Return-Path: <linux-kernel+bounces-59614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3284F9B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C691F22602
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BCC7F48F;
	Fri,  9 Feb 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cq2V1HLt"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FB7EF03
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496509; cv=none; b=EjnrzNMcK4vmxwaF7SbnK4BgdyO5CbqqBz518ouuwyp5xZPXbJp8pJTmHdLrajPyiQgvu00uZcAuRjj8K7eRgmJjrnI73mdzBJQEECFihcEEiVDBDPzp771MWoXwYAGcX2SnTU0LbjeV0ILJROWC6dznWzD6c52TY+yv1hFDFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496509; c=relaxed/simple;
	bh=POwIaSakA3P7VN3DoSdTZ1HOoCQpnAoqCCz15gHTKd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otf9cPBH6IRjCk46VDGBQYtu8F84pUN/ThuJs1QwARiRr98Bm2kleOQwU1RcRjQqwh1KIiiAxzhwtU+1HlU1hEhYkeeg/bWc0xDvxZ7NNA0r+uef7kjUJyDSecwX60VmqPvKtvhKgEBE4BsZuRjAAOHBe8H/X+tzVerMCKydpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cq2V1HLt; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40fd2fe490bso9987835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707496505; x=1708101305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eG/PuLIoWB8LKFjP4cPEQOG7vgr5hu+n2RMYn2R0is=;
        b=Cq2V1HLt/WvU3mF0qGLfWgGkkkxwuiAoivJ7JGt4Wp/MqdG+9t66o8iQ01WS1Jw02K
         um4k4coU3tbWhpp/nlxkzo77sWSmkLrdrLpjbRkngNU8fkh6RIIe2ZrOq/BmnOqwlSaL
         57UfyW3wifEFCJ9/83B79DQAA+TpYG6SxfZx/VobsaCDuzgAckMUlUll92wWzeYkjZiq
         4bdIXQiXbr3Vk427p7Z35T1fo/zGqAyMfjRDG+JqIj9grworK/UQ+olDiOE72y0EBfeO
         oJo+XwGtvyMN47JRQIcXLnvI7OG5NDRKb2oeGwSxWv+Z/AiH/GLXwEY1yZuL7DGy274y
         RqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496505; x=1708101305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eG/PuLIoWB8LKFjP4cPEQOG7vgr5hu+n2RMYn2R0is=;
        b=Hle+80zSm6eqECFVbc4DDlMVBHyP7Pz2QD+O5N1sZWAD6R5tCUKOUZ8RBydpBkJH1T
         awQKUf9k07PjmkMwSQFLtLazB2EIcEWL+qFGV0E+iQ7qp7kCNvFVsVgxrFVtt+IXaiiU
         E20VJiiCrN1d75o5wuz7rORr6BPBCovd85FvzrGrXafU1Pc3HyEz92IHhsuqwHSOGxSk
         dHA9fIAAqyxcmmNd1MD7YvuNyOZMkN7x9+rBxEPSEmTDfgbSoXE2bHcsVmWQatk8JWpX
         rT86wrwlSgQyV70YVo4Jd/PwIkNTE1o6REJyjG1wk9hJJjut8LFrONH3S/aIQNSqEq8C
         5Dmg==
X-Forwarded-Encrypted: i=1; AJvYcCWq9pDGQIMH5sWrKugU66ILuPH+5H0cCVVZzoXpZYWQSJhvmPqEzBOeVkexCXlISp9BvasqdwRKB2RRH7qSdbv5yDrqZWSHsCbuIpTS
X-Gm-Message-State: AOJu0YxH5HkPijz6FQWXaS+KMFjfd5vHKMx10vrKaeY4r394Xhs+l8pm
	psHfe7Yd8ihvYKxgTF9mFkehXxDVAdGwqr1TYoAiqTwrF4RLT+UKi/nDsd2wFw75z/hEsv0CQmG
	XesveB4JCdepnPZWIig==
X-Google-Smtp-Source: AGHT+IFsi+dEGssN0ejwDJfld0Mauoxo6HD3YYCA6JJlL+mgYc58K6Zj3QvU+GtNgZPmMLCZCI1R14cKHHJz8ErG
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:1c01:b0:40f:dd0e:b43a with
 SMTP id j1-20020a05600c1c0100b0040fdd0eb43amr23755wms.4.1707496505594; Fri,
 09 Feb 2024 08:35:05 -0800 (PST)
Date: Fri,  9 Feb 2024 16:34:46 +0000
In-Reply-To: <20240209163448.944970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209163448.944970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209163448.944970-5-vdonnefort@google.com>
Subject: [PATCH v16 4/6] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping is exposed via the per-CPU file trace_pipe_raw. The first
element of the mapping is the meta-page. It is followed by each
subbuffer constituting the ring-buffer, ordered by their unique page ID:

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Subbuf ID 0
  * Subbuf ID 1
     ...

It is therefore easy to translate a subbuf ID into an offset in the
mapping:

  reader_id = meta->reader->id;
  reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;

When new data is available, the mapper must call a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
point to the next reader containing unread data.

Mapping will prevent snapshot and buffer size modifications.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index 182e05a3004a..7330249257e7 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,4 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4ebf4d0bd14c..2c0deeedf619 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 		return;
 	}
 
+	if (tr->mapped) {
+		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
+		return;
+	}
+
 	local_irq_save(flags);
 	update_max_tr(tr, current, smp_processor_id(), cond_data);
 	local_irq_restore(flags);
@@ -1307,7 +1313,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	lockdep_assert_held(&trace_types_lock);
 
 	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX) {
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
 		spin_unlock(&tr->snapshot_trigger_lock);
 		return -EBUSY;
 	}
@@ -6533,7 +6539,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8652,15 +8658,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
+	int err;
+
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent);
+			if (err)
+				return err;
+		}
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						  iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8673,6 +8695,97 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
+{
+	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct page *page;
+
+	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
+				     vmf->pgoff);
+	if (!page)
+		return ret;
+
+	get_page(page);
+	vmf->page = page;
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index = vmf->pgoff;
+
+	return 0;
+}
+
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+	struct trace_array __maybe_unused *tr = iter->tr;
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->mapped))
+		tr->mapped--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+#endif
+}
+
+static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.open		= tracing_buffers_mmap_open,
+	.close		= tracing_buffers_mmap_close,
+	.fault		= tracing_buffers_mmap_fault,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+	struct trace_array __maybe_unused *tr = iter->tr;
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * We hold mmap_lock here. lockdep would be unhappy if we would now take
+	 * trace_types_lock. Instead use the specific snapshot_trigger_lock.
+	 */
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (tr->snapshot || tr->mapped == UINT_MAX) {
+		spin_unlock(&tr->snapshot_trigger_lock);
+		return -EBUSY;
+	}
+	tr->mapped++;
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (tr->mapped == 1)
+		synchronize_rcu();
+#endif
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (ret) {
+		spin_lock(&tr->snapshot_trigger_lock);
+		iter->tr->mapped--;
+		spin_unlock(&tr->snapshot_trigger_lock);
+	}
+#endif
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8681,6 +8794,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd312e9afe25..8a96e7a89e6b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -336,6 +336,7 @@ struct trace_array {
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
+	unsigned int		mapped;
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
-- 
2.43.0.687.g38aa6559b0-goog


