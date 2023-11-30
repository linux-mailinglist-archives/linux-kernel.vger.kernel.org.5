Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848BC7FFFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377277AbjK3Xo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377302AbjK3Xoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:44:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5975C2D61
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9c4df1287so20619761fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387733; x=1701992533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhfAqA+0zx3rIVvOFQAX3/ztaO69KpdJ+hg2RHJWvzk=;
        b=c8ncx3GBqw9KndPcCRYJc/Bu0MGSN6PQREwX+L1mVOMBMazdpU9F6O1lVWy1R+1SO9
         KFeMRTb+vHmn+3LxvnJU361JzlhbqAZGm3tp1jdDO76eGMil8wHXX9GZ7avulmZTD6Cg
         rK8vsO+cOgdT/JBPMtSDsXEH8DeNZqiK1+E1wJJLLELTHjlQLq0+d8kCmuAgML0+hBOk
         zgBbwR9Y1AB6P+OVwzvIgJLhTv5+FNhN/NVRYzORcPVkqEs492hXQO61ee/mpjqGttkV
         h0b/Ki6yA69VDc4M9HHujPwXJZ+nFvcA5wPZQs41QHlAD1KYDHElViLOCR/ipGwBXuiF
         mTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387733; x=1701992533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhfAqA+0zx3rIVvOFQAX3/ztaO69KpdJ+hg2RHJWvzk=;
        b=uQ9+OrFq4ZzFVvN1Iv+wMBxuGb2Bmn200mFS8nsRYUG4Xqhul9iP/cg44mG5GxGqHd
         YNF/T8ssjme/7loX5fz+JM3R0b1KmopWBBUwRK2x1EJzXNHpOb5pNa6lfoSh8iB/ubX0
         rxDRFw9spntxZUc2mskNa3WFOteaEzwdsD/SOXECsFCI9UgX0XTgBGxNkEk2l5aMzQyB
         lpHdJwKqwKW/KsnqZB3NL8d+AnUC7swLPqCCHf6hFqBp9p3x46cMJbh5HhFOnEdvMbwD
         HDWt/5PmWuinc0aCMp91j7iuLs7rz4kctT4fULaOuE5jz5Q6B8XUQ0X29Q5sLEj2Wvbb
         SQgQ==
X-Gm-Message-State: AOJu0YyTktRgqiYCWoueAL9IpGnCouEgHrZTYn3LMqA/EjaLusioxr+3
        rJUCPZc1AzrxFXbR7ZLM/uNx
X-Google-Smtp-Source: AGHT+IFOMJOjzqkHrGjznFae75gAztoVl98Zwya1R25i+O4APL7YKu/Vlb7hQ1Hub8r/p9Ommz/W8Q==
X-Received: by 2002:a2e:4949:0:b0:2c9:d874:20dc with SMTP id b9-20020a2e4949000000b002c9d87420dcmr193433ljd.102.1701387733098;
        Thu, 30 Nov 2023 15:42:13 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:42:12 -0800 (PST)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v2 14/15] dyndbg: write debug logs to trace instance
Date:   Fri,  1 Dec 2023 00:40:47 +0100
Message-ID: <20231130234048.157509-15-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trace is enabled (T flag is set) and trace destination field
is set to a value in range [0..62] (TRACE_DST_MAX(63) is reserved
for writing to trace events) then debug logs will be written to a
trace instance pointed by inst[trace destination].name, e.g. when
trace destination value is 2 and inst[2].name is set to tbt then
debug logs will be written to <debugfs>/tracing/instances/tbt
instance.

Before using trace instance as a destination for writing debug
logs it has to be explicitly opened with open command.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ae05b3728520..afcc536c2e91 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -141,6 +141,11 @@ static inline bool has_tr_default_dst(void)
 	return tr.default_dst != DST_NOT_SET;
 }
 
+static inline bool is_tr_event_dst(const struct _ddebug *desc)
+{
+	return desc->ctrl.trace_dst == TRACE_DST_MAX;
+}
+
 static int find_tr_instance(const char *name)
 {
 	int idx;
@@ -1251,8 +1256,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
 __printf(3, 0)
-static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
-			 const char *fmt, va_list args)
+static void ddebug_trace_event(struct _ddebug *desc, const struct device *dev,
+			       const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -1283,6 +1288,18 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 	preempt_enable_notrace();
 }
 
+__printf(2, 0)
+static void ddebug_trace_instance(struct _ddebug *desc, const char *fmt,
+				  va_list *args)
+{
+	struct va_format vaf = { .fmt = fmt, .va = args};
+	struct trace_array *arr = tr.inst[get_trace_dst(desc)].arr;
+
+	WARN_ON_ONCE(!arr);
+
+	trace_array_printk(arr, 0, "%pV", &vaf);
+}
+
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
@@ -1295,7 +1312,11 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
+		if (is_tr_event_dst(desc))
+			ddebug_trace_event(desc, NULL,
+					   fmt + strlen(KERN_DEBUG), args);
+		else
+			ddebug_trace_instance(desc, fmt, &args);
 		va_end(args);
 	}
 
@@ -1317,7 +1338,10 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(desc, dev, fmt, args);
+		if (is_tr_event_dst(desc))
+			ddebug_trace_event(desc, dev, fmt, args);
+		else
+			ddebug_trace_instance(desc, fmt, &args);
 		va_end(args);
 	}
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

