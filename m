Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0883A799F83
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjIJTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIJTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:33:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32897103
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95968C433C8;
        Sun, 10 Sep 2023 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1694374416;
        bh=dX0snYQ5v39lGdN7KQzd0K/UxL2B6SP53/xbYKcI+vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zwp9u4iwtP+uZQXd8KqiTBRa/KExQmJiUWwkKdTXrGjw86L8c1YclTnm4bPIiJaza
         efWGAZILsxJ3sB/vxNfnRZ+H41OKG5q6zxVwBW4qJ1kK0p5+CUOfzIw1sC8DGZbMQf
         /yIRO9OhC1UgORONb9mWgQqVd1ULSKQRoWatgu1E=
Date:   Sun, 10 Sep 2023 12:33:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     brauner@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org
Subject: Re: [PATCH 1/1] mm/madvise: add cond_resched() in
 madvise_cold_or_pageout_pte_range()
Message-Id: <20230910123335.36ebf58e46628eeffef612c3@linux-foundation.org>
In-Reply-To: <95d610623363009a71024c7a473d6895f39f3caf.1694219361.git.wangjiexun@tinylab.org>
References: <cover.1694219361.git.wangjiexun@tinylab.org>
        <95d610623363009a71024c7a473d6895f39f3caf.1694219361.git.wangjiexun@tinylab.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Sep 2023 13:33:08 +0800 Jiexun Wang <wangjiexun@tinylab.org> wrote:

> Currently the madvise_cold_or_pageout_pte_range() function exhibits 
> significant latency under memory pressure, which can be effectively 
> reduced by adding cond_resched() within the loop.
> 
> When the batch_count reaches SWAP_CLUSTER_MAX, we reschedule 
> the task to ensure fairness and avoid long lock holding times.
> 
> ...
>
> @@ -441,6 +443,13 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	arch_enter_lazy_mmu_mode();
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = ptep_get(pte);
> +		
> +		if (++batch_count == SWAP_CLUSTER_MAX) {
> +			pte_unmap_unlock(start_pte, ptl);
> +		 	cond_resched();
> +		 	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +		 	batch_count = 0;
> +		}
>  
>  		if (pte_none(ptent))
>  			continue;

I doubt if we can simply drop the lock like this then proceed as if
nothing has changed while the lock was released.

Could be that something along these lines:

@@ -434,6 +436,7 @@ huge_unlock:
 regular_folio:
 #endif
 	tlb_change_page_size(tlb, PAGE_SIZE);
+restart:
 	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (!start_pte)
 		return 0;
@@ -441,6 +444,15 @@ regular_folio:
 	arch_enter_lazy_mmu_mode();
 	for (; addr < end; pte++, addr += PAGE_SIZE) {
 		ptent = ptep_get(pte);
+		
+		if (++batch_count == SWAP_CLUSTER_MAX) {
+			batch_count = 0;
+			if (need_resched()) {
+				pte_unmap_unlock(start_pte, ptl);
+				cond_resched();
+				goto restart;
+			}
+		}
 
 		if (pte_none(ptent))
 			continue;

would work, but more analysis would be needed.

