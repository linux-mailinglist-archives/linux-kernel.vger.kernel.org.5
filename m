Return-Path: <linux-kernel+bounces-145036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D918A4E91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CB28357B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0146BFC5;
	Mon, 15 Apr 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X73mmABJ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12B6BFC0;
	Mon, 15 Apr 2024 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182924; cv=fail; b=YclU6xo/qyxoh8O4e/57olENCzanmir8jFLi17icw6/8G/5PlQ/CDgsCMoC0TufZZAeGNGbv2/WRqvyT1SOyjkUO2xqu/qwGO3GvvqYB0n/JdZd5OlKRFozVj9X/qyMd0Ykr3wld0g23eGBckG3m237ztGlQmqjzrUj+I0jTnko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182924; c=relaxed/simple;
	bh=UxUWlh4KI1/q38rdJiUwyA8npYlCyBQ+M8Ey4+zIe5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ci0qplMNe8nlrOryuMNnjzBKOeHPmu0tZBdJt71bIe47zaKlfBgNtgyuwnRqG0FuE2c0nFQqHztL+lwJv/q5u2H5YArB4RSxO09kAojzbosgPI6jD9UcxRioQGT+qswb27bkAsNHj+cNfRcDeKcqCbseFiy2Ou+u8jLwB9kiZD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X73mmABJ; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTmT3Pv14qwjQ3RnanExrOBXvg4AWt69tY7gkvsFQt7DuR+oV0PuubBhreDN+znNErdlqHG5fu2o/C6/ATr6UjOFI70JrgoAnSlKP2J28pfgWQlPQlKOa9gdcNxMxvFL/C+u4SsUX4LtOBqgcbHWELq5055a/VdNwqsR99mNWqqj+tyE5kd04tKzhBhneURkEz7Q1h31+wMAgkZ414bFk89NakZ/rDolRnSrnWqwaOU+jqdy4HcO7LHcVrFWYj5wCzTLEDe9A8/3gUNkr6ad4ulCp9M3STL3R0yTwkxzCdguqp8AE9E5DhDSqw9e7/sLhf51gN1D4qNtVtNxnkOoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51LVe65ebhP4GG4o5EomnRlFeoOIDaL/P4yU3sneogQ=;
 b=JjraKUAcWnEhL/jYTilKs+EXd74q3vfSVOSUCLFHG2dOLncXYHzsI84VvF9qnsrd5LUN6lCBdto3jvKshwKiB5IEonVVycW8NfLPAaNkz4Tsmh/esv6rBB1MuR4fqIJfmoWlrgnauoGgbYAmP7u5O99tjkAS7sJDH+W28BTClp8njiqesIpUuUx1ThXbsU6YIRBeMqoi6GUFCe2wMC75JLz4oZfefJYNGuimqE4Qd1kZmgbvQqaajhBA3U7y80lwseiVMr21kATKatjqXRh9SWxAW6WjLOO1nB3I4IatZb14BZltIL1hYEZa/aGKLa264yQtXccUZ6tE1MwMjcje5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51LVe65ebhP4GG4o5EomnRlFeoOIDaL/P4yU3sneogQ=;
 b=X73mmABJdjmM8GAtFqUj5SGF9SbiEW5XmmV91kOXqOTVLmiIRtv3xdbIsKQeknWRHHoDKMBlQ4JcWLl9OrN1aocaxuP9G73EhWvcNegrQf9PAfOCCclawSnYl+tS6BBnZlaUOwcBaL3ZR+9wjKMEhvx1Y42zENr5aOxQ+gs8hMVwMN1m44wJr0xdGbfyGtBKtyg4eE/YXtERwiD7SQpF4y798cojpvJwV4jkqGMPQfieN526kY/0teCBJPx6Vbbc0h3n2aIbN6JTF/NPfQVRCc84gz7To0+YnOXV7fK7RM9/gBFNyDgViateGUxiBQMeec315cbrqMLdz0OGE5OgEA==
