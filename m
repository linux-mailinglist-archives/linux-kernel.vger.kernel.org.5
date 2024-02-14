Return-Path: <linux-kernel+bounces-65131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934785486A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B809E1F28B34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827501B813;
	Wed, 14 Feb 2024 11:32:00 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8742C19473;
	Wed, 14 Feb 2024 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910319; cv=none; b=OhkCKPLHnZ4dzsWFPb8VzAb8bKamL+QCQxRKnYGSsjp6mceCLCdc5ficCDXhpPRrmJeL2sxeCKSLpHNIYcW0jkgCE9sHPnz75GPVltJoPeRB5kVAmC2TH5SMIrmvTOfZkXkqd/u62Z25liMPWAWwlUKXilNkYjf3Df1JScOi7jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910319; c=relaxed/simple;
	bh=6+0IzA4B2DlV4NvMNithN+HguWo+5w/SReDep9hW9Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pv6weYLPvZC/aMptg+6M0LFjFDcpKT3FYuIkWp8qcxVoEkrItSnq+RSqYUMAa30+Gknj4cEnKGW5/sRsDG/uO7ah6Dk64egjO5DPNfW+ZTBgLhFDSq/XS4FJTT8R5wRGDO6x8pBuHnTpoduWwQTt36RJ2YGz6BZoXU8lxfQMXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TZbC34nB3z9y62P;
	Wed, 14 Feb 2024 19:12:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 887C014061E;
	Wed, 14 Feb 2024 19:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.156.69])
	by APP1 (Coremail) with SMTP id LxC2BwAn0Rl8pMxlwo99Ag--.51308S4;
	Wed, 14 Feb 2024 12:31:48 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [PATCH v1 2/5] sbm: sandbox input and output buffers
Date: Wed, 14 Feb 2024 12:30:32 +0100
Message-Id: <20240214113035.2117-3-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAn0Rl8pMxlwo99Ag--.51308S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw48XrWUGw1rZFy8GF4rXwb_yoWDJF4DpF
	n8tFn8GF45Jry7Jrsxtr4F9w4ftw4IqF1UKay7W34YyFy5trn7WFykJr9FqFsrCrZrGayr
	Jr1vgay8Ga45J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUzWlgUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Provide SBM_COPY_IN(), SBM_COPY_OUT() and SBM_COPY_INOUT() macros to
allocate sandbox mode buffers for input/output data. Input data is copied
from kernel mode to the allocated buffer before calling the target
function. Output data is copied from the allocated buffer to kernel mode
after the target function returns.

Define two new arch hooks to map input/output buffers:

* arch_sbm_map_readonly()
* arch_sbm_map_writable()

Before calling the target function, use these hooks to create mappings for
all buffers, read-only or writable as appropriate. Provide a fallback no-op
implementation.

Upon expansion, the SBM_COPY_xxx() macros evaluate to the address of the
buffer in sandbox mode, cast back to the original type. This pointer should
be used by code running in the sandbox. It should not be used in kernel
mode; although the address is valid, the buffers are overwritten by
sbm_exec().

To do the typecast, prefer typeof(({x;})) over typeof(x). The statement
expression forces array-to-pointer decay, which allows to pass an array as
an argument to these macros.

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 include/linux/sbm.h | 154 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sbm.c        |  88 +++++++++++++++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/include/linux/sbm.h b/include/linux/sbm.h
index 8e0c63fb9fb2..9671b3c556c7 100644
--- a/include/linux/sbm.h
+++ b/include/linux/sbm.h
@@ -9,16 +9,27 @@
 #ifndef __LINUX_SBM_H
 #define __LINUX_SBM_H
 
+struct sbm_buf;
+
 /**
  * struct sbm - SandBox Mode instance.
  * @error:    Error code. Initialized to zero by sbm_init() and updated when
  *            a SBM operation fails.
  * @private:  Arch-specific private data.
+ * @input:    Input data. Copied to a temporary buffer before starting sandbox
+ *            mode.
+ * @output:   Output data. Copied from a temporary buffer after return from
+ *            sandbox mode.
+ * @io:       Input and output data. Copied to a temporary buffer before
+ *            starting sandbox mode and copied back after return.
  */
 struct sbm {
 #ifdef CONFIG_SANDBOX_MODE
 	int error;
 	void *private;
+	struct sbm_buf *input;
+	struct sbm_buf *output;
+	struct sbm_buf *io;
 #endif
 };
 
@@ -73,6 +84,103 @@ static inline int sbm_error(const struct sbm *sbm)
  */
 int sbm_exec(struct sbm *sbm, sbm_func func, void *data);
 
