Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0307C774C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442569AbjJLTts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442241AbjJLTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AEEA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:44 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a5a746e355so34119039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140123; x=1697744923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIhMRd3PEDx8wYJmsgE6KV38zHdcvoV+qxdam6F9QaA=;
        b=f10FnZJ6oT5AtiE5JmcGHWt/EkOOVPUZ+pea27CHhT2KSZ2VmVloRtsrdCXWw5gwXc
         GwnrVy5iZiCPzK+xzo9i/+1CdmXd35IunjqEeK+dTsgPWfPksQsj0w19HTFCW+vA623o
         BnDqCZfhnCFoDEMXiTrI4pe/Z2iOM/Hmy/wnOr/2elXDmNRl+6mynac5PUd/6hul08xi
         zPbu7E3pJTpkCZZOOGApAgso/PWAWIOOTT9aMLNYZgKfHH0ChtOSktOVEfa1YRdaOYMK
         YWoCUlQkNL4E9HDNlX2f1d66Z227crMPPQessRkFj5SFTx2kAEv7uSTYcmSVx5aFlkKZ
         bYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140123; x=1697744923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIhMRd3PEDx8wYJmsgE6KV38zHdcvoV+qxdam6F9QaA=;
        b=I6/yoIpjr5Y+zZ+B+j7Yzf6aJW/tahLc8UHrr5TPt1zuanOf9BXGOk29pV5JGEwGwr
         fHIaeaQqNNzbxDxeRXXTmwQCsqLJ0hs0qUjalhMXufFIT1vgV2gMhzGucI97uGO/vYVy
         u8+RGb63G1NgzeQ3jJHlgDRLNPCIvSa+KiJ+vlE6ZbVarCKX9hJyoq/RLxrBQ2RWuLGQ
         UUkwXEjVc0qUkuUEE3igr8B6FMtvZpAIigTB7osdDvGhDWLU6W7DzXk4fEeVW/n8CO0R
         vONzips6j6J6gX7OF1l5mK7Ax2Zy1MMczwieO0Y9TfOE4AZ/TRYvmxeK+92mGhmx5XHB
         r1Lw==
X-Gm-Message-State: AOJu0YwNIN+Sd+3k8v5iscFR8PTD/sRLQZWpowZSKw1ZTZViBjUZFTR8
        wYLEhhKInl4cFOLV1UW1XVxryUbaJxwb/Q==
X-Google-Smtp-Source: AGHT+IHqH6cUbDs8xrXZJT4gDhu6yQsXMA72pQaQVz1Yklqvjqho03n48wy4VfixJtREREl3H41tPA==
X-Received: by 2002:a05:6602:2014:b0:791:8f62:31ef with SMTP id y20-20020a056602201400b007918f6231efmr17972840iod.5.1697140123589;
        Thu, 12 Oct 2023 12:48:43 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:43 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 07/10] dyndbg: wire in __desc_*() functions
Date:   Thu, 12 Oct 2023 13:48:31 -0600
Message-ID: <20231012194834.3288085-8-jim.cromie@gmail.com>
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

change desc_*() macros to call __desc_*() functions, and #if 0 the
comparisons to the site->_* ref.  This makes the _ddebug.site pointer
unneccesary.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 48564625a37e..fb72a7b05b01 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -223,9 +223,9 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define desc_modname(d)		(d)->site->_modname
-#define desc_filename(d)	(d)->site->_filename
-#define desc_function(d)	(d)->site->_function
+#define desc_modname(d)		__desc_modname(d)
+#define desc_filename(d)	__desc_filename(d)
+#define desc_function(d)	__desc_function(d)
 /*
  * tmp accessors, they cheat and seek a match in builtins.  Obviously
  * this wont work for loaded modules, but doesnt work at all yet.
@@ -235,11 +235,11 @@ static const char * __desc_function(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_funcs;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_function(dp))
 		pr_err("mt-load func %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_function(dp));
-
+#endif
 	return ret;
 }
 
@@ -248,11 +248,11 @@ static const char * __desc_filename(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_files;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_filename(dp))
 		pr_err("mt-load file %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_filename(dp));
-
+#endif
 	return ret;
 }
 
@@ -261,11 +261,11 @@ static const char * __desc_modname(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_mods;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_modname(dp))
 		pr_err("mt-load mod %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_modname(dp));
-
+#endif
 	return ret;
 }
 
@@ -1441,7 +1441,7 @@ static void ddebug_condense_sites(struct _ddebug_info *di)
 	i = 0;
 	for (; i < di->num_descs; i++, cur_dd++, cur_ds++) {
 
-		BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
+		//BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
 
 		if (!strcmp(site_function(cur_ds), site_function(func_ds)))
 			continue;
-- 
2.41.0

