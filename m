Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947D7F4707
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjKVMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbjKVMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:54:49 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8813818E;
        Wed, 22 Nov 2023 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PJE4A
        /TtZytLMevB33ghaDNwTaatdKdnAe/8KBkrZZU=; b=Tp1SwVkUwPSUGC7v0osW7
        Rh21XKUJI/HaRgYsOjoR2Aap/XVsbFWaGYbaZMAogmVDIRGTSIXMM/y8v2RoJ4dN
        SR5g+RQ471J6amAPqaJf4KdySK7FbwCe3EKxpN1KsZ8fAwDZ+brg59GpMTGH6niO
        RrEgM9+j4wmS4URqDkv0A0=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wD3n5Pp+V1ldaBdAw--.53479S2;
        Wed, 22 Nov 2023 20:54:05 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 02/12] Revert "drm/rockchip: vop2: Use regcache_sync() to fix suspend/resume"
Date:   Wed, 22 Nov 2023 20:54:00 +0800
Message-Id: <20231122125400.3454430-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122125316.3454268-1-andyshrk@163.com>
References: <20231122125316.3454268-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n5Pp+V1ldaBdAw--.53479S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1rGr1xXF4xCFy7tr45trb_yoW8CF1rpF
        W7Aryjqr4IgF4jqw1kJFWUZFyYyrnrtayfCrn7G3WSvr13Krn2krn8GF15ZF98Ar1xur42
        yF97ta47CFW7uFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo4E_UUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBnBIwXlghlh74fQAAsU
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

