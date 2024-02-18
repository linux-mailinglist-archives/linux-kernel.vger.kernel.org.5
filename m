Return-Path: <linux-kernel+bounces-70370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535648596B4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 12:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA741C20C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029E633F9;
	Sun, 18 Feb 2024 11:48:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D34EB3B;
	Sun, 18 Feb 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256895; cv=none; b=DfUnyUcYKQlf16oq2CgdNYJDx694jsZiWj+vZX27FZkdBC5Pl8Fn8aPx9XmHx45fNWbNIz5T6BK6oS9NJKCRQbNyj5TBZQwEAYrJ8Edf914G/oUtU/ctcmhyGYbZh7bcmjVqn1m64nXsIrLtjLfI2MwrNjf6ZPe6H23ka1swe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256895; c=relaxed/simple;
	bh=PkNyafTg64GjrN52zqLU5irSUucWFHzmZf4YKP75Q8o=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WBv/J7Rw1bD4HE7ZnD1dEi08pPwbqv8eEMmduACDJUn67bYynYLwwgBHsc7+DWFUuzpxoQzigAaNe8tTr5qPfuRnJueMzePZd06OqH+M6rZx9IymX2brpBTh7vy3hhGLBOWwSDl17cG7266abUP0hsxZ/mCQr9Vz81hXsJYf7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Td3lb03Khz1gyrl;
	Sun, 18 Feb 2024 19:46:03 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F73E1A0172;
	Sun, 18 Feb 2024 19:48:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 19:48:07 +0800
Subject: Re: [PATCH 5.4 058/194] mtd: Fix gluebi NULL pointer dereference
 caused by ftl notifier
To: Richard Weinberger <richard@nod.at>
CC: Martin Kepplinger-Novakovic <martink@posteo.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>,
	<patches@lists.linux.dev>, ZhaoLong Wang <wangzhaolong1@huawei.com>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Sasha Levin <sashal@kernel.org>,
	linux-mtd <linux-mtd@lists.infradead.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, dpervushin <dpervushin@embeddedalley.com>, Artem
 Bityutskiy <Artem.Bityutskiy@nokia.com>, linux-kernel
	<linux-kernel@vger.kernel.org>, yi zhang <yi.zhang@huawei.com>, yangerkun
	<yangerkun@huawei.com>, Henri Roosen <Henri.Roosen@ginzinger.com>, Melchior
 Franz <Melchior.Franz@ginzinger.com>
References: <20240122235719.206965081@linuxfoundation.org>
 <20240122235721.687806578@linuxfoundation.org>
 <fdfcc3b6e1a884bb986acf072bcc13611eae8bdd.camel@posteo.de>
 <a53aacd3-4270-2d80-f14c-8cfd763e4404@huawei.com>
 <1171523562.70108.1708251955853.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <912b7429-c294-418e-2082-ab269382f1f0@huawei.com>
Date: Sun, 18 Feb 2024 19:48:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1171523562.70108.1708251955853.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/2/18 18:25, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> Hi Greg, hi patch-developers,
>>>
>>> wait a second. this already went into v5.4.268 but still: Doesn't this
>>> break userspace?
>>>
>>> According to
>>> https://lore.kernel.org/lkml/441107100.23734.1697904580252.JavaMail.zimbra@nod.at/
>>> where this solution seems to come from, the behaviour changes: "no
>>> mtdblock (hence, also no FTLs) on top of gluebi."
>>>
>>> I fell accross this because of an out-of-tree module that does
>>> sys_mount() an mtdblock, so I won't complain about my code specifically
>>> :) But doesn't it break mounting, say, jffs2 inside an ubi via
>>> mtdblock? If so, is this really something that you want to see
>>> backported to old kernels?
>>>
>>> Or differently put: Has this patch been picked up for old stable
>>> kernels by scripts or by a human?
>>>
>>> I just want to make sure, and who knows, it might help others too, who
>>> would just do a (possibly dangerous?) revert in their trees.
>>>
>>
>> This change does affect the mounting(mtdblock based on gluebi) behavior
>> in userspace. It was picked into stable versions because the fixed
>> problem is serious and easy to be reproduced, I guess.
>> A temporary solution is that modify mounting source target in userspace,
>> just replace mtdblock with mtd char device. For example, mount -t jffs2
>> mtd0 /mnt
> 
> I don't think this needs backporting to stable. It's not serious because you
> still need to be root to setup and trigger such a scenario.
> 


Yes. I feel okay to revert this patch on stable versions.

