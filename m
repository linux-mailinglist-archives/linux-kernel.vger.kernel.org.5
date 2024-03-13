Return-Path: <linux-kernel+bounces-101459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E187A768
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63294284796
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B1F3FB1D;
	Wed, 13 Mar 2024 12:11:03 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D83F9C7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331862; cv=none; b=NADdNOLwS3VTafV0igtcPvKq0p3Qf+LUuK+xnWcDBhn4d2t7aMT5uDe/EYRL9zlWmgw1UL/C0eNFo978+QY6t7ol6mN4R/dhmLD3p6iEiUb+ltfqokyLzMfS0cMnDCAp53oOZRgrz8elJYOdA+YB0uYIRPB0QF7NMD5ijF37hpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331862; c=relaxed/simple;
	bh=NdH9WP6DJGM6iZ0XJKbtpntEDbujgsLMibdp/khVy0g=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bw3Z/VYQ1cNe6lW092TYafrotA/gbR138xi/eV0Cfp5VSWwHDpCSM9lHkTvbisrdN0ysW6hQiuJTH3QKdHKtrgp9HGxLZ63PHY0n2GcRo3KURwkYZTcl8AW+jFqTBCJyTYvQ/7mgRyQIa6QMTBEoQ+4Z1AV4GXO4DDvt9yk0eOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tvq8w4fJ0z1FMBr;
	Wed, 13 Mar 2024 20:10:40 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 642BC140159;
	Wed, 13 Mar 2024 20:10:56 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 20:10:55 +0800
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Richard
 Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
Date: Wed, 13 Mar 2024 20:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/13 19:53, Arnd Bergmann 写道:
> On Wed, Mar 13, 2024, at 12:29, Zhihao Cheng wrote:
>> 在 2024/3/13 16:46, Arnd Bergmann 写道:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> The use of do_div() in ubi_nvmem_reg_read() makes calling it on
>>> 32-bit machines rather expensive. Since the 'from' variable is
>>> known to be a 32-bit quantity, it is clearly never needed and
>>> can be optimized into a regular division operation.
>>>
>> Do you meet a performance problem on a 32-bit machine? There are too
>> many places invoking do_div, why do you optimize this one?
>> Have you tested the influence on a x86_64 platform after this patch
>> applied? Looks like that do_div is more efficient in x86.
> 
> This one was just introduced. The call site looks like a fast
> path and it caused a build regression that Daniel addressed with
> an suboptimal commit b8a77b9a5f9c ("mtd: ubi: fix NVMEM over
> UBI volumes on 32-bit systems").
> 
> The way it usually goes is that someone adds an open-coded
> 64-bit division that causes a link failure, which prompts
I'm a little confused, what kind of link failure? Could you show an example?
> the original developer to either rewrite the code to avoid
> the long division if possible, or add do_div() after showing
> that it is now performance critical, e.g. only called at
> probe time.
> 
>       Arnd
> .
> 


