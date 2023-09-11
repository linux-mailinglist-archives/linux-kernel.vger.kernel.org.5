Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CE79C1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjILBqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbjILBqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:46:17 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81613AF32;
        Mon, 11 Sep 2023 16:43:26 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7a52a1e2a59so2013163241.0;
        Mon, 11 Sep 2023 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694475748; x=1695080548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSfRKZal5I08Kg2LNxyAmDMoxHoLrERFX8CpvZDeNLU=;
        b=XgQUY/RNWE49Z60zqq3GAPCesZYDluxwFb94RLvtFS1iVkLteMtHBjqhkPJ4bceDGW
         FCJqUnWXAbmM7upMTRIL/V6xvc3fcpSTn6pbP3E3Ja5e4O6y7GL5Ssril+Fo7ghw53eM
         lwkQLIa+1cwQWqLKicc96o6eIB4uqIFi0Tm07Hf7nUlOvVAvq9bkyRxmu3t6FzV2K+sG
         6MNpaYknP/qtpNIai104FB58/n3MOQ5kp+jSqkde19iRQzmNAT13yjcLyeqmbThC137A
         sgefFwpNJWzA0TWkZjqHAuIOVI/eXuOFb7MlXc2XSyrtM6HTgY8OO7qctiyMbjJOx82a
         zDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475748; x=1695080548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSfRKZal5I08Kg2LNxyAmDMoxHoLrERFX8CpvZDeNLU=;
        b=ueOkPwOabGuN1kqXAZDYkZIoxFtKfpC1ZGUsMDk4ag00l9hLWryzqw94AeaYkvQCyN
         vVJNN0J5O4sgoJZFz4hJQdGuMKr6hYZaf1jAkThB8Usxw26MRBjjzEuaJo71zuGsGbCn
         80seOdeeDTHWcWays6WIhBq//IDLn6xr/7wVzEg7k6zFaoZVW2OOgdXbI7XDqKSVTpwC
         +JsQ35jJz4uFerLfTdBWrD3ZzQtx5OxTpSmEwajA6Ulo8YQfLd+DjruDfI4TTg5pHaEN
         TG/VjPrRh8EtGGcwAOrL2pLVF+hLYZKzwjOg/eo/qnTzQiDEmmPxjMgdF6Rkm/aDgFBv
         Hrpg==
X-Gm-Message-State: AOJu0Yw7vpXeA2KJSTD/E18AHTk9SlJIx0K6sufIeU4kDFQYU8D7AQsU
        qZGeGImlwMXxg70Bwd7g52kKmzYd19lTSA==
X-Google-Smtp-Source: AGHT+IFcDet/yMw0w72Vp9INEsacivj8gjJhEwzdN7FdFH2NxXvnk+9hlDDkDfO5YLzJ/X6RaRGOww==
X-Received: by 2002:a05:6602:2be1:b0:795:196c:a074 with SMTP id d1-20020a0566022be100b00795196ca074mr12359921ioy.3.1694473738930;
        Mon, 11 Sep 2023 16:08:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:58 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 14/22] dyndbg: refactor ddebug_classparam_clamp_input
Date:   Mon, 11 Sep 2023 17:08:30 -0600
Message-ID: <20230911230838.14461-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
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

Extract input validation code, from param_set_dyndbg_module_classes()
(the sys-node >handler) to new: ddebug_classparam_clamp_input(kp),
call it from former.  It takes kernel-param arg, so it can complain
about "foo: bad input".

Reuse ddparam_clamp_input(kp) in ddebug_sync_classbits(),
to validate inputs from parent's params, just like our own.
To support that reuse, alter ddebug_sync_classbits() and caller to
pass kp instead of kp->arg.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 66 ++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 851e7f9de085..90e36fea5635 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -656,6 +656,30 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
 
+static void ddebug_class_param_clamp_input(unsigned long *inrep, const struct kernel_param *kp)
+{
+	const struct ddebug_class_param *dcp = kp->arg;
+	const struct ddebug_class_map *map = dcp->map;
+
+	switch (map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		/* expect bits. mask and warn if too many */
+		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
+			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
+			*inrep &= CLASSMAP_BITMASK(map->length);
+		}
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		/* input is bitpos, of highest verbosity to be enabled */
+		if (*inrep > map->length) {
+			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+				KP_NAME(kp), *inrep, map->length);
+			*inrep = map->length;
+		}
+		break;
+	}
+}
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *modnm)
@@ -674,26 +698,15 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		pr_err("expecting numeric input, not: %s > %s\n", instr, KP_NAME(kp));
 		return -EINVAL;
 	}
+	ddebug_class_param_clamp_input(&inrep, kp);
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		/* expect bits. mask and warn if too many */
-		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
-				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
-			inrep &= CLASSMAP_BITMASK(map->length);
-		}
 		v2pr_info("bits:0x%lx > %s.%s\n", inrep, modnm ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, modnm);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* input is bitpos, of highest verbosity to be enabled */
-		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
-				KP_NAME(kp), inrep, map->length);
-			inrep = map->length;
-		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
 		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
@@ -1160,16 +1173,27 @@ static const char * const ddebug_classmap_typenames[] = {
 		  ddebug_classmap_typenames[_cm->map_type]);		\
 	})
 
-static void ddebug_sync_classbits(const struct ddebug_class_param *dcp, const char *modname)
+static void ddebug_sync_classbits(const struct kernel_param *kp, const char *modname)
 {
-	/* clamp initial bitvec, mask off hi-bits */
-	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
-		*dcp->bits &= CLASSMAP_BITMASK(dcp->map->length);
-		v2pr_info("preset classbits: %lx\n", *dcp->bits);
+	struct ddebug_class_param *dcp = kp->arg;
+	unsigned long new_bits;
+
+	ddebug_class_param_clamp_input(dcp->bits, kp);
+
+	switch (dcp->map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		v2pr_info("%s: classbits: 0x%lx\n", KP_NAME(kp), *dcp->bits);
+		ddebug_apply_class_bitmap(dcp, dcp->bits, 0UL, modname);
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		new_bits = CLASSMAP_BITMASK(*dcp->lvl);
+		v2pr_info("%s: lvl:%ld bits:0x%lx\n", KP_NAME(kp), *dcp->lvl, new_bits);
+		ddebug_apply_class_bitmap(dcp, &new_bits, 0UL, modname);
+		break;
+	default:
+		pr_err("bad map type %d\n", dcp->map->map_type);
+		return;
 	}
-	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) class-param */
-	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
-	ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
 }
 
 static void ddebug_match_apply_kparam(const struct kernel_param *kp,
@@ -1186,7 +1210,7 @@ static void ddebug_match_apply_kparam(const struct kernel_param *kp,
 	if (map == dcp->map) {
 		v2pr_info("found kp:%s =0x%lx", kp->name, *dcp->bits);
 		vpr_cm_info(map, "mapped to:");
-		ddebug_sync_classbits(dcp, modnm);
+		ddebug_sync_classbits(kp, modnm);
 	}
 }
 
-- 
2.41.0

