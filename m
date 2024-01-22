Return-Path: <linux-kernel+bounces-32555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D2E835D11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275B42872E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A53A8F6;
	Mon, 22 Jan 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWd5mMFc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2739870;
	Mon, 22 Jan 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913212; cv=fail; b=CRd3DCCPKDDCD3XKQA/mDxVaKbfrUOkLdGpBDv7KQUk8E8PnsNNyo0M2R35fvBnfkb3J3IveebDH0mCb0dNhV/scONp2NpJBPyk3a2RN25dr81Iz6zRP6/qLd/WCrasCPCMhm8Kur4rUQV82soWdMsrEo9VPVLkUHi6SotlKPVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913212; c=relaxed/simple;
	bh=2wKmwfxzyCrc+jqF+e3sHVs0hw7DmZO5BBD0c1Vf6sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ab3Wzs8/SXAZI7qvAgQ4Y2TCPG3kFodGBFcy8lsyU27aefLB3jA2hBQP8dX/sYWz41No+u2nGc8sRjFljIYImojoLx7WlwyyECOM8u23AIfSf7il0Pr3BToq2n3S11qM5RGg9s21ygu9UiF52ENV/0Cg7pylAfHrllrJUY2tXw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWd5mMFc; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB+FnCazFY+YnRyBtKCDTgFl7a+gwW7w7RBqVJM2/i8sfBbRRN+B4DZd7dglhmPMLSQtkP6hvfQwCsB/1I2mni7QkyL0oDwYwiz0g4nqpmz4asNIEPihxdakfBZqn8COE+8piQ0P/x0Zabepn6nxyL3rb3sLeLYVfOj+6ITjjZdylLy1HUx2UmIW66Fc/0VQ3/GIBs7PePPRvTfDKTvUCdS5yIFgHF/gUK7DQD+dtGDax61Xh/sUnb4U5IsnqL+v6Rp/1SoBeKBc3y8X/hUypdy8yTfX7SqIkjf9snflqmdpjxhNTDECtHZKzMiFsSJJvVjynNzPV89f6tFPukCqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpwukNwzsvY826dbZP6FQ9LZ7jOsQFtO+AzINp6Y+l0=;
 b=ItW9l/zxB/z8FFzaETAmGqEWpYXkhfVq5DoxpMbzynmmKHl9Nq1SWgpXdzmCyqhSd/xefUgKWnbDbu6sui4J8afkWO6yfn+ZXSpijemLwuZ2z1cwkh4DEMIwoJNZq0eACV2EQDG06ik2FA1Rx77As3FrGDcfADh2vw9L+zHw5IGYNBFumNUyeXsr5GLGbELUisBlf8jce6I2MGwQvnaGCj4pmcRnNeva9homdIOSWs4M2QeeLtwuEsHmDPKcSTaD4dHmWjjVQady/1VSi1LELYlZ8noMEbFkJqddYElIg4WeCLBnvQgz2lA1WalskFCtxG0C2gLtHo6oqIA57qhChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpwukNwzsvY826dbZP6FQ9LZ7jOsQFtO+AzINp6Y+l0=;
 b=FWd5mMFc5XvPS7bKHf15iLz7Ht46Zg8OiTYfOJ2mMPAvwzAzR2vvj8/ggzVHiSOWRrlEq2VYju4DBe6V2iU7bgxmJd+B07NYThXVF4P3I2L5sY1hjl/Tb5iSULqkemic9m5H+AijeBm3ftPAvEVvdAQgDIRpZPpYMEyurLaZJ4z5QHe/Okv6m2PLC+2FVfQ4kJ1KLuAYpro0WTA2Su5Wn52pC5IDyuJezV5g746qLuQKQw4+zULxdZcSol/p6RinE9PJekXynrULpx55UZ6FmJRRPCUj7dwaQPkKxHKmJ3+7TOCcd4eIrNE461p9DiD+2acDT2e2w4JI5bkQ17ve2A==
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 08:46:47 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::ba) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:46:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:46:35 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:46:30 -0800
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
Subject: [RFC PATCH net-next 8/9] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
Date: Mon, 22 Jan 2024 10:45:29 +0200
Message-ID: <20240122084530.32451-9-danieller@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122084530.32451-1-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f460476-ba5e-437e-a871-08dc1b26ab26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	okvghLRWL2neWaML0z2h8QumbD+HqWqX+mNB1qAMM/6/MGShiaJo7D6HLc2wzzKdnEcCZWr/QFjX83CoIeepTPhOUOAcIyDQmNA8eWiEsvpDFfnqdMBSazI90h3XAk6q5X8STDy/AVX5Z6DMwEsTNWOScBqzwiWe/yeAVK0lYqeZIAgjmGk1dmzZXjKbztSr5jtFKaqR5AGlkCqOmPJpWQVhpP56WC93hc4VPlrZi0dEYm/PwG53mbt7mH2scYA490Nvl1ZQDmtv7MTvUESfb74kBPZrbgkrR9S5SiQKa6J+HgVAW0k/hvwALTl4O/OFJm7KVxz7te1xirwK4zV+EInoQLKYVU0qckNg6g8NPMcGO7MgjJ3grkXnLGG2kSTUlD9sn5snw/AeGtFBsoXu+rm3sg4+ankga5S3k+8gExvQocWU57mIVebi2e6yUeqZmAOnuHBaDiqrgkAAiLsHT4bJ+HuDfiszh8tFB/jyrTI49+VjI36g9Fx1VKZc26/+SsMBlFmhOeNj6XTLi7Z8rXdjj4KQdjt6OsWfWS44apqsjSiN9GXbnzKQYk41PSkB7npF09iH1S9ot5AN14DJ0FntD58r1Vd8DLgz3RT2T13iKRluya7h2SYeP4Kozw4fq/Jfv5Jg1v/Onal5K3ld0wBM7PZoJDv4hlcegqxjZwx0T6hO7w61bNyN/dU2WWG+vxrnLv/XZCdMWxi0NSeBiunIZS6NhFWANYgDdsOqTmvWZHjFhgnKgsi0MlN5X4SI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(336012)(107886003)(1076003)(426003)(40460700003)(40480700001)(26005)(16526019)(82740400003)(36756003)(36860700001)(47076005)(478600001)(2616005)(83380400001)(7636003)(356005)(15650500001)(5660300002)(70586007)(54906003)(70206006)(316002)(30864003)(8936002)(86362001)(2906002)(4326008)(7416002)(8676002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:47.2506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f460476-ba5e-437e-a871-08dc1b26ab26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

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
 net/ethtool/Makefile         |   2 +-
 net/ethtool/cmis.h           |   7 +
 net/ethtool/cmis_fw_update.c | 371 +++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h      |  18 ++
 4 files changed, 397 insertions(+), 1 deletion(-)
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
index a8d6f96ed26f..dd1ac13c5e25 100644
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
index 000000000000..6ecaaf6cccda
--- /dev/null
+++ b/net/ethtool/cmis_fw_update.c
@@ -0,0 +1,371 @@
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
+		goto err_cdb_init;
+
+	ethnl_module_fw_flash_ntf_start(module_fw->dev);
+
+	err = cmis_fw_update_fw_mng_features_get(cdb, module_fw->dev, &fw_mng);
+	if (err < 0)
+		goto err_fw_mng_features_get;
+
+	err = cmis_fw_update_download_image(cdb, module_fw, &fw_mng);
+	if (err < 0)
+		goto err_download_image;
+
+	err = cmis_fw_update_run_image(cdb, module_fw);
+	if (err < 0)
+		goto err_run_image;
+
+	/* The CDB command "Run Firmware Image" resets the firmware, so the new
+	 * one might have different settings.
+	 * Free the old CDB instance, and init a new one.
+	 */
+	ethtool_cmis_cdb_fini(cdb);
+
+	cdb = ethtool_cmis_cdb_init(module_fw->dev, &module_fw->params);
+	if (IS_ERR(cdb))
+		goto err_cdb_init;
+
+	err = cmis_fw_update_commit_image(cdb, module_fw);
+	if (err < 0)
+		goto err_commit_image;
+
+	ethnl_module_fw_flash_ntf_complete(module_fw->dev);
+	ethtool_cmis_cdb_fini(cdb);
+	goto out;
+
+err_commit_image:
+err_run_image:
+err_download_image:
+err_fw_mng_features_get:
+	ethtool_cmis_cdb_fini(cdb);
+err_cdb_init:
+	ethnl_module_fw_flash_ntf_err(module_fw->dev, NULL);
+out:
+	netdev_put(module_fw->dev, &module_fw->dev_tracker);
+	module_fw->dev->module_fw_flash_in_progress = false;
+	release_firmware(module_fw->fw);
+	kfree(module_fw);
+}
+EXPORT_SYMBOL_GPL(ethtool_cmis_fw_update);
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index a4d4220db35d..969de116f995 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -9,6 +9,8 @@ void ethnl_module_fw_flash_ntf_complete(struct net_device *dev);
 void ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev, u64 done,
 					   u64 total);
 
+void ethtool_cmis_fw_update(struct work_struct *work);
+
 /**
  * struct ethtool_module_fw_flash_params - module firmware flashing parameters
  * @file_name: Firmware image file name.
@@ -20,3 +22,19 @@ struct ethtool_module_fw_flash_params {
 	u32 password;
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
2.40.1


