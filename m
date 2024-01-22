Return-Path: <linux-kernel+bounces-32545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390B835CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487FF1C22687
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2C37149;
	Mon, 22 Jan 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aLhetqze"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86BDF54;
	Mon, 22 Jan 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913170; cv=fail; b=I/MPeXp2SaWI9KczUHsVG3MNMQdE/TixVUnGArYm+VAXnHGvyb+w40R3Z7bTYNaJOBunDul04bGmUrdo9fnwBdElo1I4cNY84x8sqdelVvKpZ1i6A4AdtNMBhxjlGtQ9C3RVck5FRqLKsDEjLbSF50/K4DO8PFH2i7a5yxpoqWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913170; c=relaxed/simple;
	bh=gd3dQZ9iOOdj+etiufQmzQDm8rH8YJSIz0AFrFx7wCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InubQpasQo9evmZPjcVuhPWM20wRbVi5ubDTHzvBIEvys3KvmrSdutOsYfYcqhhh7nlItHJpMAfDJBWj0LcZd4fGnbsJI3qxx3gIL5aCpKvjGLcQXx5x5ytJNpNht56bx7T0w3Dnf6i6xO2huB6O1xC0g0kdG65O62ZDWAXS2XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aLhetqze; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmD7iOM+a5Oi7dqUBJC2C0ZgKOb1RqSfDlNXi6Gu2L8wW3zkuY4Sh25p/+UdtJ79GsG5T/Td1soFroR7YHnmzAhhUL8o1mVp+6EOR5TN2uYtVzGMlAWFwlT4f6ENmJvBzCzd9KawOTWDBvxfMbY9HVYcFKafLNwD9JALk1y5mswpi3PpRhVrq6jgMcsirlc84RiQ1It8c00D8DMneBsF7MJfOjqW1tqJ/dxsC5pnIND8X/2FxcNlRTY10GMr8nKOIGJ3+iYGaVAulMOhfeHjy7ZAiJAn1auyfEeArR2nE1MQzgtr0HTCmK6yJGCTdqFVaGDSQ0nqhnClgC/e0agvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BywKH4B9/pctSaVjQ+h5N0ZfeZITnMqTYuq0yBkEPhs=;
 b=JYOvs1xaNcRZngetu70QK0zW5f7rKr3klrVL0RRANt9DTT+ctvntr3rtv+Z4RX9cQ180EyMr3EL0jaS4jAtzRk5U75J1c7diCKpp9B0GjDBilsRh3brKgc4WHl0+krBNfboXzS4DmMdyfoObJPv201dG8LIeK3M57gu391UNoIMdY4PQa2fG7oS9m4f7p98BTz3ocugrlwUHLiol9XyWtScMzQr1mFxj3WtFOvTyivHU0NZLrrYnTFILkQbS2D8YiO3BQwxkSknM62upII1RrguE244KY6kXXb1GvHRbTaWSuFhaq4CZwYiiSccKOTcuD6mIM4KC4ZiELupy3w9atQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BywKH4B9/pctSaVjQ+h5N0ZfeZITnMqTYuq0yBkEPhs=;
 b=aLhetqzevR8XvC1A9gsk0rMEqgS1by+5U1Im1xQFctZ4LqlfGNrgby9C+joYSv18XMOEuTA8lXbKn3a3j1vwNTAj8HhCiGscevZHywlNwhbv6lx0PKma4yPqRTxeuW9WOX/VMxhZiRUehYiDSJpI18DUrrPZRNJesvSDB1FJhm9Ye1Wsj4VCRMCTPj2gnirRMGPLwbN3GTH/ojEMLw5lkgbcgIj3qodNkaO0NoCFClptKjkb1rMA4vgth3kIvRC/XsVyWIrkirGWp+bICuhlXhQg8HYemWKUb6wvtHFq4FftuV9MIHiYrGJOz63E2VtW/1Li5Qoim9bPQaCGaerrqQ==
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.31; Mon, 22 Jan 2024 08:46:04 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::2e) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34 via Frontend
 Transport; Mon, 22 Jan 2024 08:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Mon, 22 Jan 2024 08:46:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 00:45:50 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 00:45:44 -0800
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
Subject: [RFC PATCH net-next 0/9] Add ability to flash modules' firmware
Date: Mon, 22 Jan 2024 10:45:21 +0200
Message-ID: <20240122084530.32451-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: df2fc91b-e482-4249-792a-08dc1b2691bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	udl9wU68F8t3WDtL1FIjLqGkr0MUuruF4VNfYPNFtDW9hDfLqyXbfjEhXwUtYAva4QZjJ0ektX9/kD6wh2gIWnQ4+oT/lA6HYebbj4fo7TZgaK8NWzx/gagxSTJRGMyttOOfHDHobr3gyagjIkwkxg2RQGiaXptM6Wnj7iP+W7/Tc77bxKo6CvTeV/i1oIBp2wt2bE2rIBFoaVEQC5uVoqGPTe7/e9UsLx/w7l8CB6gwh2ep2xtptbLfKSeitZsx0sxdJna71KPM1dfiRhOOd56L4DQiBrVHsrp2MNJlGiSdvhAS9M8beKK6oXXo+n9iJ6GKQZOj1ikCmQT5ZRTbmlJEr7WttHpRMtX6XvVSxeQU96E8Pbok+1WrYj9n0EeBjrwnr1q8QrwwB05bexp1TtpaYYQnKriMaNd0rGsCb3nLFPvixOndj7Mhiu/QDYkp67LHGype6usUdYNxnyIWYbRDNJ2foX5iuGMKC2WthwrsswmIFFT7iVjRV8x3wlDCAgOMTZdKi+dabylrJ9vec2uitcPM5uUo/OYxkujb28cyCnHzNyosh0Zmk7KQ7LxPCAHFWnE3+ntEhdbeduoFtZUfytnLS5QQUrvbxad/szjPjGlbYIGAGBerRNPJl2ueYw2WYXomCMzJu2In3IDxf0pXwJ0j8BSk4GBDAkTpwIb7XkVwB7W+43N5RqBffrHbDYGm4Jqhh4nNnlS1aGvbnF1TrK59F3wime7MiTlOAZcCRs3dluTox8L9jcAcG+IG
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(107886003)(40480700001)(40460700003)(4326008)(1076003)(8676002)(26005)(426003)(336012)(2906002)(36860700001)(16526019)(70586007)(356005)(6916009)(54906003)(82740400003)(70206006)(8936002)(316002)(7636003)(7416002)(5660300002)(47076005)(478600001)(2616005)(83380400001)(6666004)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:46:04.6520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2fc91b-e482-4249-792a-08dc1b2691bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557

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

