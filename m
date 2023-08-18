Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037D07806AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358331AbjHRHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358323AbjHRHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:51:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F33A82
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:51:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdca7cc28dso5227195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692345088; x=1692949888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNjosiFza5eZ8AzQ6EtrPFDkWUDthg2MbmBsjDUS0f4=;
        b=OFeh6xVr4kXV6Q1jV7E46aI8kzKDR7ZLAYO0UcLqsJVApAi9zup8+PJhe62UfF+KJu
         /WNKE9FSJsShKLLIMjT5jzLUKfni9Pv8PAa7ERNF82oCEieEKrcY/H7sFoVVKOmeSune
         udSLWJXyeF1SfGrMZmo3JYsmWSe4uQT6uAwzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692345088; x=1692949888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNjosiFza5eZ8AzQ6EtrPFDkWUDthg2MbmBsjDUS0f4=;
        b=HwmrTQ4/BLF3aZiC7AiAgnRHNTaPXKoYhtGLH1TwevqtxRXOsbSD/HqNIILkUzXuNh
         XMDnk0BSF/TAq12dQq3u/HYVQEfcxchHRSH+VWLLo8QlgWSFhn8lis+Pyd5rVQ9E6IeV
         g9tnikf1ZBsGYjCkCw/lRNFbmc23nn2c2IcheVXrzXmDKaKFMXEclsnaak96Dy7KiOB7
         wYrmRgpNDSRUUXYSQ+AETy4ubQ4EQezAxDvZM8rkYEZyKf2QiKDhEyCo82IAUTgbMeNa
         A0YMxPutvimwpqn5DAWuwfO6/oQ5TYZ90VGDu+m0DaQQGev1e5u9tyzF74mPIGTs6hdi
         4fWQ==
X-Gm-Message-State: AOJu0Yy9c0Qwb1mePZTkvaIOb5MArVVgWFGVS+6+i+tDc8abObefeAKz
        yk6WhIM3rqkVsdfsticnHLjg+Q==
X-Google-Smtp-Source: AGHT+IE0qUgsLAEdbNZSbOllAJUBEu6mdWYQlh4tavv+TAFALNCFVxPl8/bJqJYd/MFzx+dhzL5rUw==
X-Received: by 2002:a17:902:e74b:b0:1b8:94f4:3e0 with SMTP id p11-20020a170902e74b00b001b894f403e0mr2237474plf.14.1692345087938;
        Fri, 18 Aug 2023 00:51:27 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001ba066c589dsm1051834plb.137.2023.08.18.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:51:27 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com, jshargo@chromium.org
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mairacanal@riseup.net,
        melissa.srw@gmail.com, mripard@kernel.org,
        rodrigosiqueiramelo@gmail.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mduggan@chromium.org,
        hirono@chromium.org, Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v3 0/7] Adds support for ConfigFS to VKMS!
Date:   Fri, 18 Aug 2023 07:43:05 +0000
Message-ID: <20230818075057.3426088-1-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Jim is busy with other work and I'm working on some things that
rely on this, I've taken up the task of doing the iterations.  I've
addressed the comments as best I can (those replies are to each
individual change) and here is the patch set to go with those.

I added my own signoff to each commit, but I've left jshargo@ as the
author of all the commits he wrote.  I'm sure there is still more to
address and the ICT tests that were writtein parallel to this may also
need some additions, but I'm hoping we're in a good enough state to get
this in and iterate from there soon.

Since V3:
========
I've added hotplug support in the latest patch.  This has been reviewed some
and the notes from that review are addressed here as well.

Relevant/Utilizing work:
=======================
I've built a while test framework based on this as proof it functions (though
I'm sure there may be lingering bugs!).  You can check that out on
crrev.com if you are interested and need to get started yourself (but be
aware of any licensing that may differ from the kernel itself!  Make
sure you understand the license:

https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/tast-tests/LICENSE

That said, you can see the changes in review on the crrev gerrit:

https://chromium-review.googlesource.com/c/chromiumos/platform/tast-tests/+/4666669

Outro:
=====
I really appreciate everyone's input and tolerance in getting these
changes in.  Jim's first patch series was this, and other than some
small cleanups and documentation, taking over it is also mine.

Thank you everyone :)

