Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058A37837E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjHVCYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjHVCYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:24:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E27189;
        Mon, 21 Aug 2023 19:24:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a440a8a20so1546787b3a.3;
        Mon, 21 Aug 2023 19:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692671090; x=1693275890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWHui7UTytAd3ZHZVHjalRhUa2PgCPbw4bc+ai5jSeU=;
        b=HcaLyE9bSSNVT6zQRuM5B1b2VMl6vqmEJgeylHrqH7ZO+oWT7p1X/OGjllKS0wZud7
         YGLjwn/aNA+zB8bFNW9Q8dsqyYCJvnST5vzRbRUTdkOw5jRRE8PJQ8FzrQxbeyr8YmzY
         YURL44Z4ak63WQ8RjRIOLh51QAmVvosiBrPzSLxoHDWnR3Uvve9MGYZnuRK69p32T30W
         0utZWClej9c3q4uEeTqjDaKlWfHtsYh3HPCW/vCh0mAiLaQGAbvDEhCzqzzjWmZHzcfc
         t7YorQFGe2UPKcqnZg0YBWmvIXyrWZdNnLXu7xmFn8rrTBepV1JPu6tVHmVyPNIizXEb
         t6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692671090; x=1693275890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWHui7UTytAd3ZHZVHjalRhUa2PgCPbw4bc+ai5jSeU=;
        b=KqXL1ZnIZS73nASbbDzjpB4F9ZaFBXMwxcBur1YzwkLgySO7f9ZkF954gF+cVXV+75
         g8Pv7B6gvrKIQiEuAwDh5MeQbvMo6lsdnqtpnwbnLj1bgahZbGyYKCRzg75gsA7DJzHh
         bB9R/d6tfPJUS7CC0puAfREOo+liDglHLtQreFxBtk/vWwKZjwwt5CqZskmm52AgRtUs
         jUr5NhfK6d9YKNV0Lnb0+3Il1cCb7qkjnS5+3SqE+T/U7qGQHt43KC3NFqY6lCriDoCh
         BSaNFMl3nMs9KU7i1lcQgNKLDh+wGmladmpDx7+wsXzHppxWAso1ZV4q15/TCs6x1JX9
         u2ag==
X-Gm-Message-State: AOJu0YzSrIYbS6vCjEJlGuoQpLMQb3isGFOZ1DizZsvttu3gtK4YmX3E
        bT2JIqDwijbNrXtkew8oRAE=
X-Google-Smtp-Source: AGHT+IHdXbHuV6RoBpU7kyMmKhLiOaXHn69gqN/jFwMZkBadIyuwvz3FlqSC/3x6l61Aq5YPtAXAGA==
X-Received: by 2002:a05:6a00:1788:b0:68a:6e81:60a2 with SMTP id s8-20020a056a00178800b0068a6e8160a2mr250833pfg.26.1692671089979;
        Mon, 21 Aug 2023 19:24:49 -0700 (PDT)
Received: from localhost.localdomain ([8.210.156.175])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78544000000b006862b2a6b0dsm6940462pfn.15.2023.08.21.19.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 19:24:49 -0700 (PDT)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing/eprobe: Iterate trace_eprobe directly
Date:   Tue, 22 Aug 2023 10:24:33 +0800
Message-Id: <20230822022433.262478-1-nashuiliang@gmail.com>
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

Also, this patch defines "for_each_trace_eprobe_tp" to simplify the code
of the same logic.

[1] https://lore.kernel.org/all/CAHk-=wjakjw6-rDzDDBsuMoDCqd+9ogifR_EE1F0K-jYek1CdA@mail.gmail.com/

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v2 -> v3:
- use "for_each_trace_eprobe_tp" instead of "for_each_trace_eprobe_on_trace_probe"

v1 -> v2:
- add "for_each_trace_eprobe_on_trace_probe" as suggested by Masami

v0 -> v1:
- remove "Fixes" in the commit information.

 kernel/trace/trace_eprobe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a0a704ba27db..6a024b5912e2 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -41,6 +41,10 @@ struct eprobe_data {
 	struct trace_eprobe	*ep;
 };
 
+
+#define for_each_trace_eprobe_tp(ep, _tp) \
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
+	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
@@ -680,8 +683,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 			 */
 			WARN_ON_ONCE(ret != -ENOMEM);
 
-			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
-				ep = container_of(pos, struct trace_eprobe, tp);
+			for_each_trace_eprobe_tp(ep, tp) {
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
+		for_each_trace_eprobe_tp(ep, tp)
 			disable_eprobe(ep, file->tr);
-		}
 	}
 
  out:
-- 
2.39.2

