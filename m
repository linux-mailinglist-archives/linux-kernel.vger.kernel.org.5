Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A867F2B97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjKULVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjKULVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:21:11 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994C4F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:21:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ/ZqAc3ykckKsbrvfAOWuaDP1m9yiKl/u15rI04rKMBC4Hc1HS+VAhT6Tm7jHnEPxkk+xhzz1aPpgvYl53mnBH7DGaWHY6/6ZWQvyyUCCIzMpO8A+T3WyixZMDmWa1Vz3UJgkiw/PMHLvaVJ/0RyPi88w2VIe8zh4BQIMhNVB//R7/UdM6iwOyv6SgSU1WS3Q9eKhpCxkEwoSM23Zr0tHWpJbI5+2MxpMBSOE/Hecw5GvQ0QUIXqa5Ucgy34jOUh6w2JzYrw/FXJRIDUASI2xX6H6L3QPxg851nYsfeVFUj+/XCAthEP2ZgA8419KHn/9kZLFVGvrYKuhbvnbHhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBnKcuz+blR+bidsTL5yDX/yyJ20Yc9NGocYRSUR5WE=;
 b=ONeByq9XdBC19bWxwlvc43avi0bei2S/j1vR5dDSKOwvLjNeYu80qYTU8HHWwXdALOKonBpX3lk10vcUakwYBUrZgmkGwarZAYVWkytzoCFey37+Lkf11qm/ji+/8JIspy1Pz9xOMI8LfTF7xSL4UwEx1ykhTuZhqtV4o69fRTVoP5rNZvaNoGQ7jWmTQUQxwZGi41LrOjAuXvS2Aov+NR69/3gx8z6Uu71usQWxBVaLdNzYcRk3eDEk82XFPgfzwEFF+e3KLuxvYug5EatonRfcDC9hLPhzeOi3wVgKhxGlAN4wlE/PLCMLHLPfUoEo00VJb228Sy26lutF3Rr1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBnKcuz+blR+bidsTL5yDX/yyJ20Yc9NGocYRSUR5WE=;
 b=ZRv3n8oFf59h3mNImB8UFZtXcBjbTlvVCjgOAn2ki2ClAkvXy93/bieT5QLYQgJ2g8228C0PjA8Yzm03cBxaBTB8WuN3Wx/7zqZwVydOErVeOfEm2UQ8sdy9D03NVP/VmZepvF8mk/3N706xr1IDsIT2mFC3U9hf8y4792C+Iic=
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.25; Tue, 21 Nov 2023 11:21:03 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::41) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17 via Frontend
 Transport; Tue, 21 Nov 2023 11:21:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 11:21:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:21:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 05:21:00 -0600
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 21 Nov 2023 05:20:59 -0600
From:   Ronak Jain <ronak.jain@amd.com>
To:     <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <ben.levinsky@amd.com>,
        <nava.kishore.manne@amd.com>, <robh@kernel.org>,
        <dhaval.r.shah@amd.com>, <marex@denx.de>,
        <roman.gushchin@linux.dev>, <mathieu.poirier@linaro.org>,
        <shubhrajyoti.datta@amd.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] xilinx: firmware: Add sysfs to get last reset reason
