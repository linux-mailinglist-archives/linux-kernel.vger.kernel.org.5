Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549DE7772D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjHJIZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:25:42 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F31DC;
        Thu, 10 Aug 2023 01:25:41 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-56d0d7300d9so550545eaf.1;
        Thu, 10 Aug 2023 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691655941; x=1692260741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOP/iqFkNoqiitgBVZ/MKfSeIArQETkL/EyY1NIi8CI=;
        b=lzstj11n7W7tK1RAmAtAKLkaG6871jLPqpAwjxlWy4KYWj3NRco6w5VBuiLdS6adJg
         GjQDp2YuwSDfanPWR4sabzvLW9XByXFVbQKnZs7eDbT3ZIKyNu0Q96bERJP08jFY2Im/
         +GbrGGdq1Y3g61T4W7W0OyzKVkQ60zp8Rukw4tLq/OcWayimBRZGDWBI/f7DHFhQK0Xx
         WnqCTNC65rOuEPGVa6XWVeG+ZNlh5D237WSAcIUU55xebU2t9DEGPTf4RpT1+YWVnRpH
         en6xZV/HNAmF7NIaMPatWCgFJFYpdr5AT8n6ihhJkjn75QWgI/7rNjAZGq8K4I8degJV
         K7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655941; x=1692260741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOP/iqFkNoqiitgBVZ/MKfSeIArQETkL/EyY1NIi8CI=;
        b=U6jAr4auzeI9KlelwM7c9EbIMEfCHmQD60dB8jItkksbiRkwq4RNhkO5arf38MWu93
         3/6TaPXADIbj4GKgcbaq/2J6YZogv29SG4CR/Mmta2qH6MYa95U/jx0fXUg/d0F9/U5l
         vvfd9QVfv3gUGgLv1K3gZ6eFnmsEihjAqlDCS9DuY+g+y9/GpCnVJw16ZL8aEzRt0OSo
         1ouEH1A0PdfmOATvYt0cHo3635CViQxM/1/t6X6zIENDdQY6e1SuVQy9B5GwyaX27CNR
         N3AmT35/HY37/qEPrX4gR0aK7Q8uPQARKxU0zxnP7aBgM1Zi6KBJ4igDcHUu7RO4zuSi
         FLKA==
X-Gm-Message-State: AOJu0Yz9FTIeeFqZF4YIwlu/VpEK49bP7NXypuOvfGfekjVL+aPXtRp3
        Vuzjm30GOjMtGY1WWxCBMYI=
X-Google-Smtp-Source: AGHT+IExTWszIm0qh1iBYF85XFmUgBcCpAkcqXK8fMwflik8cbgMXazfw/o0cveoaDQ0T2XoVwc0Zw==
X-Received: by 2002:a05:6358:9041:b0:134:c1e1:3b08 with SMTP id f1-20020a056358904100b00134c1e13b08mr2490401rwf.25.1691655940893;
        Thu, 10 Aug 2023 01:25:40 -0700 (PDT)
Received: from localhost.localdomain ([8.210.156.175])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b0056420d3cd20sm970975pgc.71.2023.08.10.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:25:40 -0700 (PDT)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Iterate trace_eprobe directly
Date:   Thu, 10 Aug 2023 16:25:23 +0800
Message-Id: <20230810082523.244397-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to the description in [1], we can skip "container_of()" following
"list_for_each_entry()" by using "list_for_each_entry()" with
"struct trace_eprobe" and "tp.list".

[1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 kernel/trace/trace_eprobe.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a0a704ba27db..d68d660dff7c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -640,7 +640,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
 static int enable_trace_eprobe(struct trace_event_call *call,
 			       struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
@@ -662,8 +662,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		ep = container_of(pos, struct trace_eprobe, tp);
+	list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
@@ -680,8 +679,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 			 */
 			WARN_ON_ONCE(ret != -ENOMEM);
 
-			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-				ep = container_of(pos, struct trace_eprobe, tp);
+			list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
 				disable_eprobe(ep, file->tr);
 				if (!--cnt)
 					break;
@@ -699,7 +697,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 static int disable_trace_eprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
 	tp = trace_probe_primary_from_call(call);
@@ -716,8 +714,7 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp)) {
-		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-			ep = container_of(pos, struct trace_eprobe, tp);
+		list_for_each_entry(ep, trace_probe_probe_list(tp), tp.list) {
 			disable_eprobe(ep, file->tr);
 		}
 	}
-- 
2.39.2

