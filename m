Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5727D0419
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbjJSVks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbjJSVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:40:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48127BE;
        Thu, 19 Oct 2023 14:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=b4HCbIcpuTf2AtCD4Gw8oaFAr3lLevKnvsjAPH9DoPw=; b=HvmpSS7kAWcYGs+Te9d8uMi2LS
        avX/MnUrQidVGEn/cj37ZF4edJOaPxjKeng5T3EL1iVWhprMk+6WTfbOJOhFA+c8ieS8rsRbd6JFs
        9Eus2DWJ/Effc8qVV6ed9rttxoAQBeqPvWKJZRHYLC4Zm/qDvz0YOD51PBtrL295nGb+Dv2CrjKTf
        A7xKDWtHXzFD/bjogf+p+55FLq9ojxA1SGFBuaAPhebcAi4eL1YphFyHeVYdkyRKZM/YFQYrCQSkJ
        9L9le5NOrlxZ2JgoyvgqE+03Tdz0i11NYmyIIebw++rR/T90G60xX900OXOs8llIPX0S+vjDbCqsD
        gPIKZXLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtakt-009Mv5-BT; Thu, 19 Oct 2023 21:40:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/1] trace: Move readpos from seq_buf to trace_seq
Date:   Thu, 19 Oct 2023 22:40:33 +0100
Message-Id: <20231019214033.2229099-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make seq_buf more lightweight as a string buf, move the readpos member
from seq_buf to its container, trace_seq.  That puts the responsibility
of maintaining the readpos entirely in the tracing code.  If some future
users want to package up the readpos with a seq_buf, we can define a
new struct then.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/seq_buf.h   |  5 +----
 include/linux/trace_seq.h |  2 ++
 kernel/trace/trace.c      | 10 +++++-----
 kernel/trace/trace_seq.c  |  6 +++++-
 lib/seq_buf.c             | 13 +++++--------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 515d7fcb9634..a0fb013cebdf 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -14,19 +14,16 @@
  * @buffer:	pointer to the buffer
  * @size:	size of the buffer
  * @len:	the amount of data inside the buffer
- * @readpos:	The next position to read in the buffer.
  */
 struct seq_buf {
 	char			*buffer;
 	size_t			size;
 	size_t			len;
-	loff_t			readpos;
 };
 
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
-	s->readpos = 0;
 }
 
 static inline void
@@ -143,7 +140,7 @@ extern __printf(2, 0)
 int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args);
 extern int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s);
 extern int seq_buf_to_user(struct seq_buf *s, char __user *ubuf,
-			   int cnt);
+			   size_t start, int cnt);
 extern int seq_buf_puts(struct seq_buf *s, const char *str);
 extern int seq_buf_putc(struct seq_buf *s, unsigned char c);
 extern int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len);
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 6be92bf559fe..3691e0e76a1a 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -14,6 +14,7 @@
 struct trace_seq {
 	char			buffer[PAGE_SIZE];
 	struct seq_buf		seq;
+	size_t			readpos;
 	int			full;
 };
 
@@ -22,6 +23,7 @@ trace_seq_init(struct trace_seq *s)
 {
 	seq_buf_init(&s->seq, s->buffer, PAGE_SIZE);
 	s->full = 0;
+	s->readpos = 0;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index abaaf516fcae..217cabd09c3e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1730,15 +1730,15 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
 {
 	int len;
 
-	if (trace_seq_used(s) <= s->seq.readpos)
+	if (trace_seq_used(s) <= s->readpos)
 		return -EBUSY;
 
-	len = trace_seq_used(s) - s->seq.readpos;
+	len = trace_seq_used(s) - s->readpos;
 	if (cnt > len)
 		cnt = len;
-	memcpy(buf, s->buffer + s->seq.readpos, cnt);
+	memcpy(buf, s->buffer + s->readpos, cnt);
 
-	s->seq.readpos += cnt;
+	s->readpos += cnt;
 	return cnt;
 }
 
@@ -7006,7 +7006,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 
 	/* Now copy what we have to the user */
 	sret = trace_seq_to_user(&iter->seq, ubuf, cnt);
-	if (iter->seq.seq.readpos >= trace_seq_used(&iter->seq))
+	if (iter->seq.readpos >= trace_seq_used(&iter->seq))
 		trace_seq_init(&iter->seq);
 
 	/*
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index bac06ee3b98b..7be97229ddf8 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -370,8 +370,12 @@ EXPORT_SYMBOL_GPL(trace_seq_path);
  */
 int trace_seq_to_user(struct trace_seq *s, char __user *ubuf, int cnt)
 {
+	int ret;
 	__trace_seq_init(s);
-	return seq_buf_to_user(&s->seq, ubuf, cnt);
+	ret = seq_buf_to_user(&s->seq, ubuf, s->readpos, cnt);
+	if (ret > 0)
+		s->readpos += ret;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(trace_seq_to_user);
 
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 45c450f423fa..0d218f3835ae 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -340,7 +340,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
  *
  * Returns -EFAULT if the copy to userspace fails.
  */
-int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
+int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
 {
 	int len;
 	int ret;
@@ -350,20 +350,17 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 
 	len = seq_buf_used(s);
 
-	if (len <= s->readpos)
+	if (len <= start)
 		return -EBUSY;
 
-	len -= s->readpos;
+	len -= start;
 	if (cnt > len)
 		cnt = len;
-	ret = copy_to_user(ubuf, s->buffer + s->readpos, cnt);
+	ret = copy_to_user(ubuf, s->buffer + start, cnt);
 	if (ret == cnt)
 		return -EFAULT;
 
-	cnt -= ret;
-
-	s->readpos += cnt;
-	return cnt;
+	return cnt - ret;
 }
 
 /**
-- 
2.40.1

