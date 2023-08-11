Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F67788CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjHKIM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjHKIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:12:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D72D4F;
        Fri, 11 Aug 2023 01:12:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-563dfffea87so1346116a12.2;
        Fri, 11 Aug 2023 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691741577; x=1692346377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EElX5cZSDkZGCSK4eru5v9xsGx/NgNYUucYryIPYygo=;
        b=NoXyAIwkt+2ACaUKK3b0LsxReqKcwIgQacAm/AZq9SvNQEBQcJwpyEBE9WZ/FQ2Wzd
         S2V+t/wFdWprrWaWWxhCFu1sghqifnm4zYFyUjyzBZczELzirmnVyiri1CC50vj14WNM
         CzuMYu2AOnfuwY76UdOvykjBE8+kABGod8bvlY1FqSgcudldcH/acAPzv83R8R2LbNk7
         50wXN8BOMmO4BZa7Vx0tQXHlp2OUGuYjVcCYcNRbMsAMGxL0IKOgYnqW4KUA9Csxtnwv
         Zk7WSF3kxjQlHA5CIp3Gc47zu7HctMPlRy21zBPfz4waeG3TrFbZjaWZcPCfRNOENuHX
         AIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691741577; x=1692346377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EElX5cZSDkZGCSK4eru5v9xsGx/NgNYUucYryIPYygo=;
        b=JWYAZab2PFlWmABQI9ibk9IDqOppfTxkWNU3KutIoYMFLWGBT76SqOr1e25ERD82YZ
         jb7cRjeTK+MuMjsU5Hv1omsy16GELfc0zQRCZTJh2PLiqXZxETwXRKzBmooq3uUd/L6E
         F2ScoqNr72YE9YXZZd5Qwb5jFMK+MsX1nvFqkY41+/KEqSjG35Rf5wxQwFNszv9YLTox
         +Ng3JsDDyS2aZxuRqoK9Ur/UYWOwHR/++UTWl3hntL3TDiRtHSEfUoU1liOpGxJGRpWr
         aJ7rCLkWqTB61a6IuvsUO2DwssSQjxi232PADkQRFqp+PL5XuKYqi6cDvokbKRDBuwR7
         7oaw==
X-Gm-Message-State: AOJu0YwV+zo3DbXOALixDd0aWR93p5g2yQd5iyqHyQmcyjVqckFjey+n
        7p6YQXSdYJLhzScb1pIX1Sc=
X-Google-Smtp-Source: AGHT+IHI4h59sn4NFRyctmflnTDfMudoRJdNY1aqlif55+tdTtygM6DZrY1o/ri5X9agn1KSAhZTTg==
X-Received: by 2002:a17:90a:f0d6:b0:268:1d1e:baaf with SMTP id fa22-20020a17090af0d600b002681d1ebaafmr873730pjb.17.1691741577291;
        Fri, 11 Aug 2023 01:12:57 -0700 (PDT)
Received: from localhost.localdomain ([8.210.156.175])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a034500b00264040322desm2942636pjf.40.2023.08.11.01.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 01:12:56 -0700 (PDT)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
Date:   Fri, 11 Aug 2023 16:12:39 +0800
Message-Id: <20230811081239.246365-1-nashuiliang@gmail.com>
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

Also, this patch defines "for_each_trace_eprobe_on_trace_probe" to
simplify the code of the same logic.

[1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v1 -> v2:
- add "for_each_trace_eprobe_on_trace_probe" as suggested by Masami

v0 -> v1:
- remove "Fixes" in the commit information.

 kernel/trace/trace_eprobe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a0a704ba27db..b7c6179f8b7f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -41,6 +41,10 @@ struct eprobe_data {
 	struct trace_eprobe	*ep;
 };
 
+
+#define for_each_trace_eprobe_on_trace_probe(ep, _tp) \
+	list_for_each_entry(ep, trace_probe_probe_list(_tp), tp.list)
+
 static int __trace_eprobe_create(int argc, const char *argv[]);
 
 static void trace_event_probe_cleanup(struct trace_eprobe *ep)
@@ -640,7 +644,7 @@ static int disable_eprobe(struct trace_eprobe *ep,
 static int enable_trace_eprobe(struct trace_event_call *call,
 			       struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
@@ -662,8 +666,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	if (enabled)
 		return 0;
 
-	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-		ep = container_of(pos, struct trace_eprobe, tp);
+	for_each_trace_eprobe_on_trace_probe(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
@@ -680,8 +683,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 			 */
 			WARN_ON_ONCE(ret != -ENOMEM);
 
-			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-				ep = container_of(pos, struct trace_eprobe, tp);
+			for_each_trace_eprobe_on_trace_probe(ep, tp) {
 				disable_eprobe(ep, file->tr);
 				if (!--cnt)
 					break;
@@ -699,7 +701,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 static int disable_trace_eprobe(struct trace_event_call *call,
 				struct trace_event_file *file)
 {
-	struct trace_probe *pos, *tp;
+	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
 	tp = trace_probe_primary_from_call(call);
@@ -716,10 +718,8 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp)) {
-		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-			ep = container_of(pos, struct trace_eprobe, tp);
+		for_each_trace_eprobe_on_trace_probe(ep, tp)
 			disable_eprobe(ep, file->tr);
-		}
 	}
 
  out:
-- 
2.39.2

