Return-Path: <linux-kernel+bounces-48396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A677845B67
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA601F2BC54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7F62171;
	Thu,  1 Feb 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBr/dLhQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0935CDE6;
	Thu,  1 Feb 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801142; cv=fail; b=qcBKdmqmzQMeKGtFtlOOYNrNQfabEbffYTRMgX2y7Qyidtd8QHlmOyFF5Zbql3rJ1NnnAIbk93Wg4DWEuC5GK6PsM4ikFD5krD8I863GlUfOoNguwHWT5iG3qC7mg6Y/K3p99OjO77EgmtbnT68VBP6OQuZUXXEgEJjAo1FuX0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801142; c=relaxed/simple;
	bh=Fv3b/p2JU+opmuzGlP4oyMuqGaO2g12PKD4n8p0wi3M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COhOiyJ5TO0l04KNHbmjl6KpQo3KzQy2y4bJggC/+tjRqLVTMRdpMwFvzgd46yqmur09rJ8POMlG7sEjD9WvMLlfEwkYrVRP9Aj7TMjU8LINHHnhDarBpGfdCGN1jBy1N45haG7+bQhvkoKO3HZ2X4X5BE8nG5gIKi9WSMp3QGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBr/dLhQ; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPBjyarr3RgdBI30UjIZrXprlJNhv7oErKQTc8ojJvwk8IW0t22UX3/Z29907xMpRD1MFLh/y9nMziTwzGLHWg292OrqWZ9QX+BEXT64XgEnZ+QfSPRXojfiHlNW+Vv6++i6Asjm0vVrzA+3VaMO6nNbkX69z3AS6ZWSgs5yIMwdZAzCHUnhDb85dql0DfIqpyQHJpQj1/26VtyICnQwYpsxxnW6zpAbxORwjLFw0wEaC1+0DEu7uJwJ+Tb94hQv21gTvcpTgi5m3Nte9XtBiukTVFbinZZqgsEXNoD9qvS3Q32Tv5NqlOYmFCh2/WiLNWTsnacfxvjZddtcPEF6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/38mfVspdV8+C7k3GfsCK6p6JLNpjyxCN71JloC2RLU=;
 b=YLyilhnVOFaKXY1qwK68M8YsxFNw+Y1g+Y7NuhyDRtBPeWLJ6r+8RADqYU53XlsxGKCat53x5+4z6Twn0WcLarXpXJCcr/8dp9cJb8bk/rUvtQ/6XqVvXWf/kOLhKb8RJfnXgMzKi6PI6a8qLG5q7N7y0W3nwuPA4hrUS/RQRALpKTrWWCkaOuf+uiQzYB+ILraa0W/wJNI3Qt5cnh1n4YP7Q1VfG6v56qsbz2KTOnVRczNlZNmIsOr4fK4/lwPIapmvh9fmXjQc0e3hsTgD/YkoZDwzWlfGrNQ8Q0ORZwkWvUyKEoGCMbqNre4DCf3uol/jN5HEG0ISAxd5vS/jaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/38mfVspdV8+C7k3GfsCK6p6JLNpjyxCN71JloC2RLU=;
 b=dBr/dLhQe8m1xxuC6G5WcsTILdgHhRNdzt+BUtpgjnhuHNvHzNMxwFRE6zCbBusGlTqTzr1oQRxBNKwWXcPCjin/TlH0rN9OkjBZs/D3LxM+uXLWbEs3iAJ32ZDuzipssA6DniwAjuM5DZj/5dHuoj8yhG6+QubiEejusKlvRBgKf/4y9k/sLkEc49lA3GU9xtSSyYVI8+KXJVgLu3FVRZ2MnlWGp7kJKTHDwUiMz+pihSA8jLdlKUejTfFhI+8OvjpMk0XaWWrsq/fTCAbFpkrCwHRmbYYhssdDrpdGZ2IfkuTpvjR0szHmMkpXllvUgGByDyT+fZ86x7NSGgzDpA==
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 15:25:36 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e0:cafe::9b) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Thu, 1 Feb 2024 15:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 15:25:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 07:25:22 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 07:25:16 -0800
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
Subject: [RFC PATCH net-next v2 0/9] Add ability to flash modules' firmware
Date: Thu, 1 Feb 2024 17:24:52 +0200
Message-ID: <20240201152501.3955887-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: ce83652d-0502-433d-eade-08dc233a0a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GeFZPP7cQhgCuvmQrqMTIGMvLQtNUhWtJXh9j6NXw67aVafnuEEwGZI/3mp/xZFU1DdoYvm401pZKo14T0G8vx0tP0SVHDilBOjoFiJcOW4kVgbJbiBwSUuxSXzQIQsYvrKyGGo1HIp4cpQ+wZI3g35+se457J4zvND+uMJls7LPLbW848jH1WAFwcTG0zSo04cepf5UjGE46JJSIhgrRlyR0YlJIVFBFJ6OZnzYZHbCRrQS41vmZbCqE3pXshNT30c3il7ARDMeETI9wwx2d9KFsPus9+CcdPEdsXTTsoViusGUgYluqQxgX/d94324p1eIZo/cf/JPuPW3TUYNEPoGpZWat3NGCuviafeiK4QFTTGu/i6exhPU9JjeR54Q7nCGafOEjOwHu5bsrYjsoS/varb07QPhuJY3Hki0Wsk+ZqbJoKE6IJIlVb4spAY8EdFYY/gjks9HJiel9q+3hN5tNOvPEJrHtpIE1OwB/nuhQu7TF4tSfVHICfx4oqQoxoqX23+KkZ5cFK+qf6dMz6yMnkNdKRKcUKjpiOmoHsBuDsBlnfIBkf89hHw0qBnx/Fhkv0I3k5moZRIaonEteM8XrB85QV0UW5M3ASxDoFrC4KjchnFxGFHaGT/3IQ+X3KWyYXvK7xhrjsY3e1PZCULPn9SIeruOSIwyC2RbiKnyaElfqMzIgBYwmJq8LUMZQqVBOy1lB2GjS1kz8MSAIQdRwrH8grirg5MhtZTfTXE1JvNNGIJkeZg0TIB0/jKy
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(83380400001)(36756003)(41300700001)(86362001)(82740400003)(7636003)(356005)(36860700001)(47076005)(107886003)(1076003)(16526019)(426003)(26005)(336012)(2616005)(2906002)(478600001)(316002)(70586007)(70206006)(6916009)(4326008)(54906003)(6666004)(5660300002)(8676002)(7416002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:25:36.7353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce83652d-0502-433d-eade-08dc233a0a64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417

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

 Documentation/netlink/specs/ethtool.yaml      |  63 +++
 Documentation/networking/ethtool-netlink.rst  |  62 +++
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
 net/ethtool/cmis.h                            | 119 ++++
 net/ethtool/cmis_cdb.c                        | 525 ++++++++++++++++++
 net/ethtool/cmis_fw_update.c                  | 367 ++++++++++++
 net/ethtool/module.c                          | 238 ++++++++
 net/ethtool/module_fw.h                       |  38 ++
 net/ethtool/netlink.c                         |   7 +
 net/ethtool/netlink.h                         |   2 +
 19 files changed, 1574 insertions(+), 10 deletions(-)
 create mode 100644 net/ethtool/cmis.h
 create mode 100644 net/ethtool/cmis_cdb.c
 create mode 100644 net/ethtool/cmis_fw_update.c
 create mode 100644 net/ethtool/module_fw.h

-- 
2.43.0


