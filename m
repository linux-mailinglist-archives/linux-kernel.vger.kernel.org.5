Return-Path: <linux-kernel+bounces-118345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E588B8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC74A1F614EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235B129A7C;
	Tue, 26 Mar 2024 03:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhxLN1Id"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B8128801
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424377; cv=none; b=sBrGes4ngiBHY8PyWTfmMsnHsyYJbftTbDiEVWhzOknGMuC5BK0Ny3YcTiyIk2k9UiqYuAoRpOHAcu+A+xOze9NTM1BQtBQ+M3lMqIHQ6bdClkt5KKoi33FqyyZzwyck2CFHVjyOPLKznDHbtMKYauYm8/9zHDPG5U5iJDWZLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424377; c=relaxed/simple;
	bh=P3vreY2sz09wZD7BtqL79mQRFOWcQ2qQmdy79Frd0Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRsOjUgvLg+OrbzU1tSTFUHLEUQpiq3dqfn9VNTsm7MTqFE+UpQu0fhARnbIXhykyBL9aqHlvIP7lK3C+tYHmKzJqez8ld0ZPd6yOBTRXwYBJ+ceJWszpsEaLhKuhboZ1D/8gRi7dVUDfVH9Me60jJyg+bM8Ho/PFDH8Kum+Lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhxLN1Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBADC43390;
	Tue, 26 Mar 2024 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711424377;
	bh=P3vreY2sz09wZD7BtqL79mQRFOWcQ2qQmdy79Frd0Q4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IhxLN1IdkHiZ64LTHLbvCtomJaVRZtRfO2u0R5NhiFGnaaCNZchQvv+HLwhXo9j72
	 qMZWHzmrfjiUQz/+AAsc0jsYdhUbCNn0P97P749R1l6+TxAIRgWiykAw9dZDDk5Zwk
	 hCLzQKIKQ3DnHgsFPtW8vhqvLjm3AU0cy9wdQj17n2LpTJTXjTnOsUpp1iQWYot0Ib
	 I+ISYRzTx68ay9l8zMbVNQ97VQpF/lHHPM9clxQ0Nin44os951PUuYDOQwOIRLSulZ
	 iUnT23G/MyVu4hpKPdmrdp+pQWSjwVX8Na8bu5vizMSIzaVvU2Y4/hp/c2AqQbgZRt
	 SEPxYmLBTbHnw==
Message-ID: <30419139-6fdd-48df-b32a-9db7575cebb8@kernel.org>
Date: Tue, 26 Mar 2024 11:39:33 +0800
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
 <c1fd6c09-0083-439b-a81d-0d2f39cb10d4@kernel.org>
 <CACOAw_xejyoA9f2x9J0Z-MgbmrHAPYeAmpz8Lf1GfLDs-yHh5w@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_xejyoA9f2x9J0Z-MgbmrHAPYeAmpz8Lf1GfLDs-yHh5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/25 23:02, Daeho Jeong wrote:
