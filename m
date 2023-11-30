Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88DB7FFF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377425AbjK3Xlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377259AbjK3Xlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0787172A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a18ebac19efso179906166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387708; x=1701992508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvWBqsBruFEKsR0MhC+h7002KX53XW9q92xWDwe3s6Y=;
        b=Rk7dWZlYEVjjynwObaSgHs3cg9IweMy9dryzTT1AQnxZh7gkKRWwxso0XsGWtlDLqn
         3NTz4u0tiRdKJpfYN71vbXsQBjscvCKJSh4ZiMTHC4Ud0UN40Q6/zEid7LdrRFhivMNz
         B42GwwJGYexZ3lmxLgT4GNR084w578MTxu9RR4LRGbvWQMVCZ5mrvfKSTjkr2HJX+CKr
         4Qmr+UCb7GAc7nL2klPdtwMWdjGX/+bk5ddS5TtiKuZJ57YReeLp5cIEOe0Ar5hS2C1K
         SxnTnOZyG9OCipDJbyINMrlHyO7dzADZvCSs+Mzzph/uS1YzYZDx4UnbHbyDHpMKN7cF
         zJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387708; x=1701992508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvWBqsBruFEKsR0MhC+h7002KX53XW9q92xWDwe3s6Y=;
        b=WlO9TiNwOxbO7VYjsBE7FQqUYdt0hpKmtHkTVfDv3xOiAq/WYGsBlOMSe0sdN+zZqg
         N5PvNwQjLlx2bOFt/yZN3HaCGMShpOejdInIxVhzZuznY4XPd7foDHO1ReOZmpF7nLty
         kH+W7CD1DEv1BLG+Zm5tA7kObQ9Wk3IhAyau2NOSils674wMeC3zoP8VSKGNp1EDWr04
         gry/bcatUH5e9fdjnJWd1PqCY/VMUu/aRBkpK2/FnzlbgzwNfrtolQyRNeuDQ2KByx2a
         67gOYmad/0MUDFv6wilShFDyKXoU+gO94rPuedKDLcJUrnMjlT6dnFBLH6LNiGgWzcGd
         HpVQ==
X-Gm-Message-State: AOJu0Yw5Q2Pwywlqerv9eirE4pKXr2GfMy+YMS+m2q1UKWFwXGZQ/LMH
        ZEc+7lLekCH8PrKpXop/oaaH
X-Google-Smtp-Source: AGHT+IF2tOy1mmLqNkETl1ATpBslNTkPe++WMHkHfKYECkGJbUCbCLKg0D9ZE05c5yqAMqi4jTG3Pg==
X-Received: by 2002:a17:906:f2d2:b0:a18:8c37:239f with SMTP id gz18-20020a170906f2d200b00a188c37239fmr358773ejb.19.1701387708223;
        Thu, 30 Nov 2023 15:41:48 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:47 -0800 (PST)
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
Subject: [PATCH v2 09/15] dyndbg: add trace destination field to _ddebug
Date:   Fri,  1 Dec 2023 00:40:42 +0100
Message-ID: <20231130234048.157509-10-lb@semihalf.com>
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

Add trace destination field (trace_dst) to the _ddebug structure.
The trace destination field is used to determine output of debug
logs when +T is set. Setting trace_dst value to TRACE_DST_BITS(63)
enables output to prdbg and devdbg trace events. Setting trace_dst
value to a value in range of [0..62] enables output to trace instance.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 14 ++++++++++++--
 lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 684766289bfc..56f152e75604 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,9 +60,19 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	struct {
+	struct dd_ctrl {
 		unsigned int flags:8;
-		unsigned unused:24;
+	/*
+	 * The trace destination field is used to determine output of debug
+	 * logs when +T is set. Setting trace_dst value to TRACE_DST_MAX(63)
+	 * enables output to prdbg and devdbg trace events. Setting trace_dst
+	 * value to a value in range of [0..62] enables output to trace
+	 * instance.
+	 */
+#define TRACE_DST_BITS 6
+		unsigned int trace_dst:TRACE_DST_BITS;
+#define TRACE_DST_MAX	((1 << TRACE_DST_BITS) - 1)
+		unsigned unused:18;
 	} ctrl;
 } __attribute__((aligned(8)));
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f47cb76e0e3d..0dc9ec76b867 100644
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
2.43.0.rc2.451.g8631bc7472-goog

