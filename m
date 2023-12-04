Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4BA8031AE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjLDLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjLDLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:42:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBDEBB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:42:22 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C8B166022D1;
        Mon,  4 Dec 2023 11:42:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701690140;
        bh=dbT7V5enXDJ2E4Ob+hkRHh7p0dTf0R5FIQCB96fHlnU=;
        h=From:To:Cc:Subject:Date:From;
        b=hlLELGOEebvyBZU2AmACx0+OAov3VNPKaCF2qNWCYXRjLgXjrv6EOkbY4oHMKTGZI
         QL9QOl7uWoQmYz3txyzs8ZgGh4uJlrbticuPa/pTVrWy50IDRWYV4xKDC6zvjIUh1V
         T8hnH4MdNYN5sl2xv7zETskiHmKSI5JjsfAgzkijYCtI9jC+9+dQZFsvdxIPILtVsm
         IkE0XAhRrqbrxBQisA8vOchvjhmnpa4lLVA0RlkHVc5xBWclRIq1S3s/vjiLK8baVP
         I2LH4iVQqEB1j6Cmr9FDEkBwyfIbCzxjMsPJO+IVYKVt0w7jU+qslNJh/coHPsGApF
         XapZhwAqE1ELQ==
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
Subject: [PATCH v4 0/3] drm/panfrost: Fix poweroff and sync IRQs for suspend
Date:   Mon,  4 Dec 2023 12:42:12 +0100
Message-ID: <20231204114215.54575-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
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

Changes in v4:
 - Added checks for is_suspended bits in hardirqs
 - Added GPU suspended bit (and handling of it)
 - Reordered panfrost_drv_comp_bits entries
 - Commit description fixes

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

 drivers/gpu/drm/panfrost/panfrost_device.c |  3 ++
 drivers/gpu/drm/panfrost/panfrost_device.h | 10 ++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.c    | 40 ++++++++++++++++------
 drivers/gpu/drm/panfrost/panfrost_gpu.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c    | 26 +++++++++++---
 drivers/gpu/drm/panfrost/panfrost_job.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 32 ++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h    |  1 +
 8 files changed, 91 insertions(+), 23 deletions(-)

-- 
2.43.0

