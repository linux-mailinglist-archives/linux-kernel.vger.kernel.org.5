Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5980CCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjLKOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbjLKODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:03:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA81FE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:02:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4A5C433C7;
        Mon, 11 Dec 2023 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303324;
        bh=whuXhxP4wjKfkFcEqcwKaMlWmXmrstMwkYLk9w1vAYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SY5HvkCLqD8vHcea1F15HHQ7yBCaK0PbBRrrf6PIgdpks/1eZPdevZVwx4AiGkYBo
         Gb+u/CxuQgKxkWIgR9THNDgwOgBG9X86SDMEoVFxJhF5+FYaGqGUa2GuHpc5teRAam
         Kr7Maw2nqsaqUIw+BWCa4lCSywSnPo3/YUpwrC9Zr4d5sB9EwwRAWdxzUCeUt0GcZZ
         wVBdbvjv6/VxIjHl4NetIte1IDgelhr+BeOh4N0AivAAYPpEpFgjlh1VFqkOAD44pF
         Mvesz36W+xULU55Km+IWpzDhnO9CoCV6KMufKDe7R4MYCtYe2VSTQo4YYNCof9K7lC
         g5kgwCfEJInxQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Inki Dae <inki.dae@samsung.com>, Sasha Levin <sashal@kernel.org>,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@gmail.com, daniel@ffwll.ch, krzysztof.kozlowski@linaro.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 16/16] drm/exynos: fix a wrong error checking
Date:   Mon, 11 Dec 2023 09:00:40 -0500
Message-ID: <20231211140116.391986-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140116.391986-1-sashal@kernel.org>
References: <20231211140116.391986-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.203
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inki Dae <inki.dae@samsung.com>

[ Upstream commit 8d1b7809684c688005706125b804e1f9792d2b1b ]

Fix a wrong error checking in exynos_drm_dma.c module.

In the exynos_drm_register_dma function, both arm_iommu_create_mapping()
and iommu_get_domain_for_dev() functions are expected to return NULL as
an error.

However, the error checking is performed using the statement
if(IS_ERR(mapping)), which doesn't provide a suitable error value.
So check if 'mapping' is NULL, and if it is, return -ENODEV.

This issue[1] was reported by Dan.

Changelog v1:
- fix build warning.

[1] https://lore.kernel.org/all/33e52277-1349-472b-a55b-ab5c3462bfcf@moroto.mountain/

Reported-by : Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index bf33c3084cb41..6b4d6da3b1f4e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -108,18 +108,16 @@ int exynos_drm_register_dma(struct drm_device *drm, struct device *dev,
 		return 0;
 
 	if (!priv->mapping) {
-		void *mapping;
+		void *mapping = NULL;
 
 		if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
 			mapping = arm_iommu_create_mapping(&platform_bus_type,
 				EXYNOS_DEV_ADDR_START, EXYNOS_DEV_ADDR_SIZE);
 		else if (IS_ENABLED(CONFIG_IOMMU_DMA))
 			mapping = iommu_get_domain_for_dev(priv->dma_dev);
-		else
-			mapping = ERR_PTR(-ENODEV);
 
-		if (IS_ERR(mapping))
-			return PTR_ERR(mapping);
+		if (!mapping)
+			return -ENODEV;
 		priv->mapping = mapping;
 	}
 
-- 
2.42.0