Danielle Ratson (7):
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

Ido Schimmel (2):
  ethtool: Add ethtool operation to write to a transceiver module EEPROM
  mlxsw: Implement ethtool operation to write to a transceiver module
    EEPROM

 Documentation/netlink/specs/ethtool.yaml      |  57 ++
 Documentation/networking/ethtool-netlink.rst  |  62 ++
 .../net/ethernet/mellanox/mlxsw/core_env.c    |  57 ++
 .../net/ethernet/mellanox/mlxsw/core_env.h    |   6 +
 drivers/net/ethernet/mellanox/mlxsw/minimal.c |  15 +
 .../mellanox/mlxsw/spectrum_ethtool.c         |  15 +
 include/linux/ethtool.h                       |  18 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/sfp.h                           |   6 +
 include/uapi/linux/ethtool.h                  |  18 +
 include/uapi/linux/ethtool_netlink.h          |  20 +
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/cmis.h                            | 119 ++++
 net/ethtool/cmis_cdb.c                        | 563 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 371 ++++++++++++
 net/ethtool/module.c                          | 255 ++++++++
 net/ethtool/module_fw.h                       |  40 ++
 net/ethtool/netlink.c                         |   7 +
 net/ethtool/netlink.h                         |   2 +
 19 files changed, 1627 insertions(+), 10 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.40.1


