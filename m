Return-Path: <linux-kernel+bounces-145323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08978A52B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B6BB21C01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFC74433;
	Mon, 15 Apr 2024 14:08:35 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA31BF2A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190115; cv=none; b=lCVCa4VFXjj5l8NF9a3/Qp2g5mD03ovwGQzt3MXa+dlVewLIQ1bz2Z7UkN/R9V4GrHiEVQVd8c7xKNkvs4xetDxeU36fvleqVCm1CtugMCfQscIR57bhX49mtgkhjwjILy8x3iFB67aSYYvA9Na7/EIBB6TeyaD0jxfcpK6L8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190115; c=relaxed/simple;
	bh=h5EZPa9BSTZ+IOVlGQn5DV+g0jxDaU/2YCEBbkHDlZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EWzsLO+dRUGNN9nD3o8896rHuSOIMS4B4S+HHE/ouuf+egyezILPpLeIuISXZae29LqcjrB5CPNNplY6BzK0OP9ggJ1TYHN744JXBspSCQmUj44e1PR13DPkYy4h3z3tGomGLOFKt5Vrux0d5xokMOVwfTSitUV5mTU/xPzeiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VJ88w2NJGz1yndq;
	Mon, 15 Apr 2024 22:06:08 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BB3F14011F;
	Mon, 15 Apr 2024 22:08:29 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 22:08:29 +0800
Message-ID: <e3115135-bc20-4bca-4ca1-72d8775ee706@huawei.com>
Date: Mon, 15 Apr 2024 22:08:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] erofs: set SB_NODEV sb_flags when mounting with fsid
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <xiang@kernel.org>, <chao@kernel.org>,
	<huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <houtao1@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20240415121746.1207242-1-libaokun1@huawei.com>
 <20240415-betagten-querlatte-feb727ed56c1@brauner>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240415-betagten-querlatte-feb727ed56c1@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/15 21:38, Christian Brauner wrote:
> On Mon, Apr 15, 2024 at 08:17:46PM +0800, Baokun Li wrote:
>> When erofs_kill_sb() is called in block dev based mode, s_bdev may not have
>> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it will
>> be mistaken for fscache mode, and then attempt to free an anon_dev that has
>> never been allocated, triggering the following warning:
>>
>> ============================================
>> ida_free called for id=0 which is not allocated.
>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>> Modules linked in:
>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>> RIP: 0010:ida_free+0x134/0x140
>> Call Trace:
>>   <TASK>
>>   erofs_kill_sb+0x81/0x90
>>   deactivate_locked_super+0x35/0x80
>>   get_tree_bdev+0x136/0x1e0
>>   vfs_get_tree+0x2c/0xf0
>>   do_new_mount+0x190/0x2f0
>>   [...]
>> ============================================
>>
>> To avoid this problem, add SB_NODEV to fc->sb_flags after successfully
>> parsing the fsid, and then the superblock inherits this flag when it is
>> allocated, so that the sb_flags can be used to distinguish whether it is
>> in block dev based mode when calling erofs_kill_sb().
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/erofs/super.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index b21bd8f78dc1..7539ce7d64bc 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -520,6 +520,7 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>>   		ctx->fsid = kstrdup(param->string, GFP_KERNEL);
>>   		if (!ctx->fsid)
>>   			return -ENOMEM;
>> +		fc->sb_flags |= SB_NODEV;
> Hm, I wouldn't do it this way. That's an abuse of that flag imho.
> Record the information in the erofs_fs_context if you need to.
Hi Christian!

The problem here is that when mounting erofs, if we have an fsid
then it is not block device based, if we don't have an fsid it is block
device based. So only after we confirmed whether we have an fsid
or not, we can confirm whether we need SB_NODEV or not.

-- 
With Best Regards,
Baokun Li
.

