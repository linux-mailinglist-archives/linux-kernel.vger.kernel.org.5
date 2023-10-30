Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139517DBC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjJ3Orv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJ3Oru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:47:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C3C2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:47:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D22C433C7;
        Mon, 30 Oct 2023 14:47:46 +0000 (UTC)
Date:   Mon, 30 Oct 2023 10:47:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and
 seq_buf_str()
Message-ID: <20231030104744.11e776ce@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: dcc4e5728eeaeda84878ca0018758cff1abfca21


Kees Cook (1):
      seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()

----
 include/linux/seq_buf.h | 21 +++++++++++++++++----
 kernel/trace/trace.c    | 11 +----------
 lib/seq_buf.c           |  4 +---
 3 files changed, 19 insertions(+), 17 deletions(-)
---------------------------
commit dcc4e5728eeaeda84878ca0018758cff1abfca21
Author: Kees Cook <keescook@chromium.org>
Date:   Fri Oct 27 08:56:38 2023 -0700

    seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
    
    Solve two ergonomic issues with struct seq_buf;
    
    1) Too much boilerplate is required to initialize:
    
            struct seq_buf s;
            char buf[32];
    
            seq_buf_init(s, buf, sizeof(buf));
    
    Instead, we can build this directly on the stack. Provide
    DECLARE_SEQ_BUF() macro to do this:
    
            DECLARE_SEQ_BUF(s, 32);
    
    2) %NUL termination is fragile and requires 2 steps to get a valid
       C String (and is a layering violation exposing the "internals" of
       seq_buf):
    
            seq_buf_terminate(s);
            do_something(s->buffer);
    
    Instead, we can just return s->buffer directly after terminating it in
    the refactored seq_buf_terminate(), now known as seq_buf_str():
    
            do_something(seq_buf_str(s));
    
    Link: https://lore.kernel.org/linux-trace-kernel/20231027155634.make.260-kees@kernel.org
    Link: https://lore.kernel.org/linux-trace-kernel/20231026194033.it.702-kees@kernel.org/
    
    Cc: Yosry Ahmed <yosryahmed@google.com>
    Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Justin Stitt <justinstitt@google.com>
    Cc: Kent Overstreet <kent.overstreet@linux.dev>
    Cc: Petr Mladek <pmladek@suse.com>
    Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
    Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: Yun Zhou <yun.zhou@windriver.com>
    Cc: Jacob Keller <jacob.e.keller@intel.com>
    Cc: Zhen Lei <thunder.leizhen@huawei.com>
    Signed-off-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 8483e4b2d0d2..5fb1f12c33f9 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -21,9 +21,18 @@ struct seq_buf {
 	size_t			len;
 };
 
+#define DECLARE_SEQ_BUF(NAME, SIZE)			\
+	char __ ## NAME ## _buffer[SIZE] = "";		\
+	struct seq_buf NAME = {				\
+		.buffer = &__ ## NAME ## _buffer,	\
+		.size = SIZE,				\
+	}
+
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
+	if (s->size)
+		s->buffer[0] = '\0';
 }
 
 static inline void
@@ -69,8 +78,8 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 }
 
 /**
- * seq_buf_terminate - Make sure buffer is nul terminated
- * @s: the seq_buf descriptor to terminate.
+ * seq_buf_str - get %NUL-terminated C string from seq_buf
+ * @s: the seq_buf handle
  *
  * This makes sure that the buffer in @s is nul terminated and
  * safe to read as a string.
@@ -81,16 +90,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * After this function is called, s->buffer is safe to use
  * in string operations.
+ *
+ * Returns @s->buf after making sure it is terminated.
  */
-static inline void seq_buf_terminate(struct seq_buf *s)
+static inline const char *seq_buf_str(struct seq_buf *s)
 {
 	if (WARN_ON(s->size == 0))
-		return;
+		return "";
 
 	if (seq_buf_buffer_left(s))
 		s->buffer[s->len] = 0;
 	else
 		s->buffer[s->size - 1] = 0;
+
+	return s->buffer;
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d629065c2383..2539cfc20a97 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3828,15 +3828,6 @@ static bool trace_safe_str(struct trace_iterator *iter, const char *str,
 	return false;
 }
 
-static const char *show_buffer(struct trace_seq *s)
-{
-	struct seq_buf *seq = &s->seq;
-
-	seq_buf_terminate(seq);
-
-	return seq->buffer;
-}
-
 static DEFINE_STATIC_KEY_FALSE(trace_no_verify);
 
 static int test_can_verify_check(const char *fmt, ...)
@@ -3976,7 +3967,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		 */
 		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
 			      "fmt: '%s' current_buffer: '%s'",
-			      fmt, show_buffer(&iter->seq))) {
+			      fmt, seq_buf_str(&iter->seq.seq))) {
 			int ret;
 
 			/* Try to safely read the string */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index b7477aefff53..23518f77ea9c 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -109,9 +109,7 @@ void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
 	if (s->size == 0 || s->len == 0)
 		return;
 
-	seq_buf_terminate(s);
-
-	start = s->buffer;
+	start = seq_buf_str(s);
 	while ((lf = strchr(start, '\n'))) {
 		int len = lf - start + 1;
 