Date:   Tue, 21 Nov 2023 03:20:56 -0800
Message-ID: <20231121112056.1762641-3-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121112056.1762641-1-ronak.jain@amd.com>
References: <20231121112056.1762641-1-ronak.jain@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cad1603-f132-4fa8-09c5-08dbea83f288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFbJYE3nF6ZwH+L5tESfTs7qhsvet0kg8zljPAwMxW52d0ml2FYxL7W9/6exAqgmwE7+3OChnHxw9qh3vdf4NQhclK4WeGx/4ur9516ZCmWDWmC9K3QKYOycvGgF5C80bWMHcVpgyGS3AvzSkntkWeoLfCLIO67wcYzkW73wJkKYxDtbDq6pFFReNy2qTxBpjNb4uB/gNzHEHbM9uWR1xOGWiI/aaxPej8NCPpiplDZG/c5GGDslAiMmC47mgdmpOA7Va7fEyMI99AM1MhQbV47AgH3ZDZbr2+0JW/452hoL40wK2R0P64vodgHn/y6yM/bFJK12rvzz4awMPvzHUBWdR2ZDCIKA+8N29UKGHPXjE22WUd9tPcMCN4/c2wEKhU1fLZmbZdvJOsZ/CeEaaQddddbxYAslzkiQS+W8VZhVYJwFRuNuqBX6kykioETKKAaMPqBAuEi0oUK94FOCI2Hif2/LJoR+2hlK4nWOPzK4Qx0NWFOgKSpwxyMAc1y4xVnWg/lUmUeKY2pNRQMszg5PEDPs8m1txzqV19oCWl+vcQlNg4bOGX80zfyT0hTkXjzJ11oWQJf1w36ZJJPHdSkmQouqu9m8PuFZc5ySnm9YmvQFWFq1YzH1u5oArjnYfXihm+WFJeBOUep0vqUcJ6OUI2f911dxL0tgdfhJ9Y2HqGs9bsfqCtayfv6NcNIzGekm0XUZ4ZpDPVwv/ao7PoFNuCq0jy378ggt9dNHTfOC3sw1VsNm7gN/Xyo7Gp1HUA5NyN/DwWFAhBchtpC49MjngUsJscnXYMeEsPe8igM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(36840700001)(40470700004)(36756003)(41300700001)(5660300002)(40460700003)(86362001)(2906002)(44832011)(921008)(82740400003)(336012)(426003)(81166007)(356005)(110136005)(40480700001)(478600001)(6666004)(1076003)(26005)(2616005)(4326008)(8676002)(8936002)(47076005)(70586007)(70206006)(316002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 11:21:03.2580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad1603-f132-4fa8-09c5-08dbea83f288
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs interface to get the last reset reason of the system from
a user space.

When the system reset happens whether intentionally or due to some
errors, the firmware used to store the last reset reason and the same
be queried by using the IOCTL API or the sysfs entry to know the
reason behind the system reset and accordingly, the error can be
diagnostic.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 13 +++++++
 drivers/firmware/xilinx/zynqmp.c              | 36 +++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h          | 11 ++++++
 3 files changed, 60 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index c3fec3c835af..77ae69870767 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -254,3 +254,16 @@ Description:
 		The expected result is 500.
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/last_reset_reason
+Date:		Nov 2023
+KernelVersion:	6.7
+Contact:	"Ronak Jain" <ronak.jain@amd.com>
+Description:
+		This sysfs interface allows to get last reset reason.
+
+		Usage:
+		Get last reset reason
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/last_reset_reason
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5815d1e94407..8f49861ebbb3 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1902,6 +1902,41 @@ static ssize_t feature_config_value_store(struct device *device,
 
 static DEVICE_ATTR_RW(feature_config_value);
 
+static ssize_t last_reset_reason_show(struct device *device,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_get_last_reset_reason(ret_payload);
+	if (ret)
+		return ret;
+
+	switch (ret_payload[1]) {
+	case PM_RESET_REASON_EXT_POR:
+		return sprintf(buf, "ext_por\n");
+	case PM_RESET_REASON_SW_POR:
+		return sprintf(buf, "sw_por\n");
+	case PM_RESET_REASON_SLR_POR:
+		return sprintf(buf, "slr_por\n");
+	case PM_RESET_REASON_ERR_POR:
+		return sprintf(buf, "err_por\n");
+	case PM_RESET_REASON_DAP_SRST:
+		return sprintf(buf, "dap_srst\n");
+	case PM_RESET_REASON_ERR_SRST:
+		return sprintf(buf, "err_srst\n");
+	case PM_RESET_REASON_SW_SRST:
+		return sprintf(buf, "sw_srst\n");
+	case PM_RESET_REASON_SLR_SRST:
+		return sprintf(buf, "slr_srst\n");
+	default:
+		return sprintf(buf, "unknown reset\n");
+	}
+}
+
+static DEVICE_ATTR_RO(last_reset_reason);
+
 static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_ggs0.attr,
 	&dev_attr_ggs1.attr,
@@ -1915,6 +1950,7 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_health_status.attr,
 	&dev_attr_feature_config_id.attr,
 	&dev_attr_feature_config_value.attr,
+	&dev_attr_last_reset_reason.attr,
 	NULL,
 };
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2d8c5e88391b..6d4015b6d964 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -497,6 +497,17 @@ enum pm_gem_config_type {
 	GEM_CONFIG_FIXED = 2,
 };
 
+enum pm_reset_reason {
+	PM_RESET_REASON_EXT_POR = 0,
+	PM_RESET_REASON_SW_POR = 1,
+	PM_RESET_REASON_SLR_POR = 2,
+	PM_RESET_REASON_ERR_POR = 3,
+	PM_RESET_REASON_DAP_SRST = 7,
+	PM_RESET_REASON_ERR_SRST = 8,
+	PM_RESET_REASON_SW_SRST = 9,
+	PM_RESET_REASON_SLR_SRST = 10,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.25.1

