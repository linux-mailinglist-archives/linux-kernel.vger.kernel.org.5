Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E17D8763
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbjJZROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjJZRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:13:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13C198
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:13:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1103339b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340431; x=1698945231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaUboxRO1+viinf77RQ7N/zAs2SC9fz2QEeXcJMB0SE=;
        b=LPcaEvY2WsHosUhm9UNIJRboimWiVIPcEZY6bxci4+s3avWuyS4sveKrffJauIwfKm
         yQSXSgC85uNhJJLuvGgMSYwBiQnGKL8EVPH9MQotftHT5E0Xv+kTRjlQAJpvpn2ePGrz
         6pxcxZtISeNS5i70ru+tglbKD6qdWO3BGMKQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340431; x=1698945231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaUboxRO1+viinf77RQ7N/zAs2SC9fz2QEeXcJMB0SE=;
        b=o7B5iONDzUXSv+jXh97gy3ZjJw9gxvIIcJdNJqcU/bFOkboQB0fAh2EBgIOwo5oA8h
         m1oUzhsPTY2nBzlxhOW8S5qGbTNwnJpEdbFcw7bTYDPyac8WgqlhLAB+XwDEWYeJprVO
         tWWwDM37Bc/5q0EP7/iH2fphGba0N9mQ9egd16hjP1diLsOKHgvMI75FqP67cLat/0a4
         fxusadhDFrlpLIWm07AXk3TMkI2sNCOMxHw/Y1Jhf4G8rB/fS0tvzWeKUSq2KlNLnYau
         BBI1krNts3caYh7+q4gUxVnhHA9zsheRMubgY8jax8/Uu1bL0p8aA0rHRCw/r+afOkq4
         Tl8Q==
X-Gm-Message-State: AOJu0Yy3aYU8TXdzQEonZSV7P2irTRmGS2JVppWVFtk26onUjoNlcBk/
        1CG0QxHIdubRLbqayie7047Vtw==
X-Google-Smtp-Source: AGHT+IHyR59Pg2x487W+2yP92vC6UvozxH+Vq9jfsqmXLiUPD1h2P4QuTeIdk8oTKJcNWeUXyLwVqQ==
X-Received: by 2002:a05:6a00:3924:b0:6be:43d5:6505 with SMTP id fh36-20020a056a00392400b006be43d56505mr84131pfb.6.1698340431616;
        Thu, 26 Oct 2023 10:13:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d6-20020aa797a6000000b006b225011ee5sm11474423pfq.6.2023.10.26.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:13:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Max Chen <mxchen@codeaurora.org>,
        Yang Shen <shenyang39@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        linux-trace-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC][PATCH] wifi: wil6210: Replace strlcat() usage with seq_buf
Date:   Thu, 26 Oct 2023 10:13:49 -0700
Message-Id: <20231026171349.work.928-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; i=keescook@chromium.org;
 h=from:subject:message-id; bh=D2vtiEKqUsGt/Z09LYNxtKXhUwmDCO+5281guVaf7GY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlOp5NR+tMMbDVnVZsfav6ogCPxtfc/WTZ15nO2
 QRMEDBKLY6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZTqeTQAKCRCJcvTf3G3A
 JqQzD/9l0E0xuPY6P0roZjkRSULXnrIXkTO42RKEmMgsVde2QhNfDm1jpgQwKYS79HR7MUy81R6
 xuvxMMyhXUeRGa0rsA+6TA+heail3hcWvUUQjBz3mmibnTXjOleWcVee0TLju/NW4+Qi/i4VslT
 ss+3VmN0dnlToJW9TccwpeivyT3Zwx+ZTBbtu4c8nNeNwuexL3DzygCn0ERJpGqTaXv31L44t54
 5CluQm2N4kAm97ajzuFbUJJup54tIxrVklY7yRjuagF8gIKfXtUmGuvENXj+wjOdIpwgFOpknt2
 Strg8uN5CjXYpgRv8mhM+vDY7JNBAC9PqjbM8agfAHxWkEyDywHuv+RPz3cnTColqfnenVfPYl1
 Oxbpvi4SQwK/fOsMTmnfiA/TN5Up9l031ukqov92TTse4SgYhCVO8i4hvWBhXylLBKgfKm/SwFk
 SbVfcwbNpUwx+ZicySY48xcf1i1EZ0ydWkL137rTlcJjdvV8q7U+gubWcorg7P0UYKb7JISAlhK
 OhAEcdoTkf8CodYwlFwOSx4/FUI84czwgddorDvN1nUkjSSg6YSzjFjqX+bNedUZYokvgv7/pMu
 v3B3kUPSVnQ3Czc6EwGf0reFM3YSfnbATzoKYVDYHLfCvxrFfdxbaZWbTmbtNIlVfKz+ocrFry8
 ifQRSEE 3hfkIc6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of strlcat() is fragile at best, and we'd like to remove it from
