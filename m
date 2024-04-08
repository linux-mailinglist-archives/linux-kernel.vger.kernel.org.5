Return-Path: <linux-kernel+bounces-135045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C554A89BA5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FB92897CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FA3A1CF;
	Mon,  8 Apr 2024 08:32:04 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086A39FFB;
	Mon,  8 Apr 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565124; cv=none; b=MvCN9Qi527H580GkGXX9cK3Tu5Z+IZtXlIukRbymHiNFP5s0KsRgYcAdzYNxAZrUrf9Mr2pMaSYc2jrX3uA4++4B+xXjmO/GNYeP52YmzbYW/xLbPcpQUVhbYr8gZsb4Sggn2dNalfPJVj+i0XYnXk2zetYI8xjjGrqBzmYM3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565124; c=relaxed/simple;
	bh=uAmL+spAxj/+wCS8qccqTLgGxz6q90iFWSXXWlUjztM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BueAgU+vR9anFMhaPUx0UknRSNq9/RBtbrdRVRjVtiL7B1TRPcQ90yoMYBFzTtfFitIvTkBM5GGQ0MgLCEt+JIQb4Nr9W5clpKhprjO26OYEvwJptqEdfLEmIucICqnotzkdSkVjVL4X0/3tJ0ycfNjle5/T2+/pa3Ya5ArOOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VCj3Y0W4Cz21kdL;
	Mon,  8 Apr 2024 16:31:05 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 95CA918002D;
	Mon,  8 Apr 2024 16:31:59 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 16:31:59 +0800
Subject: Re: [PATCH] mm,swapops: Update check in is_pfn_swap_entry for
 hwpoison entries
To: Oscar Salvador <osalvador@suse.de>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, David Hildenbrand
	<david@redhat.com>, Peter Xu <peterx@redhat.com>, <stable@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20240407130537.16977-1-osalvador@suse.de>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <fdf0a811-adfa-cc78-1c8d-203043d1691d@huawei.com>
Date: Mon, 8 Apr 2024 16:31:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407130537.16977-1-osalvador@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/7 21:05, Oscar Salvador wrote:
> Tony reported that the Machine check recovery was broken in v6.9-rc1,
> as he was hitting a VM_BUG_ON when injecting uncorrectable memory errors
> to DRAM.
> After some more digging and debugging on his side, he realized that this
> went back to v6.1, with the introduction of 'commit 0d206b5d2e0d ("mm/swap: add
> swp_offset_pfn() to fetch PFN from swap entry")'.
> That commit, among other things, introduced swp_offset_pfn(), replacing
> hwpoison_entry_to_pfn() in its favour.
> 
> The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(),
> but is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> means that we would hit the VM_BUG_ON whenever we would call
> swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM set.
> Fix this by updating the check to cover hwpoison entries as well, and update
> the comment while we are it.
> 
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> Tested-by: Tony Luck <tony.luck@intel.com>
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: <stable@vger.kernel.org> # 6.1.x
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.


