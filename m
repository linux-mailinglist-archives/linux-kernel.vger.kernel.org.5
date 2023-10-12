Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00877C772E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442602AbjJLTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442490AbjJLTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B0CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:24 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79faba5fe12so50359439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140043; x=1697744843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUViZFu6qDP+V9dlTKCnuIaJi78i9uWOlvfP3OhngjY=;
        b=asV4D3VDIcoFs14TDMo+umxWesa7DOb5lWJRw78cID4TkbBGE5ia03diFHQRkVjgxs
         SZISY4ykGmmsh8E1Njz9rNtsmoV67otGLBStoturNb/EVAKCdcNKIV4OiwCozcz1mCM/
         ZNnzW8AdsludFXWcV0jhFFm38Bz5Mat82UnJXQZAdr/AacN7MVEv0Zt1LMq9s5kQqh/b
         JIvi4/rJko4hfEZeCtVuOVbF/Rk2Kg4g8wtS12/SCOIosn+p5ByIkPcr6NcXdAXOetbb
         AOq4JJiXudAz8CSXhgtEH5lpTx6b/DjjQGT+2QLAGTleASS19vdOTf+TRIvnIbRQE/cd
         bhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140043; x=1697744843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUViZFu6qDP+V9dlTKCnuIaJi78i9uWOlvfP3OhngjY=;
        b=PSxdHVuRUa3q5YH5rhjvyiDW6JHce0j9a8LG6YNkFc1s3znyZAq9t+2iWWKEmZCz4t
         IUFDLPmhE9jFdCF0zhe6/MlUVtFhLO8CvUpWK8nM+ls3VakrEud63wdl/F1MP1irCJIC
         aoS4lCVEeeMBTo1NU3TyA49WAHT0xU92Z2fjMZyFSGyOvrpkqDBCwQIXHCJGlAzOpANx
         J09dkkHrM3LL+lYyhfMW51v94O7hJ3G+sTo8A7fcsSmu49DlxALJIu+mhGqnSXn6rR4q
         n5c9q8VmOdEBQJ04YZAFB+EJakBnCP8BJQ4MH32VLJidzyEpYxV/hnHSXO4YWPImcnDk
         MLrA==
X-Gm-Message-State: AOJu0YxkxLmyM5Ot8d4LtrFhdPAVF5hmcAH0yxoq9aMG8sK2k4/PVR6D
        XhqvTZVgGkxcLfNJwLgxZYeaP+WOkucPOA==
X-Google-Smtp-Source: AGHT+IEy5LUrHNrM8PB7Uq+J/5nUEH5hYYFEbdVHzf05PX1Vsvj59Q/FEZF7mdKvVdrY8dZihBpf9g==
X-Received: by 2002:a5d:9943:0:b0:79f:d194:d6e2 with SMTP id v3-20020a5d9943000000b0079fd194d6e2mr28680189ios.10.1697140043212;
        Thu, 12 Oct 2023 12:47:23 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 02/10] dyndbg: split __dyndbg_sites section out from __dyndbg
Date:   Thu, 12 Oct 2023 13:47:03 -0600
Message-ID: <20231012194711.3288031-3-jim.cromie@gmail.com>
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

split struct _ddebug_site out from struct _ddebug (adding a site ptr),
and add new __dyndbg_sites section placement to vmlinux.lds.h

This is an implementation detail to isolate the redundant columns into
a separate section, so it specifically excludes lineno.

This allows (later) to copy and compress the info into a better (more
compact) representation thats still fast enough.  Then we can just
reclaim the whole __dyndbg_sites section.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/dynamic_debug.h     | 40 ++++++++++++++++++-------------
 kernel/module/main.c              |  3 +++
 lib/dynamic_debug.c               |  6 +++++
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5451f926a753..1d128259e373 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,6 +368,7 @@
 	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)		\
 	BOUNDED_SECTION_BY(__dyndbg_class_users, ___dyndbg_class_users)	\
 	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)				\
+	BOUNDED_SECTION_BY(__dyndbg_sites, ___dyndbg_sites)		\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index aacfafc466c0..5206a2cfdb37 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -9,21 +9,25 @@
 #include <linux/build_bug.h>
 
 /*
- * An instance of this structure is created in a special
- * ELF section at every dynamic debug callsite.  At runtime,
- * the special section is treated as an array of these.
+ * A pair of these structs are created into 2 special ELF sections for
+ * each pr_debug callsite.  At runtime, the special sections are
+ * treated as arrays.
  */
-
-struct _ddebug {
+struct _ddebug;
+struct _ddebug_site {
 	/*
-	 * These fields are used to drive the user interface
-	 * for selecting and displaying debug callsites.
+	 * These fields are used to:
+	 * - display callsites in the control file
+	 * - query/select callsites by the code's organization
+	 * - prefix/decorate pr_debug messages per user choices
 	 */
-	struct /* _ddebug_site */ {
-		const char *_modname;
-		const char *_function;
-		const char *_filename;
-	};
+	const char *_modname;
+	const char *_function;
+	const char *_filename;
+};
+
+struct _ddebug {
+	struct _ddebug_site *site;
 	const char *format;
 	unsigned int lineno:18;
 #define CLS_BITS 6
@@ -64,10 +68,6 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-#define desc_modname(d)		(d)->modname
-#define desc_filename(d)	(d)->filename
-#define desc_function(d)	(d)->function
-
 enum ddebug_class_map_type {
 	DD_CLASS_TYPE_DISJOINT_BITS,
 	/**
@@ -139,9 +139,11 @@ struct ddebug_class_user {
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
 	struct _ddebug *descs;
+	struct _ddebug_site *sites;
 	struct ddebug_class_map *classes;
 	struct ddebug_class_user *class_users;
 	unsigned int num_descs;
+	unsigned int num_sites;
 	unsigned int num_classes;
 	unsigned int num_class_users;
 };
@@ -226,9 +228,13 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	._filename = __FILE__
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
+	static struct _ddebug_site  __aligned(8)		\
+	__section("__dyndbg_sites") name ##_site = {		\
+		DYNAMIC_DEBUG_SITE_INIT(),			\
+	};							\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		DYNAMIC_DEBUG_SITE_INIT(),			\
+		.site = &(name ##_site),			\
 		.format = (fmt),				\
 		.lineno = __LINE__,				\
 		.flags = _DPRINTK_FLAGS_DEFAULT,		\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6b0b0d82b5ab..43458184744d 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2211,6 +2211,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->dyndbg_info.descs = section_objs(info, "__dyndbg",
 					      sizeof(*mod->dyndbg_info.descs),
 					      &mod->dyndbg_info.num_descs);
+	mod->dyndbg_info.sites = section_objs(info, "__dyndbg_sites",
+					      sizeof(*mod->dyndbg_info.sites),
+					      &mod->dyndbg_info.num_sites);
 	mod->dyndbg_info.classes = section_objs(info, "__dyndbg_classes",
 						sizeof(*mod->dyndbg_info.classes),
 						&mod->dyndbg_info.num_classes);
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c0e595483cb9..0ad9f1bc00f0 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -41,6 +41,8 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
+extern struct _ddebug_site __start___dyndbg_sites[];
+extern struct _ddebug_site __stop___dyndbg_sites[];
 extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 extern struct ddebug_class_user __start___dyndbg_class_users[];
@@ -191,6 +193,10 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
+#define desc_modname(d)		(d)->site->_modname
+#define desc_filename(d)	(d)->site->_filename
+#define desc_function(d)	(d)->site->_function
+
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
-- 
2.41.0

