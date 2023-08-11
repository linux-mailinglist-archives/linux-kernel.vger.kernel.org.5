Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B077859C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjHKCrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKCrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:47:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAA2D60;
        Thu, 10 Aug 2023 19:47:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-768054797f7so115712185a.2;
        Thu, 10 Aug 2023 19:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691722041; x=1692326841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhP8QpiCMA2S8cH3ID9XcIgvYsWAB2QE5PGdgRieaYQ=;
        b=gLMl1f3pC55DMTipYsAr92CK6zvaQfdCtmqXF2JTJlOfY2E1VY5tLK1+Q5JWVgfo7n
         lVFNu8bQVUuULLZyMlMb8aqUDzg+8KfxdjuW0vp8SbNco+5mQKWOukisSj3clCPPgMHw
         jpJ9cYzuB2QXSvhtmbOCNMCVHBGyHflx0F39f+g78WfAh1qgN6wl5ThnypPptWVzRgB7
         Bh/i8aIuEGjfUlFC1f5E7KnWCQIbsC2Aw7u8mrHtDIpLfcY8/QRg/BubeRlfuVgOJuQG
         MCLNo2AMxRglrp5MORZzL/CVHC6gBpNSbgBdNpH1AAp+QY+VudedevhqOAPkfVVXLaKd
         9FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691722041; x=1692326841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhP8QpiCMA2S8cH3ID9XcIgvYsWAB2QE5PGdgRieaYQ=;
        b=ibusgeVkfEL5Ki/F5mqT7tcSUcoAuvbk9MO6f4PLnEqKPrSp5Rm9bgHgANvemLzZqY
         d2BotSMNo0djlhODA53CnXLQI7qT00Xjo/1YkiXT2fP5bGcCNxEOxP36BoD6uVvlIvgE
         MhabNhOf/WxxBAJEoIFGmbvm2FTahTLCwDNWzYBGntR2rRtOlF66163J69sAPbogVFTW
         nx3ufp5cb9HuB7YCiTkwZQI7LQ/c1KLpmMJLD+kfgvknGVdaqHLzMX5bS1GVUMzHJrrV
         WfKL/DkQ++wYgjI8EYEkzqjNbAaXyhOKjkZODhu3ADQeK5K5CGgYXwkCAkghe4oh6lTN
         CU7Q==
X-Gm-Message-State: AOJu0YzcoDXRDy7Q7r82qdGgd/v/7viOnGOmmen4N1+9Ww9+1OtRxf4v
        SmEHZ25LZnIkZeTxi6XUlA+4Ilih3vM=
X-Google-Smtp-Source: AGHT+IGBy/n64YMB/7X3eHNRGZv5AYAIWqjpcds8urxr74LXbcDNi0+EFgSA4ViW4CRQoM6ZR36XLQ==
X-Received: by 2002:a05:620a:1a19:b0:768:1572:e9af with SMTP id bk25-20020a05620a1a1900b007681572e9afmr730090qkb.8.1691722040685;
        Thu, 10 Aug 2023 19:47:20 -0700 (PDT)
Received: from localhost.localdomain ([8.210.156.175])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b0064d32771fa8sm2206332pfo.134.2023.08.10.19.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 19:47:19 -0700 (PDT)
From:   Chuang Wang <nashuiliang@gmail.com>
Cc:     Chuang Wang <nashuiliang@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v1] tracing/eprobe: Iterate trace_eprobe directly
Date:   Fri, 11 Aug 2023 10:47:02 +0800
Message-Id: <20230811024702.245746-1-nashuiliang@gmail.com>
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

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v0->v1:
- remove "Fixes" in the commit information.

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