the available string APIs in the kernel. Instead, use the safer seq_buf
APIs.

Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Max Chen <mxchen@codeaurora.org>
Cc: Yang Shen <shenyang39@huawei.com>
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
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is mainly an example of where/how to use the ongoing seq_buf
refactoring happening in the tracing tree:
https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org/
---
 drivers/net/wireless/ath/wil6210/wmi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6fdb77d4c59e..45b8c651b8e2 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -3159,36 +3159,34 @@ int wmi_suspend(struct wil6210_priv *wil)
 	return rc;
 }
 
-static void resume_triggers2string(u32 triggers, char *string, int str_size)
+static void resume_triggers2string(u32 triggers, struct seq_buf *s)
 {
-	string[0] = '\0';
-
 	if (!triggers) {
-		strlcat(string, " UNKNOWN", str_size);
+		seq_buf_puts(s, " UNKNOWN");
 		return;
 	}
 
 	if (triggers & WMI_RESUME_TRIGGER_HOST)
-		strlcat(string, " HOST", str_size);
+		seq_buf_puts(s, " HOST")
 
 	if (triggers & WMI_RESUME_TRIGGER_UCAST_RX)
-		strlcat(string, " UCAST_RX", str_size);
+		seq_buf_puts(s, " UCAST_RX");
 
 	if (triggers & WMI_RESUME_TRIGGER_BCAST_RX)
-		strlcat(string, " BCAST_RX", str_size);
+		seq_buf_puts(s, " BCAST_RX");
 
 	if (triggers & WMI_RESUME_TRIGGER_WMI_EVT)
-		strlcat(string, " WMI_EVT", str_size);
+		seq_buf_puts(s, " WMI_EVT");
 
 	if (triggers & WMI_RESUME_TRIGGER_DISCONNECT)
-		strlcat(string, " DISCONNECT", str_size);
+		seq_buf_puts(s, " DISCONNECT");
 }
 
 int wmi_resume(struct wil6210_priv *wil)
 {
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
 	int rc;
-	char string[100];
+	DECLARE_SEQ_BUF(s, 100);
 	struct {
 		struct wmi_cmd_hdr wmi;
 		struct wmi_traffic_resume_event evt;
@@ -3203,10 +3201,9 @@ int wmi_resume(struct wil6210_priv *wil)
 		      WIL_WAIT_FOR_SUSPEND_RESUME_COMP);
 	if (rc)
 		return rc;
-	resume_triggers2string(le32_to_cpu(reply.evt.resume_triggers), string,
-			       sizeof(string));
+	resume_triggers2string(le32_to_cpu(reply.evt.resume_triggers), s);
 	wil_dbg_pm(wil, "device resume %s, resume triggers:%s (0x%x)\n",
-		   reply.evt.status ? "failed" : "passed", string,
+		   reply.evt.status ? "failed" : "passed", seq_buf_cstr(s),
 		   le32_to_cpu(reply.evt.resume_triggers));
 
 	return reply.evt.status;
-- 
2.34.1

