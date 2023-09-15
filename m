Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F777A14EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjIOEz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjIOEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:55:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432AD2723
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwXrJdhOkIkqVmXFyxCiVwcoE8ZAWDiH1bkF/FLl8YebQq3qostvzshxag8MADxNlYuvWU2UfHbPJRKFullYvllPFQTwS7c/oU/OYhOCa4Q+4LKSInUPoGyLMvh5MjdWJ++9e8dJP07TsiTPbd2oA+Sla89zNQkqkZCZJebb8il1zvek3yOVPlvJfaoLMVghsp8Q2jVEzahOqlSLX7mYONBHg3NrK8hH85Res6myNXDcj4sgU9WMMf0g6PtIP1ULRtRdbyc+bWdgWx76m2KAcKrCbt+oAeB6kIHjWsfN1g6ulgSWn+JKjrGrn59HlGUO8bVrOcIfBZzcJSpsmDpkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nebA7Ev9hlCgPI8GGx1l9HRcwFl+MEMWgnueVmIvbOU=;
 b=j05/XSZJmqcGH4EiT+4WfVkAnQCdcTFmYLEUUCTJdcI7VJoVMSEkFhEWx8YxgozvmChAhudskuwe/UhMndayKLPiCWCUxKEDEka3OhzP1S1LBx9KaAbXqnMmfPAxMQYEvTOkOuKCTwQWA6TZql2XLNFqjzpwD+HWpLD83TgN0FgLoHhG38bm1Bw2EIPUOOqFm0555bObiJjpHN24xgRV/o1bKpgZGonSyYnOK4Zc3Sty92CZ4pcxu9XdhYUFmCu7jO03+2LWNtTGyuue/3rxsU/AJcm1pVKGyOI3Ltjw/nbAocY/r4mLu4MFMOApsuf8vMhOStpF2aawfvFAWVTF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nebA7Ev9hlCgPI8GGx1l9HRcwFl+MEMWgnueVmIvbOU=;
 b=tpghMAsoDSKHusRqA2nbgggztDbJ1I/VRPn2GintkCLA+ifWNVHDSUi1B7qWHzbqjdHQPm9NFdWRwuoILMMGMdtXoHUqmtDXO7NulIsPBNCOuMVuU8nw450F5rIsY6TNkybE3t5E7O31C9JqHxSNUjqfpE/gPBOQHtK/Kvuvacg=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 04:55:08 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::a7) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 04:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 04:55:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 23:55:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 21:55:06 -0700
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 23:55:04 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <alex.williamson@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Shubham Rohila <shubham.rohila@amd.com>
Subject: [PATCH v8 3/3] vfio-cdx: add bus mastering device feature support
Date:   Fri, 15 Sep 2023 10:24:23 +0530
Message-ID: <20230915045423.31630-3-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915045423.31630-1-nipun.gupta@amd.com>
References: <20230915045423.31630-1-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebdf625-b511-4747-8fed-08dbb5a7ef59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wWXg4nLMf0rnkQdq2b1IFWTcN2eOMtoaCv88138VS2zFrBJ8B0eFZWD5ye2k9Q1/njBcBTXfOKJKWjDFF7ADLlsALHWfUgvnZSnfuNo2mLRKYinRdPvBau77JgKfSDD0SHr8xLDiws0zHfWiuCnDOhAeqBO/fIfPX0f2+2IxTEq4qkTXremyB3KCoVTGyra0uK2EyF5XUb/OhsFUQoCgWCEldaBTwobiW7a/6yPt2qZL0LyW28ZDA4rHtDMQlmuyedInBgvG6HTE68JD0THZv3z3+d4w1h+OWD5A971G6KePlDUGjmPhRwvHTBDXdUWrIfu5kEP7qH9JD34Gk2/LSdfNTFyMcYs1LTMkStAU7JPQX9uolm4Zhcl/gYTbZB5tgqg5u3y/Kwq0PuIrb7k60Y9kHPC3PRAP42+9v99HDahT1LUZ57C34iLYd2V4n95GoXitCMStFgOgbVCbqxUTT3Qc1eZMzjpjZuqNV6FKlcj1IbF7rTBL8D5NSwEzwBEzKGn06jGH2U1uVxy0IKp8f8+L1ToMKeOTUoxl4folmoZH2a1qk6tuWZF3BMowm5ASwoN6E2NzCRBKvT3cD6Njc/d2kdkhCS2I9Piy1rBXCQKGutHJocYLxpD5BFehpO/oNq0TaDLKXYl8IMYM5ldpqmFmnpmGMYvvRXBGpWnzo3DjLFQDqycOYGjMUqRVsw9h3ElyaDJxWjWQYFTBs1UKmmM5m3U8GQMH2Q84g9mtZ+BKBSeRCRfyBaRKTrAIc5OhaLrrQBuM/7iw5IdAKMufQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(110136005)(356005)(36756003)(6666004)(26005)(478600001)(83380400001)(2906002)(336012)(426003)(70586007)(1076003)(44832011)(70206006)(41300700001)(8676002)(2616005)(316002)(4326008)(40460700003)(5660300002)(8936002)(54906003)(36860700001)(86362001)(40480700001)(47076005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:55:08.1128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebdf625-b511-4747-8fed-08dbb5a7ef59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Bus master enable and disable on VFIO-CDX devices using
VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.

Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---

Changes v7->v8:
- None

Changes v6->v7:
- Add check for BME in open, thus resulting in correct response
  in feature probe.
- Set vdev_regions to NULL in case of error in vfio device open.

Changes v5->v6:
- Called CDX device reset at cdx_open_device()

Changes v4->v5:
- Use device feature IOCTL instead of adding a new VFIO IOCTL
  for bus master feature.

Changes in v4:
- This patch is newly added which uses cdx_set_master() and
  cdx_clear_master() APIs.

 drivers/vfio/cdx/main.c    | 57 +++++++++++++++++++++++++++++++++++++-
 drivers/vfio/cdx/private.h |  2 ++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index c376a69d2db2..53ed8e6c499f 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct vfio_cdx_device, vdev);
 	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
 	int count = cdx_dev->res_count;
