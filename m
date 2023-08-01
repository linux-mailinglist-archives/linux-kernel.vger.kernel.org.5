Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918CB76B895
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjHAP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjHAP2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E4193
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EB88615DE
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D81CC433C8;
        Tue,  1 Aug 2023 15:28:36 +0000 (UTC)
Date:   Tue, 1 Aug 2023 16:28:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        21cnbao@gmail.com
Subject: Re: [PATCH v3] arm64: hugetlb: enable
 __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
Message-ID: <ZMkkoVl+q4Iljoy1@arm.com>
References: <20230801023145.17026-3-wangkefeng.wang@huawei.com>
 <20230801135616.165067-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801135616.165067-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:56:16PM +0800, Kefeng Wang wrote:
> +#define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
> +static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
> +					   unsigned long start,
> +					   unsigned long end)
> +{
> +	unsigned long stride = huge_page_size(hstate_vma(vma));
> +
> +	switch (stride) {
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	case PUD_SIZE:
> +		flush_pud_tlb_range(vma, start, end);
> +		break;
> +#endif
> +	case PMD_SIZE:
> +		flush_pmd_tlb_range(vma, start, end);
> +		break;
> +	default:
> +		__flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
> +	}
> +}

I think we should be consistent and either use __flush_tlb_range()
everywhere or flush_p*d_tlb_range() together with flush_tlb_range().
Maybe using __flush_tlb_range() for the pmd/pud is not too bad, smaller
patch.

That said, I'd avoid the #ifndef and just go for an if/else statement:

	if (stride == PMD_SIZE)
		__flush_tlb_range(vma, start, end, stride, false, 2);
	else if (stride == PUD_SIZE)
		__flush_tlb_range(vma, start, end, stride, false, 1);
	else
		__flush_tlb_range(vma, start, end, PAGE_SIZE, 0);

With the pmd folded, the P*D_SIZE is the same and the compiler should
eliminate the second branch.

-- 
Catalin
