Return-Path: <linux-kernel+bounces-95074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA88748F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C77282938
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516C6311B;
	Thu,  7 Mar 2024 07:43:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCF38DEF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797430; cv=none; b=kD0Vj7RIj+l+4ejU2JtrIvlE/oAgqBAZSNOfhXMw5cCDnYCIaG5551WZwzhok1XOq2DptGLx6VOqoG4kvo9cDCcSeMXeZBH3bn84hZh97L/e8xIVUySfaErry69Znc6cDZj92wFCh7ydCU/aCU8mNKo91tXOsZWYzDQlJE1BB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797430; c=relaxed/simple;
	bh=LVAe2E6e0Oz/NDfDpFiSTBjN3xsQ02++UCJW5rUkH+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ClAcaUEYE+XjTtl/PpJdTTFNWlg0PJKcZwqvsp+3noTMpSknHeNF7TTBfhhmrzY6m0ch4WCgK7LBy4DnVroyACTlgjIRD95kfZZBM0M/yDTLDyqS7HdZS2dk1fKfOV0jnd3EkbwoIm66cRSsAbgcC7rU07SEQuMbOtPMgNDRUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tr1T261TgzwPHK;
	Thu,  7 Mar 2024 15:41:26 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC5D140410;
	Thu,  7 Mar 2024 15:43:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 15:43:44 +0800
Message-ID: <bca29c1a-6a4d-e128-b9b5-5c48020d4850@huawei.com>
Date: Thu, 7 Mar 2024 15:43:44 +0800
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
 <20240307072112.GC538574@ZenIV>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240307072112.GC538574@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/3/7 15:21, Al Viro wrote:
> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
>>>> +int erofs_anon_register_fs(void)
>>>> +{
>>>> +	return register_filesystem(&erofs_anon_fs_type);
>>>> +}
>>> What for?  The only thing it gives you is an ability to look it up by
>>> name.  Which is completely pointless, IMO,
>> The helper function here is to avoid extern erofs_anon_fs_type(), because
>> we define it in fscache.c, but also use it in super.c. Moreover, we don't
>> need
>> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
> You don't need to register it at all.
>
> The one and only effect of register_filesystem() is making file_system_type
> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
>
> That's it.  If you want to have it looked up by name (e.g. for userland
> mounts), you need to register.  If not, you do not need to do that.
>
> Note that kern_mount() take a pointer to struct file_system_type,
> not its (string) name.  So all you get from registration is an extra line
> in /proc/filesystems.  What's the point?
It's dawning on me, thank you so much for explaining! ღ( ´･ᴗ･` )

-- 
With Best Regards,
Baokun Li
.

