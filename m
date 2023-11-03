Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69D7E0369
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbjKCNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbjKCNKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061FD4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a5f2193bso2208299e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017026; x=1699621826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI3+psSg/0z6wOi4I/j3+MaVtopAUYjIX515gNS2jUE=;
        b=Bg+WEu/ZU97HP4aJrVKjwXeqUrnMjcKmtoYcUmwIyubrTL8f0lkENN53sl8cRb5ZwK
         BkNUUVzDZ3zJV8Jv3e9gxLwZHJ4MRwRo3OKGhn7q8fmdCvCswFychne/eYrBjxilJP3T
         cyd3AhvcxeLYYG4zlvKNlfPPeMD4rfZaJ5INutD3VS2rBRA1bdD3gcrUlF3xHOS5F9zg
         NYcfA0idpQQcV6YBR5k0WDjaLeFmxE6bGiBxvDl1ZOSBtbpUxn+0ig+g9zAH98opa7mN
         SJfQWU1BVm55qdqA6El0v4PCgxL1ovQR4ffXOMbs3Vv4ft8d5NbmFRTUhj27IA7gJ5LW
         jSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017026; x=1699621826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI3+psSg/0z6wOi4I/j3+MaVtopAUYjIX515gNS2jUE=;
        b=P5YfNvgw9nn/ND7nBXDyA9UO6hqheCQxhUawNJqIPY6jx+u1VaQbd0eht0DvYUal3k
         hlt2+f2BEJrUEYwgU2fPVmJQQ90KmFeSVlQheoQaPHfGG13PHSf5hpgXCJn8sbG3O+q0
         PFbkr4nqTMoteFMRgMWQs34SDOriO4808Uy9AM6g0ocybWR1CYUK1RucmvMNoPWifs4M
         plZ9bSFekvUkkFURMvy0vtGcPQ18kzcIJV3t5u3dOiLAoJHKBVOiZENN2Lmt/MjCKpj1
         B9uKX8iCneJx64IcMmJ/XYx+3GEarzHRMdCDjtIHDopdd+neAFFBuSAo4NN/Dwu7J52s
         MWiw==
X-Gm-Message-State: AOJu0Yz7N1xOk5RISWf3CiF6ntwP5XRfw/PaSApV0VS5Geq0u1CUojxi
        KOgC8Hb7uivrlSoPK44kwMyz
X-Google-Smtp-Source: AGHT+IGuQaAU0GuaN3OJxEwOtd2r1wXMUAEDYFKDcbZy/O2GNqIEpKuBLFo39IclGY05eHu17zM9Vg==
X-Received: by 2002:ac2:48a4:0:b0:509:4421:b38f with SMTP id u4-20020ac248a4000000b005094421b38fmr955208lfg.20.1699017026460;
        Fri, 03 Nov 2023 06:10:26 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:26 -0700 (PDT)
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
Subject: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
Date:   Fri,  3 Nov 2023 14:10:10 +0100
Message-Id: <20231103131011.1316396-12-lb@semihalf.com>
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

When trace is enabled (T flag is set) and trace_dst field is set
to value greater than 0 (0 is reserved for trace events) then
debug logs will be written to trace instance pointed by trace_dst
value, for example when trace_dst value is 2 then debug logs will
be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
Given trace instance will not be initialized until debug logs are
requested to be written to it and afer init will persist until
reboot.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/Kconfig.debug   |  1 +
 lib/dynamic_debug.c | 79 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..9617e92c046d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -181,6 +181,7 @@ config DYNAMIC_DEBUG_CORE
 	bool "Enable core function of dynamic debug support"
 	depends on PRINTK
 	depends on (DEBUG_FS || PROC_FS)
