Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778F9792DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbjIESwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjIESwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:52:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB4E78;
        Tue,  5 Sep 2023 11:51:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BA2D6607038;
        Tue,  5 Sep 2023 19:45:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693939544;
        bh=FGsQV/S5pRAHMoWWN5RS4+CcJHs6Hwgm/Twc6RPbmng=;
        h=From:To:Cc:Subject:Date:From;
        b=UFrmGNyFBBonyiAHIYpGo6uyKaupLNGWAvDzXYSfEu4vDwAss9agU0DoWJ5omsqsx
         RcnLFLCvGEc4HNvmnEON2/W2QxWqYaGK+1j3Xc4cMdKTqPFE6nSnSZ3nz4Iq1EqweN
         xo4Od2iEGEwoj3MKaW2ArwOAxwWnNETuROVcQeyUWd6DbO7yeMB4bip1zRdB0lYpav
         OyBRUuIGfkIIhdAg94YZbGf4j6qiNO//CSxiFS1gRZy3fEkJRX2NXaJJQ6loMva5f/
         FZ77Y40K/LC9+DrOr0dvZxfRqBejNDhh6Cir4/1lD6WdsGDv+pIxMFAZR6zkulLfrf
         DiK1Lzt/Syd/Q==
From:   =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     adrian.larumbe@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, healych@amazon.com,
        kernel@collabora.com
Subject: [PATCH v3 0/8] Add fdinfo support to Panfrost
Date:   Tue,  5 Sep 2023 19:45:16 +0100
Message-ID: <20230905184533.959171-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds fdinfo support to the Panfrost DRM driver. It will
display a series of key:value pairs under /proc/pid/fdinfo/fd for render
processes that open the Panfrost DRM file.

The pairs contain basic drm gpu engine and memory region information that
can either be cat by a privileged user or accessed with IGT's gputop
utility.

Changelog:

v1: https://lore.kernel.org/lkml/bb52b872-e41b-3894-285e-b52cfc849782@arm.com/T/

v2: https://lore.kernel.org/lkml/20230901084457.5bc1ad69@collabora.com/T/
 - Changed the way gpu cycles and engine time are calculated, using GPU
 registers and taking into account potential resets.
 - Split render engine values into fragment and vertex/tiler ones.
 - Added more fine-grained calculation of RSS size for BO's.
 - Implemente selection of drm-memory region size units
 - Removed locking of shrinker's mutex in GEM obj status function

v3:
 - Changed fdinfo engine names to something more descriptive
 - Mentioned GPU cycle counts aren't an exact measure
 - Handled the case when job->priv might be NULL
 - Handled 32 bit overflow of cycle register
 - Kept fdinfo drm memory stats size unit display within 10k times the
   previous multiplier for more accurate BO size numbers
 - Removed special handling of Prime imported BO RSS
 - Use rss_size only for heap objects
 - Use bo->base.madv instead of specific purgeable flag
 - Fixed kernel test robot warnings

Adrián Larumbe (8):
  drm/panfrost: Add cycle count GPU register definitions
  drm/panfrost: Enable cycle counter register upon job submission
  drm/panfrost: Enable debugfs toggling of cycle counter register
  drm/panfrost: Add fdinfo support GPU load metrics
  drm/panfrost: Add fdinfo support for memory stats
  drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
  drm/panfrost: Implement generic DRM object RSS reporting function
  drm/drm-file: Show finer-grained BO sizes in drm_show_memory_stats

 drivers/gpu/drm/drm_file.c                  |  7 ++-
 drivers/gpu/drm/panfrost/Makefile           |  2 +
 drivers/gpu/drm/panfrost/panfrost_debugfs.c | 51 ++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_debugfs.h | 13 +++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  8 +++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 +
 drivers/gpu/drm/panfrost/panfrost_device.c  |  5 ++
 drivers/gpu/drm/panfrost/panfrost_device.h  | 19 ++++++
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 65 ++++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 28 +++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h     |  5 ++
 drivers/gpu/drm/panfrost/panfrost_gpu.c     | 43 ++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h     |  6 ++
 drivers/gpu/drm/panfrost/panfrost_job.c     | 37 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h     |  5 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 12 ++--
 drivers/gpu/drm/panfrost/panfrost_regs.h    |  5 ++
 include/drm/drm_gem.h                       |  9 +++
 18 files changed, 316 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h


base-commit: f45acf7acf75921c0409d452f0165f51a19a74fd
-- 
2.42.0

