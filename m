Return-Path: <linux-kernel+bounces-77663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D872186089A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167801C230AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40405BA30;
	Fri, 23 Feb 2024 01:57:36 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1B2F3A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653455; cv=none; b=ia83MbI2UdVX13mYdqmtyJIqA39fMpfOuDayAgbG12dEtbd6hhW6hlDHQQyiIP3SBbOd1fRtLgRmrOL0Uzg/28ECtcsBuVZLuOrreMDCa7pKsJE5ccT4OIglDqEQOkNqU5+0O/9YSdIdQuTzV5WnJvLdtshSMcoVksmR4Rl61jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653455; c=relaxed/simple;
	bh=LjEijvE2jTF8EqZALMOAkjsf18Eu+9FEUVVEXfCmV2A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dllKMX7yoS4ZM4d7k6thtAYJqTkYwUwTP804zTAk1Ys0c99cCqV8bHnsCm0S/O3vMAlw5RDvPHB3Bso3+YUS+awIbPsM/DUH9OOthhbYNxMPFydWr3tvd1nMdBERhmkxXx71wlRHJcZljdTOPvnXy0bPD9WsicLohjqPrSpVXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TgtRW1bmjz1vv81;
	Fri, 23 Feb 2024 09:56:55 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D22218001B;
	Fri, 23 Feb 2024 09:57:30 +0800 (CST)
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 09:57:29 +0800
Subject: Re: [PATCH] arm: flush: check if the folio is reserved for IMO
 addresses
To: Matthew Wilcox <willy@infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <yanaijie@huawei.com>,
	<zhangxiaoxu5@huawei.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
	<linux-kernel@vger.kernel.org>, <keescook@chromium.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>
References: <20240222140147.1880357-1-liuyongqiang13@huawei.com>
 <ZddUrO7i5KZn57FY@casper.infradead.org>
From: Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <16b0b45c-721b-2e61-65cf-306b160d713d@huawei.com>
Date: Fri, 23 Feb 2024 09:57:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZddUrO7i5KZn57FY@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500005.china.huawei.com (7.185.36.59)


ÔÚ 2024/2/22 22:05, Matthew Wilcox Ð´µÀ:
> On Thu, Feb 22, 2024 at 10:01:47PM +0800, Yongqiang Liu wrote:
>> @@ -296,6 +297,9 @@ void __sync_icache_dcache(pte_t pteval)
>>   		return;
>>   
>>   	folio = page_folio(pfn_to_page(pfn));
>> +	if (test_bit(PG_reserved, &folio->flags))
>> +		return;
> Why are you using PG_foo directly instead of the helpers?
>
> 	if (folio_test_reserved(folio))
> .
Sorry, I will send v2.

