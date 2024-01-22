Return-Path: <linux-kernel+bounces-32414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A40835B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126BDB2407D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2088FC09;
	Mon, 22 Jan 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsWEKk8r"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AFFBE7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907611; cv=none; b=kPyW2obqIT2JCsK2b97u7pUFb0H8kmUhHuGZv1Cr3n/jIyniY1E59+qB0gBFbSgYfEHPf1X+z3i1RdWpbCAK3TcGHJo5a6HgaD4vZe7C28GI76e3ynh3tM5kMsrXru81TOklsKTqAp7tpfKlT1UBmwwUthe/znIRDsJhdxta6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907611; c=relaxed/simple;
	bh=6Lrv5xwMfaDaPsl1VCKPLCnIY6z/5ht1dxDtK8LPTm4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V9wsm3ztT9VWNqCjDNnus0HI32D6SbMDbj7T2N23snCHTD0FAPKOQKNajl0rnoagpZN1DmYSqps4LbM73GOUoZOpePJhVDV83BG6kssf1xAml3TUWb9FHtW2JWeQZs8IqoHoveKOpo0fkRTtJjnkr9CorbffkzlFDURbYvR05SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsWEKk8r; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so3614425276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705907608; x=1706512408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=UsWEKk8rXs+hKbDWocKQBdrDKXKhfh7jxYSGJNpmt/g5n6Ib5Uh7cFCdtwF1uBsKIo
         6bV0X98CVkYYVLY2A8uEkBhzAv5kYDxH8nsK+7P9lARMQCWcL7k4auaMiQ0OacLPjz8J
         22aphKXRcuApyh1s4BwTpO8M++11answPeB7Z4GtcZP+d1V+0X+EfzxgcfhAzKXC7hxA
         lNlWWZp0M+PPptivUqVxF8iO+FulNtCQyaQO9LtolBByrN9Z+w9YkmQX+JaTn9O7VOAk
         IPNA3xX69jCFo65s2A7SJ9YqakfeYuAO2S3UNxVv3zeckadO/eSh7ZZ3CXtmsRdaqwlQ
         p5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907608; x=1706512408;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXyU4pkvCRYAyA2TUvsUC8dh5sAPzBBH4qagn6tOpF0=;
        b=ChKshpuksDJNOQVDrSPD9iG4L8wQAYYgb+hnXJP8iepHXjP193/L4tdMwVOT/kH/uw
         VAKfaRolE9DFUBU8WtIY4iLhHE3JYzFPL6CLxhBNy9L2CwHtk3bpcuNZ3XaoJLAXWv6A
         QN+LyNB5b+S7P2MUfJaZFG93NniHMI9LEBaWzqbebHojNsM85CPKvjfV2QYGCszrSAdI
         Gn51TPHDephzNnC9lvP1Z9o+VZbnpEHXJA2Jv8Grek7crfEPjWZFoY9nfGTAfvTEtmse
         Ov/w/PC8BYyvH2LdqOZuV4NAkhYunq0roOyHOLynzPX71EL6AJu+XgF55gOKU/5k2AD6
         9PYQ==
X-Gm-Message-State: AOJu0Yw9yGVBBunOFsUFaXzllpE6utfu8TU1Srs88jsRiqC+AP1qeKtt
	cwquvSp/ADu1TlL0ymwGosBcBag8TdhKsx3q5ytcVFaiJ+12hxlDwAakMtGhxvT6qqw2tdH0HPJ
	ccw==
X-Google-Smtp-Source: AGHT+IG8d1Gn9VWPvChN4p2/RHkaCghVVAROZ7VOgDGN0KGJpb0phlIzNaSwlCWzvJeInLF/vdqx3fCBkG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4979:1d79:d572:5708])
 (user=surenb job=sendgmr) by 2002:a25:e90c:0:b0:dbe:49ca:eb03 with SMTP id
 n12-20020a25e90c000000b00dbe49caeb03mr1889847ybd.5.1705907608657; Sun, 21 Jan
 2024 23:13:28 -0800 (PST)
Date: Sun, 21 Jan 2024 23:13:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122071324.2099712-1-surenb@google.com>
Subject: [PATCH 1/3] mm: make vm_area_struct anon_name field RCU-safe
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

For lockless /proc/pid/maps reading we have to ensure all the fields
used when generating the output are RCU-safe. The only pointer fields
in vm_area_struct which are used to generate that file's output are
vm_file and anon_name. vm_file is RCU-safe but anon_name is not. Make
anon_name RCU-safe as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 10 +++++++++-
 include/linux/mm_types.h  |  3 ++-
 mm/madvise.c              | 30 ++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..bbdb0ca857f1 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -389,7 +389,7 @@ static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
 
 	if (anon_name)
-		new_vma->anon_name = anon_vma_name_reuse(anon_name);
+		rcu_assign_pointer(new_vma->anon_name, anon_vma_name_reuse(anon_name));
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
@@ -411,6 +411,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 		!strcmp(anon_name1->name, anon_name2->name);
 }
 
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
@@ -424,6 +426,12 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 	return true;
 }
 
+static inline
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8b611e13153e..bbe1223cd992 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -545,6 +545,7 @@ struct vm_userfaultfd_ctx {};
 
 struct anon_vma_name {
 	struct kref kref;
+	struct rcu_head rcu;
 	/* The name needs to be at the end because it is dynamically sized. */
 	char name[];
 };
@@ -699,7 +700,7 @@ struct vm_area_struct {
 	 * terminated string containing the name given to the vma, or NULL if
 	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
 	 */
-	struct anon_vma_name *anon_name;
+	struct anon_vma_name __rcu *anon_name;
 #endif
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
diff --git a/mm/madvise.c b/mm/madvise.c
index 912155a94ed5..0f222d464254 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -88,14 +88,15 @@ void anon_vma_name_free(struct kref *kref)
 {
 	struct anon_vma_name *anon_name =
 			container_of(kref, struct anon_vma_name, kref);
-	kfree(anon_name);
+	kfree_rcu(anon_name, rcu);
 }
 
 struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
 
-	return vma->anon_name;
+	return rcu_dereference_protected(vma->anon_name,
+		rwsem_is_locked(&vma->vm_mm->mmap_lock));
 }
 
 /* mmap_lock should be write-locked */
@@ -105,7 +106,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	struct anon_vma_name *orig_name = anon_vma_name(vma);
 
 	if (!anon_name) {
-		vma->anon_name = NULL;
+		rcu_assign_pointer(vma->anon_name, NULL);
 		anon_vma_name_put(orig_name);
 		return 0;
 	}
@@ -113,11 +114,32 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	if (anon_vma_name_eq(orig_name, anon_name))
 		return 0;
 
-	vma->anon_name = anon_vma_name_reuse(anon_name);
+	rcu_assign_pointer(vma->anon_name, anon_vma_name_reuse(anon_name));
 	anon_vma_name_put(orig_name);
 
 	return 0;
 }
+
+/*
+ * Returned anon_vma_name is stable due to elevated refcount but not guaranteed
+ * to be assigned to the original VMA after the call.
+ */
+struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
+{
+	struct anon_vma_name __rcu *anon_name;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	anon_name = rcu_dereference(vma->anon_name);
+	if (!anon_name)
+		return NULL;
+
+	if (unlikely(!kref_get_unless_zero(&anon_name->kref)))
+		return NULL;
+
+	return anon_name;
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static int replace_anon_vma_name(struct vm_area_struct *vma,
 				 struct anon_vma_name *anon_name)
-- 
2.43.0.429.g432eaa2c6b-goog