Original Message:
>Usage
>=====
>
>After installing these patches, you can create a VKMS device with two
>displays and a movable overlay like so (this is documented in the
>patches):
>
>  $ modprobe vkms enable_overlay=1 enable_cursor=1 enable_writeback=1
>  $ mkdir -p /config/
>  $ mount -t configfs none /config
>
>  $ export DRM_PLANE_TYPE_PRIMARY=1
>  $ export DRM_PLANE_TYPE_CURSOR=2
>  $ export DRM_PLANE_TYPE_OVERLAY=0
>
>  $ mkdir /config/vkms/test
>
>  $ mkdir /config/vkms/test/planes/primary
>  $ echo $DRM_PLANE_TYPE_PRIMARY > /config/vkms/test/planes/primary/type
>
>  $ mkdir /config/vkms/test/planes/other_primary
>  $ echo $DRM_PLANE_TYPE_PRIMARY > /config/vkms/test/planes/other_primary/type
>
>  $ mkdir /config/vkms/test/planes/cursor
>  $ echo $DRM_PLANE_TYPE_CURSOR > /config/vkms/test/planes/cursor/type
>
>  $ mkdir /config/vkms/test/planes/overlay
>  $ echo $DRM_PLANE_TYPE_OVERLAY > /config/vkms/test/planes/overlay/type
>
>  $ mkdir /config/vkms/test/crtcs/crtc
>  $ mkdir /config/vkms/test/crtcs/crtc_other
>  $ mkdir /config/vkms/test/encoders/encoder
>  $ mkdir /config/vkms/test/connectors/connector
>
>  $ ln -s /config/vkms/test/encoders/encoder /config/vkms/test/connectors/connector/possible_encoders
>  $ ln -s /config/vkms/test/crtcs/crtc /config/vkms/test/encoders/encoder/possible_crtcs/
>  $ ln -s /config/vkms/test/crtcs/crtc /config/vkms/test/planes/primary/possible_crtcs/
>  $ ln -s /config/vkms/test/crtcs/crtc /config/vkms/test/planes/cursor/possible_crtcs/
>  $ ln -s /config/vkms/test/crtcs/crtc /config/vkms/test/planes/overlay/possible_crtcs/
>  $ ln -s /config/vkms/test/crtcs/crtc_other /config/vkms/test/planes/overlay/possible_crtcs/
>  $ ln -s /config/vkms/test/crtcs/crtc_other /config/vkms/test/planes/other_primary/possible_crtcs/
>
>  $ echo 1 > /config/vkms/test/enabled
>
>Changes within core VKMS
>========================
>
>This introduces a few important changes to the overall structure of
>VKMS:
>
>  - Devices are now memory managed!
>  - Support for multiple CRTCs and other objects has been added
>
>Since v1
>========
>
>  - Added DRMM memory management to automatically clean up resources
>  - Added a param to disable the default device
>  - Renamed "cards" to "devices" to improve legibility
>  - Added a lock for the configfs setup handler
>  - Moved all the new docs into the relevant .c file
>  - Addressed as many of sean@poorly.run as possible
>
>Testing
>=======
>
>  - New IGT tests (see
>    gitlab.freedesktop.org/jshargo/igt-gpu-tools/-/merge_requests/1)
>  - Existing IGT tests (excluding .*suspend.*, including .*kms_flip.*
>    .*kms_writeback.* .*kms_cursor_crc.*, .*kms_plane.*)
>
>Outro
>=====
>
>I'm excited to share these changes, it's my still my first kernel patch
>and I've been putting a lot of love into these.

Brandon Pollack (1):
  drm/vkms Add hotplug support via configfs to VKMS.

Jim Shargo (6):
  drm/vkms: Back VKMS with DRM memory management instead of static
    objects
  drm/vkms: Support multiple DRM objects (crtcs, etc.) per VKMS device
  drm/vkms: Provide platform data when creating VKMS devices
  drm/vkms: Add ConfigFS scaffolding to VKMS
  drm/vkms: Support enabling ConfigFS devices
  drm/vkms: Add a module param to enable/disable the default device

 Documentation/gpu/vkms.rst            |  20 +-
 drivers/gpu/drm/Kconfig               |   1 +
 drivers/gpu/drm/vkms/Makefile         |   1 +
 drivers/gpu/drm/vkms/vkms_composer.c  |  30 +-
 drivers/gpu/drm/vkms/vkms_configfs.c  | 724 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c      | 103 ++--
 drivers/gpu/drm/vkms/vkms_drv.c       | 206 +++++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 182 +++++--
 drivers/gpu/drm/vkms/vkms_output.c    | 340 ++++++++++--
 drivers/gpu/drm/vkms/vkms_plane.c     |  38 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  33 +-
 11 files changed, 1443 insertions(+), 235 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

-- 
2.42.0.rc1.204.g551eb34607-goog

