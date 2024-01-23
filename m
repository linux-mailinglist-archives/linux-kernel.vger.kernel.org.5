Return-Path: <linux-kernel+bounces-34711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F2838676
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035521C2683D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192341FC8;
	Tue, 23 Jan 2024 04:55:27 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC84400
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985726; cv=none; b=U5nZ6xH/x6kIHQ8MeEGr+zZlRil1paktv98ClICxx09vNEDlNweS6WeiAlCYLc1mTktrIKcfuqO0dRFLUKmlK1KVP8qDi6IQa0utF/pK9j2txSiYkiSnpOowH7smAx96Qv6c5/wZwgj+KpNGXYQgarL9EOyDqjhg2MQFnRN7sAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985726; c=relaxed/simple;
	bh=rAgcmrG0t3aSDcPvl2Ic++oT+SicOQH1vWkViIaa/mM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B1l7jWE5TeoQL7PzxqJNcCA1X1XaJq6gfDzKfuTIZAS753ssZmN+RA5A5hrRQCX1pmrsLu8e6R7ZHwi7Pmx0y9FWLSEAiMy8GA3ofleGiKO4aU1XvDP8DCUs1Fh22yJe6SOCXQ/hjSXYI60QPN1yuc7TzeGmnbC4jKfS0D+uKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TJvrj71Z6z1xmWc;
	Tue, 23 Jan 2024 12:54:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 15BB71A0172;
	Tue, 23 Jan 2024 12:55:21 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 12:55:20 +0800
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
To: Chenyuan Yang <chenyuan0y@gmail.com>, <linux-mtd@lists.infradead.org>,
	<richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>, Zijie Zhao
	<zzjas98@gmail.com>
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com>
Date: Tue, 23 Jan 2024 12:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/1/23 11:53, Chenyuan Yang 写道:
> Dear Linux Kernel Developers for UBI,
> 
> We encountered "memory leak in ubi_attach" when testing UBI with
> Syzkaller and our generated specifications.
> 
> syz repro: https://drive.google.com/file/d/17FoGw6akfufz05U-oRBP2wXmOiFF1VUq/view?usp=drive_link
> C reproducer: https://drive.google.com/file/d/1ayd3lmHPvqNoI01pQEdU832EktpTUnZ_/view?usp=drive_link
> report: https://drive.google.com/file/d/1hC2arY3FbQt-6L5rbDfY-DQ2oH82IIGq/view?usp=drive_link
> stats: https://drive.google.com/file/d/1REig9fV0H1fYPWaiicc-JVLlCpo7TTw4/view?usp=drive_link

I can't open above links in company, may you post these files in attachment?

> 
> This memory leak is triggered by `ioctl$UBI_IOCATT`, where
> `ubi_attach_info` invokes `kmem_cache_create`
> (https://elixir.bootlin.com/linux/v6.7/source/drivers/mtd/ubi/attach.c#L1464).
> It seems that the memory leak occurs when the slab cache is
> successfully created. I apologize for not being able to conduct a
> deeper analysis of the root cause, as my expertise in UBI drivers is
> limited.
> 
> If you have any questions or require more information, please feel
> free to contact us.
> 
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> 
> Best,
> Chenyuan
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 


