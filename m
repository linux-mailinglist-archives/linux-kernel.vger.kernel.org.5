Return-Path: <linux-kernel+bounces-14225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED2F82196C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEEB2096E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716AD27E;
	Tue,  2 Jan 2024 10:08:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217ECA78
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T47nq0DhKzMl5r;
	Tue,  2 Jan 2024 18:07:43 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A982180075;
	Tue,  2 Jan 2024 18:08:12 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 18:08:11 +0800
Subject: Re: [PATCH RFC 00/17] ubifs: Add filesystem repair support
To: Richard Weinberger <richard@nod.at>
CC: david oberhollenzer <david.oberhollenzer@sigma-star.at>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Sascha Hauer <s.hauer@pengutronix.de>, Tudor
 Ambarus <Tudor.Ambarus@linaro.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
 <1145531757.175508.1703844362355.JavaMail.zimbra@nod.at>
 <13b259ca-b32f-a8d6-5e11-8bb38df72f5c@huawei.com>
 <642239519.177270.1703884138999.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com>
Date: Tue, 2 Jan 2024 18:08:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <642239519.177270.1703884138999.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2023/12/30 5:08, Richard Weinberger 写道:
>> Second, you concern odd/incomplete files are recovered just like I
>> metioned in documentation(Limitations section), which still make
>> application failed because the recovered file lost data or deleted file
>> is recovered. So you suggested me that make a userspace fsck tool, and
>> fsck can telll user which file is data lost, which file is recovered
>> after deletion.
>>
>> The difficulty comes from second point,  how does fsck know a file is
>> recovered incomplete or old. Whether the node is existing, it is judged
>> by TNC, but TNC could be damaged like I descibed in above. Do you have
>> any ideas?
> That's the problem what all fsck tools have in common.
> The best we can do is offering safe and dangerous repair modes
> plus a good repair report.
> 

I come up with another way to implement fsck.ubifs:

There are three modes:

1. common mode(no options): Ask user whether to fix as long as a problem 
is detected.

2. safe mode(-a option): Auto repair as long as no data/files lost(eg. 
nlink, isize, xattr_cnt, which can be corrected without dropping nodes), 
otherwise returns error code.

3. dangerous mode(-y option): Fix is always successful, unless 
superblock is corrupted. There are 2 situations:

   a) TNC is valid: fsck will print which file is dropped and which 
file's data is dropped

   b) TNC is invalid: fsck will scan all nodes without referencing TNC, 
same as this patchset does


Q1: How do you think of this method?

Q2: Mode 1, 2 and 3(a) depend on journal replaying, I found 
xfs_repair[1] should be used after mounting/unmounting xfs (Let kernel 
replay journal), if UBIFS does so, there is no need to copy recovery 
subsystem into userspace, but user has to mount/unmount before doing 
fsck. I found e2fsck has copied recovery code into userspace, so it can 
do fsck without mounting/unmounting. If UBIFS does so, journal replaying 
will update TNC and LPT, please reference Q3(1). Which method do you 
suggest?

Q3: If fsck drops or updates a node(eg. dentry lost inode, corrected 
inode) in mode 1,2 and 3(a), TNC/LPT should be updated. There are two 
ways updating TNC and LPT:

   1) Like kernel does, which means that mark dirty TNC/LPT for 
corresponding branches and do_commit(). It will copy much code into 
userspace, eg. tnc.c, lpt.c, tnc_commit.c,
lpt_commit.c. I fear there exists risks. For example, there is no space 
left for new index nodes, gc should be performed? If so, gc/lpt gc code 
should be copied too.

   2) Rebuild new TNC/LPT based on valid nodes. This way is simple, but 
old good TNC could be corrupted, it means that powercut during fsck may 
let UBIFS image must be repaired in mode 3(b) but it could be repaired 
in mode 2\3(a) before invoking fsck.

Which way is better?


[1] 
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_file_systems/checking-and-repairing-a-file-system__managing-file-systems#proc_repairing-an-xfs-file-system-with-xfs_repair_checking-and-repairing-a-file-system

> Long story short, I'm not opposed to the idea, I just want to make
> sure that this new tool or feature is not used blindly, since
> it cannot do magic.


