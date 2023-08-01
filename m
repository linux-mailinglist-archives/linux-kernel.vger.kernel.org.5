Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053776B2D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjHALO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjHALOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243ED49F5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:09:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1D16150F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20930C433C8;
        Tue,  1 Aug 2023 11:09:49 +0000 (UTC)
Date:   Tue, 1 Aug 2023 12:09:47 +0100
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
Subject: Re: [PATCH v2 2/2] arm64: hugetlb: enable
 __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
Message-ID: <ZMjn+68gKrdQSjMD@arm.com>
References: <20230801023145.17026-1-wangkefeng.wang@huawei.com>
 <20230801023145.17026-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801023145.17026-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:31:45AM +0800, Kefeng Wang wrote:
> +#define __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
> +static inline void flush_hugetlb_tlb_range(struct vm_area_struct *vma,
> +					   unsigned long start,
> +					   unsigned long end)
> +{
> +	unsigned long stride = huge_page_size(hstate_vma(vma));
> +
> +	if (stride != PMD_SIZE && stride != PUD_SIZE)
> +		stride = PAGE_SIZE;
> +	__flush_tlb_range(vma, start, end, stride, false, 0);

We could use some hints here for the tlb_level (2 for pmd, 1 for pud).
Regarding the last_level argument to __flush_tlb_range(), I think it
needs to stay false since this function is also called on the
hugetlb_unshare_pmds() path where the pud is cleared and needs
invalidating.

That said, maybe you can rewrite it as a switch statement and call
flush_pmd_tlb_range() or flush_pud_tlb_range() (just make sure these are
defined when CONFIG_HUGETLBFS is enabled).

-- 
Catalin
