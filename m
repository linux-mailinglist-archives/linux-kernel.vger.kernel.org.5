Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097C7806BE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377431AbjLFK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377325AbjLFK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:26:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72690D40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:26:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ABAD1474;
        Wed,  6 Dec 2023 02:27:35 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996183F762;
        Wed,  6 Dec 2023 02:26:47 -0800 (PST)
Message-ID: <1ccb1e57-1aef-4797-b6d2-ab59efa488db@arm.com>
Date:   Wed, 6 Dec 2023 10:26:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mm: Always make sw-dirty PTEs hw-dirty in
 pte_modify
Content-Language: en-GB
To:     James Houghton <jthoughton@google.com>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204172646.2541916-1-jthoughton@google.com>
 <20231204172646.2541916-3-jthoughton@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231204172646.2541916-3-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 17:26, James Houghton wrote:
> Make it impossible to create a sw-dirty, hw-clean PTE with pte_modify.
> Such a PTE should be impossible to create, and there may be places that
> assume that pte_dirty() implies pte_hw_dirty().
> 
> Signed-off-by: James Houghton <jthoughton@google.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
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
>  }
>  

