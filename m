Return-Path: <linux-kernel+bounces-36167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72484839CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF851C256B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AF54BCE;
	Tue, 23 Jan 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuV9T5RA"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4F53E28
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051421; cv=none; b=JipOx3z3lLIgTeqD+T/vjuk5Hi8/r6mzJ2jak6GZUMxTY4RKIvRz/AvVh9LLwWE+lzCDmY89FM8V4myfVDZG15CGiGNcytsZIsaXkStV/lsNJ2egOc9tBzpiZVtu3Ov3Aw7gYSKfiOQgb80BPcGAZtVvvIIQQlNViDsxjhEVCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051421; c=relaxed/simple;
	bh=VSmKcMfyN3MYuxa3M+8VItvp5qj4UNGBOJKK9wA9Qlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5RpeeFLZ/NgtACn4x4Lxm6g2ftHES8Wfaz6tvuQ9fyBmYPNIN7VG3lmztL3ArF+JtxgFRjuW74mXq1bN7dJURDXzyUXQ/6T9BHXW4KNXLljaJawFOrLSqaewmZ3ePKT7dvIpeonLoXiPsnsMgaZqcjh2GJJBuW+ZI3OaU6Tab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuV9T5RA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff7cf2fd21so51161107b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051419; x=1706656219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=XuV9T5RAXMXEf4hcRZSSpo96qObe0afVE4WoZ3Na/Td2ZSGF6RVXD9I3catbFL61Fx
         7EcKFg92EehqiNaSHycU78dw6JEa1uITxBKB0TuymA/Ckr9psHv6w8IL2Eajcizhicwa
         vY0zblX3cdStLP6OEJbVlHPVztheMt+4Q4NI6BhoNfGBEtF8+TDbCBSc7c1Fes5OT2D6
         RJgT9LKZETNfBXLqIhVZ8zNuArmkQetb4nq6naANciE3ke51eToTIjkqecGYBRMQFJzM
         0DM+2n0FHchVeKP7ElAtbgNGHyv85yZkJKkuZHYlLjDhndZsITipsOjHlgjT5tMacSZU
         l/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051419; x=1706656219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=l48+FlKhSUIgKoat6MqFnlDelYlxWC+7tMeqaGM8IZcOCLBM/l/pTUtEB7w2UxKE2t
         ZQ7pch3dgVPpmw3qVqZx30YiTg857voeAnaWapwJ1GjW6UAhm83sz4pd4k0cshn4fpjO
         6wATWiY4zcwpx1Yd/NDjlShxK31CiJMYfwIlngqhFo7pJmh7QyMl8VhaArIdZGKPx//1
         SmS4T8PVntm7DMt64BseOfMFKz3w4DGKYHG8a81iVpwRaPc0r1lFE1xvVJEc6jMudx+j
         srckqm0MKCPQ+W5vHKhZhHPCJioDn0yw0IvYkl/E5Y0Kfsus9VYWPv2AsSl+lbIdIUq0
         pICw==
X-Gm-Message-State: AOJu0YzOBRhfcy5ZOOS2zNPexwbM7DyEao/UzxWlguc2m60UpgTbc1EH
	T+w87Df5WOMjnPF/6qlAkupqN+p39FSjKEjHHfc+1Q5BbSHDHc6fySy1YM6OcU0FXSDhg7Monyh
	bdw==
X-Google-Smtp-Source: AGHT+IFX5qIebM/ZQiKUEXGTW3oxR6pBTWd2HR+W3VQ1MxVAngHzessR/YRxQzpsjGe8I1sOL4WmImG7jew=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:8fc3:c34f:d407:388])
 (user=surenb job=sendgmr) by 2002:a81:9896:0:b0:5fc:7f94:da64 with SMTP id
 p144-20020a819896000000b005fc7f94da64mr134477ywg.5.1706051419411; Tue, 23 Jan
 2024 15:10:19 -0800 (PST)
Date: Tue, 23 Jan 2024 15:10:13 -0800
In-Reply-To: <20240123231014.3801041-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123231014.3801041-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123231014.3801041-2-surenb@google.com>
Subject: [PATCH v2 2/3] mm: add mm_struct sequence number to detect write locks
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Provide a way for lockless mm_struct users to detect whether mm might have
been changed since some specific point in time. The API provided allows
the user to record a counter when it starts using the mm and later use
that counter to check if anyone write-locked mmap_lock since the counter
was recorded. Recording the counter value should be done while holding
mmap_lock at least for reading to prevent the counter from concurrent
changes. Every time mmap_lock is write-locked mm_struct updates its
mm_wr_seq counter so that checks against counters recorded before that
would fail, indicating a possibility of mm being modified.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_types.h  |  2 ++
 include/linux/mmap_lock.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bbe1223cd992..e749f7f09314 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -846,6 +846,8 @@ struct mm_struct {
 		 */
 		int mm_lock_seq;
 #endif
+		/* Counter incremented each time mm gets write-locked */
+		unsigned long mm_wr_seq;
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 8d38dcb6d044..0197079cb6fe 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -106,6 +106,8 @@ static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+	smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -113,6 +115,8 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+	smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -122,6 +126,10 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret) {
+		/* Pairs with ACQUIRE semantics in mmap_write_seq_read */
+		smp_store_release(&mm->mm_wr_seq, mm->mm_wr_seq + 1);
+	}
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
@@ -140,6 +148,20 @@ static inline void mmap_write_downgrade(struct mm_struct *mm)
 	downgrade_write(&mm->mmap_lock);
 }
 
+static inline unsigned long mmap_write_seq_read(struct mm_struct *mm)
+{
+	/* Pairs with RELEASE semantics in mmap_write_lock */
+	return smp_load_acquire(&mm->mm_wr_seq);
+}
+
+static inline void mmap_write_seq_record(struct mm_struct *mm,
+					 unsigned long *mm_wr_seq)
+{
+	mmap_assert_locked(mm);
+	/* Nobody can concurrently modify since we hold the mmap_lock */
+	*mm_wr_seq = mm->mm_wr_seq;
+}
+
 static inline void mmap_read_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, false);
-- 
2.43.0.429.g432eaa2c6b-goog


