Return-Path: <linux-kernel+bounces-18459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8E825DF5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 03:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BCF1C21A81
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1B15C4;
	Sat,  6 Jan 2024 02:48:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3015AC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.254])
	by sina.com (10.75.12.45) with ESMTP
	id 6598BF71000029E5; Sat, 6 Jan 2024 10:48:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 48107731457776
X-SMAIL-UIID: E4633905762A40B7A2DD360CE9870677-20240106-104820-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
Date: Sat,  6 Jan 2024 10:48:07 +0800
Message-Id: <20240106024807.3011-1-hdanton@sina.com>
In-Reply-To: <000000000000c8a56a060de13553@google.com>
References: <000000000000c8a56a060de13553@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jan 2024 04:06:21 -0800
> HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13177855e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/include/linux/sched.h
+++ y/include/linux/sched.h
@@ -1544,6 +1544,7 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+	unsigned long	bfl;
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
--- x/include/linux/buffer_head.h
+++ y/include/linux/buffer_head.h
@@ -78,6 +78,7 @@ struct buffer_head {
 	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
 					 * serialise IO completion of other
 					 * buffers in the page */
+	struct task_struct *lko;
 };
 
 /*
@@ -402,6 +403,9 @@ static inline void lock_buffer(struct bu
 	might_sleep();
 	if (!trylock_buffer(bh))
 		__lock_buffer(bh);
+	bh->lko = current;
+	get_task_struct(bh->lko);
+	bh->lko->bfl = (unsigned long) bh;
 }
 
 static inline void bh_readahead(struct buffer_head *bh, blk_opf_t op_flags)
--- x/fs/ext4/super.c
+++ y/fs/ext4/super.c
@@ -7248,6 +7248,7 @@ static ssize_t ext4_quota_write(struct s
 		brelse(bh);
 		return err;
 	}
+	BUG_ON(current->bfl == (unsigned long) bh);
 	lock_buffer(bh);
 	memcpy(bh->b_data+offset, data, len);
 	flush_dcache_page(bh->b_page);
--- x/fs/buffer.c
+++ y/fs/buffer.c
@@ -77,6 +77,11 @@ void unlock_buffer(struct buffer_head *b
 	clear_bit_unlock(BH_Lock, &bh->b_state);
 	smp_mb__after_atomic();
 	wake_up_bit(&bh->b_state, BH_Lock);
+	if (!bh->lko)
+		return;
+	bh->lko->bfl = 0;
+	put_task_struct(bh->lko);
+	bh->lko = NULL;
 }
 EXPORT_SYMBOL(unlock_buffer);
 
--

