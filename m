Return-Path: <linux-kernel+bounces-95185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6D874A60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82A6288205
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37D82D88;
	Thu,  7 Mar 2024 09:08:35 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593D823BF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802515; cv=none; b=Ct42EYfVKCR+G/oyQ3C9cikjKn0qzr9NKeW1M+IbWCvM0prAOjXTnCH6YMH9Oi4edBqTsShaJbvh/CqHRzz1AgJuAEk+TukwCEe/2VEyNRWp90LAaolI/S0WRGAZeOf5hKiLehuq5MclSWwZjAFAWpUoPnVLWPyh+2DC2VUFaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802515; c=relaxed/simple;
	bh=MhPKVKt5bqVMniQ/NgqFAw+BatWOS+z0ZiSQ9WK6huM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ntYIhBUnqBkpg0GkJ9fOZd6JnPih/BX2HF55Ttq75YWlO+qVbM+5TN3n/+/fS3Eya/spiJURu0hkQb7SH9aFtBl81W1FgBw4bwPFjPkOsfaSwE9p32HSqq9oxHsjlTBFZZBVJmbttBCfDO6ArpON+tkaatBhwoM4Hcu7ou2dDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tr3Ls2yX2zXhsC;
	Thu,  7 Mar 2024 17:06:13 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F4981400DD;
	Thu,  7 Mar 2024 17:08:30 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 17:08:29 +0800
Message-ID: <84a79c06-692a-25b8-b95c-21e565eced19@huawei.com>
Date: Thu, 7 Mar 2024 17:08:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <linux-erofs@lists.ozlabs.org>, <xiang@kernel.org>, <chao@kernel.org>,
	<huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>, <chengzhihao1@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
 <20240307072112.GC538574@ZenIV> <20240307084608.GD538574@ZenIV>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240307084608.GD538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/7 16:46, Al Viro wrote:
> On Thu, Mar 07, 2024 at 07:21:12AM +0000, Al Viro wrote:
>> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
>>>>> +int erofs_anon_register_fs(void)
>>>>> +{
>>>>> +	return register_filesystem(&erofs_anon_fs_type);
>>>>> +}
>>>> What for?  The only thing it gives you is an ability to look it up by
>>>> name.  Which is completely pointless, IMO,
>>> The helper function here is to avoid extern erofs_anon_fs_type(), because
>>> we define it in fscache.c, but also use it in super.c. Moreover, we don't
>>> need
>>> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
>> You don't need to register it at all.
>>
>> The one and only effect of register_filesystem() is making file_system_type
>> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
>>
>> That's it.  If you want to have it looked up by name (e.g. for userland
>> mounts), you need to register.  If not, you do not need to do that.
>>
>> Note that kern_mount() take a pointer to struct file_system_type,
>> not its (string) name.  So all you get from registration is an extra line
>> in /proc/filesystems.  What's the point?
> PS: at one point I considered renaming it to something that would sound
> less vague, but the best variant I'd been able to come up with was
> "publish_filesystem()", which is not much better and has an extra problem -
> how do you describe the reverse of that?  "withdraw_filesystem()"?
> Decided that it wasn't worth the amount of noise and headache...
I feel the emphasis on "fs_name" rather than "filesystem" is less
likely to be misunderstood. What do you think about renaming
to add_fs_name/remove_fs_name?

-- 
With Best Regards,
Baokun Li
.

