Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655FA78A78E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjH1IUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjH1IUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:20:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A03198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:19:38 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a41031768so1962115b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693210776; x=1693815576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=STR53w+n0mJPUS4uOx0MPcYbGDkDAhQu6X8V6hhu27Q=;
        b=S24LFt6WlYrVzqeUL4nh3xmbWsnyGkUJqAEem1C7Qk/kT5nUKTbK4vNmKhFAgOI+Tl
         hWZHV0UMOJWWvIHGkW3NdY7WFGu9RI0d+MyvV+q4Qfhv6KIsXbuRfTElD0e7Zgkq2jMT
         CkdCudrLjNakMq/+nsWENnbiX0/4jmKqZaaa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693210776; x=1693815576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STR53w+n0mJPUS4uOx0MPcYbGDkDAhQu6X8V6hhu27Q=;
        b=ATfarSNgJw/0BesOxv77ImYSMKDfzUOc1xKeZHUGKDK5q2M64LfnbaoMcuXvLMkYmC
         4bbVf4N3slbK++vhg0l6GjVWth2EilC3UHWkd9W0zv88AtWS6LwgjutWFO8ah1Z/1qxb
         KmQ6ARIPNB7OYML0I8V729zicjHYDW9MNt4EgWUHUcHNss6KOEvL4GHgBOtdTUFTLq1+
         Qry1KBLhwGfWVZwYzG9eY5bzi7BbDhbA4EBCyYesFkHUIN79pkX0/Ajm30jMMPR0CZHy
         +DcTOUw0TUHixS81FhIhLxieujhQFDphlOO4yCa00/+52v3qvsZpdPbugoqT//xs+GtW
         20nw==
X-Gm-Message-State: AOJu0YwAEwjaxpvvjU94+EF741xJkmSiwaqmPpt7WYBzU799Mjinn6p3
        wePo9YUL43fNorl7ZCjOuAXpgQ==
X-Google-Smtp-Source: AGHT+IEaiV2e0xU93hqGVaHiIRDf1PtqblBVu3uFJESa6ohyXbUNarKYwLxGAe5rxV0odjPaFdq6AA==
X-Received: by 2002:a05:6a20:7490:b0:13a:43e8:3fb8 with SMTP id p16-20020a056a20749000b0013a43e83fb8mr23789273pzd.54.1693210776264;
        Mon, 28 Aug 2023 01:19:36 -0700 (PDT)
Received: from datalore.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001bf6ea340b3sm6616779plz.116.2023.08.28.01.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:19:35 -0700 (PDT)
From:   Brandon Pollack <brpol@chromium.org>
To:     marius.vlad@collabora.com, mairacanal@riseup.net,
        jshargo@chromium.org
Cc:     corbet@lwn.net, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        mripard@kernel.org, rodrigosiqueiramelo@gmail.com,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mduggan@chromium.org,
        hirono@chromium.org, Brandon Pollack <brpol@chromium.org>
Subject: [PATCH v5 0/7] Adds support for ConfigFS to VKMS!
Date:   Mon, 28 Aug 2023 08:17:02 +0000
Message-ID: <20230828081929.3574228-1-brpol@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Since V5:
========
Fixed some bad merge conflicts and locking behaviours as well as
clarified some documentation, should be good to go now :

Since V4:
========
Fixed up some documentation as suggested by Marius
Fixed up some bad locking as suggested by Marius
Small fixes here and there (most have email responses to previous chain
emails)

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
 drivers/gpu/drm/vkms/vkms_configfs.c  | 721 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c      | 102 ++--
 drivers/gpu/drm/vkms/vkms_drv.c       | 206 +++++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 182 +++++--
 drivers/gpu/drm/vkms/vkms_output.c    | 405 +++++++++++++--
 drivers/gpu/drm/vkms/vkms_plane.c     |  44 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  31 +-
 11 files changed, 1508 insertions(+), 235 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c

-- 
2.42.0.rc1.204.g551eb34607-goog

