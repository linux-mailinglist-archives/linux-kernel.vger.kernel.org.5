Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BB47E036A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377659AbjKCNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377612AbjKCNKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18FD51
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50930f126b1so2496006e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017027; x=1699621827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZSPUorn4pTdADZrPzHb8i7AO+zsH0qYfe7SAa+uJVc=;
        b=OVwj/ta4ja6sMcG5kOo50EXcyYnI1coX0VATo8UALsqhvhWOyDaPC2GRDGWxwQ3zX1
         viFZIJZubLGF5M/thHIvE0Gi6jggVkpnWlTQ6LpZZXgTPjTCjcqP9QF3s8KBpyMEHaN+
         C59/1J5ZXnTbNRvKZYb4JRCnJXqMIZLweiDA47q5P+ASj2jCPq4ARO2vXikMprIomIsj
         w8FGiWa31DJLP4B/TY5s2RwMegqz++F76Kwczohjc9Hikm4cnQp/Lt6Fd2G2exVrFPu3
         /H9P8UWpa1Ar7mLpJlbdGiTuByPQGkX7dZWxR5vCzvxVpKtSVIRqt1De/FNOrqpKm6bU
         H7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017027; x=1699621827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZSPUorn4pTdADZrPzHb8i7AO+zsH0qYfe7SAa+uJVc=;
        b=udM8Q9WwU0WTMO1U/lPDulfovUslncL2v12EwWlWWfV67DH+ORPeC+O5RFvCWb4F1a
         9rMxGc4AZBHaLXHz6zFBon3VjNLVf0TuVnMeG9VOqxKgHlztOT2Arlz1EeVdyxd0WYKc
         9R5k6R64MDYAb3Ym3YNiYB4RfHwCEC0Y6AdSxMn/SHkBWYDZzxmhB9TngnW3uXtOOEjt
         C5CzttXZxrpKWgxcgdEpGacBdC/d67VdNRlYxYvRtcUHzMgDpEkRy9CoCirE5C7zUTnm
         JhrO9GTHYQGiNooBQVh/BB+1Vz3/hTlA29B/BSh3l6tlV9hjAoL3lBRp0VYtGNzXwdcg
         p/7Q==
X-Gm-Message-State: AOJu0Yx0WMCFgMTOTlC5AN3lTe3qJ3fCDIkqYA2i99nkveuGpqfLFTz8
        QvOCoZZ4MVy4plGcfn8T0lox
X-Google-Smtp-Source: AGHT+IE/9U48t0tU5PPZhFGUjTuLEUVf68zErXPFQG4ELxF6/Ta4zhL/CgztUcIgO1+IihRf2R4IWw==
X-Received: by 2002:a19:6d03:0:b0:507:c763:27a5 with SMTP id i3-20020a196d03000000b00507c76327a5mr14710758lfc.62.1699017027390;
        Fri, 03 Nov 2023 06:10:27 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:27 -0700 (PDT)
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
Subject: [PATCH v1 12/12] dyndbg: add trace support for hexdump
Date:   Fri,  3 Nov 2023 14:10:11 +0100
Message-Id: <20231103131011.1316396-13-lb@semihalf.com>
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

Add support for writing hexdump debug logs to trace.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 16 ++++++++++------
 lib/dynamic_debug.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 3084302876b4..e01b529dcd09 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -298,12 +298,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	_dynamic_func_call(fmt, __dynamic_ibdev_dbg,		\
 			   dev, fmt, ##__VA_ARGS__)
 
-#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
-			 groupsize, buf, len, ascii)			\
-	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
-				   print_hex_dump,			\
-				   KERN_DEBUG, prefix_str, prefix_type,	\
-				   rowsize, groupsize, buf, len, ascii)
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii);
+
+#define dynamic_hex_dump(prefix_str, prefix_type, rowsize,				\
+			 groupsize, buf, len, ascii)					\
+	_dynamic_func_call(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump",	\
+			   _print_hex_dump,						\
+			   KERN_DEBUG, prefix_str, prefix_type,				\
+			   rowsize, groupsize, buf, len, ascii)
 
 /* for test only, generally expect drm.debug style macro wrappers */
 #define __pr_debug_cls(cls, fmt, ...) do {			\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 541d9d522b3b..fb2c6e2909bb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1128,6 +1128,41 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
 	}
 }
 
+void _print_hex_dump(struct _ddebug *descriptor, const char *level,
+		     const char *prefix_str, int prefix_type, int rowsize,
+		     int groupsize, const void *buf, size_t len, bool ascii)
+{
+	const u8 *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 1];
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				   linebuf, sizeof(linebuf), ascii);
+
+		switch (prefix_type) {
+		case DUMP_PREFIX_ADDRESS:
+			ddebug_printk(descriptor, "%s%s%p: %s\n",
+				      level, prefix_str, ptr + i, linebuf);
+			break;
+		case DUMP_PREFIX_OFFSET:
+			ddebug_printk(descriptor, "%s%s%.8x: %s\n",
+				      level, prefix_str, i, linebuf);
+			break;
+		default:
+			ddebug_printk(descriptor, "%s%s%s\n",
+				      level, prefix_str, linebuf);
+			break;
+		}
+	}
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.42.0.869.gea05f2083d-goog

