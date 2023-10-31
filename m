Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77D7DC4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjJaDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjJaDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:47:10 -0400
X-Greylist: delayed 30107 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 20:47:07 PDT
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EEAE6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:47:07 -0700 (PDT)
Received: by gentwo.org (Postfix, from userid 1003)
        id CC31648CA2; Mon, 30 Oct 2023 20:47:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id CABB3489FB;
        Mon, 30 Oct 2023 20:47:06 -0700 (PDT)
Date:   Mon, 30 Oct 2023 20:47:06 -0700 (PDT)
From:   Christoph Lameter <cl@linux.com>
To:     Chengming Zhou <chengming.zhou@linux.dev>
cc:     vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
In-Reply-To: <1dcc9969-da5b-4384-96d8-d03c835f198e@linux.dev>
Message-ID: <edd0197b-7a79-9cb5-8ac5-5d202c2ed51b@linux.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev> <d5e40e42-ad02-e53d-c38f-09a4fdf1be88@linux.com> <1199315b-63ce-4be4-8cde-b8b2fd29f91a@linux.dev> <7f70d130-c05a-3cb7-9509-41c21c3014fb@linux.com>
 <1dcc9969-da5b-4384-96d8-d03c835f198e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Chengming Zhou wrote:

> The current scheme (which this series implemented) is:
>
> - node partial slabs: PG_Workingset (set or clear with per-node list_lock protection)
> - cpu partial slabs: !PG_Workingset

And then the frozen flag needs to be set. Otherwise slab_free() would 
conclude it is on a partial list?

> - cpu slabs: !PG_Workingset && frozen (set or clear using cmpxchg together with freelist)



> - full slabs: !PG_Workingset

And frozen is clear? Otherwise it is the same as a cpu partial slab.

> As Vlastimil noted, it's possible to drop "frozen" bit for cpu slabs, but
> we keep it for performance, since we don't need to grab node list_lock to
> check whether PG_Workingset is set or not if the "frozen" bit is set.
>
> Thanks!
>
