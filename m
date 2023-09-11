Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B3879C152
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjILAsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjILAsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:48:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB91E238C;
        Mon, 11 Sep 2023 16:09:47 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-792623074edso145880239f.1;
        Mon, 11 Sep 2023 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473706; x=1695078506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4QPvsUCuesDbdqzdhDuBEQMp4BSGGOAe53BRO5DTLhU=;
        b=WAsfvyAm4nq/T0d542lY7eJYNEWKx1KrHiO7uKGUjfRQxMplaCVuQHW6Q2kC8YkqOZ
         eVaN/pNeQzYSRumFzAIigbjqS6i77zjpFG/LzXvrtGeSb9xg56Yd6GisaXs1nGrA2dD7
         Sga5bxd4aWJ0yHKCEB3mXw6Y7R6khtCfOizyS0YbOa91EqLxgcx4yajRbQY3LyC2ilwr
         aNuGaGGTuklrEltmizJCHjuVbMn70EjHB1T9h0aOMMln/YJTG41arbdKmb9wpiQ7yA3K
         c1vh4vCeH6KEuJc7OgoCt+tUJROPdm4gCt1aWjW6Zl6y+ULqSb4cdIBsQ7FXoIQa0xpl
         a7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473706; x=1695078506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QPvsUCuesDbdqzdhDuBEQMp4BSGGOAe53BRO5DTLhU=;
        b=HHvV+Ykiv8Hqb3iHSSxiKsUoXesEWNNxKWzl/fw9wyIu3jVPdaTNr9VWpIsyIQbuoa
         kDqU6WyOM8uBjMx6pDTSQH5SnE+K8PUfzkU9y3VJMx+TS2KDAbFMB7OIMYzDOFBExqI9
         daQTW6HGynu9+WmyyPc+5h7VyDRthYF0tDY+NJbcOvzCaH8dSPqlQ0fliBB4KSveQ3de
         05e26Bqk8oCcdEbXw/+4b+qauDAbk/nQHp1E/X1LERsseZ+Oz00s72O1kUDePNFEIPsP
         EgsmwD3pEjznGX7x5p0wehgl6AKam6QdscfaCFGAEjPkyd77QfJKibeP7SpeWAz61JBO
         5veA==
X-Gm-Message-State: AOJu0Yz/gqIlLj8c5WL5hpNggpEFz8VOcsygQm0GR4g0zpa+7C5c2UQP
        f4QxsSymIAy+wD0hnrE6DOE=
X-Google-Smtp-Source: AGHT+IG7bYicJCrmUYKVqmd3OJOt+rHV8pZgZGqdIESBV9//RY1GB+4nospOwL2Y8hO5uFJ5BARkiQ==
X-Received: by 2002:a05:6602:2e89:b0:792:8c29:7b with SMTP id m9-20020a0566022e8900b007928c29007bmr1041872iow.10.1694473705771;
        Mon, 11 Sep 2023 16:08:25 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u1-20020a02c041000000b0042b1061c6a8sm2518671jam.84.2023.09.11.16.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:25 -0700 (PDT)
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
Date:   Mon, 11 Sep 2023 17:07:55 -0600
Message-ID: <20230911230817.14402-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

