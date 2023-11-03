Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159517E0368
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377151AbjKCNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjKCNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D907D4C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2508173e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017024; x=1699621824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mQYTJ70pc6Q6adrELeKdGI1nIru5AIIoaJ2DUP8/rw=;
        b=Y8Ba87jy1RPOumI0C3IgX8syk7NAFRsXnn2wEIcUhnio8tiz4Kd5BJT4mA829Hpstb
         ci1qCJDBQ/J6sTskJCdmbV3Gun9HR1D9eEbc8TCYrQpPjw1X1sITRt5oGK3afNuyda3c
         uUHTtjkSqJqW6iPWypkao6pbR9RH2crefiBmaHmC84j1VfO/0TcrQj3RNKxBS7ZXp1Cs
         Y36y6gfB4joySMhq3ZE8RQFvkO4IrYwet2Uv2jsp4orcm6CT3fxAHCWlA6TT1VGo9wq1
         T8EU2bpgSqIM6R1F4AZ6lOL324Hr0InLPe84sbLsAIK0CII45C/IIJdTTPISsrqFlMSv
         gDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017024; x=1699621824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mQYTJ70pc6Q6adrELeKdGI1nIru5AIIoaJ2DUP8/rw=;
        b=SghHmQiv8dIHkOid9Sm7/gYR2kupSePdSq099U5986gFG7XUOL9EWci1cgDRqj/ycN
         8Rr5Zcwx94lXYfEZ0A6NyZjyzW9D0XvAwLLYDzKQm860O4rERvI0Roe5Q5we8NhajGbL
         dDsSiIsGzY8kATGjEXWPpAaBNXjDU4774ZnP7n9VcQtA98TMgPKwJTCb06bY8KC+6rV8
         5NxFWpkTdD3ShguuRrH1VnkE+eNMKK7x+QVlP41jAqVwfj+3pPBSan8BZi8dOt0rPmxx
         xSpt31KSR0t2jO7rCNZcacTARCwSU1+BrOLh0htjHHr/iIzdccMlqdiL9+XShUldIZFx
         M2UQ==
X-Gm-Message-State: AOJu0Yw8U6Gvqdbp6Igfjts0buZzyXZ+9V7k1S3EtcRxxuR4utyrMclD
        1IDjXqMt2R6NDmNNpo8Cm90q
X-Google-Smtp-Source: AGHT+IHQDh4Eeno3q8Ts2UslN99Nr/9Ts/QOWOUUQ1UycyMmk3BM9ArqlMmDqc1ljiLOwKTpr8MYhA==
X-Received: by 2002:a05:6512:1093:b0:503:1bb0:a658 with SMTP id j19-20020a056512109300b005031bb0a658mr21570248lfg.32.1699017023780;
        Fri, 03 Nov 2023 06:10:23 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:23 -0700 (PDT)
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
Subject: [PATCH v1 08/12] dyndbg: move flags field to a new structure
Date:   Fri,  3 Nov 2023 14:10:07 +0100
Message-Id: <20231103131011.1316396-9-lb@semihalf.com>
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

Add a new structure ctrl and place it in 4 padding bytes
of _ddebug struct. Move flags field to the ctrl struct
and create setter and getter for the flags field. Add unused
fields to explicitly emphasise size of each bitfield.
This step prepares for addition of a trace_dst field.

Layout of _ddebug struct after addition of ctrl is:

struct _ddebug {
        union {
                struct static_key_true dd_key_true;      /*     0    16 */
                struct static_key_false dd_key_false;    /*     0    16 */
        } key;                                           /*     0    16 */
        union {
                struct static_key_true     dd_key_true;  /*     0    16 */
                struct static_key_false    dd_key_false; /*     0    16 */
        };

        const char  *              modname;              /*    16     8 */
        const char  *              function;             /*    24     8 */
        const char  *              filename;             /*    32     8 */
        const char  *              format;               /*    40     8 */
        unsigned int               lineno:18;            /*    48: 0  4 */
        unsigned int               class_id:6;           /*    48:18  4 */
        unsigned int               unused:8;             /*    48:24  4 */
        struct dd_ctrl             ctrl;                 /*    52     4 */

        /* size: 56, cachelines: 1, members: 9 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h |  9 +++++--
 lib/dynamic_debug.c           | 44 ++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b9237e4ecd1b..684766289bfc 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,8 @@ struct _ddebug {
 #define CLS_BITS 6
 	unsigned int class_id:CLS_BITS;
 #define _DPRINTK_CLASS_DFLT		((1 << CLS_BITS) - 1)
+	unsigned int unused:8;
+
 	/*
 	 * The flags field controls the behaviour at the callsite.
 	 * The bits here are changed dynamically when the user
@@ -58,7 +60,10 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	unsigned int flags:8;
+	struct {
+		unsigned int flags:8;
+		unsigned unused:24;
+	} ctrl;
 } __attribute__((aligned(8)));
 
 enum class_map_type {
@@ -171,7 +176,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 		.filename = __FILE__,				\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
-		.flags = _DPRINTK_FLAGS_DEFAULT,		\
+		.ctrl = { .flags = _DPRINTK_FLAGS_DEFAULT },	\
 		.class_id = cls,				\
 		_DPRINTK_KEY_INIT				\
 	};							\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1ed3c4f16f69..ca87adf327df 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,6 +80,16 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline unsigned int get_flags(const struct _ddebug *desc)
+{
+	return desc->ctrl.flags;
+}
+
+static inline void set_flags(struct _ddebug *desc, unsigned int val)
+{
+	desc->ctrl.flags = val;
+}
+
 /* Return the path relative to source root */
 static inline const char *trim_prefix(const char *path)
 {
@@ -247,11 +257,11 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (dp->flags & modifiers->mask) | modifiers->flags;
-			if (newflags == dp->flags)
+			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (newflags == get_flags(dp))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
 				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
 			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
@@ -261,9 +271,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
-				  ddebug_describe_flags(dp->flags, &fbuf),
+				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
-			dp->flags = newflags;
+			set_flags(dp, newflags);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
@@ -824,10 +834,11 @@ static int remaining(int wrote)
 
 static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
+	unsigned int flags = get_flags(desc);
 	int pos_after_tid;
 	int pos = 0;
 
-	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
+	if (flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
 		else
@@ -835,16 +846,16 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->modname);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+	if (flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				desc->function);
-	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
+	if (flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
 				trim_prefix(desc->filename));
-	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
+	if (flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				desc->lineno);
 	if (pos - pos_after_tid)
@@ -857,7 +868,7 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 
 static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
 {
-	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
+	if (unlikely(get_flags(desc) & _DPRINTK_FLAGS_INCL_ANY))
 		return __dynamic_emit_prefix(desc, buf);
 	return buf;
 }
@@ -917,7 +928,8 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -929,7 +941,7 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -943,7 +955,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 			      const char *fmt, ...)
 {
 
-	if (desc->flags & _DPRINTK_FLAGS_TRACE) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_TRACE) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -951,7 +963,7 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_end(args);
 	}
 
-	if (desc->flags & _DPRINTK_FLAGS_PRINTK) {
+	if (get_flags(desc) & _DPRINTK_FLAGS_PRINTK) {
 		va_list args;
 
 		va_start(args, fmt);
@@ -1247,7 +1259,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
 		   iter->table->mod_name, dp->function,
-		   ddebug_describe_flags(dp->flags, &flags));
+		   ddebug_describe_flags(get_flags(dp), &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
 
-- 
2.42.0.869.gea05f2083d-goog

