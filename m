Return-Path: <linux-kernel+bounces-503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C781420E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277D71C21088
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D765BD28D;
	Fri, 15 Dec 2023 07:03:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61FD27A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VyWoQ7T_1702623454;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VyWoQ7T_1702623454)
          by smtp.aliyun-inc.com;
          Fri, 15 Dec 2023 14:57:45 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: hjc@rock-chips.com
Cc: heiko@sntech.de,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/rockchip: vop2: Remove the unused variable if_dclk_rate
Date: Fri, 15 Dec 2023 14:57:33 +0800
Message-Id: <20231215065733.48895-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable if_dclk_rate is not effectively used, so delete it.

drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:1688:16: warning: variable ‘if_dclk_rate’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7750
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 44508c2dd614..b4e7cddaf25a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1685,13 +1685,11 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 	unsigned long dclk_core_rate = v_pixclk >> 2;
 	unsigned long dclk_rate = v_pixclk;
 	unsigned long dclk_out_rate;
-	unsigned long if_dclk_rate;
 	unsigned long if_pixclk_rate;
 	int K = 1;
 
 	if (vop2_output_if_is_hdmi(id)) {
 		/*
-		 * K = 2: dclk_core = if_pixclk_rate > if_dclk_rate
 		 * K = 1: dclk_core = hdmie_edp_dclk > if_pixclk_rate
 		 */
 		if (output_mode == ROCKCHIP_OUT_MODE_YUV420) {
@@ -1700,10 +1698,8 @@ static unsigned long rk3588_calc_cru_cfg(struct vop2_video_port *vp, int id,
 		}
 
 		if_pixclk_rate = (dclk_core_rate << 1) / K;
-		if_dclk_rate = dclk_core_rate / K;
 		/*
 		 * *if_pixclk_div = dclk_rate / if_pixclk_rate;
-		 * *if_dclk_div = dclk_rate / if_dclk_rate;
 		 */
 		 *if_pixclk_div = 2;
 		 *if_dclk_div = 4;
-- 
2.20.1.7.g153144c


