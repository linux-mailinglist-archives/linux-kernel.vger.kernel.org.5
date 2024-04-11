Return-Path: <linux-kernel+bounces-140067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948168A0B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72041C21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153213FD7C;
	Thu, 11 Apr 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w+ooJH74"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66413FD66
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823718; cv=fail; b=j+WPv2ahOrNpxDb5RM6KXNQlWYpS9tjh/VRXiVYzXR+9lTtrgW5s2O6zuHNPO52UfRtXByQ4Rts7XGBqbhLIeZki6GvE9keh5FoEhqJ/rg/Fj/sFmHyNnZuUix9wDv/YwhvILzcEqhTNoK4KMIaTk4RCyPMUEgHaMvvBWdXd6JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823718; c=relaxed/simple;
	bh=yQyWioH5MpdQYYG5E+9POA2GJeL/ORkew5wOIgOI8Rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TGd7hk5Yd2O41FXnUqutvxO6MOT80oJBmD5oj1MOHiTlna7maOcGGwJIVHZAvnuhQ6/VEUGSAl6ExxQItvSKoB++CT9mB7IR/LMrNVzbZmykeGe0D+y5SVYbbJ8VxlG3BDxTTa7d1RM25FhILvYxI2Jhdck5cap/P/77ZX4xqlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w+ooJH74; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzm6XGX7Jnrqzq+xbozTf65pMXCAbAOrK8KZ6GRdgcGV5iS8myPvBcmlroScypRtCv/zVQR///xfb3xq1VWTCe+U1yUdLnIyJ7qqzg4RnL+lmL6RVJc2Rj/XDY0FVmjFN2v9K3NbxprdoqgVbpCv09DcwjBKSum7TSVEpzar6vB/w/n+q0iCDI2iDGDxpmj7OpQUmeIEmZ9c0MOEW52bwxMDEEqGIUPwCb9laD1AaNmMHijwU6ogxkDDq2DVaSSLqWdqRnfsRJqMI8U7Z22Rg8pfw3RE8JIOHXLGScmQJbemhLCzR3OOswtelN9s5VjELOApMozJfxTXiLDyy+hvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e1GlzRNexC3xin3n08TJasBE8CWX0HHPAvo1mlbLAE=;
 b=eGTcYRVhUvVwm+DO0G4ZpYNvrKqsEkK34wdRr1SodplvnY7F+jtgDZuIAo2tN+6hgWJDhAAcd2RFgRyB8kGwNEW3i/gbsw0CwNh+1cta2qeQJlnx+Dame5Cow5jaBlqEZ4299TgCLMVh/4u1SVnCeY6XWk/YXEnQ+OH01AH8ccuoZ7jDgYNhU9lO5cXtEiEDBux9cnQN6xRVwemNd6K7LZ2HLd9oN/kmKTH2u8nVPQTTo0vcmFK8zwcFhBRrXmuSjsD4U0gwTCS74EI34nKLfcwaUUKVLa3Mugy+fDRwQy/LBSnHRC985ldy1TFp0bTaWAQMecsb/kE8wn8L1a4zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e1GlzRNexC3xin3n08TJasBE8CWX0HHPAvo1mlbLAE=;
 b=w+ooJH745IT1t5aim+P6oRe+XmFoKhOwshcVmSA5LEUxyPDHRan5FxcJoHiAxbH57JTDsrl+RtIEB/HElv2KsiCuKLw4BnVCy8xpSk2OhO6wdI63n6ruBBgcbt+d01/fEABsWt93AaV1iPRZG5i0EGTRFFKqRxVK6zCn4vxr0ZI=
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 08:21:54 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::8f) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25 via Frontend
 Transport; Thu, 11 Apr 2024 08:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 08:21:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 03:21:52 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Rob Herring <robh@kernel.org>
Subject: [PATCH] microblaze: Remove gcc flag for non existing early_printk.c file
Date: Thu, 11 Apr 2024 10:21:44 +0200
Message-ID: <5493467419cd2510a32854e2807bcd263de981a0.1712823702.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=michal.simek@amd.com; h=from:subject:message-id; bh=yQyWioH5MpdQYYG5E+9POA2GJeL/ORkew5wOIgOI8Rk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTxubNY123Uf+Ww0f31FQmxAGGB9698kta8XlGcNnfKQ sEje+ZId8SyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJXD3KME9v+XyZS8H1M5Zx aJssNW5SePjQzZdhflBdaW1wg4Eiz4nPctvlY5N8gz0vAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ec81fb-d59a-47c4-7b51-08dc5a0071db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	onf7GhmRAqda4UfDeSUX4hvZpMV769penwHiNS46o8/FQh/MRt0nspigs2rBYYDHJ1Agu4Naa3H87eHcEEF2D0TvmV1qMcYEYy+OtvgZEkRITJEj7d7Wx9A+v9qTSQealJjjUbgmLh9uRB/a5lZ1lwK8z0B5iZYsA13IdjUOG6hThdy8HaTEKYjBRj72u4XZONjh5+DTvRlteHuBWRSzU1eBO1MQe9LkrifuqHaaQj0gYhDYmPUu24Snz4dC403f5SH0SROv7U0pEW1KwOlD0M8eY/LUx+n1SvU3M9QGTFFjcUZwBBgdyu/9BpIBldy4+lbytgAiRdeQa2xH4rSJ7p2Ws6/8hDPWHpeYPC9OaYJwEm5rYg1DkC8cjH5vm6hniIJBsUGXjO6MYe1kCvFu4NSHyHLBWIrQWbeQV3jk2FiFY1Bb+dFUnqYgZ/pdJfK8cH3WjASTdAFZUR7f8gBeQuYGAXoqJF6BsWazW5Z8IES9+UKCs/vKbwNjtCusHnPk9dgLqK2ZgEVeQ1WcyDRolGPvYlxUgOi8HLGeimGvJ6lorpk18er4cBJwDK0+Tfv4ZUmjSPvN06+LjuOko4ZV+DjpioZx2b41dLLsThBfPLW4nOHYFk9oO6nN9rEaAJkBET9H89md/dZlLkokwtYoYkZ8WPe73YSQzD3IxoX8R9KohCf7w43RgbM1snKv0Zs9d7vse5JAwhxDs9xARPn8NKmyx2/6KRbWtQNvuJE+mK/ho1UdxhqbGkR5cEXuAMCe
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:21:53.6164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ec81fb-d59a-47c4-7b51-08dc5a0071db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

early_printk support for removed long time ago but compilation flag for
ftrace still points to already removed file that's why remove that line
too.

Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/kernel/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 4393bee64eaf..85c4d29ef43e 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -7,7 +7,6 @@ ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code and low level code
 CFLAGS_REMOVE_timer.o = -pg
 CFLAGS_REMOVE_intc.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
-- 
2.44.0


