Return-Path: <linux-kernel+bounces-142027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D88A2668
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C936B287DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4C3EA66;
	Fri, 12 Apr 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aKi+OKzU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAA633997;
	Fri, 12 Apr 2024 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902925; cv=fail; b=Zy5lpK+HAd49eEWnEcwDXnR+fwm4R/4aTXQrMBYfuZkDnH5Be/9s9M967zr9nSclUO7iq97/TA6gkxlpFCOAWvLDAFRYJkECLDEH0VRM09GHQ3r2GaovMntkkq+oCA9ebzwJAPb11qXqvkxT066T6THwgEm7wpxzT1aShmzJkM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902925; c=relaxed/simple;
	bh=hRMSfUhNJC1BRp5yX9KckU2qk2LzlmcjppPoHnrVjDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ku1oK0Bwy5kbUFsz98r2d7zhjEsIQTPxEXeYD19x7aW2/zmfjcDIS1doci+EvKc5kCUWxn4tcxOJ0ybRzlR9AYHKa/fT0kQwg9QITyhHDnpQ9aD+BAv/zH6H6fAk8Gc93s0ZQiryPJrb0P8FM2YqQzrsYgrx5zNRLsGwzh3iYgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aKi+OKzU; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7KQ4wWvpVyqUo0jrCyNjJseOPw+ufQJ2lvd42xlEDRbzdOYnP3m2xiGPWBEB3tZrSXIOmxFnDxlMTIW9FfUi/wNkhujmwUgv4E7Y3U8gML51V0Hp77CtpVLPaIeFryobJIATYa22tt9Og6CoMM1bjMiw3xt1GpFxNgLlii9V+edw4hna4pIaaN7DLgphxOj/hvCrQcl15HTx9HzAXQImdlkQs1fIuOz4Lf+ggTnbuz9XQyRWnwonhhVRjd2uotcLthkgBRWqz9E4lowBdHd4k0OCDry4qrw6STWHLD4qQ314AQktFOTN/gpATPQ+jwo1/PjLcErr0Sd4kErwTHX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+Wy8HziLGiQ6367N9s58GyicPrcV2tmvbm4xy93p3M=;
 b=aDCZEV+8zffxkvA10mfDUiaLNvh9WEz3PWqTQYEK7uY6W475AGVHdwRTxM0f6Jqvm48saDJLkifQ3AKvyu9F1S+hnxz59dT58ucSHn/f1BkkCo0hkcxlc/JC48YZTc+FIg051vwFzCNkVmkvrlGF9003QigPo8esG2C1LNJJRsivl6pZg0YmuUC/R3x2agWebzTT7yqEZzguOnVo0xw6XE2XKhOGoYPI7pUHGocAnvoP+hSsfNEX9QVmptwVwPnyTNhD40gU8p2H3lCZv6qSXGFVuv5ljW13HONu3plKb1NvaiPfoUNiCxIMlsRKlN4mbTHXYKjj9AvRhw609ZstKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+Wy8HziLGiQ6367N9s58GyicPrcV2tmvbm4xy93p3M=;
 b=aKi+OKzUxXuGKowJzBv2JR+5RQU/Ul9SsTaUQ1SkU7+7iEDDkrNV+vnbeRILRoXS6VjK6mpk9KtpwUh1bjbSOUVsQEEZW2dgAvHdM/QzBNbUwqnLWSg7ETBevnlQX/vH2DX4XMEBFwMN1DsQ0t/821bsFq5tWh9qp6hpeBWkpnU=
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:22:00 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::3) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.46 via Frontend
 Transport; Fri, 12 Apr 2024 06:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 06:22:00 +0000
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 01:21:54 -0500
From: Vignesh Balasubramanian <vigbalas@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-toolchains@vger.kernel.org>
CC: <mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<ebiederm@xmission.com>, <keescook@chromium.org>, <x86@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>, <bpetkov@amd.com>,
	<jinisusan.george@amd.com>, <matz@suse.de>, <binutils@sourceware.org>,
	<jhb@FreeBSD.org>, <felix.willgerodt@intel.com>, Vignesh Balasubramanian
	<vigbalas@amd.com>
Subject: [PATCH 0/1] Replace the macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
Date: Fri, 12 Apr 2024 11:51:37 +0530
Message-ID: <20240412062138.1132841-1-vigbalas@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c7f989-8689-4339-bcd6-08dc5ab8dca7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k4lkyO6DQFTl/3yHDCnnFMMvn3gU52ENOhlLgzlAnJyJNQgim9ItPE1nxe9zWwGbRWYCFHasT1OuEToiRP4hUWzgKWltOFXoSJ+qlpJYp0w4lDvsg9M2Tl5k/VuddX4cB00OH/ct0XFBQHbASC4/Dhuc+ebFvGAueXB2l3ypyi/rCyksw1wnolkdI1FHaxnX0Vyh9f6yaskDBbjOk56yElkZIjQv9qxsNPSp28hpDbqfZnyyI1h+VixRXNI6kKqzSEI+rBC9LoLSgrVl1MZygmQTI/XemSXWjuUhCXhqdxvPVaSWeZuk3KWNNfCfhJtOZ7w4dGD7I0SwLve2pEGhzeAsUis/YmoB0yTxZI1WvHm5+0nEpV/l+wtLTiyzZFcHmvsXY1XMQD7/JFBj6J3yz2EGYZ9mGc3krGnAUqmg+LhN/HLfrfzxnSswBTIag0r5+5srC+YyDTQA0Tvj1E5SCmBQow8TfcCh8YxSNigVPZieqzjIRHDE5g2vYNmkRgOle1A8Kem8DKwAElSwztH6DdxPpCyRYg6JyqMOyL42wQhrZLgrfDUQTVnAQWD12WkQ195OGw6nfrCXnqF0vW2OAY5S4WGBUcG8Ag8sJbFTaRVOqG6nr81FCMJYzQCGVb2mZrQaOit6/B3urBsCXWl9BJRhXjE/xZONDz85pJnNyU0IcuoRzxIAaO2LvdJe9bIfOvmyyl6K2a2pqunrAcWJ9yD5/8u7Iv/N82EW/Pa44RNuvbFXK6Q1/W8MlBoSlFOlRafSxicrVyvURd2IUIv8Gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:22:00.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c7f989-8689-4339-bcd6-08dc5ab8dca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

This patch replaces the macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
as discussed here
https://lore.kernel.org/lkml/CA+55aFxDk9_cmo4SPYMgG_WQ+_g5e_v6O-HEtQ_nTs-q1zjykg@mail.gmail.com/
It is a pre-requisite patch for the review
https://lore.kernel.org/lkml/20240314112359.50713-1-vigbalas@amd.com/
I have split this patch as suggested in the review comment
https://lore.kernel.org/lkml/87o7bg31jd.fsf@mail.lhotse/


Vignesh Balasubramanian (1):
  Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig

 arch/Kconfig                   | 9 +++++++++
 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/include/asm/elf.h | 2 --
 include/linux/elf.h            | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1


