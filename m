Return-Path: <linux-kernel+bounces-148047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E68A7D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE95B212CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36F26CDA1;
	Wed, 17 Apr 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NEUbkjDB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6D604D3;
	Wed, 17 Apr 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339049; cv=fail; b=NwhJDhyDRJ4TRz7MUnb3apjACBGMP4mO2Dg2bNjFG/CGPF4KWvd2o8ztp0fFL8dJ0OiLxCwf8lOU/mo/el3diSibfH9HdcZmdfNhpXYh69UYsq+pVir5N74Hvv24BqfKpU2S50dkmfTChOdmqL73miziMqU5hdRpqe+QCElrTUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339049; c=relaxed/simple;
	bh=aIFduZYNjuZDYhgFmTvvcMIhaPALoIRnY+mawj1AyZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SScG+cDYCbfOVXSJZDKPURgCgjRzX192mZwBYkSc5pgJF6vF0/urmgBueuyIHKiM4RJPoPPDkctxQs16ijQw/GXY3otIO/LJmgnpa/Vq3m6XHX7bQCXDPtTJlkgl/V67wGPLgUc7jJwKAXSYoI2BBzaUl/EG8z6zIbxN5lqk9U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NEUbkjDB; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RunX36ZD/XZR4gZ/a/ggeZBCxPxpqa/I6s2zzZaTK2V7xHHsaggntlezxfrrqNQKRQQAx+4V03lwWNWYVK5fGP9ttElpRmJrimYrf5xXcPvcC88v74rtqt2nbc7zrkYKjsexohOg4tlP+7s3Ih4fJHRZ3FxGoJ44PsSa84qoG0s/9kFYvH5RSDqk64hBJw8nlNLVdG6IXbF+uGVzqFksMjqma+6yFrlxz7YQ4r2IfOkPDWqUZCTjas9WpSAqL+IUv9Mn2UJL/1zKhi58tcLkEaWAiwZHVu3PQOZu4+/5Lo6eZnP7rZ82+jECMBi2k52xfGD6D9exb+Ffi4/Um6IY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQZXlV/5sW0pdE+f6OPcAZHmxWuc9sFZ7/qTFPpkRPY=;
 b=hUSgNav27teozH63/Q0TsMP2Mt+o+kzzAkhQDsP1+Six4+RBxcIcVgyHF9F5yH3a/FFl9By/fT8ipMK9jH+p0t4JM4cH0ERnTeTJKM/NQpszgK4FxOn2FA0GsCSJ0d/fZj+nLUB4oxNleDy4m/Kzig7rcccrI7uRLoVNiDKM07RRRsCi58IRYhrbGF2FAy41cqpkvTCbdnBxEwQUgk6G6AWbNZQDw5/QvgaUM5GRl7eLQAhJrOMsIxg21gwZmlWxkhjCA2SOXXvYl9tM39UDCynRcex6Ia/GT82WnEJ3it6a49/mjjBNWvFwxywFog6Qc4votbZU31+0NVZpsCq3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQZXlV/5sW0pdE+f6OPcAZHmxWuc9sFZ7/qTFPpkRPY=;
 b=NEUbkjDBmUGK8Q4anrmsPMUkNKoMcy0Og1qtFp9EJuvgzYVhhdVtRfeGfTTvWEaCYnqrmFFjeYQByDvFJeqf1XnxupaSI1mpfAM7I9TIxPG6lou4nLSLDLKmJPC3N0YXwWG3+J8n+iEWKkH5f7tX2M6fn5KiWbWw5/DaVYUY2uWgc596UreSfhneokVH8X6K03Rr77Q9vtMGUW6L4Cn9nMs84faBDM501LrxLzsa/jBjpcNqYgCNQ47IEXeL5X7VLfAkvody26KlogpEGoWFPiiyf6NVwdsbGTzsr+h8uwuRvl5OokwSCpLVdy0YwXGv40rkv3Mj7geoCJ2Qhmsc+w==
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Wed, 17 Apr
 2024 07:30:44 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::ec) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Wed, 17 Apr 2024 07:30:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 07:30:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 00:30:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 00:30:30 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 00:30:29 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] Updates to mlxbf-pmc
Date: Wed, 17 Apr 2024 03:30:15 -0400
Message-ID: <cover.1713334019.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a178ed-7f53-4eef-e57d-08dc5eb04a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lgGG9Cr4SicAqaz4nZc69r0VEhMvKJTGuiOTjlWpPy81oan9IIChFXJ2aiK/63t28+GYaV5jEsHVW4BpNFvQfBzZrQWcLOY3ubE5pdZnFpWwezgSN0PY6Ptz+6b0OuLz0rBEQ4TWkBFzKTK+dYQEenwa/+M/6ndcagf1aH/e65PMQIdTMo+eQ67kc/Rq2BARwCwiwXOnZf2r38tCp1CwmeuEO/JJve5v0FiVmCeNOEkBJ3kDa5U693Yce5O/9PBFmraz0OagEyFEBtK+4aqz0G9eQir+jOw0G2eK83cCBNNcgP9MJWl/qNj6ryVmXPwTXHuQfV9lw3wEVEGbihC0kZe43WPd9rLK6khTGGSFGpsje/87VA3SxQTaEbtT/G+m1rJakW+62YviRoLEu0AgTDeOXtAERsFYYZ7ivYvhdFgkrTvBKrOEZxw0NPIXrI0fs/T6pv4gFYbNTr1EeBL2a13G2KBVpL9Rk71kYQswOBT2uhTnnnalXtZaEyXBsCc/3CUq1QRCDVtOx85Iva7aix1n5jYNu3d55ttHsl+RwA90TMFUq+P7ugy29oHOdD1oXU6I7imi/TIUrTlNGUn4M1T8MdSsIL2vBsXhSun3mMaN2XSdvslfk9SgamDrmKqtBcsC8W4Lj1r9ILh9tw3dBNWt/0GgguAsi33mjqNfkzszAaZteOde2AXMU5+Ct77CTt6nz2UmAP5b2VoemRbdQLfBNwDwqNxMEi+RzzHl1qtbna8hiHm3RmWR1IexJRXm
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:30:43.7478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a178ed-7f53-4eef-e57d-08dc5eb04a9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991

This submission contains 3 patches relating to mlxbf-pmc.

Patch 1 adds documentation for the sysfs files created by the driver.
Patches 2 and 3 add specific functionality to the driver for supporting
64-bit ocunters, cycle count and clock_measure performance block.

Shravan Kumar Ramani (3):
  Documentation/ABI: Add document for Mellanox PMC driver
  platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and
    cycle count
  platform/mellanox: mlxbf-pmc: Add support for clock_measure
    performance block

 .../ABI/testing/sysfs-platform-mellanox-pmc   |  49 +++++
 drivers/platform/mellanox/mlxbf-pmc.c         | 180 +++++++++++++++++-
 2 files changed, 225 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

-- 
2.30.1


