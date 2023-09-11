Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591CE79C372
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjILC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241103AbjILC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:58:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B1B1242BF;
        Mon, 11 Sep 2023 16:38:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c0b40a13ebso2563975a34.0;
        Mon, 11 Sep 2023 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694475469; x=1695080269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QPvsUCuesDbdqzdhDuBEQMp4BSGGOAe53BRO5DTLhU=;
        b=IFAKVoYtPOOALsodzgYoPEOGc5zCd3Lyw6q2P0Vb1g+56QJN2dnMDYRxgATLYF0icq
         OEr2yRaJ9rAaJyjGv1LgNQ3y0GgmgiWH6bz4w3YvAdFo6F12JzuFV/+snDgbWOWTp9It
         lU3XJymUxnivWzc64vl399Zz5G7I/TLxCcMtfjn0GRWaRTTaSl1QERyl9zy1xYfSLRAu
         zBApGx9jt7hjNoRQSKhjq2nZypf16otcxIFUBgp1QfbdkkSY96l/3WBRLNIlBghDjihh
         IKn2olbp3WCSdUGihERiUU5CQFpX9s0voPW52UXm50X8j0kYQuU4b/9WRE445SwT+wnL
         ExIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475469; x=1695080269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QPvsUCuesDbdqzdhDuBEQMp4BSGGOAe53BRO5DTLhU=;
        b=tafatf2W8ldPuAzuLivB1PuxOIqXoDaj7VRKFt6PNg5It7M0y4/qEdc3XNrirRcqRU
         jUUoAK/ha95HMmT1PwQJyqWCFT1vIh6jnvwuFZ/R4LLHpaD/Up+FLEfLZn265SDFvBkU
         UtrYxoKdFQwhKPpBhvwqszYQzdQbu4xoyAeDJEwQ3rsSkCgw8v6Fui0dksM1F0zNQ3sK
         1vzG3JcLyZs8bNdvB5M+CTLU8ycG0w+tOna/kv4ZUON7A16OX4JWGdpFsEUM3mOUDDcb
         HwUOpATIGkUPP/m3si5cOOCoOw3hzSyRCvOWs/XmcuX+JLUgPHmQOE02MKuuAzlmeTap
         oo+Q==
X-Gm-Message-State: AOJu0YwJrTdWaVAz2mM1ojxVqkGyB9SxCeJQHqvmlTJ4AzlmY0Ig9wST
        P6RdbFNLPg2Z3/yZ1R+20Z5KLfE5L6sS3w==
X-Google-Smtp-Source: AGHT+IFUPQoRpMf1cn/UePxbHse2ZRULTpQVv0MhBdRfgttJDXNSROjhhVjOL6jgLU7aV8tcFnbiDQ==
X-Received: by 2002:a5d:9d9a:0:b0:792:7c46:3dec with SMTP id ay26-20020a5d9d9a000000b007927c463decmr1259726iob.4.1694473723879;
        Mon, 11 Sep 2023 16:08:43 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:43 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 00/22] fix DRM_USE_DYNAMIC_DEBUG regression
Date:   Mon, 11 Sep 2023 17:08:16 -0600
Message-ID: <20230911230838.14461-1-jim.cromie@gmail.com>
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

This series fixes the regression in DRM_USE_DYNAMIC_DEBUG=y

blame analysis: (all mine)

1. my early test scripts did a lot of 'modprobe $m $*',
   with dyndbg=.. and debug=.. args
   this obscured the lack of drm.debug -> drivers propagation

2. I broke K&R rule: "define once, refer many times".
   the classmaps DECLAREd by the drivers would run on args in 1

The thinko beneath that was imitating the "static struct" in the
definition of DEFINE_DYNAMIC_DEBUG_METADATA.  Imitating __drm_debug
export instead broke the mental logjam.

So the patchset splits DECLARE_DYNDBG_CLASSMAP duty in 2: with
DYNDBG_CLASSMAP_DEFINE/_USE, where _DEFINE exports the classmap, so
_USE can reference it.  The _USEs are added into a new section:
__dyndbg_class_users.

ddebug_add_module() now also scans class_users at modprobe time,
whence it finds the kernel-param that refs the classmap, and applies
its initialized state to the user/driver.

test-dynamic-debug is extended with a _submod, allowing it to
recapitulate the drm.ddebug -/-> drivers failure scenario.


NOTE: patch-14 does the DECLARE -> _DEFINE/_USE, so it also changes
DRM to follow the API change.  That makes it buildable, but crosses 2
trees, which isn't so great.  But since the feature is marked BROKEN
at this point, perhaps I should have split them.

Finally 3 DRM patches: drops BROKEN on DRM_USE_DYNAMIC_DEBUG, fixes
drm/Makefile, and wires a bunch more drivers to _USE DRM's
drm_debug_classmap.

