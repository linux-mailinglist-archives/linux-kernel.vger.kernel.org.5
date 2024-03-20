Return-Path: <linux-kernel+bounces-108413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E383880A34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4835A1C21651
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF411C83;
	Wed, 20 Mar 2024 03:46:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0E1170B;
	Wed, 20 Mar 2024 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710906398; cv=none; b=EYg5TRgNBsnZ690qZBHfAoBuTDepkiCLIkFVALhThFDHMOgUK/FR0VEWZdDwwjyb+j8ar43/2n+EToZ2AgFhubwVVdaMQ3TB7YAmDaiYm9uqM3mwSh48Xlamn6DT9Kzrhwan+e5kwKIMAEIXjIGhx9rV5x3s65AT6ul2qjoOQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710906398; c=relaxed/simple;
	bh=l+mqYCBgZTwxi4ErekRH/lhS4Fi+295tQE8tgGy3YAM=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jZBGwwYDsGx1oFRAB9uQhq8Vm0h0A3SRTdZvFLqCO1us0cYkOyDWtpeXuSS8szE7tXXGEwJMfCvTHvDDChnxnnoaPKG+8RnFYD04KAoKihFYU2FSi085ArIIRa4QnfTBu0dlQNBtHXy7TbRmFZNiFdIjZ4Sr/yO2WjjvS8+zqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzvdY0Kfqz1HBvb;
	Wed, 20 Mar 2024 11:46:09 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 0341F1A0172;
	Wed, 20 Mar 2024 11:46:32 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 20 Mar
 2024 11:46:31 +0800
Subject: Re: [PATCH] ARM: unwind: improve unwinders for noreturn case
To: Matthew Wilcox <willy@infradead.org>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>
 <202403191945.661DBCE8@keescook>
 <fb8c6e8f-de47-8cbc-e30a-60961f5ce7ad@huawei.com>
 <ZfpZLJ3F3efXUwQf@casper.infradead.org>
CC: Kees Cook <keescook@chromium.org>, <linux@armlinux.org.uk>,
	<arnd@arndb.de>, <rmk+kernel@armlinux.org.uk>, <haibo.li@mediatek.com>,
	<angelogioacchino.delregno@collabora.com>, <amergnat@baylibre.com>,
	<akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<douzhaolei@huawei.com>, <gustavoars@kernel.org>, <jpoimboe@kernel.org>,
	<kepler.chenxin@huawei.com>, <kirill.shutemov@linux.intel.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
	<nixiaoming@huawei.com>, <peterz@infradead.org>, <wangbing6@huawei.com>,
	<wangfangpeng1@huawei.com>, <jannh@google.com>, <David.Laight@aculab.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <98468785-ed75-f812-7263-1adf677f00d2@huawei.com>
Date: Wed, 20 Mar 2024 11:46:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZfpZLJ3F3efXUwQf@casper.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/20 11:34, Matthew Wilcox wrote:
> On Wed, Mar 20, 2024 at 11:30:13AM +0800, Jiangfeng Xiao wrote:
>> The checkpatch.pl script reports the "WARNING: printk() should
>> include KERN_<LEVEL> facility level" warning.
>>
>> That's why I changed printk to pr_warn.
>> I should change printk to printk(KERN_DEFAULT).
> 
> No, you should ignore checkpatch.  For bonus points, figure out why you
> should ignore it specifically in this case.
> .
> 

Thank you. I think I understand.

The checkpatch.pl file is a false report
because the 'loglvl' already exists.

I'd better keep printk(" %s...", loglvl, ...) still.

