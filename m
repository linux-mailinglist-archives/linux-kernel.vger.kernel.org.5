Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC07D890C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjJZTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJZTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:40:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CB1A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:40:39 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so1082149a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698349239; x=1698954039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gjt0z8KB401ODn/KQpGfh65VQ9DCOj6T2VTgcJAisaU=;
        b=K/iQtg9cc/3l9fzr0Yeblv4umTGFPjbbH/fPCeGKW5ufmdm6eTPUpvz6I1fbiIxxCB
         /h5h2PgtNeohg67Iqn9/7AaIFYsInNy8JbrfpfQZSKJzak9fDMcozWeXWkwNHYiY1Qo4
         Tn93rfRm0IEzPJYyP/R1RtTxgcS3/s5u8hndY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349239; x=1698954039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjt0z8KB401ODn/KQpGfh65VQ9DCOj6T2VTgcJAisaU=;
        b=WfaNHJABPfsycP5IWFNKs839cpaCcojInwQ7qrCakJ5r6RQknB20/mFsdPwLCpOt/T
         ATzpUsJ4mLyXvnzFLpU+oCtpIgHZJiouQ0JNaXqLfL+XiFs+nAjz6nQ8JB9HulBZLf9n
         pn8LjdcLejYeZDJI9khpgw2juWCahK7VgVkhqFMuqiWPLSL9y7tD56DwD0MWMd8OoLEq
         ifhCXvvQtbKSzByEuOqWcEO4YWTG9fNzMtrqx5UCjNxGr5juB1RRt2KezPteqt3GTtHh
         KObqNfdWYIy3k068liQH7kWkm23ILmrpraglb7mix6odhMKl6AGQp8XoEVO5tg/qBI2t
         Klxw==
X-Gm-Message-State: AOJu0YxEJY1jb0QIOD3Q6BVqx+06A3ba23B/sFVYW0G2P+UaG7cf6twp
        siw/GHM/6jyjob1NdtIV3+pI6A==
X-Google-Smtp-Source: AGHT+IFPozRjqk4eTroKTzM92AY+aYNqvVn190/wBBcMxFS6ljK2zYGS4IbI0peYiwL15ZsKGpjI2Q==
X-Received: by 2002:a17:90a:f2d4:b0:27c:f845:3e3f with SMTP id gt20-20020a17090af2d400b0027cf8453e3fmr591135pjb.1.1698349238991;
        Thu, 26 Oct 2023 12:40:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id rj14-20020a17090b3e8e00b00263dfe9b972sm2014171pjb.0.2023.10.26.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 12:40:38 -0700 (PDT)
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
Subject: [PATCH v2] seq_buf: Introduce DECLARE_SEQ_BUF and seq_buf_str()
Date:   Thu, 26 Oct 2023 12:40:37 -0700
Message-Id: <20231026194033.it.702-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4617; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QzU6NWc3QjM8fdUO4tKS474/1B+NsO6zg9R0CrHFpJM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlOsC1kxj4+RmjGClwoE8uk9UJshjZEuNiX1ZS+
 yLTj3vaZbKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTrAtQAKCRCJcvTf3G3A
 Juj7D/9Q8PtxzOSbHP41qMXdud/3iF/z+PvOOKi/oEONwQhcwL6/oW8digv+UOlsJhVHk08VPqS
 66mtwRVVlCrWC3+eU/5jQgJTYhgKwpA9lnaKRBHhz+OGn+/VflkFKBbrULuQO0K32ZEJb+XVFPV
 xhxO68W1+sS2oFV9YgJxbYrlvNnSaNC0+18lRaFYabrG/3lpFdKFL/SPz7KeIekSmvxO60eZBA0
 D/OGpRMTqh9w400dRdIkLV/rV64Fz2cI3PqhOEWBkjHUYH8VQD5IEnKnhAtYTojP56cqT9l5kav
 Dnj1/7dzoQDS1D3NUuxv4DzBWWgMYKZ7ZOKlyOd3XvhVFiotft68r61bQHuyWM0VFPq1L3iT0Qy
 6PobzBVyvGHTJKwpkhxuEi+9uYH6yfYzhG4xuU7Um2e8xCSRiultRnenx8Pxgkual21gazVya/d
 +FAWdO6UDipc8Lz1VlVDnWBhUahywP6JMpVS/PXg2XSDTJg492tKH3hOmGmfhl1VAhJhqzkcLqD
 wjYepoYfgzdOeuWTtmxzp5B/OF9pkhoXevWsOUOgPVkoyk1kg3O0kYcUBe/vpRvIYcOQp0vkcir
 SI2WejEJ+lej1iSXDl0q05gZ6abepOTI6n9mk2tECFtARKNOnqScu2gAd8TqhhjVEhR+M8k9Cw2
 IwmAlV8 HxEBv7sw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Instead, we can just return s->buffer direction after terminating it
in refactored seq_buf_terminate(), now known as seq_buf_str():

	do_soemthing(seq_buf_str(s));

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
v2 - rename seq_buf_cstr() to seq_buf_str() (rostedt)
v1 - https://lore.kernel.org/all/20231026170722.work.638-kees@kernel.org/
---
 include/linux/seq_buf.h | 19 +++++++++++++++----
 kernel/trace/trace.c    | 11 +----------
 lib/seq_buf.c           |  4 +---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index 8483e4b2d0d2..71eb4d624308 100644
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
+ * seq_buf_str - get %NUL-terminated C string from seq_buf
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
+static inline char *seq_buf_str(struct seq_buf *s)
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

