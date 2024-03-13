Return-Path: <linux-kernel+bounces-101541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD887A873
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BAD1C22DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267547779;
	Wed, 13 Mar 2024 13:29:51 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917046B83
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336591; cv=none; b=cw5YcHmk7T3eMFZa1FpUPK5M8xK81feYOA+vKcVariFJOeKUe4TXKsuH8wf9xClvchlWGVxPkR3xK+YLTZxgvVtbMTqIzPEpKtnZw/6PQ8jS9ja2hbfg8itWzxrvVZjRm+5S54iuYS6u2X4sxx9TEw+qH/JEUxvRg9pvfFYiBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336591; c=relaxed/simple;
	bh=pdLDJC2piLf5zMosG1/TZ7MhDvUxHrIdoOhQ2pDEzgc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WyOHT42+bed3csqpgC3QgUiTH2GOCbtYT93SEpULh9C8fD2V37kTIDiCxGyAOMMRzL9fqMRxVk+8xZ0X0kD1DiC8w0axmqgAItw62Ja7ytozbeJzkc98b2jPBtcj9CmDSlxZJnOJDtb7VdL7qc54DIovBTu7/r3xdAEOGmlBoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TvrsD1DMFz1Q9gw;
	Wed, 13 Mar 2024 21:27:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D5A3E140159;
	Wed, 13 Mar 2024 21:29:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 21:29:38 +0800
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard
 Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
 <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
 <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <610231c3-c3ee-e543-1a8a-8e1098ee6a7c@huawei.com>
Date: Wed, 13 Mar 2024 21:29:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/13 20:21, Arnd Bergmann 写道:
> On Wed, Mar 13, 2024, at 13:10, Zhihao Cheng wrote:
>> 在 2024/3/13 19:53, Arnd Bergmann 写道:
>>> On Wed, Mar 13, 2024, at 12:29, Zhihao Cheng wrote:
>>>
>>> The way it usually goes is that someone adds an open-coded
>>> 64-bit division that causes a link failure, which prompts
>> I'm a little confused, what kind of link failure? Could you show an example?
> 
> The open-coded 64-bit division without using do_div() shows up as
> 
> x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_read':
> nvmem.c:(.text+0x10a): undefined reference to `__umoddi3'
> x86_64-linux-ld: nvmem.c:(.text+0x11f): undefined reference to `__udivdi3'
> x86_64-linux-ld: drivers/mtd/ubi/nvmem.o: in function `ubi_nvmem_reg_read.cold':
> nvmem.c:(.text.unlikely+0x2d): undefined reference to `__umoddi3'
>  > The idea is that gcc expects __umoddi3 to be provided by libgcc,
> but Linux intentionally leaves it out in order to catch accidental
> 64-bit divisions.
> 

Thanks for explaination, which means that do_div is used for 64-bit 
division to solve the link failure caused by missed libgcc. Since 
parameter 'from' is u32, there is no need to invoke do_div on a 32-bit 
platform, you just want to stop the wasting behavior on a 32-bit 
platform. Do I understand right?

