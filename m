Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800777528E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbjGMQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjGMQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B2130DC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso3965045ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266221; x=1691858221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utQH+brkTHZoOvReum7R2ktr/sBK5CmFUpoSFYGWWyA=;
        b=Y2xNn+k95UAYxdC65PxUWdECMmWg5H8QO529F96NVSQI1Q7+c91cjOO556Pt+Y9yof
         viWj3m3Dfs6nbPP4m4imeWpZ9JTfrFYPN9jeuIA6WTdaecTh1YxKr23DECzd0TNp6LwG
         Oq7p3S/fpdfp+fVFWFdQ9W+pBcnCnUS1j9fmqLVHwhSYTm6LXo7vDk9oc5IyTDUiIFwC
         l50n5velfskvdm4X9QunLF/RUHqO6OF/JbxKRHU09cddqyJsZnqV8fTmcsFgAr/qpDlq
         ss+z/Be0Chqu3stERxukuBWHm9hP1MR41hEdVb3LCcYVmexIExefuy5RlEtFEV00/Kh6
         Pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266221; x=1691858221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utQH+brkTHZoOvReum7R2ktr/sBK5CmFUpoSFYGWWyA=;
        b=NNd+SVnuWWwofoLmUtc9m8kd9RDvCUB6LHyQK67bCeDIMZIwsN181hXIuXJIlgvAQ+
         eWfX4uBmaisGuqNzcjRLjBEg/Klua3/s6C3u9pePS/En7V+na2KQGfdBVQesVrr+NR3A
         u2IjuaJz2mka2txQ54GmSFiRqlaYfTtpoxAuu2iklYLr0xrpMa4PBAiP0mv5RVf/bC9W
         bB6+lyPiGBoha5r+mYlOJqA8kLgg1dDnKj73hXZngzotDaVdaTf1N8yLZa16vy9yN5tZ
         3UirKpZCmMdcUnFBI1NgU2j4Dz10pd+c3TCbifpSSjLVZFj1tb7kwstM7AOxr1hA65k5
         luxQ==
X-Gm-Message-State: ABy/qLZnZFn3mjx27YN0Xl0rVfCLjbAnqEGit73e7+8JxHX39FOZopyX
        q9APQ0X31+kPnpAyUXl66bM=
X-Google-Smtp-Source: APBJJlGvMp/On2vUPbobjjmmD6JVqAuT+Lq07GsyfsccBEoQcumR22KgWqK8JhRxe0MMtFZFHc250A==
X-Received: by 2002:a92:cc43:0:b0:346:e96:7cba with SMTP id t3-20020a92cc43000000b003460e967cbamr2180423ilq.27.1689266220748;
        Thu, 13 Jul 2023 09:37:00 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:00 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 15/21] dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
Date:   Thu, 13 Jul 2023 10:36:20 -0600
Message-ID: <20230713163626.31338-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move macro from test-dynamic-debug.c into header, and refine it.

Distinguish the 2 use cases of DYNDBG_CLASSMAP_PARAM*

1.DYNDBG_CLASSMAP_PARAM_REF
    for DRM, to pass in extern __drm_debug by name.
    dyndbg keeps bits in it, so drm can still use it as before/remaining.

2.DYNDBG_CLASSMAP_PARAM
    new user (test_dynamic_debug) doesnt need to share state,
    decls,inits a static long unsigned int to store the bitvec.

__DYNDBG_CLASSMAP_PARAM
   bottom layer - allocate,init a ddebug-class-param, module-param-cb.

1. doesnt initialize bits properly.
   macro seems to lose type of previously decl'd extern,
   then whines about type mistmatch
   punt now - following commit trys to fix it, draws warning.

2. init seems to work
   maybe masked by sync-bits
   not validated

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c   |  8 ++-----
 include/drm/drm_print.h       |  6 ++++--
 include/linux/dynamic_debug.h | 39 +++++++++++++++++++++++++++++++++--
 lib/test_dynamic_debug.c      | 22 +++-----------------
 4 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index dabcfa0dd279..8f4b609353a5 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -69,12 +69,8 @@ DRM_CLASSMAP_DEFINE(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,
 		    "DRM_UT_DP",
 		    "DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
-	.bits = &__drm_debug,
-	.flags = "p",
-	.map = &drm_debug_classes,
-};
-module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+DRM_CLASSMAP_PARAM_REF(debug, __drm_debug, drm_debug_classes, p);
+
 #endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 706afc97c79c..94d4f5500030 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -322,11 +322,13 @@ enum drm_debug_category {
 };
 
 #ifdef CONFIG_DRM_USE_DYNAMIC_DEBUG
