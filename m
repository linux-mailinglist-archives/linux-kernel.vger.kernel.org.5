Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED2F7F3DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKVFoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjKVFoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:44:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A918E;
        Tue, 21 Nov 2023 21:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVPMRjJLD/Wqsn9UJoZvQd4CsPURH6s2v/JYZT0X1gOJo6H3NRQN4sLPN5L8zAdnqG/fOo5fambGw8WjCCPWM8jh4ud72hWOZlRQr+MiMpdb9i2XIgGbGA1PTXCLiBZq73ya1y6vjA2OrUiBK6/iVi4GOwMpYNnf5F5a5s6r2Fckt6savucLa6HKe8Kaj7JTbdZn87zu5VjzcdGdNXbxHpCGWN5PV88Xco0zwepM8H6NOxXUYzrLdt1E8ygUbSYMfLasgYARLQ4SKU0pt/dvnepbY2bLT3WxWZ4JFqOVzkiPLsrOjzvdwauJneHH0nITM9kkuPGB4bHb/OjLZ0KKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGFLKM4m7ZOhTuGsMykKETOSn3f9gwPUwUfSCjeIHvU=;
 b=WFyaqf2EWJcM/Km7mQalCM8UwRdtzq5c4GelfXUb8l5di7Rx/qRpf+PSJL3kZQpv83GkSRYG3q3h6SSfJODTWzCQtcUfkw36HRFEGnc1dqcMU/EKu746LW6lbsklzBMUpAAfUybw+0IOA16vbPAS7uSYS2xYCI7OcPqU20JgMhjRPhaeQD5I2JhN8oBqbiyKp3yXLP/AcLV1SNxHHA7vf18N68U48rkaJowvAHuBgY+5FOxpLuMq8fj8Mejvb2+AfTygN0imsoyRimxi/OEEeMyCI41BqDhjEpjZo7MSls6V9bvC3J1uY4avCQrzMAmGGQZc6J4AeimZzL1RD95oYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGFLKM4m7ZOhTuGsMykKETOSn3f9gwPUwUfSCjeIHvU=;
 b=uZeuSvxYdsyy78QN4WXSEopwR9eOIY42GdF3M+e85aGMwcYVcHjGbMTMEaH8V5YmdhBlf+QW3rBVvownL1lJ8AePW8IsdCVK0IhlsDDRgG8e/Y+LSnN1024RqfRac86mUzav+Jp42FsmmUUpoU4ETi9O0kg3wi6LwG7aak6UhHs=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 05:44:14 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::cd) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 05:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 05:44:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:44:13 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <nava.kishore.manne@amd.com>,
        <dhaval.r.shah@amd.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 2/3] drivers: fpga: Add user-key encrypted FPGA Image loading support
Date:   Wed, 22 Nov 2023 11:14:03 +0530
Message-ID: <20231122054404.3764288-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da67252-d6c9-4f13-aded-08dbeb1e0fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5gljhnLDpn/bfZlDgPy46PrC4Vo2hoS6NjMQCnovBgdy5fy9UxzO5ZQkeAVidfR42ODaFx7cr9f0et9/hI1OeDezshEn+R+BJ0U2rhHBczCgfwux3UUNmVlIpUs7jfE7OpyXuutG7R51cQc7OP1mP/CZhYRRvmf1f4LbCI798+t7mytYlddf+BV6Tqcn2h6HKAthZ1vJ4kk+7AnPFS4rZpiQhWsrobrT8KBu+Q46VTkEtICR81oYERP7oF2EeGA4/zJxg/n90cMLTnFNFhEloGDXU2y7N5vNeEyNhlMtstE0eZiFg0PriNUt/kmn4vQFHpriYsQEpMAdoF6NARnIUkLb18iDH1bTG32Wzf0T6dtmO4KchfPT8aogtCyl3ZYv8LjqfrRihcaFJDvEOGzT76A/mYbbZzmEcp5sAppmsiRimIhiL8vS8/OV6PG7nZKX+NXsVi5f9PsULh9qQD3V3z1SnfyY2uFyCxr4oeg9C0zphlxo2WS1YzClXHXfQosYH0JmnG/hYnsF5wpoOT5uSmvrMmt+L9PIcd9l+We2vhTjn7FQG3rINl1iKpg176Q8Wg9NO6e7Rt3fiuam2piFUoWIRxPNUdZNxPRAGkFQIsJZq+g6HOMDsFYX9avwdgjChQ6ESIZRzClsvh3H/9Blk/TyedTe6mJoQZeBlvUEwa6l/0V4VuOBlbfWTmI/Nl/bdZx0mXUFGwfq+pCYA6/lIK2Kk7VconMvtydNZiH1NGDLkVBF7b36kP4z63Bs6pTuTs/1cfG5OZU6U/64aE0IKDt6zJWOHVaNYytV8nI/T1lkJlXF5jM0qgA3b7o7jO9ELIKKXnKg+FTBUFFi+arbitn/RuGEQfD6+JM+W6CthAPBt54Q3kMW0yooVVIvyhX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230273577357003)(230173577357003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(46966006)(36840700001)(40470700004)(356005)(83380400001)(40480700001)(47076005)(478600001)(81166007)(36860700001)(26005)(6666004)(16526019)(1076003)(426003)(82740400003)(336012)(2616005)(316002)(70206006)(5660300002)(70586007)(110136005)(86362001)(7416002)(2906002)(921008)(103116003)(41300700001)(8936002)(8676002)(40460700003)(36756003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 05:44:14.6454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da67252-d6c9-4f13-aded-08dbeb1e0fa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds parse_aes_key() callback to fpga_manager_ops, It will read the
AES key from firmware to support user-key encrypted bitstream loading.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/fpga/fpga-mgr.c       | 86 ++++++++++++++++++++++++++++++++---
 drivers/fpga/of-fpga-region.c | 10 ++++
 include/linux/fpga/fpga-mgr.h |  8 ++++
 3 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..c8e20e8f4b6f 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -83,6 +83,15 @@ static inline int fpga_mgr_parse_header(struct fpga_manager *mgr,
 	return 0;
 }
 
+static inline int fpga_mgr_parse_aes_key(struct fpga_manager *mgr,
+					 struct fpga_image_info *info,
+					 const char *buf, size_t count)
+{
+	if (mgr->mops->parse_aes_key)
+		return mgr->mops->parse_aes_key(mgr, info, buf, count);
+	return 0;
+}
+
 static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
 				      struct fpga_image_info *info,
 				      const char *buf, size_t count)
@@ -559,6 +568,43 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 	return ret;
 }
 
