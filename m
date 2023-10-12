Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCF7C7747
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442959AbjJLTt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442434AbjJLTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC7BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fe6da0049so55267339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140122; x=1697744922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeZlT3fWkSsRBBC0KH8nwdyunCgP5eGN9Bq/f3gwBO4=;
        b=V/v2dyJRdLMTggpwruH4K9XrHfEkCTLAqWlCyOMkdgwjUkNjOCIIqccC/qoqXSNf2c
         XNkv9sYmZKwCIxXQZ6cyBwgLZARmo+kf9YYNMeUQ3QTLHAxcycmHtfoUc6mnhnFfYqiv
         ZXGSZ3LFLm2voWs9aq5QgIFnLyEQgCPFOBeqSYqPQtq0kDZzhh5rIRmmyI3K48r6JU3R
         hYOxPcn5nI/wYYZiV8AZo8HYcgzFq1YJaOz/VKELkX+fes4x2NYGdc0A52mzAMpfd9hX
         n4OnG61M/VMC+2e7V3wuW/mTodGuJPHiKXLGcUMmv0U1Q6XarAiYXocZjGE+NA/pZhIw
         wjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140122; x=1697744922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeZlT3fWkSsRBBC0KH8nwdyunCgP5eGN9Bq/f3gwBO4=;
        b=WNe+5/bz4r52wYs9GWSZITzhKHVUYDuXYgEDk2nWfoPsTNUSRNityldDGTFhfVt7hJ
         asyF5ydA/aOGhbB7ILcWLKngJs0MFHTpcjWTyUDtyZnBdXpA65tXhQDCSTTPQPbX/kY0
         S0aO2CcTd6qCspEriByNBwzWnDRcm84gkHOvDiugTamFs3J60WHS+NV82tJi9JS4jGO+
         O6sjcwvNtYEbNdW1aKNA8RUnoqb8Dfud56jBoVOloy6lu0kYZgjOLqJPRphBtxgd/JVZ
         qGxeBJ2UWGkoHq+GJzHCg0MRR2uzJ85EsnCMJVhBpZjbisTsJiKvpS6ZvZfD1XWBPPLb
         epfQ==
X-Gm-Message-State: AOJu0Yyednk+ENoJOYsASZQQMxvmoI/RJflAQUurKQB2xNTyZGcxLDFD
        snjOZ8sY97eP7bbwIp3PR9IXQNcr7sV2BQ==
X-Google-Smtp-Source: AGHT+IFFhJf/S6gN8jP4a20rhHTQC/HvlBHfDKD0Jy1c5AB7c08SdgSogYnGLzu7Mmjg+FissnHXPA==
X-Received: by 2002:a5e:8c0c:0:b0:794:efb0:83d6 with SMTP id n12-20020a5e8c0c000000b00794efb083d6mr30403278ioj.12.1697140122710;
        Thu, 12 Oct 2023 12:48:42 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 06/10] dyndbg: add site_*() macros to avoid using _ddebug.site
Date:   Thu, 12 Oct 2023 13:48:30 -0600
Message-ID: <20231012194834.3288085-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adjust ddebug_condense_sites() and dynamic_debug_init() to replace
desc_*() uses with new site_*() macros which avoid the _ddebug.site
pointers by relying upon site* cursors instead.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 563d373224ba..48564625a37e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1426,6 +1426,9 @@ static void dd_store_range(struct maple_tree *mt, const struct _ddebug *start,
 		v4pr_info("  ok %s at %lx\n", val, first);
 }
 
+#define site_function(s)	(s)->_function
+#define site_filename(s)	(s)->_filename
+#define site_modname(s)		(s)->_modname
 
 static void ddebug_condense_sites(struct _ddebug_info *di)
 {
@@ -1440,27 +1443,27 @@ static void ddebug_condense_sites(struct _ddebug_info *di)
 
 		BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
 
-		if (!strcmp(desc_function(cur_dd), desc_function(func_dd)))
+		if (!strcmp(site_function(cur_ds), site_function(func_ds)))
 			continue;
-		dd_store_range(&mt_funcs, func_dd, cur_dd, "func", desc_function(func_dd));
+		dd_store_range(&mt_funcs, func_dd, cur_dd, "func", site_function(func_ds));
 		func_dd = cur_dd;
 		func_ds = cur_ds;
 
-		if (!strcmp(desc_filename(cur_dd), desc_filename(file_dd)))
+		if (!strcmp(site_filename(cur_ds), site_filename(file_ds)))
 			continue;
-		dd_store_range(&mt_files, file_dd, cur_dd, "file", desc_filename(file_dd));
+		dd_store_range(&mt_files, file_dd, cur_dd, "file", site_filename(file_ds));
 		file_dd = cur_dd;
 		file_ds = cur_ds;
 
-		if (!strcmp(desc_modname(cur_dd), desc_modname(mod_dd)))
+		if (!strcmp(site_modname(cur_ds), site_modname(mod_ds)))
 			continue;
-		dd_store_range(&mt_mods, mod_dd, cur_dd, "mod", desc_modname(mod_dd));
+		dd_store_range(&mt_mods, mod_dd, cur_dd, "mod", site_modname(mod_ds));
 		mod_dd = cur_dd;
 		mod_ds = cur_ds;
 	}
-	dd_store_range(&mt_funcs, func_dd, cur_dd, "func:", desc_function(func_dd));
-	dd_store_range(&mt_files, file_dd, cur_dd, "file:", desc_filename(file_dd));
-	dd_store_range(&mt_mods, mod_dd, cur_dd, "mod:", desc_modname(mod_dd));
+	dd_store_range(&mt_funcs, func_dd, cur_dd, "func:", site_function(func_ds));
+	dd_store_range(&mt_files, file_dd, cur_dd, "file:", site_filename(file_ds));
+	dd_store_range(&mt_mods, mod_dd, cur_dd, "mod:", site_modname(mod_ds));
 }
 
 /*
@@ -1688,13 +1691,13 @@ static int __init dynamic_debug_init(void)
 	}
 
 	site = site_mod_start = di.sites;
-	iter = iter_mod_start = __start___dyndbg;
-	modname = desc_modname(iter);
+	iter = iter_mod_start = di.descs;
+	modname = site_modname(site);
 	i = mod_sites = mod_ct = 0;
 
 	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
 
-		if (strcmp(modname, desc_modname(iter))) {
+		if (strcmp(modname, site_modname(site))) {
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.num_sites = mod_sites;
@@ -1705,7 +1708,7 @@ static int __init dynamic_debug_init(void)
 				goto out_err;
 
 			mod_sites = 0;
-			modname = desc_modname(iter);
+			modname = site_modname(site);
 			iter_mod_start = iter;
 			site_mod_start = site;
 		}
-- 
2.41.0

