Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB97C772F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442626AbjJLTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442416AbjJLTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEE1D7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso53624839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140044; x=1697744844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=071vttQwsRtHTk9tdWp1lQy+KTSRjIxShniNeq+GU3Y=;
        b=dEdQySNxeH6BRAk/+ev1J5ZuaWr49h7kURh6eKxxY7YH6HS+yEJywgZEK3u0evpHlg
         N9P8zFw92jppvQm0JUE3rlN8BBUAmLwsmgCCy7RuzYFl+tPejRqqUzP4O5gbEi7eQUl6
         8o4bp7U5uweqtv38huuAx67Tetxpwy4IhPJ0lgvULP+drbs1YmM7fr5WKljZiww8x75W
         B0hMrE+iKrI/Edu3lhrANGMO9uyhCCrmhUC54l8tusu19oAajZRQLsV0ig7WYN01TYeG
         NAdSH7IJlRP0m02GiuMIeum/i77kMJ3GdzItVi+lyMFDafzL/ztCzdajMuI2JEjOp+Dn
         9AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140044; x=1697744844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=071vttQwsRtHTk9tdWp1lQy+KTSRjIxShniNeq+GU3Y=;
        b=D+0gjpSYSUbEa9lbhkVpPG8Q2Cy5RfvudYqPvLcmby7/L202npc6k7KF5M+1lJ3kqI
         Sz9mzo4avexZ8BRceR9y7dto07nly3n1II3NxP7o7JQi7YcBNbpYtHgt5h9Lm0B/cSYZ
         9pDDu68+z/AqGp2w20hKiHxrXwbqafJPcubSKeyTktN5H0V6+LmnID3Yp2fzu7oFQNxw
         5nOrdYAtwuX5q7lsa8eD2Nt75ObxoaUlo602/JPF1VOhaDPEFj/nXkRJOG5s+yAsIly3
         A8Kd6ATKwsluvZ09fSxME91133Ch+J/DrVmfesIZ37K67VEjwatqeL3S0528kxazvejG
         Xn7w==
X-Gm-Message-State: AOJu0YycA77ZVLsjPwqvFRVc+bbtA76Rg4FaUnOt2Eay/0pZ3ZbLGKFm
        bG675rXvqAtedqPkahOmeFiQbYU4YKH9Tg==
X-Google-Smtp-Source: AGHT+IHZHagMWy2HPI0YrF34ye0IkVkYy10h1jWIvdho+KQVHFHRQjT4ByRa26XBH6udfT+GuQvITg==
X-Received: by 2002:a5e:8f4d:0:b0:791:2db5:c779 with SMTP id x13-20020a5e8f4d000000b007912db5c779mr31016076iop.10.1697140044235;
        Thu, 12 Oct 2023 12:47:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 03/10] dyndbg: add 2nd cursor pair to init-fn
Date:   Thu, 12 Oct 2023 13:47:04 -0600
Message-ID: <20231012194711.3288031-4-jim.cromie@gmail.com>
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

In dynamic_debug_init(), add 2nd cursor pair to walk the
__dyndbg_sites section in parallel with the __dyndbg section.

This avoids using the _ddebug.site pointer during initialization,
which is a 1st step towards dropping the member entirely, and reducing
the struct size and section footprint.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0ad9f1bc00f0..51af6a75ae92 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1501,6 +1501,7 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
+	struct _ddebug_site *site, *site_mod_start;
 	struct _ddebug *iter, *iter_mod_start;
 	int ret, i, mod_sites, mod_ct;
 	const char *modname;
@@ -1508,9 +1509,11 @@ static int __init dynamic_debug_init(void)
 
 	struct _ddebug_info di = {
 		.descs = __start___dyndbg,
+		.sites = __start___dyndbg_sites,
 		.classes = __start___dyndbg_classes,
 		.class_users = __start___dyndbg_class_users,
 		.num_descs = __stop___dyndbg - __start___dyndbg,
+		.num_sites = __stop___dyndbg_sites - __start___dyndbg_sites,
 		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
 		.num_class_users = __stop___dyndbg_class_users - __start___dyndbg_class_users,
 	};
@@ -1533,16 +1536,19 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 
+	site = site_mod_start = di.sites;
 	iter = iter_mod_start = __start___dyndbg;
 	modname = desc_modname(iter);
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
 
 		if (strcmp(modname, desc_modname(iter))) {
 			mod_ct++;
 			di.num_descs = mod_sites;
+			di.num_sites = mod_sites;
 			di.descs = iter_mod_start;
+			di.sites = site_mod_start;
 			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
@@ -1550,10 +1556,13 @@ static int __init dynamic_debug_init(void)
 			mod_sites = 0;
 			modname = desc_modname(iter);
 			iter_mod_start = iter;
+			site_mod_start = site;
 		}
 	}
 	di.num_descs = mod_sites;
+	di.num_sites = mod_sites;
 	di.descs = iter_mod_start;
+	di.sites = site_mod_start;
 	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
-- 
2.41.0

