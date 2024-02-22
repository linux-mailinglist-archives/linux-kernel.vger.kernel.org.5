Return-Path: <linux-kernel+bounces-75967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B775085F146
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F931C2132D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086A154B1;
	Thu, 22 Feb 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBNMQgPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337F12B7E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582351; cv=none; b=OUrJStQo4xjom5zqTozHDr+ehv8tt/9NZcEB7AhOiiBkatqYnBFupHI6W6ul4JnDFQaO6tWPCprpaLnQu+eFYQZFUTt5ncYDjUJ+b0Pf/2ekuI0+2g7RKYjMtBZ5s02lM80ZooNkRiy2CcfUgi3Q1vJSAJrUYbOMLgLy2vJiuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582351; c=relaxed/simple;
	bh=Mj4m/LUW/0R0WXrAQ1/3pKu7G8HE7jUazEdX+H82wOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfM46QvMgDiHRimmGYsL4UGxjI56Ok4xzSGZS/L9ufyH3yiOsMCY2YJXQ1oaXhe208kpz7laP6FzloR2D1OcysIi2+mnXU7shXOx+HS11AtJHn+HX/+ByUkMMX+6FRsT6Z3zbO2sxTMI5MBv4EhHNUmIPCRi84G5mcyAOSj4J64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBNMQgPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658BC433F1;
	Thu, 22 Feb 2024 06:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708582350;
	bh=Mj4m/LUW/0R0WXrAQ1/3pKu7G8HE7jUazEdX+H82wOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBNMQgPp1xkgnA8YrLaygyd/3NI6p/sstxjCowSWVcVvWAZOgS72sUe0xw3QAVvQD
	 lz4lBHhhyWz4s9HguP1cPullIOmnr8odHMK4gU3duLilAhx+jcv5pEtqVEF7O5crdh
	 TBYMgEiXNCCtxlJ12zMdPinkLf7/mHMtRztzR1LfTR1khvfnK/XEU9JXqVzJSBPYLp
	 IQI7GzUDiMid8qcjiYd1Rcbk/2zU9cmkiT9rThJmpONXsQWDwQEPTHAbyzyuAbDwPH
	 Bd0CfrTwntv02Biym5TZ9ORMYvbO31tSX+6Q+XmOSQod2pANb8cx3RutnFC/g1iB/k
	 YAW5oumbTqSiQ==
Message-ID: <14a6ad4e-fb73-4673-865e-ee98030705ea@kernel.org>
Date: Thu, 22 Feb 2024 14:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
 <c2ab9d88-b947-42e5-a1a2-204d58e0c1a8@kernel.org>
 <CAHJ8P3+LGb7pQyLVjsxYvLHgO87Wn41VRhVZ_kkvcdqC8y=5Lg@mail.gmail.com>
 <c0adebd6-8aa3-4704-b429-a14775ed2dcb@kernel.org>
 <CAHJ8P3JjNWJL4rpc5=n9Ku+r1OTC1d-jwTpU17oAAZF0ZeeK-Q@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3JjNWJL4rpc5=n9Ku+r1OTC1d-jwTpU17oAAZF0ZeeK-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/22 13:48, Zhiguo Niu wrote:
> Dear Chao,
> 
> On Thu, Feb 22, 2024 at 11:51 AM Chao Yu <chao@kernel.org <mailto:chao@kernel.org>> wrote:
> 
>     On 2024/2/22 10:15, Zhiguo Niu wrote:
>      >
>      >
>      > On Thu, Feb 22, 2024 at 9:37 AM Chao Yu <chao@kernel.org <mailto:chao@kernel.org> <mailto:chao@kernel.org <mailto:chao@kernel.org>>> wrote:
>      >
>      >     On 2024/2/20 14:11, Zhiguo Niu wrote:
>      >      > There is low probability that an out-of-bounds segment will be got
>      >      > on a small-capacity device. In order to prevent subsequent write requests
>      >      > allocating block address from this invalid segment, which may cause
>      >      > unexpected issue, stop checkpoint should be performed.
>      >      >
>      >      > Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.
>      >      >
>      >      > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com <mailto:zhiguo.niu@unisoc.com> <mailto:zhiguo.niu@unisoc.com <mailto:zhiguo.niu@unisoc.com>>>
>      >      > ---
>      >      > changes of v4: use more suitable MACRO name according to Chao's suggestions
>      >      > changes of v3: correct MACRO spelling and update based on the lastes code
>      >      > ---
>      >      > ---
>      >      >   fs/f2fs/segment.c       | 7 ++++++-
>      >      >   include/linux/f2fs_fs.h | 1 +
>      >      >   2 files changed, 7 insertions(+), 1 deletion(-)
>      >      >
>      >      > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>      >      > index c25aaec..e42e34c 100644
>      >      > --- a/fs/f2fs/segment.c
>      >      > +++ b/fs/f2fs/segment.c
>      >      > @@ -2665,7 +2665,12 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>      >      >       if (secno >= MAIN_SECS(sbi)) {
>      >      >               secno = find_first_zero_bit(free_i->free_secmap,
>      >      >                                                       MAIN_SECS(sbi));
>      >      > -             f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>      >      > +             if (secno >= MAIN_SECS(sbi)) {
>      >      > +                     f2fs_stop_checkpoint(sbi, false,
>      >      > +                             STOP_CP_REASON_NO_SEGMENT);
>      >
>      >     We should relocate stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT) outside
>      >     segmap_lock spinlock, due to it may sleep in f2fs_flush_merged_writes().
>      >
>      > Indeed it is. How about the following fix?
>      > @@ -2665,11 +2665,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>      >          if (secno >= MAIN_SECS(sbi)) {
>      >                  secno = find_first_zero_bit(free_i->free_secmap,
>      >                                                          MAIN_SECS(sbi));
>      > -               if (secno >= MAIN_SECS(sbi)) {
>      > -                       f2fs_stop_checkpoint(sbi, false,
>      > -                               STOP_CP_REASON_NO_SEGMENT);
>      > -                       f2fs_bug_on(sbi, 1);
>      > -               }
>      > +               f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>      >          }
>      >          segno = GET_SEG_FROM_SEC(sbi, secno);
>      >          zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>      > @@ -2700,6 +2696,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>      >          __set_inuse(sbi, segno);
>      >          *newseg = segno;
>      >          spin_unlock(&free_i->segmap_lock);
>      > +       if (secno >= MAIN_SECS(sbi))
>      > +               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
> 
>     How about this?
> 
>     ---
>        fs/f2fs/segment.c | 12 +++++++++---
>        1 file changed, 9 insertions(+), 3 deletions(-)
> 
>     diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>     index d0209ea77dd2..8edc42071e6f 100644
>     --- a/fs/f2fs/segment.c
>     +++ b/fs/f2fs/segment.c
>     @@ -2646,6 +2646,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>              unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>              bool init = true;
>              int i;
>     +       int ret = 0;
> 
>              spin_lock(&free_i->segmap_lock);
> 
>     @@ -2671,9 +2672,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>                      secno = find_first_zero_bit(free_i->free_secmap,
>                                                              MAIN_SECS(sbi));
>                      if (secno >= MAIN_SECS(sbi)) {
>     -                       f2fs_stop_checkpoint(sbi, false,
>     -                               STOP_CP_REASON_NO_SEGMENT);
>     -                       f2fs_bug_on(sbi, 1);
>     +                       ret = -ENOSPC;
>     +                       goto out_unlock; 
> 
>                      }
>              }
>              segno = GET_SEG_FROM_SEC(sbi, secno);
>     @@ -2704,7 +2704,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>              f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
>              __set_inuse(sbi, segno);
>              *newseg = segno;
>     +out_unlock:
>              spin_unlock(&free_i->segmap_lock);
>     +
>     +       if (ret) {
>     +               f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
>     +               f2fs_bug_on(sbi, 1);
> 
> *newseg will not be changed , its caller new_curseg will set a segno got from __get_next_segno to
> curseg->segno, this segno maybe 0, this won't cause any problems because cp has stopped, right?
> thanks!

Since there is no free segment, no matter which segno we assign,
there should be problem, so I'd like to fix to hanlde such error
in caller corectly, unluckly, I doesn't covered all cases yet.

 From b2155a30827bf017d0b3daa1549774aba5953b7e Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 19 Feb 2024 15:15:30 +0800
Subject: f2fs: fix to handle segment allocation failure correctly

Signed-off-by: Chao Yu <chao@kernel.org>
---
  fs/f2fs/data.c    |  7 +++++--
  fs/f2fs/f2fs.h    |  2 +-
  fs/f2fs/gc.c      |  7 ++++++-
  fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++++++++++++++-------
  4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0c9aa3082fcf..c21b92f18463 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1416,8 +1416,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)

  	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
  	old_blkaddr = dn->data_blkaddr;
-	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
-				&sum, seg_type, NULL);
+	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
+				&dn->data_blkaddr, &sum, seg_type, NULL);
+	if (err)
+		return err;
+
  	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
  		f2fs_invalidate_internal_cache(sbi, old_blkaddr);

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b951575bc341..075a8378585d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3733,7 +3733,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
  			block_t old_addr, block_t new_addr,
  			unsigned char version, bool recover_curseg,
  			bool recover_newaddr);
-void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  			block_t old_blkaddr, block_t *new_blkaddr,
  			struct f2fs_summary *sum, int type,
  			struct f2fs_io_info *fio);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6d160d50e14e..42e75e9b8b6b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1358,8 +1358,13 @@ static int move_data_block(struct inode *inode, block_t bidx,
  	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);

  	/* allocate block address */
-	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
+	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
  				&sum, type, NULL);