-#define DRM_CLASSMAP_DEFINE(...) DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
-#define DRM_CLASSMAP_USE(name)   DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_DEFINE(...)	DYNDBG_CLASSMAP_DEFINE(__VA_ARGS__)
+#define DRM_CLASSMAP_USE(name)		DYNDBG_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)	DYNDBG_CLASSMAP_PARAM_REF(__VA_ARGS__)
 #else
 #define DRM_CLASSMAP_DEFINE(...)
 #define DRM_CLASSMAP_USE(name)
+#define DRM_CLASSMAP_PARAM_REF(...)
 #endif
 
 static inline bool drm_debug_enabled_raw(enum drm_debug_category category)
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2604fda3abe3..95a6b3882b76 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -90,7 +90,7 @@ struct ddebug_class_map {
  * module, and to validate inputs to DD_CLASS_TYPE_*_NAMES typed params.
  */
 #define DYNDBG_CLASSMAP_DEFINE(_var, _maptype, _base, ...)		\
-	const char *_var##_classnames[] = { __VA_ARGS__ };		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	struct ddebug_class_map __aligned(8) __used			\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
@@ -118,7 +118,7 @@ struct ddebug_class_user {
 	DYNDBG_CLASSMAP_USE_(_var, __UNIQUE_ID(ddebug_class_user))
 #define DYNDBG_CLASSMAP_USE_(_var, _uname)				\
 	extern struct ddebug_class_map _var;				\
-	struct ddebug_class_user __used					\
+	static struct ddebug_class_user __used				\
 	__section("__dyndbg_class_users") _uname = {			\
 		.user_mod_name = KBUILD_MODNAME,			\
 		.map = &_var,						\
@@ -143,6 +143,41 @@ struct ddebug_class_param {
 	const struct ddebug_class_map *map;
 };
 
+/**
+ * DYNDBG_CLASSMAP_PARAM - wrap a dyndbg-classmap with a controlling sys-param
+ * @_name  sysfs node name
+ * @_var   name of the struct classmap var defining the controlled classes
+ * @_flags flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classes defined by the
+ * classmap.  Keeps bits in a private/static
+ */
+#define DYNDBG_CLASSMAP_PARAM(_name, _var, _flags)			\
+	static unsigned long _name##_bvec;				\
+	__DYNDBG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)
+
+/**
+ * DYNDBG_CLASSMAP_PARAM_REF - wrap a dyndbg-classmap with a controlling sys-param
+ * @_name  sysfs node name
+ * @_bits  name of the module's unsigned long bit-vector, ex: __drm_debug
+ * @_var   name of the struct classmap var defining the controlled classes
+ * @_flags flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classmap, keeping bitvec in user @_bits.
+ * This lets drm use __drm_debug elsewhere too.
+ */
+#define DYNDBG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)		\
+	__DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
+
+#define __DYNDBG_CLASSMAP_PARAM(_name, _bits, _var, _flags)		\
+	static struct ddebug_class_param _name##_##_flags = {		\
+		.bits = &_bits,						\
+		.flags = #_flags,					\
+		.map = &_var,						\
+	};								\
+	module_param_cb(_name, &param_ops_dyndbg_classes,		\
+			&_name##_##_flags, 0600)
+
 /*
  * pr_debug() and friends are globally enabled or modules have selectively
  * enabled them.
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 23967071b60f..df41963d9faf 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -35,22 +35,6 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
 
 #define CLASSMAP_BITMASK(width, base) (((1UL << (width)) - 1) << base)
 
-/* sysfs param wrapper, proto-API */
-#define DYNDBG_CLASSMAP_PARAM_(_model, _flags, _init)			\
-	static unsigned long bits_##_model = _init;			\
-	static struct ddebug_class_param _flags##_##_model = {		\
-		.bits = &bits_##_model,					\
-		.flags = #_flags,					\
-		.map = &map_##_model,					\
-	};								\
-	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
-			&_flags##_##_model, 0600)
-#ifdef DEBUG
-#define DYNDBG_CLASSMAP_PARAM(_model, _flags)  DYNDBG_CLASSMAP_PARAM_(_model, _flags, ~0)
-#else
-#define DYNDBG_CLASSMAP_PARAM(_model, _flags)  DYNDBG_CLASSMAP_PARAM_(_model, _flags, 0)
-#endif
-
 /*
  * Demonstrate/test all 4 class-typed classmaps with a sys-param.
  *
@@ -113,11 +97,11 @@ DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 		       V0, "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
 
 /*
- * now add the sysfs-params
+ * now add the sysfs-params: name, classmap, flags-toggled
  */
 
-DYNDBG_CLASSMAP_PARAM(disjoint_bits, p);
-DYNDBG_CLASSMAP_PARAM(level_num, p);
+DYNDBG_CLASSMAP_PARAM(p_disjoint_bits,	map_disjoint_bits, p);
+DYNDBG_CLASSMAP_PARAM(p_level_num,	map_level_num, p);
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
 
-- 
2.41.0

