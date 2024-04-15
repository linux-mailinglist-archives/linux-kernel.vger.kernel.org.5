Return-Path: <linux-kernel+bounces-145314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753E78A528E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5191C229C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD577442E;
	Mon, 15 Apr 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzC6Nuab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799B71B32
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189710; cv=none; b=nDJIrQ4rvnW3yYLXnJS4jpZmqUv2llPyPiND9XV5NlYSSd7Zh7ZJovNT3TijT5GdVxyNiQQUqpf9s8fG71zTMiC5WAp602lAFHM2YkiN2T2ZiBTPC7UG/qzFkP5YZbUc49Ias/d9CFOrcniepISpc8Mqzyi02zyAYsf+GuvZ4DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189710; c=relaxed/simple;
	bh=s4rqQTIWqE6+TGFrg42uZ+A8hJMHcbsNSDEavYd7P5E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ivt7bafL5a3ODVTijXq3PySMLF13h+q1b9O5zH9P33v9Pz6J0dvLhs5EIHv8/MoIWxKmScyl9wjwZqLiJ6huVOV4V0rHWBrqfTtkNRatxHuBEulzkfgnzyTvvICMjPZh73apZLEj1GHtJn/d/zFKzaqRTrsWls0e1KUbvRwlaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzC6Nuab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E556C113CC;
	Mon, 15 Apr 2024 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713189709;
	bh=s4rqQTIWqE6+TGFrg42uZ+A8hJMHcbsNSDEavYd7P5E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BzC6NuabkkujADKC2gAd3He3LDqZOn6trDxp+HzcCTuMly/kSlnJwQcKgyYchxQGa
	 8OfyUzl1Wg0z+ai17m05sOJ5W0F6SiirGV1P/IXpGmGTQwqLrY7uF/B50OBlk39xvd
	 Sv0p+JtNn1PXNQ5tHPr78EUZXMA2CYffynlCIwwFiRkvWVE66epdilCogQxB2GPaaC
	 +AFm94VsnLmuH3vdWtoc+sapI+aWlECzcRDYSWEl7K+rNV0z9BEW98UYEoN/ZhOsmP
	 w0o9o4KTBU8Ehov/yz7+FnfLpT45pSPDZHW7gMizIjS7nvOuyMhI9uoxu1MRBgBS7Y
	 cULEIXn5l69cA==
Message-ID: <36c2974c-8a4a-4da0-b497-aef4c9647f94@kernel.org>
Date: Mon, 15 Apr 2024 22:01:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: zone: don't block IO if there is
 remained open zone
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240407135848.3638669-1-chao@kernel.org>
 <Zhmje71C7FOTIfom@google.com>
 <2ca3cb91-1db5-4a9b-9dd0-8caad2d09f31@kernel.org>
 <Zhvz-_pqlCEZrUHB@google.com>
 <2dee7da9-e65d-47c0-a7f5-2e952e4aa784@kernel.org>
Content-Language: en-US
In-Reply-To: <2dee7da9-e65d-47c0-a7f5-2e952e4aa784@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/15 11:26, Chao Yu wrote:
> On 2024/4/14 23:19, Jaegeuk Kim wrote:
>> It seems this caused kernel hang. Chao, have you tested this patch enough?
> 
> Jaegeuk,
> 
> Oh, I've checked this patch w/ fsstress before submitting it, but missed
> the SPO testcase... do you encounter kernel hang w/ SPO testcase?

I did see any hang issue w/ por_fsstress testcase, which testcase do you use?

Thanks,

