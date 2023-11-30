Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3317FFF96
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbjK3XlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377355AbjK3XlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:41:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477D10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a18f732dc83so174390966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387675; x=1701992475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Wq8EpQ6dCRcGOk0/JZhMwPd7dekut1Rp7pQcPvRIiQ=;
        b=Bd72puUw2+qMUcz3c27Gv3BYDyrF8XuGurmKFunbINC6l3Xqkz6iswNqf7+M+tyrT7
         BN+0zN9qBRVh84mOPunzLY/mE6N2xm08ZPgtVBqOVcoicSViPHc/cLKs/yx/LeXuqK33
         a/1XixL0qy5zkQ7+LOQts2Dtu+6fJ0e0/rdfPwhma1SD/RZBynQWQOjYDdvwabGwtzd5
         8RwDBfVwPO5W7MCwH2CfaW8UcCega8rx2O6xnGedkKsoaIHvnBa4VyujuW0CxcalHIO/
         pVo5jYLS84XYrfNvWzRkc+6sT6GxWpiaFtaWC7ZxkGVtr34XUw9w5t8usUw3qejwcAly
         tzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387675; x=1701992475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wq8EpQ6dCRcGOk0/JZhMwPd7dekut1Rp7pQcPvRIiQ=;
        b=gyQll01GYtFyirqpiqDU3SNach+E9R8pXcxU0XUCWO3BvtuV8bYNqmnK5mXnLlRyaT
         +107vUoEnqdJOEmtUgePfKTeusKa7NiLo2MeXEBGj2Edzzl3eK5BbjyUZu96tF8Zw6Li
         zTxTnGg5xVwoIUdUH4ATWT8hsodwJpQE0VwFQLclQcSKHMvNAM5KPEW718dHY4ermX7q
         ZUaAfArXC/8o5PwXlBd6TLsRcIKvPK3gEHUiOCxKuy3ckBDwt+f9vQbYlNS/e3yok9eW
         7NszxTla1+y/KY9LxhadWEVujvriweQfGJlhdUBCE0dGzyPmmxRXpQV7K+lY5lRfIdD7
         Fe0Q==
X-Gm-Message-State: AOJu0YzRoYayUXSZYuRrysojlw+cQEKo16wjGHMXCcSWdDeSBn+aJnyJ
        NdYOtylgdWJnVgY40/k7boCb
X-Google-Smtp-Source: AGHT+IG8TeQ+Zx3H3YN74SgCo0q6DDaeAMwm7mi2DhuuInzgByqvCQ2Twc/uEAZnoZAX9wm10qB19g==
X-Received: by 2002:a17:906:73c2:b0:9c7:59ff:b7fd with SMTP id n2-20020a17090673c200b009c759ffb7fdmr373547ejl.28.1701387675442;
        Thu, 30 Nov 2023 15:41:15 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:41:15 -0800 (PST)
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
Subject: [PATCH v2 01/15] dyndbg: add _DPRINTK_FLAGS_ENABLED
Date:   Fri,  1 Dec 2023 00:40:34 +0100
Message-ID: <20231130234048.157509-2-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130234048.157509-1-lb@semihalf.com>
References: <20231130234048.157509-1-lb@semihalf.com>
MIME-Version: 1.0
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

From: Jim Cromie <jim.cromie@gmail.com>

Distinguish the condition: _DPRINTK_FLAGS_ENABLED from the bit:
_DPRINTK_FLAGS_PRINT, and re-define former in terms of latter, in
preparation to add a 2nd bit: _DPRINTK_FLAGS_TRACE

Update JUMP_LABEL code block to check _DPRINTK_FLAGS_ENABLED symbol.
Also add a 'K' to get new symbol _DPRINTK_FLAGS_PRINTK, in order to
break any stale uses.

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 10 ++++++----
 lib/dynamic_debug.c           |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..7be791af7cf1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,7 +32,7 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +44,10 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
+#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+
 #if defined DEBUG
-#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
@@ -199,10 +201,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..ee0cb37153ef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -89,7 +89,7 @@ static inline const char *trim_prefix(const char *path)
 }
 
 static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -247,10 +247,10 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(newflags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
+			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
-- 
2.43.0.rc2.451.g8631bc7472-goog

