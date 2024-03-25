Return-Path: <linux-kernel+bounces-116891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F888A4E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7161C3C55F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCFD178200;
	Mon, 25 Mar 2024 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JhqaJrzX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9218D888;
	Mon, 25 Mar 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363813; cv=fail; b=DWyrbB6JPo7ZTTIAPR84jAjTCKWcaxq2OvC9N116qIBRG2GN76+vWrxN3JuOSkLDeKP5sQtWZKKG4LJiqFqLh+loExGOC2Hd5dRY8vN53KdsFtMjSs6JHMxqmvWTzxmyEQUi8+YF53gZ/UXQSfo/c3ppuYpOcrdgQmFbekqJJYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363813; c=relaxed/simple;
	bh=xkVlhB9dWH2RjGD7bqe+gvccushq7HsPjcrgQFZ13D4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mpRvQGXZ3o3LPaACNVlxShQKc9nTEFVXmSU1xBxQD3z66QA01MZe3OyaZPD2lvvvB9dlZL3bBXNSrTTE5vGWjzekIES6PXCPmN4hnhNR+7Y/vDOYEB87WV/g7K9T9yqZoZwPLVQ3GKJd2sWCcVqSV7qgwdac4rvLvpJMo7LwaHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JhqaJrzX; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdbFfsOjmzS7cUY/zgqnGRkAhQuBuwkl2x+DxWtkXXzdegd9ruT+XwOPJuUqJAYVhxh08/7D3NaqDs3nY28dgrXSptScHuAAbv/no+c9w+GFRPyHSMncMXXnRDlmxkw0b48tjkQQiZPRMGx7u7P/wqdNiErsjz0CNriD8SKlA9YlRJAhQS89lE6DA6njxXS2Yxvhi5NvaWlDTNC0OvvWZJ1SZ+KxUuXFlYf69IzL0gP7qaKnLPh7pIwTv+8xUHhZWDS7BsPAY1uRzaOupzZfxfJ/PKXRfIikPQRZzHbZa9VyoyK318TM4MI2D9VxcOVvGEt0YnahAlLizimrnHORoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEHEcWNqsfvjIf8UK9p7wyrQkHxJgyf9XLWuKhf7Lys=;
 b=Kvkx0I5LscfRke8jC3zvDDYbOZSx9VCamwnuPJTQd7xWyy0NrSBValBImWPbsutq9pwyhqUgRUjNggKhrbrMMc5lwxKPoW0xb9EVjV5PkyS8lHTbdiRbML9fQrx0KatM9yze+18Th7qRBGh8prJ1Tq9PjdMywVU+LQitMGaE13muTEjN1kwWg//PDsNena/xykB4BsC1Fq3xAE6t6kyk6FYADMF1MXYmaYpWez6f3U70kEmX001JFap6l3LMz0YjlHIgyWMgW0jXStjRBmlQ2XP/+cYfGmrZ8+ZAWTFt3sUVtb86YfE2LqXVc+dOL5cdfHzcY9xH4rn4wSj3jMbuSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEHEcWNqsfvjIf8UK9p7wyrQkHxJgyf9XLWuKhf7Lys=;
 b=JhqaJrzX4F1urPe8B6gAafvVkrfeaMHTp/kNqy/BG2QKLWiIacSHmuoayN90f73FSt9W04y3vbOQJkqOuBiM9pvVXabdOOOl/ad/d83TsyktotZTz5HKvaqJ6w7z0OLboXjk7wIDOa2HBqNWcCF0cQlfbn/S1xtjek7Sy6wASHrufvGvGaINrap4eVoHK/fYGepdsHWxkZ7ksEXGR3GWR4pCJvnUoIrZX+oPbYhVoWWe8M2tNzZC7fzUJ8o/xINTfJ3/bCGS7qGqW82h+RnSS4i6wcZljjc+cLWjVSdS49iXdKfnPJ6pskczt5wQBdzz+ysqLZgBSSSTz7CP7zERYQ==
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:50:06 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::a1) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 10:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:50:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 03:49:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 03:49:53 -0700
Received: from build-spujar-20230918T214410352.internal (10.127.8.9) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Mon, 25 Mar 2024 03:49:53 -0700
From: Sameer Pujar <spujar@nvidia.com>
To: <broonie@kernel.org>, <linux-sound@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lgirdwood@gmail.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
	<mkumard@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] ASoC: tegra: Fix DSPK 16-bit playback
Date: Mon, 25 Mar 2024 10:49:28 +0000
Message-ID: <20240325104928.2796868-1-spujar@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e856167-544a-4df8-ffeb-08dc4cb9551d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HQZ1+BARq0jYbOwgB4zo0mCZOPbEUl69XmNC5XpNze7L0dH6pae9JmnF1m6F2GBhTp5nHwnyB5+9U6xWgdcyTSSkfEXEM7ogFtJbZR4mrA8Tip4pUITQPe961mhIn3CyL/dh/pPTt9xznBBXFFmysxi5s0BAiZ4LWEcrB/vcGpdEMtHphKNv7GzmI4SITcFL16xocNdzSWoDlZ+mThyY7UnI/jqi2Yu6aJqw6Sr08Q7S2AbNN9bNFsFEhab1T1R8p5uuqCfTD2XgqCP0u/douE97IXx1e8WsmNctNE0EPSaTgGVVTh2/vxNu+GSh8jPnrpL2DfqxvUdGzZJ8YuqkbX1IINbsTyfmhcbAdd1GJfCopHcfmPgjTZOR9hvr7K+yq40rUGoYZZxiJq35i1SInjdILeWZC3M6NRGuchttKNt2XmGn3myozs5GiqLb+uuFRwOmhBdInZMLJ2c7NtNbAFNpLrWbiG6RtR9KXF+hMda8PaZaptQ4c1EjvPTFER3HhaVShXS9TQ0+HoKCaIMJTLVTd5SIF+Hu+G6UPJrkHRYyMD/D3z4zn7WMf7S+A3LdSbklDjFxP9wpkvO/xJbgxKUNJNiCKAKnY4sfQwfGtJWsFSm5lBSewvC8sYYJuOTFfe8tD+7lCY7gqCfWCgXwldrJDzvC2t4aeU6WpL0ZOnKoTCpId7BXE6SIT4Zr/EHy0DVDwDWkzCdzSU9K3Cj1jv+XlJ0lrvCxiTf0nwbUDiaN8ZjZ5r9RuE/0XPSYZMMO
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:50:05.9520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e856167-544a-4df8-ffeb-08dc4cb9551d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

DSPK configuration is wrong for 16-bit playback and this happens because
the client config is always fixed at 24-bit in hw_params(). Fix this by
updating the client config to 16-bit for the respective playback.

Fixes: 327ef6470266 ("ASoC: tegra: Add Tegra186 based DSPK driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra186_dspk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra186_dspk.c b/sound/soc/tegra/tegra186_dspk.c
index aa37c4ab0adb..3a152e76122b 100644
--- a/sound/soc/tegra/tegra186_dspk.c
+++ b/sound/soc/tegra/tegra186_dspk.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2020-2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 //
 // tegra186_dspk.c - Tegra186 DSPK driver
-//
-// Copyright (c) 2020 NVIDIA CORPORATION. All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -246,6 +245,7 @@ static int tegra186_dspk_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_16;
+		cif_conf.client_bits = TEGRA_ACIF_BITS_16;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		cif_conf.audio_bits = TEGRA_ACIF_BITS_32;
-- 
2.25.1


