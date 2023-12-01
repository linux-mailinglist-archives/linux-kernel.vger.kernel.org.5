Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4708800892
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378321AbjLAKk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378295AbjLAKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:40:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90BA10D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:40:34 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D4B5660739C;
        Fri,  1 Dec 2023 10:40:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701427233;
        bh=0ug+U8+oATYsYs/JNbMT9HWVGshpUjmLXOajcBgeZ74=;
        h=From:To:Cc:Subject:Date:From;
        b=fqg8YB6RGLAsGa67XEUsNhDp8AHj54O5bU0RVByN0367O1tABKjV9kZy1ejTTwgV8
         9kMQO7/BNfnkoWB9tT9sy+5aejcGWn8vT0OpFrZbDwhAPxA1tC8Jaxdx6ybkHIYslo
         REwtYtxhRRe3r6xjMuGH82Ofe4zSf+3SxjMnxaea93o4ROSiZKFhi38y/n3oLpCB8/
         icYHMkQ16LYYje6YYoRhmZqvGJhqlRFxcLBe6malYYF1sW0WwCfobZ+F6x9bBsH7u7
         KNkq3CdqRAFbHpFBNE7NbQxZOWc4UcN4UmNTkpfMx5IF1eyF9C8Vdtie+zIJAEluwD
         pGOzObXQyMsQw==
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
Subject: [PATCH v3 0/3] drm/panfrost: Fix poweroff and sync IRQs for suspend
Date:   Fri,  1 Dec 2023 11:40:24 +0100
Message-ID: <20231201104027.35273-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Removed useless GPU_INT_CLEAR write in suspend path
 - Changed to clear suspend bits in job/mmu reset path

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

 drivers/gpu/drm/panfrost/panfrost_device.c |  3 +++
 drivers/gpu/drm/panfrost/panfrost_device.h |  9 +++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 28 ++++++++++++++-------
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 20 ++++++++++++---
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 29 ++++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
 8 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.43.0

