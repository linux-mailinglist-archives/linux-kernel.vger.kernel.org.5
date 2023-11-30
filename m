Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE87FFFA3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377316AbjK3XnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbjK3XnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:43:09 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF22D73
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bca79244fso2171942e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1701387737; x=1701992537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAxdVKRV7B/lxV4lDmwYdRUAU2qmKuUmSjMzK6aeeaI=;
        b=Kl9B17I4boh5b08Kg7UbT9j6Ldfo/dMiDTDhpRmGcnV9Q+MJl2BJwxrJfWidx9eB4k
         CeGJKLnOTVcK/qRVUfuYP/m16COuEDkmhYWvjxIFkasSaU+kXalJKt/ORqqlivwFGfg5
         yDL0WTExruLQu79kxDhtayfay8qqM4N3M6Xkye8B/dTVnk3fkz5wae9w88q/o2U3+O4l
         IxAY8rh9STndJ+TNL3Q8UdvFPpIivEyLy3GvFt+ePHdITgqx9Y4fbp/f+OcX2aKPe/za
         MxRp7CxMd768cRVRQQ8EPOo7L5uUkTN+wpBDaawDAoo7lMGTc6pQfH24Id4P/p13FeC3
         Ci+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387737; x=1701992537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAxdVKRV7B/lxV4lDmwYdRUAU2qmKuUmSjMzK6aeeaI=;
        b=udlgMunaWoljGxDctNM1ERHaOTetYnRNPc+Qk9fjQRhOC4aiqDj1/X9B6iu2D6YDDn
         tzY5y8hTMcVjSTDWd35wqylTXD9LsanB9KIwX1BVIK1hwHR2vow+oRLronVRTzfHxlWO
         fmP9+WjrKM1iXdfm/6evfy99x0vrBSHh5wao1ilUQ7uCavD8uz1qwBGrzyyL5Yz7lrx2
         O70ab9R1JB6eDuvBvejCF9X5c8qfGqdeqb2KGlc7AUvyjmsTDbxpIewEGCr24vOuk5tY
         2TraqeNZfJMWg+bUJftCvhZpkev7nvjiS5xsxV3A5U0p5TQtsnPJasj3TevDyeUwAOlZ
         SDgw==
X-Gm-Message-State: AOJu0YyM2M/Maw/xGOYtFQN4LI+VDOeMcdItpB6yViv+qsl/FL5wCTkp
        nYo/e5HOzqLbQJug0iSczyhv
X-Google-Smtp-Source: AGHT+IGEBpsoqxNnPCaOLOCImppjHglDtpfgNOSv+MAtgGPUUibigOkvU9x/HJWWdhG6F6aYc0CV4A==
X-Received: by 2002:a19:f014:0:b0:50b:d764:76d0 with SMTP id p20-20020a19f014000000b0050bd76476d0mr152044lfc.95.1701387737270;
        Thu, 30 Nov 2023 15:42:17 -0800 (PST)
Received: from ukaszb-l.semihalf.net (public-gprs368940.centertel.pl. [37.47.72.109])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906100900b009ddaf5ebb6fsm1210175ejm.177.2023.11.30.15.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 15:42:16 -0800 (PST)
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
Subject: [PATCH v2 15/15] dyndbg: add support for hex_dump output to trace
Date:   Fri,  1 Dec 2023 00:40:48 +0100
Message-ID: <20231130234048.157509-16-lb@semihalf.com>
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

Add support for writing hex_dump debug logs to trace.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 include/linux/dynamic_debug.h | 16 ++++++++++------
 lib/dynamic_debug.c           | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 5555857d9ba5..08d8d951e41d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -300,12 +300,16 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
index afcc536c2e91..71db40df31b2 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1354,6 +1354,41 @@ static void ddebug_dev_printk(struct _ddebug *desc, const struct device *dev,
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
2.43.0.rc2.451.g8631bc7472-goog

