Return-Path: <linux-kernel+bounces-87803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D586D93D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D785C283D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D26836137;
	Fri,  1 Mar 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY/nZbu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA72BAF0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258123; cv=none; b=KLzHd7VGh0YNsHbmOYNWWzqElZPlhHzZIpu8Y+ldMfg1J++CBdQA+cG1AYX75BzMTUl8HAUQvIMqk1ChcLUoe+Lx5UvokLeXG4AVKfgFPg20AJ0m5bbtyZqIuR/M54r+dMx1y+xlh4dve6Dk5Y7v8AqbgxavCYwPv4tdwrhddxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258123; c=relaxed/simple;
	bh=cbqoixCcz2zE8+F9Pz2JkEG1qy/+t8gYH7RfdkUJYUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5ABLYWXNbb1ae0OaYUUrjQKXsPIr1eibaxcgH9OZS0OTEg00/YIlSEsEY0A3WdHZ1eZKCE4un54v68Z1fdmw2YOQIMo93KeQAuYB0YnJxD1Vd34u4U5lH+59qJNfXAXJj2kHKSmW7c5RK+yuucFemlPHgwz61bxvfcsKsOVGMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY/nZbu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC31C433C7;
	Fri,  1 Mar 2024 01:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709258122;
	bh=cbqoixCcz2zE8+F9Pz2JkEG1qy/+t8gYH7RfdkUJYUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gY/nZbu3L7l92Zt1PCeX1GhBMup6uD9QPIRva9ZiDGX97+d0l1EYQJofw1vcRB/1H
	 y9YkGZt5rxsFIbyVDuSiWwW36SDZf1wSiPIHG3H7mXbVJbDo6cfCRumFVZS56qANjF
	 UpO5U9w0NDrEMSRedjunrhhkfRHljnZu1Cf1aPSsKjBp9+7uTfST23NDCzbxjqPWj1
	 JVhyN5JackZIzxecSMsGRUVFUqTgGE4FpMaK6uVi+srfHD1E0W6R7EFGZzVMWgb/ts
	 OOyJOSMg8rElxld5nLthF613+gRap9DLo7rXD6LXOSDNz7Ca8DnNVv+7UNqayhX9nB
	 A3sqpI/zI1XJQ==
Message-ID: <3325fdb0-1f21-4ba9-919a-09fa0206f7c5@kernel.org>
Date: Fri, 1 Mar 2024 09:55:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix blkofs_end correctly in
 f2fs_migrate_blocks()
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240226013208.2389246-1-chao@kernel.org>
 <2b81aa6f-db51-4a7c-97ab-2af2c2fea056@kernel.org>
 <CACOAw_yn4m+nEGMEX8RL1xFEaZpzXvjUhUdSoo9d2EeGfzPrAA@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_yn4m+nEGMEX8RL1xFEaZpzXvjUhUdSoo9d2EeGfzPrAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/1 1:41, Daeho Jeong wrote:
> On Thu, Feb 29, 2024 at 2:11 AM Chao Yu <chao@kernel.org> wrote:
>>
>> Jaegeuk, Daeho,
>>
>> Any comments on this serials?
>>
>> Thanks,
> 
> No functional difference here, since start_blk is always aligned with
> the section address.

You're right.

> However, this is more clear in itself.

Thanks for the review!

One more thing is, I found that fallocate() on pinned file will preallocate
aligned w/ section-size which is about several hundred megabyte for ZUFS case,
since commit e1175f022911 ("f2fs: fix to align to section for fallocate() on
pinned file").

It looks not make sense, especially for logcat case which actually want to
preallocate 2MB space, so, what about reverting commit e1175f022911 and
looking for other solution to avoid GCing on fragmented pinned file.

What do you think?

Thanks,

> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> 
> Thanks,
> 
>>
>> On 2024/2/26 9:32, Chao Yu wrote:
>>> In f2fs_migrate_blocks(), when traversing blocks in last section,
>>> blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/f2fs/data.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index c21b92f18463..0c728e82d936 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3841,13 +3841,14 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>>>        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>        unsigned int blkofs;
>>>        unsigned int blk_per_sec = BLKS_PER_SEC(sbi);
>>> +     unsigned int end_blk = start_blk + blkcnt - 1;
>>>        unsigned int secidx = start_blk / blk_per_sec;
>>>        unsigned int end_sec;
>>>        int ret = 0;
>>>
>>>        if (!blkcnt)
>>>                return 0;
>>> -     end_sec = secidx + (blkcnt - 1) / blk_per_sec;
>>> +     end_sec = end_blk / blk_per_sec;
>>>
>>>        f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>        filemap_invalidate_lock(inode->i_mapping);
>>> @@ -3857,7 +3858,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>>>
>>>        for (; secidx <= end_sec; secidx++) {
>>>                unsigned int blkofs_end = secidx == end_sec ?
>>> -                     (blkcnt - 1) % blk_per_sec : blk_per_sec - 1;
>>> +                             end_blk % blk_per_sec : blk_per_sec - 1;
>>>
>>>                f2fs_down_write(&sbi->pin_sem);
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