+/**
+ * fpga_mgr_get_aes_key - request aes key form the firmware class
+ * @mgr:        fpga manager
+ * @info:       fpga image specific information
+ * @image_name: name of image file on the aes key firmware search path
+ *
+ *
+ * Request an aes key image using the firmware class, then Step the low level
+ * fpga manager through the device-specific steps. Update the state before each
+ * step to provide info on what step failed if there is a failure.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int fpga_mgr_get_aes_key(struct fpga_manager *mgr,
+				struct fpga_image_info *info,
+				const char *image_name,
+				const struct firmware *fw)
+{
+	struct device *dev = &mgr->dev;
+	int ret;
+
+	dev_info(dev, "Get Aes-key: %s to %s\n", image_name, mgr->name);
+
+	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
+
+	ret = request_firmware(&fw, image_name, dev);
+	if (ret) {
+		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
+		dev_err(dev, "Error requesting firmware %s\n", image_name);
+		return ret;
+	}
+
+	ret = fpga_mgr_parse_aes_key(mgr, info, fw->data, fw->size);
+
+	return ret;
+}
+
 /**
  * fpga_mgr_load - load FPGA from scatter/gather table, buffer, or firmware
  * @mgr:	fpga manager
@@ -571,15 +617,41 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	const struct firmware *fw;
+	int ret;
+
 	info->header_size = mgr->mops->initial_header_size;
 
-	if (info->sgt)
-		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
-	if (info->buf && info->count)
-		return fpga_mgr_buf_load(mgr, info, info->buf, info->count);
-	if (info->firmware_name)
-		return fpga_mgr_firmware_load(mgr, info, info->firmware_name);
-	return -EINVAL;
+	if (info->encrypted_key_name) {
+		ret = fpga_mgr_get_aes_key(mgr, info,
+					   info->encrypted_key_name, fw);
+		if (ret)
+			return ret;
+
+		info->flags |= FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM;
+	}
+
+	if (info->sgt) {
+		ret = fpga_mgr_buf_load_sg(mgr, info, info->sgt);
+		if (ret)
+			goto free_fw;
+	} else if (info->buf && info->count) {
+		ret = fpga_mgr_buf_load(mgr, info, info->buf, info->count);
+		if (ret)
+			goto free_fw;
+	} else if (info->firmware_name) {
+		ret = fpga_mgr_firmware_load(mgr, info, info->firmware_name);
+		if (ret)
+			goto free_fw;
+	} else {
+		ret = -EINVAL;
+	}
+
+free_fw:
+	if (info->encrypted_key_name)
+		release_firmware(fw);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_load);
 
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index a6affd83f275..e9ddece4b82d 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -196,6 +196,7 @@ of_fpga_region_parse_ov(struct fpga_region *region,
 			struct device_node *overlay)
 {
 	struct device *dev = &region->dev;
+	const char *encrypted_key_name;
 	struct fpga_image_info *info;
 	const char *firmware_name;
 	int ret;
@@ -238,6 +239,15 @@ of_fpga_region_parse_ov(struct fpga_region *region,
 			return ERR_PTR(-ENOMEM);
 	}
 
+	if (!of_property_read_string(overlay, "encrypted-key-name",
+				     &encrypted_key_name)) {
+		info->encrypted_key_name = devm_kstrdup(dev,
+							encrypted_key_name,
+							GFP_KERNEL);
+		if (!info->encrypted_key_name)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	of_property_read_u32(overlay, "region-unfreeze-timeout-us",
 			     &info->enable_timeout_us);
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..303264d89922 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -71,12 +71,15 @@ enum fpga_mgr_states {
  * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
  *
  * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
+ *
+ * %FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted with user-key
  */
 #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
 #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
 #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
 #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
 #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
+#define FPGA_MGR_USRKEY_ENCRYPTED_BITSTREAM	BIT(5)
 
 /**
  * struct fpga_image_info - information specific to an FPGA image
@@ -86,6 +89,7 @@ enum fpga_mgr_states {
  * @config_complete_timeout_us: maximum time for FPGA to switch to operating
  *	   status in the write_complete op.
  * @firmware_name: name of FPGA image firmware file
+ * @encrypted_key_name: name of the FPGA image encrypted user-key file
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
@@ -102,6 +106,7 @@ struct fpga_image_info {
 	u32 disable_timeout_us;
 	u32 config_complete_timeout_us;
 	char *firmware_name;
+	char *encrypted_key_name;
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
@@ -172,6 +177,9 @@ struct fpga_manager_ops {
 	bool skip_header;
 	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
 	u64 (*status)(struct fpga_manager *mgr);
+	int (*parse_aes_key)(struct fpga_manager *mgr,
+			     struct fpga_image_info *info,
+			     const char *buf, size_t count);
 	int (*parse_header)(struct fpga_manager *mgr,
 			    struct fpga_image_info *info,
 			    const char *buf, size_t count);
-- 
2.25.1

