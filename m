Return-Path: <linux-kernel+bounces-71488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8185A619
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357FD282CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76149376EC;
	Mon, 19 Feb 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCHAvyVl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8428374F5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353376; cv=none; b=U5XRwxbOf/367HtMzGBj3NhuoSONPCIxVjUDBu2dzpBpIuL9j+BTYVbiMSdyOq9xBxqtij53H7M8vxbLNB19pksJ9vADneUR4+vj9K1kRQAEc3XGVhofW4936VGgJdWDqbDTgqun2xAQPBGh/gFU71gSJBNYZXFW/9HWpUzUHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353376; c=relaxed/simple;
	bh=onxy2/zJpPN9M2EouGCzMIOMSF+KmNAf0ohiTariuLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6kr4KhOPRUnOqFPeo5XXssr2n1qdbJU+wNHUCxaYHI3SH3uZ9j6rUCTp4dADxXfrkqGHm6u2wVngWfuD03fJ17h69WTX2evxydnj0+p8NBZicxb6DZOG5we5peNd2ueI53d/3ee+4NGe5eeLnRNZQM12TNembNUThg6rE4QRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCHAvyVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0F2C43390;
	Mon, 19 Feb 2024 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708353376;
	bh=onxy2/zJpPN9M2EouGCzMIOMSF+KmNAf0ohiTariuLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NCHAvyVlP8gj+gbxdh4MA8CYEkaaHbAEMK7Cn6hdOaRViyuaAkQ3WETsUk1exlotx
	 BslpPFc5J4NL7HkoWowyNS6V1uzgMH9DcOlNtem1kUd8CbpJy4mBO3jgTLNUZj/JKu
	 vXB6QPoNNdEfShj8BEByhpcVTyyScyw8s8fvReQA2sv97IXxNuHpAdnRcDDjY4+lPN
	 unuCAoEr/57RV2MfoU1XUu+4fesVFMyI/C3GQl58udcDb2/9VbawtbhWdGokw3J8fF
	 NS1sMZjNhmS/aGn8q7Cq248zG8G4w8aKHdXBzyXWrOlGxALIuw/VpVTm8VldwQZoX6
	 HhRvNI7eEP08w==
Message-ID: <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
Date: Mon, 19 Feb 2024 22:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org>
 <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
 <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/19 19:19, Zhiguo Niu wrote:
