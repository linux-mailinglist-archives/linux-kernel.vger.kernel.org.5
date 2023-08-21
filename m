Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF37830B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjHUTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHUTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:02:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA02B7C;
        Mon, 21 Aug 2023 12:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzaDufyY8KJ+w1Ih85LOiOMxtPibHgKxoCDITA7bBX3/sPvx4CEhVAr88kie/Pg+JhQQ/b0s3Gx6MT480JSq3X+bSN1ZDSvv8AdaC3YqvDtQqsIbRbbMP5Dc9wJu95PWEFW2hSZ2jqJdDi0ckIzH3R+HU/lnbWMwb9dOrBxICHeblTOXwdbmPjPAvaIuNiiBr0RMdORmj4E1s+D0p7siDgkvzxuUiVqKPZwmGhN+60vY9UnmNV8ayR0lDVkRyjPMasyph2n14GTNo9AzxpfzMRT0X7xwp0wDqQUGnpJkUSOZOtIZH0M9la0dDmFZgktJEwQLSjDoc0rLjUNSneFcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VMY4Uo1BQUgg0ipv28t+qZM3bd6J1Hpe2pmq+S5Mao=;
 b=SJq01M/lvNq1SjTROWwL/Y8KMkREDOvmk4u/Cnq70T5kSjtY3tnG9wv9LHu5zdgeV8IJMoQpro6UIO5ihkxJIS1dM+e4+w6C9BNHXfHyVjjHxYrn1DWY+PCfyN9z37KJqkZM4FRhyeMzIFsuBtO6OPoR7rzTDEYgFQhhafClIfWl9ozxz7uVM01vDMhwtKTowXBvcOu7SIO8I+Gv0WGsnHZuyIQhYnqYTwnhw6FgpFKWkZmzOjSTdCmvtlLOOZGXb70VfGEZz/I0gN77cEUYSOzLWgL/fljoyxE3uJe16qWT1rZ+NQh3dMES7Z3RXNH7ia0UQwt2hny7S94uxhlb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VMY4Uo1BQUgg0ipv28t+qZM3bd6J1Hpe2pmq+S5Mao=;
 b=n51xi2wQ4gsKnivEWI3XLJ4aUehZXheqZPZkrtgw/obwFArBML6YmhudGohLd9DE9MLysPXEB1w23MMfkZc1kEqtsF6wXbmX5ZT+poCvGyD9BKgmVI3FMGf4hXapC2aPP2n7948JDEjfulX2amgkCVJAtRIcJwVlo2lwku2A8C+I1/0wb2F+weFA5sIj0+68oBGGIFWk+AvSi7VULbxFoOAk+6OMHuFIoxujWuIiNv9EFiNGrKML14vGI+lwgvHAGxuAA9nDE8qdIkB9aM3TH0GIkMKi/pu88OBxGSGbIx3fbS9QV6aReQLUTH+a7wJuJN9QRIdCN/sydYQPJnucSw==
