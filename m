Return-Path: <linux-kernel+bounces-161223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602F8B4935
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 04:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85A4B211B1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 02:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65910FA;
	Sun, 28 Apr 2024 02:25:00 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46390EC3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714271099; cv=none; b=eZmxI/7IiuuqjvEzEDbqCZc8BA8x3L1lB60M17NL0O29UDyqoKzD0yNhRGqF7ZqLbX0jFD3W0FSI9UJjJsdb0cU5WftAO3bivi+oGTy/vuGASFK2S4Bj0m+cF5/zz7Vg35iq/yS3VVbN1Ri208mb8oTSJhO3nE0/q9RMEofmBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714271099; c=relaxed/simple;
	bh=qgDNso/QLmtFHaMGuIWeebX7Mu5rFMWi21QdjM2z4Oc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ENYOAKBgImdKDJrZzqrV/k3vZKLLIpe+mDW/annQFLr/cqlHUP5YLfAOx1HLkr/Wz0MhBjTjV61hbFFYlOD2WhfQI+2P5a4pur7KSMKcBg3A+bLFIhsOlwbpAOY/brXMYeS736NY7+EvfSV8U0VY3qBC/Fz/4SlIyL58qF0XUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VRqw34lxTz1RDMh;
	Sun, 28 Apr 2024 10:21:39 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 70ECA180045;
	Sun, 28 Apr 2024 10:24:47 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Apr 2024 10:24:46 +0800
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
To: Jane Chu <jane.chu@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <nao.horiguchi@gmail.com>, <osalvador@suse.de>,
	Matthew Wilcox <willy@infradead.org>, Sidhartha Kumar
	<sidhartha.kumar@oracle.com>
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
 <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
 <ZivyC3vqa2BIBoMj@casper.infradead.org>
 <c40cfd0b-f045-4887-a955-fee7e0392cf1@oracle.com>
 <Ziv67sGBi02YCYZ5@casper.infradead.org>
 <47614f5d-0942-4b2c-a51a-451f6bc9c802@oracle.com>
 <d19e1033-285f-474b-af1f-ae4c32e32e21@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6048a36d-6bb2-2e74-1d20-228f0486d965@huawei.com>
Date: Sun, 28 Apr 2024 10:24:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d19e1033-285f-474b-af1f-ae4c32e32e21@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/27 4:33, Jane Chu wrote:
> My apology for the gobbled message earlier.
> 
> On 4/26/2024 12:52 PM, Jane Chu wrote:
>> On 4/26/2024 12:05 PM, Matthew Wilcox wrote:
>> [..]
>>> That would be unsafe, the safe way would be if we moved page_folio() after
>>>> the call to __get_hw_poison() in get_any_page() and there would still be one
>>>> remaining user of shake_page() that we can't convert. A safe version of this
>>>> patch would result in a removal of one use of PageHuge() and two uses of
>>>> put_page(), would that be worth submitting?
>>>>
>>>> get_any_page()
>>>>     if(__get_hwpoison_page())
>>>>         folio = page_folio() /* folio_try_get() returned 1, safe */
>>> I think we should convert __get_hwpoison_page() to return either the folio
>>> or an ERR_PTR or NULL.  Also, I think we should delete the "cannot catch
>>> tail" part and just loop in __get_hwpoison_page() until we do catch it.
>>> See try_get_folio() in mm/gup.c for inspiration (although you can't use
>>> it exactly because that code knows that the page is mapped into a page
>>> table, so has a refcount).
>>>
>>> But that's just an immediate assessment; you might find a reason that
>>> doesn't work.
>>
> Besides, in a possible hugetlb demote scenario, it seems to me that we should retry
> get_hwpoison_hugetlb_folio() instead of falling thru to folio_try_get().
> 
> static int __get_hwpoison_page(struct page *page, unsigned long flags)
> {
>         struct folio *folio = page_folio(page);
>         int ret = 0;
>         bool hugetlb = false;
> 
>         ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
>         if (hugetlb) {
>                 /* Make sure hugetlb demotion did not happen from under us. */
>                 if (folio == page_folio(page))
>                         return ret;
>                 if (ret > 0) {      <===== still hugetlb, don't fall thru, retry

I tend to agree we should retry get_hwpoison_hugetlb_folio() because folio is still hugetlb in this case.
Below folio_try_get() won't do the right things. This is on my TODO list but as you mentioned this, please
feel free to submit the corresponding patch.
Thanks.
.

