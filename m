Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B580CC14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbjLKN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjLKNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:55:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1C2D75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BAEC433C7;
        Mon, 11 Dec 2023 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302832;
        bh=Qejs/lny/vjMi846PM8b8cKoCxx5siqz5ArARQonAOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZY1IgQJJvN9HJfRoX1nPou/PW8/hGjDvg7D4tuvS22XncNPn3aOOQt/1+iYgy9Gj
         Lu+DI0oL/PrT4gu4GliieSojmL0jbXkcMXI8m0nMkqx/N31azwbEzTnZfsumIvwC6r
         ol4EinYpvUxl+WdaV73E0thBg1N1eo5Pb5K97jn+/aSVkSw+yTjAEzSe1W2dKPfNo/
         yrNfeld7zbP4SDEcTnEC8s1+Iw9hJbNaV2bI9ZqO+entDu5NSrBgdylzgVVSjr0d9B
         ue9GVSkI0GlugRR8caegv8FsoaZsA0v3ADcYkbyUyL6Q3eOLTYW/blWXHsC/BAKXge
         S3QyyYyD7SBsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiang Yang <xiangyang3@huawei.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 41/47] drm/exynos: fix a potential error pointer dereference
Date:   Mon, 11 Dec 2023 08:50:42 -0500
Message-ID: <20231211135147.380223-41-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index f3aaa4ea3e682..dd9903eab563e 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1861,6 +1861,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 
 	crtc = exynos_drm_crtc_get_by_type(drm_dev, EXYNOS_DISPLAY_TYPE_HDMI);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
 	crtc->pipe_clk = &hdata->phy_clk;
 
 	ret = hdmi_create_connector(encoder);
-- 
2.42.0