You can bang at the test module with:
#!/bin/bash

ddcmd () {
    echo $* > /proc/dynamic_debug/control
}
vx () {
    echo $1 > /sys/module/dynamic_debug/parameters/verbose
}
ddgrep () {
    grep $1 /proc/dynamic_debug/control
}
doprints () {
    cat   /sys/module/test_dynamic_debug/parameters/do_prints
}

note () {
    echo NOTE: $* >&2
    $*
}
ddparms () {
    note ls -l /sys/module/test_dynamic_debug/parameters/
    note cat   /sys/module/test_dynamic_debug/parameters/*
}
up () {
    modprobe drm debug=0x03 debug_trace=0x1ff
}
dn () {
    rmmod drm
}
ddtraceon () {
    echo 1 > /sys/kernel/tracing/tracing_on
    echo 1 > /sys/kernel/tracing/events/dyndbg/enable
}

# replay drm.debug dependent-module scenario
submod () {
    echo  MP test_dynamic_debug $1 $2 dyndbg=+pm $3 $4

    # extra complexity to avoid passing param=s since theyre explicit inits
    if [[ -z $1 ]] ; then
	modprobe test_dynamic_debug dyndbg=+pm
    elif [[ -z $2 ]] ; then
	modprobe test_dynamic_debug dyndbg=+pm \
		 p_disjoint_bits=${1:-0}
    elif [[ -z $3 ]] ; then
	# force 3,4 off, undoing DEBUG - declutter
	modprobe test_dynamic_debug dyndbg=+pm \
		 p_disjoint_bits=${1:-0} p_level_num=${2:-0}
		 # p_disjoint_names=${3:-MID,-LOW,-HI} p_level_names=${4:-L3}
    elif [[ -z $4 ]] ; then
	modprobe test_dynamic_debug dyndbg=+pm \
		 p_disjoint_bits=${1:-0} p_level_num=${2:-0}
		 # p_disjoint_names=${3:-MID}
    else
	modprobe test_dynamic_debug dyndbg=+pm \
		 p_disjoint_bits=${1:-0} p_level_num=${2:-0}
		 # p_disjoint_names=${3:-MID} p_level_names=${4:-L3}
    fi
    
    # _submod should pick up kparams
    echo  MP test_dynamic_debug_submod dyndbg=+pmf
    modprobe test_dynamic_debug_submod dyndbg=+pmf
}
unmod () {
    rmmod test_dynamic_debug_submod
    rmmod test_dynamic_debug
}

# The test:
submod_test () {
    unmod
    submod $*
    sleep 1
    
    note "above submod.s D2_* prdbgs should have printed"
    note "because they are enabled here:"
    ddgrep _submod

    echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints

    note submod prdbgs should print here
    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_prints
}

# old-code: triggered jump-label init panic, fixed by doing
# dyndbg-init in notifier, after jump-label
submod_force () {
    unmod
    submod $*
    sleep 1
    # force all classes off, then on
    note trigger toggled warning by turning off the supposed enabled prdbgs in submod

    echo 0     > /sys/module/test_dynamic_debug/parameters/disjoint_bits
    echo 0x2ff > /sys/module/test_dynamic_debug/parameters/disjoint_bits

    note now theyre on
    doprints
}

setup () {
    echo dynbg-verbose-0, clearing kmsg, and running submod_test
    vx 0
    dmesg -W &
    submod_test  7 7
    ddcmd class V +mfl
    ddcmd class V2 +tmfsl
    ddcmd class V3 +mfsl
    ddcmd class V4 +mfs
    ddcmd class V5 +mf
    ddcmd class V6 +m
    doprints
}



Jim Cromie (22):
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
  dyndbg-API: fix CONFIG_DRM_USE_DYNAMIC_DEBUG regression
  dyndbg: add for_each_boxed_vector
  dyndbg: refactor ddebug_classparam_clamp_input
  dyndbg-API: promote DYNDBG_CLASSMAP_PARAM to API
  dyndbg-test: build it with just CONFIG_DYNAMIC_DEBUG_CORE
  dyndbg-doc: add classmap info to howto
  dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
  dyndbg: add _DPRINTK_FLAGS_INCL_LOOKUP
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
 include/linux/dynamic_debug.h                 | 122 ++++--
 kernel/module/main.c                          |   3 +
 lib/Kconfig.debug                             |  10 +-
 lib/Makefile                                  |   4 +-
 lib/dynamic_debug.c                           | 407 +++++++++++-------
 lib/test_dynamic_debug.c                      | 137 +++---
 lib/test_dynamic_debug_submod.c               |  17 +
 27 files changed, 546 insertions(+), 346 deletions(-)
 create mode 100644 lib/test_dynamic_debug_submod.c

-- 
2.41.0

