Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76727FBA61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjK1MpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjK1MpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:45:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10602D4C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:45:17 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6460766020EE;
        Tue, 28 Nov 2023 12:45:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701175516;
        bh=Q1fClNxiy5uCbKocfPk587p66TLkQdgMv+lgueLRZgc=;
        h=From:To:Cc:Subject:Date:From;
        b=dicwJevDrgKOkdWNhibo40/NRp7chzmaLrhuk0GWI7Twtdk/HUktcvcbRPmqS6rDR
         yd7nEZsZupNiNwF7lkpPfnbxC45lnlxcRCtbF11knluuY7G5+Exq4LBVduuIFI5Tmf
         t8F+ccRtOOohPOMF3nob8jOQpcMTzVQR6DIT9x/PS9RjAZ5pV9xBmmauMjf0ADp5DJ
         KBSRBqmV5QUubdkDmCB5X2r/sOIMpiCvTKXAnCf5OPKcDhyXgFXZsxMmotU4s0ga6K
         c2+4TFQNX+bb4f1ELDTEOlbQARZWGnLo71tYEgwb9fVVXYIZOpBmxuu7mJvfyVpu4J
         X4Ti8TKlB2h2Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     boris.brezillon@collabora.com
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, m.szyprowski@samsung.com,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 0/3] drm/panfrost: Fix poweroff and sync IRQs for suspend
Date:   Tue, 28 Nov 2023 13:45:07 +0100
Message-ID: <20231128124510.391007-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fast fix for the basic GPU poweroff functionality
and goes further by implementing interrupt masking and synchronization
before suspend.

For more information, please look at the conversation at [1], which
explains the regression seen with the poweroff commit and the initial
approaches taken to solve that.

Cheers!

[1]: https://lore.kernel.org/all/20231123095320.41433-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (3):
  drm/panfrost: Ignore core_mask for poweroff and disable PWRTRANS irq
  drm/panfrost: Add gpu_irq, mmu_irq to struct panfrost_device
  drm/panfrost: Synchronize and disable interrupts before powering off

 drivers/gpu/drm/panfrost/panfrost_device.c |  4 +++
 drivers/gpu/drm/panfrost/panfrost_device.h |  9 +++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 29 +++++++++++++++-------
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 18 +++++++++++---
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 27 ++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
 8 files changed, 70 insertions(+), 20 deletions(-)

-- 
2.42.0

