Return-Path: <linux-kernel+bounces-42902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFE84084B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D372894C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629D12BF27;
	Mon, 29 Jan 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdUSRWbc"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A786AF9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538503; cv=none; b=ULVk44JnBi+zgfxbUjs9nAcBTUP7eRIAahqE+DAl/tY9ND9woPqDGd542zdrz9NX0Xp2tiodGelrQnOxYEoNJaS+XCpkDSfMdMBDtfcMAqFKXybrig8TD5K3I/Ut2N57EQg1n7PGQM5R93yGP7/+jB4rr1XI/l1/VoFClfuBvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538503; c=relaxed/simple;
	bh=8l3Xro9CGBurtt6Wge/Qc8D/2BsLWQZglREppaxWwFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8TzQgLkDjdO5cMsfgRAS4xrcxytOLU17s7n0bh9fnowWR52C54/1qaP8aAUiN+huM62x777azqVcYcdlcIWEC5JilWOqAd3PeeYfwAQ/qGV4cjv0rLhufrkQ5FopXpm0XCG1oHbQZdoMK9mNtyxAcV/Ptu2JyRWJkzbe0Gw2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdUSRWbc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33aebf85ce9so525244f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706538499; x=1707143299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4qRXjTQVo0RcEeMrfJKcOpRJsj7Drr77yBnbAPk5yc=;
        b=BdUSRWbcguyJDEsJCjKtITa7EZ0+0gaiBxw3y5oNWclEieaTEjUtts/TYvOcDBCjjZ
         kvjcIVGpBgq+qlaq9K6YaJO8Vl07/e+UMuIA/xFgfiVsJxo6qu6ablaF9QzB6LSWqggZ
         U/d2zo3V25w/N1xFIwb1R8AS6mdSLqE4caZnla/8xvSsKvAAHg0mC3coMUOCn5Ynzk6K
         eesNzHgJIak9Taco3Ou9GGokK+jZAlOoxYguzdot5HiWBu7CK/MwnPoZbUddB6mUtn9B
         5lH+9LcqNFnclJf7Kb/y0mGX2hWiFvwGeBGm/OOiLJcYU/YD+Gl7R3+8o0x0LUPTYJ8F
         DkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538499; x=1707143299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4qRXjTQVo0RcEeMrfJKcOpRJsj7Drr77yBnbAPk5yc=;
        b=gdSsdXJLy6ooFNLj9PkXxNMlSnnDXCB1DwAqwI5jB+uovkeLID/pUkw4O4iz3vGpI2
         4Vw5ubd3QSQPEPKODu+fL535vU00tkJuEgDh2WeuiykYN9hLOiYnOUE/PcejV346zgly
         XY/BC9OLrs1IP6K8baeyiB9nnGdfs1q8oXuo91KclVXaHq0pG5rWZ1j2UiB5FvIohi3u
         L5qqMuDoGfum92eoG/vCMdtiXVhAjekvY7IQluFq4M5a9Tq+szsTdPC0moE5y8pY7BTK
         QBhuEbLfGc1oWaxA/XH64eVIJ9MXMpRCxCvIpHXy19nu+FRPhAed2/T2lGCc3y7BjWtz
         ZuAA==
X-Gm-Message-State: AOJu0YzWHWBLbSGyUtezR3yTPfQTnaOD1hqbuL1BrTjpRwYToiSkzmSZ
	tk0ZTz+LGNf8Qyz6Lh/OuUdGgTf6MrUiQw6Ev0DqjEMy9CuwsUGnyiGM1r1nR4XgX601eQxzheM
	gfcvFaDhSHOsjOC3k5g==
X-Google-Smtp-Source: AGHT+IHmkH1z7yYeR+N/ECRqaZAvEnbB97ntUvNCXePl52VlonwtlaoH38d43y7RNVElA2AlaQNU5z99tOKGs82j
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:1f0e:b0:33a:ed58:9c24 with
 SMTP id bv14-20020a0560001f0e00b0033aed589c24mr5183wrb.10.1706538499562; Mon,
 29 Jan 2024 06:28:19 -0800 (PST)
Date: Mon, 29 Jan 2024 14:28:00 +0000
In-Reply-To: <20240129142802.2145305-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129142802.2145305-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129142802.2145305-5-vdonnefort@google.com>
Subject: [PATCH v13 4/6] tracing: Allow user-space mapping of the ring-buffer
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
index d4bb67430719..47194c51a4ac 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -40,4 +40,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b6a0e506b3f9..b570f4519d87 100644
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
@@ -6534,7 +6543,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8653,15 +8662,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
@@ -8674,6 +8699,90 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
@@ -8682,6 +8791,7 @@ static const struct file_operations tracing_buffers_fops = {
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


