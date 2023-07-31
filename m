Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C576942C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGaLFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGaLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E3A1AC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 476DC6100F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA7EC433C8;
        Mon, 31 Jul 2023 11:05:29 +0000 (UTC)
Date:   Mon, 31 Jul 2023 12:05:25 +0100
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
Subject: Re: [PATCH 2/4] mm: mremap: use flush_pmd_tlb_range() in
 move_normal_pmd()
Message-ID: <ZMeVdcNcp76L8bOG@arm.com>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731074829.79309-3-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:48:27PM +0800, Kefeng Wang wrote:
> Archs may need to do special things when flushing thp tlb,
> so use the more applicable flush_pud_tlb_range() instead of
> flush_tlb_range().
> 
> Fixes: 2c91bd4a4e2e ("mm: speed up mremap by 20x on large regions")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 11e06e4ab33b..1883205fa22b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -284,7 +284,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  	VM_BUG_ON(!pmd_none(*new_pmd));
>  
>  	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
> -	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
> +	flush_pmd_tlb_range(vma, old_addr, old_addr + PMD_SIZE);

I don't think that's correct for arm64. The assumption in the
flush_p*d_tlb_range() was that they are called only for block mappings
at that p*d level (and we use FEAT_TTL on arm64 indicating that the leaf
level is level 2 for pmd, 1 for pud). IIUC move_normal_pmd() is only
called for table pmds which would have a leaf level of 3 (the pte).

Same for the next patch doing the equivalent for the pud.

-- 
Catalin
