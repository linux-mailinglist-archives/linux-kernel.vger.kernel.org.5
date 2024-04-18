Return-Path: <linux-kernel+bounces-149474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CAB8A9194
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913FB2835E5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DD2524AF;
	Thu, 18 Apr 2024 03:36:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C379D0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411391; cv=none; b=hAbhFByPqkfIERDEbz8SYpgNYM0OXOsRl1S/rgw6ahXJixHofPndKI/KUhmqZiDjY63Mh/M6ORrQUQj256Y3QJH4uEsdFDnT2S9memU1wG+J4dMjM3iYzJ8z8fIuK5rAHMw47oU6Z48j5l7JN03LRVdUt/5CT230MN6IKl90mJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411391; c=relaxed/simple;
	bh=y+VJB9FcDmpkJ6zth+23xdSUEJyw01Ag1XSB4zDc15I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ABs4sfSlCFZ5cDemvDf50xYzz+u2Z6Wnf3Tis7JDy1ixi7ofVFikcP5Fd79ezJfFx/mdxLtaMSvmk1odmInBzN7Eeo3BnS40zMHofgC8DyQgTNLB45WL6ASc42HU+AoKzEzwVZIaIODGg+yQVc+dQmlh/nu3lYRbeJ3b207Nbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKjzN4YW0zwSfx;
	Thu, 18 Apr 2024 11:33:20 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 820671800C5;
	Thu, 18 Apr 2024 11:36:24 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 11:36:23 +0800
Message-ID: <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
Date: Thu, 18 Apr 2024 11:36:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
To: Jingbo Xu <jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <xiang@kernel.org>, <chao@kernel.org>,
	<huyue2@coolpad.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/4/18 10:16, Jingbo Xu wrote:
> Hi Baokun,
>
> Thanks for catching this and move forward fixing this!

Hi Jingbo，

Thanks for your review！

>
> On 4/17/24 2:55 PM, Baokun Li wrote:
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
>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>> during erofs_get_tree() and ensure that erofs can always have the info
>> available during erofs_kill_sb().
>
> I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
> be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
> another potential advantage of doing this way is that erofs_fs_context
> is not needed anymore and we can use sbi directly.
Yes, except for some extra memory usage when remounting,
this idea sounds great. Let me send a version of v3 to get rid
of erofs_fs_context.
>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> Changes since v1:
>>    Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
>>    modifying fc->sb_flags.
>>
>> V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
>>
>>   fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index b21bd8f78dc1..4104280be2ea 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -581,8 +581,7 @@ static const struct export_operations erofs_export_ops = {
>>   static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	struct inode *inode;
>> -	struct erofs_sb_info *sbi;
>> -	struct erofs_fs_context *ctx = fc->fs_private;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   	int err;
>>   
>>   	sb->s_magic = EROFS_SUPER_MAGIC;
>> @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>>   	sb->s_op = &erofs_sops;
>>   
>> -	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> -	if (!sbi)
>> -		return -ENOMEM;
>> -
>> -	sb->s_fs_info = sbi;
>> -	sbi->opt = ctx->opt;
>> -	sbi->devs = ctx->devs;
>> -	ctx->devs = NULL;
>> -	sbi->fsid = ctx->fsid;
>> -	ctx->fsid = NULL;
>> -	sbi->domain_id = ctx->domain_id;
>> -	ctx->domain_id = NULL;
>> -
>>   	sbi->blkszbits = PAGE_SHIFT;
>>   	if (erofs_is_fscache_mode(sb)) {
>>   		sb->s_blocksize = PAGE_SIZE;
>> @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> -static int erofs_fc_get_tree(struct fs_context *fc)
>> +static void erofs_ctx_to_info(struct fs_context *fc)
>>   {
>>   	struct erofs_fs_context *ctx = fc->fs_private;
>> +	struct erofs_sb_info *sbi = fc->s_fs_info;
>> +
>> +	sbi->opt = ctx->opt;
>> +	sbi->devs = ctx->devs;
>> +	ctx->devs = NULL;
>> +	sbi->fsid = ctx->fsid;
>> +	ctx->fsid = NULL;
>> +	sbi->domain_id = ctx->domain_id;
>> +	ctx->domain_id = NULL;
>> +}
> I'm not sure if abstracting this logic into a seperate helper really
> helps understanding the code as the logic itself is quite simple and
> easy to be understood. Usually it's a hint of over-abstraction when a
> simple helper has only one caller.
>
Static functions that have only one caller are compiled inline, so we
don't have to worry about how that affects the code.

The reason these codes are encapsulated in a separate function is so
that the code reader understands that these codes are integrated
as a whole, and that we shouldn't have to move one or two of these
lines individually.

But after we get rid of erofs_fs_context, those won't be needed
anymore.
>>   
>> -	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && ctx->fsid)
>> +static int erofs_fc_get_tree(struct fs_context *fc)
>> +{
>> +	struct erofs_sb_info *sbi;
>> +
>> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>> +	if (!sbi)
>> +		return -ENOMEM;
>> +
>> +	fc->s_fs_info = sbi;
>> +	erofs_ctx_to_info(fc);
>> +
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		return get_tree_nodev(fc, erofs_fc_fill_super);
>>   
>>   	return get_tree_bdev(fc, erofs_fc_fill_super);
>> @@ -767,6 +774,7 @@ static void erofs_fc_free(struct fs_context *fc)
>>   	kfree(ctx->fsid);
>>   	kfree(ctx->domain_id);
>>   	kfree(ctx);
>> +	kfree(fc->s_fs_info);
>>   }
>>   
>>   static const struct fs_context_operations erofs_context_ops = {
>> @@ -783,6 +791,7 @@ static int erofs_init_fs_context(struct fs_context *fc)
>>   	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>   	if (!ctx)
>>   		return -ENOMEM;
>> +
>>   	ctx->devs = kzalloc(sizeof(struct erofs_dev_context), GFP_KERNEL);
>>   	if (!ctx->devs) {
>>   		kfree(ctx);
>> @@ -799,17 +808,13 @@ static int erofs_init_fs_context(struct fs_context *fc)
>>   
>>   static void erofs_kill_sb(struct super_block *sb)
>>   {
>> -	struct erofs_sb_info *sbi;
>> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (erofs_is_fscache_mode(sb))
>> +	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		kill_anon_super(sb);
>>   	else
>>   		kill_block_super(sb);
>>   
>> -	sbi = EROFS_SB(sb);
>> -	if (!sbi)
>> -		return;
>> -
>>   	erofs_free_dev_context(sbi->devs);
>>   	fs_put_dax(sbi->dax_dev, NULL);
>>   	erofs_fscache_unregister_fs(sb);
-- 
With Best Regards,
Baokun Li