> Dear Chao
> 
> On Mon, Feb 19, 2024 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/2/6 11:32, Jaegeuk Kim wrote:
>>> On 02/05, Chao Yu wrote:
>>>> On 2024/2/5 11:30, Zhiguo Niu wrote:
>>>>> There are some cases of f2fs_is_valid_blkaddr not handled as
>>>>> ERROR_INVALID_BLKADDR,so unify the error handling about all of
>>>>> f2fs_is_valid_blkaddr.
>>>>>
>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>> ---
>>>>> changes of v7: update patch according to sync with Chao
>>>>>      -restore some code to original
>>>>>      -modify err handle of __is_bitmap_valid for covering all cases
>>>>> changes of v6: improve patch according to Chao's suggestions
>>>>>      -restore dump_stack to original position
>>>>>      -adjuest code sequence of __is_bitmap_check_valid
>>>>> changes of v5: improve patch according to Jaegeuk's suggestiongs
>>>>>      -restore return value of some f2fs_is_valid_blkaddr error case to original
>>>>>      -move cp_err checking to outermost for unified processing
>>>>>      -return true directly for case (type=DATA_GENERIC_ENHANCE_READ) in
>>>>>       __is_bitmap_valid to avoid meaningless flow
>>>>>      -rename __is_bitmap_valid to __is_bitmap_check_valid for avoiding ambiguity
>>>>>       and handling its return value in the caller uniformly, also cooperate
>>>>>       switch checking true to false for error case of
>>>>>       f2fs_is_valid_blkaddr(type=DATA_GENERIC_ENHANCE_UPDATE) in do_recover_data
>>>>>       for more readable
>>>>> changes of v4: update according to the latest code
>>>>> changes of v3:
>>>>>      -rebase patch to dev-test
>>>>>      -correct return value for some f2fs_is_valid_blkaddr error case
>>>>> changes of v2: improve patch according Chao's suggestions.
>>>>> ---
>>>>> ---
>>>>>     fs/f2fs/checkpoint.c   | 33 ++++++++++++++++++---------------
>>>>>     fs/f2fs/data.c         | 22 +++-------------------
>>>>>     fs/f2fs/extent_cache.c |  5 +----
>>>>>     fs/f2fs/file.c         | 16 +++-------------
>>>>>     fs/f2fs/gc.c           |  2 --
>>>>>     fs/f2fs/recovery.c     |  4 ----
>>>>>     fs/f2fs/segment.c      |  2 --
>>>>>     7 files changed, 25 insertions(+), 59 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>> index b85820e..3335619 100644
>>>>> --- a/fs/f2fs/checkpoint.c
>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>> @@ -154,46 +154,43 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>>>>      if (unlikely(f2fs_cp_error(sbi)))
>>>>>              return exist;
>>>>> -   if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
>>>>> -           f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>>> -                    blkaddr, exist);
>>>>> -           set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>> -           return exist;
>>>>> -   }
>>>>> -
>>>>> -   if (!exist && type == DATA_GENERIC_ENHANCE) {
>>>>> +   if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
>>>>> +           (!exist && type == DATA_GENERIC_ENHANCE)) {
>>>>>              f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>>>>>                       blkaddr, exist);
>>>>>              set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>              dump_stack();
>>>>>      }
>>>>> +
>>>>
>>>> No need to add one blank line.
>>>>
>>>> Otherwise, it looks good to me.
>>>>
>>>> Reviewed-by: Chao Yu <chao@kernel.org>
>>>>
>>>> Thanks,
>>>>
>>>>>      return exist;
>>>>>     }
>>>>>     static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>>                                      block_t blkaddr, int type)
>>>>>     {
>>>>> +   bool valid = false;
>>>>> +
>>>>>      switch (type) {
>>>>>      case META_NAT:
>>>>>              break;
>>>>>      case META_SIT:
>>>>>              if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              break;
>>>>>      case META_SSA:
>>>>>              if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
>>>>>                      blkaddr < SM_I(sbi)->ssa_blkaddr))
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              break;
>>>>>      case META_CP:
>>>>>              if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
>>>>>                      blkaddr < __start_cp_addr(sbi)))
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              break;
>>>>>      case META_POR:
>>>>>              if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>>>>>                      blkaddr < MAIN_BLKADDR(sbi)))
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              break;
>>>>>      case DATA_GENERIC:
>>>>>      case DATA_GENERIC_ENHANCE:
>>>>> @@ -210,21 +207,27 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>>                                blkaddr);
>>>>>                      set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>                      dump_stack();
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              } else {
>>>>> -                   return __is_bitmap_valid(sbi, blkaddr, type);
>>>>> +                   valid = __is_bitmap_valid(sbi, blkaddr, type);
>>>>> +                   if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
>>>>> +                           (valid && type == DATA_GENERIC_ENHANCE_UPDATE))
>>>>> +                           goto err;
>>>
>>> Please think about how to optimize this, which is really ugly now.
>>
>> How about this?
>>
>> ---
>>    fs/f2fs/checkpoint.c | 16 +++++++++-------
>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 246b2a063cfb..5a6ac6f26cfe 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -135,7 +135,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
>>    }
>>
>>    static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>> -                                                       int type)
>> +                                               int type, bool *record_error)
>>    {
>>          struct seg_entry *se;
>>          unsigned int segno, offset;
>> @@ -160,6 +160,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>                           blkaddr, exist);
>>                  set_sbi_flag(sbi, SBI_NEED_FSCK);
>>                  dump_stack();
>> +               *record_error = true;
>>          }
>>
>>          return exist;
>> @@ -168,8 +169,6 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>    static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>                                          block_t blkaddr, int type)
>>    {
>> -       bool valid = false;
>> -
>>          switch (type) {
>>          case META_NAT:
>>                  break;
>> @@ -209,10 +208,13 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>                          dump_stack();
>>                          goto err;
>>                  } else {
>> -                       valid = __is_bitmap_valid(sbi, blkaddr, type);
>> -                       if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
>> -                               (valid && type == DATA_GENERIC_ENHANCE_UPDATE))
>> +                       bool valid, record_error = false;
>> +
>> +                       valid = __is_bitmap_valid(sbi, blkaddr, type,
>> +                                                       &record_error);
>> +                       if (!valid || record_error)
>>                                  goto err;
>> +                       return valid;
>>                  }
>>                  break;
>>          case META_GENERIC:
>> @@ -227,7 +229,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>          return true;
>>    err:
>>          f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>> -       return valid;
>> +       return false;
> for case:   (type == DATA_GENERIC_ENHANCE_UPDATE and bitmap check valid）,
> true should be returned, but here return false,  it is not  as expected, right?

Yes, let me revise soon. :)

