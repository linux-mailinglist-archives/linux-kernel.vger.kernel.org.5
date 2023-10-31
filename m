Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5387DC771
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbjJaHjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbjJaHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:39:51 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2DBDF;
        Tue, 31 Oct 2023 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0Gjq6fjQV3V/kUXnqDrmOdv5PactEotElsmcVGlJqFI=; b=ro5B47lA1kK7u/l6aQkUvTm8Mn
        gt6i4VPrp2ERG9ipJ5pjW7Nq2eab9AshZnpUTempPgIOktHDhPdj9qqroP6P04yZRaqtKX8ZmT1nx
        HjE/8JeWv04nshw//4AAg9hfudjaBTCvSg3obYSurCb7jGiE4ApbvX96bWIwnbpu2w/Nw1uWbGWY4
        Ab8H/J4Xb65BHWn75AJ3xC7kbmC8xlzTEnZVo1rvemvI4bFb4RWEsF04QxCU4WDpZtMkeaP4hgPDk
        VTvyud/RYNdHfJfDaH+PCVF/doen51C4HZEOoIXAsImNghjwjd9x0BTVq6oBf4wrDsxq7Ej75I85M
        7w0KjnZA==;
Received: from 251.48.60.213.dynamic.reverse-mundo-r.com ([213.60.48.251] helo=vega.mundo-R.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qxjLU-00FHU5-HX; Tue, 31 Oct 2023 08:39:28 +0100
From:   Iago Toral Quiroga <itoral@igalia.com>
To:     dri-devel@lists.freedesktop.org, Maira Canal <mcanal@igalia.com>
Cc:     Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH v3 0/4] V3D module changes for Pi5
Date:   Tue, 31 Oct 2023 08:38:55 +0100
Message-Id: <20231031073859.25298-1-itoral@igalia.com>
X-Mailer: git-send-email 2.39.2
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

This series includes patches to update the V3D kernel module
that drives the VideoCore VI GPU in Raspberry Pi 4 to also support
the Video Core VII iteration present in Raspberry Pi 5.

The first patch in the series adds a small uAPI update required for
TFU jobs, the second patch addresses the bulk of the work and
involves mostly updates to register addresses, the third and fourth
patches match the 'brcm,2712-v3d' device string from Pi5 with the
V3D driver.

The changes for the user-space driver can be found in the
corresponding Mesa MR here:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25450

Changes in v2:
  - Addeded s-o-b to patches (Maíra Canal)
  - patch 2: fixed style warnings (Maíra Canal)
  - patch 2: Use macro with version param to get reg addresses (Maíra Canal)
  - new patch: Update the device tree binding (Stefan Wahren)

Changes in v3:
  - Moved changelog entries in patches to cover letter (Stefan Wahren)
  - Added DT maintainers (Stefan Wahren, Krzysztof Kozlowski)

Iago Toral Quiroga (4):
  drm/v3d: update UAPI to match user-space for V3D 7.x
  drm/v3d: fix up register addresses for V3D 7.x
  dt-bindings: gpu: v3d: Add BCM2712's compatible
  drm/v3d: add brcm,2712-v3d as a compatible V3D device

 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml |   1 +
 drivers/gpu/drm/v3d/v3d_debugfs.c             | 178 ++++++++++--------
 drivers/gpu/drm/v3d/v3d_drv.c                 |   1 +
 drivers/gpu/drm/v3d/v3d_gem.c                 |   4 +-
 drivers/gpu/drm/v3d/v3d_irq.c                 |  46 +++--
 drivers/gpu/drm/v3d/v3d_regs.h                |  94 +++++----
 drivers/gpu/drm/v3d/v3d_sched.c               |  38 ++--
 include/uapi/drm/v3d_drm.h                    |   5 +
 8 files changed, 211 insertions(+), 156 deletions(-)

-- 
2.39.2

