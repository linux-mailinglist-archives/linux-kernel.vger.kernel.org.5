Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43579F8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 05:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjINDQa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 23:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjINDQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 23:16:18 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2F1BDD;
        Wed, 13 Sep 2023 20:16:13 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0119524E2D9;
        Thu, 14 Sep 2023 11:16:12 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 11:16:12 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 14 Sep
 2023 11:16:11 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        <bryan.odonoghue@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <jack.zhu@starfivetech.com>, <changhuang.liang@starfivetech.com>
Subject: [PATCH v9 8/8] media: staging: media: starfive: camss: Register devices
Date:   Thu, 14 Sep 2023 11:16:07 +0800
Message-ID: <20230914031607.34877-9-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914031607.34877-1-jack.zhu@starfivetech.com>
References: <20230914031607.34877-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register ISP sub-device and video devices for StarFive Camera
Subsystem.

Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 .../staging/media/starfive/camss/stf-camss.c  | 97 ++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-camss.c b/drivers/staging/media/starfive/camss/stf-camss.c
index 373467322885..b2e0f5b3c910 100644
--- a/drivers/staging/media/starfive/camss/stf-camss.c
+++ b/drivers/staging/media/starfive/camss/stf-camss.c
@@ -123,6 +123,85 @@ static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
 	return ret;
 }
 
+static int stfcamss_register_devs(struct stfcamss *stfcamss)
+{
+	struct stf_capture *cap_yuv = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+	int ret;
+
+	ret = stf_isp_register(isp_dev, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"failed to register stf isp%d entity: %d\n", 0, ret);
+		return ret;
+	}
+
+	ret = stf_capture_register(stfcamss, &stfcamss->v4l2_dev);
+	if (ret < 0) {
+		dev_err(stfcamss->dev,
+			"failed to register capture: %d\n", ret);
+		goto err_isp_unregister;
+	}
+
+	ret = media_create_pad_link(&isp_dev->subdev.entity, STF_ISP_PAD_SRC,
+				    &cap_yuv->video.vdev.entity, 0, 0);
+	if (ret)
+		goto err_cap_unregister;
+
+	cap_yuv->video.source_subdev = &isp_dev->subdev;
+
+	return ret;
+
+err_cap_unregister:
+	stf_capture_unregister(stfcamss);
+err_isp_unregister:
+	stf_isp_unregister(&stfcamss->isp_dev);
+
+	return ret;
+}
+
+static void stfcamss_unregister_devs(struct stfcamss *stfcamss)
+{
+	stf_isp_unregister(&stfcamss->isp_dev);
+	stf_capture_unregister(stfcamss);
+}
+
+static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
+					  struct v4l2_subdev *subdev,
+					  struct v4l2_async_connection *asc)
+{
+	struct stfcamss *stfcamss =
+		container_of(async, struct stfcamss, notifier);
+	struct stfcamss_async_subdev *csd =
+		container_of(asc, struct stfcamss_async_subdev, asd);
+	enum stf_port_num port = csd->port;
+	struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
+	struct stf_capture *cap_raw = &stfcamss->captures[STF_CAPTURE_RAW];
+	struct media_pad *pad;
+	int ret;
+
+	if (port == STF_PORT_CSI2RX) {
+		pad = &isp_dev->pads[STF_ISP_PAD_SINK];
+	} else {
+		dev_err(stfcamss->dev, "not support port %d\n", port);
+		return -EPERM;
+	}
+
+	ret = v4l2_create_fwnode_links_to_pad(subdev, pad, 0);
+	if (ret)
+		return ret;
+
+	ret = media_create_pad_link(&subdev->entity, 1,
+				    &cap_raw->video.vdev.entity, 0, 0);
+	if (ret)
+		return ret;
+
+	isp_dev->source_subdev = subdev;
+	cap_raw->video.source_subdev = subdev;
+
+	return 0;
+}
+
 static int stfcamss_subdev_notifier_complete(struct v4l2_async_notifier *ntf)
 {
 	struct stfcamss *stfcamss =
@@ -133,6 +212,7 @@ static int stfcamss_subdev_notifier_complete(struct v4l2_async_notifier *ntf)
 
 static const struct v4l2_async_notifier_operations
 stfcamss_subdev_notifier_ops = {
+	.bound = stfcamss_subdev_notifier_bound,
 	.complete = stfcamss_subdev_notifier_complete,
 };
 
@@ -217,6 +297,12 @@ static int stfcamss_probe(struct platform_device *pdev)
 		goto err_cleanup_notifier;
 	}
 
+	ret = stf_isp_init(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to init isp: %d\n", ret);
+		goto err_cleanup_notifier;
+	}
+
 	stfcamss_mc_init(pdev, stfcamss);
 
 	ret = v4l2_device_register(stfcamss->dev, &stfcamss->v4l2_dev);
@@ -231,6 +317,12 @@ static int stfcamss_probe(struct platform_device *pdev)
 		goto err_unregister_device;
 	}
 
+	ret = stfcamss_register_devs(stfcamss);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register subdevice: %d\n", ret);
+		goto err_unregister_media_dev;
+	}
+
 	pm_runtime_enable(dev);
 
 	stfcamss->notifier.ops = &stfcamss_subdev_notifier_ops;
@@ -239,11 +331,13 @@ static int stfcamss_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to register async subdev nodes: %d\n",
 			ret);
 		pm_runtime_disable(dev);
-		goto err_unregister_media_dev;
+		goto err_unregister_subdevs;
 	}
 
 	return 0;
 
+err_unregister_subdevs:
+	stfcamss_unregister_devs(stfcamss);
 err_unregister_media_dev:
 	media_device_unregister(&stfcamss->media_dev);
 err_unregister_device:
@@ -265,6 +359,7 @@ static int stfcamss_remove(struct platform_device *pdev)
 {
 	struct stfcamss *stfcamss = platform_get_drvdata(pdev);
 
+	stfcamss_unregister_devs(stfcamss);
 	v4l2_device_unregister(&stfcamss->v4l2_dev);
 	media_device_cleanup(&stfcamss->media_dev);
 	v4l2_async_nf_cleanup(&stfcamss->notifier);
-- 
2.34.1

