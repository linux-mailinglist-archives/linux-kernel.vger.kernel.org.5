Return-Path: <linux-kernel+bounces-48404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D94845B82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75DF2B29F54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48981626D0;
	Thu,  1 Feb 2024 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KMZWcsnI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753F626CF;
	Thu,  1 Feb 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801184; cv=fail; b=d8JqF393jyVIXyNUBfzgeF+vtTi9VTnUXYLh9dsqAItFirQCt5Eeb7UVXueBPlAcq3MJ7Q+hnsFfZjNbE7KIs3S1zrQPqZTiJbFydaS4J6wB9N+Nk3P9VS9Hxymumi8alLqGTQzOUhe1h6gox1zEmeOJh7t56Fl7AYZvnMpaJMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801184; c=relaxed/simple;
	bh=58PhNOh5H8La0Q7YrOKUM7p/zhoolQXRqUYqmfCyYFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4NtpjvJlZCpgIaRmC4jeJY6Wd5wpZVN5TOKiZ+nkFnYQcfrIPyIUmcL0bL2fKd2jmaG9F4whvYZgTi2+Wke280YiL5wER/XqppoFQ/dd/sVDqIQse9nh1ZMKD1IeugBT0dVyta7wlSz2gfkYLjTJ6r5agPZ98rU55iEd7CfJlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KMZWcsnI; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzNQmN6ObUkIaFJ+Rbbcrz2x4Eo8G2+Edi2cOka9oG2GTgY6UoGdE/P8PTC+XWt2AKH9dd8QaXyvsW8Yxf4ktgNdQkTlAlZCMPtcs1+8km6HEIfOOj8b2B673SP/BmrcmBxaHemuT8dB0YCOH338Ref5cRbkZF+ZYhjJo30+ACzdVdYedJi5eoBso/u/uHSCVCmQZxh26abplOzsACDFjrHyG3YmUsK6thS0a8WVYbJGmJx5hB120ztArXWRuFT8bqXXxFbj2/eAO6UAtXMSkgbzkIC175ww7BbW3qiYTUecxyGnkb4j57Mb0Co8dZE0x2HL437BqcMVyw7pFq8Eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o8FRMTSt0O7uZLJ2VqR+gX4lLnudSO1tBOo/1740PA=;
 b=HApiq1r4cS7G0qfFU51erm7Yg9kEfEg9AK8eLVbuqLyJNgEXvQVJb9D5Bc8sEBga03wa+5Or+grYZZyTbER57Dheq8BeN/JeaOOaCPWgBPT+dcmDL1+Zumo/33DOfYftXob4nq9vnYZjsdAm8fLGW7V6W6Jzal3gpe3nOmLzMfuSwE9eFFW1RQSddfo84wDQ9axw7sWNan1i0BBg60guv7kLom3Ppz4x5ikPSBopATPaYKB1x+KyZ4jqMNobPp+LefWmNn/7jge5n+gMDycOJ+FPmckAWJAVBLLAfe6xuE9mAUEkC2poNmUCbus3D2zHYjaYDyJQxkBey7mmcSW9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o8FRMTSt0O7uZLJ2VqR+gX4lLnudSO1tBOo/1740PA=;
 b=KMZWcsnIeA9P15qIJbWLI+e2YebH26nDWgVUTDzQo72/HQ64UUAhc5p4qE4Urr0VSX3V3lerYVZPF6Xo0l/ckDZgdAPB/sFo5n1KtGLFN+Ii6FzDvw9K1Mrmw8yRGVXHANgQuuWAPalMkjIofmfpNjF64EkJLO16qUkYZXu43nG8TvByjND28pttMUjaL0rUO4QJ+csl+jf1VKyAg+xU/YVn+ht3CvsK3hK75YndXNyGlPDsO1mMRNajHOSlvJvytopfsrguus1pboTgBSZeyBq+hfPUWq4cHbuIlLFr6PVGutnU2BBXQF8KGOuenkSB4o2bAVRN4TqyybYbpeV1Rw==
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Thu, 1 Feb
 2024 15:26:19 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::5a) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 15:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:26:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:26:07 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:26:01 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <petrm@nvidia.com>,
	<idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [RFC PATCH net-next v2 8/9] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
