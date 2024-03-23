Return-Path: <linux-kernel+bounces-112224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C350E887710
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 05:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E26F1F22148
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670763FE4;
	Sat, 23 Mar 2024 04:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLle9KSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DA17F3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 04:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711168008; cv=none; b=VoX+O9E+GSXIi29oh6OstRjNslomw4i8bjI8aiGRLGuYiCtnOxJBpCwLj+0EoWVO4hSOOOS9T//pkZX2oUSv+KG5Mp5HlqOoENM6eOXm0pwtgS0MeJV+cpp0Ryjg7+JE8bVf4wREMUEsDvKTbX1a3ruEGj3283JtInJi7vnB2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711168008; c=relaxed/simple;
	bh=yK8dDTZSWtZlDKKXpzS7heTkO7u+N3dxFz037MPPjsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUjZgmcrFtZ2m02Ji4iMQcGEuP9ey7DIMGby7RoDEXkh+osIgVHx0rpGTbq8ohYDp8/XoHtRbyHk4NptnEhw1IoOG0BjFwDM+2cUfAhPE6y2cXfxtoYlBFJTdL+YAOkqbuGbvobCqtiRDfDrqBzx69KTloEqkTdcmiVorUFcGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLle9KSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB7C433F1;
	Sat, 23 Mar 2024 04:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711168007;
	bh=yK8dDTZSWtZlDKKXpzS7heTkO7u+N3dxFz037MPPjsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SLle9KSsmR+UuzL9V1wpIGnLAEh6nUthenpr4LTm++VcCDQ3VPOL/8KE97NgOEaxp
	 k/BF1+XW4zUT4nt+M3vneuwQjuAMGdQPxUanXr+jYRPTrdE9iSgcnn6rHb3ug5MvUv
	 nPuOpBVlMzOgfcCpThNznSTTfKiTozyX5AgF664SRCPs3Qz/pTbHwUtZsQnMJQXorn
	 1nwovNsFO4RPZkcv8ImDu6ALT4+VN/fndWa7JyfF7ogns+q27NVLMSgxRJqb2/R+kC
	 jjQUB2mxBUKQtuxVlcAaMNGZ1nVNP5GZCskD1ftXaaZyFV/MKBEuUvH8x1ewioaSkk
	 oCc5CCilLFTxw==
Message-ID: <c1fd6c09-0083-439b-a81d-0d2f39cb10d4@kernel.org>
Date: Sat, 23 Mar 2024 12:26:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate()
 for pinned files
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
References: <20240319212316.4193790-1-daeho43@gmail.com>
 <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
 <CACOAw_yAWGbx2Bx2or1OyVUUw6HSgTd=fo3e151d1JHU+Op5qQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CACOAw_yAWGbx2Bx2or1OyVUUw6HSgTd=fo3e151d1JHU+Op5qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/21 1:42, Daeho Jeong wrote:
> On Wed, Mar 20, 2024 at 2:38 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/3/20 5:23, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> In a case writing without fallocate(), we can't guarantee it's allocated
>>> in the conventional area for zoned stroage.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>> v2: covered the direct io case
>>> v3: covered the mkwrite case
>>> ---
>>>    fs/f2fs/data.c | 14 ++++++++++++--
>>>    fs/f2fs/file.c | 16 ++++++++--------
>>>    2 files changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index c21b92f18463..d3e5ab2736a6 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>
>>>        /* use out-place-update for direct IO under LFS mode */
>>>        if (map->m_may_create &&
>>> -         (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
>>> -             if (unlikely(f2fs_cp_error(sbi))) {
>>> +         (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
>>> +                      !f2fs_is_pinned_file(inode)))) {
>>> +             if (unlikely(f2fs_cp_error(sbi)) ||
>>> +                 (f2fs_is_pinned_file(inode) && is_hole &&
>>> +                  flag != F2FS_GET_BLOCK_PRE_DIO)) {
>>>                        err = -EIO;
>>>                        goto sync_out;
>>>                }
>>> @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>>                f2fs_map_lock(sbi, flag);
>>>                locked = true;
>>>        } else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
>>> +             if (f2fs_is_pinned_file(inode))
>>> +                     return -EIO;
>>>                f2fs_map_lock(sbi, flag);
>>>                locked = true;
>>>        }
>>> @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>>
>>>        if (!f2fs_lookup_read_extent_cache_block(inode, index,
>>>                                                 &dn.data_blkaddr)) {
>>> +             if (f2fs_is_pinned_file(inode)) {
>>> +                     err = -EIO;
>>> +                     goto out;
>>> +             }
>>> +
>>>                if (locked) {
>>>                        err = f2fs_reserve_block(&dn, index);
>>>                        goto out;
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 82277e95c88f..4db3b21c804b 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>        struct inode *inode = file_inode(vmf->vma->vm_file);
>>>        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>        struct dnode_of_data dn;
>>> -     bool need_alloc = true;
>>> +     bool need_alloc = !f2fs_is_pinned_file(inode);
>>
>> Will this check races w/ pinfile get|set?
> 
> Do you mean "set/clear" case? I believe "set" case is okay, since we

Yup,

> can't set if the inode already has a data block. For "clear" case, I

However, we can set pinfile on written inode in regular block device:

	if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
		ret = -EFBIG;
		goto out;
	}

Should we add the logic only if blkzoned feture is enabled?

> believe mkwrite failure is okay in racy conditions caused by clearing
> the pin flag. What do you think?

Or we can use filemap_invalidate_lock() in f2fs_ioc_set_pin_file() to
avoid the race condition?

Thanks,

> 
>>
>> Thanks,
>>
>>>        int err = 0;
>>>        vm_fault_t ret;
>>>
>>> @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>                goto out_sem;
>>>        }
>>>
>>> +     set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>        if (need_alloc) {
>>>                /* block allocation */
>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>                err = f2fs_get_block_locked(&dn, page->index);
>>> -     }
>>> -
>>> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>>> -     if (!need_alloc) {
>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
>>> +     } else {
>>>                err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>>>                f2fs_put_dnode(&dn);
>>>        }
>>> -#endif
>>> +
>>>        if (err) {
>>>                unlock_page(page);
>>>                goto out_sem;
>>> @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>>>                        return ret;
>>>        }
>>>
>>> +     /* For pinned files, it should be fallocate()-ed in advance. */
>>> +     if (f2fs_is_pinned_file(inode))
>>> +             return 0;
>>> +
>>>        /* Do not preallocate blocks that will be written partially in 4KB. */
>>>        map.m_lblk = F2FS_BLK_ALIGN(pos);
>>>        map.m_len = F2FS_BYTES_TO_BLK(pos + count);

