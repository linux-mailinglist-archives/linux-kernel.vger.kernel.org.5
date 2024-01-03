Return-Path: <linux-kernel+bounces-15132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5D822789
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64709B2184F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FED4A33;
	Wed,  3 Jan 2024 03:18:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC94A16
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T4ZZw3PHnz1FHX7;
	Wed,  3 Jan 2024 11:14:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id F3CD1140136;
	Wed,  3 Jan 2024 11:18:46 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:18:46 +0800
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
 <a145fc68-9b0a-9794-48d2-b7ad79116833@huawei.com>
 <535616666.192239.1704228332389.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <460eb02e-8937-282c-62c5-6ea606324b0e@huawei.com>
Date: Wed, 3 Jan 2024 11:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <535616666.192239.1704228332389.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/1/3 4:45, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> I come up with another way to implement fsck.ubifs:
>>
>> There are three modes:
>>
>> 1. common mode(no options): Ask user whether to fix as long as a problem
>> is detected.
> 
> Makes sense.
> 
>> 2. safe mode(-a option): Auto repair as long as no data/files lost(eg.
>> nlink, isize, xattr_cnt, which can be corrected without dropping nodes),
>> otherwise returns error code.
> 
> Makes sense.
>   
>> 3. dangerous mode(-y option): Fix is always successful, unless
>> superblock is corrupted. There are 2 situations:
> 
> Please not use "-y". Usually "-y" stands for "answer yes to all questions".
> But selecting names for command line flags is currently my least concern.
>   
>>    a) TNC is valid: fsck will print which file is dropped and which
>> file's data is dropped
> 
> Sounds also good.
>   
>>    b) TNC is invalid: fsck will scan all nodes without referencing TNC,
>> same as this patchset does
> 
> I'd make this a distinct mode.
> It can be used to rebuild index and LEB property trees.
> This is basically a "drop trees and rebuild" mode.
> 

OK, then fsck will have four modes.

>>
>> Q1: How do you think of this method?
> 
> Sounds good so far.
>   
>> Q2: Mode 1, 2 and 3(a) depend on journal replaying, I found
>> xfs_repair[1] should be used after mounting/unmounting xfs (Let kernel
>> replay journal), if UBIFS does so, there is no need to copy recovery
>> subsystem into userspace, but user has to mount/unmount before doing
>> fsck. I found e2fsck has copied recovery code into userspace, so it can
>> do fsck without mounting/unmounting. If UBIFS does so, journal replaying
>> will update TNC and LPT, please reference Q3(1). Which method do you
>> suggest?
> 
> UBIFS is a little special regarding the journal.
> 
> 1. The journal is not an add-on like it is on many other file systems,
> you have to replay it to get a consistent file system.
> 2. Journal replay is also needed after a clean umount. The reason is that
> UBIFS does no commit at umount time.

I agree, there exists one situation that UBIFS replays journal even 
after clean umount.
     P1      ubifs_bgt      umount
   mkdir
          run_bg_commit
           c->cmt_state = COMMIT_RUNNING_BACKGROUND
           do_commit
            ubifs_log_start_commit(c, &new_ltail_lnum) // log start
            up_write(&c->commit_sem)
   touch
    ubifs_jnl_update // new buds added
                          cleanup_mnt
                           deactivate_super
                            fs->kill_sb
                             generic_shutdown_super
                              sync_filesystem
                               ubifs_sync_fs
                                ubifs_run_commit
                                 wait_for_commit // wait bg commit, 
'touch' won't be commited, it will be replayed in next mount

> 
> So IMHO you need to have journal replay code in your tool in any case.
> You can copy it from the kernel implementation and add more checks.
> While the kernel code also tries to be fast, fsck should be more paranoid.
> Ideally the outcome is a libubifs or such which can be derived from the
> kernel source while building mtd-utils.

All right, sounds like a huge copy work.

> 
>> Q3: If fsck drops or updates a node(eg. dentry lost inode, corrected
>> inode) in mode 1,2 and 3(a), TNC/LPT should be updated. There are two
>> ways updating TNC and LPT:
>>
>>    1) Like kernel does, which means that mark dirty TNC/LPT for
>> corresponding branches and do_commit(). It will copy much code into
>> userspace, eg. tnc.c, lpt.c, tnc_commit.c,
>> lpt_commit.c. I fear there exists risks. For example, there is no space
>> left for new index nodes, gc should be performed? If so, gc/lpt gc code
>> should be copied too.
>>
>>    2) Rebuild new TNC/LPT based on valid nodes. This way is simple, but
>> old good TNC could be corrupted, it means that powercut during fsck may
>> let UBIFS image must be repaired in mode 3(b) but it could be repaired
>> in mode 2\3(a) before invoking fsck.
>>
>> Which way is better?
> 
> Since you need to do a full journal replay anyway and power-cut awareness
> is one of your requirements, I fear the only option is 1). >
> Thanks,
> //richard
> .
> 


