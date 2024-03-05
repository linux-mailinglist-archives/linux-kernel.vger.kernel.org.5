Return-Path: <linux-kernel+bounces-93043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B505872A14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECC71C2182F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267B12EBCB;
	Tue,  5 Mar 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUCIuPRV"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEE12DDBD;
	Tue,  5 Mar 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677130; cv=fail; b=dMRX3KViqkYzDQrhJ3dQPOlYW/lb47Djhtz6t8EWZTXcMscGBhIEI9a4Qa4l9Baaml38rgvTZa04M8Y8qWDB1ka8BR6P0fFLVJ/3y7RBjtSWnPun51Tlcc6k/y7PMYxxQyKHOoLf8tEp51qektaWGbhuZFOp5UQKPXIddaXHry8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677130; c=relaxed/simple;
	bh=qrYW7cpWjOEP7qYD5fwWoYdqMoPBAdTPLYQ6/TFzH8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g/VSv4iL/9JIzsRLkrB7EC/8qFiJ0iUuSstl2+v7wRPBJYqBhFVMtawDPvrzBH5Kj4/Wq8KGiVTtKW4XTa0X4oawP6GqOklYYBmyBCqSKF0YgiIX0vFqyWv9b7wrbaL4hr0QYn59hWtfC9DJqslCkeZPCD+WvuBfBCklyfntqGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUCIuPRV; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxnOSdGMXXZa/MPPc5kkmFaoO8qfiUzS0eq9fUj7HdV8kpvYd2L4aHmn55BLaCfaFX7V3Ww5p8/C4Cyu5VXk3tgUqjLG678Yf0HxzS3zW0HXjTDNj2mLat/erz+KJpwvmHcX0EfxzNroeGi47x3SlJh6cFsZPRfqdkqvZD+mXVW+s7CkWJwNv/8sNb6wq2wP0omkkdiqqLuopxplxCgRC/PosIkUsWF95yVf1n8/KuZ5DliqUB++EbW3vfQtP22aL4rA8NfLxB2Z1ZVVXsw1+bGZ7/A3Et4/qA+vL3MNBICKHGtGtTjbjDAC4ZY7Q0ZoxF8PVaayMb2MTLvC4yIePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT47+UxnY8sZ6QkjxJS6BPd5/Jbb8HfLbba9VhBR9tE=;
 b=mhmp9nmUVpUrUKa46gWuUSk7HVGNv+xC3ZEwbof9N1DXfRoCh0SSocR5VpKQi05C+8eTzrsZnIpPzGJKshtjXqKgJ8nltA3ENrhD0hlQAVDbUC0+FrgOSYr0sYQSQs5njGQVx74SLVLSYQDJLFFNfUaGtau8FkweXMH1eMZOS5Tfb0YKecaB8k4HYs3JIo2RFmUgBSRF9kKGS/LRdoKP1Q7h3rnI2GU7Z5TzVZWdpezqLMlgPy3YFNM+AFfI+268GlNd3Q69csYWVEV2okuCuDqwScBSGbFXqy1D6TLo3eEZT2gkM4yrUQRD9cUO1j0kdTzYngmMSlwWgq3jELqGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT47+UxnY8sZ6QkjxJS6BPd5/Jbb8HfLbba9VhBR9tE=;
 b=pUCIuPRVPONBYeZ2r/PZqw98efktEwqzHD6iMuqwlC0u5aOGkOh5ZfxfM7hvginUUBngwhKN8bEMJy52/X2Qrv3TmTxu/LUe7Yy13rx9gTwMk2irAx8seZE8isNQnmpsknJV0piGXYNtfMeuvFkK1EBrBjEux/lZc2xWdS5M5kc=