Received: from SN7PR18CA0030.namprd18.prod.outlook.com (2603:10b6:806:f3::7)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 18:39:56 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::a8) by SN7PR18CA0030.outlook.office365.com
 (2603:10b6:806:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 18:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 18:39:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 21 Aug 2023
 11:39:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 21 Aug 2023 11:39:43 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 21 Aug 2023 11:39:42 -0700
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shravankr@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v3] mlxbf-bootctl: Support sysfs entries for MFG fields
Date:   Mon, 21 Aug 2023 14:39:39 -0400
Message-ID: <20230821183939.3229-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 46aa0fbd-0eb6-446d-2eb5-08dba27603e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTUbYttxOr/d8frVLPY1C5jTtF1Y7Zypfbuw29STIgClPq9RriT1MouT+AntZQQpWtSesZtVMnsmYgz+rqIOrkpj/u8UgGwEzpPlgocd443jJ3rNO1jIsZUDYOpNsC55XTZbUX334GSanLMbrYl+Hz4sN3sDKS43HwK9z8P+1UatKc99KVtrwWmJMeZwrS0tPAGfCo++3OT8YPEQGKynFS9MHkzIIOfo8lemmmLn/z08ORagYGqWrLdDYGBGgjgPKawqYwzY0uwkUbWt7CG6BjEyfGgGDoVEJpF7yxWWYfNypQN03UJiSKVGlEyiO3HynPhWuXnqU1X0nvPQFUIV8+GFHEL7AuVYKCL8PhH4T3qZfOJ7GaF8+0TF5pLpWtzjc1K+ByNq/SIIo0precPSeYT/07eiEZuZPYbMmqdPrciLCo7oE1rXsmZhaX0P3Mmb6P4vsWpwKQpy6soaKNjyN1MXe5NMamqCipGjb2wJaJaCfO9dJzTI7DWXZNCV4eJknpAMCoB54R9VdluAitCwk2D3s5CGb65RPV+Jxpu7T7zyYd4WDmNj/D5KpQv0zER00p1tJgV9+vo7WiNY9UcmbjFj6d5efPIHze4lAAOG/aloEnAW3Yh5dEdbDfHnHM0pzmS3JOYXPvfQDt0YNT2acqIQTrVoPA7sOeMgSFCKhYPZ4PUhAu2klx+FGplEIrpvVHTfJlOmVSHnFiAWw6ecoD5itQW7N8fIr+Cvgji4t3MqK3uHKNQkXMk20+DhbT1k4j7TJe3KBDOZh0lVeP0mwQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70586007)(70206006)(316002)(110136005)(8676002)(8936002)(2616005)(107886003)(4326008)(1076003)(7636003)(36756003)(41300700001)(40460700003)(356005)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(26005)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 18:39:55.6671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aa0fbd-0eb6-446d-2eb5-08dba27603e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the mlxbf-bootctl driver's sysfs entries
to support read and write access for the manufacturing (MFG)
fields in the board-level EEPROM.  The MFG fields are set
once during the board manufacturing phase, and then the MFG
fields are write-protected.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
v2->v3
   - Updated Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
v1->v2
   - use ETH_ALEN instead of custom #define (MLNX_MFG_OOB_MAC_LEN)
   - changes to xxx_show() methods:
      a) removed unnecessary memcpy() calls, instead use data from xxx_data[]
      b) increment size of xxx_data[] by 1 to ensure null termination
   - changed "byte[]" variable to unsigned int in oob_mac_store()
   - use sysfs_format_mac() in oob_mac_show()
---
 .../testing/sysfs-platform-mellanox-bootctl   |  68 +++
 drivers/platform/mellanox/mlxbf-bootctl.c     | 438 ++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h     |   8 +
 3 files changed, 514 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
