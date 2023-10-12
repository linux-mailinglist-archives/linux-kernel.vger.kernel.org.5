Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388537C772D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442523AbjJLTra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442384AbjJLTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B63CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:23 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fa2dbd793so56866339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140042; x=1697744842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM5rYwdrlUHJ3qGgxecEnebBAR86FDciuES39cltGkM=;
        b=BZSrpsKT+iXyEjxwx8qExQ5jbJURE1tIaq6sbZa88iYC2LxcIDV7mGsVoRmmGcgJVT
         lPcn9zFqF0kQOUFvJlkdDW+oDLVf8B2pQudENR05VD0Aim7mzkismDX4d9gZ4jIOQhfl
         25ikzh6xGkUL/fsnLGplxHW2V/t0UtILKH3wcwR4zshIuqf0xGQEvpx8bi5VqdWhgkpf
         u1ofaoSGcwbD0GJ1tIplsA+X1enn7Tmv8ZzTZ9hJ3OSCnH8Q6bOSYm4Tq2VrzgurV8nF
         K62jhyOgbWiMYkB4CiL6ovr8bdncTSOZsZerSifreanchHAVCHP4XEAqGRB3hmhy4VzU
         CNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140042; x=1697744842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM5rYwdrlUHJ3qGgxecEnebBAR86FDciuES39cltGkM=;
        b=HRNu8HT2BYnkZlCId2fajmDIBX/4J6aKRbS955VYLknimA0xqiTpdwaKqASDd9VeIs
         kqe/FQmWDHRH5bp0HrthB/IL7HO8dySIZitYyCq7f/TisV8cfjKYUkZlE74UHdvuq6Ol
         P+9+A0jnxNM66gwXRhaS7/Fklcn/PDUhhct20o3Q20whjHqOM4gvNmrZNAh3tYP1/AD9
         /JO4PCfgUVJYFLzfhLSWwbYmA1059pPUnfrPke8k8psYRqJMt+Mw2buxbASIyf6njWn3
         ogI1ozxnqIYvFJ7v2rDAkC3TySvf4RZmj7udJnR2ps2XtnrD/kp9U4040jPamhXV96h9
         pMwQ==
X-Gm-Message-State: AOJu0YyDiofkH3dyTY2FqwLU1XjNnVuwCY0BYnkjFPpvT2ISoHldit+6
        IoOkaUDO8/kyzb3HQexaD0pfG0vZk9+iyw==
X-Google-Smtp-Source: AGHT+IGceM5gIpg13Xxjob+QcvLQXenti4VC6/T4P9oMFLg7p3XFso04Nihjee/j89Bz47ENyasfaw==
X-Received: by 2002:a6b:fd01:0:b0:790:c3d0:8f87 with SMTP id c1-20020a6bfd01000000b00790c3d08f87mr26611201ioi.19.1697140042119;
        Thu, 12 Oct 2023 12:47:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:21 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 01/10] dyndbg: prep to isolate 3 repetetive fields
Date:   Thu, 12 Oct 2023 13:47:02 -0600
Message-ID: <20231012194711.3288031-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194711.3288031-1-jim.cromie@gmail.com>
References: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

