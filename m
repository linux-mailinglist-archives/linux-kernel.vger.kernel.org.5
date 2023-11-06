Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF37E2BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjKFS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjKFS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EDC173A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:26:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C262C433C7;
        Mon,  6 Nov 2023 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699295196;
        bh=VzcmarRj5xg87q6eM78zA0Xh095fv6u/JvD6rbia9pk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pwaKx8X1ahf/f+kUWCkPOV0SH985FU13FHH0XDHIhcibepRoAQglwQ+AingOuHCt+
         hexL80g9HbmCscfsbE9u/hmukg1wVvvFNNxoGr1EG/sc2a+CvnE3x1Cr684W/7AMt0
         h97vxN4soL/QFx4qs1xSAhkzh2f5VB2n6TYMKW0A=
Date:   Mon, 6 Nov 2023 10:26:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Fix for negative counter: nr_file_hugepages
Message-Id: <20231106102635.55bdf0cd99baad5c1fc8617a@linux-foundation.org>
In-Reply-To: <20231106181918.1091043-1-shr@devkernel.io>
References: <20231106181918.1091043-1-shr@devkernel.io>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Nov 2023 10:19:18 -0800 Stefan Roesch <shr@devkernel.io> wrote:

> While qualifiying the 6.4 release, the following warning was detected in
> messages:
> 
> vmstat_refresh: nr_file_hugepages -15664
> 
> The warning is caused by the incorrect updating of the NR_FILE_THPS
> counter in the function split_huge_page_to_list. The if case is checking
> for folio_test_swapbacked, but the else case is missing the check for
> folio_test_pmd_mappable. The other functions that manipulate the counter
> like __filemap_add_folio and filemap_unaccount_folio have the
> corresponding check.
> 
> I have a test case, which reproduces the problem. It can be found here:
>   https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c
> 
> The test case reproduces on an XFS filesystem. Running the same test
> case on a BTRFS filesystem does not reproduce the problem.
> 
> AFAIK version 6.1 until 6.6 are affected by this problem.

I'm thinking a cc:stable is justified.

> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2740,7 +2740,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  			if (folio_test_swapbacked(folio)) {
>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>  							-nr);
> -			} else {
> +			} else if (folio_test_pmd_mappable(folio)) {
> +
>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>  							-nr);
>  				filemap_nr_thps_dec(mapping);
> 

I expect this will backport OK until it hits 3e9a13daa ("huge_memory:
convert split_huge_page_to_list() to use a folio") at which point the
-stable maintainers might request a reworked version.

