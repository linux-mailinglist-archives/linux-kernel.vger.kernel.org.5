Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFEE808261
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjLGIBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjLGIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:01:43 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A7AA10CF;
        Thu,  7 Dec 2023 00:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zb21F
        grwTHHIjSU2lLqUEQQ7s329de26aUDP8GoQ+6A=; b=kzoUkzqceLopPCcYi//E7
        FZqZMZqU7rFswtGmR6ePN+wpVjclKIsaP1mzN0JGVK74OJ9q2osJobEPh+V8RqGP
        3uqTv0FtKHrAIgodl79m4kJX8RSk1oB+JPaHQxEkUmwzefG0+uhfRdA52ecI2auu
        d4zdg9KrIASxN1eiGtBL8E=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnr0uee3FlXgKlEw--.44744S2;
        Thu, 07 Dec 2023 16:00:33 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v4 05/17] drm/rockchip: vop2: Add write mask for VP config done
Date:   Thu,  7 Dec 2023 16:00:29 +0800
Message-Id: <20231207080029.652110-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207075906.651771-1-andyshrk@163.com>
References: <20231207075906.651771-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnr0uee3FlXgKlEw--.44744S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rKw17GrW5WF13XF4fKrg_yoW8Ar1xpF
        WrAay5urs2kFsFgr4qkFy5Zr1aya9rAa92yr97Kw13Xas0qr1DZFn09F1jyr98JFWxZr1a
        ywsrAryrGF4jvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSzuXUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAo-XmVOA0YD-wAAsR
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

The write mask bit is used to make sure when writing
config done bit for one VP will not overwrite the other.

Unfortunately, the write mask bit is missing on
rk3566/8, that means when we write to these bits,
it will not take any effect.

We need this to make the vop work properly after
rk3566/8 variants.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v3)

Changes in v3:
- split from the vop2 driver patch

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a019cc9bbd54..25c1f33c5622 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -268,12 +268,23 @@ static bool vop2_cluster_window(const struct vop2_win *win)
 	return win->data->feature & WIN_FEATURE_CLUSTER;
 }
 
+/*
+ * Note:
+ * The write mask function is missing on rk3566/8, write
+ * to this bit has no effect, for the other soc(rk3588 and
+ * the following...), this function works well.
+ *
+ * GLB_CFG_DONE_EN doesn't have a write mask bit
+ *
+ */
 static void vop2_cfg_done(struct vop2_video_port *vp)
 {
 	struct vop2 *vop2 = vp->vop2;
+	u32 val = RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN;
+
+	val |= BIT(vp->id) | (BIT(vp->id) << 16);
 
-	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE,
-			BIT(vp->id) | RK3568_REG_CFG_DONE__GLB_CFG_DONE_EN);
+	regmap_set_bits(vop2->map, RK3568_REG_CFG_DONE, val);
 }
 
 static void vop2_win_disable(struct vop2_win *win)
-- 
2.34.1