Thanks,

>>    }
>>
>>    bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>> --
>> 2.40.1
>>
>>
>>
>>>
>>>>>              }
>>>>>              break;
>>>>>      case META_GENERIC:
>>>>>              if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
>>>>>                      blkaddr >= MAIN_BLKADDR(sbi)))
>>>>> -                   return false;
>>>>> +                   goto err;
>>>>>              break;
>>>>>      default:
>>>>>              BUG();
>>>>>      }
>>>>>      return true;
>>>>> +err:
>>>>> +   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>> +   return valid;
>>>>>     }
>>>>>     bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 05158f8..300f9ae 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>>>>      if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>>>>>                      fio->is_por ? META_POR : (__is_meta_io(fio) ?
>>>>> -                   META_GENERIC : DATA_GENERIC_ENHANCE))) {
>>>>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>>>>> +                   META_GENERIC : DATA_GENERIC_ENHANCE)))
>>>>>              return -EFSCORRUPTED;
>>>>> -   }
>>>>>      trace_f2fs_submit_page_bio(page, fio);
>>>>> @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>>>>>                      fio->encrypted_page : fio->page;
>>>>>      if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>>>>> -                   __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)) {
>>>>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>>>>> +                   __is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>>>>>              return -EFSCORRUPTED;
>>>>> -   }
>>>>>      trace_f2fs_submit_page_bio(page, fio);
>>>>> @@ -1286,8 +1282,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>>>>>              if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
>>>>>                                              DATA_GENERIC_ENHANCE_READ)) {
>>>>>                      err = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(F2FS_I_SB(inode),
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>>                      goto put_err;
>>>>>              }
>>>>>              goto got_it;
>>>>> @@ -1313,8 +1307,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>>>>>                                              dn.data_blkaddr,
>>>>>                                              DATA_GENERIC_ENHANCE)) {
>>>>>              err = -EFSCORRUPTED;
>>>>> -           f2fs_handle_error(F2FS_I_SB(inode),
>>>>> -                                   ERROR_INVALID_BLKADDR);
>>>>>              goto put_err;
>>>>>      }
>>>>>     got_it:
>>>>> @@ -1642,7 +1634,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>>>>>      if (!is_hole &&
>>>>>          !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
>>>>>              err = -EFSCORRUPTED;
>>>>> -           f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>              goto sync_out;
>>>>>      }
>>>>> @@ -2166,8 +2157,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
>>>>>              if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
>>>>>                                              DATA_GENERIC_ENHANCE_READ)) {
>>>>>                      ret = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(F2FS_I_SB(inode),
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>>                      goto out;
>>>>>              }
>>>>>      } else {
>>>>> @@ -2707,11 +2696,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>>>>          f2fs_lookup_read_extent_cache_block(inode, page->index,
>>>>>                                              &fio->old_blkaddr)) {
>>>>>              if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>>>>> -                                           DATA_GENERIC_ENHANCE)) {
>>>>> -                   f2fs_handle_error(fio->sbi,
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>> +                                           DATA_GENERIC_ENHANCE))
>>>>>                      return -EFSCORRUPTED;
>>>>> -           }
>>>>>              ipu_force = true;
>>>>>              fio->need_lock = LOCK_DONE;
>>>>> @@ -2739,7 +2725,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>>>>>              !f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>>>>>                                              DATA_GENERIC_ENHANCE)) {
>>>>>              err = -EFSCORRUPTED;
>>>>> -           f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>>>>>              goto out_writepage;
>>>>>      }
>>>>> @@ -3706,7 +3691,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>>>>>              if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>>>>>                              DATA_GENERIC_ENHANCE_READ)) {
>>>>>                      err = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      goto fail;
>>>>>              }
>>>>>              err = f2fs_submit_page_read(use_cow ?
>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>> index ad8dfac7..48048fa 100644
>>>>> --- a/fs/f2fs/extent_cache.c
>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>> @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
>>>>>      if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>>>>>          !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>>>>>                                      DATA_GENERIC_ENHANCE)) {
>>>>> -           set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>              f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>>>>>                        __func__, inode->i_ino,
>>>>>                        ei->blk, ei->fofs, ei->len);
>>>>> @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>>>>>              goto out;
>>>>>      if (__is_valid_data_blkaddr(blkaddr) &&
>>>>> -       !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
>>>>> -           f2fs_bug_on(sbi, 1);
>>>>> +       !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
>>>>>              return -EINVAL;
>>>>> -   }
>>>>>     out:
>>>>>      /*
>>>>>       * init block age with zero, this can happen when the block age extent
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 25b119cf..23cd6a1 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>>>>>                      if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
>>>>>                              continue;
>>>>>                      if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
>>>>> -                                           DATA_GENERIC_ENHANCE)) {
>>>>> -                           f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>> +                                           DATA_GENERIC_ENHANCE))
>>>>>                              continue;
>>>>> -                   }
>>>>>                      if (compressed_cluster)
>>>>>                              valid_blocks++;
>>>>>              }
>>>>> @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
>>>>>                      !f2fs_is_valid_blkaddr(sbi, *blkaddr,
>>>>>                                      DATA_GENERIC_ENHANCE)) {
>>>>>                      f2fs_put_dnode(&dn);
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      return -EFSCORRUPTED;
>>>>>              }
>>>>> @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
>>>>>              if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
>>>>>                                      DATA_GENERIC_ENHANCE)) {
>>>>>                      ret = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      break;
>>>>>              }
>>>>> @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>>>>>              if (!__is_valid_data_blkaddr(blkaddr))
>>>>>                      continue;
>>>>>              if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
>>>>> -                                   DATA_GENERIC_ENHANCE))) {
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>> +                                   DATA_GENERIC_ENHANCE)))
>>>>>                      return -EFSCORRUPTED;
>>>>> -           }
>>>>>      }
>>>>>      while (count) {
>>>>> @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>>>>>              if (!__is_valid_data_blkaddr(blkaddr))
>>>>>                      continue;
>>>>>              if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
>>>>> -                                   DATA_GENERIC_ENHANCE))) {
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>> +                                   DATA_GENERIC_ENHANCE)))
>>>>>                      return -EFSCORRUPTED;
>>>>> -           }
>>>>>      }
>>>>>      while (count) {
>>>>> @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>>>>                                              DATA_GENERIC_ENHANCE)) {
>>>>>                              ret = -EFSCORRUPTED;
>>>>>                              f2fs_put_dnode(&dn);
>>>>> -                           f2fs_handle_error(sbi,
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>>                              goto out;
>>>>>                      }
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index a079eeb..30e93d8 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>>>>              if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>>>>>                                              DATA_GENERIC_ENHANCE_READ))) {
>>>>>                      err = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      goto put_page;
>>>>>              }
>>>>>              goto got_it;
>>>>> @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>>>>      if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>>>>>                                              DATA_GENERIC_ENHANCE))) {
>>>>>              err = -EFSCORRUPTED;
>>>>> -           f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>              goto put_page;
>>>>>      }
>>>>>     got_it:
>>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>>> index aad1d1a..289c0bf 100644
>>>>> --- a/fs/f2fs/recovery.c
>>>>> +++ b/fs/f2fs/recovery.c
>>>>> @@ -693,14 +693,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>>              if (__is_valid_data_blkaddr(src) &&
>>>>>                      !f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
>>>>>                      err = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      goto err;
>>>>>              }
>>>>>              if (__is_valid_data_blkaddr(dest) &&
>>>>>                      !f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>>>>>                      err = -EFSCORRUPTED;
>>>>> -                   f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>>>                      goto err;
>>>>>              }
>>>>> @@ -755,8 +753,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>>                              f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
>>>>>                                      dest, inode->i_ino, dn.ofs_in_node);
>>>>>                              err = -EFSCORRUPTED;
>>>>> -                           f2fs_handle_error(sbi,
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>>                              goto err;
>>>>>                      }
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 7901ede..ad6511f 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>>>>>                                      DATA_GENERIC_ENHANCE)) {
>>>>>                              f2fs_put_dnode(&dn);
>>>>>                              ret = -EFSCORRUPTED;
>>>>> -                           f2fs_handle_error(sbi,
>>>>> -                                           ERROR_INVALID_BLKADDR);
>>>>>                              goto out;
>>>>>                      }

