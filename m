Return-Path: <linux-kernel+bounces-13094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CC81FF9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81211C210EB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA062111BD;
	Fri, 29 Dec 2023 13:10:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADA111AD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T1m1V3Bx3zsTgK;
	Fri, 29 Dec 2023 21:09:34 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A0811400E3;
	Fri, 29 Dec 2023 21:10:03 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 21:10:02 +0800
Subject: Re: [PATCH RFC 00/17] ubifs: Add filesystem repair support
To: Richard Weinberger <richard@nod.at>
CC: david oberhollenzer <david.oberhollenzer@sigma-star.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Sascha Hauer <s.hauer@pengutronix.de>, Tudor
 Ambarus <Tudor.Ambarus@linaro.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
 <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com>
Date: Fri, 29 Dec 2023 21:09:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2023/12/29 18:06, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> An: "david oberhollenzer" <david.oberhollenzer@sigma-star.at>, "richard" <richard@nod.at>, "Miquel Raynal"
>> <miquel.raynal@bootlin.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Tudor Ambarus" <Tudor.Ambarus@linaro.org>
>> CC: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>
>> Gesendet: Donnerstag, 28. Dezember 2023 02:40:55
>> Betreff: [PATCH RFC 00/17] ubifs: Add filesystem repair support
> Thanks a lot for sharing this.
> Below you find some thoughts that came into my mind while skimming over the
> patch series.
>
>> UBIFS repair provides a way to fix inconsistent UBIFS image(which is
>> corrupted by hardware exceptions or UBIFS realization bugs) and makes
>> filesystem become consistent, just like fsck tools(eg. fsck.ext4,
>> fsck.f2fs, fsck.fat, etc.) do.
> I don't fully agree. The tool makes UBIFS mount again but you still have lost data
> and later userspace might fail because file no longer contain what the application
> expected.
> So my fear is that we're just shifting the problem one layer up.
>
> UBIFS never had a fsck for reasons. UBIFS tries hard to not become inconsistent,
> by maintaining a data journal for example.
> It can fail of course by hardware issues. e.g. if the underlying MTD loses bits,
> but there is nothing UBIFS can do except something like storing duplicates
> of data like BTRFS does.
>
> And finally, the biggest pain point, it can fail due to bugs in UBIFS itself.
> In my opinion bugs should get addressed by improving our test infrastructure
> instead of working around.

I make UBIFS repair for two reasons:

1. There have been many inconsistent problems happened in our 
products(40+ per year), and reasons for most of them are unknown, I even 
can't judge the problem is caused by UBIFS bug or hardware exception. 
The consistent problems, for example, TNC points to an empty space, TNC 
points to an unexpected node, bad key order in znodes, dirty space of 
pnode becomes greater than LEB size, huge number in 
master->total_dead(looks like overflow), etc. I cannot send these bad 
images to find help, because the corporate policy. Our kernel version is 
new, and latest bugfixs in linux-mainline are picked in time. I have 
looked though journal/recovery UBIFS subsystem dozens of times, the 
implementation looks good, except one problem[2]. And we have do many 
powercut/faul-injection tests for ubifs, and Zhaolong has published our 
fault-injection implementation in [3], the result is that 
journal/recovery UBIFS subsystem does look sturdy.

2. If there exists a fsck tool, user have one more option to deal with 
inconsistent UBIFS image. UBIFS is mainly applied in embeded system, 
making filesystem available is most important when filesystem becomes 
inconsistent in some situations.

[1] 
https://linux-mtd.infradead.narkive.com/bfcHzD0j/ubi-ubifs-corruptions-during-random-power-cuts

[2] https://bugzilla.kernel.org/show_bug.cgi?id=218309

[3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=388034

I'm not sure whether you prefer a fsck tool, in my opinion, fsck just 
provide a way for userspace to fix filesystem, user can choose invoke it 
or not according to the tool's limitations based on specific situation. 
But according to your following reply, I guess you can accept that UBIFS 
can have a fsck, and fsck should let user known which file is recovered 
incomplete, which file is old, rather than just make filesystem become 
consistent.

>
>> About why do we need it, how it works, what it can fix or it can not
>> fix, when and how to use it, see more details in
>> Documentation/filesystems/ubifs/repair.rst (Patch 17).
> This needs to go into the cover letter.
OK, thanks for reminding.
>   
>> Testing on UBIFS repair refers to
>> https://bugzilla.kernel.org/show_bug.cgi?id=218327
>>
>> Whatever, we finally have a way to fix inconsistent UBFIS image instead
>> of formatting UBI when UBIFS becomes inconsistent.
> Fix in terms of making mount work again, I fear? As I said, most likely
> the problem is now one layer above. UBIFS thinks everything is good but
> userspace suddenly will see old/incomplete files.
>
> What I can think of is a tool (in userspace like other fscks) which
> can recover certain UBIFS structures but makes very clear to the user what
> the data is lost. e.g. that inode XY now misses some blocks or an old version
> of something will be used.
> But this isl nothing you can run blindly in production.

Let me see.

First, we have a common view, fsck tool is valuable for UBIFS, it just 
provide a way for user application to make UBIFS be consistent and 
available. Right?

Second, you concern odd/incomplete files are recovered just like I 
metioned in documentation(Limitations section), which still make 
application failed because the recovered file lost data or deleted file 
is recovered. So you suggested me that make a userspace fsck tool, and 
fsck can telll user which file is data lost, which file is recovered 
after deletion.

The difficulty comes from second point,  how does fsck know a file is 
recovered incomplete or old. Whether the node is existing, it is judged 
by TNC, but TNC could be damaged like I descibed in above. Do you have 
any ideas?

Besides, we get incomplete file because some data nodes are corrupted, 
the corrupted data is printed in dbg msg when it is dropped.


