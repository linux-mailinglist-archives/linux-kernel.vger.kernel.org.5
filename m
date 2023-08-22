Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EABB78470B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjHVQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbjHVQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910BF137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E099627CC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517BEC433C7;
        Tue, 22 Aug 2023 16:24:21 +0000 (UTC)
Date:   Tue, 22 Aug 2023 17:24:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
Message-ID: <ZOThMse/o7WtOkOH@arm.com>
References: <20230821160849.531668-1-david@redhat.com>
 <20230821160849.531668-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821160849.531668-2-david@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 06:08:46PM +0200, David Hildenbrand wrote:
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index cd508ba80ab1..a31833e3ddc5 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -33,8 +33,9 @@ int mte_save_tags(struct page *page)
>  
>  	mte_save_page_tags(page_address(page), tag_storage);
>  
> -	/* page_private contains the swap entry.val set in do_swap_page */
> -	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
> +	/* lookup the swap entry.val from the page */
> +	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
> +		       GFP_KERNEL);
>  	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
>  		mte_free_tag_storage(tag_storage);
>  		return xa_err(ret);

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
