Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010C3767268
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjG1Qux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbjG1QuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:50:18 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90E59C5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:53 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso1202333f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690562893; x=1691167693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ss9MUA3Tr56YAsWyllu6HM14rw2I4XzRyajq/SbgYxY=;
        b=4c5l0dRm/bFC3tsehp6MrNkqMUm+BOvSlEM5xvMAprLXVe3P7IyU3LOlmODS/ChG0l
         BHw3u9pjVmhR21N7+TXS2DdTz2M4Kyu7sm5xonA6y5RjqQLU3N2wNle1/fBkSBMSq4aI
         budE9554Zm4Fj2UPe2sG4I5MXtx9tQC2gIyzeE0Vi8BLBB27ADgqzuR8m+CN1vf5jce4
         4UV5BCnEHTFzyT4JPcqo8IfBJgtO11Wxx5Kq6bx1hoV2FfVF8s8qKsIDCoghNn8ZdCDV
         Fwnd8NgicwZn1bx8Cp119wPidRYOxQlWWs8z/ZmeGTCG/oxjlIXdkTpDuLOGvSYY4Lze
         tiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562893; x=1691167693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss9MUA3Tr56YAsWyllu6HM14rw2I4XzRyajq/SbgYxY=;
        b=AYd3ncVEwRE1kasmQhEnvtL3T7nRo6fPEQgGmTbsBuDGa8OqauCjUi4XA4+3fv1OT7
         vTyNwxJ17fGHn8Fx9I7cJgo30lnKE3cK5c34KwH34KU2pD/GcB/zVshcU4Z7mJPxRSXR
         9b9ZO/K+QU/OGroaGdh4Ip4o8tu6+AjKzLxdzXP3Jc22psMDsKGmr6AbJRHZl0pkpyR7
         D1vlqZAQ6pYg7ilkfrus0pqVvYjEjzla2vrlY78WkUccer+Se8RdpRfMJo0wvJ962xq7
         2itR029xaI8yaSX8RIzSX3wVbAKU8FTXHu1Gv0qYzssbLyl8KRs1Oo//66J3QwftKk+g
         tbYw==
X-Gm-Message-State: ABy/qLbtawuLUTB/c7K25zQznvSitpr4np5cQMM1UGsCDa2gQpOxAquT
        W+VEO6Gz1Z8cbqY5mvBxa2NoYKjCk2gYhGBa
X-Google-Smtp-Source: APBJJlE4iRbPMO0jdJvQOOvJEL7qN8hQVRczTqoiowzZ3DLigKFhhjDYpkpMbm9tFqX4bbDGpvqqXtMfjpRuEYZE
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:43ce:0:b0:317:7514:100a with SMTP
 id v14-20020a5d43ce000000b003177514100amr23308wrr.6.1690562892607; Fri, 28
 Jul 2023 09:48:12 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:47:54 +0100
In-Reply-To: <20230728164754.460767-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230728164754.460767-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230728164754.460767-3-vdonnefort@google.com>
Subject: [PATCH v5 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, user-space extracts data from the ring-buffer via splice,
which is handy for storage or network sharing. However, due to splice
limitations, it is imposible to do real-time analysis without a copy.

A solution for that problem is to let the user-space map the ring-buffer
directly.

The mapping exposed via the per-CPU file trace_pipe_raw. The first page
is the meta-page and is followed by each page of the ring-buffer,
ordered by their unique page ID. It is therefore easy to translate a
page-ID to an offset in the mapping.

  * Meta-page -- include/uapi/linux/trace_mmap.h for a description
  * Page ID 0
  * Page ID 1
     ...

The mapper must then do what use to be the kernel job: swap the reader
with the head. This is done with a newly introduced ioctl:
TRACE_MMAP_IOCTL_GET_READER_PAGE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
index 653176cc50bc..fd323a92cf78 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -23,4 +23,6 @@ struct ring_buffer_meta {
 	} reader_page;
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..849d2d1c73fe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6461,7 +6461,7 @@ static void tracing_set_nop(struct trace_array *tr)
 {
 	if (tr->current_trace == &nop_trace)
 		return;
-	
+
 	tr->current_trace->enabled--;
 
 	if (tr->current_trace->reset)
@@ -8495,15 +8495,21 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	return ret;
 }
 
-/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
 static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct ftrace_buffer_info *info = file->private_data;
 	struct trace_iterator *iter = &info->iter;
 
-	if (cmd)
-		return -ENOIOCTLCMD;
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE)
+		return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
+						       iter->cpu_file);
+	else if (cmd)
+		return -ENOTTY;
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8516,6 +8522,63 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
+	vmf->page = page;
+
+	get_page(vmf->page);
+	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
+	vmf->page->index   = vmf->pgoff;
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
+
+	if (vma->vm_flags & VM_WRITE)
+		return -EPERM;
+
+	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
+	vma->vm_ops = &tracing_buffers_vmops;
+
+	return ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
+}
+
 static const struct file_operations tracing_buffers_fops = {
 	.open		= tracing_buffers_open,
 	.read		= tracing_buffers_read,
@@ -8524,6 +8587,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.41.0.487.g6d72f3e995-goog