Received: from CY5P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::12) by
 MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 12:08:36 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::35) by CY5P221CA0004.outlook.office365.com
 (2603:10b6:930:b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 12:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:08:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:08:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:08:18 -0700
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
Subject: [PATCH net-next v2 08/10] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
Date: Mon, 15 Apr 2024 15:07:15 +0300
Message-ID: <20240415120717.1251864-9-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415120717.1251864-1-danieller@nvidia.com>
References: <20240415120717.1251864-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0848708e-0265-4ef8-d8cf-08dc5d44c73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pF73NUH/FmhEU9JihIca6mpxvdFFhbO/nmupA5er2rgrILl0cQt95x0ODapLJPTywGArG7d5R74sF/QL1mVRWz5GUzQYUv8q3KYFOjkvFKaTQB2uFjkBeCDlD6QDVb0iz85wDiOmb/D/d8aKRmn3Eu3rY1Zr/An1lLArvExOwSD7KtbzpN1vIgtLq+2ZDYkxfZZP7TEHApVc+mD4YsQAkA1r65ElhqxjFuebglDaqPCHc9ruXuvhvEINrfI7lR6rDFYTsLjxHOuEVrQTeyJ7XrmXXTpsFrC6ppCSC0UYhupmSk4Z8X3D48coxQiqqJ5XMveEn6yAEzzFZ+Ebr6uPmBjwESq/53TP1eU8ifkIg9ITbbt6D9qF+3qNLBb/y3SfrKyXCh96YKiLoW5BQfV+TJk2sRODZjjOSlsIrfPl7UNP+NVZLsRRsBgvu7YlIr3IrT15XHFm9Fw3sMgmlZAFFHi9r3FNLyDkThXsAIJo+aMhqhdgcbzjsEnCkHbocyNO3nh/WZmgPobnKHzwIOkUBGuNpKC1BYWhVLQJha1ZcJvGPyuPga+Zs5/u8cAdFx0mkQqHM1govZkIrSvjPXW+OelANCgJGdUOVqH9ErSGndScZALOZMG7GdFwoSqRBQQWzM090lK4OyOB2RLADyG3dE+ae6Bk2Y/FF6xC+Al19MmbAICD0y3ibB2IA65S5K8leONz/L5N0LHcrBEe1HiZoRAQraUvpQVuU5Nr4GPv7t8jqDv+YiZeYwYPTlm9Nbbw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:08:35.9952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0848708e-0265-4ef8-d8cf-08dc5d44c73b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951

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
    	* Decrease msleep before querying completion flag in Write FW
    	  Image command.
    	* Change the condition for failing when LPL is not supported.
    	* Re-write cmis_fw_update_write_image().

 net/ethtool/Makefile         |   2 +-
 net/ethtool/cmis.h           |   7 +
 net/ethtool/cmis_fw_update.c | 397 +++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h      |  18 ++
 4 files changed, 423 insertions(+), 1 deletion(-)
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
index 2ade50eec27a..f46c87991697 100644
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
index 000000000000..a23ff2c86a8a
--- /dev/null
+++ b/net/ethtool/cmis_fw_update.c
@@ -0,0 +1,397 @@
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
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_fw_mng_features_rpl *rpl;
+	u8 flags = CDB_F_STATUS_VALID;
+	int err;
+
+	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000,
+				      sizeof(*rpl), flags);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "FW Management Features command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
+	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL)) {
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "Write LPL is not supported",
+					      NULL);
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
+	struct ethtool_cmis_cdb_cmd_args args = {};
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
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Start FW download command failed",
+					      args.err_msg);
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
+	u32 offset, max_block_size, max_lpl_len;
+	int err;
+
+	max_lpl_len = min_t(u32,
+			    ethtool_cmis_get_max_payload_size(cdb->read_write_len_ext),
+			    ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
+	max_block_size =
+		max_lpl_len - sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+					   block_address);
+
+	for (offset = start; offset < image_size; offset += max_block_size) {
+		struct cmis_cdb_write_fw_block_lpl_pl pl = {
+			.block_address = cpu_to_be32(offset - start),
+		};
+		struct ethtool_cmis_cdb_cmd_args args = {};
+		u32 block_size, lpl_len;
+
+		ethnl_module_fw_flash_ntf_in_progress(module_fw->dev,
+						      offset - start,
+						      image_size);
+		block_size = min_t(u32, max_block_size, image_size - offset);
+		memcpy(pl.fw_block, &module_fw->fw->data[offset], block_size);
+		lpl_len = block_size +
+			sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+				     block_address);
+
+		ethtool_cmis_cdb_compose_args(&args,
+					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL,
+					      (u8 *)&pl, lpl_len,
+					      fw_mng->max_duration_write,
+					      cdb->read_write_len_ext, 1, 0,
+					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+		err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+		if (err < 0) {
+			ethnl_module_fw_flash_ntf_err(module_fw->dev,
+						      "Write FW block LPL command failed",
+						      args.err_msg);
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
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD,
+				      NULL, 0, fw_mng->max_duration_complete,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev,
+					      "Complete FW download command failed",
+					      args.err_msg);
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
+	u8 state;
+
+	return ethtool_cmis_wait_for_cond(module_fw->dev, flags,
+					  CDB_F_MODULE_STATE_VALID,
+					  CMIS_MODULE_READY_MAX_DURATION_USEC,
+					  CMIS_MODULE_STATE_OFFSET,
+					  module_is_ready, NULL, &state);
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
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_run_fw_image_pl pl = {0};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE,
+				      (u8 *)&pl, sizeof(pl),
+				      cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_MODULE_STATE_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Run image command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	err = cmis_fw_update_wait_for_module_state(module_fw, args.flags);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Module is not ready on time after reset",
+					      NULL);
+
+	return err;
+}
+
+static int
+cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
+			    struct ethtool_module_fw_flash *module_fw)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(module_fw->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(module_fw->dev,
+					      "Commit image command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+static int cmis_fw_update_reset(struct net_device *dev)
+{
+	__u32 reset_data = ETH_RESET_PHY;
+
+	return dev->ethtool_ops->reset(dev, &reset_data);
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
+	err = cmis_fw_update_reset(module_fw->dev);
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
+	ethnl_module_fw_flash_ntf_err(module_fw->dev, NULL, NULL);
+out:
+	module_fw->dev->module_fw_flash_in_progress = false;
+	netdev_put(module_fw->dev, &module_fw->dev_tracker);
+	release_firmware(module_fw->fw);
+	kfree(module_fw);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index 96da7a8175f2..9af5b15efe85 100644
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


