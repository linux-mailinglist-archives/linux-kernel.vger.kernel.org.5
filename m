Return-Path: <linux-kernel+bounces-32416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD8835B74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435E7B24BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D315AF5;
	Mon, 22 Jan 2024 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nv+KkvTo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3F125B9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907616; cv=none; b=fDeoqnWh+sDbHa7hdAka3SYLZoKbL7sF+iE5r8W073zZ0DvLHVGS72/rtjkTUruR7kSkyZ6982Y3ahT00RxYYRloqXxrnIieB22n3Y1dYZD+Kmf9WLjvnswluEwfqoOVGzjj7Iqp+yLmZfPCLIGBkzFNg+7J8uL5Nctpk9snKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907616; c=relaxed/simple;
	bh=Q4c5kAQB/tihMQ4sonqfCtbk7g6WtRsFX1gU0E6agKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TyQ8cKbaucy7ShPAgEOSRCMM4hpm420hBe55JfCxYkIYFF26HGp8SF/SMCfNlpn6QAXr7VFpf3HL1BJl52DoJh51LW7mPqItrO2PGIGjPoy1m+HxazRaW9F3s5xI7Y/tJ5Bd0054YTSOZ/82TBzL5YEN/01XLVDhyvxZTu+TCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nv+KkvTo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f53b4554b6so38600617b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705907613; x=1706512413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pm6LGPn0g5uP1lRXkRkuwE07r5wy4EXy2R/IId+4s5Y=;
        b=Nv+KkvToXtL3NAC2LApO/y0zwVfomGjye0FD+j0U5teteYMGoGEa4/oaLHhUK6eBn0
         bXPvDUHjwoGKWAZhCowMrIonl7J+yUwsyTEhHy6RDtD7SG0LWVOXlHzRyK9niqdw/Pw7
         kpOzkGY+YkktZHQr/dr9ptU05NY/zvxr+Z+3G0seLVaT6QYjNU3HGzE2UJoSO4C/q5J2
         TivSWrMUfRUh7MmnE0XacQi8X1svM4kWG+/4Xi13TOZaF3PRwy5yDW9miv+8uYyn92Wt
         pV0FQSv3KsdThEEWfYaQwD6Cs/lx9wtxaF8FTAyAfAz4J55yZ/KGwnKE07rAn7C2ScJA
         dp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907613; x=1706512413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm6LGPn0g5uP1lRXkRkuwE07r5wy4EXy2R/IId+4s5Y=;
        b=mIXPM3PC2RFr99QRZmATNNOHxaznAkh2/j2LZ5azZht5TD/SqSTGOOuCLCROeQgshv
         kuNrcWkLKpwJYeebRmB5GnPQtW6YsHQshir1uvTy1qDUAZWlDdOuqHSmhxrxA+s3+69f
         FQkuj9iPVh98E074juubwIHoHHN0rZtN+txvLar0H7yujY/slld6fWpkRyaaeTRqUVph
         0gCc2Ukp8pvhbf6ugWkyKagS55tZiFR8Vk13UeIRCgpAqslitBoVnW1F/DQpoVPjy9Rz
         UPQhMnhT56wQxXUiV5LUNVdYpnbyk2nxEdN8rfiUttQrYqqAtSRb0fZmbgGjQbBeakjT
         o6BQ==
X-Gm-Message-State: AOJu0Yza77nAAjlAtJZtnOEZhSHYZq8aUZXsgdkdwghw6XOWPqdyo+or
	SLOLgO/4LRnD5AZxLlJbmijV4H+N8HSR5h6SnNyCxky2doJdbCNPA0TJHKrLVgN9TJCJunxPg+5
	gRw==
X-Google-Smtp-Source: AGHT+IH/iYjVx28BB70L/Axhud1gI/xXkTJNuH9QVTuj4mqjLNYD8CKXEzHkMSgNYwCDkSwAyquSZSHHvqg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:4979:1d79:d572:5708])
 (user=surenb job=sendgmr) by 2002:a81:9847:0:b0:5e7:12cc:a60f with SMTP id
 p68-20020a819847000000b005e712cca60fmr1362943ywg.6.1705907613421; Sun, 21 Jan
 2024 23:13:33 -0800 (PST)
Date: Sun, 21 Jan 2024 23:13:24 -0800
In-Reply-To: <20240122071324.2099712-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122071324.2099712-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122071324.2099712-3-surenb@google.com>
Subject: [PATCH 3/3] mm/maps: read proc/pid/maps under RCU
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

