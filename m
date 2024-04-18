Return-Path: <linux-kernel+bounces-149540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1D8A9297
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F91F2186E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFB56455;
	Thu, 18 Apr 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Q9BadeY5"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457654BFA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419440; cv=none; b=Mf0Kdhz7s33kIvrdG0P/tyOoG/F3IbeFg2Ac7kMKYn/mtBFaQjIyt4i38p/0gDU38kR8jbKyuYhU32FJNx0Bg5mVuFpfEaXSrwOgd2YjxXzKaj2+5dTQJ9+wE7CZkUTShaXk32VhOC6dF79TIKX4miU9yo3eohQgRTXDqH6fGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419440; c=relaxed/simple;
	bh=PFyGbk56OmzNLjMtqAchKOOo908XeKp6oW+0qESPT2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+pXeCyJnfzOqaEKeGaVbR42spPEy4SiX1sAXFFZLpscVum8Wj904ojbR7hmAlsbHZNUfyNYwfIiK3bDHrUA8MiLlC3jfjlrx176U4j13GnQcEp+9Fy9EG1I4/NdP9OyCcqjhnoOkU8txWGXt4c5ZX5iqEk2/R0U2RznU9AYvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Q9BadeY5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713419433; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4eOeKenzK1gFrzCAeTlcjNO1rvtm7qAGVD0c/9ky3IQ=;
	b=Q9BadeY5Qkk88lD94CxqBI+B96T8TVdwkxAcAik++G7CcC+lR9BAk9ihhRC6t7naMhJKm6YhQjGoEbs8lKkI6lWyktpZTt5aXW6Xz2kyRPPktk6Og4HJU03c8992boiO0OP7vD53zACWUaDnBYBahi6ccKvNnXsxcEKH3uP/FCY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W4nXygh_1713419431;
Received: from 30.221.145.60(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W4nXygh_1713419431)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 13:50:32 +0800
Message-ID: <fb65c7d0-c348-409e-b977-07616d28b279@linux.alibaba.com>
Date: Thu, 18 Apr 2024 13:50:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: reliably distinguish block based and fscache
 mode
Content-Language: en-US
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com
References: <20240417065513.3409744-1-libaokun1@huawei.com>
 <71e66b02-9c2b-4981-83e1-8af72d6c0975@linux.alibaba.com>
 <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <7fdf4bff-2d3d-bdc0-5446-caa58aeca314@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/18/24 11:36 AM, Baokun Li wrote:
> On 2024/4/18 10:16, Jingbo Xu wrote:
>> Hi Baokun,
>>
>> Thanks for catching this and move forward fixing this!
> 
> Hi Jingbo，
> 
> Thanks for your review！
> 
>>
>> On 4/17/24 2:55 PM, Baokun Li wrote:
>>> When erofs_kill_sb() is called in block dev based mode, s_bdev may
>>> not have
>>> been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled, it
>>> will
>>> be mistaken for fscache mode, and then attempt to free an anon_dev
>>> that has
>>> never been allocated, triggering the following warning:
>>>
>>> ============================================
>>> ida_free called for id=0 which is not allocated.
>>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>>> Modules linked in:
>>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>>> RIP: 0010:ida_free+0x134/0x140
>>> Call Trace:
>>>   <TASK>
>>>   erofs_kill_sb+0x81/0x90
>>>   deactivate_locked_super+0x35/0x80
>>>   get_tree_bdev+0x136/0x1e0
>>>   vfs_get_tree+0x2c/0xf0
>>>   do_new_mount+0x190/0x2f0
>>>   [...]
>>> ============================================
>>>
>>> Instead of allocating the erofs_sb_info in fill_super() allocate it
>>> during erofs_get_tree() and ensure that erofs can always have the info
>>> available during erofs_kill_sb().
>>
>> I'm not sure if allocating erofs_sb_info in erofs_init_fs_context() will
>> be better, as I see some filesystems (e.g. autofs) do this way.  Maybe
>> another potential advantage of doing this way is that erofs_fs_context
>> is not needed anymore and we can use sbi directly.
> Yes, except for some extra memory usage when remounting,
> this idea sounds great. Let me send a version of v3 to get rid
> of erofs_fs_context.

I'm not sure if Gao Xaing also prefers this.  I think it would be better
to wait and listen for his thoughts before we sending v3.

>>
>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> ---
>>> Changes since v1:
>>>    Allocate and initialise fc->s_fs_info in erofs_fc_get_tree()
>>> instead of
>>>    modifying fc->sb_flags.
>>>
>>> V1:
>>> https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
>>>
>>>   fs/erofs/super.c | 51 ++++++++++++++++++++++++++----------------------
>>>   1 file changed, 28 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index b21bd8f78dc1..4104280be2ea 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -581,8 +581,7 @@ static const struct export_operations
>>> erofs_export_ops = {
>>>   static int erofs_fc_fill_super(struct super_block *sb, struct
>>> fs_context *fc)
>>>   {
>>>       struct inode *inode;
>>> -    struct erofs_sb_info *sbi;
>>> -    struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = EROFS_SB(sb);
>>>       int err;
>>>         sb->s_magic = EROFS_SUPER_MAGIC;
>>> @@ -590,19 +589,6 @@ static int erofs_fc_fill_super(struct
>>> super_block *sb, struct fs_context *fc)
>>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>>       sb->s_op = &erofs_sops;
>>>   -    sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>>> -    if (!sbi)
>>> -        return -ENOMEM;
>>> -
>>> -    sb->s_fs_info = sbi;
>>> -    sbi->opt = ctx->opt;
>>> -    sbi->devs = ctx->devs;
>>> -    ctx->devs = NULL;
>>> -    sbi->fsid = ctx->fsid;
>>> -    ctx->fsid = NULL;
>>> -    sbi->domain_id = ctx->domain_id;
>>> -    ctx->domain_id = NULL;
>>> -
>>>       sbi->blkszbits = PAGE_SHIFT;
>>>       if (erofs_is_fscache_mode(sb)) {
>>>           sb->s_blocksize = PAGE_SIZE;
>>> @@ -704,11 +690,32 @@ static int erofs_fc_fill_super(struct
>>> super_block *sb, struct fs_context *fc)
>>>       return 0;
>>>   }
>>>   -static int erofs_fc_get_tree(struct fs_context *fc)
>>> +static void erofs_ctx_to_info(struct fs_context *fc)
>>>   {
>>>       struct erofs_fs_context *ctx = fc->fs_private;
>>> +    struct erofs_sb_info *sbi = fc->s_fs_info;
>>> +
>>> +    sbi->opt = ctx->opt;
>>> +    sbi->devs = ctx->devs;
>>> +    ctx->devs = NULL;
>>> +    sbi->fsid = ctx->fsid;
>>> +    ctx->fsid = NULL;
>>> +    sbi->domain_id = ctx->domain_id;
>>> +    ctx->domain_id = NULL;
>>> +}
>> I'm not sure if abstracting this logic into a seperate helper really
>> helps understanding the code as the logic itself is quite simple and
>> easy to be understood. Usually it's a hint of over-abstraction when a
>> simple helper has only one caller.
>>
> Static functions that have only one caller are compiled inline, so we
> don't have to worry about how that affects the code.
> 
> The reason these codes are encapsulated in a separate function is so
> that the code reader understands that these codes are integrated
> as a whole, and that we shouldn't have to move one or two of these
> lines individually.
> 
> But after we get rid of erofs_fs_context, those won't be needed
> anymore.

Yeah, I understand. It's only coding style concerns.



-- 
Thanks,
Jingbo

