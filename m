Return-Path: <linux-kernel+bounces-128041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56CD895550
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D928A1C22141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901F381AB2;
	Tue,  2 Apr 2024 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TW8bXUFJ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6481AB6;
	Tue,  2 Apr 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064421; cv=fail; b=cfjF28EeDp+Q2JNW1M1OzfpC+kWNp29RF3rtmEjgIzRKR3XvnON44OhOoUGvTZipp1psTEXq5Kor4CLKyycERJpuqJY/Exxsg21UjvcacD6MknnT+CVFuJi8zIonsKne8ZGA6HsTXWCMQzroJIx1zGzdsFn/Wi16fj29ZHRMO4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064421; c=relaxed/simple;
	bh=Az7ZgPEcp1fDur+cOOSZspU0aR2NoDLXnHT0vzPlK0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c10wQwdcAXDvkVk3qyi6pfqQr/Uo4q91/4MftAqzHH9zJ3c0ZlkGsy/7Dykejz7WhRFKfplbTyfJplcOSLUkFLjOw7wquS38KCzQ65M1yPnDeLOiDIlHUUR0gc/qnRTFKtJp0nMPqMQstlRAy42U1Nz4BhrGSXfN0u3hs+lu3Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TW8bXUFJ; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT+2Oy/s11wRIJtstYXIeRk5gAPzcti2+jUei+XI28RPYi5BNbAm4NTDyNQcdjko6IfuOMKt8Zl/7m76U1a6scbgq/Qzm/IiDNQXHMYFtthn+YikWK3xKq1greqe8DW+iWPdfdZrLUdT9G3KytE7N5Mqoz3LJLy1sZcVRb35fUGskErIjNwdR7fU5mBPs7/ifzFTmdBreWluyPCbHEHwVnNMpH72bKXlMp4B7uoxo7biHmqsqqmf/fNrqwzgo3D4vY+uUNXiRU0ctFRy0h21677eECEHSI/LkrZqeV4bOuC7ClMARU8OmlcUDnx6AdU0Ejq94kkJ69njvDG3eIacow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hLK2+p6lq5VQotQdLT2f335zgwjtOZPvXT/LlF8lIw=;
 b=HIVs0yTDSsY1HXLGiM8d6FYzzeoaovc5lz4gW7WRQmxs8dWLgRuK7ikzEsP8zkWbcn8KZZ81/rTJ3RY4sw4imlZN5F+Sk9+yUDoZbUZd2WFSrLu3JaM+ZiyZR/LKiI85ioCeiEPfNb8qWx2ROkH+XlV5fVXsgFP/+GOg32UWJbkBTLAAYCrilqVvJccsar8sF7eg6uKkTELGXa0B0vJ91i2AB9E2PoL1pQzpHNKM8oVJreBoauuVyxOqiP3BP7zYVr1aeDw089nUghRxC+FYBTrOkxwwMlUjxEFmd7t0CD5r8n+m1dxX3fn7ibKuM74i3MAsAnGl7kBGV0/AHe5B8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hLK2+p6lq5VQotQdLT2f335zgwjtOZPvXT/LlF8lIw=;
 b=TW8bXUFJmpcdRXCs+PBn4ShxKvPSc7JWwx6hHne4flYJ/10w0tVRkdvpE8IENHQaYBK0RV4jIyH3UFRqBoFG8/gi2hGi3tc7XaWlkUw9dXyA8aBcotqXg64GqC4DkD2OCOp5tidi2zzHRRaluBnefGBIEi++1U4acitOvE3walNYpN+9VUTgqWzf7bWp9o87eIaVZYfREYKgY1z6g1WD6iqitMqRdcotIq+pORsh2KYMPK6eFYB+JpD7rzMDI2910mmDZLJbuGrpvy/8y4O3o5JejI7GsNon3oYb/nKJGWkznM9ou/6eBRC6dp6t7ANcfirbDuFL6Y1kg/TGEHZQ9g==
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:26:48 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a2) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:26:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:26:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 06:26:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 06:26:28 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <maz@kernel.org>, <mark.rutland@arm.com>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <amhetre@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [Patch v2 0/2] memory: tegra: Skip restricted register access from Guest
Date: Tue, 2 Apr 2024 18:56:24 +0530
Message-ID: <20240402132626.24693-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f94c89e-c62b-4ca7-45dc-08dc53188cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DaoaCttH3VXqW/IZIL9ZnRGWbE4EeVHUT9P9csdHtw6AWzf4vb1igcsVniAZSspl7mQYcwTcuygl2c6k+Ak+onY2AtlIgG+QwK7/SI92fEsnxp5LT48UMRZWMpOqb4yUIGie9t2+CM9F/u26u3wjKIcSiNIbY7KEC7XFLUX+wtdyUCX251ovXisCUazdkeY/oebMSycaFzxaqGksmjEO5fAtyb0hC45YUKPhpmrHoEo1p/Y1NqIl/0GD4Ll/B4OGp2bC+tylf3qzwpZfDbzdmD34BMSN1QWDk1AVqg2xGfqYEtS75NmEsP22FqEoA/7JMQeIv7MncsTfs7Q3SEREBtKnvDD6/TTu4FrRlzZt8Fzf3fOsLLyXdrE5xckjRGyD5iwJO5SmD4qGgDBJpE2J3Reeb9+6oMAU/Z+Rm8ZH3yGBjBXgV8oBC/l4/qcbnGBbY+wkVOL6XvBCFo7FQpzCnZbXVExfRtBqWndrdz+9plud+SOJjQrz/UPh95JnFoBgsJNYnPwhCc35CpOvJ5oDgj2WI3wMRxRCsalIpQ7vRDdVdTQc1mho4dfbV4QDSLRYF2Tan2jz/sKfJxBxpLoP5DfG1C+fMor6exboEd49mNqeoJvE5XP7Z6vRYv8gatTGWhNm968Fwnln/2e8i2Lez5pdpl6s2KhdOEatji1tN4WHwCiYckQffbzaFjNdOmczzh1YMbx7MS+0+lbpRWGCG+/RB9evNIB3qidu2pN0QS2YmGbezepAw5bvQbW4VjHS
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:26:48.4844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f94c89e-c62b-4ca7-45dc-08dc53188cd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

MC SID and Broadbast channel register access is restricted for Guest VM.
But the Tegra MC driver is considering both these regions as mandatory
and causes error on access. Change that to consider both the regions as
optional in SoC's from Tegra186 onwards. Then skip access to the
restricted registers from Guest if its region is not present in Guest DT
and hence not mapped.
Previously, the solution in [1] was not accepted. Now, handled the
problem with this alternate solution.

---
v1[1] -> v2:
- consider broadcast channel registers also as restricted along with sid.
- make sid and broadcast regions optional and access if present in dt.
- update the yaml file.

Sumit Gupta (2):
  dt-bindings: make sid and broadcast reg optional
  memory: tegra: make sid and broadcast regions optional

 .../nvidia,tegra186-mc.yaml                   | 18 +++++++--------
 drivers/memory/tegra/mc.c                     |  9 +++++++-
 drivers/memory/tegra/mc.h                     | 18 +++++++--------
 drivers/memory/tegra/tegra186.c               | 22 ++++++++++---------
 4 files changed, 38 insertions(+), 29 deletions(-)

[1] https://lore.kernel.org/lkml/20240206114852.8472-1-sumitg@nvidia.com/

-- 
2.17.1


