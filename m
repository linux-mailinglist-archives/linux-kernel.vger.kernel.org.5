Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5969980CCEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344221AbjLKOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbjLKOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:04:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286035BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:02:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB06C433C8;
        Mon, 11 Dec 2023 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303367;
        bh=X8BcZbwp3MScYiolNRocaQ2haYm8pGOwTNtJJ9H0s74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mvTDGt/6NnjDcxFsBAYyhOkqoyWSBJdEseHtngKzQqkHgVpgIwmXAVrdcU9Plpbqr
         Ce61BlEkrTRbZrVaWBcm5A28fOfAX1TEM1I5phaCb3pL2o1FTX1XF0mTfvE4n7xslG
         pXH2u+/zpJkQEKyRzkx26DHqzsoI2fox79bawGZO2INLJpKTJ8slrwh77CwTDGQtTx
         MSkfAPSL5lNf8sn7Wlc6J65lgG9+qnxkRaOjb6qnhKuVEAGPkN019VFSk0tPwYQM0z
         Mx2/deASbkiNiBBzRVanplU1QzE0g/VzQPao0gaJPaIZxnc+MuCqtNxi1I8JKtYS1L
         5Ruphe1sH7teA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Yang <xiangyang3@huawei.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/12] drm/exynos: fix a potential error pointer dereference
Date:   Mon, 11 Dec 2023 09:02:04 -0500
Message-ID: <20231211140219.392379-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211140219.392379-1-sashal@kernel.org>
References: <20231211140219.392379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.263
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

From: Xiang Yang <xiangyang3@huawei.com>

[ Upstream commit 73bf1c9ae6c054c53b8e84452c5e46f86dd28246 ]

Smatch reports the warning below:
drivers/gpu/drm/exynos/exynos_hdmi.c:1864 hdmi_bind()
error: 'crtc' dereferencing possible ERR_PTR()

The return value of exynos_drm_crtc_get_by_type maybe ERR_PTR(-ENODEV),
which can not be used directly. Fix this by checking the return value
before using it.

Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 0073a2b3b80a2..93b2af4936d0e 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1850,6 +1850,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	crtc = exynos_drm_crtc_get_by_type(drm_dev, EXYNOS_DISPLAY_TYPE_HDMI);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
 	crtc->pipe_clk = &hdata->phy_clk;
 
 	ret = hdmi_create_connector(encoder);
-- 
2.42.0

