Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9627C7733
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442723AbjJLTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442512AbjJLTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8107BE0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa2125e19so49776739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140047; x=1697744847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeZlT3fWkSsRBBC0KH8nwdyunCgP5eGN9Bq/f3gwBO4=;
        b=DZd4FW2YTxozpL1GyBzPAx27G7hnEMyvApYewJ56wGo0nL3yGowG2KxRmjlzVqjNis
         GSP6I4Bu4XhfwuZum2P6mIqipoo//3vGqw1JzcFh8e3kixFHm+DKN5Tm2RNZp4A1uM9G
         xPh12+PskUcyXDXGUtalU+CVjZoihSfRD+y0cB9r9VKF2pmEgWMThwXSDhAb/QvUOYxh
         K28WpDCVLjR1jw1DrDhdCgoiAVlQJj13nHDPr+0efjGaH7+Qyj/jQegHGqvPtFLN4972
         xD6h+pgjAtLt26Njkjgb68nD9Ntya/0WQJB2RGuGSWPiYXJUZ4H8BRl4mWHEj7/UQkSh
         NdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140047; x=1697744847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeZlT3fWkSsRBBC0KH8nwdyunCgP5eGN9Bq/f3gwBO4=;
        b=dSaZC6whJS1/7Gbv+9pngL4ccADWbJgW40bw4mJ1L3tm31+2K/rsf6y4C2MfAwTZFi
         L/VlcRlLVgm+QyG9vnrZ8iPItJdd6bZv6T0aE5AwLpICv8Kafacj8AbPgPtPjAWmg60F
         W4pM1j11UFpc0gE9+4DqLNuygjBzk8uKVN0ATSLTsGNCyVCEYBy+qwdzNgmry7JdfDTf
         7KW6JJFbv5HF7PDUlZEi6S0l5sPAmhjtAhVjk8dUFpEbnG47FZr3sZMIc0r//JKLjWmF
         MIfKBwDhyyvhL2eQE5BcAdndMjrwPR+P2GG0dLVzi9ouf3XXjSI9WvHzayv0Iu4xBT97
         CcUw==
X-Gm-Message-State: AOJu0Yw1/8jPiyb8OfZ9HGkzIieq6c/fLOq9+ONjLFPLxrEAFzJBhfFx
        7TW+XIhElLY9QaZ9cq+b61CDwrIqMv0/Pg==
X-Google-Smtp-Source: AGHT+IHn7mDbO0S9A1+0b66S1qg4vsjED53qQ+O/oQTsPg5mse541WjW5llcVGB1QOru72YgI0Y3oA==
X-Received: by 2002:a6b:f30b:0:b0:794:e015:585e with SMTP id m11-20020a6bf30b000000b00794e015585emr27649805ioh.21.1697140047466;
        Thu, 12 Oct 2023 12:47:27 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 06/10] dyndbg: add site_*() macros to avoid using _ddebug.site
Date:   Thu, 12 Oct 2023 13:47:07 -0600
Message-ID: <20231012194711.3288031-7-jim.cromie@gmail.com>
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

