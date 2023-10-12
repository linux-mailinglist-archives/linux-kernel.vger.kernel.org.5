Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119E07C773F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442896AbjJLTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442716AbjJLTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:01 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A56FD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fb64b5265so55330939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140118; x=1697744918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM5rYwdrlUHJ3qGgxecEnebBAR86FDciuES39cltGkM=;
        b=aj+KRwpC1cmoM6NSANYphNSYheZ62vD3JBs7HcGpT8pTLp6y0zcRFxbpAZiwOzjAOr
         cQ9V0nPuR96UMh7E1Sy00rdUCYmrzlKyfkG18sQdhievHuWta/+dp78uj3XqMAz9NYLd
         WccHaC1wh+CtaG6LUQ8u1yP6/YvtRuX51dB5Up+N4cXjUtbaZ+c0NJAGZfPbQ36LRxNj
         xsEQpJkVXgyq2To3KzGwhPxNMcahWzNK+DNK5c3Zd99Bl370oLYLWFX+WEyxdeFdyMCX
         YAPVGhJzamTOVaxTUpzMsP4TIOIyHPtkx3/u9kZvAXaWdRHwnIj/xVUIUrYLxSp2X+5a
         ZR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140118; x=1697744918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM5rYwdrlUHJ3qGgxecEnebBAR86FDciuES39cltGkM=;
        b=YUT7i9KJh4iacGmWjd3OUyJGPhsq30/lL6ft+X12gjuoA0MgCLn3v0ReWdCqtkVDrP
         amis28nhXmKitCCalYZUBZjaFmDsFHJmRe4gTVJmNILhpjTFmH7f6kkdCM8/vYw1fl0A
         WcYUW8LQOAEBaZ8AOeU29P15xfquUh2HP38ceQ69KUwVlcNPv2BqEQnqVBEckWJ8IFq8
         h8KzOY/zd/4oD9fLBq4uyuSyd/GDM5xWwqY/tFGix8sSb8CuPB5RAELc74wJxsJxYIRe
         a3ppJpkkPkseKbxUke8HcQyEcqi/fy3cEC3zmPU+LaMWVhWL7DhfIa7Bylb2Ut1UkQf3
         A2tw==
X-Gm-Message-State: AOJu0YxXXJFk5CoItv1p0VmDwKOIa3U+fmv0dNjX52NrnKueJcCZCqus
        gK6IQmr8xp3jrmjRfbO5I2q0G1bCvH4mTw==
X-Google-Smtp-Source: AGHT+IHJQgyemV60d0TtSM5gRZcC8BOKY9QEWfAWdNthxj5Xm9QnZob6Y9eoYwqr1EmvKzVb/INxVg==
X-Received: by 2002:a05:6602:211a:b0:792:43b4:dc2 with SMTP id x26-20020a056602211a00b0079243b40dc2mr28000700iox.3.1697140118215;
        Thu, 12 Oct 2023 12:48:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:37 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 01/10] dyndbg: prep to isolate 3 repetetive fields
Date:   Thu, 12 Oct 2023 13:48:25 -0600
Message-ID: <20231012194834.3288085-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move 3 fields: modname, filename, function into an anonymous struct,
and rename with '_' prefix to catch stale uses.

Add 3 desc_*() macros to abstract the field refs.

Add DYNAMIC_DEBUG_SITE_INIT() to initialize the fields.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 22 ++++++++++++++++------
 lib/dynamic_debug.c           | 28 ++++++++++++++--------------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2237d454bc19..aacfafc466c0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -13,14 +13,17 @@
  * ELF section at every dynamic debug callsite.  At runtime,
  * the special section is treated as an array of these.
  */
+
 struct _ddebug {
 	/*
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
 	 */
-	const char *modname;
-	const char *function;
-	const char *filename;
+	struct /* _ddebug_site */ {
+		const char *_modname;
+		const char *_function;
+		const char *_filename;
+	};
 	const char *format;
 	unsigned int lineno:18;
 #define CLS_BITS 6
@@ -61,6 +64,10 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
+#define desc_modname(d)		(d)->modname
+#define desc_filename(d)	(d)->filename
+#define desc_function(d)	(d)->function
+
 enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
@@ -213,12 +220,15 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
+#define DYNAMIC_DEBUG_SITE_INIT()			\
+	._modname = KBUILD_MODNAME,			\
+	._function = __func__,				\
+	._filename = __FILE__
+
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.modname = KBUILD_MODNAME,			\
-		.function = __func__,				\
-		.filename = __FILE__,				\
+		DYNAMIC_DEBUG_SITE_INIT(),			\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3dc512fb1d66..c0e595483cb9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -235,16 +235,16 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			/* match against the source filename */
 			if (query->filename &&
-			    !match_wildcard(query->filename, dp->filename) &&
+			    !match_wildcard(query->filename, desc_filename(dp)) &&
 			    !match_wildcard(query->filename,
-					   kbasename(dp->filename)) &&
+					    kbasename(desc_filename(dp))) &&
 			    !match_wildcard(query->filename,
-					   trim_prefix(dp->filename)))
+					    trim_prefix(desc_filename(dp))))
 				continue;
 
 			/* match against the function */
 			if (query->function &&
-			    !match_wildcard(query->function, dp->function))
+			    !match_wildcard(query->function, desc_function(dp)))
 				continue;
 
 			/* match against the format */
@@ -281,8 +281,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			}
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
-				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  trim_prefix(desc_filename(dp)), dp->lineno,
+				  dt->mod_name, desc_function(dp),
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -781,13 +781,13 @@ static int __dynamic_emit_prefix(const struct _ddebug *desc, char *buf, int pos)
 {
 	if (desc->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
+				desc_modname(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+				desc_function(desc));
 	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
 		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				trim_prefix(desc->filename));
+				trim_prefix(desc_filename(desc)));
 	return pos;
 }
 
@@ -1110,8 +1110,8 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
-		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   trim_prefix(desc_filename(dp)), dp->lineno,
+		   iter->table->mod_name, desc_function(dp),
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_puts(m, "\"");
@@ -1528,12 +1528,12 @@ static int __init dynamic_debug_init(void)
 	}
 
 	iter = iter_mod_start = __start___dyndbg;
-	modname = iter->modname;
+	modname = desc_modname(iter);
 	i = mod_sites = mod_ct = 0;
 
 	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
 
-		if (strcmp(modname, iter->modname)) {
+		if (strcmp(modname, desc_modname(iter))) {
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
@@ -1542,7 +1542,7 @@ static int __init dynamic_debug_init(void)
 				goto out_err;
 
 			mod_sites = 0;
-			modname = iter->modname;
+			modname = desc_modname(iter);
 			iter_mod_start = iter;
 		}
 	}
-- 
2.41.0

