Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF0791B3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjIDQQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjIDQQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:16:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB39D;
        Mon,  4 Sep 2023 09:16:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 696FD660722B;
        Mon,  4 Sep 2023 17:15:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693844163;
        bh=xPXtvuiXMDVBWx/0jUHhIWmNJ5ZPDsCSW3gvJrwF0oY=;
        h=From:To:Cc:Subject:Date:From;
        b=k6JZBUwnNWNMmFP4LrNvMsJjMmMG8xtaztfYdO1KfVk7AcmpPoNW5n9A0eWaZUl6R
         1+9n3PXxe5e/uO1S8i6sfzaxJcyz6dAyT3GGQ4bQ6nmfUC1RwzFK8ij9LdMCe221VL
         YINmWrOLNMf8jBXVowAScLstpDHGYwV4pM26+xhfEyJNBFKAFYd6e8aZEKTLSQdd7U
         huHZaSeDa4ajqaOQ+qj4X/0qZ6jWuDYddHaiYTd6wbYzCn3GlaehkDH4wDrlAuQ6j7
         QmYj0in4HMVY7kOlc+Bdf29oqWskc4qrWG4oeRbwxoYs80F+4ede0LSPlLnPFvOIYq
         UR96GTDDVNZQg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/7] drm: ci: fixes
Date:   Mon,  4 Sep 2023 21:45:09 +0530
Message-Id: <20230904161516.66751-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series contains improvements, enabling new ci jobs which
enables testing for Mediatek MT8173, Qualcomm APQ 8016 and VirtIO GPU,
fixing issues with the ci jobs and updating the expectation files.
This series is intended for drm branch topic/drm-ci.

v2:
  - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
  - Reworded the commit message for enabling jobs
  - Added a new patch in the series to use scripts/config to enable/disable configs

Vignesh Raman (7):
  drm: ci: igt_runner: remove todo
  drm: ci: Force db410c to host mode
  drm: ci: virtio: update ci variables
  drm: ci: Enable configs to fix mt8173 boot hang issue
  drm: ci: Update xfails
  drm: ci: Enable new jobs
  drm: ci: Use scripts/config to enable/disable configs

 drivers/gpu/drm/ci/arm64.config               |  2 ++
 drivers/gpu/drm/ci/build.sh                   | 19 ++++++++++++-------
 .../ci/dt-overlays/apq8016-sbc-overlay.dts    | 13 +++++++++++++
 drivers/gpu/drm/ci/gitlab-ci.yml              |  2 +-
 drivers/gpu/drm/ci/igt_runner.sh              |  1 -
 drivers/gpu/drm/ci/test.yml                   | 14 ++++----------
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |  1 -
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  1 -
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |  2 ++
 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |  1 +
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   |  2 --
 .../drm/ci/xfails/mediatek-mt8173-flakes.txt  | 16 ++++++++++++++++
 .../gpu/drm/ci/xfails/msm-apq8016-flakes.txt  |  2 ++
 .../drm/ci/xfails/rockchip-rk3288-flakes.txt  |  1 +
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  4 ++--
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  3 +++
 16 files changed, 59 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts

-- 
2.40.1