Date: Thu, 1 Feb 2024 17:25:00 +0200
Message-ID: <20240201152501.3955887-9-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201152501.3955887-1-danieller@nvidia.com>
References: <20240201152501.3955887-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e168a9e-45cb-4554-1ee5-08dc233a2394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eKYs1gaoFGSRP41DKCpNkfn9dSfrUig5uwrW8BhuQx4d6Z3aneGwRa2RJUDYWOJeanPSNg5++GwBEhj2yACl9iiE9EsnpJFdroUbK5tAJUDGVWFQkg/DlMY/s4gQP4WDXuvP7NQUYdrQavrOD+GClK+idISZy5FC9qPboCl2lNbX1ND7oR43jYyj8uUx54u+gmmv9KLSjcji8FSIQdwinXHm2kTV7eZ+OQ5ac7ekBQjZClkTag0h3FBymKhsJ8nrVAhXo2PhR/sHbz32dwP9UsftmR1E0eOqql0UgOk1XMxzHbZkH8q0UtAviW3YrBQPQCg0fFQJhGHTh7xopCOD8Rn1XNJokdd5sGlfDncp7nWyIROB7adhXjF5SnlJ/pcrkftZfSYk/nQK4qzRne5fK/tj3S0SXxGZeHk7rsbZ7fKi0CkqD6XbdBi+Zz8qXHgv5g2sJUvf0Ry1rA+/xRcGjkULHcGZG1Z33oi7f7Q/UKtmgQxPoNJlNpv7SL6BSyqsWIQaY7E0FVe8RUKf6xhF/u84zUyZcrgV/OgZEAYZkvOvKCGA3zpL8nn0Jvw/rCS22hsQAWipcvsvQtprKQ2ZZnKfy0vI5tXvXS3N33WzZFrROKuzjs2/iHM9ks0xILP6CbdOzdFB4C/Sdjr0CoCgzPtmPNn9dObgCnhn+Y8Gt+8vScDttKtAt+AL2BBdBIa5qpyswmxsQQY3yAuUt4qfpMhSkxdPTPxApHv7SbbWDHFh7+11aif7mQEmj1xj02B6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(16526019)(336012)(426003)(26005)(2616005)(107886003)(1076003)(7636003)(82740400003)(36860700001)(5660300002)(4326008)(8676002)(8936002)(15650500001)(7416002)(30864003)(2906002)(478600001)(54906003)(70206006)(70586007)(6916009)(316002)(86362001)(41300700001)(356005)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:26:18.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e168a9e-45cb-4554-1ee5-08dc233a2394
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

According to the CMIS standard, the firmware update process is done using
a CDB commands sequence.

Implement a work that will be triggered from the module layer in the
next patch the will initiate and execute all the CDB commands in order, to
eventually complete the firmware update process.

This flashing process includes, writing the firmware image, running the new
firmware image and committing it after testing, so that it will run upon
reset.

This work will also notify user space about the progress of the firmware
update process.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	* Name labels after the target in ethtool_cmis_fw_update().
    	* Remove ethtool_cmis_fw_update() export.
    	* Switch between the lines that sets module_fw_flash_in_progress
    	  to false and netdev_puts.

 net/ethtool/Makefile         |   2 +-
 net/ethtool/cmis.h           |   7 +
 net/ethtool/cmis_fw_update.c | 367 +++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h      |  18 ++
 4 files changed, 393 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/cmis_fw_update.c

diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 38806b3ecf83..9a190635fe95 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o cmis_cdb.o pse-pd.o plca.o mm.o
+		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o
diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 06596ae749a5..f8e907a4c7eb 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -20,6 +20,12 @@ struct ethtool_cmis_cdb {
 enum ethtool_cmis_cdb_cmd_id {
 	ETHTOOL_CMIS_CDB_CMD_QUERY_STATUS		= 0x0000,
 	ETHTOOL_CMIS_CDB_CMD_MODULE_FEATURES		= 0x0040,
+	ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES	= 0x0041,
+	ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD		= 0x0101,
+	ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL		= 0x0103,
+	ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD	= 0x0107,
+	ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE		= 0x0109,
+	ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE		= 0x010A,
 };
 
 /**
@@ -47,6 +53,7 @@ struct ethtool_cmis_cdb_request {
 
 #define CDB_F_COMPLETION_VALID		BIT(0)
 #define CDB_F_STATUS_VALID		BIT(1)
+#define CDB_F_MODULE_STATE_VALID	BIT(2)
 
 /**
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
new file mode 100644
index 000000000000..a18a7ffb7919
--- /dev/null
+++ b/net/ethtool/cmis_fw_update.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/firmware.h>
+
+#include "common.h"
+#include "module_fw.h"
+#include "cmis.h"
+
+struct cmis_fw_update_fw_mng_features {
+	u8	start_cmd_payload_size;
+	u16	max_duration_start;
+	u16	max_duration_write;
+	u16	max_duration_complete;
+};
+
+/* See section 9.4.2 "CMD 0041h: Firmware Management Features" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_fw_mng_features_rpl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_rpl::payload.
+ */
+struct cmis_cdb_fw_mng_features_rpl {
+	u8	resv1;
+	u8	resv2;
+	u8	start_cmd_payload_size;
+	u8	resv3;
+	u8	read_write_len_ext;
+	u8	write_mechanism;
+	u8	resv4;
+	u8	resv5;
+	__be16	max_duration_start;
+	__be16	resv6;
+	__be16	max_duration_write;
+	__be16	max_duration_complete;
+	__be16	resv7;
+};
+
+#define CMIS_CDB_FW_WRITE_MECHANISM_LPL	0x01
+
+static int
+cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
+				   struct net_device *dev,
+				   struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	struct cmis_cdb_fw_mng_features_rpl *rpl;
+	struct ethtool_cmis_cdb_cmd_args args;
+	u8 flags = CDB_F_STATUS_VALID;
+	int err;
+
+	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, sizeof(*rpl),
+				      flags);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "FW Management Features command failed");
+		return err;
+	}
+
+	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
+	if (!(rpl->write_mechanism & CMIS_CDB_FW_WRITE_MECHANISM_LPL)) {
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "Write LPL is not supported");
+		return  -EOPNOTSUPP;
+	}
+
+	/* Above, we used read_write_len_ext that we got from CDB
+	 * advertisement. Update it with the value that we got from module
+	 * features query, which is specific for Firmware Management Commands
+	 * (IDs 0100h-01FFh).
+	 */
+	cdb->read_write_len_ext = rpl->read_write_len_ext;
+	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	fw_mng->max_duration_start = be16_to_cpu(rpl->max_duration_start);
+	fw_mng->max_duration_write = be16_to_cpu(rpl->max_duration_write);
+	fw_mng->max_duration_complete = be16_to_cpu(rpl->max_duration_complete);
+
+	return 0;
+}
+
+/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_start_fw_download_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_start_fw_download_pl {
+	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
+			__be32	image_size;
+			__be32	resv1;
+	);
+	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
+		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
+};
+
+static int
+cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_module_fw_flash *module_fw,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 vendor_data_size = fw_mng->start_cmd_payload_size;
+	struct cmis_cdb_start_fw_download_pl pl = {};
+	struct ethtool_cmis_cdb_cmd_args args;
+	u8 lpl_len;
+	int err;
+
+	pl.image_size = cpu_to_be32(module_fw->fw->size);
+	memcpy(pl.vendor_data, module_fw->fw->data, vendor_data_size);
+
+	lpl_len = offsetof(struct cmis_cdb_start_fw_download_pl,
+			   vendor_data[vendor_data_size]);
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD,
+				      (u8 *)&pl, lpl_len,
+				      fw_mng->max_duration_start,
+				      cdb->read_write_len_ext, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Start FW download command failed");
+
+	return err;
+}
+
+/* See section 9.7.4 "CMD 0103h: Write Firmware Block LPL" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_write_fw_block_lpl_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_write_fw_block_lpl_pl {
+	__be32	block_address;
+	u8 fw_block[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH - sizeof(__be32)];
+};
+
+static int
+cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
+			   struct ethtool_module_fw_flash *module_fw,
+			   struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 start = fw_mng->start_cmd_payload_size;
+	u32 image_size = module_fw->fw->size;
+	u32 offset, block_size, lpl_len;
+	int err;
+
+	lpl_len = ethtool_cmis_get_max_payload_size(cdb->read_write_len_ext);
+	block_size =
+		lpl_len - sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+				       block_address);
+
+	for (offset = start; offset < image_size; offset += block_size) {
+		struct cmis_cdb_write_fw_block_lpl_pl pl = {
+			.block_address = cpu_to_be32(offset - start),
+		};
+		struct ethtool_cmis_cdb_cmd_args args;
+
+		ethnl_module_fw_flash_ntf_in_progress(module_fw->dev,
+						      offset - start,
+						      image_size);
+
+		memcpy(pl.fw_block, &module_fw->fw->data[offset],
+		       min(block_size, image_size - offset));
+
+		ethtool_cmis_cdb_compose_args(&args,
+					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL,
+					      (u8 *)&pl,
+					      min_t(u32, lpl_len, sizeof(pl)),
+					      fw_mng->max_duration_write,
+					      cdb->read_write_len_ext, 0,
+					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+		err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+		if (err < 0) {
+			ethnl_module_fw_flash_ntf_err(module_fw->dev,
+						      "Write FW block LPL command failed");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int
+cmis_fw_update_complete_download(struct ethtool_cmis_cdb *cdb,
+				 struct net_device *dev,
+				 struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	struct ethtool_cmis_cdb_cmd_args args;
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD,
+				      NULL, 0, fw_mng->max_duration_complete,
+				      cdb->read_write_len_ext, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "Complete FW download command failed");
+
+	return err;
+}
+
+static int
+cmis_fw_update_download_image(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_module_fw_flash *module_fw,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	int err;
+
+	err = cmis_fw_update_start_download(cdb, module_fw, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_write_image(cdb, module_fw, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_complete_download(cdb, module_fw->dev, fw_mng);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+enum {
+	CMIS_MODULE_LOW_PWR	= 1,
+	CMIS_MODULE_READY	= 3,
+};
+
+static bool module_is_ready(u8 data)
+{
+	u8 state = (data >> 1) & 7;
+
+	return state == CMIS_MODULE_READY || state == CMIS_MODULE_LOW_PWR;
+}
+
+#define CMIS_MODULE_READY_MAX_DURATION_USEC	1000
+#define CMIS_MODULE_STATE_OFFSET		3
+
+static int
+cmis_fw_update_wait_for_module_state(struct ethtool_module_fw_flash *module_fw,
+				     u8 flags)
+{
+	return ethtool_cmis_wait_for_cond(module_fw->dev, flags,
+					  CDB_F_MODULE_STATE_VALID,
+					  CMIS_MODULE_READY_MAX_DURATION_USEC,
+					  CMIS_MODULE_STATE_OFFSET,
+					  module_is_ready, NULL);
+}
+
+/* See section 9.7.10 "CMD 0109h: Run Firmware Image" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_run_fw_image_pl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_run_fw_image_pl {
+	u8 resv1;
+	u8 image_to_run;
+	u16 delay_to_reset;
+};
+
+static int cmis_fw_update_run_image(struct ethtool_cmis_cdb *cdb,
+				    struct ethtool_module_fw_flash *module_fw)
+{
+	struct cmis_cdb_run_fw_image_pl pl = {0};
+	struct ethtool_cmis_cdb_cmd_args args;
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE,
+				      (u8 *)&pl, sizeof(pl),
+				      cdb->max_completion_time,
+				      cdb->read_write_len_ext, 0,
+				      CDB_F_MODULE_STATE_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Run image command failed");
+		return err;
+	}
+
+	return cmis_fw_update_wait_for_module_state(module_fw, args.flags);
+}
+
+static int
+cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
+			    struct ethtool_module_fw_flash *module_fw)
+{
+	struct ethtool_cmis_cdb_cmd_args args;
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Commit image command failed");
+
+	return err;
+}
+
+void ethtool_cmis_fw_update(struct work_struct *work)
+{
+	struct cmis_fw_update_fw_mng_features fw_mng = {0};
+	struct ethtool_module_fw_flash *module_fw;
+	struct ethtool_cmis_cdb *cdb;
+	int err;
+
+	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
+
+	cdb = ethtool_cmis_cdb_init(module_fw->dev, &module_fw->params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	ethnl_module_fw_flash_ntf_start(module_fw->dev);
+
+	err = cmis_fw_update_fw_mng_features_get(cdb, module_fw->dev, &fw_mng);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_download_image(cdb, module_fw, &fw_mng);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_run_image(cdb, module_fw);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	/* The CDB command "Run Firmware Image" resets the firmware, so the new
+	 * one might have different settings.
+	 * Free the old CDB instance, and init a new one.
+	 */
+	ethtool_cmis_cdb_fini(cdb);
+
+	cdb = ethtool_cmis_cdb_init(module_fw->dev, &module_fw->params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	err = cmis_fw_update_commit_image(cdb, module_fw);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	ethnl_module_fw_flash_ntf_complete(module_fw->dev);
+	ethtool_cmis_cdb_fini(cdb);
+	goto out;
+
+err_cdb_fini:
+	ethtool_cmis_cdb_fini(cdb);
+err_send_ntf:
+	ethnl_module_fw_flash_ntf_err(module_fw->dev, NULL);
+out:
+	module_fw->dev->module_fw_flash_in_progress = false;
+	netdev_put(module_fw->dev, &module_fw->dev_tracker);
+	release_firmware(module_fw->fw);
+	kfree(module_fw);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index 8bbf13cea4c4..bc4ce6393fdb 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -9,6 +9,8 @@ void ethnl_module_fw_flash_ntf_complete(struct net_device *dev);
 void ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev, u64 done,
 					   u64 total);
 
+void ethtool_cmis_fw_update(struct work_struct *work);
+
 /**
  * struct ethtool_module_fw_flash_params - module firmware flashing parameters
  * @password: Module password. Only valid when @pass_valid is set.
@@ -18,3 +20,19 @@ struct ethtool_module_fw_flash_params {
 	__be32 password;
 	u8 password_valid:1;
 };
+
+/**
+ * struct ethtool_module_fw_flash - module firmware flashing
+ * @dev: Pointer to the net_device to be flashed.
+ * @dev_tracker: Refcount tracker for @dev.
+ * @params: Module firmware flashing parameters.
+ * @work: The flashing firmware work.
+ * @fw: Firmware to flash.
+ */
+struct ethtool_module_fw_flash {
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	struct ethtool_module_fw_flash_params params;
+	struct work_struct work;
+	const struct firmware *fw;
+};
-- 
2.43.0


