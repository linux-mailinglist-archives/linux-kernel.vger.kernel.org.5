Return-Path: <linux-kernel+bounces-156005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E858AFC8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBF728439C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010753E14;
	Tue, 23 Apr 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gV79sV/w"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676B53398
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914870; cv=none; b=ZO9hqEByimEEqAZWmXap0h43LodgV/zOVeXSFMN+j44Gud6WyTqPDmpc+2UrZhTVN4VcqC/XED9hKeF7qWx0PPM1P48/iONvWW5dDMErRcKwuuvF1WRfOFOpe2Xs+IkWMfUwtN+lgF0Lrj6vYlhRsekqSIoKQc/tx1DrXPx40yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914870; c=relaxed/simple;
	bh=VhRUrMgDXvxrbFcK977T8yS4Vw+MmwCzKPPOBPrfvio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UwGWl2pa8HiFlGfyFywMaOtUUFs3KVqMzlMxu9bfHIt8qCcYEhwRbJICHLyuxlVyIYgK9+qpmXzmYo6fa1nLq9aNZz9E2HKvbvg7CQgCXqD9ehmJFU4h0axD+0G/eC2XwBizzBEqP9Yta+cOA2iDbVBtmT9swFU7JhH0qeF4asE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gV79sV/w; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-417fb8195d7so29796885e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713914867; x=1714519667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaFaT9yjXtresVS5HFOg4DBcxHZeTWd1pZVR5Za+Mxc=;
        b=gV79sV/wpw+PwVFufPOBxghtSO+aHsjJ3kOxTNtnQakAQzPxTh6S3mF6Hi8B8bXR8y
         dDpK0niANFmAL+I1ERO11b1Y9dObETpYysa4sguhEi6jk6X7ujqmCMIr60FJs6Rey0ZJ
         py2YODRSnzk76H0xjNGUs0V76p+9xHguzuwM/jhHeJdKpy/SfT2nEJNP34k7zqxgjQNQ
         5zKxPnk60vQ2IQvmzRjmHa+k87uygH+/t0GBO1kvr48UPXvpXmmKQGphd7AbQdti1J5d
         a9gUsSzA4+fSBH8SvvHNHcSrMD7vTuABwW2swr1E1Tr+2l5gUHDdMfIZr+PE9ZiEqEtS
         nnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914867; x=1714519667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaFaT9yjXtresVS5HFOg4DBcxHZeTWd1pZVR5Za+Mxc=;
        b=f6LGKa9lRgvhXds+5jKGIo/3iv1CJfPS5WEqNxJF/NaIU5j333j25vpzK900vOvvvu
         sTXFjaaZ+IevSuxsfx/au8EOzLIk71+u2l1LaRyCeuuvGAzgiR5HaSKhKKve3h6pSXm0
         t1eqd9tqd5GXkRBv5g25QMx/2Pgv2Ex0BovSb+IKNz0TIfjqja5BIHDXc67k7apJOgA6
         hORLsLSAFCaO/rePRnrpl5VftqiEHJvaI/ob1EwxAtwY2iqydLZGIv+QHhwistoSK9Ow
         dSsvQsSy8fKEwVaD0Nh2nXcbq3Jju/kaEwhHv/gX+4pdhEydWD/gOLq8OM2yhiYXbV8B
         B+ew==
X-Forwarded-Encrypted: i=1; AJvYcCU6G8IXxb00veuarXBV0t4mo8O3Ng1xk6OsuoApUTRRCa68tLn5BeFUS/nxJGXQdi286G3aHS7/ttHUUcJbBTSuAMFbgIxk4yuTpOil
X-Gm-Message-State: AOJu0Yz3eUOHjdoZzV+77k8TGQbQf9lFQrSeX2d3Cx+ZZSFwftGH5Lep
	aDSOOmzHCHcyNVUonIOnxV3D1GoFZHNgQwbJzQ6jrt2QyZxm7PdYoJWwt4+1hFOHf5ZvI9+PG2d
	PwBmlpzrTRQx+WKn45A==
X-Google-Smtp-Source: AGHT+IFCDABCADdFLnD0phykkbD9Gu5AIQBZ62UxA/EhQAKHMu7J7egaT2rm+tUe6aiIMaJ0/Tc/k/iDgGFOOjAe
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:600c:5352:b0:41a:3485:19c4 with
 SMTP id hi18-20020a05600c535200b0041a348519c4mr3395wmb.3.1713914867196; Tue,
 23 Apr 2024 16:27:47 -0700 (PDT)
Date: Wed, 24 Apr 2024 00:27:26 +0100
In-Reply-To: <20240423232728.1492340-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423232728.1492340-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423232728.1492340-4-vdonnefort@google.com>
Subject: [PATCH v21 3/5] tracing: Allow user-space mapping of the ring-buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, linux-mm@kvack.org
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

CC: <linux-mm@kvack.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index b682e9925539..bd1066754220 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -43,4 +43,6 @@ struct trace_buffer_meta {
 	__u64	Reserved2;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
+
 #endif /* _TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 233d1af39fff..a35e7f598233 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1191,6 +1191,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
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
@@ -1323,7 +1329,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
 	lockdep_assert_held(&trace_types_lock);
 
 	spin_lock(&tr->snapshot_trigger_lock);
-	if (tr->snapshot == UINT_MAX) {
+	if (tr->snapshot == UINT_MAX || tr->mapped) {
 		spin_unlock(&tr->snapshot_trigger_lock);
 		return -EBUSY;
 	}
@@ -6068,7 +6074,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8194,15 +8200,32 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
+					       iter->tr->buffer_percent,
+					       NULL, NULL);
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
 
 	/* Make sure the waiters see the new wait_index */
@@ -8214,6 +8237,76 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 	return 0;
 }
 
+#ifdef CONFIG_TRACER_MAX_TRACE
+static int get_snapshot_map(struct trace_array *tr)
+{
+	int err = 0;
+
+	/*
+	 * Called with mmap_lock held. lockdep would be unhappy if we would now
+	 * take trace_types_lock. Instead use the specific
+	 * snapshot_trigger_lock.
+	 */
+	spin_lock(&tr->snapshot_trigger_lock);
+
+	if (tr->snapshot || tr->mapped == UINT_MAX)
+		err = -EBUSY;
+	else
+		tr->mapped++;
+
+	spin_unlock(&tr->snapshot_trigger_lock);
+
+	/* Wait for update_max_tr() to observe iter->tr->mapped */
+	if (tr->mapped == 1)
+		synchronize_rcu();
+
+	return err;
+
+}
+static void put_snapshot_map(struct trace_array *tr)
+{
+	spin_lock(&tr->snapshot_trigger_lock);
+	if (!WARN_ON(!tr->mapped))
+		tr->mapped--;
+	spin_unlock(&tr->snapshot_trigger_lock);
+}
+#else
+static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
+static inline void put_snapshot_map(struct trace_array *tr) { }
+#endif
+
+static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = vma->vm_file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
+	put_snapshot_map(iter->tr);
+}
+
+static const struct vm_operations_struct tracing_buffers_vmops = {
+	.close		= tracing_buffers_mmap_close,
+};
+
+static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct ftrace_buffer_info *info = filp->private_data;
+	struct trace_iterator *iter = &info->iter;
+	int ret = 0;
+
+	ret = get_snapshot_map(iter->tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
+	if (ret)
+		put_snapshot_map(iter->tr);
+
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ret;
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8223,6 +8316,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 64450615ca0c..749a182dab48 100644
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
2.44.0.769.g3c40516874-goog


