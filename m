Return-Path: <linux-kernel+bounces-90118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3F686FA93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9D61F212DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA634134B4;
	Mon,  4 Mar 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMj5bKUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959353A6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536643; cv=none; b=loJsrKQVbQ00Re3lGK30oQEDW8teApWRD6vEZW2LigI9ivLejaDSPEofAAO0RnqT3hD6qaIGgOSRHR8x/a+8T/CAmNWPSrZ9G21Ri0tivrF1yHdJ28VwQHH1c2WQ6mzonaAC74Ly3GnrjwFVzeHL4ekrzVNn8FTz8Mu3T93gW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536643; c=relaxed/simple;
	bh=t/fKooogMX5Y+d+WfM6A6zOdudg4To48TJ8kZ84r3PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIZilLlaEfyfNZdyONdhTnhU22gim/NlkfzctAFjQGSFECKGgV3ZnBcuDlFZBvidDDyt5bJjGhnRaEFepoJRXGRAdG2IOPZcpFgdES404sSk78nctPTBgSgGdITWp3/QVe1of37u8RcJExX380vtF5fNSH3ESPzluxWUF6FxE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMj5bKUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E1DC433F1;
	Mon,  4 Mar 2024 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709536643;
	bh=t/fKooogMX5Y+d+WfM6A6zOdudg4To48TJ8kZ84r3PE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hMj5bKUQncMDV7mRRoA3xHtpLrIj+3DbwcoPMIQ7Mj6k6pSghBKtUd2mpHeszRCfO
	 HmzBUx4cr7vNGps3QcQILxYhXAZwzqB2QI3KxmhJhUWk18Zotfph4rPeMpU30IsVQG
	 l99KSkV/c3UT73OCMypj6aRnCA39SijlWwrRdj5jjX+B7aqin/ERwumAwr35EZ2A74
	 WTBLZBak5G3y52H2H6KkSJWFUuOoALNp+cPwGZfWFzjcpSqNeDcvH9LCnsT3UItu/e
	 XVVPIpI1tIJzwuDdRKug4vbkwPtkYhbJA/3wRLlzNh4AhLyr7E2PxWMmuKn7/zbrtA
	 JXxSIgcFrT5bQ==
Message-ID: <73197f36-4962-4a3d-a56c-8fd3494af7e5@kernel.org>
Date: Mon, 4 Mar 2024 15:17:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to check result of new_curseg in
 f2fs_allocate_segment_for_resize
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1709292976-13118-1-git-send-email-zhiguo.niu@unisoc.com>
 <7dc371ad-2448-4dd4-9551-8caef0a00d48@kernel.org>
 <CAHJ8P3+ZBuBu9Sdpm_6fxhY2sVyu97dXFKKLdtEF4shi_3Fs1Q@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+ZBuBu9Sdpm_6fxhY2sVyu97dXFKKLdtEF4shi_3Fs1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/4 11:33, Zhiguo Niu wrote:
> On Mon, Mar 4, 2024 at 11:19 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/3/1 19:36, Zhiguo Niu wrote:
>>> new_curseg may return error if get_new_segment fail, so its result
>>> should be check in its caller f2fs_allocate_segment_for_resize,
>>> alos pass this results to free_segment_range.
>>
>> Zhiguo,
>>
>> What about handling all error paths of new_curseg() and change_curseg()
>> in one patch?
> Dear Chao,
> 
> Do you mean to merge it with the previous patch “f2fs: fix to check
> return value of f2fs_gc_range”?
> Because in addition to new_curseg/change_curseg error handling, there
> are some other changes in the previous patch.
> besides, I searched for new related codes, and there should be the
> only place left without error handling about new_curseg/
> change_curseg .

Zhiguo, I meant something like this?

Subject: [PATCH] f2fs: fix to handle error paths of {new,change}_curseg()

---
  fs/f2fs/f2fs.h    |  4 +--
  fs/f2fs/gc.c      |  7 +++--
  fs/f2fs/segment.c | 67 +++++++++++++++++++++++++++++++----------------
  fs/f2fs/super.c   |  4 ++-
  4 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 80789255bf68..03927f1b2ea1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3702,10 +3702,10 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable);
  void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
  int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
  bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno);
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
  void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
  void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
  					unsigned int start, unsigned int end);
  int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
  int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f8314765246a..854ad0a3f6ea 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2033,8 +2033,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
  	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);

  	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
-		f2fs_allocate_segment_for_resize(sbi, type, start, end);
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
+		if (err)
+			goto out;
+	}

  	/* do GC to move out valid blocks in the range */
  	err = f2fs_gc_range(sbi, start, end, dry_run, 0);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22241aba6564..2bcf01fde143 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2863,7 +2863,7 @@ bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
   * This function always allocates a used segment(from dirty seglist) by SSR
   * manner, so it should recover the existing segment information of valid blocks
   */