With maple_tree supporting vma tree traversal under RCU and per-vma locks
making vma access RCU-safe, /proc/pid/maps can be read under RCU and
without the need to read-lock mmap_lock. However vma content can change
from under us, therefore we make a copy of the vma and we pin pointer
fields used when generating the output (currently only vm_file and
anon_name). Afterwards we check for concurrent address space
modifications, wait for them to end and retry. That last check is needed
to avoid possibility of missing a vma during concurrent maple_tree
node replacement, which might report a NULL when a vma is replaced
with another one. While we take the mmap_lock for reading during such
contention, we do that momentarily only to record new mm_wr_seq counter.
This change is designed to reduce mmap_lock contention and prevent a
process reading /proc/pid/maps files (often a low priority task, such as
monitoring/data collection services) from blocking address space updates.

Note that this change has a userspace visible disadvantage: it allows for
sub-page data tearing as opposed to the previous mechanism where data
tearing could happen only between pages of generated output data.
Since current userspace considers data tearing between pages to be
acceptable, we assume is will be able to handle sub-page data tearing
as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/proc/internal.h |   2 +
 fs/proc/task_mmu.c | 114 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584..e0247225bb68 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -290,6 +290,8 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	unsigned long mm_wr_seq;
+	struct vm_area_struct vma_copy;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..3886d04afc01 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -126,11 +126,96 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static const struct seq_operations proc_pid_maps_op;
+/*
+ * Take VMA snapshot and pin vm_file and anon_name as they are used by
+ * show_map_vma.
+ */
+static int get_vma_snapshow(struct proc_maps_private *priv, struct vm_area_struct *vma)
 {
+	struct vm_area_struct *copy = &priv->vma_copy;
+	int ret = -EAGAIN;
+
+	memcpy(copy, vma, sizeof(*vma));
+	if (copy->vm_file && !get_file_rcu(&copy->vm_file))
+		goto out;
+
+	if (copy->anon_name && !anon_vma_name_get_rcu(copy))
+		goto put_file;
+
+	if (priv->mm_wr_seq == mmap_write_seq_read(priv->mm))
+		return 0;
+
+	/* Address space got modified, vma might be stale. Wait and retry. */
+	rcu_read_unlock();
+	ret = mmap_read_lock_killable(priv->mm);
+	mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
+	mmap_read_unlock(priv->mm);
+	rcu_read_lock();
+
+	if (!ret)
+		ret = -EAGAIN; /* no other errors, ok to retry */
+
+	if (copy->anon_name)
+		anon_vma_name_put(copy->anon_name);
+put_file:
+	if (copy->vm_file)
+		fput(copy->vm_file);
+out:
+	return ret;
+}
+
+static void put_vma_snapshot(struct proc_maps_private *priv)
+{
+	struct vm_area_struct *vma = &priv->vma_copy;
+
+	if (vma->anon_name)
+		anon_vma_name_put(vma->anon_name);
+	if (vma->vm_file)
+		fput(vma->vm_file);
+}
+
+static inline bool needs_mmap_lock(struct seq_file *m)
+{
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read under RCU.
+	 */
+	return m->op != &proc_pid_maps_op;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+/* Without per-vma locks VMA access is not RCU-safe */
+static inline bool needs_mmap_lock(struct seq_file *m) { return true; }
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
+{
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = vma_next(&priv->iter);
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (vma && !needs_mmap_lock(m)) {
+		int ret;
+
+		put_vma_snapshot(priv);
+		while ((ret = get_vma_snapshow(priv, vma)) == -EAGAIN) {
+			/* lookup the vma at the last position again */
+			vma_iter_init(&priv->iter, priv->mm, *ppos);
+			vma = vma_next(&priv->iter);
+		}
+
+		if (ret) {
+			put_vma_snapshot(priv);
+			return NULL;
+		}
+		vma = &priv->vma_copy;
+	}
+#endif
 	if (vma) {
 		*ppos = vma->vm_start;
 	} else {
@@ -169,12 +254,20 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
+	/* Drop mmap_lock if possible */
+	if (!needs_mmap_lock(m)) {
+		mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
+		mmap_read_unlock(priv->mm);
+		rcu_read_lock();
+		memset(&priv->vma_copy, 0, sizeof(priv->vma_copy));
+	}
+
 	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
 	if (last_addr == -2UL)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
@@ -183,7 +276,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 		*ppos = -1UL;
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -195,7 +288,10 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	if (needs_mmap_lock(m))
+		mmap_read_unlock(mm);
+	else
+		rcu_read_unlock();
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -283,8 +379,10 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
-	if (mm)
-		anon_name = anon_vma_name(vma);
+	if (mm) {
+		anon_name = needs_mmap_lock(m) ? anon_vma_name(vma) :
+				anon_vma_name_get_rcu(vma);
+	}
 
 	/*
 	 * Print the dentry name for named mappings, and a
@@ -338,6 +436,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		seq_puts(m, name);
 	}
 	seq_putc(m, '\n');
+	if (anon_name && !needs_mmap_lock(m))
+		anon_vma_name_put(anon_name);
 }
 
 static int show_map(struct seq_file *m, void *v)
-- 
2.43.0.429.g432eaa2c6b-goog