> 
> Anyway, let me test it more.
> 
> Thanks,
> 
>>
>> On 04/13, Chao Yu wrote:
>>> On 2024/4/13 5:11, Jaegeuk Kim wrote:
>>>> On 04/07, Chao Yu wrote:
>>>>> max open zone may be larger than log header number of f2fs, for
>>>>> such case, it doesn't need to wait last IO in previous zone, let's
>>>>> introduce available_open_zone semaphore, and reduce it once we
>>>>> submit first write IO in a zone, and increase it after completion
>>>>> of last IO in the zone.
>>>>>
>>>>> Cc: Daeho Jeong <daeho43@gmail.com>
>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>> ---
>>>>> v3:
>>>>> - avoid race condition in between __submit_merged_bio()
>>>>> and __allocate_new_segment().
>>>>>    fs/f2fs/data.c    | 105 ++++++++++++++++++++++++++++++----------------
>>>>>    fs/f2fs/f2fs.h    |  34 ++++++++++++---
>>>>>    fs/f2fs/iostat.c  |   7 ++++
>>>>>    fs/f2fs/iostat.h  |   2 +
>>>>>    fs/f2fs/segment.c |  43 ++++++++++++++++---
>>>>>    fs/f2fs/segment.h |  12 +++++-
>>>>>    fs/f2fs/super.c   |   2 +
>>>>>    7 files changed, 156 insertions(+), 49 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 0d88649c60a5..18a4ac0a06bc 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -373,11 +373,10 @@ static void f2fs_write_end_io(struct bio *bio)
>>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>>    static void f2fs_zone_write_end_io(struct bio *bio)
>>>>>    {
>>>>> -    struct f2fs_bio_info *io = (struct f2fs_bio_info *)bio->bi_private;
>>>>> +    struct f2fs_sb_info *sbi = iostat_get_bio_private(bio);
>>>>> -    bio->bi_private = io->bi_private;
>>>>> -    complete(&io->zone_wait);
>>>>>        f2fs_write_end_io(bio);
>>>>> +    up(&sbi->available_open_zones);
>>>>>    }
>>>>>    #endif
>>>>> @@ -531,6 +530,24 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>>>>>        if (!io->bio)
>>>>>            return;
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    if (io->open_zone) {
>>>>> +        /*
>>>>> +         * if there is no open zone, it will wait for last IO in
>>>>> +         * previous zone before submitting new IO.
>>>>> +         */
>>>>> +        down(&fio->sbi->available_open_zones);
>>>>> +        io->open_zone = false;
>>>>> +        io->zone_openned = true;
>>>>> +    }
>>>>> +
>>>>> +    if (io->close_zone) {
>>>>> +        io->bio->bi_end_io = f2fs_zone_write_end_io;
>>>>> +        io->zone_openned = false;
>>>>> +        io->close_zone = false;
>>>>> +    }
>>>>> +#endif
>>>>> +
>>>>>        if (is_read_io(fio->op)) {
>>>>>            trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
>>>>>            f2fs_submit_read_bio(io->sbi, io->bio, fio->type);
>>>>> @@ -601,9 +618,9 @@ int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi)
>>>>>                INIT_LIST_HEAD(&sbi->write_io[i][j].bio_list);
>>>>>                init_f2fs_rwsem(&sbi->write_io[i][j].bio_list_lock);
>>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>> -            init_completion(&sbi->write_io[i][j].zone_wait);
>>>>> -            sbi->write_io[i][j].zone_pending_bio = NULL;
>>>>> -            sbi->write_io[i][j].bi_private = NULL;
>>>>> +            sbi->write_io[i][j].open_zone = false;
>>>>> +            sbi->write_io[i][j].zone_openned = false;
>>>>> +            sbi->write_io[i][j].close_zone = false;
>>>>>    #endif
>>>>>            }
>>>>>        }
>>>>> @@ -634,6 +651,31 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>>>>>        f2fs_up_write(&io->io_rwsem);
>>>>>    }
>>>>> +void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type)
>>>>> +{
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    struct f2fs_bio_info *io;
>>>>> +
>>>>> +    if (!f2fs_sb_has_blkzoned(sbi))
>>>>> +        return;
>>>>> +
>>>>> +    io = sbi->write_io[PAGE_TYPE(type)] + type_to_temp(type);
>>>>> +
>>>>> +    f2fs_down_write(&io->io_rwsem);
>>>>> +    if (io->zone_openned) {
>>>>> +        if (io->bio) {
>>>>> +            io->close_zone = true;
>>>>> +            __submit_merged_bio(io);
>>>>> +        } else if (io->zone_openned) {
>>>>> +            up(&sbi->available_open_zones);
>>>>> +            io->zone_openned = false;
>>>>> +        }
>>>>> +    }
>>>>> +    f2fs_up_write(&io->io_rwsem);
>>>>> +#endif
>>>>> +
>>>>> +}
>>>>> +
>>>>>    static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>>>>>                    struct inode *inode, struct page *page,
>>>>>                    nid_t ino, enum page_type type, bool force)
>>>>> @@ -918,22 +960,16 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>>>>>    }
>>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>> -static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>>>>> +static bool is_blkaddr_zone_boundary(struct f2fs_sb_info *sbi,
>>>>> +                    block_t blkaddr, bool start)
>>>>>    {
>>>>> -    int devi = 0;
>>>>> +    if (!f2fs_blkaddr_in_seqzone(sbi, blkaddr))
>>>>> +        return false;
>>>>> +
>>>>> +    if (start)
>>>>> +        return (blkaddr % sbi->blocks_per_blkz) == 0;
>>>>> +    return (blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
>>>>> -    if (f2fs_is_multi_device(sbi)) {
>>>>> -        devi = f2fs_target_device_index(sbi, blkaddr);
>>>>> -        if (blkaddr < FDEV(devi).start_blk ||
>>>>> -            blkaddr > FDEV(devi).end_blk) {
>>>>> -            f2fs_err(sbi, "Invalid block %x", blkaddr);
>>>>> -            return false;
>>>>> -        }
>>>>> -        blkaddr -= FDEV(devi).start_blk;
>>>>> -    }
>>>>> -    return bdev_is_zoned(FDEV(devi).bdev) &&
>>>>> -        f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
>>>>> -        (blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
>>>>>    }
>>>>>    #endif
>>>>> @@ -944,20 +980,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>        struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>>>>>        struct page *bio_page;
>>>>>        enum count_type type;
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    bool blkzoned = f2fs_sb_has_blkzoned(sbi) && btype < META;
>>>>> +#endif
>>>>>        f2fs_bug_on(sbi, is_read_io(fio->op));
>>>>>        f2fs_down_write(&io->io_rwsem);
>>>>>    next:
>>>>> -#ifdef CONFIG_BLK_DEV_ZONED
>>>>> -    if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
>>>>> -        wait_for_completion_io(&io->zone_wait);
>>>>> -        bio_put(io->zone_pending_bio);
>>>>> -        io->zone_pending_bio = NULL;
>>>>> -        io->bi_private = NULL;
>>>>> -    }
>>>>> -#endif
>>>>> -
>>>>>        if (fio->in_list) {
>>>>>            spin_lock(&io->io_lock);
>>>>>            if (list_empty(&io->io_list)) {
>>>>> @@ -985,6 +1015,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>        type = WB_DATA_TYPE(bio_page, fio->compressed_page);
>>>>>        inc_page_count(sbi, type);
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    if (blkzoned && is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, true))
>>>>> +        io->open_zone = true;
>>>>> +#endif
>>>>> +
>>>>>        if (io->bio &&
>>>>>            (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>>>>>                      fio->new_blkaddr) ||
>>>>> @@ -1010,15 +1045,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>>>>>        io->last_block_in_bio = fio->new_blkaddr;
>>>>>        trace_f2fs_submit_page_write(fio->page, fio);
>>>>> +
>>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>> -    if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
>>>>> -            is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
>>>>> -        bio_get(io->bio);
>>>>> -        reinit_completion(&io->zone_wait);
>>>>> -        io->bi_private = io->bio->bi_private;
>>>>> -        io->bio->bi_private = io;
>>>>> -        io->bio->bi_end_io = f2fs_zone_write_end_io;
>>>>> -        io->zone_pending_bio = io->bio;
>>>>> +    if (blkzoned &&
>>>>> +        is_blkaddr_zone_boundary(sbi, fio->new_blkaddr, false)) {
>>>>> +        io->close_zone = true;
>>>>>            __submit_merged_bio(io);
>>>>>        }
>>>>>    #endif
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 694f8a52cb84..8a26530cf4fb 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -1234,16 +1234,16 @@ struct f2fs_bio_info {
>>>>>        struct bio *bio;        /* bios to merge */
>>>>>        sector_t last_block_in_bio;    /* last block number */
>>>>>        struct f2fs_io_info fio;    /* store buffered io info. */
>>>>> -#ifdef CONFIG_BLK_DEV_ZONED
>>>>> -    struct completion zone_wait;    /* condition value for the previous open zone to close */
>>>>> -    struct bio *zone_pending_bio;    /* pending bio for the previous zone */
>>>>> -    void *bi_private;        /* previous bi_private for pending bio */
>>>>> -#endif
>>>>>        struct f2fs_rwsem io_rwsem;    /* blocking op for bio */
>>>>>        spinlock_t io_lock;        /* serialize DATA/NODE IOs */
>>>>>        struct list_head io_list;    /* track fios */
>>>>>        struct list_head bio_list;    /* bio entry list head */
>>>>>        struct f2fs_rwsem bio_list_lock;    /* lock to protect bio entry list */
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    bool open_zone;            /* open a zone */
>>>>> +    bool zone_openned;        /* zone has been openned */
>>>>> +    bool close_zone;        /* close a zone */
>>>>> +#endif
>>>>>    };
>>>>>    #define FDEV(i)                (sbi->devs[i])
>>>>> @@ -1560,6 +1560,7 @@ struct f2fs_sb_info {
>>>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>>>        unsigned int blocks_per_blkz;        /* F2FS blocks per zone */
>>>>>        unsigned int max_open_zones;        /* max open zone resources of the zoned device */
>>>>> +    struct semaphore available_open_zones;    /* available open zones */
>>>>>    #endif
>>>>>        /* for node-related operations */
>>>>> @@ -3822,6 +3823,7 @@ void f2fs_destroy_bio_entry_cache(void);
>>>>>    void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>>>>>                  enum page_type type);
>>>>>    int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
>>>>> +void f2fs_blkzoned_submit_merged_write(struct f2fs_sb_info *sbi, int type);
>>>>>    void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
>>>>>    void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
>>>>>                    struct inode *inode, struct page *page,
>>>>> @@ -4469,6 +4471,28 @@ static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>>>>>        return test_bit(zno, FDEV(devi).blkz_seq);
>>>>>    }
>>>>> +
>>>>> +static inline bool f2fs_blkaddr_in_seqzone(struct f2fs_sb_info *sbi,
>>>>> +                            block_t blkaddr)
>>>>> +{
>>>>> +    int devi = 0;
>>>>> +
>>>>> +    if (f2fs_is_multi_device(sbi)) {
>>>>> +        devi = f2fs_target_device_index(sbi, blkaddr);
>>>>> +        if (blkaddr < FDEV(devi).start_blk ||
>>>>> +            blkaddr > FDEV(devi).end_blk) {
>>>>> +            f2fs_err(sbi, "Invalid block %x", blkaddr);
>>>>> +            return false;
>>>>> +        }
>>>>> +        blkaddr -= FDEV(devi).start_blk;
>>>>> +    }
>>>>> +
>>>>> +    if (!bdev_is_zoned(FDEV(devi).bdev) ||
>>>>> +        !f2fs_blkz_is_seq(sbi, devi, blkaddr))
>>>>> +        return false;
>>>>> +
>>>>> +    return true;
>>>>
>>>> Applied as below.
>>>>
>>>> @@ -4485,11 +4485,8 @@ static inline bool f2fs_blkaddr_in_seqzone(struct f2fs_sb_info *sbi,
>>>>                   blkaddr -= FDEV(devi).start_blk;
>>>>           }
>>>>
>>>> -       if (!bdev_is_zoned(FDEV(devi).bdev) ||
>>>> -               !f2fs_blkz_is_seq(sbi, devi, blkaddr))
>>>> -               return false;
>>>> -
>>>> -       return true;
>>>> +       return bdev_is_zoned(FDEV(devi).bdev) &&
>>>> +               f2fs_blkz_is_seq(sbi, devi, blkaddr);
>>>
>>> Looks good, thank you for cleanup.
>>>
>>> Thanks,
>>>
>>>>    }
>>>>    #endif
>>>>
>>>>> +}
>>>>>    #endif
>>>>>    static inline int f2fs_bdev_index(struct f2fs_sb_info *sbi,
>>>>> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
>>>>> index f8703038e1d8..a8626e297876 100644
>>>>> --- a/fs/f2fs/iostat.c
>>>>> +++ b/fs/f2fs/iostat.c
>>>>> @@ -237,6 +237,13 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>>>>>        spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
>>>>>    }
>>>>> +void *iostat_get_bio_private(struct bio *bio)
>>>>> +{
>>>>> +    struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
>>>>> +
>>>>> +    return iostat_ctx->sbi;
>>>>> +}
>>>>> +
>>>>>    void iostat_update_and_unbind_ctx(struct bio *bio)
>>>>>    {
>>>>>        struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
>>>>> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
>>>>> index eb99d05cf272..9006c3d41590 100644
>>>>> --- a/fs/f2fs/iostat.h
>>>>> +++ b/fs/f2fs/iostat.h
>>>>> @@ -58,6 +58,7 @@ static inline struct bio_post_read_ctx *get_post_read_ctx(struct bio *bio)
>>>>>        return iostat_ctx->post_read_ctx;
>>>>>    }
>>>>> +extern void *iostat_get_bio_private(struct bio *bio);
>>>>>    extern void iostat_update_and_unbind_ctx(struct bio *bio);
>>>>>    extern void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>>>>>            struct bio *bio, struct bio_post_read_ctx *ctx);
>>>>> @@ -68,6 +69,7 @@ extern void f2fs_destroy_iostat(struct f2fs_sb_info *sbi);
>>>>>    #else
>>>>>    static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi, struct inode *inode,
>>>>>            enum iostat_type type, unsigned long long io_bytes) {}
>>>>> +static inline void *iostat_get_bio_private(struct bio *bio) { return bio->bi_private; }
>>>>>    static inline void iostat_update_and_unbind_ctx(struct bio *bio) {}
>>>>>    static inline void iostat_alloc_and_bind_ctx(struct f2fs_sb_info *sbi,
>>>>>            struct bio *bio, struct bio_post_read_ctx *ctx) {}
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 4fd76e867e0a..4a3cf2888faf 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -3140,6 +3140,9 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
>>>>>            return err;
>>>>>        stat_inc_seg_type(sbi, curseg);
>>>>>        locate_dirty_segment(sbi, old_segno);
>>>>> +
>>>>> +    f2fs_blkzoned_submit_merged_write(sbi, type);
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>> @@ -3461,12 +3464,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
>>>>>            f2fs_bug_on(fio->sbi, true);
>>>>>        }
>>>>> -    if (IS_HOT(type))
>>>>> -        fio->temp = HOT;
>>>>> -    else if (IS_WARM(type))
>>>>> -        fio->temp = WARM;
>>>>> -    else
>>>>> -        fio->temp = COLD;
>>>>> +    fio->temp = type_to_temp(type);
>>>>>        return type;
>>>>>    }
>>>>> @@ -4132,6 +4130,27 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
>>>>>            return -EINVAL;
>>>>>        }
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +    if (f2fs_sb_has_blkzoned(sbi)) {
>>>>> +        for (type = 0; type < NR_PERSISTENT_LOG; type++) {
>>>>> +            struct curseg_info *curseg = CURSEG_I(sbi, type);
>>>>> +            enum page_type ptype;
>>>>> +            enum temp_type temp;
>>>>> +
>>>>> +            if (!(curseg->next_blkoff % sbi->blocks_per_blkz))
>>>>> +                continue;
>>>>> +
>>>>> +            if (!f2fs_blkaddr_in_seqzone(sbi,
>>>>> +                    START_BLOCK(sbi, curseg->segno)))
>>>>> +                continue;
>>>>> +
>>>>> +            ptype = PAGE_TYPE(type);
>>>>> +            temp = type_to_temp(type);
>>>>> +            down(&sbi->available_open_zones);
>>>>> +            sbi->write_io[ptype][temp].zone_openned = true;
>>>>> +        }
>>>>> +    }
>>>>> +#endif
>>>>>        return 0;
>>>>>    }
>>>>> @@ -5451,6 +5470,18 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
>>>>>        for (i = 0; i < NR_CURSEG_TYPE; i++) {
>>>>>            kfree(array[i].sum_blk);
>>>>>            kfree(array[i].journal);
>>>>> +
>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>> +        if (f2fs_sb_has_blkzoned(sbi)) {
>>>>> +            enum page_type ptype = PAGE_TYPE(i);
>>>>> +            enum temp_type temp = type_to_temp(i);
>>>>> +
>>>>> +            if (sbi->write_io[ptype][temp].zone_openned) {
>>>>> +                up(&sbi->available_open_zones);
>>>>> +                sbi->write_io[ptype][temp].zone_openned = false;
>>>>> +            }
>>>>> +        }
>>>>> +#endif
>>>>>        }
>>>>>        kfree(array);
>>>>>    }
>>>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>>>>> index e1c0f418aa11..855978ca869f 100644
>>>>> --- a/fs/f2fs/segment.h
>>>>> +++ b/fs/f2fs/segment.h
>>>>> @@ -24,7 +24,8 @@
>>>>>    #define IS_DATASEG(t)    ((t) <= CURSEG_COLD_DATA)
>>>>>    #define IS_NODESEG(t)    ((t) >= CURSEG_HOT_NODE && (t) <= CURSEG_COLD_NODE)
>>>>> -#define SE_PAGETYPE(se)    ((IS_NODESEG((se)->type) ? NODE : DATA))
>>>>> +#define PAGE_TYPE(t)    (IS_NODESEG(t) ? NODE : DATA)
>>>>> +#define SE_PAGETYPE(se)    (PAGE_TYPE((se)->type))
>>>>>    static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>>>>>                            unsigned short seg_type)
>>>>> @@ -965,3 +966,12 @@ static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
>>>>>                return GET_SEGNO(sbi, FDEV(devi).start_blk);
>>>>>        return 0;
>>>>>    }
>>>>> +
>>>>> +static inline enum temp_type type_to_temp(int type)
>>>>> +{
>>>>> +    if (IS_HOT(type))
>>>>> +        return HOT;
>>>>> +    else if (IS_WARM(type))
>>>>> +        return WARM;
>>>>> +    return COLD;
>>>>> +}
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index fdf358c7f808..954baa6c100d 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -3893,6 +3893,8 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>>>>                    sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
>>>>>                return -EINVAL;
>>>>>            }
>>>>> +
>>>>> +        sema_init(&sbi->available_open_zones, sbi->max_open_zones);
>>>>>        }
>>>>>        zone_sectors = bdev_zone_sectors(bdev);
>>>>> -- 
>>>>> 2.40.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

