Return-Path: <linux-kernel+bounces-53019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E71849F8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575FB1F23CA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103E645035;
	Mon,  5 Feb 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8XJzqh5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9744C6F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150870; cv=none; b=NfTl0g0sdCXbYWwQxG0eutaFjm7Q1dM7ZRs+IWaoQnpIEeVk70Xky205mJRq6dANBJtF2zyc5vetd8FEifMI8Qhr+qWtPeYH+92iIM2H/keiPf+cPoOkA/AWiq4Mescik5NrDD7Yf+M3b030kDJoGq6Kws1Zzcy1nEKb1844tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150870; c=relaxed/simple;
	bh=Bqyi0ICVEBYrJJMGXLGA+v+nMZe2jifnBmWShjN4Oew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o0C6qEZ3v83DnMgkJp/1pzIm5lCRBPzzdJvfhKQa1B7q2VpEQTi1ZXaxqx5qYON3zVYJZ9HguHYt0s7cE+eOi5sAzEWVztsJiBfhOLlVuYSwtou8BvJXZzBqckJklMa31+rAefnoA2WSxrEAq3Qvn1mjmAav2QmUXDO1Xw5r2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8XJzqh5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso26319865e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707150866; x=1707755666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czI6QKRPuD+UhsFBM8noEszZVdGtsHH2blT9IiCFAMo=;
        b=b8XJzqh5UAFYWVdVBErgoiGQ8wrzOcpr6VUFBHCDx3dSZgybfqdxQlp6U/NyKtrFMM
         kvZNsXjNRe0mVhpG6EyseYDjcKpDcBNrdYLOwDGqAwuoLdN1IfWxeLCMzv23FzNLQtZU
         +REpwT6AWsxOrvIp26SB5VB8fdZrDREvQIIPLu7I7GAh/qs5hlWq5l8QjqXOKd6BRqOr
         rslQZmru6l8T+mOho6za8YJpkjHoxBbMbJNkTac4jCpolRiSZScdF9HSzQVMrPpK4jE2
         468aUkkb81TMSNLMYM2m+N5E+IVx0iArxAwkdTYEbuhJrStAv5px55GaPxyq65q5FEkL
         pk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150866; x=1707755666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czI6QKRPuD+UhsFBM8noEszZVdGtsHH2blT9IiCFAMo=;
        b=l0bW4HRdIcyt73sGvyzsNf4BnNZdLxokRYiuE9MXgugbw5GMUXCVQf8pD2GLwMssHa
         mB4wxn2Md/MBvIbyIg7EOmItVQTqv31IDQLt7Oh5dhqDE7lpG37RQabkp4bGxpSJ7mHA
         kZTZsvJ42Wv1wYI+6duMZyIXdqMcSwcRW5Yy4ftCyN0DEh3enWAXwm9rr5yKteH4adL6
         SH0wLCQX/5Dwsdm1tOChQfNZVWvTXDhdJT7hqhTVbISSywrP3fpQAz9wCyLaobedN05y
         9Er8K7GF3xUs0vM8Gy2x/XQY/mHiM09/d7r4mL5z+Ra4ZcNI/6mbnVdSEkeWx7ymTr1T
         0+Zw==
X-Gm-Message-State: AOJu0YwKkOuw+udcQOdntxx2fM/WDSFRt/MatdnVW7luBaoNLIhUhz7I
	6ln7+GE521l+WaF8RoAHP6mAOf6YX6w7PSk6a7jYI6hLu3+uRJUAe57tflGESujZhtiyEx8hmcI
	hErAzR7+raFKCqBp/gw==
X-Google-Smtp-Source: AGHT+IGnWbdD8C95UvgUBky6yne3dWY2zB8UoFU9+lB7hmfYbBNV+6e5uf0uyKnetvUvv1sJUFl2CJkx7pboDy9H
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:b96:b0:40f:df2b:6843 with SMTP
 id fl22-20020a05600c0b9600b0040fdf2b6843mr590wmb.3.1707150866597; Mon, 05 Feb
 2024 08:34:26 -0800 (PST)
Date: Mon,  5 Feb 2024 16:34:08 +0000
In-Reply-To: <20240205163410.2296552-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205163410.2296552-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205163410.2296552-5-vdonnefort@google.com>
Subject: [PATCH v14 4/6] tracing: Allow user-space mapping of the ring-buffer
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
index 4ebf4d0bd14c..36b62cf2fb3f 100644
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
+	struct trace_array *tr = iter->tr;
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
+	struct trace_array *tr = iter->tr;
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE)
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
2.43.0.594.gd9cf4e227d-goog


