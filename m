Return-Path: <linux-kernel+bounces-15639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F66822F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CF1C2354B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371211A590;
	Wed,  3 Jan 2024 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jw9L9SfN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B811A58B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Now9Y
	nDkaSsHEHrDFSFBcDE8yy3D0lUh+jYhNHjxB6g=; b=Jw9L9SfNrJBd4s6kWTjbX
	G/ntiwm+fC8VvvhmuPERdxVtxQK8bkSWqPrNVs5hF20pSDgh3d/uAbyBuKQjvJ34
	OekV8+HhsDiGuef0nqAG7WqQtNxod2BR87QxgShcCfOaUssL6//mu6HPnn4OBcGn
	Qg2L+oOycNOqJSZRvVMHCw=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wDnL+uEbJVlwe6uAA--.29037S2;
	Wed, 03 Jan 2024 22:17:42 +0800 (CST)
From: chenguanxi11234@163.com
To: neil.armstrong@linaro.org
Cc: cgel.zte@gmail.com,
	yang.guang5@zte.com.cn,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next] drm/panel: samsung: Simplify with dev_err_probe()
Date: Wed,  3 Jan 2024 22:17:38 +0800
Message-Id: <061ed94a003362bb7d7e9d3e4d38358c5b91c8a3.1704186827.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL+uEbJVlwe6uAA--.29037S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1DJF47Xw4fXw18AF43ZFb_yoWkAFX_C3
	45u3WfuwsrGF4Igr17Aa17ArWIka9Y9F4kuwnYk3W7tw1DG3W3JFykJFyDJw17WF47uF90
	y3WfXFWFvF4fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8AWrJUUUUU==
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/1tbiQAlY+mVOAw9xcAABsM

From: Chen Haonan <chen.haonan2@zte.com.cn>

dev_err_probe() can check if the error code is -EPROBE_DEFER 
and can return the error code, replacing dev_err() with it 
simplifies the code.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 79f611963c61..f4103e762b53 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -194,10 +194,8 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 	s6->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						GPIOD_OUT_HIGH);
 	if (IS_ERR(s6->reset_gpio)) {
-		ret = PTR_ERR(s6->reset_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request GPIO (%d)\n", ret);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(s6->reset_gpio),
+							 "failed to request GPIO\n");
 	}
 
 	drm_panel_init(&s6->panel, dev, &s6d16d0_drm_funcs,
-- 
2.25.1