+/**
+ * struct sbm_buf - Description of an input/output buffer.
+ * @next:      Pointer to the next buffer in the list.
+ * @kern_ptr:  Buffer address in kernel mode.
+ * @sbm_ptr:   Buffer address in sandbox mode.
+ * @size:      Size of the buffer.
+ */
+struct sbm_buf {
+	struct sbm_buf *next;
+	void *kern_ptr;
+	void *sbm_ptr;
+	size_t size;
+};
+
+/**
+ * sbm_alloc_buf() - Allocate a new input/output buffer.
+ * @sbm:   SBM instance.
+ * @size:  Size of the buffer.
+ *
+ * Allocate a new &struct sbm_buf and the corresponding sandbox mode
+ * input/output buffer. If either allocation fails, update &sbm->error.
+ *
+ * Return: New buffer descriptor, or %NULL on allocation failure.
+ */
+struct sbm_buf *sbm_alloc_buf(struct sbm *sbm, size_t size);
+
+/**
+ * sbm_add_buf() - Add a new I/O buffer to the SBM instance.
+ * @sbm:   SBM instance.
+ * @list:  Target argument buffer list.
+ * @buf:   Buffer virtual address.
+ * @size:  Size of the buffer.
+ *
+ * Add a new buffer to @list.
+ *
+ * Return: SBM address of the buffer, or %NULL on error.
+ */
+static inline void *sbm_add_buf(struct sbm *sbm, struct sbm_buf **list,
+				const void *buf, size_t size)
+{
+	struct sbm_buf *io;
+
+	io = sbm_alloc_buf(sbm, size);
+	if (!io)
+		return NULL;
+
+	io->kern_ptr = (void *)buf;
+	io->next = *list;
+	*list = io;
+	return io->sbm_ptr;
+}
+
+/**
+ * SBM_COPY_IN() - Mark an input buffer for copying into SBM.
+ * @sbm:   SBM instance.
+ * @buf:   Buffer virtual address.
+ * @size:  Size of the buffer.
+ *
+ * Add a buffer to the input buffer list for @sbm. The content of the
+ * buffer is copied to sandbox mode before calling the target function.
+ *
+ * It is OK to modify the input buffer after invoking this macro.
+ *
+ * Return: Buffer address in sandbox mode.
+ */
+#define SBM_COPY_IN(sbm, buf, size) \
+	((typeof(({buf; })))sbm_add_buf((sbm), &(sbm)->input, (buf), (size)))
+
+/**
+ * SBM_COPY_OUT() - Mark an output buffer for copying out of SBM.
+ * @sbm:   SBM instance.
+ * @buf:   Buffer virtual address.
+ * @size:  Size of the buffer.
+ *
+ * Add a buffer to the output buffer list for @sbm. The content of the
+ * buffer is copied to kernel mode after calling the target function.
+ *
+ * Return: Buffer address in sandbox mode.
+ */
+#define SBM_COPY_OUT(sbm, buf, size) \
+	((typeof(({buf; })))sbm_add_buf((sbm), &(sbm)->output, (buf), (size)))
+
+/**
+ * SBM_COPY_INOUT() - Mark an input buffer for copying into SBM and out of SBM.
+ * @sbm:   SBM instance.
+ * @buf:   Buffer virtual address.
+ * @size:  Size of the buffer.
+ *
+ * Add a buffer to the input and output buffer list for @sbm. The content
+ * of the buffer is copied to sandbox mode before calling the target function
+ * and copied back to kernel mode after the call.
+ *
+ * Return: Buffer address in sandbox mode.
+ */
+#define SBM_COPY_INOUT(sbm, buf, size) \
+	((typeof(({buf; })))sbm_add_buf((sbm), &(sbm)->io, (buf), (size)))
+
 #ifdef CONFIG_HAVE_ARCH_SBM
 
 /**
@@ -95,6 +203,30 @@ int arch_sbm_init(struct sbm *sbm);
  */
 void arch_sbm_destroy(struct sbm *sbm);
 
