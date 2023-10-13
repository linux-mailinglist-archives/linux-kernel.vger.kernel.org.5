Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041347C9070
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjJMWsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:33 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284D3B7;
        Fri, 13 Oct 2023 15:48:31 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35135b79b6aso9492145ab.0;
        Fri, 13 Oct 2023 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237310; x=1697842110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mng0G0MZHQ5iG3ZlpwMZtpDxjZVpA+nf77+wmyN2nk=;
        b=W+GR8g43WaCcDYfUy141kNb+natipdKet0Xg2Zy72hhaE1iwmZ1mi3sVJL3TsLRVMO
         dqjCPlupxJmkH/Mw6mds5TMRgIiNWTt5cWaJHPsSWP+/9zYbR3uaXTAxdu85mQ5dFLZT
         MWIAO6OjeWJGibgImB6aAr634v/xzFg9EUjpHN0bRg+E2DnsTzl/vd4zDU9bkL3ZJmm1
         diDHHmzw32e/IiAk2PpwlccSWrJHEWGtfRIaxnsjlt26o3Bcxdg9Kb653HopsdUPsbF2
         0HHkvVvBabBxMKT3Bm23ZSslK+MTdakO75Mfbc3nvMkbYalmO64xfBzxzuIe7WieFkTr
         1e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237310; x=1697842110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mng0G0MZHQ5iG3ZlpwMZtpDxjZVpA+nf77+wmyN2nk=;
        b=w9gY5CmwHiF+PZf2bfXeJ48mnzmmWMvJgHp+DR+/vq+HHmMcBEayEWfg43QIn87nyt
         28nF6acgGw31Hd47OTeGbgeRWvag+/H/Bl9Wvt2MYa3gBT9CLSMEeDT9TStj1u6WCse/
         nGfQnWw/udWrh7WXOWXGcg2AYhtXFp45vs177dDnaxj3mkpujVse7F7Xn+vPrCMw4RGz
         5fgzMQ8r1ngsP/p+JTpL18yi1N6dhF9IqwsS9CyYNXAvluP0AyZbnUVpOqwhm5xeQXW2
         FVUk5B+0u1um+TWj079yFAgJdiJ/rOjrifQVTn0tyQ4ACv2L4fKIfXpqEyks5/LL+IQ5
         4f3A==
X-Gm-Message-State: AOJu0Yx+f9zK71y0yut38sMFRseYi/eSE6WeBbPgrEdivRYfigjoMlvp
        3pr5CKOIjk/Zn4Sf/KqWRfs2BsT1fCwviA==
X-Google-Smtp-Source: AGHT+IG+I25uvqNU5DZMw47ZwGEBEd5TljGGiNjhM3n4cZrTiK6lXr5EVFKspt/gyJ2MjEBfwcoK7w==
X-Received: by 2002:a05:6e02:b22:b0:357:5b51:ae6c with SMTP id e2-20020a056e020b2200b003575b51ae6cmr5877260ilu.6.1697237310091;
        Fri, 13 Oct 2023 15:48:30 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:29 -0700 (PDT)
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
Subject: [PATCH v7b 00/25] fix DRM_USE_DYNAMIC_DEBUG=y regression
Date:   Fri, 13 Oct 2023 16:47:52 -0600
Message-ID: <20231013224818.3456409-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
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

hi Jason, DRM-folk

(now with checkpatch fixes)

This patchest fixes the chicken-egg initialization problem in the 1st
version of ddebug-class-maps, that DRM-CI uncovered.

The root-problem was DECLARE_DYNDBG_CLASSMAP, which broke the K&R rule:
"define once, refer many".  In patch 14 it is replaced by:

 DYNDBG_CLASSMAP_DEFINE - define and export a struct ddebug_class_map
 DYNDBG_CLASSMAP_USE - ref the exported struct

test-dynamic-debug is also extended with a -submod.ko, in order to
recapitulate the drm & drivers initialization scenario.

They're on v6.6-rc5 now, and apply cleanly to drm-tip/drm-tip.

Ive been running recent revs on rc3+, on my desktop and laptop.

The final blocker was a missing __align(8) on the ddebug_class_user
record inserted by DYNDBG_CLASSMAP_USE.  This caused DRM=y (builtin
only) to have a corrupt record for drm_kms_helper (builtin dependent).
Curiously, a clang build did not exhibit this problem.

Heres a part of dmesg, for a DRM=y kernel, booted with
     dynamic_debug.verbose=3 drm.debug=0x10