+	if (err) {
+		f2fs_put_page(mpage, 1);
+		/* filesystem should shutdown, no need to recovery block */
+		goto up_out;
+	}

  	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
  				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8edc42071e6f..d02e92034ae3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2636,7 +2636,7 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
   * Find a new segment from the free segments bitmap to right order
   * This function should be returned with success, otherwise BUG
   */
-static void get_new_segment(struct f2fs_sb_info *sbi,
+static int get_new_segment(struct f2fs_sb_info *sbi,
  			unsigned int *newseg, bool new_sec, bool pinning)
  {
  	struct free_segmap_info *free_i = FREE_I(sbi);
@@ -2650,6 +2650,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,

  	spin_lock(&free_i->segmap_lock);

+	if (time_to_inject(sbi, FAULT_NO_SEGMENT)) {
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+
  	if (!new_sec && ((*newseg + 1) % SEGS_PER_SEC(sbi))) {
  		segno = find_next_zero_bit(free_i->free_segmap,
  			GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
@@ -2711,6 +2716,7 @@ out_unlock:
  		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
  		f2fs_bug_on(sbi, 1);
  	}
+	return ret;
  }

  static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
@@ -2719,6 +2725,10 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
  	struct summary_footer *sum_footer;
  	unsigned short seg_type = curseg->seg_type;

+	/* only happen when get_new_segment() fails */
+	if (curseg->next_segno == NULL_SEGNO)
+		return;
+
  	curseg->inited = true;
  	curseg->segno = curseg->next_segno;
  	curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);
@@ -2783,7 +2793,10 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
  		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));

  	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec, pinning);
+	if (get_new_segment(sbi, &segno, new_sec, pinning)) {
+		curseg->segno = NULL_SEGNO;
+		return -ENOSPC;
+	}
  	if (new_sec && pinning &&
  	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
  		__set_free(sbi, segno);
@@ -3425,7 +3438,7 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
  		get_random_u32_inclusive(1, sbi->max_fragment_hole);
  }

-void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  		block_t old_blkaddr, block_t *new_blkaddr,
  		struct f2fs_summary *sum, int type,
  		struct f2fs_io_info *fio)
@@ -3442,6 +3455,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  	mutex_lock(&curseg->curseg_mutex);
  	down_write(&sit_i->sentry_lock);

+	if (curseg->segno == NULL_SEGNO)
+		goto out_err;
+
  	if (from_gc) {
  		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
  		se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
@@ -3500,6 +3516,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
  				change_curseg(sbi, type);
  			stat_inc_seg_type(sbi, curseg);
  		}
+
+		if (curseg->segno == NULL_SEGNO)
+			goto out_err;
  	}

  skip_new_segment:
@@ -3534,8 +3553,15 @@ skip_new_segment:
  	}

  	mutex_unlock(&curseg->curseg_mutex);
-
  	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return 0;
+out_err:
+	*new_blkaddr = NULL_ADDR;
+	up_write(&sit_i->sentry_lock);
+	mutex_unlock(&curseg->curseg_mutex);
+	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return -ENOSPC;
+
  }

  void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
@@ -3573,8 +3599,14 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
  	if (keep_order)
  		f2fs_down_read(&fio->sbi->io_order_lock);

-	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-			&fio->new_blkaddr, sum, type, fio);
+	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
+			&fio->new_blkaddr, sum, type, fio)) {
+		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
+			fscrypt_finalize_bounce_page(&fio->encrypted_page);
+		if (PageWriteback(fio->page))
+			end_page_writeback(fio->page);
+		goto out;
+	}
  	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
  		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);

@@ -3582,7 +3614,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
  	f2fs_submit_page_write(fio);

  	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
-
+out:
  	if (keep_order)
  		f2fs_up_read(&fio->sbi->io_order_lock);
  }
-- 
cgit v1.2.3-18-g5258

> 
>     +       }
>        }
> 
>        static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
>     -- 
>     2.40.1
> 
>      >
>      >     Thanks,
>      >
>      >      > +                     f2fs_bug_on(sbi, 1);
>      >      > +             }
>      >      > +
>      >      >       }
>      >      >       segno = GET_SEG_FROM_SEC(sbi, secno);
>      >      >       zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>      >      > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>      >      > index 9b69c50..755e9a4 100644
>      >      > --- a/include/linux/f2fs_fs.h
>      >      > +++ b/include/linux/f2fs_fs.h
>      >      > @@ -75,6 +75,7 @@ enum stop_cp_reason {
>      >      >       STOP_CP_REASON_CORRUPTED_SUMMARY,
>      >      >       STOP_CP_REASON_UPDATE_INODE,
>      >      >       STOP_CP_REASON_FLUSH_FAIL,
>      >      > +     STOP_CP_REASON_NO_SEGMENT,
>      >      >       STOP_CP_REASON_MAX,
>      >      >   };
>      >      >
>      >
> 

