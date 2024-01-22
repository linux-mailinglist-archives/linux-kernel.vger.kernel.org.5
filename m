Return-Path: <linux-kernel+bounces-32415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC6835B72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD5DB2460E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0B112E59;
	Mon, 22 Jan 2024 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1V6naVaZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E36FC10
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907614; cv=none; b=jclvxHsDHjonn/wBO2ry8ZimsnkkD7V24eBV3vufhyqPByTaGwUKQzzsodkLMAKEFXOin5q0ueI14PeO9+lxuAsmS7U3OCtlKbfvyzbnO3pO2A+J4tK6o9/wNyn/Lkt65GeqXNx2JbEqYqBV2y+2bFYttMJqxDHgRBSBD1R6kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907614; c=relaxed/simple;
	bh=VSmKcMfyN3MYuxa3M+8VItvp5qj4UNGBOJKK9wA9Qlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dV76NVrXB8BBYKv6S3SNToKYZ6MFi4cY2uTiS5t7O2g1fLkez7e5DEkltP6E2wRk4jTJUYVBox1qdk1z1nFx1l2W/cwZnX9HKFme+Lh7PcoiWlcle/GPHoqZC8iGBiz9tC3SxtdHKWniSGwGr2QEqOtFEvkwVPUC52y7rYnKx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1V6naVaZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f6c12872fbso43748577b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705907611; x=1706512411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=1V6naVaZaSLjwy19DLCWrHyiuJ3nL9dOJ2i1WamO/OYHbln+7XGcnJa7FVhJZ1en2P
         hidngHBf6X4ak8lqqu/DpCUgRfjMX1rt2/n8kga7qyAjzfLtYy4HV57HOZXl5t8FujMG
         7T47ry/neXetIKOdV59cMb7XDRgiLgR/wKqvpYiFeeWEGNiORBCsSS7D7fTdtW9Mf7QB
         JBfd1mE6W3oj3lDr7pFP5m72VsT3R9TXsmPynxDOj2Zl/On92L+Ig8wZnVj8XYJyF5aS
         xK1OIUYq2gRcrqpC4bBRb+fU19EAH+vMP4qmnNrJKmYEu3C0S90dRleNPT8J3yZe1ZuC
         FKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907611; x=1706512411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLp6U6EsMSw583KQsA7U2jc3UsvPAv4xgtxefIxudO0=;
        b=dl9+9suCM2qPx4vz4rxxGj1UtnAOzzjRUjqcrJPl/iRbDD4SXwtcM9AXxPjqqnilPa
         /+/C+K81IOWDr/VVtXrKLGNgobkNgBzIrujV3IbtmT4jTtF5yWMNqnysjDnSgZRHs3qY
         qSALoPrmQq+c1ryNp7On6Hf7W/AG7Uf8b2rGaLl/5cteWOOAWBjqJVUzID0OQIGxla18
         PjPK92tvMzwbjs3B/EnK7K5Ti5W4a4wDIUAJLcT6i1IVgCcBMSNA+/is52CFijalNxDG
         wr3G4jU9dZ0vj0iOZdqvrWR9nnl/v+/kWoWvtAizlY/mNDONRtL8ETIHKlWnFjSbZ35h
         +MZg==
X-Gm-Message-State: AOJu0YyKixl2D9UWt1MsgtgCs9Vx9J3if6L26b5jcukRovKIFIgvkuRC
	uTN9EDGkx/3zbtH4i7WhG2FB5z/QcsyjOGUr51n45yM0FQtht2PNC0meSnPN+qmg9ztA1SNWpUY
	8kw==
X-Google-Smtp-Source: AGHT+IFDFx+rU5MMV2joyEArNdxSbn9+Uqv0sdgUNYpKz6Fm9lpqOqNw6v9H//7PI5LcIGO1EwFhJ6qHlkY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4979:1d79:d572:5708])
 (user=surenb job=sendgmr) by 2002:a81:a096:0:b0:5e6:27ee:67fb with SMTP id
 x144-20020a81a096000000b005e627ee67fbmr1310854ywg.4.1705907611085; Sun, 21
 Jan 2024 23:13:31 -0800 (PST)
Date: Sun, 21 Jan 2024 23:13:23 -0800
In-Reply-To: <20240122071324.2099712-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122071324.2099712-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122071324.2099712-2-surenb@google.com>
Subject: [PATCH 2/3] mm: add mm_struct sequence number to detect write locks
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
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com, 
	surenb@google.com
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


