Return-Path: <linux-kernel+bounces-148177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA78A7EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4311F2276E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454312AAF7;
	Wed, 17 Apr 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SO4ufyjb"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22527701;
	Wed, 17 Apr 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344065; cv=fail; b=iVRGq4dwY6N9h40gHm/rRw4sylO585xZ2nHGYdzbbwA1N0Po9FI791LzPfDvWhi3Du71lll0wINBmurrFC+28vhkIwF17Ce4lrNrN7Uggd39cnSihjmq0Pqo5zETLDLbXFXkNTccqp3gywchIwnidI+lCyhr2JMZIvs6czn2EMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344065; c=relaxed/simple;
	bh=yl8x5kCQUO34BNUMjWL9xnKBPylm7iCY6T0pulR1c0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icsiTyU31AbhwfLIUhTJ2pMCMNO3w89AMG3lH8DcqD+ZZqEVRTbl1f7BlbomlAm+eTPigyBBOlXVSBE3BtqIDAxiOkdXEcnSLpW2LlAFIg6bBJ5r+8G7fFA0vWBOfjtlwbIQdNu0rPN+q9QQcv1WN8hQP0JLFM/qQyydzCZSt04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SO4ufyjb; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xdxu3+Uy5IECV8D+RQ8v7y9sxliVl9qr5h0V64Ar3eOlOg/8QMyyE99dW4uvBKAS8Zb+976MgTESO46uVzeeOHMiPO9TmIAXn1DSC18FGxgtOMZoJni+c23ocDJnh6ceAxubRBLgiKoxxn4hcMF4Lr+G6UjoVnwTWmU5QvyClgvmJWTPcF4pT9nnAo0mUhwsw1y5D0GVXRgXt/4uvWBliOaBYmciPuIdkgUJAw2DTEXW5mzcd0//R37QADhBQy1l5ckOJZowNO2LMTzo+puR8X3GnlxO+RHH2rSnTueInxhHuk/nWRZmQgWXk2rBrlwWBwNe9Lf4jMEWXgVuyJIQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwPPMptZlI2dVDgVU8q6BA4u3r5Zugu5n795rnPJJoM=;
 b=k1LjkePXaYp+OZnLDf1GkNgPZglcJ5oQlsp7AFa3AEKmKU5LUnh7C6UQvoOTzoLlD46MJjQiFvoHmOUaK5/QCcVm7flxiBU4JIEudGUi9jxi+nHdHaxzHXqG89SYeGs/eSQsq2moyDsUoBjZiIJ+ow7dbJwxs4SD6tM6Xgt8nbmZSWKdvg6uHWGkfZtYUqH8nrQt4uL7k7YbR5CZjNrtpnYTsBS+1OV0PgZKWQCUpBYZbSNrksGT/iJzfW5CKx5cYgTZCS+szZVFhvXoK+9RzAKX7V/LJA4wQlOynE8jUs6YtmN8BrMQEtZpH8a2YHNK4ImP5rugFMY+7P2R8/qOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwPPMptZlI2dVDgVU8q6BA4u3r5Zugu5n795rnPJJoM=;
 b=SO4ufyjb5Jxkv3Jvs/Ns2vsh0e5X6IkpKDuZgtA/3YoAw86keyPkKtJd7kdfjqZc3p3JSA39osq9iMkXVG++JbL6s2fOAsyvcCa71TmCsW5+FrHMP+Yiet1jEqH0i2ZYKhBGtPKll5SC7r8uyLj5Jl5BVsp9hnH7+kUl9EFkV7Ku99DooQtkML3ZM101Cxw2NHqAHlAiCfAf7jLmnhigUk9DQrLeB5IJSouYci6IdyoNjZFXAsSmV5ikggFZNGOH9dQre3n7e18GPDhMNzaDxXxj9vnnEasZdhSdmR+RUhj77p5cLN2mIvA+C4Tk/1C6/BQXgMmUkUNeYWIdyPOw3g==
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 08:54:20 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::65) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Wed, 17 Apr 2024 08:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 08:54:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Apr
 2024 01:54:06 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 17 Apr 2024 01:54:01 -0700
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
Subject: [PATCH net-next v3 00/10] Add ability to flash modules' firmware
Date: Wed, 17 Apr 2024 11:53:37 +0300
Message-ID: <20240417085347.2836385-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3427c30f-99c1-411f-91b9-08dc5ebbf8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gswcv7yT3h9GmymzYDfY4Bw7QFHN12Fn7bRxrStPf3zBvt86AegPeA3lazYQCTbEXL+HTp20Egam4h6KJkOz7ujnyOh7m28iElsqyt19h4b3n2YDmpOfycFt2SKhYlNZ/5/pb+ncH5cqmgyMs2GV9QOUukNpCPMIz5dMv54QPZh1GSE+XO0LxwSXAJDquk4IFbFAiq+9vMLWujqNVgwCiIDHhiO7RrLGGyc+cnekbzTDtwnqCJHmKFDagZzJI0j7ysmaWHdEoAp2q+/EmeTgdrXjksocC28t3pNw9Cg6rTmOSlDIi4hnBgrjuPF62zuzam5ptGwpd/8rKv0gkLiKw1EhBYwzkL2fvJqw2308pGhhl52gPMW27b7gic1QZ/5sLmQYYm5YrLpLFP6TMAnj/pIvuVuHXbbGoCAPvoTZtDquWI1+CzpI7S6xx8SWChrWInTUdZTlYUETD+d5MKZWkxpHicU8LK9iPQBnR8XZ7yVHDa++fo1bjtYCb4DVnbI/iyu59ucgZ4GUHW9kdClA6XY5nZRxHzmlAFj3K787TLQya+PWwYtHEpg3LCahgoGq3bkXRqapEEywXmcdeHYvhb4o+3W8k+yJUDx8lxx1yhWO66Gy0lci38lcliGNU6zwCenNe3KGKFQ7+aaxuh50pnxaIx6H8wjY6qkyG6BwLDFnBu2Hxu2XFtyW6Qfty4pucfNC+xDcbS4DgmyE7Ob7brIRGK7enuNHioo9L85D6Urop4gQbJiULXw7X7qifpXp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:54:20.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3427c30f-99c1-411f-91b9-08dc5ebbf8d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

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
 net/ethtool/cmis_cdb.c                        | 579 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 397 ++++++++++++
 net/ethtool/eeprom.c                          |   6 +
 net/ethtool/ioctl.c                           |  12 +
 net/ethtool/module.c                          | 286 +++++++++
 net/ethtool/module_fw.h                       |  38 ++
 net/ethtool/netlink.c                         |  37 +-
 net/ethtool/netlink.h                         |   2 +
 21 files changed, 1754 insertions(+), 11 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.43.0


