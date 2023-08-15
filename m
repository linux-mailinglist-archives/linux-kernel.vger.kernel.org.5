Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797077CB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjHOKk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbjHOKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C619B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A60465265
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9224C433C7;
        Tue, 15 Aug 2023 10:39:54 +0000 (UTC)
Date:   Tue, 15 Aug 2023 11:39:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, glider@google.com,
        andreyknvl@gmail.com, zhaoyang.huang@unisoc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/kmemleak: use object_cache instead of
 kmemleak_initialized to check in set_track_prepare()
Message-ID: <ZNtV+MvSSf3TM+fU@arm.com>
References: <20230815051358.802035-1-xiaolei.wang@windriver.com>
 <20230815051358.802035-2-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815051358.802035-2-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:13:57PM +0800, Xiaolei Wang wrote:
> kmemleak_initialized is set in kmemleak_late_init(), which
> also means that there is no call trace which object's memory
> leak is before kmemleak_late_init(), so use object_cache instead
> of kmemleak_initialized to check in set_track_prepare() to avoid
> no call trace records when there is a memory leak in the code
> between kmemleak_init() and kmemleak_late_init().
> 
> unreferenced object 0xc674ca80 (size 64):
>  comm "swapper/0", pid 1, jiffies 4294938337 (age 204.880s)
>  hex dump (first 32 bytes):
>   80 55 75 c6 80 54 75 c6 00 55 75 c6 80 52 75 c6 .Uu..Tu..Uu..Ru.
>   00 53 75 c6 00 00 00 00 00 00 00 00 00 00 00 00 .Su..........
> 
> Fixes: 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  mm/kmemleak.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a2d34226e3c8..04bb4cdbb402 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -610,7 +610,8 @@ static noinline depot_stack_handle_t set_track_prepare(void)
>  	unsigned long entries[MAX_TRACE];
>  	unsigned int nr_entries;
>  
> -	if (!kmemleak_initialized)
> +	/*Use object_cache to determine whether kmemleak_init() is complete*/

Nitpick: please add spaces after/before the comment delimiters. I'd also
make it clearer that it's not about kmemleak being initialised but
rather the stack depot. E.g.:

	/*
	 * Use object_cache to determine whether kmemleak_init() has
	 * been invoked. stack_depot_early_init() is called before
	 * kmemleak_init() in mm_core_init().
	 */

> +	if (!object_cache)
>  		return 0;
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>  	trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
