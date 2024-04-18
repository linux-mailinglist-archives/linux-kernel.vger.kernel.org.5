Return-Path: <linux-kernel+bounces-149892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF08A9777
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552961C21F57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778AD15DBC6;
	Thu, 18 Apr 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjvdb/87"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB815D5B8;
	Thu, 18 Apr 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436528; cv=fail; b=c8kJltmhEYhsXAJbZTYdb0fUgdDLiFfKw6LPHD+a8HNzBRFFcoC3QS5xuIaSs9oYW07IBcx/m2yvKInyHWQxR6+QbjFCbEXTQu4Rt9AZDVuTYwTHuxA/CMdcpz0KGKCL7KQECMnPrAkYHncvRj4grl8AYTfrkoABNBa+JrsdKN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436528; c=relaxed/simple;
	bh=xGQ7K3Qgen8rfVd2CgrQPRoxsikXOsto6xoVQeg5Fjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0ZPYNxH/r95X08squs3RDOgAB9EHdyiyT6imbONQUJ9AA1k+Xhu7f/AFqYkxnxiF7o9NaaLHOmkGajykHcW1gv6yKzl6D6Jhj+ac9lxHTBt09vE3D2dVzZd9sN9gLC/TkNX1r6NG9x9TfqssHBK5RjQK5eOGOAxgIh5JEimeyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjvdb/87; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsODA/TjyrROrYp7LzI171EB9s0OgpzB9d+mhnxnKeujXueD6wtlXOtr55gfe/8cipcdI11B8LU25sYSK0WB3uRDaIDW6Pvaf/WcAUvAOrAqQjLQsxXGth0TVgmwxMcNqJLkElbS7popqozjjCCZtZ3QTc0g87KOfp7CgFvQVIrRxWTJPOp6dYe9oBCKzbCo6ZxR3ud/Svu6NgmX2bbEdvrvjWMoKfOc1VuOpaeYRfpfqNI5jOIJuNWhYfdguFTsSiAC4FPCx6fqASC7hRc6XsRDt5Jh+F6h9cTTHXOQANGVmg9v4/oQz/2qIoRF/6xyT5BsvoUma8fx4lWTKia01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyVNi6JFicY6Nkd//muwEhFOsmnBmKGqg7efYg3HkdQ=;
 b=ap3vrdaxofskWukR59nuTP3TQnjx9U844EM3jNt/enU+Z+1sF7oHNU9bEjXIPfLZ8tlBh3Guqz3T0sOImXw8Wlk8IZuqM+PviGfslVqeIt/qIxRSE4y0s7hVjugzREb60iCWbFLoz+13uMiVuXmb2/mw4VMM6f2ERgX8ZtOin/Amj+3uo1pjcoSU3jJl68EuLWjdZBjJ3HIK8FDcJXk56NmydMNmVc+1I6fS+PjqhO1+KROEAvZjvDE34WNejYLI5LCMuZ5OU2QICym1iqmhI5ykVczzNv/ufsg8dD+vH5T7YF2/B9hgYwg+Y44p+5tKPMwHrFY+KeGG7GNpEtdneA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyVNi6JFicY6Nkd//muwEhFOsmnBmKGqg7efYg3HkdQ=;
 b=sjvdb/87nDjdmYaggG8lu6BoaSGSLv2F/2PkRg9v6SRiBB38gQ50M2rH4kmTBKYgvO8u07E90euEo5TM43Ijoa+D9bW4dim6308r6gMpEQDZJ6Cfc3aKFP1M57A8xDLGltCln2cFxbjVpH4Jz73s35JQ9rbcLJs1DehQ3CwSNcZtDcoirNtvL/czily1ZoYwPt+AtReXTeE4mmctGGph12Vmvj+mBuCfyMhuEif3N4hqoeneWk7oA9ZugxYhrR+EIYyxfsnuu84bO6P3XAalBcCLk+ZWtUsgan+88xyPAVj2sXCIMbs1VsxrI9YWuZtu7s7El02DZBAJKclJcYjw5g==
Received: from CH0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:610:cc::6)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.52; Thu, 18 Apr
 2024 10:35:24 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::89) by CH0PR03CA0061.outlook.office365.com
 (2603:10b6:610:cc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Thu, 18 Apr 2024 10:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:35:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 03:35:12 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Apr 2024 03:35:07 -0700
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
Subject: [PATCH net-next v4 00/10] Add ability to flash modules' firmware
Date: Thu, 18 Apr 2024 13:34:45 +0300
Message-ID: <20240418103455.3297870-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: d98f2f6e-c952-4415-89a7-08dc5f934152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUaHBAGNa4mfIGefuJhwDkgOvApbzPFwzwiMzWQKejk8NjnvH8Q/LQJsjtIMWJDsHAJSvsxzosayG2pn4G3v5FonYSKwZKalaYILlpl2NNRg0ppJCSwGCx/UEhch5KHi6Cr8zi9Aqs36/eLC9+IpWsnfxRxyo3LEU+CqWzSFX0ZC0qT8DYtY3e+q/RDuClQyhcYV59dRid7YMbtIronGoifXb3QoYOXFhuB6ErqZqS9kT5IQ47xFcKvRL86DIHYxcnY3DfyI0hqXpbzJUjRQZ3ilqnXbo/zV+XKMYge9CSUOZ1/Y1MjncOFi4fN5gIkXMUDFSmy+kYkAHV2HsV/5kD8c24LZxHHxCuwJ8XOZSqWIjxL07L0WDZGHcwTe6jUmqr3ICmDIf6RhA5UdZlyjL1dkqVwf31w/WRVqauAfGxbDbrP8iyD/SxQikNAfPY3JHrCWxp74Y1I3BNEfkFETQmLu92597BggKSLw94DPklJXXWkC70oDUeOPq3v03ejNg0LI8DJ2db9YIs6CWA+FnhW6JqFMGBc/n1SRs0wR+yZZEt3LUh9oWjXFphsrijX/fbyAtCmLeNAT/Fw9StuDfKvUjI7xyfag9GLjmwTwSX/+O/Rf03qR8aVVXNLqwU4M787EcTnOI63WfSZyFk2be3jlhpyIR5fH9A74Yc6vEw+hGV0VIUjdJbDLiajaWUDmR4CBBm7MtJWNnpIyWgci8T2JxmX5mVEJMJuKW6F8dOKe5Waq9XgxLKQHlEUIe1aT
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:35:23.8808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d98f2f6e-c952-4415-89a7-08dc5f934152
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

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
 net/ethtool/cmis.h                            | 123 ++++
 net/ethtool/cmis_cdb.c                        | 579 ++++++++++++++++++
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