Received: from BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::9)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 22:18:46 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::ba) by BN9P222CA0004.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 5 Mar 2024 22:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.0 via Frontend Transport; Tue, 5 Mar 2024 22:18:45 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 16:18:44 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 0/4] Translate development-process into Spanish
Date: Tue, 5 Mar 2024 16:18:35 -0600
Message-ID: <20240305221839.2764380-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f7e6fc-ab2e-4ad6-ed3b-08dc3d623919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pW4HTIIi+A4UsxyLTQKW1YC8PRaOCk/5Cq3ZZNc/mjCKKqgMFgZbd7Jjb5A6cF7R9UqP3DWyiIqJjT6AGL60wYUkg9FvkZNHBjLB8qalp3zuV4+accRwMmOYo3ghGgnYGJcC19EJRhsYQrXfR/kDVHokDAz2TyIOvbmGqUapDIhSiBskXlKL/a4CGtjcIA2orepZaY+11zqwFrvUe3Rk1AnhZW97DiVQV9Z8qC8yRTa7+AJt+0X45T+O89dYVXFMoSiZ32WCXTbznup2pIW3QX8N8IldksrligTv+y/bmvdMn/8Kl4Hnl1CMqpKcaUjPrVKciwd1ArOLNWVNWZ5V+8KjEq0srW3N9c6iOF5felLAvmsn+Q9AennscS4IDyAc1XAteD9xZhQv5w6KR6//vP4Cj0G2V+zISkuJ1sETWzBQ/M2kCbwrn0C5ErlJJKDTwj6x5C+/cjP1a2wfEVKxynYBydQErHCLG6rcvhrG6W0T6F9fCahD0sErvKPMafrM8GONuPFnSbohExHcAMj8aJfwNtzDa7tnEVi7MjiZVop4xZ2QDvQNDrnN6TRmiFKuZh885Ob8N9MG+ReI+AfZmfbt8x63SO5lzHQPnF4A3VN3MbDCSIzREwinvzlqk9WIvjeZsjQMcZNG2VryUS80a5EP7afKfK4KlHreOvIv7lIjHFno2o3lamBKB4A3s3zq2awwP3PFn+CGgafwX79dag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:18:45.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f7e6fc-ab2e-4ad6-ed3b-08dc3d623919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

This patch set translates development-process and two of its associated
files into Spanish.

The first patch updates the Spanish version of process/submitting-patches
with the changes recently introduced into its original English version.

The second patch translates the process/development-process into
Spanish.

The third patch translates the process/1.Intro file into Spanish

The fourth patch translates process/2.Process file into Spanish.

NOTE:
In order to avoid broken links in process/1.Intro, empty files have been
created for the documents, associated with development-process, that have
not been translated yet. Similar approach was taken for Italian
translations some time back.

Link: https://lore.kernel.org/lkml/20181108232417.14982-1-federico.vaga@vaga.pv.it/

Translations for these documents will be submitted within the coming
months.

Avadhut Naik (4):
  docs/sp_SP: Update process/submitting-patches
  docs/sp_SP: Add translation of process/development-process.rst
  docs/sp_SP: Add translation of process/1.Intro.rst
  docs/sp_SP: Add translation of process/2.Process.rst

 .../translations/sp_SP/process/1.Intro.rst    | 302 ++++++++++
 .../translations/sp_SP/process/2.Process.rst  | 542 ++++++++++++++++++
 .../sp_SP/process/3.Early-stage.rst           |  11 +
 .../translations/sp_SP/process/4.Coding.rst   |  11 +
 .../translations/sp_SP/process/5.Posting.rst  |  11 +
 .../sp_SP/process/6.Followthrough.rst         |  11 +
 .../sp_SP/process/7.AdvancedTopics.rst        |  11 +
 .../sp_SP/process/8.Conclusion.rst            |  11 +
 .../sp_SP/process/development-process.rst     |  27 +
 .../translations/sp_SP/process/index.rst      |   1 +
 .../sp_SP/process/submitting-patches.rst      |  28 +
 11 files changed, 966 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/1.Intro.rst
 create mode 100644 Documentation/translations/sp_SP/process/2.Process.rst
 create mode 100644 Documentation/translations/sp_SP/process/3.Early-stage.rst
 create mode 100644 Documentation/translations/sp_SP/process/4.Coding.rst
 create mode 100644 Documentation/translations/sp_SP/process/5.Posting.rst
 create mode 100644 Documentation/translations/sp_SP/process/6.Followthrough.rst
 create mode 100644 Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
 create mode 100644 Documentation/translations/sp_SP/process/8.Conclusion.rst
 create mode 100644 Documentation/translations/sp_SP/process/development-process.rst


base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.34.1


