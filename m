Return-Path: <linux-kernel+bounces-37014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728AE83AA32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AFF1C22A90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6477655;
	Wed, 24 Jan 2024 12:45:09 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A747763A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100309; cv=none; b=BFikDFFkhC0vc2KbpAaQBrOQvYQgaeLzy27FdfKlhI5DE1wbTILBuVwFoD8vbOqAKG4i2zn/So2MR4FeYFPFsL2egFBjYtAfgOli03QF7b7NHZVB+b85czTIIltUFFUZQTUbQwdVUEzYI+z4LDQrfOpU1hztELvAEX74mqSU86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100309; c=relaxed/simple;
	bh=XKi0zVwjjfVwdJlARkO2RrHn8fFmHl2ls0r3ZRqrlhY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ldj8tJHskEm0iF0+UkWMWMreb1uHfi8ruAtKFpdl5w0ZoZNWxouIdz5chkuW1vHXJWzAzbOiNsEHJeJW11Yu+tCiUizNjG7145uYgKJx6DDKl+Go6n/SY9BCu8t5Y6Adsi/BsoLj0pboZwY5ndfTX/ZxFatJzsXzLGNNsIxaGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TKkDC5GGhz1xmT3;
	Wed, 24 Jan 2024 20:44:11 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 42DB91A016E;
	Wed, 24 Jan 2024 20:44:49 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 20:44:48 +0800
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
To: Chenyuan Yang <chenyuan0y@gmail.com>
CC: <linux-mtd@lists.infradead.org>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>, <syzkaller@googlegroups.com>, Zijie Zhao
	<zzjas98@gmail.com>
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
 <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com>
 <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7138a98c-1562-3059-07b6-4d918bec9d1a@huawei.com>
Date: Wed, 24 Jan 2024 20:44:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/1/23 12:57, Chenyuan Yang 写道:
> Hi Zhihao,
> 
> Thanks for your prompt reply! Here are the files related to this memory leak.
> 
> Best,
> Chenyuan
> 

Can you provide a kernel config and the cmdline? I can't reproduce the 
problem by both C program and syz program. But after analyzing the log:

     [<ffffffff8157274e>] __kmalloc_node_track_caller+0x4e/0x120 
mm/slab_common.c:1027
     [<ffffffff81561e1f>] kstrdup+0x3f/0x70 mm/util.c:62
     [<ffffffff81561ea7>] kstrdup_const+0x57/0x80 mm/util.c:85
     [<ffffffff824d4596>] kvasprintf_const+0xc6/0x110 lib/kasprintf.c:48
     [<ffffffff84aaeadf>] kobject_set_name_vargs+0x3f/0xe0 lib/kobject.c:272
     [<ffffffff84aaef41>] kobject_add_varg lib/kobject.c:366 [inline]
     [<ffffffff84aaef41>] kobject_init_and_add+0x71/0xe0 lib/kobject.c:455
     [<ffffffff8162085a>] sysfs_slab_add+0x10a/0x210 mm/slub.c:6168
     [<ffffffff81628474>] __kmem_cache_create+0x1b4/0x5a0 mm/slub.c:5120
     [<ffffffff81571dca>] create_cache mm/slab_common.c:235 [inline]
     [<ffffffff81571dca>] kmem_cache_create_usercopy+0x16a/0x2e0 
mm/slab_common.c:340
     [<ffffffff81571f51>] kmem_cache_create+0x11/0x20 mm/slab_common.c:395
     [<ffffffff82e40fc5>] alloc_ai drivers/mtd/ubi/attach.c:1464 [inline]
     [<ffffffff82e40fc5>] ubi_attach+0xb5/0x1e00 
drivers/mtd/ubi/attach.c:1560
     [<ffffffff82e302f8>] ubi_attach_mtd_dev+0x878/0x1130 
drivers/mtd/ubi/build.c:1000
     [<ffffffff82e3176d>] ctrl_cdev_ioctl+0x1dd/0x250 
drivers/mtd/ubi/cdev.c:1043
     [<ffffffff816b0e23>] vfs_ioctl fs/ioctl.c:51 [inline]
     [<ffffffff816b0e23>] __do_sys_ioctl fs/ioctl.c:871 [inline]

The leaked memory is located in 'kobj->name', the kobj comes from 
kmem_cache and it is used to create entry under 
sysfs('/sys/kernel/slab'). If kmem_cache_destroy() is missed to be 
called in someone exiting path in UBI, there will be more memleak 
messages reported (eg. ai->aeb_slab_cache). So I guess the potentional 
problem has nothing to do with UBI.
After looking through the implementation of create_cache, the life time 
of 'kobj->name' is along with kobj, it can be always released even in 
error handling paths. To figure out what happens I need to reproduce it 
on my local machine.

> On Mon, Jan 22, 2024 at 10:55 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2024/1/23 11:53, Chenyuan Yang 写道:
>>> Dear Linux Kernel Developers for UBI,
>>>
>>> We encountered "memory leak in ubi_attach" when testing UBI with
>>> Syzkaller and our generated specifications.
>>>
>>> syz repro: https://drive.google.com/file/d/17FoGw6akfufz05U-oRBP2wXmOiFF1VUq/view?usp=drive_link
>>> C reproducer: https://drive.google.com/file/d/1ayd3lmHPvqNoI01pQEdU832EktpTUnZ_/view?usp=drive_link
>>> report: https://drive.google.com/file/d/1hC2arY3FbQt-6L5rbDfY-DQ2oH82IIGq/view?usp=drive_link
>>> stats: https://drive.google.com/file/d/1REig9fV0H1fYPWaiicc-JVLlCpo7TTw4/view?usp=drive_link
>>
>> I can't open above links in company, may you post these files in attachment?
>>
>>>
>>> This memory leak is triggered by `ioctl$UBI_IOCATT`, where
>>> `ubi_attach_info` invokes `kmem_cache_create`
>>> (https://elixir.bootlin.com/linux/v6.7/source/drivers/mtd/ubi/attach.c#L1464).
>>> It seems that the memory leak occurs when the slab cache is
>>> successfully created. I apologize for not being able to conduct a
>>> deeper analysis of the root cause, as my expertise in UBI drivers is
>>> limited.
>>>
>>> If you have any questions or require more information, please feel
>>> free to contact us.
>>>
>>> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
>>>
>>> Best,
>>> Chenyuan
>>>
>>>
>>> ______________________________________________________
>>> Linux MTD discussion mailing list
>>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>>>
>>
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/


