Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53838808251
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378026AbjLGIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjLGIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:00:54 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31318B2;
        Thu,  7 Dec 2023 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pekM+
        FGyDCtPmb0jWNTPyTz93vTz66hJl88mKNFM3+k=; b=J8JRw9ln8ws6z8vKQ/tx0
        JtIFggwwsjn6fZSlESWSWk8jh3H/8AOQhZ0OLNInm/KTcvB4y++3u1nswgDrTsDj
        2ylbuPbD91EQcBImI/NgUkJSLYZKHWc8x1R3yGDOt6yWbTfG4fVu0cr/Mnly6VdB
        ieV+C+5mgFbtjSH4u8zjqM=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDX_1p4e3FlH_C_DA--.43713S2;
        Thu, 07 Dec 2023 15:59:55 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 02/17] Revert "drm/rockchip: vop2: Use regcache_sync() to fix suspend/resume"
Date:   Thu,  7 Dec 2023 15:59:50 +0800
Message-Id: <20231207075950.651931-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207075906.651771-1-andyshrk@163.com>
References: <20231207075906.651771-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX_1p4e3FlH_C_DA--.43713S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1rGr1xXF4xCFy7tr45trb_yoW8Cw4UpF
        W7AryYqr4IgFWjqw1kJFWUZFWYyrsFyayfCrn7G3WS9rnxKrnakrn8GF15ZFn8Ar1xur42
        yFn7ta47CFW7uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo4E_UUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEB0-XmVOA0Wh6AAAsI
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

This reverts commit b63a553e8f5aa6574eeb535a551817a93c426d8c.

regcache_sync will try to reload the configuration in regcache to
hardware, but the registers of 4 Cluster windows and Esmart1/2/3 on
the upcoming rk3588 can not be set successfully before internal PD
power on.

Also it's better to keep the hardware register as it is before we really
enable it.

So let's revert this version, and keep the first version:
commit afa965a45e01 ("drm/rockchip: vop2: fix suspend/resume")

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 312da5783362..57784d0a22a6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -217,6 +217,8 @@ struct vop2 {
 	struct vop2_win win[];
 };
 
+static const struct regmap_config vop2_regmap_config;
+
 static struct vop2_video_port *to_vop2_video_port(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct vop2_video_port, crtc);
@@ -883,7 +885,11 @@ static void vop2_enable(struct vop2 *vop2)
 		return;
 	}
 
-	regcache_sync(vop2->map);
+	ret = regmap_reinit_cache(vop2->map, &vop2_regmap_config);
+	if (ret) {
+		drm_err(vop2->drm, "failed to reinit cache: %d\n", ret);
+		return;
+	}
 
 	if (vop2->data->soc_id == 3566)
 		vop2_writel(vop2, RK3568_OTP_WIN_EN, 1);
@@ -913,8 +919,6 @@ static void vop2_disable(struct vop2 *vop2)
 
 	pm_runtime_put_sync(vop2->dev);
 
-	regcache_mark_dirty(vop2->map);
-
 	clk_disable_unprepare(vop2->aclk);
 	clk_disable_unprepare(vop2->hclk);
 }
-- 
2.34.1

