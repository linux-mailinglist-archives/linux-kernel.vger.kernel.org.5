Return-Path: <linux-kernel+bounces-135364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C689BF88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BE0B281F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC376413;
	Mon,  8 Apr 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOBge/Yc"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0266F08E;
	Mon,  8 Apr 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580875; cv=fail; b=fkb0qdnT7KRIgf4kbUt17BC858oVFBD3rziHywVwLxgQ30RYkqgbz8NiShN7eHaQ3S4qD5QRT7XwQ5fNVaoBMD1ofafZCifsgrfgvRsDDUFY49Kj+tfowX8Xs78hSQQJHEQv+Ya+lGIIX84lDJ+BUNN1pwlEJllRp6VfPXfnemc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580875; c=relaxed/simple;
	bh=GzCHQb+b5mjqjQX85hu+ZTeXNPz7/e9N6h8o/vKorxg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMkWExw5DJmugALKTjfM5zKQMg49j7hCDpg9/qmokoEb8YJAcWRzZCadQPBjX1NdZiuQJFi8udQLekZzp6e/hkAjRPZXkOo/3Hg0INL8GbKpnQsTyNBDELUkaWuAj7pTk45CsC1nwg2MWFPMVGmXUO5zEL1sZwRyADdVBSWrLBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOBge/Yc; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGxF4rf6toKkc4ymR2ZPEhd7lHG95JLm+Dt/dcZWAPriAp+X0z2jHnr/I4XhjLsZqjhWjccRlbrGzo2H8AR4jzOwWMVyfmTXuZVWJUWfPeK9qdb5PISHp3SQOzrBosy8cSWcWo3RVDctX2QZ/srrR0jcP6cJSxk0+BBSzMN2pQTymS3IrQwezcaNIcn0hIDgM+1G6j9NtINcutg5s8fuCBAglTQumZsGNCKvLZK6UMAfy7zZjblB0fBkYq70RChiKRWEAYEptJrPTmNPCt+cT2qer0SOIs91X0PSIL7THcwuUvan/REKrMHSuZzekL6Bok1bMOmXlDOEjObv2pjwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vetlP21hQJ95M8t3oHmkorJC8ZQy2jcFN8CRJiGwgN4=;
 b=ej1WImZ/g/RoRSkGVp/9RETgDJbZUVCrwVxDlRSaYGFPKo5rKXNb1G/Ytsxb+aUCbrVEq+kAjWQbUC2WeudImZfOwXKZGgTHZI2uUzkRIq1U0+wIuTT1B08c8GYo2oV1bbMRmVdSdBoJGZNLH+0LVGQVCEa1ahJREiG97S/HcOlx1yj6C9ZqFwZcBrCorlit0rsQcg4wMvC8y0SuwjUoAIs4pbl3WDF3XihtxlzXmsGmKMPM5uW491m5I7CSlaVDG3Io/ul50qnejo/hnBx0Q7gsfy6pRBME0nD+F/ZsHNOUKkMXUynUDiByfjoz0vEogEUcuWjQT21l8DjM75h7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vetlP21hQJ95M8t3oHmkorJC8ZQy2jcFN8CRJiGwgN4=;
 b=cOBge/Yclf10Jy7YAh2sxlghAd3aAw7mKzDTPY4k56UzHl3V2ieSvMT4ttsIY1ff1DYR6EOud0FVR46e1yvCPLNPse2kFngUYfjcYZqCrZdYvGSWTEcp3illX5gTMu/i6MrQkFdPE/9lbOjV+sxICF6a0hbMDUtTuOzt7vA7GQaADqeI7LXQ3kIqXWv6OoT7S2tig+x9oC824LdbA9GtERwRV2sfurcF6urEulla01758/oVkS0y6dclImeCbcoviJuQDGzrBIG95ZZ8C5HBgrOW/AiOc+cBMeD2qcMA5NITdOrqmUVR9IXACp8VMZux6Ios/pO2JCSU+sD48Tu38w==
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:54:22 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::b2) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Mon, 8 Apr 2024 12:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 12:54:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Apr 2024
 05:54:02 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 8 Apr 2024 05:53:57 -0700
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
Subject: [PATCH net-next 00/10] Add ability to flash modules' firmware
Date: Mon, 8 Apr 2024 15:53:30 +0300
Message-ID: <20240408125340.2084269-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8b7112-7190-49fa-612e-08dc57cb035b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2cX2Q9wRjcNIj86e6549ijVF96MWpc1bzqqaJCBwYdug8ohdrXAmAlqLRWF7t1chXn6DyKIQ8Zx/BnXOZziBYYFO+IKhZfDJZVTpPnrJvHpaLlw/96UW0aVEw94K3YvdNk85hBhP55aMAiOYsJEHI40B793nLqu9JgxEPExwv/WhgTLE+Lbywb2nSmewDeYJ6bZrArAaUnlcIqkes0r2iA2fOZ7xiyCXHif6AnVcR0i1gy5HGRBEuqPf8VGQGDad3+HQL1RvqWL373cJ1AqbManfARtQUE6S5DX+6beU3mYlTvirKY/XY0Nfso8xlSimp+tI8ZVxGDAIeGsX6gpxDmuUSYufobGjqvJXE7qq2EkK1ed8tWHDzH6MH7CcSNE1tH/B3eSz0pcDjlpYu8NNXqPe4diKc8Kj2UAmRRAbknG6ZFtuYfPgPNbeYbdAQwVLLNLMdOIbAhIHtj/RACcFdfOMogQgzbSN0Cxt4b9XToXLR+2d+FVO9dfeArXQbVsWIhL0f+D9yqBM2TuiVh2H7DuICBHhpW3j3Qf16wCXQgJeciImm9E7TqJ2OXvYr3bqQm0kGkL3NLRmJIwrU93yJ2z1oE3eeaJv3q6XSG0fSxCccQitTCjlFriMaBh8sbirfXRSaiTIDSVLnuY+gPSpGHPiV4SBHgPwzZw238vlG9aidqTS3P3iV52Rnnrv0hfc9E/ZFsj6mQAP/zfX4zbckXulrPooKowZKY1IDIRPeNtqlAbw73f4ZVGf9ouIUIJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:54:22.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8b7112-7190-49fa-612e-08dc57cb035b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

