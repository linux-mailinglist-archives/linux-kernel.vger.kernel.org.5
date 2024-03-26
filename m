Return-Path: <linux-kernel+bounces-120003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE588CFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ACC3235E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB513D631;
	Tue, 26 Mar 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tu3eg7VE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CF12C7FF;
	Tue, 26 Mar 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488423; cv=fail; b=hCUePubGHFjetntTlEI5/U/B9VbfJPm0jL1/OXJK7MbiySZS/em8W8rgzvxGp2Xzd7yOlBjF0R34wlkzCzmt5qx5D/Xm2GmBgaLVQ3lbn8PsUFEYmv0iofvaLIY89Lg0NVTpHWUwT5UvopgueqV+mOLNB6Kjc5tlC4ugcB70C0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488423; c=relaxed/simple;
	bh=pS7TH0aSBGd4LOKo+j9duXtCzy0ymz898yGLigY3RI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D4bGAF2EhJ6mpMeA5otQC+7NmHnVacLKsbDobeSiSTDVBUnW7VCUjB3dqVywtCG+W6HrYyNfz6liDe5ZlNxU4swYPabYsFGqZ66SFA0IoGO43OSa0rZ5DDRnVP/AUjS5a1xX4wuYJupwzrPVxryqH2L+qZ64uxSUoqZpCMtjYUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tu3eg7VE; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3m48ydvTwu8uX9tBdScjGGGowmnj4ZeDmfS3t6KatYPlurr2nhbzDBRfTjsWEvWjbJBSDuKfOxSA7GIzBgqPT+AVXkQnt0PCVXHcZGrHoaxzBmzt5HqEAg+giVZ59LmS4A8T9vUHqMpIETm22IoX9U9yAjx73HM41GCmDE6HSW10llSPuvsVPC8fbw/YOmLc5XCoTf6+QZM9q2zqoNrIad0S2bewh3d/S6mHPqAI5LvXvSYzZtmzYnwyEIDDkggcUBf8ezeIybAy6kC1DtGc3SO8FNNDwMExy1JrLoXd6XncHBp/R4vvks3Abs/i3ibrnML8yP3zfI+L9eZwP+F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfU5Z0iaHRlI9h+ejhoRg/+pNAoHASYHD0Q96UtUvbk=;
 b=P11AgAp6ageyyhwsevQIE19faLw6JTzo5rJBbQpQB2SHgnfl9QxgR8A7THCh+zA3bYAgihvgTkuMsFN44rezS+/imtoNruxfIckLzLNX/MbFDdo3LW9cB3JCXy9+h/pQ1eozpRjDbaGXK0HJJI1hVj13Vuevx4IowdsJWLRhs6btADidxxRMgkvfM3nUKLUNDkGQw30NMXHy/qBjXhgSiALQrMXurcc8jw3eLj1f/JR/wrgrb0yfA7+R5Wmys0ZhxpQA0Cd63N3xlHVShQmSvXK8LV3LyLX7Zjaml/3/XALiXYbjUnrW8Gnps74pSGaiE8ug7XwIoA91rfhUlA3SUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfU5Z0iaHRlI9h+ejhoRg/+pNAoHASYHD0Q96UtUvbk=;
 b=Tu3eg7VEww/AvSRCQhX5U+Jpmd42wAWkbuCDzPRJ+jq6He92pV4fbQKJCI2O92JROuMSY8DJbuKQF0aSPqONsYfQinnJ7Vpg758VfDLtJ+fSFpJWvwAzP9UCIxG4GmghBfrB00ZexkS/7jOK/ZWFBJj5lDIMcV92hGNODrcapZE=
Received: from BN9PR03CA0322.namprd03.prod.outlook.com (2603:10b6:408:112::27)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 21:26:58 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::53) by BN9PR03CA0322.outlook.office365.com
 (2603:10b6:408:112::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 21:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 21:26:58 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 16:26:57 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH 0/2] PRM handler direct call interface
Date: Tue, 26 Mar 2024 21:26:38 +0000
Message-ID: <20240326212640.96920-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: f84be2e3-b3dc-4445-ca55-08dc4ddb77e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9k9tiGkFnll0MnlgQoSJ5Gfi6KI9ua4Gk81tBB3q2KfyiIQMiBPx1HvxonmHuxpbr3e/9GVBFtsvQCxViSC+QX8W9qK1JP4c3qW7G0iNrTZtoUd1uaffeDVwnWLIgp+iUYWe6Hu7StKDWUK4nBi1dhYfzDYQavgAXeSBMCIVyvtK1yRdjAccTV+DuWItQq3w6vo22oB/h4rZ/c+UKCJR90pOtPXFqEwYt4oGfHyG9wbm14I1XZajYdSPCKY4PALQqCcakdIfodYNGlMBl71bnDAHCYDbStKKgObluDoSgF+7OSU0nJJVhJ83MqdzT4qAeYEiC1lz8RX7ABUyZtG0CmQfkZ8564aOIAnpw+89J005OMrzrKTcExpjT/1rGd02dBCJUMUgX0OSYzg9O3X7YNeGQ0zsybeLd4XukgNK0qNXBjQNwDhsAKNm0cEyRofbG0Ys8JzvBVWGvYeojgnMX7J5f0a5mwXM5G58hiUU2tDwlUbUEi5GQieftuwLdpcNlraNhTWtujAAjEq9KRjCI1wMrjPfAqoSbvJk1axY1FdJgi4hZ5q+pnH/uaR7MPzfG04nn+2ksBDP4iOVg3UeHkFX7F6x6DvcFd93K3uWa+mcL508HLoBzqgDrhLp3OpI85pfJ4HY15mqQYgDB/GmO5N6wrdjla7zJVadqM7Jffg2ZXYx0bRI0PbJWlC+GVpkNNGtZnFamBrK7QMmRZuSjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 21:26:58.3555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84be2e3-b3dc-4445-ca55-08dc4ddb77e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

Platform Runtime Mechanism (PRM) introduces a means for the AML
interpreter and OS drivers to invoke runtime handlers from platform
firmware in order to remove the need for certain classes of SMIs.
Further details can be seen in the PRM specification[1].

Future AMD platforms will implement a PRM module in firmware that will
include handlers for performing various types of address translation.
The address translation PRM module is documented in chapter 22 of the
publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
ACPI v6.5 Porting Guide"[2].

While the kernel currently has support for calling PRM handlers from the
AML interpreter, it does not support calling PRM handlers directly from
OS drivers. This series implements the direct call interface and uses it
for translating normalized addresses to system physical addresses.

Thanks,
John

[1]: https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf
[2]: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
Base commit: 4cece764965020c22cff7665b18a012006359095 

John Allen (2):
  ACPI: PRM: Add PRM handler direct call support
  ras/amd/atl: Translate normalized to system physical addresses using
    PRM

 drivers/acpi/prmt.c            | 24 ++++++++++++++
 drivers/ras/amd/atl/Makefile   |  1 +
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/prm.c      | 58 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 include/linux/prmt.h           |  5 +++
 6 files changed, 95 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

-- 
2.34.1


