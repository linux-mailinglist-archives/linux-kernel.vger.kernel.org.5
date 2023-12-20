Return-Path: <linux-kernel+bounces-6301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F48196F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2125F1F25E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE28BFB;
	Wed, 20 Dec 2023 02:49:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E98827
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Svygc57qqz8XrRF;
	Wed, 20 Dec 2023 10:49:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 3BK2mqt7068198;
	Wed, 20 Dec 2023 10:48:52 +0800 (+08)
	(envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Wed, 20 Dec 2023 10:48:53 +0800 (CST)
Date: Wed, 20 Dec 2023 10:48:53 +0800 (CST)
X-Zmail-TransId: 2afa65825615ffffffffd39-0a04b
X-Mailer: Zmail v1.0
Message-ID: <202312201048538333616@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.guang5@zte.com.cn>
To: <hanxu5@huaqin.corp-partner.google.com>
Cc: <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>, <cgel.zte@gmail.com>,
        <neil.armstrong@linaro.org>, <quic_jesszhan@quicinc.com>,
        <sam@ravnborg.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9wYW5lbDogU2ltcGxpZnkgd2l0aCBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 3BK2mqt7068198
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6582561C.001/4Svygc57qqz8XrRF

From: Yang Guang <yang.guang5@zte.com.cn>

dev_err_probe() can check if the error code is -EPROBE_DEFER 
and can return the error code, replacing dev_err() with it 
simplifies the code.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/gpu/drm/panel/panel-boe-himax8279d.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 11b64acbe8a9..e225840b0d67 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -854,26 +854,20 @@ static int panel_add(struct panel_info *pinfo)

 	pinfo->pp18_gpio = devm_gpiod_get(dev, "pp18", GPIOD_OUT_HIGH);
 	if (IS_ERR(pinfo->pp18_gpio)) {
-		ret = PTR_ERR(pinfo->pp18_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pp18 gpio: %d\n", ret);
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(pinfo->pp18_gpio),
+							 "failed to get pp18 gpio\n");
 	}

 	pinfo->pp33_gpio = devm_gpiod_get(dev, "pp33", GPIOD_OUT_HIGH);
 	if (IS_ERR(pinfo->pp33_gpio)) {
-		ret = PTR_ERR(pinfo->pp33_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pp33 gpio: %d\n", ret);
-		return ret;
+		return	dev_err_probe(dev, PTR_ERR(pinfo->pp33_gpio),
+							 "failed to get pp33 gpio\n");
 	}

 	pinfo->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(pinfo->enable_gpio)) {
-		ret = PTR_ERR(pinfo->enable_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get enable gpio: %d\n", ret);
-		return ret;
+		return	dev_err_probe(dev, PTR_ERR(pinfo->enable_gpio),
+						 "failed to get enable gpio\n");
 	}

 	drm_panel_init(&pinfo->base, dev, &panel_funcs,
-- 
2.25.1

