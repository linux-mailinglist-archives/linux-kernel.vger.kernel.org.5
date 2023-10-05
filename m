Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA337B9E03
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjJEN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241223AbjJENy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:54:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C740261AB;
        Thu,  5 Oct 2023 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UsVE557PzrNyYPiLJjrpDiv6e1odj4+yvG6YntgxdCg=; b=ob2iAc3pk+z+RLvlwJM5ZEIvGo
        1xjlUmYsHVt79MNTw4fGTMR0RYJ9EwHjkC8TchD6JndeNF9j7AL1U3YCLbp1cCTTPnSxL+D9XEjOz
        T2sXoNyUQjP4sXh2lkD/iqCFjHrfBqeIGpf9fdLQhjmwQX1ZzGnhB+C1SlebzOsIODjoZBD5Y0Cah
        oi6qGj3u6Dkn9AZ9iOkLgfcFEtKORAT1NAnzJlwUfCVQQZyqSAUE8tQTBRAJqj9Ts0hBfCxNPz35E
        FGLRIWC3XppZ0LoiouEOuc4j5NIaBhHZzY7aFkvgE/YWal0MMIJfbB3fG4pIIBrDnIuE6RkpeSBy0
        4gZf7Lfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoNKS-009IID-A4; Thu, 05 Oct 2023 12:19:44 +0000
Date:   Thu, 5 Oct 2023 13:19:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Regressions <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        Maxime Ripard <mripard@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [REGRESSION] BUG: KFENCE: memory corruption in
 drm_gem_put_pages+0x186/0x250
Message-ID: <ZR6p4MpDbQpZiUSZ@casper.infradead.org>
References: <13360591.uLZWGnKmhe@natalenko.name>
 <2160215.irdbgypaU6@natalenko.name>
 <fed1cbf3-0926-4895-a8ba-d6fa9fd53dbe@suse.de>
 <3254850.aeNJFYEL58@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3254850.aeNJFYEL58@natalenko.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:56:03AM +0200, Oleksandr Natalenko wrote:
> Hello.
> 
> On čtvrtek 5. října 2023 9:44:42 CEST Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 02.10.23 um 17:38 schrieb Oleksandr Natalenko:
> > > On pondělí 2. října 2023 16:32:45 CEST Matthew Wilcox wrote:
> > >> On Mon, Oct 02, 2023 at 01:02:52PM +0200, Oleksandr Natalenko wrote:
> > >>>>>>> BUG: KFENCE: memory corruption in drm_gem_put_pages+0x186/0x250
> > >>>>>>>
> > >>>>>>> Corrupted memory at 0x00000000e173a294 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ] (in kfence-#108):
> > >>>>>>>   drm_gem_put_pages+0x186/0x250
> > >>>>>>>   drm_gem_shmem_put_pages_locked+0x43/0xc0
> > >>>>>>>   drm_gem_shmem_object_vunmap+0x83/0xe0
> > >>>>>>>   drm_gem_vunmap_unlocked+0x46/0xb0
> > >>>>>>>   drm_fbdev_generic_helper_fb_dirty+0x1dc/0x310
> > >>>>>>>   drm_fb_helper_damage_work+0x96/0x170
> > >>>
> > >>> Matthew, before I start dancing around, do you think ^^ could have the same cause as 0b62af28f249b9c4036a05acfb053058dc02e2e2 which got fixed by 863a8eb3f27098b42772f668e3977ff4cae10b04?
> > >>
> > >> Yes, entirely plausible.  I think you have two useful points to look at
> > >> before delving into a full bisect -- 863a8e and the parent of 0b62af.
> > >> If either of them work, I think you have no more work to do.
> > > 
> > > OK, I've did this against v6.5.5:
> > > 
> > > ```
> > > git log --oneline HEAD~3..
> > > 7c1e7695ca9b8 (HEAD -> test) Revert "mm: remove struct pagevec"
> > > 8f2ad53b6eac6 Revert "mm: remove check_move_unevictable_pages()"
> > > fa1e3c0b5453c Revert "drm: convert drm_gem_put_pages() to use a folio_batch"
> > > ```
> > > 
> > > then rebooted the host multiple times, and the issue is not seen any more.
> > > 
> > > So I guess 3291e09a463870610b8227f32b16b19a587edf33 is the culprit.
> > 
> > Ignore my other email. It's apparently been fixed already. Thanks!
> 
> Has it? I think I was able to identify offending commit, but I'm not aware of any fix to that.

I don't understand; you said reverting those DRM commits fixed the
problem, so 863a8eb3f270 is the solution.  No?