+/**
+ * arch_sbm_map_readonly() - Arch hook to map a buffer for reading.
+ * @sbm:  SBM instance.
+ * @buf:  Buffer to be mapped.
+ *
+ * Make the specified buffer readable by sandbox code. See also
+ * arch_sbm_map_writable().
+ *
+ * Return: Zero on success, negative on error.
+ */
+int arch_sbm_map_readonly(struct sbm *sbm, const struct sbm_buf *buf);
+
+/**
+ * arch_sbm_map_writable() - Arch hook to map a buffer for reading and writing.
+ * @sbm:  SBM instance.
+ * @buf:  Buffer to be mapped.
+ *
+ * Make the specified buffer readable and writable by sandbox code.
+ * See also arch_sbm_map_readonly().
+ *
+ * Return: Zero on success, negative on error.
+ */
+int arch_sbm_map_writable(struct sbm *sbm, const struct sbm_buf *buf);
+
 /**
  * arch_sbm_exec() - Arch hook to execute code in a sandbox.
  * @sbm:   SBM instance.
@@ -121,6 +253,18 @@ static inline void arch_sbm_destroy(struct sbm *sbm)
 {
 }
 
+static inline int arch_sbm_map_readonly(struct sbm *sbm,
+					const struct sbm_buf *buf)
+{
+	return 0;
+}
+
+static inline int arch_sbm_map_writable(struct sbm *sbm,
+					const struct sbm_buf *buf)
+{
+	return 0;
+}
+
 static inline int arch_sbm_exec(struct sbm *sbm, sbm_func func, void *data)
 {
 	return func(data);
@@ -149,6 +293,16 @@ static inline int sbm_exec(struct sbm *sbm, sbm_func func, void *data)
 	return func(data);
 }
 
+/* Evaluate expression exactly once, avoiding warnings about a "statement
+ * with no effect". GCC doesn't issue this warning for the return value
+ * of a statement expression.
+ */
+#define __SBM_EVAL(x) ({ typeof(({x; })) __tmp = (x); __tmp; })
+
+#define SBM_COPY_IN(sbm, buf, size)  __SBM_EVAL(buf)
+#define SBM_COPY_OUT(sbm, buf, size) __SBM_EVAL(buf)
+#define SBM_COPY_INOUT(sbm, buf, size) __SBM_EVAL(buf)
+
 #endif /* CONFIG_SANDBOX_MODE */
 
 #endif /* __LINUX_SBM_H */
diff --git a/kernel/sbm.c b/kernel/sbm.c
index 9a5b89a71a23..df57184f5d87 100644
--- a/kernel/sbm.c
+++ b/kernel/sbm.c
@@ -9,7 +9,46 @@
 
 #include <linux/export.h>
 #include <linux/sbm.h>
+#include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/vmalloc.h>
+
+struct sbm_buf *sbm_alloc_buf(struct sbm *sbm, size_t size)
+{
+	struct sbm_buf *buf;
+
+	if (sbm->error)
+		return NULL;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		sbm->error = -ENOMEM;
+		goto out;
+	}
+	buf->sbm_ptr = vzalloc(size);
+	if (!buf->sbm_ptr) {
+		sbm->error = -ENOMEM;
+		goto out;
+	}
+	buf->size = size;
+
+out:
+	return buf;
+}
+EXPORT_SYMBOL(sbm_alloc_buf);
+
+/* Free a buffer list. */
+static void sbm_free_buf_list(const struct sbm_buf *buf)
+{
+	const struct sbm_buf *nextbuf;
+
+	while (buf) {
+		vfree(buf->sbm_ptr);
+		nextbuf = buf->next;
+		kfree(buf);
+		buf = nextbuf;
+	}
+}
 
 int sbm_init(struct sbm *sbm)
 {
@@ -25,14 +64,61 @@ EXPORT_SYMBOL(sbm_init);
 
 void sbm_destroy(struct sbm *sbm)
 {
+	sbm_free_buf_list(sbm->input);
+	sbm_free_buf_list(sbm->output);
+	sbm_free_buf_list(sbm->io);
 	arch_sbm_destroy(sbm);
 }
 EXPORT_SYMBOL(sbm_destroy);
 
+/* Copy input buffers into a sandbox. */
+static int sbm_copy_in(struct sbm *sbm)
+{
+	const struct sbm_buf *buf;
+	int err = 0;
+
+	for (buf = sbm->input; buf; buf = buf->next) {
+		err = arch_sbm_map_readonly(sbm, buf);
+		if (err)
+			return err;
+		memcpy(buf->sbm_ptr, buf->kern_ptr, buf->size);
+	}
+
+	for (buf = sbm->io; buf; buf = buf->next) {
+		err = arch_sbm_map_writable(sbm, buf);
+		if (err)
+			return err;
+		memcpy(buf->sbm_ptr, buf->kern_ptr, buf->size);
+	}
+
+	for (buf = sbm->output; buf; buf = buf->next) {
+		err = arch_sbm_map_writable(sbm, buf);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Copy output buffers out of a sandbox. */
+static void sbm_copy_out(struct sbm *sbm)
+{
+	const struct sbm_buf *buf;
+
+	for (buf = sbm->output; buf; buf = buf->next)
+		memcpy(buf->kern_ptr, buf->sbm_ptr, buf->size);
+	for (buf = sbm->io; buf; buf = buf->next)
+		memcpy(buf->kern_ptr, buf->sbm_ptr, buf->size);
+}
+
 int sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 {
 	int ret;
 
+	if (sbm->error)
+		return sbm->error;
+
+	sbm->error = sbm_copy_in(sbm);
 	if (sbm->error)
 		return sbm->error;
 
@@ -40,6 +126,8 @@ int sbm_exec(struct sbm *sbm, sbm_func func, void *args)
 	if (sbm->error)
 		return sbm->error;
 
+	sbm_copy_out(sbm);
+
 	return ret;
 }
 EXPORT_SYMBOL(sbm_exec);
-- 
2.34.1