-	int i;
+	int i, ret;
 
 	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
 				GFP_KERNEL_ACCOUNT);
@@ -39,6 +39,17 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
 			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
 	}
+	ret = cdx_dev_reset(core_vdev->dev);
+	if (ret) {
+		kfree(vdev->regions);
+		vdev->regions = NULL;
+		return ret;
+	}
+	ret = cdx_clear_master(cdx_dev);
+	if (ret)
+		vdev->flags &= ~BME_SUPPORT;
+	else
+		vdev->flags |= BME_SUPPORT;
 
 	return 0;
 }
@@ -52,6 +63,49 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
 	cdx_dev_reset(core_vdev->dev);
 }
 
+static int vfio_cdx_bm_ctrl(struct vfio_device *core_vdev, u32 flags,
+			    void __user *arg, size_t argsz)
+{
+	size_t minsz =
+		offsetofend(struct vfio_device_feature_bus_master, op);
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
+	struct vfio_device_feature_bus_master ops;
+	int ret;
+
+	if (!vdev->flags & BME_SUPPORT)
+		return -ENOTTY;
+
+	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(ops));
+	if (ret != 1)
+		return ret;
+
+	if (copy_from_user(&ops, arg, minsz))
+		return -EFAULT;
+
+	switch (ops.op) {
+	case VFIO_DEVICE_FEATURE_CLEAR_MASTER:
+		return cdx_clear_master(cdx_dev);
+	case VFIO_DEVICE_FEATURE_SET_MASTER:
+		return cdx_set_master(cdx_dev);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vfio_cdx_ioctl_feature(struct vfio_device *device, u32 flags,
+				  void __user *arg, size_t argsz)
+{
+	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
+	case VFIO_DEVICE_FEATURE_BUS_MASTER:
+		return vfio_cdx_bm_ctrl(device, flags, arg, argsz);
+	default:
+		return -ENOTTY;
+	}
+}
+
 static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
 				   struct vfio_device_info __user *arg)
 {
@@ -169,6 +223,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
+	.device_feature = vfio_cdx_ioctl_feature,
 	.mmap		= vfio_cdx_mmap,
 	.bind_iommufd	= vfio_iommufd_physical_bind,
 	.unbind_iommufd	= vfio_iommufd_physical_unbind,
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index 8bdc117ea88e..8e9d25913728 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -23,6 +23,8 @@ struct vfio_cdx_region {
 struct vfio_cdx_device {
 	struct vfio_device	vdev;
 	struct vfio_cdx_region	*regions;
+	u32			flags;
+#define BME_SUPPORT BIT(0)
 };
 
 #endif /* VFIO_CDX_PRIVATE_H */
-- 
2.17.1

