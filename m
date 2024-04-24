Return-Path: <linux-kernel+bounces-156962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B48B0AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24BB1F22B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B515E802;
	Wed, 24 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEv3h/RY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2015E209;
	Wed, 24 Apr 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965493; cv=fail; b=LSZNzPCDkwQF5a3jTlaX2Xcn+GHUAJCd/1L4AU6fnzUDNgBpFyeGk0YnXGkqryi+L5K7FibPSCdV/1OqOqu0DzFi/a95uI1qBIAnm+ynvdQnOcKfK+yBQaq5tQyc/T3xQzqOtEoU8ejPJXLoweqXfZ3zOVoNamPWccF8wT/5zs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965493; c=relaxed/simple;
	bh=fvysu4StwvtZ9HT+NOcaVgBeCXNgXYuM7ofZW72Z2F8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gVcRdFmwQThgvbNaAFjf0rXF8BzvkY1lMDXpWdl/Mr96Q3yYoFrd1DdIafp/az41RjjrT+1N0tlOjJjzvw6Y6y0MUc+hW7Y0EV9oiLvHnLe6QVQ+chOBN38UZ1Z4dE6Kda/0UqO3EdZoakEUumsSYBEfTSd/Y9UAayYOxYMwUD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEv3h/RY; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHEmCpRQKYSsSbO3qg8ryOdoFW5Mqk3OxMMK2RIFJ5uzoEcCQn4yaK+iBX+qQieNRguGXZWmnT62qT2pn5EfQTJik+eP/6a/LenuDONF+2yvOPfFAAIoRNfYOFv9ryxPd/AtiQzvNF5JcvsXtInufmhsMCJQPq0PI3f9K7hf+ygUcmw2uhi6sXW9UCH+NcAXwn0H+NTp7UVjop7gs8w5bc9bv2/UnbIF4gDcthkOtXI5NlOvPO/kDBqujAfq6CqxIZUAuKeoSVrza3sw2etR2PwUKvhcUOdZ2wAWGeTHtRsMVK1Bgn7JSqmT1fn94nEVXKgNWCD7quCJa5GML0LJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZrgPdacXl0Q46JFdIcvOl4nFr0+czBldKRu3LZ+Yy4=;
 b=AxmjB8639NlGdanu074wres9xuhEKLKgonrtt7O6WPz1whdXLUc7eJ6afrZU6pLqgG7q96c4YW8iAJK/pRbS6mK40lNsyhP3fgafWzpov4AinXAHKk2ox9huq/1EdmRukOQG1nZnO+iUzOGLeMGrOIVWOe/qmiw39gtTEF/ovmuCbMwf3tft30CaIxrbskGKCmgAFLbxTdRzaVK+OjPiHEyj0zvK1tpGFDHOZELPl3+jmbUcyK1/dAO0GpJI452JTjpqkxziMdNub95k8qGLdVT4roKdQGF0ncwxHDJ+lEC8JHGHftq7RUYEepNwsQfV07sAMPdeZ3tEzFiHW6JTTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZrgPdacXl0Q46JFdIcvOl4nFr0+czBldKRu3LZ+Yy4=;
 b=HEv3h/RYXtMJNbdVkIQ1171Rr6070QkQVIoRtwN9A7vnbzRC93k/FqmtQZowB9xHb4GWncqReI7q8DfkfXNO0ArWIf+gm1LzpTICFQ6T20oG8ZofQLWOXPCd8Qww1c1+TLbyeUr2JQalkJ9g+sCEEYnm2oPXJsyHJaYNp55319CYYKYNF6AGGJah/FrzUJw5zmmGcfIAFBJFAdKEJTrovYa44+EgNuXOtpOq/5MkvqnhU1uXcgO2HdnqyJxW7O1ajtacrBtn+rrd4BVxGRXRhVC67v1OR62ru9h+cmc9z6Yn2Uig//V914Jb59kShAELqkrX+ZTOKlCRgtJ2lCZmMw==
