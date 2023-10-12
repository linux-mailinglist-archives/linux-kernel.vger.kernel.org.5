Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058DE7C7745
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442839AbjJLTtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442770AbjJLTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537BD63
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:42 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7a26fd82847so54099739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140122; x=1697744922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdFWb7R/lDvUnWmGrNZ1doFLmbR1Cvf7k7ETF/HiAfA=;
        b=IaEYe1nTZEaIpCA9se3MpoM+juo8R3nesta7QigkJ4JNvr0oS2k60IH5V9bvUBzagV
         lZGzqKAN93ujVxk0TCBAlk6Dcik8Np+YjRU5gZmbGo9T3KtRN6YzGYJl1KLGhuIhrwCN
         p6QRHMGcLwgRwxmQHSgerbD2mmXwXKys43rEpRkJ8ebLP50+/kuyjqB0IvAXnRRri4PU
         rbYL/5zInDGFX3Y2QfSxv9MAqIYpF/cjSC9Quz0VHCuWs4GZ0MaL26I6iqH5v5WZ0o0D
         dIKZ+LUQIV+XaTnKJDLWhe50jNgD/VeDHxq2lI5nzm2/lxhk9bEV/fNOnMwHScHKkVx1
         pnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140122; x=1697744922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdFWb7R/lDvUnWmGrNZ1doFLmbR1Cvf7k7ETF/HiAfA=;
        b=a/Dhv5FkQfrW3bH5IFRMjCQX+O3hlvy5/gMSBB115IR0dW5Zg9Wf4+lW42Xfb3YNfc
         a21FEIA0n9zoUdqdgAeA4RKSy/SPstl0qalE4h3AWSo5sIQADnKtw4KqoyyAXg1vOe89
         Je33rDggfWDUzv7PYM+5i+ZgKsYDHeGrYJanWb5qMjEYxgTMapbbfXVFa6ILd42oN0zl
         pXv2cxSSQ3IvDhXLQhw4K/MrieZr1guGuKpeTrbp29TKe1+QvdId7MZ32xzpMEWRdh/B
         lSRTXzJqJAWFZY/cgdoPoFvKWeVEDhPISiGEH6esNviTBOXF2m3tlbgdht5Ragt6HpMN
         m4Aw==
X-Gm-Message-State: AOJu0YwMgorF4tvZRdIEKGwSZXhcUmfObFWUTwVyvAtg/RK4pEvgt+hp
        AX0X/lY0BGigIT80dM2xE8Dir3kzHqtufA==
X-Google-Smtp-Source: AGHT+IHB8Dgmlza+u38qD643ri3DiUTOqK9L6CK0JVBufkfHlFy0t26xGOhQZRYBrjCa8x/2Wi/a0g==
X-Received: by 2002:a5d:9cd5:0:b0:79f:d4e6:5175 with SMTP id w21-20020a5d9cd5000000b0079fd4e65175mr28324749iow.16.1697140121898;
        Thu, 12 Oct 2023 12:48:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 05/10] dyndbg: avoid _ddebug.site in ddebug_condense_sites
Date:   Thu, 12 Oct 2023 13:48:29 -0600
Message-ID: <20231012194834.3288085-6-jim.cromie@gmail.com>
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

Modify the for-loop in ddebug_condense_sites() to walk thru both
vectors: descs, sites in parallel.

This requires a 2nd set of cursor variables (*_ds) that mark the
start-of-range in the sites vector for the intervals to be
dd_store_range()d.  So also rename the old cursors (*_dd) for better
consistency and readability.

This is a partial step.  It still uses the desc_*() macros to provide
the values, and the macros use the site pointer.  Next, we replace the
macros with site_*(), passing the *_ds vars.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3dc17922a1d1..563d373224ba 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1426,32 +1426,41 @@ static void dd_store_range(struct maple_tree *mt, const struct _ddebug *start,
 		v4pr_info("  ok %s at %lx\n", val, first);
 }
 
+
 static void ddebug_condense_sites(struct _ddebug_info *di)
 {
-	struct _ddebug *cur, *funcp, *filep, *modp;
+	struct _ddebug_site *cur_ds, *func_ds, *file_ds, *mod_ds;
+	struct _ddebug      *cur_dd, *func_dd, *file_dd, *mod_dd;
 	int i;
 
-	funcp = filep = modp = di->descs;
-	for_each_boxed_vector(di, descs, num_descs, i, cur) {
+	cur_dd = func_dd = file_dd = mod_dd = di->descs;
+	cur_ds = func_ds = file_ds = mod_ds = di->sites;
+	i = 0;
+	for (; i < di->num_descs; i++, cur_dd++, cur_ds++) {
+
+		BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
 
-		if (!strcmp(desc_function(cur), desc_function(funcp)))
+		if (!strcmp(desc_function(cur_dd), desc_function(func_dd)))
 			continue;
-		dd_store_range(&mt_funcs, funcp, cur, "func", desc_function(funcp));
-		funcp = cur;
+		dd_store_range(&mt_funcs, func_dd, cur_dd, "func", desc_function(func_dd));
+		func_dd = cur_dd;
+		func_ds = cur_ds;
 
-		if (!strcmp(desc_filename(cur), desc_filename(filep)))
+		if (!strcmp(desc_filename(cur_dd), desc_filename(file_dd)))
 			continue;
-		dd_store_range(&mt_files, filep, cur, "file", desc_filename(filep));
-		filep = cur;
+		dd_store_range(&mt_files, file_dd, cur_dd, "file", desc_filename(file_dd));
+		file_dd = cur_dd;
+		file_ds = cur_ds;
 
-		if (!strcmp(desc_modname(cur), desc_modname(modp)))
+		if (!strcmp(desc_modname(cur_dd), desc_modname(mod_dd)))
 			continue;
-		dd_store_range(&mt_mods, modp, cur, "mod", desc_modname(modp));
-		modp = cur;
+		dd_store_range(&mt_mods, mod_dd, cur_dd, "mod", desc_modname(mod_dd));
+		mod_dd = cur_dd;
+		mod_ds = cur_ds;
 	}
-	dd_store_range(&mt_funcs, funcp, cur, "func:", desc_function(funcp));
-	dd_store_range(&mt_files, filep, cur, "file:", desc_filename(filep));
-	dd_store_range(&mt_mods, modp, cur, "mod:", desc_modname(modp));
+	dd_store_range(&mt_funcs, func_dd, cur_dd, "func:", desc_function(func_dd));
+	dd_store_range(&mt_files, file_dd, cur_dd, "file:", desc_filename(file_dd));
+	dd_store_range(&mt_mods, mod_dd, cur_dd, "mod:", desc_modname(mod_dd));
 }
 
 /*
-- 
2.41.0

