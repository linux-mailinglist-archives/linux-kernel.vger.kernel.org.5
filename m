Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651480D814
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345367AbjLKSmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbjLKSmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:42:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC0FB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:42:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232D0C433C7;
        Mon, 11 Dec 2023 18:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702320162;
        bh=La1SkaK7aEdY1LxNkNO5JyzTxPGR7qbV9MxCEFKaG3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0fbAglu5jBzJzxh07T39fVM/s7FoQQSuOhDZqlRkIy91TQy6IekTeoIlifpvVwhU
         PN264G8HQGPp9TJP7Q5MnF3aAIS7+3ikvtayafsup1uH7XFTvI6QOQl8gSes/6/YF9
         nmyUZCZb9nmtc9v0yaf4T1nkJpx0SQu4WCXqivdjTbkj+/islL16+lokwCbggKM8I/
         U9BbayDdfuz+VHhDGDk2HIW7kqOBhhswSowciT5cLlC2E88xWqonx9Qdseyo7+ObiE
         bSa1NcTqx/+TNV1EGySODFGcKNk1ysriAJAjSjIL2tMSi/b4Pw230zFkjYBxosUiWe
         UiRxINs+8/2XA==
Date:   Mon, 11 Dec 2023 18:42:36 +0000
From:   Will Deacon <will@kernel.org>
To:     James Houghton <jthoughton@google.com>
Cc:     Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: mm: Always make sw-dirty PTEs hw-dirty in
 pte_modify
Message-ID: <20231211184236.GB26462@willie-the-truck>
References: <20231204172646.2541916-1-jthoughton@google.com>
 <20231204172646.2541916-3-jthoughton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204172646.2541916-3-jthoughton@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:26:46PM +0000, James Houghton wrote:
> Make it impossible to create a sw-dirty, hw-clean PTE with pte_modify.
> Such a PTE should be impossible to create, and there may be places that
> assume that pte_dirty() implies pte_hw_dirty().
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

I'm not sure how, but you seem to be missing the '---' separator and the
diffstat here, so I suspect this might confuse tools such as b4 which try
to apply the patch directly.

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b19a8aee684c..79ce70fbb751 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -834,6 +834,12 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
>  
>  	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
> +	/*
> +	 * If we end up clearing hw dirtiness for a sw-dirty PTE, set hardware
> +	 * dirtiness again.
> +	 */
> +	if (pte_sw_dirty(pte))
> +		pte = pte_mkdirty(pte);
>  	return pte;

Looks like this is a fix for Catalin to pick up (patch #1 isn't necessary
afaict).

Will
