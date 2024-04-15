Return-Path: <linux-kernel+bounces-145028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A698A4E78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72651F2220B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E237269D0A;
	Mon, 15 Apr 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6l6PXf9"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F405FC;
	Mon, 15 Apr 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182872; cv=fail; b=cvJ67NGpphFIjhXNkmcO0TupognTcSm7w+l6as8WquiiA9IOh1mdS6fIT9We681KbG9TzL0rlZ/Nl5yxL4wXLsbxsslexVpFNlG4ZtOSIhTk8fI4WhUV+r+RUyBKp+Qtew8kfYKI0Vhf4wydRT8H8uwebeW+JJ/uVer7E6FI9uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182872; c=relaxed/simple;
	bh=Zn9EJWv4QhRAcTogFIBG8yggFWfI8KJr5ZHwkBRLtms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N4WtvB+9AxkX2iNSjX6eVOmGS661gd19WL2McRhAJDJErc5TEDvHn53s5F0a2316Nl/YW77GimWzbUiChKk7o2eq9gwiwSb41Vwv3SLUAH33XYQZrAOJVrJXq/lOmn0nQyucBTa52eAfsDvgUDmSrVSrGbQnRMiV2/jC1Y3KoWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6l6PXf9; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjl06OSvoY1r1OgG+bAm8a0MeAwa/lvtfHklCCld7/hdsKjyha0ovxxaoBhJbAvrPfadVzol3e34xF5+He0TIC4rmrQ8z+ZXT/uoDQnkiQ/7t0JEh1blBLhmw8bE3iq4cK9bgyzyNKtkcNO3QdFEZi6XrYoYB83TapCvPoyHHrpLrfA3j1YQM88dUFb/OjtRhLKwuJ855PLubqtrA0ybXMjvwcN+wIQ5R5BIXAPZ5qXupJzac4ptxi6ECLSr2ysvWqA+y7TreKCkwIBGvmB3fv9xVYYCqAyWmtGibpNyWB6h8ZT+GQMbqweHuqZeJWmksGkskojwlyxRUrmA2bSJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqB45ys5hTiWzeuW1K6Dl9lVMHo8nc2pO5+Dnx0Sa1M=;
 b=d8ULdCNZtUAABV0RI9D9lctJBL9T9SZE8gQQzzN3NbFKBDx0HAbTGPpP9CAmGfcOS65Xg+uk07c+hPYRwxIf43P+V4H5Ehhbes6Q0RIC5Y/k5gIaqtBwKYtl6Ta8AQmji1aTJ/B9fwqamP7E+J0Rm3N9CRl/NuyRUVY5iR4v5q52Le3+I3ELPa0qRtkEL8ynzaF1sjoDiyIx7DyrUD8ZpUKvTrfApw9oOzuF4AvKh0xU5CPdhbHCqDb8FazSEIvvLDnepd3CP/V537/Q4/SvTrpoTGFArhFcvfgTmVqRE+pwAzVmoXtbdK7259KgaQ1bHLC+cada4L4lFaydGefujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqB45ys5hTiWzeuW1K6Dl9lVMHo8nc2pO5+Dnx0Sa1M=;
 b=D6l6PXf9ypDAV8+f3z7iVGMkpOmALNVaJF3sNBHktZcn2HhHf+ElvsGjE2S/zd+GVn0aKE33WTotgsoQdJr5kkHBt7Zu2W6Npk3ZKMN7uJ3pJJ38J9Yo53USwg+7f6asoHwo/MznaXeLMTwgMRE5XLuj3C5WAKfYBobl2jmZ7WIuyrnm0X3mQ2Aq3ntirTn/glslQF/pGXF4e9gHDwx05i+BLq9/YOjpCrY/Oj6fx2gjicUi2YtvLgqlB6tyRbyqJgAPehZj8TS/27NncieWE8AiChQVGWU5+pgk1z/I5dUfIrVjELnwIBiJsyVSyHLDjHU/xo/0Rm7X8cRvS1rb+w==
Received: from PH8PR21CA0015.namprd21.prod.outlook.com (2603:10b6:510:2ce::12)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:07:48 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::23) by PH8PR21CA0015.outlook.office365.com
 (2603:10b6:510:2ce::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.6 via Frontend
 Transport; Mon, 15 Apr 2024 12:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 12:07:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 15 Apr
 2024 05:07:36 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 15 Apr 2024 05:07:31 -0700
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
Subject: [PATCH net-next v2 00/10] Add ability to flash modules' firmware
Date: Mon, 15 Apr 2024 15:07:07 +0300
Message-ID: <20240415120717.1251864-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8ee3e3-f5d9-4f2a-1fc5-08dc5d44aa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8syKLYxs9h8F5oanC8yALdr8spW1OfTu9XPQxdTiK8guE36u8PFi3RcIMLhCx8H/G9SKzxAbUGjI7Y+iWPIIT1ZN0A634NzHGtwRuBljbCBnyRaybe8XWeiEF5aLfcmPBemN5Lpq6lbktKwKM2MC/Xh2GBIMmbXSJko0kMGmHv/28W4Nc/447IOAQ7EiqhQl8oz2lorJ8KOYf1dl8unGTAa8NyDkDTFG7dKTN9XRqWBSSYaFWIonpPkAvdrBJ3Up/GDBEU36PcsA1IBKhCBI80JKUqhzsTkTC08hrjPyBuw3wWI1siPf8kUJzl2IGl4AFPprvogFpNBXcx1n1tnSoQawl7FtMuKJYWjQ1uV94LA6a8Du4vVyFei3EnljPv+8IrehVMG6fwTntNHetUGlpzBcZAgmUFV8Q0iTuI4f5/JGsGXD+GU3pyQTeY88VngnP4IEuR5i9FFUwMBJBfQpEDiwrfbuGs8DJVZDV6TqQQ0nEIcUS6ceNZPjIkOU4uUHIsb4syoidfVQnvnIF4STkzPHD2VRz00tV3D+VVb/8Mv5Y5hWghtbGnGU6hqxhbWhbD+XNzH0+6YD9N6aszGF5dbUuAjIuJ4Az+mUxWwWWGH+5kOxq6NWAR6C2NLJJnIlneUjmaUVWvGcN4sZDiejDlxpkoFd8Txo6LhP3Kt4BYgtGX6dbePQMzKnP394DY0c6fWQYask7DiAhfQ7+3ZaoIwIZlgLl9yCYtLiRvN7iHJGRX+2RMibrgSDouX8QFPB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:07:47.6405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8ee3e3-f5d9-4f2a-1fc5-08dc5d44aa67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

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

 Documentation/netlink/specs/ethtool.yaml      |  62 ++
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
 net/ethtool/cmis_cdb.c                        | 581 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 397 ++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 286 +++++++++
 net/ethtool/module_fw.h                       |  38 ++
 net/ethtool/netlink.c                         |  37 +-
 net/ethtool/netlink.h                         |   2 +
 21 files changed, 1756 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.43.0