-static void change_curseg(struct f2fs_sb_info *sbi, int type)
+static int change_curseg(struct f2fs_sb_info *sbi, int type)
  {
  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
  	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2888,21 +2888,24 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
  	if (IS_ERR(sum_page)) {
  		/* GC won't be able to use stale summary pages by cp_error */
  		memset(curseg->sum_blk, 0, SUM_ENTRY_SIZE);
-		return;
+		return PTR_ERR(sum_page);
  	}
  	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
  	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
  	f2fs_put_page(sum_page, 1);
+
+	return 0;
  }

  static int get_ssr_segment(struct f2fs_sb_info *sbi, int type,
  				int alloc_mode, unsigned long long age);

-static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
+static int get_atssr_segment(struct f2fs_sb_info *sbi, int type,
  					int target_type, int alloc_mode,
  					unsigned long long age)
  {
  	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	int ret;

  	curseg->seg_type = target_type;

@@ -2910,38 +2913,45 @@ static void get_atssr_segment(struct f2fs_sb_info *sbi, int type,
  		struct seg_entry *se = get_seg_entry(sbi, curseg->next_segno);

  		curseg->seg_type = se->type;
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
  	} else {
  		/* allocate cold segment by default */
  		curseg->seg_type = CURSEG_COLD_DATA;
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);
  	}
  	stat_inc_seg_type(sbi, curseg);
+
+	return ret;
  }

-static void __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
+static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
  {
  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC);
+	int ret;

  	if (!sbi->am.atgc_enabled)
-		return;
+		return 0;

  	f2fs_down_read(&SM_I(sbi)->curseg_lock);

  	mutex_lock(&curseg->curseg_mutex);
  	down_write(&SIT_I(sbi)->sentry_lock);

-	get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC, CURSEG_COLD_DATA, SSR, 0);
+	ret = get_atssr_segment(sbi, CURSEG_ALL_DATA_ATGC,
+					CURSEG_COLD_DATA, SSR, 0);

  	up_write(&SIT_I(sbi)->sentry_lock);
  	mutex_unlock(&curseg->curseg_mutex);

  	f2fs_up_read(&SM_I(sbi)->curseg_lock);

+	return ret;
+
  }
-void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
+
+int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
  {
-	__f2fs_init_atgc_curseg(sbi);
+	return __f2fs_init_atgc_curseg(sbi);
  }

  static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, int type)
@@ -3069,11 +3079,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
  	return false;
  }

-void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
+int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
  					unsigned int start, unsigned int end)
  {
  	struct curseg_info *curseg = CURSEG_I(sbi, type);
  	unsigned int segno;
+	int ret = 0;

  	f2fs_down_read(&SM_I(sbi)->curseg_lock);
  	mutex_lock(&curseg->curseg_mutex);
@@ -3084,9 +3095,9 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
  		goto unlock;

  	if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type, SSR, 0))
-		change_curseg(sbi, type);
+		ret = change_curseg(sbi, type);
  	else
-		new_curseg(sbi, type, true);
+		ret = new_curseg(sbi, type, true);

  	stat_inc_seg_type(sbi, curseg);

@@ -3100,6 +3111,8 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,

  	mutex_unlock(&curseg->curseg_mutex);
  	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+
+	return ret;
  }

  static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
@@ -3107,6 +3120,7 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,
  {
  	struct curseg_info *curseg = CURSEG_I(sbi, type);
  	unsigned int old_segno;
+	int ret;

  	if (type == CURSEG_COLD_DATA_PINNED && !curseg->inited)
  		goto allocate;
@@ -3119,8 +3133,9 @@ static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,

  allocate:
  	old_segno = curseg->segno;
-	if (new_curseg(sbi, type, true))
-		return -EAGAIN;
+	ret = new_curseg(sbi, type, true);
+	if (ret)
+		return ret;
  	stat_inc_seg_type(sbi, curseg);
  	locate_dirty_segment(sbi, old_segno);
  	return 0;
@@ -3480,14 +3495,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  	bool from_gc = (type == CURSEG_ALL_DATA_ATGC);
  	struct seg_entry *se = NULL;
  	bool segment_full = false;
+	int ret = 0;

  	f2fs_down_read(&SM_I(sbi)->curseg_lock);

  	mutex_lock(&curseg->curseg_mutex);
  	down_write(&sit_i->sentry_lock);

-	if (curseg->segno == NULL_SEGNO)
+	if (curseg->segno == NULL_SEGNO) {
+		ret = -ENOSPC;
  		goto out_err;
+	}

  	if (from_gc) {
  		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
@@ -3541,17 +3559,17 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  		}

  		if (from_gc) {
-			get_atssr_segment(sbi, type, se->type,
+			ret = get_atssr_segment(sbi, type, se->type,
  						AT_SSR, se->mtime);
  		} else {
  			if (need_new_seg(sbi, type))
-				new_curseg(sbi, type, false);
+				ret = new_curseg(sbi, type, false);
  			else
-				change_curseg(sbi, type);
+				ret = change_curseg(sbi, type);
  			stat_inc_seg_type(sbi, curseg);
  		}

-		if (curseg->segno == NULL_SEGNO)
+		if (ret)
  			goto out_err;
  	}

@@ -3594,7 +3612,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  	up_write(&sit_i->sentry_lock);
  	mutex_unlock(&curseg->curseg_mutex);
  	f2fs_up_read(&SM_I(sbi)->curseg_lock);
-	return -ENOSPC;
+	return ret;

  }

