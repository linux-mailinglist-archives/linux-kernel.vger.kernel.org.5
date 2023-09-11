Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A279C215
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjILCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjILCAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:00:13 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA051018BE;
        Mon, 11 Sep 2023 16:37:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-59205f26e47so47963397b3.2;
        Mon, 11 Sep 2023 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694475414; x=1695080214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxV5EwVeeWXpJX0Hrevj96jd4dTd0GlqOcLeKugsmAo=;
        b=d7JHKPl3cpptRvP4X2nMFPNsAE0q85jy8pDy0/BQvofrlf8jbt4mlxqCdN+5qa3FFj
         oF9MDflDb8lYrelq+mMcGCmP5Lto0h9NPEIsPcOQIFSJUEPEiYjLBDD3TchlqYISwRIc
         skMiQc1k9zzXVwdzTCzwdPz069Y5dkes9nn5t6hANFrnsDfWpFYLb3mE93F1d1a9BjE0
         UcfKIZnLDmqsMHuDFGYyNWjxV2G3vDVpFokrLfLki2tun8HgNwIHPiJXDImAtlnonIy5
         t7uN8uqw9GDZkaLIUlVYHHlyPjy2JceQ56/F4zOvGrsrBlxTUqSDPvoR3SBLSIGF9a2B
         c2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475414; x=1695080214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxV5EwVeeWXpJX0Hrevj96jd4dTd0GlqOcLeKugsmAo=;
        b=EdEJUj3c/bp5VB8nAfbuDqJwF9AOuboIVPYrbaJ9YCP3R7mtcaTDZCGWGsYle5nfBy
         lDB79X5hiKiZ1e0ZtmVNOmlirKotnIKPU0e1WcEmtz0QRs95ZKK2Zhp6/iIqV6H3zUkd
         eKS9XT4hjoSzp1dwhqfsKdkBqCO66uHis1wvUoQ6QPTTeYKDKpn5HF86YTCs2tI3wcLP
         7FQYfnzTdFRmnydMCcsSjM1ROnKqCcgWKSvSE3iihBIv18vj3ns/nXsTMLP9RzEeAgGT
         nZjq26fxaP1qJCqHluAvgJ9MAsU6W1pTgzO/DJWcuA7lSLfi9u9Z2ABIW//6WSHYEEbi
         JlYw==
X-Gm-Message-State: AOJu0YyeobI1X2jDxAlw1jw8dtUHXJk+SV6p62bx8MnmwiDZxu514B/E
        oLpumsR5LxdEcja8wu5la8yIpBO3Ntjffw==
X-Google-Smtp-Source: AGHT+IGToB+JhZTwISt0CgVORoAeQuEFbPe5m0BPaNkuKCYxWUyirqBpKKg2RS9ogJTYNrxKH1TaXw==
X-Received: by 2002:a05:6602:3352:b0:787:8fc:75d8 with SMTP id c18-20020a056602335200b0078708fc75d8mr13398981ioz.9.1694473743182;
        Mon, 11 Sep 2023 16:09:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 17/22] dyndbg-doc: add classmap info to howto
Date:   Mon, 11 Sep 2023 17:08:33 -0600
Message-ID: <20230911230838.14461-18-jim.cromie@gmail.com>
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

Add some basic info on classmap usage and api

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5- adjustments per Randy Dunlap, me
---
 .../admin-guide/dynamic-debug-howto.rst       | 60 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0b3d39c610d9..4ad7d184ed9f 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -225,7 +225,6 @@ the ``p`` flag has meaning, other flags are ignored.
 Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
 To clear all flags at once, use ``=_`` or ``-fslmpt``.
 
-
 Debug messages during Boot Process
 ==================================
 
@@ -375,3 +374,62 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+Dynamic Debug classmaps
+=======================
+
+Dyndbg allows selection/grouping of *prdbg* callsites using structural
+info: module, file, function, line.  Classes allow authors to add
+their own domain-oriented groupings using class-names.  Classes span
+the kernel, so DRM can define DRM_UT_<*> classes, and helpers &
+drivers can use those definitions.
+
+  # enable classes individually
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+The "class FOO" syntax protects class'd prdbgs from generic overwrite::
+
+  # IOW this doesn't wipe any DRM.debug settings
+  :#> ddcmd -p
+
+To support the DRM.debug parameter, DYNDBG_CLASSMAP_PARAM* updates all
+classes in a classmap, mapping param-bits 0..N onto the classes:
+DRM_UT_<*> for the DRM use-case.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNDBG_CLASSMAP_DEFINE - modules use this to create classmaps, naming
+each of the classes (stringified enum-symbols: "DRM_UT_<*>"), and
+type, and mapping the class-names to consecutive _class_ids.
+
+By doing so, modules tell dyndbg that they are have prdbgs with those
+class_ids, and they authorize dyndbg to accept "class FOO" for modules
+which declare that classname with the DEFINE macro.
+
+There are 2 types of classmaps:
+
+ DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like DRM.debug
+ DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNDBG_CLASSMAP_PARAM - refers to a DEFINEd classmap, exposing the set
+of defined classes to manipulation as a group.  This interface
+enforces the relatedness of classes of DD_CLASS_TYPE_LEVEL_NUM typed
+classmaps; all classes are independent in the >control parser itself.
+
+DYNDBG_CLASSMAP_USE - drm drivers use the CLASSMAP that drm DEFINEs.
+This shares the classmap definition, authorizes coordinated changes
+amongst the CLASSMAP DEFINEr and multiple USErs, and tells dyndbg
+how to initialize the user's prdbgs at modprobe.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones (__pr_debug_cls(id,fmt..)).  This won't be reflected in
+the PARAM readback value, but the pr_debug callsites can be toggled
+into agreement with the param.
-- 
2.41.0

