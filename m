Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF876BA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjHARDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjHARDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:03:04 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702A52103
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:03 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-348cd23610cso21272065ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909383; x=1691514183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpLKlPkPuDeZTaydF9hSSkY9Ellw/0x0sPYE01QQjK8=;
        b=dwZwdTx3LbTEUjrG7cqObNua7f/Y6UApTOfS71NoiM+4B3YWrCLr2w6QEvPLWhDQ82
         ok+QSNsMDSsGiu47UdPyWXPoOyDyTuozvp5e3kulaStWriPzuNLhXDZHiZFxvO2/uNzf
         KecRX12r2tzxow1wQSwHlyXAwcXrd6DN3vaOB288qxzuGWTJIPqGKCnh+kXjRo7+d7cl
         YJy/HTYGtvfXMJJMvEwmrwK6qExfYDLuiSpgauCDrQI+LNAysON/q5beCISdZTol7XVt
         x0NxJHLAetlZGoKrBTjXmCCJRX4bPGCjmOjSxGm744nOgpviFoHbdKlhLAbdxUCTC3fh
         6BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909383; x=1691514183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpLKlPkPuDeZTaydF9hSSkY9Ellw/0x0sPYE01QQjK8=;
        b=k6osrUGW2rEfCpR2amZYNPLYHR2GnzVT3SsY+dPniFfvLCSccIsCpznKIP596FkiZG
         tYMR2YMvTQ4SMBeHV+cUjxN70Xw3u15AQQqJ21Bl5evBdc1ySLWEWr5lr+hb3vwPnvtm
         d/Xi8F7DVqbhZacp/ZzM/SWG9uCHmDFREA8+Z60S2j9nf7QQh3Q7yUbp+doVVxXPsUjh
         n+4qyRShnwMLKSylgV0hl/2N4h5FKpvz956I0qYCImXtON9i9Xuq35QFIymAqeGV/u7/
         ufBTpSY9z9NbQaaXCwFB0mTQKxlmyhfGMKOSeeX7seAA7NBneUSp2axmuvjDLpSzJ4NC
         1lIg==
X-Gm-Message-State: ABy/qLbAGmOWTl24JyT0X3zJ4ePk8CFVZHIZ63mk6fSZqFoMXAWSOeJC
        ZDV2sAY8ETsfkmIDDmP+DvQ=
X-Google-Smtp-Source: APBJJlFnXDkFGfkVLtL6cxCofA5CYCbk4OYOGIz5bGjX04E7JRgdcDA1DzDAmsNmGGPAU1VpuideFQ==
X-Received: by 2002:a05:6e02:1aa3:b0:345:66f5:3404 with SMTP id l3-20020a056e021aa300b0034566f53404mr14132076ilv.0.1690909382631;
        Tue, 01 Aug 2023 10:03:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 00/22] fix DRM_USE_DYNAMIC_DEBUG regression
Date:   Tue,  1 Aug 2023 11:02:32 -0600
Message-ID: <20230801170255.163237-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Daniel, etal

This is V5, Im hoping to land this one.
 patchwork will probably call this set v3
 113361	fix DRM_USE_DYNAMIC_DEBUG regression - revs 1,2
 111652	DRM_USE_DYNAMIC_DEBUG regression - older, also 2 revs

It (patch 14 mainly):
 Fixes: aad0214f3026 ("dyndbg: add DECLARE_DYNDBG_CLASSMAP macro")
 Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
 Ref: commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")

It replaces DECLARE_DYNDBG_CLASSMAP macro with 2 new ones;
DYNDBG_CLASSMAP_DEFINE/_USE, and invokes them from drm.ko and drivers
respectively.  A new __dyndbg_class_users section contains each
driver's _USE; dyndbg scans it at driver-module load, finds drm.debug,
and applies it to the driver's class'd prdbgs.

The code it fixes went in here:
https://lore.kernel.org/lkml/Yy7%2F6oTBW2lqVSK1@kroah.com/

then Ref: effectively marked DRM_USE_DYNAMIC_DEBUG=y as broken

and https://lore.kernel.org/lkml/Y3XUrOGAV4I7bB3M@kroah.com/
GregKH opined:
This should go through the drm tree now.  The rest probably should also
go that way and not through my tree as well.

While most of this patchset's churn is still in lib/, DRM is the real
user for all this classmap stuff, and the real acceptance test is in
DRM CI.  Hopefully it won't fall over in BAT.

However, theres also a dyndbg patch to add -s flag, I havent seen it
lately, but it might have a nominal conflict.

I'll happily take reviews/Acks/tested-bys, grumpily breakage reports.
And some landing instructions, wind-speed, runway assignment, etc from the Tower.

theres also a few drive-by checkpatch tweaks.
13 fixes a warning that 14 gets about vmlinux.lds.h declared linker-symbols.


Jim Cromie (22):
  drm: use correct ccflags-y syntax
  test-dyndbg: fixup CLASSMAP usage error
  dyndbg: make ddebug_class_param union members same size
  dyndbg: replace classmap list with a vector
  dyndbg: ddebug_apply_class_bitmap - add module arg, select on it
  dyndbg: split param_set_dyndbg_classes to module/wrapper fns
  dyndbg: drop NUM_TYPE_ARRAY
  dyndbg: reduce verbose/debug clutter
  dyndbg: silence debugs with no-change updates
  dyndbg: tighten ddebug_class_name() 1st arg type
  dyndbg: tighten fn-sig of ddebug_apply_class_bitmap
  dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
  checkpatch: file-scoped extern special case for linker-symbol
  dyndbg-API: fix CONFIG_DRM_USE_DYNAMIC_DEBUG regression
  dyndbg: add for_each_boxed_vector
  dyndbg: refactor ddebug_classparam_clamp_input
  dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
  dyndbg-test: build it with just CONFIG_DYNAMIC_DEBUG_CORE
  drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
  drm-drivers: DRM_CLASSMAP_USE in 2nd batch of drivers, helpers
  dyndbg-doc: add classmap info to howto
  checkpatch: reword long-line warn about commit-msg

 .../admin-guide/dynamic-debug-howto.rst       |  64 ++-
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
 include/linux/dynamic_debug.h                 | 113 +++--
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  10 +-
 lib/Makefile                                  |   4 +-
 lib/dynamic_debug.c                           | 406 +++++++++++-------
 lib/test_dynamic_debug.c                      | 127 +++---
 lib/test_dynamic_debug_submod.c               |  10 +
 scripts/checkpatch.pl                         |  22 +-
 28 files changed, 550 insertions(+), 341 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c

-- 
2.41.0

