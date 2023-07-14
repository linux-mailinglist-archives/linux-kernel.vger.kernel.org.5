Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C949752FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjGND2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjGND2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:28:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0763A26B1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:28:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F39161570;
        Thu, 13 Jul 2023 20:28:57 -0700 (PDT)
Received: from [10.163.47.78] (unknown [10.163.47.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C613F67D;
        Thu, 13 Jul 2023 20:28:14 -0700 (PDT)
Message-ID: <0e685e81-ee61-a9da-1fe0-698fdc5f969a@arm.com>
Date:   Fri, 14 Jul 2023 08:58:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/huge_memory: use RMAP_NONE when calling
 page_add_anon_rmap()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230713120557.218592-1-linmiaohe@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230713120557.218592-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 17:35, Miaohe Lin wrote:
> It's more convenient and readable to use RMAP_NONE instead of false when
> calling page_add_anon_rmap(). No functional change intended.

It's not only more convenient, page_add_anon_rmap() also expects rmap_t
as the last argument.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9f3109ed7351..762be2f4244c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2255,7 +2255,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  				entry = pte_mksoft_dirty(entry);
>  			if (uffd_wp)
>  				entry = pte_mkuffd_wp(entry);
> -			page_add_anon_rmap(page + i, vma, addr, false);
> +			page_add_anon_rmap(page + i, vma, addr, RMAP_NONE);
>  		}
>  		VM_BUG_ON(!pte_none(ptep_get(pte)));
>  		set_pte_at(mm, addr, pte, entry);

After this change, no other page_add_anon_rmap() call site has non rmap_t
argument.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