@@ -3824,7 +3842,8 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
  	/* change the current segment */
  	if (segno != curseg->segno) {
  		curseg->next_segno = segno;
-		change_curseg(sbi, type);
+		if (change_curseg(sbi, type))
+			goto out_unlock;
  	}

  	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
@@ -3850,12 +3869,14 @@ void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
  	if (recover_curseg) {
  		if (old_cursegno != curseg->segno) {
  			curseg->next_segno = old_cursegno;
-			change_curseg(sbi, type);
+			if (change_curseg(sbi, type))
+				goto out_unlock;
  		}
  		curseg->next_blkoff = old_blkoff;
  		curseg->alloc_type = old_alloc_type;
  	}

+out_unlock:
  	up_write(&sit_i->sentry_lock);
  	mutex_unlock(&curseg->curseg_mutex);
  	f2fs_up_write(&SM_I(sbi)->curseg_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0676c2dcbbf7..8c69257db8cc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4691,7 +4691,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
  	if (err)
  		goto free_meta;

-	f2fs_init_inmem_curseg(sbi);
+	err = f2fs_init_inmem_curseg(sbi);
+	if (err)
+		goto sync_free_meta;

  	/* f2fs_recover_fsync_data() cleared this already */
  	clear_sbi_flag(sbi, SBI_POR_DOING);
-- 
2.40.1



> 
> thanks!
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    fs/f2fs/f2fs.h    | 2 +-
>>>    fs/f2fs/gc.c      | 7 +++++--
>>>    fs/f2fs/segment.c | 9 +++++++--
>>>    3 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 4331012..39dda7d 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -3701,7 +3701,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>    void f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
>>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
>>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
>>> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>                                        unsigned int start, unsigned int end);
>>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type, bool force);
>>>    int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi);
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index c60b747..7a458fa 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -2037,8 +2037,11 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
>>>        mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
>>>
>>>        /* Move out cursegs from the target range */
>>> -     for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++)
>>> -             f2fs_allocate_segment_for_resize(sbi, type, start, end);
>>> +     for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
>>> +             err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
>>> +             if (err)
>>> +                     goto out;
>>> +     }
>>>
>>>        /* do GC to move out valid blocks in the range */
>>>        err = f2fs_gc_range(sbi, start, end, dry_run, 0);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 1bb3019..2a07b9d 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3071,11 +3071,12 @@ static bool need_new_seg(struct f2fs_sb_info *sbi, int type)
>>>        return false;
>>>    }
>>>
>>> -void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>> +int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>                                        unsigned int start, unsigned int end)
>>>    {
>>>        struct curseg_info *curseg = CURSEG_I(sbi, type);
>>>        unsigned int segno;
>>> +     int err = 0;
>>>
>>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
>>>        mutex_lock(&curseg->curseg_mutex);
>>> @@ -3089,7 +3090,10 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>                change_curseg(sbi, type);
>>>        else
>>>                new_curseg(sbi, type, true);
>>> -
>>> +     if (curseg->segno == NULL_SEGNO) {
>>> +             err = -ENOSPC;
>>> +             goto unlock;
>>> +     }
>>>        stat_inc_seg_type(sbi, curseg);
>>>
>>>        locate_dirty_segment(sbi, segno);
>>> @@ -3102,6 +3106,7 @@ void f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
>>>
>>>        mutex_unlock(&curseg->curseg_mutex);
>>>        f2fs_up_read(&SM_I(sbi)->curseg_lock);
>>> +     return err;
>>>    }
>>>
>>>    static int __allocate_new_segment(struct f2fs_sb_info *sbi, int type,

