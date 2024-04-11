Return-Path: <linux-kernel+bounces-139652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07A8A05D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5651F24E85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614B64A9F;
	Thu, 11 Apr 2024 02:26:50 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1163417
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802409; cv=none; b=W9Zv5/fy1jVdhB9OTE01GBpsenCdZpJjBBcVe8cDXOEWM2Uoklngu6Hsb2W2GZpYNt1T8li1bpdj5MkeIwhhguN62s3sEV643EBTuI+Afkyb0KdcgU0urrOmaMHj/2Yzb9xZXsB4wDXKVgSV7CxTaDELxNFxXp/M9h+Ythaya50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802409; c=relaxed/simple;
	bh=8vXXG+d8ZnqIckkv5izWLMGEUrINe2wkChJeqUn5G2k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PWHBg82h1lm36yG9WfEMNNlp1bs6LHnVlau7JPlbC5soCzxyk3l7MwL5c1meKJRZaVZnttBONQ1ZvVC8JV+J3C9L3ngK+f4clLj69P7YrvLQ3rC6OWr7PjmcjEtZD2Lr2ZqCv3DNq/E+l9Wv2TjCsaKHJX+fjDSlJNXO90KUlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFNn84QNyz1ymsY;
	Thu, 11 Apr 2024 10:24:28 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 082B21A0172;
	Thu, 11 Apr 2024 10:26:45 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:26:44 +0800
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Oscar Salvador <osalvador@suse.de>
CC: <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
 <ZhVMThr9TNeP6SWj@localhost.localdomain>
 <ZhVoatdJZ1RWu2r3@localhost.localdomain>
 <13aa38af-46a1-3894-32bd-c3eb6ef67359@huawei.com>
 <ZhZTZtzyMpMMowoD@localhost.localdomain>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <247259aa-9c78-d1ae-c829-aa72adc75922@huawei.com>
Date: Thu, 11 Apr 2024 10:26:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZhZTZtzyMpMMowoD@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/10 16:52, Oscar Salvador wrote:
> On Wed, Apr 10, 2024 at 03:52:14PM +0800, Miaohe Lin wrote:
>> AFAICS, iff check_pages_enabled static key is enabled and in hard offline mode,
>> check_new_pages() will prevent those pages from ending up in a PCP queue again
>> when refilling PCP list. Because PageHWPoison pages will be taken as 'bad' pages
>> and skipped when refill PCP list.
> 
> Yes, but check_pages_enabled static key is only enabled when
> either CONFIG_DEBUG_PAGEALLOC or CONFIG_DEBUG_VM are set, which means
> that under most of the systems that protection will not take place.
> 
> Which takes me to a problem we had in the past where we were handing
> over hwpoisoned pages from PCP lists happily.
> Now, with for soft-offline mode, we worked hard to stop doing that
> because soft-offline is a non-disruptive operation and no one should get 
> killed.
> hard-offline is another story, but still I think that extending the
> comment to include the following would be a good idea:
> 
> "Disabling pcp before dissolving the page was a deterministic approach
>  because we made sure that those pages cannot end up in any PCP list.
>  Draining PCP lists expels those pages to the buddy system, but nothing
>  guarantees that those pages do not get back to a PCP queue if we need
>  to refill those."

This really helps. Will add it in v2.
Thanks Oscar.

> 
>  Just to remind ourselves of the dangers of a non-deterministic
>  approach.
> 
> 
> Thanks
> 
> 