> On Fri, Mar 22, 2024 at 9:26 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/3/21 1:42, Daeho Jeong wrote:
>>> On Wed, Mar 20, 2024 at 2:38 AM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/3/20 5:23, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> In a case writing without fallocate(), we can't guarantee it's allocated
>>>>> in the conventional area for zoned stroage.
>>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>> v2: covered the direct io case
>>>>> v3: covered the mkwrite case
>>>>> ---
>>>>>     fs/f2fs/data.c | 14 ++++++++++++--
>>>>>     fs/f2fs/file.c | 16 ++++++++--------
>>>>>     2 files changed, 20 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index c21b92f18463..d3e5ab2736a6 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>>>
>>>>>         /* use out-place-update for direct IO under LFS mode */
>>>>>         if (map->m_may_create &&
>>>>> -         (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
>>>>> -             if (unlikely(f2fs_cp_error(sbi))) {
>>>>> +         (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
>>>>> +                      !f2fs_is_pinned_file(inode)))) {
>>>>> +             if (unlikely(f2fs_cp_error(sbi)) ||
>>>>> +                 (f2fs_is_pinned_file(inode) && is_hole &&
>>>>> +                  flag != F2FS_GET_BLOCK_PRE_DIO)) {
>>>>>                         err = -EIO;
>>>>>                         goto sync_out;
>>>>>                 }
>>>>> @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>>>>                 f2fs_map_lock(sbi, flag);
>>>>>                 locked = true;
>>>>>         } else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
>>>>> +             if (f2fs_is_pinned_file(inode))
>>>>> +                     return -EIO;
>>>>>                 f2fs_map_lock(sbi, flag);
>>>>>                 locked = true;
>>>>>         }
>>>>> @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>>>>
>>>>>         if (!f2fs_lookup_read_extent_cache_block(inode, index,
>>>>>                                                  &dn.data_blkaddr)) {
>>>>> +             if (f2fs_is_pinned_file(inode)) {
>>>>> +                     err = -EIO;
>>>>> +                     goto out;
>>>>> +             }
>>>>> +
>>>>>                 if (locked) {
>>>>>                         err = f2fs_reserve_block(&dn, index);
>>>>>                         goto out;
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 82277e95c88f..4db3b21c804b 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>>>         struct inode *inode = file_inode(vmf->vma->vm_file);
>>>>>         struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>         struct dnode_of_data dn;
>>>>> -     bool need_alloc = true;
>>>>> +     bool need_alloc = !f2fs_is_pinned_file(inode);
>>>>
>>>> Will this check races w/ pinfile get|set?
>>>
>>> Do you mean "set/clear" case? I believe "set" case is okay, since we
>>
>> Yup,
>>
>>> can't set if the inode already has a data block. For "clear" case, I
>>
>> However, we can set pinfile on written inode in regular block device:
> 
> You're right. I missed it. Maybe I think we should keep the concept
> consistent across devices regardless of zoned storage support. How
> about preventing file pinning for already written inodes across all
> device types? I am changing the pinfile concept by allowing the users

I'm okay with that, or we can tries to migrate data block of target file
from seq-zone to conv-zone or regular-device before setting it w/ pin flag...

Thanks,

> to write on only fallocate()-ed space.
> 
>>
>>          if (f2fs_sb_has_blkzoned(sbi) && F2FS_HAS_BLOCKS(inode)) {
>>                  ret = -EFBIG;
>>                  goto out;
>>          }
>>
>> Should we add the logic only if blkzoned feture is enabled?
>>
>>> believe mkwrite failure is okay in racy conditions caused by clearing
>>> the pin flag. What do you think?
>>
>> Or we can use filemap_invalidate_lock() in f2fs_ioc_set_pin_file() to
>> avoid the race condition?
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>         int err = 0;
>>>>>         vm_fault_t ret;
>>>>>
>>>>> @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>>>>                 goto out_sem;
>>>>>         }
>>>>>
>>>>> +     set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>>>         if (need_alloc) {
>>>>>                 /* block allocation */
>>>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>>>                 err = f2fs_get_block_locked(&dn, page->index);
>>>>> -     }
>>>>> -
>>>>> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>>>>> -     if (!need_alloc) {
>>>>> -             set_new_dnode(&dn, inode, NULL, NULL, 0);
>>>>> +     } else {
>>>>>                 err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>>>>>                 f2fs_put_dnode(&dn);
>>>>>         }
>>>>> -#endif
>>>>> +
>>>>>         if (err) {
>>>>>                 unlock_page(page);
>>>>>                 goto out_sem;
>>>>> @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>>>>>                         return ret;
>>>>>         }
>>>>>
>>>>> +     /* For pinned files, it should be fallocate()-ed in advance. */
>>>>> +     if (f2fs_is_pinned_file(inode))
>>>>> +             return 0;
>>>>> +
>>>>>         /* Do not preallocate blocks that will be written partially in 4KB. */
>>>>>         map.m_lblk = F2FS_BLK_ALIGN(pos);
>>>>>         map.m_len = F2FS_BYTES_TO_BLK(pos + count);

