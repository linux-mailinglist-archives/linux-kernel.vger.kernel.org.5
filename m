Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7A7864B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjHXBg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbjHXBgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:36:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA13810E4;
        Wed, 23 Aug 2023 18:36:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a02:8010:65b5:0:1ac0:4dff:feee:236a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 234F86607186;
        Thu, 24 Aug 2023 02:36:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692840979;
        bh=CTem+vlDOUjPRaoGMpRBhvncae1lgfwc6Fj1M1O4Rf0=;
        h=From:To:Cc:Subject:Date:From;
        b=GDW0sV3Ym09BdZH5iPbMQ7DDt3jRbkBGpybyCnYvafe/FSNas9aSusXMzSzSP/gsY
         mYvq747rG8SJTcQyaAAhL8Qlc+a8DoPavfPlveT55aFnY1UopgnWt8C7fcfMdFft8l
         vqcLTN7Sc7sDaa5mvPsANtna9ehysDr0a4PbqxqJxFeuV/e7ibh/cYucu9U3i0S0RU
         48Qg01yFS4NSGSPJdM5AbD8MINYTrDILIGXGWBFHTDCBMEEGHMVNXPkgek5P9zIGvs
         KQbF1PyIAn7S2fGWGrSHSVlqwsL7wMiqVDFz39cwIloCgn8VSLk3L7KfDzjD63MZRT
         MdaUdpM4fvwSA==
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
Subject: [PATCH v2 0/6] Add fdinfo support to Panfrost
Date:   Thu, 24 Aug 2023 02:34:43 +0100
Message-ID: <20230824013604.466224-1-adrian.larumbe@collabora.com>
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

v2:
 - Changed the way gpu cycles and engine time are calculated, using GPU
 registers and taking into account potential resets.
 - Split render engine values into fragment and vertex/tiler ones.
 - Added more fine-grained calculation of RSS size for BO's.
 - Implemente selection of drm-memory region size units
 - Removed locking of shrinker's mutex in GEM obj status function

Adrián Larumbe (6):
  drm/panfrost: Add cycle count GPU register definitions
  drm/panfrost: Add fdinfo support GPU load metrics
  drm/panfrost: Add fdinfo support for memory stats
  drm/drm_file: Add DRM obj's RSS reporting function for fdinfo
  drm/panfrost: Implement generic DRM object RSS reporting function
  drm/drm-file: Allow size unit selection in drm_show_memory_stats

 drivers/gpu/drm/drm_file.c                  | 27 +++++++----
 drivers/gpu/drm/msm/msm_drv.c               |  2 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  8 +++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h |  3 ++
 drivers/gpu/drm/panfrost/panfrost_device.h  | 13 +++++
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 54 +++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gem.c     | 34 +++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.h     |  6 +++
 drivers/gpu/drm/panfrost/panfrost_job.c     | 30 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h     |  4 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 16 ++++--
 drivers/gpu/drm/panfrost/panfrost_regs.h    |  5 ++
 include/drm/drm_file.h                      |  5 +-
 include/drm/drm_gem.h                       |  9 ++++
 14 files changed, 195 insertions(+), 21 deletions(-)

-- 
2.42.0