+	depends on TRACING
 	help
 	  Enable core functional support of dynamic debug. It is useful
 	  when you want to tie dynamic debug to your kernel modules with
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c5cd28e74a02..541d9d522b3b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/netdevice.h>
+#include <linux/trace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dyndbg.h>
@@ -81,6 +82,18 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+/*
+ * When trace is enabled (T flag is set) and trace_dst field is set
+ * to value greater than 0 (0 is reserved for trace events) then
+ * debug logs will be written to trace instance pointed by trace_dst
+ * value, for example when trace_dst value is 2 then debug logs will
+ * be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
+ * Given trace instance will not be initialized until debug logs are
+ * requested to be written to it and afer init will persist until
+ * reboot.
+ */
+static struct trace_array *trace_arr[TRACE_DST_MAX];
+
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
 	return &desc->ctrl;
@@ -255,6 +268,45 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
+static int handle_trace_dst(struct dd_ctrl *ctrl)
+{
+#define TRACE_INST_NAME_LEN 16
+	char instance_name[TRACE_INST_NAME_LEN];
+	struct trace_array *arr;
+	int ret = -EINVAL;
+
+	/* check if trace (T flag) is enabled */
+	if (!(ctrl->flags & _DPRINTK_FLAGS_TRACE))
+		return 0;
+
+	/* check if trace destination are trace events */
+	if (!ctrl->trace_dst)
+		return 0;
+
+	/* check if trace instance is already set up */
+	if (trace_arr[ctrl->trace_dst])
+		return 0;
+
+	snprintf(instance_name, TRACE_INST_NAME_LEN,
+		 "dyndbg_inst_%u", ctrl->trace_dst);
+	arr = trace_array_get_by_name(instance_name);
+	if (!arr)
+		goto err;
+
+	ret = trace_array_init_printk(arr);
+	if (ret)
+		goto err_init;
+
+	trace_arr[ctrl->trace_dst] = arr;
+	return 0;
+
+err_init:
+	trace_array_put(arr);
+	trace_array_destroy(arr);
+err:
+	return ret;
+}
+
 #define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
@@ -338,6 +390,9 @@ static int ddebug_change(const struct ddebug_query *query,
 			nctrl.trace_dst = modifiers->trace_dst;
 			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
+
+			if (handle_trace_dst(&nctrl))
+				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
 				if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLED))
@@ -977,8 +1032,8 @@ static DEFINE_PER_CPU(struct ddebug_trace_bufs, ddebug_trace_bufs);
 static DEFINE_PER_CPU(int, ddebug_trace_reserve);
 
 __printf(3, 0)
-static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
-			 const char *fmt, va_list args)
+static void ddebug_trace_event(struct _ddebug *desc, const struct device *dev,
+			       const char *fmt, va_list args)
 {
 	struct ddebug_trace_buf *buf;
 	int bufidx;
@@ -1010,6 +1065,15 @@ static void ddebug_trace(struct _ddebug *desc, const struct device *dev,
 	preempt_enable_notrace();
 }
 
+__printf(2, 0)
+static void ddebug_trace_instance(struct _ddebug *desc, const char *fmt,
+				  va_list *args)
+{
+	struct va_format vaf = { .fmt = fmt, .va = args};
+
+	trace_array_printk(trace_arr[get_trace_dst(desc)], _THIS_IP_, "%pV", &vaf);
+}
+
 __printf(2, 3)
 static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 {
@@ -1022,7 +1086,11 @@ static void ddebug_printk(struct _ddebug *desc, const char *fmt, ...)
 		 * All callers include the KERN_DEBUG prefix to keep the
 		 * vprintk case simple; strip it out for tracing.
 		 */
-		ddebug_trace(desc, NULL, fmt + strlen(KERN_DEBUG), args);
+		if (get_trace_dst(desc))
+			ddebug_trace_instance(desc, fmt, &args);
+		else
+			ddebug_trace_event(desc, NULL,
+					   fmt + strlen(KERN_DEBUG), args);
 		va_end(args);
 	}
 
@@ -1044,7 +1112,10 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 		va_list args;
 
 		va_start(args, fmt);
-		ddebug_trace(desc, dev, fmt, args);
+		if (get_trace_dst(desc))
+			ddebug_trace_instance(desc, fmt, &args);
+		else
+			ddebug_trace_event(desc, dev, fmt, args);
 		va_end(args);
 	}
 
-- 
2.42.0.869.gea05f2083d-goog