index 4c5c02d8f870..33cabddc5c34 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
@@ -84,3 +84,71 @@ Description:
 		The file used to write BlueField boot log with the format
                 "[INFO|WARN|ERR|ASSERT ]<msg>". Log level 'INFO' is used by
                 default if not specified.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/oob_mac
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "oob_mac" sysfs attribute holds the MAC address for
+                the out-of-band 1Gbps Ethernet port.  This MAC address is
+                provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/opn
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "opn" sysfs attribute holds the board's part number.
+                This value is provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/sku
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "sku" sysfs attribute holds the board's SKU number.
+                This value is provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/modl
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "modl" sysfs attribute holds the board's model number.
+                This value is provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/sn
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "sn" sysfs attribute holds the board's serial number.
+                This value is provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/uuid
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "uuid" sysfs attribute holds the board's UUID.
+                This value is provided by the manufacturing team.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/rev
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "rev" sysfs attribute holds the board's revision.
+                This value is provided on a board-level label.
+
+What:		/sys/bus/platform/devices/MLNXBF04:00/mfg_lock
+Date:		August 2023
+KernelVersion:	6.5
+Contact:	"David Thompson <davthompson@nvidia.com>"
+Description:
+		The "mfg_lock" sysfs attribute is write-only.
+                A succesful write to this attribute will latch the
+                board-level attributes into EEPROM, making them read-only.
+
+
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 0bf29eee1e70..4ee7bb431b7c 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -81,6 +82,49 @@ static const char * const mlxbf_rsh_log_level[] = {
 
 static DEFINE_MUTEX(icm_ops_lock);
 static DEFINE_MUTEX(os_up_lock);
+static DEFINE_MUTEX(mfg_ops_lock);
+
+/*
+ * Objects are stored within the MFG partition per type.
+ * Type 0 is not supported.
+ */
+enum {
+	MLNX_MFG_TYPE_OOB_MAC = 1,
+	MLNX_MFG_TYPE_OPN_0,
+	MLNX_MFG_TYPE_OPN_1,
+	MLNX_MFG_TYPE_OPN_2,
+	MLNX_MFG_TYPE_SKU_0,
+	MLNX_MFG_TYPE_SKU_1,
+	MLNX_MFG_TYPE_SKU_2,
+	MLNX_MFG_TYPE_MODL_0,
+	MLNX_MFG_TYPE_MODL_1,
+	MLNX_MFG_TYPE_MODL_2,
+	MLNX_MFG_TYPE_SN_0,
+	MLNX_MFG_TYPE_SN_1,
+	MLNX_MFG_TYPE_SN_2,
+	MLNX_MFG_TYPE_UUID_0,
+	MLNX_MFG_TYPE_UUID_1,
+	MLNX_MFG_TYPE_UUID_2,
+	MLNX_MFG_TYPE_UUID_3,
+	MLNX_MFG_TYPE_UUID_4,
+	MLNX_MFG_TYPE_REV,
+};
+
+#define MLNX_MFG_OPN_VAL_LEN         24
+#define MLNX_MFG_SKU_VAL_LEN         24
+#define MLNX_MFG_MODL_VAL_LEN        24
+#define MLNX_MFG_SN_VAL_LEN          24
+#define MLNX_MFG_UUID_VAL_LEN        40
+#define MLNX_MFG_REV_VAL_LEN         8
+#define MLNX_MFG_VAL_QWORD_CNT(type) \
+	(MLNX_MFG_##type##_VAL_LEN / sizeof(u64))
+
+/*
+ * The MAC address consists of 6 bytes (2 digits each) separated by ':'.
+ * The expected format is: "XX:XX:XX:XX:XX:XX"
+ */
+#define MLNX_MFG_OOB_MAC_FORMAT_LEN \
+	((ETH_ALEN * 2) + (ETH_ALEN - 1))
 
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
@@ -454,6 +498,384 @@ static ssize_t os_up_store(struct device *dev,
 	return count;
 }
 
+static ssize_t oob_mac_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct arm_smccc_res res;
+	u8 *mac_byte_ptr;
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC, 0, 0, 0,
+		      0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+	if (res.a0)
+		return -EPERM;
+
+	mac_byte_ptr = (u8 *)&res.a1;
+
+	return sysfs_format_mac(buf, mac_byte_ptr, ETH_ALEN);
+}
+
+static ssize_t oob_mac_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned int byte[MLNX_MFG_OOB_MAC_FORMAT_LEN] = { 0 };
+	struct arm_smccc_res res;
+	int byte_idx, len;
+	u64 mac_addr = 0;
+	u8 *mac_byte_ptr;
+
+	if ((count - 1) != MLNX_MFG_OOB_MAC_FORMAT_LEN)
+		return -EINVAL;
+
+	len = sscanf(buf, "%02x:%02x:%02x:%02x:%02x:%02x",
+		     &byte[0], &byte[1], &byte[2],
+		     &byte[3], &byte[4], &byte[5]);
+	if (len != ETH_ALEN)
+		return -EINVAL;
+
+	mac_byte_ptr = (u8 *)&mac_addr;
+
+	for (byte_idx = 0; byte_idx < ETH_ALEN; byte_idx++)
+		mac_byte_ptr[byte_idx] = (u8)byte[byte_idx];
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC,
+		      ETH_ALEN, mac_addr, 0, 0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+
+	return res.a0 ? -EPERM : count;
+}
+
+static ssize_t opn_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 opn_data[MLNX_MFG_VAL_QWORD_CNT(OPN) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_OPN_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		opn_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)opn_data);
+}
+
+static ssize_t opn_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 opn[MLNX_MFG_VAL_QWORD_CNT(OPN)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_OPN_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(opn, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_OPN_0 + word,
+			      sizeof(u64), opn[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t sku_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 sku_data[MLNX_MFG_VAL_QWORD_CNT(SKU) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_SKU_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		sku_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)sku_data);
+}
+
+static ssize_t sku_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 sku[MLNX_MFG_VAL_QWORD_CNT(SKU)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_SKU_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(sku, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_SKU_0 + word,
+			      sizeof(u64), sku[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t modl_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	u64 modl_data[MLNX_MFG_VAL_QWORD_CNT(MODL) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_MODL_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		modl_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)modl_data);
+}
+
+static ssize_t modl_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	u64 modl[MLNX_MFG_VAL_QWORD_CNT(MODL)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_MODL_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(modl, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_MODL_0 + word,
+			      sizeof(u64), modl[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t sn_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	u64 sn_data[MLNX_MFG_VAL_QWORD_CNT(SN) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_SN_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		sn_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)sn_data);
+}
+
+static ssize_t sn_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	u64 sn[MLNX_MFG_VAL_QWORD_CNT(SN)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_SN_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(sn, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_SN_0 + word,
+			      sizeof(u64), sn[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t uuid_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	u64 uuid_data[MLNX_MFG_VAL_QWORD_CNT(UUID) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_UUID_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		uuid_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)uuid_data);
+}
+
+static ssize_t uuid_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	u64 uuid[MLNX_MFG_VAL_QWORD_CNT(UUID)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_UUID_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(uuid, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_UUID_0 + word,
+			      sizeof(u64), uuid[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t rev_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 rev_data[MLNX_MFG_VAL_QWORD_CNT(REV) + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_REV + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		rev_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)rev_data);
+}
+
+static ssize_t rev_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 rev[MLNX_MFG_VAL_QWORD_CNT(REV)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_REV_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(rev, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_REV + word,
+			      sizeof(u64), rev[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t mfg_lock_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct arm_smccc_res res;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val != 1)
+		return -EINVAL;
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_LOCK_MFG_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
@@ -463,6 +885,14 @@ static DEVICE_ATTR_WO(fw_reset);
 static DEVICE_ATTR_WO(rsh_log);
 static DEVICE_ATTR_RW(large_icm);
 static DEVICE_ATTR_WO(os_up);
+static DEVICE_ATTR_RW(oob_mac);
+static DEVICE_ATTR_RW(opn);
+static DEVICE_ATTR_RW(sku);
+static DEVICE_ATTR_RW(modl);
+static DEVICE_ATTR_RW(sn);
+static DEVICE_ATTR_RW(uuid);
+static DEVICE_ATTR_RW(rev);
+static DEVICE_ATTR_WO(mfg_lock);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -474,6 +904,14 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_rsh_log.attr,
 	&dev_attr_large_icm.attr,
 	&dev_attr_os_up.attr,
+	&dev_attr_oob_mac.attr,
+	&dev_attr_opn.attr,
+	&dev_attr_sku.attr,
+	&dev_attr_modl.attr,
+	&dev_attr_sn.attr,
+	&dev_attr_uuid.attr,
+	&dev_attr_rev.attr,
+	&dev_attr_mfg_lock.attr,
 	NULL
 };
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
index 613963d448f2..1299750a8661 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -81,6 +81,14 @@
  */
 #define MLXBF_BOOTCTL_FW_RESET  0x8200000D
 
+/*
+ * SMC function IDs to set, get and lock the manufacturing information
+ * stored within the eeprom.
+ */
+#define MLXBF_BOOTCTL_SET_MFG_INFO    0x8200000E
+#define MLXBF_BOOTCTL_GET_MFG_INFO    0x8200000F
+#define MLXBF_BOOTCTL_LOCK_MFG_INFO   0x82000011
+
 /*
  * SMC function IDs to set and get the large ICM carveout size
  * stored in the eeprom.
-- 
2.30.1