Received: from DM6PR06CA0012.namprd06.prod.outlook.com (2603:10b6:5:120::25)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:31:14 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::61) by DM6PR06CA0012.outlook.office365.com
 (2603:10b6:5:120::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 24 Apr 2024 13:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 13:31:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 06:30:42 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Apr 2024 06:30:37 -0700
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
	<idosch@nvidia.com>, <danieller@nvidia.com>
Subject: [PATCH net-next v5 00/10] Add ability to flash modules' firmware
Date: Wed, 24 Apr 2024 16:30:13 +0300
Message-ID: <20240424133023.4150624-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 18af7d7e-bc98-4188-fb85-08dc6462cfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BpTRmFdLTk5dGtoxsZ1xtxv2UKMYtarsVWeCZw7+psuj/zcTmiAWuLdt7oyv?=
 =?us-ascii?Q?TEUaWXUrLmwGkNXbeEfgGuCJO/uu2qFn/9WFKeFQ7NRCa8yV4KwiYnqm4oAQ?=
 =?us-ascii?Q?Z7l71EZed+5Tw/Mxw5D3jR8qsmALTx8bTXpXd+v4135Nfp5A+lkagTkgiHVW?=
 =?us-ascii?Q?6Q7cgyOzYSxNi8RFmc4Ik9WrYGHTFL3OoW32AufWfRN69p78Oc/MnlVRl3mk?=
 =?us-ascii?Q?lQAimechKmIxL8saW4QXdZl1kiInQ4b8Dm1QAqiAaEjUHVU8FVXiOBrZMvfc?=
 =?us-ascii?Q?yLYOn0DqIa+OtwAuxo7mi49LeflYFrE9K8xqL2RTqa0W8VF2TR3/KI1K/m8m?=
 =?us-ascii?Q?uhpFV2Mf5Omi/JreaQSdMtzQNNsHargUwSudfIn5F7i2+qr2bgQX0HLnP0oy?=
 =?us-ascii?Q?FtvW5AoJXKDh6eSGbqOBdzBVA+2znMRP41ue8AYA8LlUG/VLCEel5elfU0lJ?=
 =?us-ascii?Q?8M/ZV9xg9OGHRwgbdzf1QPU94m5FStnFNepcrWSZy9+V7zNwtskRv8ga81qY?=
 =?us-ascii?Q?zvDFReKWz7G9p3+xn0V3+iYwpG3qdZY6EIa2b5wScP36R9R4+mddolHlSL/m?=
 =?us-ascii?Q?xXZU1/bd19x3R6FJP5rGbfK9Bm8ikEc28H6KmZ4uJJ+EmTCnONDIlF/y1jsT?=
 =?us-ascii?Q?ePTWTvi4iCeKdQuYc+XvX8TrdavH/IJtpX3KgVHgUrTv1tQ5uI1II54RoNjT?=
 =?us-ascii?Q?YlIy8lYjXYRxYKOUxvuMwFg1KPanWqZ565an025/txBCxXaL3zygPPk1geOy?=
 =?us-ascii?Q?+MLMIAlgGgVCfLqh8KVDPVOuvvlhkq/HF7Lhqa11+yWTvV0M18zmidpD+mVB?=
 =?us-ascii?Q?BVdfN2pFfbDwJFtqinMRo+4Ej4E7FMSr/W/sld+vcu5BDmOUJggXBMcy0j/N?=
 =?us-ascii?Q?6m6JUGtCufDPnXCpYAMZzjN76hCaMe9gt3fcbq6BtFFNNgxy243S/z0lOFu8?=
 =?us-ascii?Q?D9278/K6eRHecf47Et5cVc6Cz+oDWhIrh4O3RFtOv+Hbl6TjKcQrhWl9ODVS?=
 =?us-ascii?Q?AnHGRwAjpJCJWxSRrCMayaecI8c2B2eF4QQUaKcAae2M0RQwIsf7tW1eDZTT?=
 =?us-ascii?Q?v5AHWJeHnF9cp3CVV+M0qYkf6Xki76tStPol01c/+G4niwRIMd8JhLLkq1Fz?=
 =?us-ascii?Q?D2GIDpbG6LXbbBNfI2y5wyiKNBt5tn0AP+4IBe7sC9Xp0AqLef7je+yIzbR7?=
 =?us-ascii?Q?A+A96uE+/qoOrx+kGYfO+i5zc3nfp2+wNAuRncPqo33KsJles12hBntgSKGc?=
 =?us-ascii?Q?mF0JSR8vVhhNoWSVXNL6UT6lXS0MMVa5hl9+Pgtd9K82cgJH8daLRb2bwXdn?=
 =?us-ascii?Q?Qv19Mncurl1IDiDHMbkSHBZbjdZRrCfq35Mw1pqWX49ewnAJ84blXeNKDosa?=
 =?us-ascii?Q?8tWXddU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:31:13.5970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18af7d7e-bc98-4188-fb85-08dc6462cfeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

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

v5:
	* Drop all the inline in cmis_cdb.c.
	* Modify tools/net/ynl/Makefile.deps so the ynl file will
	* include the ethtool.h changes.
	* u64>uint for 'total' and 'done' attrs.
	* Translate the enum from ethtool_netlink.h to YAML.

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

 Documentation/netlink/specs/ethtool.yaml      |  55 ++
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
 net/ethtool/cmis.h                            | 123 ++++
 net/ethtool/cmis_cdb.c                        | 577 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 397 ++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 286 +++++++++
 net/ethtool/module_fw.h                       |  38 ++
 net/ethtool/netlink.c                         |  37 +-
 net/ethtool/netlink.h                         |   2 +
 tools/net/ynl/Makefile.deps                   |   3 +-
 22 files changed, 1749 insertions(+), 12 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.43.0


