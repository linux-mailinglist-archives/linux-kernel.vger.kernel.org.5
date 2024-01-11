Return-Path: <linux-kernel+bounces-22925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF46382A589
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781C828866C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BF7EA;
	Thu, 11 Jan 2024 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcJQ9/Ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA816394
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BC2C433C7;
	Thu, 11 Jan 2024 01:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704936388;
	bh=5R41srxwELgpcVkdWas/ZAU8OawuQEn8G6bkikiGVnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DcJQ9/Ckit2VZ2a96ohX0Wrz0cYJKkmSK8D2FMQVNEVyPeg7YzVhsIIKj+xIA/l3z
	 ljREURXvQzyKmC3YPNMR3NzDhlOjLYkszJMCH5N5QVJmng1zJsu/3WLly5GIVPsRbt
	 Syd+ZZRjXw1TxolfmgVKcrHbaRh72yCnq1IJ+TSqcHIjSfckOruoRRc5ukbsoMFFAU
	 3Uan/l8HaxyiBvcyJuw77NRxQdNqC1j9rGN1q9GUQIImFX2epfyMGXxFCA/2t++WI+
	 zt1PWYVEa10y3Pr+kCDazn6qLlEFchgDhkfq36xyxzPBhkKs1Uvluy4kxHQbWK1fZS
	 fC7xRKLaMP91w==
Message-ID: <dcefc352-d528-41e3-bc7a-5cb388f43240@kernel.org>
Date: Thu, 11 Jan 2024 09:26:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v3 1/6] f2fs: compress: fix to guarantee
 persisting compressed blocks by CP
To: Daeho Jeong <daeho43@gmail.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231228143152.1543509-1-chao@kernel.org>
 <CACOAw_xXGUt=2JJgq5yfW5ZG7EfZMm1iNTVxvfA9FoJVDwbH_A@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CACOAw_xXGUt=2JJgq5yfW5ZG7EfZMm1iNTVxvfA9FoJVDwbH_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/11 8:55, Daeho Jeong wrote:
> On Thu, Dec 28, 2023 at 6:33 AM Chao Yu <chao@kernel.org> wrote:
>>
>> If data block in compressed cluster is not persisted with metadata
>> during checkpoint, after SPOR, the data may be corrupted, let's
>> guarantee to write compressed page by checkpoint.
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v3:
>> - treat compressed page as CP guaranteed data explictly.
>>   fs/f2fs/compress.c |  4 +++-
>>   fs/f2fs/data.c     | 17 +++++++++--------
>>   fs/f2fs/f2fs.h     |  4 +++-
>>   3 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index c5a4364c4482..9940b7886e5d 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1418,6 +1418,8 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
>>          struct f2fs_sb_info *sbi = bio->bi_private;
>>          struct compress_io_ctx *cic =
>>                          (struct compress_io_ctx *)page_private(page);
>> +       enum count_type type = WB_DATA_TYPE(page,
>> +                               f2fs_is_compressed_page(page));
>>          int i;
>>
>>          if (unlikely(bio->bi_status))
>> @@ -1425,7 +1427,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
>>
>>          f2fs_compress_free_page(page);
>>
>> -       dec_page_count(sbi, F2FS_WB_DATA);
>> +       dec_page_count(sbi, type);
>>
>>          if (atomic_dec_return(&cic->pending_pages))
>>                  return;
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index dce8defdf4c7..81f9e2cc49e2 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
>>          bioset_exit(&f2fs_bioset);
>>   }
>>
>> -static bool __is_cp_guaranteed(struct page *page)
>> +bool f2fs_is_cp_guaranteed(struct page *page)
>>   {
>>          struct address_space *mapping = page->mapping;
>>          struct inode *inode;
>> @@ -65,8 +65,6 @@ static bool __is_cp_guaranteed(struct page *page)
>>                          S_ISDIR(inode->i_mode))
>>                  return true;
>>
>> -       if (f2fs_is_compressed_page(page))
>> -               return false;
> 
> Out of curiosity, why don't we simply change the above to "return true"?

Daeho,

I used the implementation, please check v1 and related comments
from Jaegeuk and me, let me know if that was not clear enough. :)

https://lore.kernel.org/linux-f2fs-devel/aae654e7-8a7e-478d-9f5a-65807a0e0343@kernel.org/

> 
>>          if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
>>                          page_private_gcing(page))
>>                  return true;
>> @@ -338,7 +336,7 @@ static void f2fs_write_end_io(struct bio *bio)
>>
>>          bio_for_each_segment_all(bvec, bio, iter_all) {
>>                  struct page *page = bvec->bv_page;
>> -               enum count_type type = WB_DATA_TYPE(page);
>> +               enum count_type type = WB_DATA_TYPE(page, false);
>>
>>                  if (page_private_dummy(page)) {
>>                          clear_page_private_dummy(page);
>> @@ -762,7 +760,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
>>
>>          inc_page_count(fio->sbi, is_read_io(fio->op) ?
>> -                       __read_io_type(page) : WB_DATA_TYPE(fio->page));
>> +                       __read_io_type(page) : WB_DATA_TYPE(fio->page, false));
>>
>>          if (is_read_io(bio_op(bio)))
>>                  f2fs_submit_read_bio(fio->sbi, bio, fio->type);
>> @@ -973,7 +971,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>>          if (fio->io_wbc)
>>                  wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
>>
>> -       inc_page_count(fio->sbi, WB_DATA_TYPE(page));
>> +       inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
>>
>>          *fio->last_block = fio->new_blkaddr;
>>          *fio->bio = bio;
>> @@ -1007,6 +1005,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>          enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
>>          struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>>          struct page *bio_page;
>> +       enum count_type type;
>>
>>          f2fs_bug_on(sbi, is_read_io(fio->op));
>>
>> @@ -1046,7 +1045,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>          /* set submitted = true as a return value */
>>          fio->submitted = 1;
>>
>> -       inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>> +       type = WB_DATA_TYPE(bio_page, fio->compressed_page);
>> +       inc_page_count(sbi, type);
>>
>>          if (io->bio &&
>>              (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>> @@ -1059,7 +1059,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>                  if (F2FS_IO_ALIGNED(sbi) &&
>>                                  (fio->type == DATA || fio->type == NODE) &&
>>                                  fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
>> -                       dec_page_count(sbi, WB_DATA_TYPE(bio_page));
>> +                       dec_page_count(sbi, WB_DATA_TYPE(bio_page,
>> +                                               fio->compressed_page));
>>                          fio->retry = 1;
>>                          goto skip;
>>                  }
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 65294e3b0bef..50f3d546ded8 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1080,7 +1080,8 @@ struct f2fs_sm_info {
>>    * f2fs monitors the number of several block types such as on-writeback,
>>    * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
>>    */
>> -#define WB_DATA_TYPE(p)        (__is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
>> +#define WB_DATA_TYPE(p, f)                     \
>> +       (f || f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
>>   enum count_type {
>>          F2FS_DIRTY_DENTS,
>>          F2FS_DIRTY_DATA,
>> @@ -3804,6 +3805,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi);
>>    */
>>   int __init f2fs_init_bioset(void);
>>   void f2fs_destroy_bioset(void);
>> +bool f2fs_is_cp_guaranteed(struct page *page);
>>   int f2fs_init_bio_entry_cache(void);
>>   void f2fs_destroy_bio_entry_cache(void);
>>   void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

