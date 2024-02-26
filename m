Return-Path: <linux-kernel+bounces-81805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE89867A46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483DD1C2427E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E912AAD8;
	Mon, 26 Feb 2024 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZnnLeOH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F253E28;
	Mon, 26 Feb 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961398; cv=fail; b=Rb46JI06Zdu32+/VSTNvITifgSg5z9UI3hX/zS/MuA9BH5yo1x3w6w41eTiFelZzP/8Ajx68u8XTbMc1YyPamVZA31K7LW/Jr9tG4KYIlvAicyKEmkLi9q/2cMXgAQZuX+ZbXOOhGmSHbTTX/J4K+/lo8Va02vX+PtzVbE7GEUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961398; c=relaxed/simple;
	bh=CUcZsn0yj8uFF+lyTuNrm4OoN0GwPBwWQtsnvasHqVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eY9uOrUK6VGvvMCxy8JNtxpiaCcFVN8fZOMQFWN4EGy8BJYyNoD9e5ao7/gPuqmPM5BZX1U1I8vizrA/n0sqpIxPsKA9kuGXdwTbRhD41WVihjwf0oJDAGGdVeFo3WV12NWmd59eQYpB+H+EY2Zr1dwk6e2XWr8i9CVAKU/V5/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eZnnLeOH; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKgLENSAQZHZtiE09fe9Wjac8y7Du0+Lpmw6xyPdD5ixwN5vRlVPE1asjhxZeV5kdluOr6Ml94QkMfwpLxyyGLCVtq8xT9OQazfeesnK2tOGLfheCIz0Ekccbr8BUoUQe0A0JB2bVI9unNtO735T5Kuzd/s5W5ZEloXPWFqEBzHwAR3lY1N5+A8L84JY+qV1j396yzjBX1cD/I4x5madEJmAWi4xiel1lCazFjVsYPHBhAPUmU4NPZl17xWOo2U7lmHotiQlXGjQCUNfJAvGo5b9Y/QkEZmO60bMPNWq5bLbb5bZJyrOFOKSokVnoF7QsaGXVqYrIl1/1BtYXfuRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JIFJmOwyvAsM2K/E3zfEbw95y2e8XILJ1iHyHItRR0=;
 b=eY3n64Osxxt+0pzgeOSQpEYciFJgnOKQKaRNxmYuhAN5wwjhjnax8mWliIsLMkp9SADzlP5FpZZkYAmAjKjBS7PtZ4/9x/N2tArmBzBEc91MSxiike45hDPViI2zA8S1wV6+Dj97LWI3R7KsjsQv2ylmeD2SSyQFC1AgHHM9ggZ6wlSUdxkD7+Q/7AwmbZTxs0F/TbZzDlisufvJcpuBsESJnjE4mOI5yy6kRoIihpFp3UmGppZvpwK7+14dtXDjawl3fJSZMON986gTMtQue6FadbMt/p+rydAIuWOMwS/WjL3ptiVehbeMNEH1rN6MmYqnubrkdfCMNVpWTxjrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JIFJmOwyvAsM2K/E3zfEbw95y2e8XILJ1iHyHItRR0=;
 b=eZnnLeOHQJ5ddFu08xcxgH82Gw+vvUIMkVaRdvEAe7QsEmyECa690FNEBg5GGjuKEu+tq3FXZy3Yn9hHh/Hemu76Rcl/kwgW3Qj4Oj3nrd2hNq5/9hDiaVZuamntUfv1HbTZGRPKeO/lMdBB2j558XXGVQ+PVYxKf+QctILom2Y=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:29:53 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1b) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:29:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Mon, 26 Feb 2024 15:29:52 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:29:50 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] FMPM Debug Updates
Date: Mon, 26 Feb 2024 09:29:38 -0600
Message-ID: <20240226152941.2615007-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 5713e43c-a5c9-4b31-6b48-08dc36dfc6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nyqiUksEyDTHeDiwBYYcvSty2pV4iBI4TFz0f+u58UTs8lm/fSv0EWE9O0wuk4KLoxHlt0jroSytMOKuzSnyr4W8w5Um1mpRvZ9V1r18tFkXIkk7CAfatw8NUjQfMW5KQVNDI3mZiLXnkAT/Aax0T6ELeYTDBuPmKonB7rdjmbSA3Hbd4N/r2N1VrprZkLaUYTsrog+t1yU/V9YDFR35CtPiou1KIfadRJFXHXg825TBqTwO+XgexrSeyMHL202iGWBXOuMyrmzauDjs9RS2a2/CMTxNfmIr9wXEwSmPrbYumIXCufNSxzEUGCKGqxYREHRYmIqtdIcn4f8oWZW8T1Zhy/QRHlanQwLSaX7Rh/Ex0mBR2Y+6w5vx1tn8oAmFVnmqKyZznmkC4/hKMygnykfSYbkUwJtxMR1btJmDXu0CFue9HSFxHPC1qt1NTN9VdCZRvEEvi+7Oy29Cdq6xmw83v8+71L6ix8R0kgn/w9HrwDq0yYlu7yWqYBIA1KTKo5FB7/ImsXVv+G7p0To7l2w6Y6Yq+v37Zqmm44WutHST2FMrCCkwrelsAfNJRvoWjBJBKGvxH7rQ1NejwNYTox1C0NovLLD7ZFDroin/Hzm7P20rtdAYAUM2IvABV/Y9tzRazH/0LSgkslEWE5f+dtK30gVUSbcfDKNkocpOn4e7Fg+oyiSx5/9HQBflTASjSOr5nA2Ue8VAKlT/uI69a2Y+nM2RZcEYSoXPs4Cq6dq0meB2RP8mNNGavQQsrKuy
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:29:52.2152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5713e43c-a5c9-4b31-6b48-08dc36dfc6fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260

Hi all,

This set adds two pieces of debug functionality.
1) Saving the system physical address of a recorded error.
2) Printing record entries through a debugfs file.

I'd like to include Murali, Naveen, and Sathya as co-developers, since
this is based on their previous work from here:
https://lore.kernel.org/r/20231129075034.2159223-4-muralimk@amd.com

Thanks,
Yazen

Yazen Ghannam (3):
  RAS: Export ras_debugfs_dir
  RAS/AMD/FMPM: Save SPA values
  RAS/AMD/FMPM: Add debugfs interface to print record entries

 drivers/ras/amd/fmpm.c | 183 +++++++++++++++++++++++++++++++++++++++++
 drivers/ras/debugfs.c  |   1 +
 2 files changed, 184 insertions(+)


base-commit: 3513ecaa685c6627a943b1f610421754734301fa
-- 
2.34.1


