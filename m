Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777967FEF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjK3Mi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjK3Mi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:38:57 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84695D4A;
        Thu, 30 Nov 2023 04:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=c7kjH
        jIQ4/nlmiPUxBorZmmivgfaJAOI5Gw9Jj5OowE=; b=RiSeGZ6inEhAZK1tNi/S7
        EOhH5l6KUvbRJ+K1axbtXAhb+AELEbP/J/WfNEHxqbyc9GMnFPOl1J/o61dSi8ns
        ClndHaNkwHwqljU/cj/Q7CoAexqhPYD0q0/VLKcHSU8Bc8Wvf1EXl6cmvJ1yjdER
        ITdB8WVNXffCpG446dw9TE=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wDHXlS0fmhl4hTXAQ--.47878S2;
        Thu, 30 Nov 2023 20:23:20 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 04/14] drm/rockchip: vop2: clear afbc en and transform bit for cluster window at linear mode
Date:   Thu, 30 Nov 2023 20:23:15 +0800
Message-Id: <20231130122315.12954-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130122001.12474-1-andyshrk@163.com>
References: <20231130122001.12474-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHXlS0fmhl4hTXAQ--.47878S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW3WF1DuFyrWryfXrWkZwb_yoW8Gr1kpr
        W5AFWqqr4xK3yqqa1DJF9xZFZYk3ZFkayxWrZ7JwnFgFWUKa4kG3Z0kryDJrWUJ3WagF48
        trn3JrW7ZFWYvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSwZ7UUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqBs4XmVOAquRqAAAsu
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

The enable bit and transform offset of cluster windows should be
cleared when it work at linear mode, or we may have a iommu fault
issue on rk3588 which cluster windows switch between afbc and linear
mode.

As the cluster windows of rk3568 only supports afbc format
so is therefore not affected.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 639dfebc6bd1..a019cc9bbd54 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1312,6 +1312,11 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		vop2_win_write(win, VOP2_WIN_AFBC_ROTATE_270, rotate_270);
 		vop2_win_write(win, VOP2_WIN_AFBC_ROTATE_90, rotate_90);
 	} else {
+		if (vop2_cluster_window(win)) {
+			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 0);
+			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, 0);
+		}
+
 		vop2_win_write(win, VOP2_WIN_YRGB_VIR, DIV_ROUND_UP(fb->pitches[0], 4));
 	}
 
-- 
2.34.1

