Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1E76E8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjHCMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:51:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE3110
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:51:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5840614b13cso15684807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691067113; x=1691671913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J4zJKDo0qVw9nnDi02wK0gUvUvTiEvrCWmDoOMueZ+g=;
        b=cbLncG2zOcIvXhC07TxZZ2AohsMrE3yRXBJp4hWu0igmxn9PNdu7mG8JDPT0CXS1VS
         OcnNUUtpAwN7WZWEfdwNijwZsczhrLwPTgQ2GCqz4OdLe/u57lnxD7qBX+wpcmSFj3ek
         gO2XX8FHNk9tUTP0UJJKmy1/zMKQfOdTnwIhwqhXOYrr8zNbOR+PlqROOrESd9N/ryzR
         dZSu4ETnKqTgZ2WNQjucuJNZm6uszBq52rNjuoPvBt/Tlp+EQLCFJq40mMDOFkzm6Y8F
         vPln6x71dyzK3tkwcxFWm9QhjUrjc9bhQYl0wMkSfXyNKl/UEOkcab3mFuc+Xx8/E66i
         WELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067113; x=1691671913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4zJKDo0qVw9nnDi02wK0gUvUvTiEvrCWmDoOMueZ+g=;
        b=LfzbPrD8PwTW+2Ag4QMDid26+xNByj4BBb9IbAU9acs9h+8n/7zY4oUh1y+cFE+LqF
         kEynhvyTWOrB4DJiYVVqHmtEsvUihYil+ocIAfa5m1YXdvZ8FzdU8Y3DhSCf4ZQRJDlO
         tZYP810VST2o6yzTU3ei8zvuGOnEyLUKWiMHnQbgKBc4pWKkQHBFPuNguX60c/h1GJeY
         KjhCLCbsaJi6vm54Vc25gouQmaczOhmJb9GMk+hc9gdJVlmcjzhME5SKpj1evLSTBtXD
         0suUFKJtfiOCRPjtMFujBZpeXWsuoKfhpe6tbnwrK8ep6hdIORJvSN9tXuNs5TS7BZYB
         lUFw==
X-Gm-Message-State: ABy/qLa5TH9b/MGKVZF76YL8YkQKygVoYHeoIi+ns2Rygv1mlYEmQVDc
        8fP47OJDQ5iiugheVXnqa5Wb3K28i4vSuhYl
X-Google-Smtp-Source: APBJJlH1og4uqd3nlr+a1kPHamVKYDX95Gpj/Lvn/1DldH8F4AoSWkXDsIn/BaJlVDRjPz5RE8ibfc80VUgKw6f7
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a81:c509:0:b0:583:9d8d:fb0d with SMTP
 id k9-20020a81c509000000b005839d8dfb0dmr253224ywi.0.1691067113616; Thu, 03
 Aug 2023 05:51:53 -0700 (PDT)
Date:   Thu,  3 Aug 2023 13:51:37 +0100
In-Reply-To: <20230803125137.1779474-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20230803125137.1779474-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803125137.1779474-3-vdonnefort@google.com>
Subject: [PATCH v6 2/2] tracing: Allow user-space mapping of the ring-buffer
From:   Vincent Donnefort <vdonnefort@google.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
index 41759b9ad9f2..4c915f1d0065 100644
--- a/include/uapi/linux/trace_mmap.h
+++ b/include/uapi/linux/trace_mmap.h
@@ -26,4 +26,6 @@ struct trace_buffer_meta {
 	__u32		nr_data_pages;		/* Number of pages in the ring-buffer */
 };
 
+#define TRACE_MMAP_IOCTL_GET_READER_PAGE	_IO('T', 0x1)
+
 #endif /* _UAPI_TRACE_MMAP_H_ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..cec6f7599a2c 100644
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
@@ -8495,15 +8495,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
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
+	if (cmd == TRACE_MMAP_IOCTL_GET_READER_PAGE) {
+		if (!(file->f_flags & O_NONBLOCK)) {
+			err = ring_buffer_wait(iter->array_buffer->buffer,
+					       iter->cpu_file,
+					       iter->tr->buffer_percent);
+			if (err)
+				return err;
+		}
+
+		return ring_buffer_map_get_reader_page(iter->array_buffer->buffer,
+						       iter->cpu_file);
+	} else if (cmd) {
+		return -ENOTTY;
+	}
 
+	/*
+	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
+	 * waiters
+	 */
 	mutex_lock(&trace_types_lock);
 
 	iter->wait_index++;
@@ -8516,6 +8532,63 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
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
@@ -8524,6 +8597,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
+	.mmap		= tracing_buffers_mmap,
 };
 
 static ssize_t
-- 
2.41.0.585.gd2178a4bd4-goog

