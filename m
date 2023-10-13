Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD497C9103
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjJMWt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjJMWta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:49:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3046D5F;
        Fri, 13 Oct 2023 15:48:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-351437112c1so9977585ab.3;
        Fri, 13 Oct 2023 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237332; x=1697842132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt5GYS9mXBsgXWCKjkvZOfiO8j43yK6Z0bFknFJi+ls=;
        b=nPToxU7g0WnF/lNbFR+RqdGtrHkuqhrkqtR3NUqdnBh8coJxuNgDr1L+IiIpbblJxM
         gbwimK+ElTXtNw3uJjQB3YX7wD1YHKNVoUCJJuoAtpbtmXUkJTgmOXXvxLE4MEt9Lc+Z
         XhylbrjtX4g492fdFa/NYazE30Lj6JqmDJAr7HBNjDhHfCuqMt2VJV4qWgIUJANY/c7f
         6w5bfyzoIUIwr/CG5UR+XOeUUWAxh71+PWfctFij0qhxqSNap5Hkjki77RVWa8Fgclo5
         jaab6Ecgpm9T7ygFo53PbLoPQjSWcfjcdVcVy7G1qUSf5Ch58Gxh3ikj/ySoH+NzxpJl
         OruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237332; x=1697842132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt5GYS9mXBsgXWCKjkvZOfiO8j43yK6Z0bFknFJi+ls=;
        b=fJwc/swxPmgtGat1wP3AAA4Y/ltkxAAK9zCLB5wh2FoUUvdjGsw2/SVAOfeQW82HKq
         8+v9NCoKO9KTDFXugaSRekNmCCTnuHryw3K0sK6vHrrbivgOROw5lyTLKf4GD6iQ7KVM
         XpUSlkeQLKoDTt8CkX/1ARaKW3uy+GwjwP3xveo2F/GQem9zk2yD69oHEmJVsLRSd23U
         1scfZSaUbJ8r/ALnNE4420Ocd0jyf5V7yg+W5yrmHMC6qT/v/WG2u5qHe9k/I1UQXkJM
         nc0ktxZkpv6Af5XhGx8jE8ve3pJEj5n3eJLesGDqULlExadXzIJ9MNTzvrjaZsGI9qPf
         /2cw==
X-Gm-Message-State: AOJu0YxkXDsIXxUhTXDNQ7ikTrP/bmK4C5FyTefFTlpo+Xf9yaaZqQiP
        OyTutVjQXaQzuwmXn2tgc++uyvFyF3vkag==
X-Google-Smtp-Source: AGHT+IGqQ1iwV3rhmpHdu75VZNFfcZihQtqNSLpY33tZ2e3fX8O3LgvYIt+m1LEyZYRdn0zTAq8rIA==
X-Received: by 2002:a92:cdac:0:b0:357:4a69:60d8 with SMTP id g12-20020a92cdac000000b003574a6960d8mr10470030ild.4.1697237331792;
        Fri, 13 Oct 2023 15:48:51 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:51 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 18/25] dyndbg-doc: add classmap info to howto
Date:   Fri, 13 Oct 2023 16:48:10 -0600
Message-ID: <20231013224818.3456409-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
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

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5- adjustments per Randy Dunlap, me
v7b- checkpatch fixes
---
 .../admin-guide/dynamic-debug-howto.rst       | 60 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0b3d39c610d9..028c2cb5b4c5 100644
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
+info: module, file, function, line.  Classmaps allow authors to add
+their own domain-oriented groupings using class-names.  Classmaps are
+exported, so they referencable from other modules.
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
+class_ids, and they authorize dyndbg to accept "class FOO" for the
+module defining that classname.
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
+DYNDBG_CLASSMAP_USE - drm drivers invoke this to ref the CLASSMAP that
+drm DEFINEs.  This shares the classmap definition, and authorizes
+dyndbg to apply changes to the user module's class'd pr_debugs.  It
+also tells dyndbg how to initialize the user's prdbgs at modprobe,
+based upon the current setting of the parent's controlling param.
+
+Modules or module-groups (drm & drivers) can define multiple
+classmaps, as long as they share the limited 0..62 per-module-group
+_class_id range, without overlap.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the pr_debug callsites can be toggled into agreement with the
+param.
-- 
2.41.0

