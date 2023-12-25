Return-Path: <linux-kernel+bounces-11084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E563281E11E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B0F1C21A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCDA524D5;
	Mon, 25 Dec 2023 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mq7Vgsxv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D84524C9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Edaz
	bBuWn+zR00jVC2IdNv8Gvt/eD6wDHkffcQ4WIU=; b=mq7VgsxvzC25fxBq8Bs4X
	EzQG6tcDcREDQJG6Y7Mna7g12xzFIn0TsvWpMpi6Kh85tFnYn2Kl5md1mOVUup6E
	mEC+O/8PrKlEr68W1fM/6mluL28XGGGH1MFLYRo2OEY8sk9M73QsLy5l3qmDjN8C
	IHbw04CeO0ZKbzlq559iOM=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wDHF0wJkYllJEGXGg--.64396S2;
	Mon, 25 Dec 2023 22:26:18 +0800 (CST)
From: chenguanxi11234@163.com
To: hanxu5@huaqin.corp-partner.google.com
Cc: cgel.zte@gmail.com,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	yang.guang5@zte.com.cn,
	jiang.xuexin@zte.com.cn,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next v2] drm/panel: Simplify with dev_err_probe()
Date: Mon, 25 Dec 2023 22:26:15 +0800
Message-Id: <3ac20d355b0b3ad3cedb87c8f4efa819a055624b.1702967834.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHF0wJkYllJEGXGg--.64396S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DZFW8CFy3Cr4ftr1DZFb_yoW8Cr1kpF
	4UJF9FvF98AFWS939xAF97AF1jya1xKF4YkFs2g397Aw17tr4xWr17GFy0vFW5tFyrXFW5
	JF1xXFy3ua4UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jM89_UUUUU=
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBzwVR+mV4G-HRcAABs2

From: Chen Haonan <chen.haonan2@zte.com.cn>

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


