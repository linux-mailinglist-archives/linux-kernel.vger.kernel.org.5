Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C197A96C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIURHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjIURHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:07:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B370149FC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A24176A;
        Thu, 21 Sep 2023 09:26:23 -0700 (PDT)
Received: from [10.1.34.154] (XHFQ2J9959.cambridge.arm.com [10.1.34.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408773F59C;
        Thu, 21 Sep 2023 09:25:45 -0700 (PDT)
Message-ID: <7aee2aeb-acb2-4fe3-90b5-3dd43ee855c2@arm.com>
Date:   Thu, 21 Sep 2023 17:25:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-GB
To:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2022 15:57, Qi Zheng wrote:
> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
> helper") add set_huge_swap_pte_at() to handle swap entries on
> architectures that support hugepages consisting of contiguous ptes.
> And currently the set_huge_swap_pte_at() is only overridden by arm64.
> 
> The set_huge_swap_pte_at() provide a sz parameter to help determine
> the number of entries to be updated. But in fact, all hugetlb swap
> entries contain pfn information, so we can find the corresponding
> folio through the pfn recorded in the swap entry, then the folio_size()
> is the number of entries that need to be updated.
> 
> And considering that users will easily cause bugs by ignoring the
> difference between set_huge_swap_pte_at() and set_huge_pte_at().
> Let's handle swap entries in set_huge_pte_at() and remove the
> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
> anywhere, which simplifies our coding.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Hi,

FYI, I discovered a bug in v6.6-rc1 that causes a kernel panic, which I believe
is caused by this change. I've posted a fix along with a detailed explanation at
[1].

[1]
https://lore.kernel.org/linux-arm-kernel/20230921162007.1630149-1-ryan.roberts@arm.com/

Thanks,
Ryan

