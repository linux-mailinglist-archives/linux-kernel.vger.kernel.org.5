Return-Path: <linux-kernel+bounces-35161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E94838CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A391C23C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4A5D72E;
	Tue, 23 Jan 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2q7MsmH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769A5C911
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706008093; cv=none; b=b4knoCIFEGU0WwB0gZrDfpiA92jU4rbRsQcpEC2ktAbIFIqT7L1+Jm6CWWL1Q87wwsPd27EYqLf6OfIfv/6iC1Q201UCCA4MNWvYpiIETgyHae+UNeSZQJYYYfL4WwsQeA4bnsAc+XLjHZdKaz2iHhpQNQAPDz2aJ/mh+cAQlTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706008093; c=relaxed/simple;
	bh=LpOg75oVVjHVZ5zcMj1Cygednq+3XV9tdhxoOBosZSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6KmHUll8tVYvHoHvZm1Tbkl6ZOPPrQDZtL0gIB5QxIMy2b1WAL6oA9d9D26eq8pIk/F6pqxUv9VuveEe3zUNiC/yaAECzi01YntI3QDlboRpgKEiOZmpLRUlUX+BWAaNN53iIkbakisQTMwWwSFO0+axOE8mdYvyV1oSFS/MHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2q7MsmH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc21df30950so7459957276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706008090; x=1706612890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr7C1cm+K+0sbZ2jJ1EOt2NrKO81ZGlkB1FGvQN+/xc=;
        b=j2q7MsmHrELBsmjUcQ82/8B0F4gwBmxh6LZ2io3YbAwEDEAxJVh3YLR/O0BgEwzqRe
         j8eAZeLjnbYP0HbcMR4ZCRmyFn5SbvaTx+tHAsNqcYAVC+kWuU6IlBavp2eaFIb8uEJa
         ptEKS01h8OLFKSK2waPcf5PYPJ2JX9UPHc8zPJs05vDnMrXYse9wSsIdwR4dwcYCDk1f
         Ib7m0sUqr8wLsqpYj7MRm5rm3wjRf9RBRdCuznL9RThnhMOC0EMXDolAC8j6CVBSdHOz
         2lbdlFn04VXQeSgAvVv/vC9YHkBxBT/OmIND+wzih1WaiY1t/WexyGBdeC+SQ+bQ7jyM
         NmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706008090; x=1706612890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr7C1cm+K+0sbZ2jJ1EOt2NrKO81ZGlkB1FGvQN+/xc=;
        b=p0Ms+bib2rtSpJOsHPkgXqW9jLyZiX1u8j/k7ikOkXaQ7kX/VfjHobjX0mPuYJ6XQI
         QJdOiJWwma/p+5yOR4k0vofEPGFH/+WAXyipVh3ygU//FI4lD/knCUhMd61IO1+UFH2g
         20KZgTx6y/HXfT5jtAgivqv90mOHqarLP5qYuAfidxgPL7XGAhCWaSNyfyiNlspVhZRi
         UriQHC7cYDl+Ira52Iq1F9KckExnobRW7AKsaH/iGT6pRByuZN9FC8ejv9W99fNthDMj
         XjMOHd6vpB018ZSixpACKeztEOdGeVz1eScpo5ZyhCa/a4iEBERwSqC51sbZhQkXkMla
         tkAw==
X-Gm-Message-State: AOJu0YzrpGjH+WmGYXI8bfYEZ3aeOs4uxcvkj8b08nZJ0zfeNqfSyc86
	TxSUq32lujfzhrXzQ1ppObvHSeCvjXpwQ5KrrBG6faTyFYheqzU89IaEvNO5Cd+THAUz48EUYTd
	XmyVoKaCILI9e8CveWw==
X-Google-Smtp-Source: AGHT+IFIyDVggOlHUuSF0i46wk6Y9mpErXwWsnI9RT508ATRbK2lbJzxqsXgHRS4RWrxxOVJKckQ9qtccIT8EXCj
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:1b12:b0:db5:4766:e363 with
 SMTP id eh18-20020a0569021b1200b00db54766e363mr2514419ybb.6.1706008090555;
 Tue, 23 Jan 2024 03:08:10 -0800 (PST)
Date: Tue, 23 Jan 2024 11:07:55 +0000
In-Reply-To: <20240123110757.3657908-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123110757.3657908-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123110757.3657908-5-vdonnefort@google.com>
Subject: [PATCH v12 4/6] tracing: Allow user-space mapping of the ring-buffer
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

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index 5468afc94be7..09c4ae6d6e71 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -41,4 +41,6 @@ struct trace_buffer_meta {
 	__u64	subbufs_lost;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ac59321a8d95..eb9e829ecc12 100644
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
@@ -1309,6 +1315,9 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	if (tr->snapshot == UINT_MAX)
 		return -EBUSY;
 
+	if (tr->mapped)
+		return -EBUSY;
+
 	ret = tracing_alloc_snapshot_instance(tr);
 	if (ret)
 		return ret;
@@ -6520,7 +6529,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8637,15 +8646,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
+	int err;
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent);
+			if (err)
+				return err;
+		}
+
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
@@ -8658,6 +8683,90 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+
+	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	mutex_lock(&trace_types_lock);
+	if (!WARN_ON(!iter->tr->mapped))
+		iter->tr->mapped--;
+	mutex_unlock(&trace_types_lock);
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
+	int ret = 0;
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	mutex_lock(&trace_types_lock);
+	if (iter->tr->snapshot || iter->tr->mapped == INT_MAX) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (!iter->tr->mapped++)
+		synchronize_rcu();
+#endif
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	if (ret)
+		iter->tr->mapped--;
+unlock:
+	mutex_unlock(&trace_types_lock);
+#endif
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8666,6 +8775,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3aa06bd5e48d..25ec246d5f1e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -335,6 +335,7 @@ struct trace_array {
 	struct array_buffer	max_buffer;
 	bool			allocated_snapshot;
 	unsigned int		snapshot;
+	int			mapped;
 #endif
 #ifdef CONFIG_TRACER_MAX_TRACE
 	unsigned long		max_latency;
-- 
2.43.0.429.g432eaa2c6b-goog