CMIS compliant modules such as QSFP-DD might be running a firmware that
can be updated in a vendor-neutral way by exchanging messages between
the host and the module as described in section 7.2.2 of revision
4.0 of the CMIS standard.

According to the CMIS standard, the firmware update process is done
using a CDB commands sequence.

CDB (Command Data Block Message Communication) reads and writes are
performed on memory map pages 9Fh-AFh according to the CMIS standard,
section 8.12 of revision 4.0.

Add a pair of new ethtool messages that allow:

* User space to trigger firmware update of transceiver modules

* The kernel to notify user space about the progress of the process

The user interface is designed to be asynchronous in order to avoid RTNL
being held for too long and to allow several modules to be updated
simultaneously. The interface is designed with CMIS compliant modules in
mind, but kept generic enough to accommodate future use cases, if these
arise.

The kernel interface that will implement the firmware update using CDB
command will include 2 layers that will be added under ethtool:

* The upper layer that will be triggered from the module layer, is
 cmis_ fw_update.
* The lower one is cmis_cdb.

In the future there might be more operations to implement using CDB
commands. Therefore, the idea is to keep the cmis_cdb interface clean and
the cmis_fw_update specific to the cdb commands handling it.

The communication between the kernel and the driver will be done using
two ethtool operations that enable reading and writing the transceiver
module EEPROM.
The operation ethtool_ops::get_module_eeprom_by_page, that is already
implemented, will be used for reading from the EEPROM the CDB reply,
e.g. reading module setting, state, etc.
The operation ethtool_ops::set_module_eeprom_by_page, that is added in
the current patchset, will be used for writing to the EEPROM the CDB
command such as start firmware image, run firmware image, etc.

Therefore in order for a driver to implement module flashing, that
driver needs to implement the two functions mentioned above.

Patchset overview:
Patch #1-#2: Implement the EEPROM writing in mlxsw.
Patch #3: Define the interface between the kernel and user space.
Patch #4: Add ability to notify the flashing firmware progress.
Patch #5: Add firmware flashing in progress flag.
Patch #6: Add extended compliance codes.
Patch #7: Add the cdb layer.
Patch #8: Add the fw_update layer.
Patch #9: Add ability to flash transceiver modules' firmware.
Patch #10: Veto problematic scenarios.

Danielle Ratson (8):
  ethtool: Add an interface for flashing transceiver modules' firmware
  ethtool: Add flashing transceiver modules' firmware notifications
    ability
  include: netdevice: Add module firmware flashing in progress flag to
    net_device
  net: sfp: Add more extended compliance codes
  ethtool: cmis_cdb: Add a layer for supporting CDB commands
  ethtool: cmis_fw_update: add a layer for supporting firmware update
    using CDB
  ethtool: Add ability to flash transceiver modules' firmware
  ethtool: Veto some operations during firmware flashing process

Ido Schimmel (2):
  ethtool: Add ethtool operation to write to a transceiver module EEPROM
  mlxsw: Implement ethtool operation to write to a transceiver module
    EEPROM

 Documentation/netlink/specs/ethtool.yaml      |  63 ++
 Documentation/networking/ethtool-netlink.rst  |  62 ++
 .../net/ethernet/mellanox/mlxsw/core_env.c    |  57 ++
 .../net/ethernet/mellanox/mlxsw/core_env.h    |   6 +
 drivers/net/ethernet/mellanox/mlxsw/minimal.c |  15 +
 .../mellanox/mlxsw/spectrum_ethtool.c         |  15 +
 include/linux/ethtool.h                       |  20 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/sfp.h                           |   6 +
 include/uapi/linux/ethtool.h                  |  18 +
 include/uapi/linux/ethtool_netlink.h          |  20 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis.h                            | 121 ++++
 net/ethtool/cmis_cdb.c                        | 549 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 391 +++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 286 +++++++++
 net/ethtool/module_fw.h                       |  38 ++
 net/ethtool/netlink.c                         |  37 +-
 net/ethtool/netlink.h                         |   2 +
 21 files changed, 1719 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.43.0


