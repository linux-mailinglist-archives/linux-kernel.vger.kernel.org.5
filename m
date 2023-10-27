Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D574F7D9D99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbjJ0P4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbjJ0P4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:56:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60EC129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:56:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b44befac59so2489490b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698422200; x=1699027000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40fyXIZLWl6t+j1qK/ww8o7e/vmz8aWuQu+nEtghbIE=;
        b=CRPn1o7AzPXlGW0pjH0nQAzz0oyjEmn+qQWozrq8tZ6viB0qSGdxO7QdNUgAxPT41S
         +lVIeXVzXYi8eFN0yQXsVZe9MfK4Ro0HfHxGErb53v9gEMkvHeBOZJlRVTlE1kzB6Ts5
         ow5Ud3NZ65gn+fT6CGIMW2EAV2YJElVMnCjRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422200; x=1699027000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40fyXIZLWl6t+j1qK/ww8o7e/vmz8aWuQu+nEtghbIE=;
        b=rX+YKd0/VkeWCW/QTna3sN9VzCuvHfbIAEn19J85da4gUwBlwSHg/2PTPigD/OS296
         O7FTbt2WzUr2ebHXb17/9iVzy6BMUIzIrrV1OGjnV98GmxwVcGL0X4nMAYHCVLFH9fIl
         OLoAHfy5KKxfBDCMOibVdslLqKVMthA1dHUQ6QMy3FQfklrSzBSTBN2v+1XK2vqyLrfN
         CsxouX48UJUhfY9nxdqPYECLtd93nCc36kccnAX4US5Yrcg9n/q7Yis5WcM3aivzHeRl
         vnRgx+vkryYcQMxGIS2vCHcA7ooNz/ga1kq4FOJ3yRuqV/KufgwA1lGWP2aFBe/qHtF/
         Wwqg==
X-Gm-Message-State: AOJu0YzUTXc5B3W5v3gzNhp7RMB6ZGONBDEE2l98wM7epJbA7InWQAMR
        R7AC3NBQInJjEQaOSCrSRK8U7w==
X-Google-Smtp-Source: AGHT+IENI6l4x0rUhXCb0++j2mRLJ+co5f7HRnxct20HokNEjgiWTI/oZ8VdjqfhoUx6oXd5jnCZ+A==
X-Received: by 2002:a05:6a21:32aa:b0:17b:2c56:70bc with SMTP id yt42-20020a056a2132aa00b0017b2c5670bcmr4314236pzb.10.1698422200183;
        Fri, 27 Oct 2023 08:56:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b006be484e5b9asm1545611pfu.188.2023.10.27.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:56:39 -0700 (PDT)
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
Subject: [PATCH v3] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Date:   Fri, 27 Oct 2023 08:56:38 -0700
Message-Id: <20231027155634.make.260-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4859; i=keescook@chromium.org;
 h=from:subject:message-id; bh=3QgU2GLPGx9pQtjcPqO6cwYESMY3mYmV87vQL0flhSk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlO922vKn2ZbYda/N+2eCxBpz/i6JD9BxvPlHI+
 EYOwNQvs8uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTvdtgAKCRCJcvTf3G3A
 JmNwD/9KM3Ah0jhY/I4rtDSfk6VKAxNnDNfdAb6bwxkU6i4DwTDv2m9bkpEJ8tOYI17VJM08pQP
 dqiHbBRsnaXTcjX7qSYYZkiEyvtaz1aqEqfESlMMsQlG5nm3p5ydAJ0HCTNgPsRCmqWXg7ngHkw
 U7AKCvYa8/k77glsBe2DNvwJG/iV8SxHewOBIX/RMMjXxejGUnJwcTu7WDaAoBalJSF4B6V4O+j
 TRX9ttk89GcOeEcpA86CtE4W+PPDeatAy3KkfNM3yH9dzWtryIvODc6fenHLhc5Wzfae72h5CoW
 0oxEf4bfFEjxene1jXHBMNrro16JWBcSKXnbTxFcVG8wnbMnILi+338L74Pu04ADedq7T1GOSNp
 eRO4uwHrqbLV3FN6gfdLdVtDcuSzg7JzSh1ea9jba2TmOUxv2yCgimfAAeTAH8hKV2xYbgrA853
 hLA+F1AG58hsyZ57S3wJ5VAoXaEXaxRMozLDG+VyMp3z3729+n8oRBpfM9d+RMYm8mfi0LjoVfd
 1Sy0aMBBB5fKUYpLuqkSTeIy1jtimZFYyTAZyBJQASoPKrmY4RXNhm+0AJ4bGB/bXDQPrw3QQl1
 BtG3KwDfQIQyK/1Bny3W7k4GSD9HheeC3xRVhJoya0NIYmUvNJj6A7wYgPPi6o/qjg+tU5+e9EX
 jZhI4NB wPewSiBQ==
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
Link: https://lore.kernel.org/r/20231026194033.it.702-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3
 - fix commit log typos
 - improve code style for DECLARE_SEQ_BUF (shevchenko)
 - const-ify seq_bug_str() return (rostedt)
v2 - https://lore.kernel.org/lkml/20231026194033.it.702-kees@kernel.org
v1 - https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org
---
 include/linux/seq_buf.h | 21 +++++++++++++++++----
 kernel/trace/trace.c    | 11 +----------
 lib/seq_buf.c           |  4 +---
 3 files changed, 19 insertions(+), 17 deletions(-)

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
 
-- 
2.34.1

