Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C0769447
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGaLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGaLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE491BF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C2C6100C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A632AC433C7;
        Mon, 31 Jul 2023 11:11:42 +0000 (UTC)
Date:   Mon, 31 Jul 2023 12:11:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: tlb: set huge page size to stride for hugepage
Message-ID: <ZMeW5jcsYgisxsoJ@arm.com>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074829.79309-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:48:29PM +0800, Kefeng Wang wrote:
> +/*
> + * We cannot use leaf-only invalidation here, since we may be invalidating
> + * table entries as part of collapsing hugepages or moving page tables.
> + * Set the tlb_level to 0 because we can not get enough information here.
> + */
> +#define flush_tlb_range(vma, start, end)				\
> +	__flush_tlb_range(vma, start, end,				\
> +				((vma)->vm_flags & VM_HUGETLB)		\
> +				? huge_page_size(hstate_vma(vma))	\
> +				: PAGE_SIZE, false, 0)

This won't work if we use the contiguous PTE to get 64K hugetlb pages on
a 4K base page configuration. The 16 base pages in the range would have
to be invalidated individually (the contig PTE bit is just a hint, the
hardware may or may not take it into account).

-- 
Catalin
