Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA87E0366
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377657AbjKCNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjKCNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:32 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0FD4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2508194e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017024; x=1699621824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiFe3xfWVVRbB+dZemjysAJsSe+YWOJENxzGnSzBt3U=;
        b=UqjsreWOp46SPecv+RRcXLnXAAjAliU6huwoRB6jf+NLbf5a/HEilZ+xrAx+tni9/x
         BuLSDwKhTuMihmj/Zgm14sNqSOMAEJj0vjDuYr/wRg1OLLof+HcW15ctqsQsTZhjcM3c
         K2MFvrRt8kMzARRRXY6cpisgFt0CcHOGS3/oohyivjdLPvKUwjDENWUskh0WR5rcdxGN
         hcsmCQvfd12p15ty48O3MAdmB5dottuzh6hbGqGO+vXzNw3o7T9HXE+p4/ZmFIzjVx6v
         f9nzo+VSBOPs3zkcO9ifv518SFHIng2/tCHVZ/yJnSD5iRttcR8uCA4KRfkxFOXY2WV/
         D0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017024; x=1699621824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiFe3xfWVVRbB+dZemjysAJsSe+YWOJENxzGnSzBt3U=;
        b=t+FCbVr7CrFs1SCpExtv0QNwewN+kkIs6h79PFSnkp0EGYULfsTfG3VKxcmnqj4j9q
         9LnmG7wkxSb+VqMGv2eQvUlbKOdUFc+UnePEVB6K0phAMbf2m0uC014RVnwnQmPEAFpg
         bUfcKnjJZtEn4FhWwPcpGQ0lIiDP1DS8ia8qOldu9IHh+nkqcXZBY6zYpds8mRLm3op6
         oeE7Wkc550pFpLXwlwcq7NVz4Kmm4sg8qhkLYELd6hHv7BP6rh8MT2jKk79J0aXoX+Nj
         kUubltG0RMmckekjVsyh/FctD68PtPJI7JeR6fC1YrBwLHs1ZVpa977KNjMh1lQug2gM
         dEYA==
X-Gm-Message-State: AOJu0Ywh95EgIWu/8u+oR6PKNW8FpXrTM5cJnkweDAXud7GVRZuJBsZh
        KSTKzRETWBJStIkD3CBEbEiz
X-Google-Smtp-Source: AGHT+IG8n7Vv2U2ein1ag0/kCSjhyEj09gs4gS2sKD4MRICZ/8/OvGOHydfG7YcboaVTn/oUCuvr3Q==
X-Received: by 2002:a05:6512:10c7:b0:509:1227:ca71 with SMTP id k7-20020a05651210c700b005091227ca71mr16819209lfg.17.1699017024656;
        Fri, 03 Nov 2023 06:10:24 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:24 -0700 (PDT)
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
Subject: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
Date:   Fri,  3 Nov 2023 14:10:08 +0100
Message-Id: <20231103131011.1316396-10-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20231103131011.1316396-1-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
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

Add trace destination field (trace_dst) to the _ddebug structure.
The trace destination field is used to determine output of debug
logs when +T is set. Setting trace_dst value to 0 (default) enables
output to prdbg and devdbg trace events. Setting trace_dst value to
a value in range of [1..255] enables output to trace instance.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 13 +++++++++++--
 lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 684766289bfc..3084302876b4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,9 +60,18 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	struct {
+	struct dd_ctrl {
 		unsigned int flags:8;
-		unsigned unused:24;
+	/*
+	 * The trace destination field is used to determine output of debug
+	 * logs when +T is set. Setting trace_dst value to 0 (default) enables
+	 * output to prdbg and devdbg trace events. Setting trace_dst value to
+	 * a value in range of [1..255] enables output to trace instance.
+	 */
+#define TRACE_DST_BITS 8
+		unsigned int trace_dst:TRACE_DST_BITS;
+#define TRACE_DST_MAX	((1 << TRACE_DST_BITS) - 1)
+		unsigned unused:16;
 	} ctrl;
 } __attribute__((aligned(8)));
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ca87adf327df..3218ab078a76 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,14 +80,24 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
+{
+	return &desc->ctrl;
+}
+
+static inline void set_ctrl(struct _ddebug *desc, struct dd_ctrl *ctrl)
+{
+	desc->ctrl = *ctrl;
+}
+
 static inline unsigned int get_flags(const struct _ddebug *desc)
 {
 	return desc->ctrl.flags;
 }
 
-static inline void set_flags(struct _ddebug *desc, unsigned int val)
+static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 {
-	desc->ctrl.flags = val;
+	return desc->ctrl.trace_dst;
 }
 
 /* Return the path relative to source root */
@@ -190,8 +200,8 @@ static int ddebug_change(const struct ddebug_query *query,
 {
 	int i;
 	struct ddebug_table *dt;
-	unsigned int newflags;
 	unsigned int nfound = 0;
+	struct dd_ctrl nctrl = {0};
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
@@ -257,14 +267,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (newflags == get_flags(dp))
+			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
-				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
+				if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
+			} else if (nctrl.flags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
@@ -272,8 +282,8 @@ static int ddebug_change(const struct ddebug_query *query,
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(newflags, &nbuf));
-			set_flags(dp, newflags);
+				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			set_ctrl(dp, &nctrl);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.42.0.869.gea05f2083d-goog