[    0.466747] dyndbg: add-module: drm 406 sites
[    0.467569] dyndbg: classes[0]: module:drm base:0 len:10 type:DISJOINT_BITS
[    0.467743] dyndbg: module:drm attached 1 classes
[    0.468557] dyndbg: builtin class: module:drm base:0 len:10 type:DISJOINT_BITS
[    0.468742] dyndbg:  found kp:drm.debug =0x10
[    0.468743] dyndbg:   mapped to: module:drm base:0 len:10 type:DISJOINT_BITS
[    0.469742] dyndbg:   drm.debug: classbits: 0x10
[    0.470573] dyndbg: apply bitmap: 0x10 to: 0x0 for drm
[    0.470743] dyndbg: query 0: "class DRM_UT_ATOMIC +p" mod:drm
[    0.471743] dyndbg: split into words: "class" "DRM_UT_ATOMIC" "+p"
[    0.472743] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[    0.473679] dyndbg: parsed: func="" file="" module="drm" format="" lineno=0-0 class=DRM_UT_ATOMIC
[    0.473749] dyndbg: processed 1 queries, with 0 matches, 0 errs
[    0.474742] dyndbg: bit_4: 0 matches on class: DRM_UT_ATOMIC -> 0x10
[    0.475742] dyndbg: applied bitmap: 0x10 to: 0x0 for drm
[    0.476686] dyndbg: 406 debug prints in module drm
[    0.476743] dyndbg: add-module: drm_kms_helper 93 sites
[    0.477727] dyndbg: class_ref[0] drm_kms_helper -> drm module:drm base:0 len:10 type:DISJOINT_BITS
[    0.477743] dyndbg: builtin class: module:drm base:0 len:10 type:DISJOINT_BITS
[    0.478742] dyndbg:  found kp:drm.debug =0x10
[    0.478743] dyndbg:   mapped to: module:drm base:0 len:10 type:DISJOINT_BITS
[    0.479743] dyndbg:   drm.debug: classbits: 0x10
[    0.480592] dyndbg: apply bitmap: 0x10 to: 0x0 for drm_kms_helper
[    0.480743] dyndbg: query 0: "class DRM_UT_ATOMIC +p" mod:drm_kms_helper
[    0.481743] dyndbg: split into words: "class" "DRM_UT_ATOMIC" "+p"
[    0.482743] dyndbg: op='+' flags=0x1 maskp=0xffffffff
[    0.483743] dyndbg: parsed: func="" file="" module="drm_kms_helper" format="" lineno=0-0 class=DRM_UT_ATOMIC
[    0.484750] dyndbg: class-ref: drm_kms_helper.DRM_UT_ATOMIC  module:drm_kms_helper nd:93 nc:0 nu:1
[    0.485809] dyndbg: processed 1 queries, with 44 matches, 0 errs
[    0.486742] dyndbg: bit_4: 44 matches on class: DRM_UT_ATOMIC -> 0x10
[    0.487742] dyndbg: applied bitmap: 0x10 to: 0x0 for drm_kms_helper
[    0.488743] dyndbg: attach-client-module:  module:drm_kms_helper nd:93 nc:0 nu:1
[    0.489742] dyndbg:  93 debug prints in module drm_kms_helper

Widespread testing is appreciated.
I have scripts if anyone wants them.

I'll forward lkp-robot reports here when I get them.
Patches also at https://github.com/jimc/linux (dd-fix-7b)


Jim Cromie (25):
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: reword "class unknown," to "class:_UNKNOWN_"
  dyndbg: make ddebug_class_param union members same size
  dyndbg: replace classmap list with a vector
  dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
  dyndbg: split param_set_dyndbg_classes to module/wrapper fns
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg: silence debugs with no-change updates
  dyndbg: tighten ddebug_class_name() 1st arg type
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg: reduce verbose=3 messages in ddebug_add_module
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  dyndbg-API: fix CONFIG_DRM_USE_DYNAMIC_DEBUG regression
  dyndbg: add for_each_boxed_vector
  dyndbg: refactor ddebug_classparam_clamp_input
  dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
  dyndbg-doc: add classmap info to howto
  dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
  dyndbg: add _DPRINTK_FLAGS_INCL_LOOKUP
  dyndbg: refactor *dynamic_emit_prefix
  dyndbg: change WARN_ON to WARN_ON_ONCE
  drm: use correct ccflags-y spelling
  drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN

 .../admin-guide/dynamic-debug-howto.rst       |  60 ++-
 MAINTAINERS                                   |   2 +-
 drivers/gpu/drm/Kconfig                       |   3 +-
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +-
 drivers/gpu/drm/display/drm_dp_helper.c       |  12 +-
 drivers/gpu/drm/drm_crtc_helper.c             |  12 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +
 drivers/gpu/drm/drm_print.c                   |  35 +-
 drivers/gpu/drm/gud/gud_drv.c                 |   2 +
 drivers/gpu/drm/i915/i915_params.c            |  12 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |   2 +
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  12 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   2 +
 drivers/gpu/drm/radeon/radeon_drv.c           |   2 +
 drivers/gpu/drm/udl/udl_main.c                |   2 +
 drivers/gpu/drm/vkms/vkms_drv.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c           |   2 +
 include/asm-generic/vmlinux.lds.h             |   1 +
 include/drm/drm_print.h                       |  12 +-
 include/linux/dynamic_debug.h                 | 121 +++--
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  24 +-
 lib/Makefile                                  |   3 +
 lib/dynamic_debug.c                           | 460 +++++++++++-------
 lib/test_dynamic_debug.c                      | 131 ++---
 lib/test_dynamic_debug_submod.c               |  17 +
 27 files changed, 586 insertions(+), 365 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c

-- 
2.41.0

