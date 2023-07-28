Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557AB7664AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjG1HC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjG1HC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:02:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA614198A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:02:25 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S57RII010707;
        Fri, 28 Jul 2023 07:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Z2g6bzyfpZCzCp33w3yLlCiXyUWfr6VgzHUl9tHSEqA=;
 b=GlZg2p840aVlKGM7VQByIx3w2CcTBnsGmgRBDj4gDg9sDoh9TqYLC2ggfOp7u85eQPWj
 Fd9wHhSmL0iC0GeqfJiuymMNuwP1Wrl4XNLzx2zUz8EA7kX0R7M5yXP+9iJoARr8U7a/
 qswCnfeJXebzV/m7UZLSfXZWkRGR25m7C3Mgi7/IwUW/V7WO8u9Qt7s7cU9+3SvzCziy
 dv7TJWmfGbeKXNEB0Q4IjtXxd0M6EjtzMO7bLI4cbsCW3BwPMp1voXVdaXDoLHVjtaDr
 i19f3A6w5FUbCUi4nDkDBOIU8KEbru7V8o2ybdtwLUbrHtzOE2YMBr9HnlRGj80C0MDL Cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3ufushnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:02:18 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S72BfK010198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:02:11 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 00:01:44 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC:     Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: [PATCH] virtio_mmio: add suspend and resume calls for virtio_mmio devices
Date:   Fri, 28 Jul 2023 12:31:27 +0530
Message-ID: <20230728070127.18452-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B3DUN0y8o7FizMQRk7MOcdUWt84lLKzo
X-Proofpoint-ORIG-GUID: B3DUN0y8o7FizMQRk7MOcdUWt84lLKzo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle suspend and resume calls for virtio mmio devices from
PM core. Expose these notifications to virtio drivers that can quiesce and
resume vq operations. Update virtio pm ops to handle freeze& restore and
suspend & resume callbacks separately.

Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
---
 drivers/virtio/virtio.c      | 112 +++++++++++++++++++++++++++++++++++
 drivers/virtio/virtio_mmio.c |  50 +++++++++++++++-
 include/linux/virtio.h       |  12 ++++
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 3893dc29eb26..c6f25a267600 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -551,6 +551,118 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend)
+		return drv->suspend(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume) {
+		ret = drv->resume(dev);
+		if (ret)
+			goto err;
+
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
+
+int virtio_device_suspend_late(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend_late)
+		return drv->suspend_late(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend_late);
+
+int virtio_device_resume_early(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume_early) {
+		ret = drv->resume_early(dev);
+		if (ret)
+			goto err;
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume_early);
+
+int virtio_device_suspend_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	virtio_config_disable(dev);
+
+	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+
+	if (drv && drv->suspend_noirq)
+		return drv->suspend_noirq(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend_noirq);
+
+int virtio_device_resume_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (drv && drv->resume_noirq) {
+		ret = drv->resume_noirq(dev);
+		if (ret)
+			goto err;
+		if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+			virtio_device_ready(dev);
+
+		virtio_config_enable(dev);
+	}
+
+	return 0;
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume_noirq);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index a46a4a29e929..9385c7e65da9 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -596,9 +596,57 @@ static int virtio_mmio_restore(struct device *dev)
 
 	return virtio_device_restore(&vm_dev->vdev);
 }
+static int virtio_mmio_suspend(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume(&vm_dev->vdev);
+}
+
+static int virtio_mmio_suspend_late(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend_late(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume_early(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume_early(&vm_dev->vdev);
+}
+
+static int virtio_mmio_suspend_noirq(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_suspend_noirq(&vm_dev->vdev);
+}
+
+static int virtio_mmio_resume_noirq(struct device *dev)
+{
+       struct virtio_mmio_device *vm_dev = dev_get_drvdata(dev);
+
+       return virtio_device_resume_noirq(&vm_dev->vdev);
+}
 
 static const struct dev_pm_ops virtio_mmio_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
+       .freeze         = virtio_mmio_freeze,
+       .restore        = virtio_mmio_restore,
+       .suspend        = virtio_mmio_suspend,
+       .resume         = virtio_mmio_resume,
+       .suspend_late   = virtio_mmio_suspend_late,
+       .resume_early   = virtio_mmio_resume_early,
+       .suspend_noirq  = virtio_mmio_suspend_noirq,
+       .resume_noirq   = virtio_mmio_resume_noirq,
 };
 #endif
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index de6041deee37..e88b321408e9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -145,6 +145,12 @@ void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
+int virtio_device_suspend(struct virtio_device *dev);
+int virtio_device_resume(struct virtio_device *dev);
+int virtio_device_suspend_late(struct virtio_device *dev);
+int virtio_device_resume_early(struct virtio_device *dev);
+int virtio_device_suspend_noirq(struct virtio_device *dev);
+int virtio_device_resume_noirq(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
@@ -187,6 +193,12 @@ struct virtio_driver {
 #ifdef CONFIG_PM
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	int (*suspend)(struct virtio_device *dev);
+	int (*resume)(struct virtio_device *dev);
+	int (*suspend_late)(struct virtio_device *dev);
+	int (*resume_early)(struct virtio_device *dev);
+	int (*suspend_noirq)(struct virtio_device *dev);
+	int (*resume_noirq)(struct virtio_device *dev);
 #endif
 };
 

base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
-- 
2.17.1

