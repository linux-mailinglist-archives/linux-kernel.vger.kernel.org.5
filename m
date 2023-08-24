Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7778689A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjHXHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbjHXHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E331735;
        Thu, 24 Aug 2023 00:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 457F66328D;
        Thu, 24 Aug 2023 07:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E109C433C9;
        Thu, 24 Aug 2023 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862645;
        bh=apVo29quPAJNJ5zBNsotHOwD/sJ5HhXMBXuZaLSVig8=;
        h=From:To:Cc:Subject:Date:From;
        b=t6Uje6qsOtieNhKUK3PZ0NhYuVib0TYmuGgGXn/SM+BGz5yDI7Yv6Ic7/Q9SIMUoM
         75jPH2B3yCqjB3etVZHJUsItPk+uS+QXbwFon6ZWnUHV0WvtOs0kOkmr/o9C48sf22
         81r6ukOs+zNlnQuf4jGA8hYZhqmMf6Mc5DhcJNo4+uYaZOIMlCMSk8ezNAjSNX3y1r
         L8ZsdtuEADnpUNzDfLQVv48w19gXSemSY9q/ESnKx2YKJwvrQoCFzyxlX1vA0+rsjp
         EvLKEudsnhcXwz+dcCssbhSPSkdTNL+XLYFIzHsS7Jx93dkGS/l/b1fPNoO6EGgv3R
         vFR2L2MSGRfYw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karol Herbst <kherbst@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        nouveau@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Date:   Thu, 24 Aug 2023 08:36:45 +0100
Message-ID: <20230824073710.2677348-1-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Gourav Samaiya <gsamaiya@nvidia.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Jerome Glisse <glisse@freedesktop.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-media@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: "Maíra Canal" <mairacanal@riseup.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: nouveau@lists.freedesktop.org
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

Lee Jones (20):
  drm/xlnx/zynqmp_disp: Use correct kerneldoc formatting in zynqmp_disp
  drm/nouveau/nvkm/subdev/acr/lsfw: Remove unused variable 'loc'
  drm/nouveau/nvkm/subdev/bios/init: Demote a bunch of kernel-doc abuses
  drm/nouveau/nvkm/subdev/volt/gk20a: Demote kerneldoc abuses
  drm/nouveau/nvkm/engine/gr/gf100: Demote kerneldoc abuse
  drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
  drm/radeon/radeon_ttm: Remove unused variable 'rbo' from
    radeon_bo_move()
  drm/amd/amdgpu/sdma_v6_0: Demote a bunch of half-completed function
    headers
  drm/tests/drm_kunit_helpers: Place correct function name in the
    comment header
  drm/scheduler/sched_main: Provide short description of missing param
    'result'
  drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct misdocumented param
    'doorbell_index'
  drm/amd/amdgpu/amdgpu_device: Provide suitable description for param
    'xcc_id'
  drm/tests/drm_kunit_helpers: Correct possible double-entry typo in
    'ddrm_kunit_helper_acquire_ctx_alloc'
  drm/imx/ipuv3/imx-ldb: Increase buffer size to ensure all possible
    values can be stored
  drm/tegra/hub: Increase buffer size to ensure all possible values can
    be stored
  drm/drm_connector: Provide short description of param
    'supported_colorspaces'
  drm/amd/amdgpu/amdgpu_ras: Increase buffer size to account for all
    possible values
  drm/drm_gpuva_mgr: Remove set but unused variable 'prev'
  drm/amd/amdgpu/amdgpu_sdma: Increase buffer size to account for all
    possible values
  drm/amd/amdgpu/imu_v11_0: Increase buffer size to ensure all possible
    values can be stored

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   8 +-
 drivers/gpu/drm/drm_connector.c               |   2 +
 drivers/gpu/drm/drm_gpuva_mgr.c               |  10 +-
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c           |   2 +-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c       |   4 +-
 .../gpu/drm/nouveau/nvkm/engine/gr/gf100.c    |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c    |   3 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/init.c   | 136 +++++++++---------
 .../gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c  |   4 +-
 drivers/gpu/drm/radeon/radeon_ttm.c           |   2 -
 drivers/gpu/drm/scheduler/sched_main.c        |   1 +
 drivers/gpu/drm/tegra/hub.c                   |   2 +-
 drivers/gpu/drm/tests/drm_kunit_helpers.c     |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c            |   6 +-
 19 files changed, 96 insertions(+), 97 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

