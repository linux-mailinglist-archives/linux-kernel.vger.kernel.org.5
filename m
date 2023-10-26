Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC80B7D8739
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbjJZRHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJZRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:07:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE8F1BC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:07:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1056107b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340052; x=1698944852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6uwa1NQ3b5So6ZqC1jDfFnZs3E6+OcPbQsril5qkDE=;
        b=jDsHeG0eV/PVWEpkwiV7KyjG3d+bbr4szNp1BE2YWFuVFrl0VmhMjLk34b7Iv+u0LV
         K7WPas9ItsasMtIs28unrbP6gVrc1EWDMDW+Royy9L8iAr2LO47ivfyXsjTHB4DGgGbB
         DMUPhDoShJr3hBckPhO3t7K54woFOBkAB6S24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340052; x=1698944852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6uwa1NQ3b5So6ZqC1jDfFnZs3E6+OcPbQsril5qkDE=;
        b=RnTlLNUJNEm+KKjX99H6F+oplBiMe5tP14gMTrl2UAGmQqaeZKX7liI2jBvB4qoXC+
         X+xXNmvaiBWv0/fCoiGGCtVbjcDTjA3H2OIon969LcJUK9enIIaLifZtKWpk91L/hUTt
         b9r2RYIfXh8kMbMdP073XoGiMo18RnNaYlnMeYJaWGHfTjYr0zbRSQm2Sy5lCsTUDIfU
         2gpzCxNgldrW3h1dHdb5/nMPp41Nwu116IOVOnDtk8f9zuGAKBLanzj3k0K2Av3sAJtZ
         PVhdw51fyGJTlvRCUJLqJuYWSWQj5lMhY9Lj2Ms5Q5sVBSBU+QhHxFa51P5pyyYfav8u
         JKwA==
X-Gm-Message-State: AOJu0YywyExk5DFpfeOPNzb8Ne3ZRhgpUxQp2T4cT0q4jH99vNnNmbm/
        4ATpGAdXJk7jSPZz8BJPNk7ZSA==
X-Google-Smtp-Source: AGHT+IE7hpmLQqEysEfdJXUltg5QC3Oo8kQXtpDePhBsrIx9j6UHm4qiSQH81VcLVMZ/nIfcqpCBIA==
X-Received: by 2002:a05:6a20:3d2a:b0:15d:684d:f514 with SMTP id y42-20020a056a203d2a00b0015d684df514mr537837pzi.6.1698340052455;
        Thu, 26 Oct 2023 10:07:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z16-20020a656110000000b005b929dc2d25sm1351597pgu.10.2023.10.26.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:07:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Yun Zhou <yun.zhou@windriver.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-trace-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_cstr()
Date:   Thu, 26 Oct 2023 10:07:28 -0700
Message-Id: <20231026170722.work.638-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4488; i=keescook@chromium.org;
 h=from:subject:message-id; bh=VSeNn7/RMcdVPleKpkEjvHM85UsfX0np5UVWhRNzd8U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlOpzQ5loxdyuUGtxqQcAlDxcpVgVq53LwrCQag
 bnMFdQY2dKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTqc0AAKCRCJcvTf3G3A
 JrXtD/9QYO6GmmwzvTM0xFkPaw27QP97gXGJGIxv631wEy5F56f10I8PqEzoILEJzIU9s/s/vaJ
 60Oxo5TGL1aMtHG3kadZSJnyOV+zj244PintWD18FXWAS/OhBKlPEYYGoWdCC+6xSQePk+m1o6H
 3H/U94d2dodigsjd4qCFswPoK/Ukdmt6Ks9zp5aUMHcH2IOLCHx47xag1gQ508t/+9xy43Ox8HP
 bk0diEv0qqOKGBOnQv+cl9PhK3ciQnK3W9Fri1XapmlpesIlz/IxV3bVk+S6Y9MnYvlUi0zrLEN
 UgJbiBxkVgsMSbNig4uQWkUh9mj/LTlPBvDKm1/nHNSu3KZb0ialmZVZE9CxEAgj0W3JL84IZfT
 8dEGsOw62OfrkVAuLnZc0k8K33Vhxj4QO4kLFK//Oml7I0lUdx3Abw85jgO/NJQds9CByzUnx0M
 51YrrF4h+edaHU1h+Qrqh5kIbOHVB5DocI4mDSrN0mZH/1E/Z6XrGxkhIo/qocyEUj00DIY5x+V
 a4lK+sascEFpR25yMi3gIYEtSL+TE10P1zGfoBpNQYpIxKSDRiFfj7Vew7TLfQuGd+qrFqdG2/w
 xpHdSXIUUXpgvoFOqoWGRz3qdfuOq8+qMkHIPjnnA3Rso7zZBeUDHhRfwxu9n9+JqRtL5gy5Xg8
 juLsepS NEfQ04kA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solve two ergonomic issues with struct seq_buf:

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

Instead, we can just return s->buffer direction after terminating it
in refactored seq_buf_terminate(), now known as seq_buf_cstr():

	do_soemthing(seq_buf_cstr(s));

Cc: Steven Rostedt <rostedt@goodmis.org>
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
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/seq_buf.h | 19 +++++++++++++++----
 kernel/trace/trace.c    | 11 +----------
 lib/seq_buf.c           |  4 +---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 8483e4b2d0d2..8896b830eb3d 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -21,9 +21,16 @@ struct seq_buf {
 	size_t			len;
 };
 
+#define DECLARE_SEQ_BUF(NAME, SIZE)					\
+	char __ ## NAME ## _buffer[SIZE] = "";				\
+	struct seq_buf NAME = { .buffer = &__ ## NAME ## _buffer,	\
+				.size = SIZE }
+
 static inline void seq_buf_clear(struct seq_buf *s)
 {
 	s->len = 0;
+	if (s->size)
+		s->buffer[0] = '\0';
 }
 
 static inline void
@@ -69,8 +76,8 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
 }
 
 /**
- * seq_buf_terminate - Make sure buffer is nul terminated
- * @s: the seq_buf descriptor to terminate.
+ * seq_buf_cstr - get %NUL-terminated C string from seq_buf
+ * @s: the seq_buf handle
  *
  * This makes sure that the buffer in @s is nul terminated and
  * safe to read as a string.
@@ -81,16 +88,20 @@ static inline unsigned int seq_buf_used(struct seq_buf *s)
  *
  * After this function is called, s->buffer is safe to use
  * in string operations.
+ *
+ * Returns @s->buf after making sure it is terminated.
  */
-static inline void seq_buf_terminate(struct seq_buf *s)
+static inline char *seq_buf_cstr(struct seq_buf *s)
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
index d629065c2383..d83f36dc4bf8 100644
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
+			      fmt, seq_buf_cstr(&iter->seq.seq))) {
 			int ret;
 
 			/* Try to safely read the string */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index b7477aefff53..165caed5a74e 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -109,9 +109,7 @@ void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
 	if (s->size == 0 || s->len == 0)
 		return;
 
-	seq_buf_terminate(s);
-
-	start = s->buffer;
+	start = seq_buf_cstr(s);
 	while ((lf = strchr(start, '\n'))) {
 		int len = lf - start + 1;
 
-- 
2.34.1

