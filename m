Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D695A77BDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjHNQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjHNQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:21:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2290CF1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4823621AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E82DC433C7;
        Mon, 14 Aug 2023 16:21:00 +0000 (UTC)
Date:   Mon, 14 Aug 2023 17:20:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     wang xiaolei <xiaolei.wang@windriver.com>,
        akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized
 in set_track_prepare()
Message-ID: <ZNpUal2iJZXqpMN3@arm.com>
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-3-xiaolei.wang@windriver.com>
 <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
 <79deae0c-eeef-2370-9d8a-b2746389d38c@suse.cz>
 <e401350a-1e23-dae9-97be-fe659665e22d@windriver.com>
 <dbffe403-3419-58b3-cf94-ea4119c1c00d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbffe403-3419-58b3-cf94-ea4119c1c00d@suse.cz>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:09:08AM +0200, Vlastimil Babka wrote:
> On 8/11/23 04:03, wang xiaolei wrote:
> > On 8/10/23 9:16 PM, Vlastimil Babka wrote:
> >> Looking closer, I think what you want could be achieved by kmemleak_init()
> >> setting a variable that is checked in kmemleak_initialized() instead of the
> >> kmemleak_initialized that's set too late.
> >>
> >> I think this should work because:
> >> - I assume kmemleak can't record anything before kmemleak_init()
> >> - stack depot early init is requested one way or the other
> >> - mm_core_init() calls stack_depot_early_init() before kmemleak_init()
> >>
> >> But I also wonder how kmemleak can even reach set_track_prepare() before
> >> kmemleak_init(), maybe that's the issue?
> > 
> > Before kmemleak_init, many places also need to allocate kmemleak_object,
> > 
> > and also need to save stack in advance, but kmemleak_object is allocated
> > 
> > in the form of an array, after kmemleak_init 'object_cache = 
> > KMEM_CACHE(kmemleak_object, SLAB_NOLEAKTRACE);'
> 
> Hm I see, kmemleak has this static mempool so it really can record some
> objects very early.

Indeed, otherwise we'd get a lot of false positives.

> > I think there is still some memory not recorded on the backtrace before
> > 
> > stack_depot_early_init(), does anyone have a better suggestion?
> 
> No we can't record the backtrace earlier. But I don't think it's a problem
> in practice. AFAIU kmemleak needs to record these very early allocations so
> if they point to further objects, those are not suspected as orphans. But
> the early allocations themselves also are very unlikely to be leaks, so does
> it really matter that we don't have a backtrace for their allocation?
> Because the backtrace is the only thing that's missing - the object is
> otherwise recorded even if set_track_prepare() returns 0.

It's not a functional problem, just a reporting one. There are
rare early leaks (usually false positives) so identifying them would
help. That said, I think set_track_prepare() is too conservative in
waiting for kmemleak_initialized to be set in kmemleak_late_init().
That's a late_initcall() meant for the scanning thread etc. not the core
kmemleak functionality (which is on from early boot).

We can instead use a different variable to check in set_track_prepare(),
e.g. object_cache. stack_depot_early_init() is called prior to
kmemleak_init(), so it should be fine.

If "kmemleak_initialized" is confusing, we could rename it to
"kmemleak_late_initialized" or "kmemleak_fully_initialized". I'm not too
fussed about this as long as we add some comment on why we check
object_cache instead of kmemleak_initialized.

-- 
Catalin
