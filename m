Return-Path: <linux-kernel+bounces-107185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11C87F89A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32E71F21C45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798F537ED;
	Tue, 19 Mar 2024 07:56:21 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6398D1E536
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710834981; cv=none; b=jfFAqJ6U53n67YVddOWgwVXypdqWuOtFBj2E8t5cuUbN8OsEZFW37rIG8K8HKiUUi91DAmytHBOca2M69U0JLz75OeUpqqYp7DM34kxERx2FevXh+V/tGNookadKNvgjnlzbJ+472fU+LZmMuuZBBOcIcNqbHSYsKedbU2O+3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710834981; c=relaxed/simple;
	bh=7Mtz5aapBUAeT2uBu28m7XZBeO79sKV484K9ltSNg5k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WK39tek9rkabWeHg6xgvBiFqSBSJ1wCyEurgcsLPbn9xhEZAA1bXDy66ORCfpugO+ZzR4NGw9qgMv2Il6CBY5zyFxsfj/iYEeXIZfJmcczIiVI7xWcUe2A/DlwYGJCoN0FfcWYvG8geiuneMy+sSwiOFcb3kQuN14Z12+mzDPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TzPBR4mmNzNm9T;
	Tue, 19 Mar 2024 15:54:23 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id BA548140120;
	Tue, 19 Mar 2024 15:56:15 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 15:56:14 +0800
Subject: Re: [RFC PATCH] jffs2: fix recursive fs_reclaim deadlock
To: Qingfang Deng <dqfext@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240315075946.587679-1-dqfext@gmail.com>
 <ff19df82-3fd4-9098-667c-0502b2452334@huawei.com>
 <CALW65jbKBUDN8ybE1oqrNW5VK1QGpZ1RmnFCCzxjQCo4obaA4A@mail.gmail.com>
 <e5c2c285-0b10-0d23-2c02-7582c026dbfd@huawei.com>
 <CALW65jbQCvkpeoOv275jgQAHf+Tk3QBR0HdwdGhK3s7gF+HVeg@mail.gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3424d2c5-9e49-6218-7ffe-3cf62a07ac3d@huawei.com>
Date: Tue, 19 Mar 2024 15:56:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALW65jbQCvkpeoOv275jgQAHf+Tk3QBR0HdwdGhK3s7gF+HVeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/19 14:41, Qingfang Deng 写道:
> On Fri, Mar 15, 2024 at 9:00 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>
>> 在 2024/3/15 20:19, Qingfang Deng 写道:
>>> Hi Zhihao,
>>>
>>> On Fri, Mar 15, 2024 at 7:19 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>>>> I think it's a false positive warning. Jffs2 is trying to get root inode
>>>> in process '#1', which means that the filesystem is not mounted
>>>> yet(Because d_make_root is after jffs2_iget(sb,1), there is no way to
>>>> access other inodes.), so it is impossible that jffs2 inode is being
>>>> evicted in '#0'.
>>>>
>>>
>>> You're right that process '#1' is getting the root inode. However,
>>> lockdep only records the stack of the first unique lock ordering (see
>>> https://docs.kernel.org/locking/lockdep-design.html#performance ), and
>>> there are many occasions where GFP_KERNEL is used inside a
>>> jffs2_inode_info::sem 's critical section.
>>> .
>>>
>> Allocating memory without GFP_NOFS flags under sleeping lock is a normal
>> thing. The vfs_write is an example(eg. ext4), page is allocated with
>> FGP_WRITEBEGIN flag(no FGP_NOFS) when holding inode lock.
> 
> If this is a false positive, is there a way to suppress the warning?
> .
> 

I can't find a idea either. According to my poor knowledge on lockdep, 
it looks like that lockdep traces a class of locks(eg. f->sem in jffs2) 
rather than one certain lock, because the key of lock->dep_map is 
initialized with a static variable (See mutex_init). In some easy cases, 
we can add subclass to solve the false positive warnings(eg. 
lock_4_inodes). But now, jffs2 case is different, any 
jffs2_do_clear_inode calling could trigger it, and we cannot add limited 
subclasses to solve it.
Take a step back, I think we can just ignore the warning, 
fs_reclaim_acquire is a public path, other filesystems/modules could 
face the same case.

