Return-Path: <linux-kernel+bounces-70219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DB68594F9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46621F22D28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777146AD7;
	Sun, 18 Feb 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2s0ie98v"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519215394;
	Sun, 18 Feb 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237627; cv=fail; b=pNyR7N6a6I4wgZqGncZjMk9DAjlbzDNAzzKLwnzm+uF5sRb51UXFbyfYWSD+gv5SwslNhUXn2/dtfTEoBUooOiGvSZATdyR42yST52KAfChFAcyelZYSw8MvlrqgtmzJwRCP9Y//Nk6vB4pJ0AOgIUm/2DJ58FAqaFaVX0badtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237627; c=relaxed/simple;
	bh=rzQnxdRe91xgi1qd14VaVZBsBMyfeoc0gIP1/2UMeqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n327cdXLAHv33PMWMSEDD2cO0N0Kfmx6FlnoJAIIWuvbGa8ciI9ilwySeESYM4aa1cynTidtlj1M1B/N0yPAt479EVY34iGWRuJ8O208EwsSp8jQnR5Kqc2bSFHTtPCHR8+XMZCKP0c46vgzgkwdZfpzOYJVO3Jgm2A2nlYq6aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2s0ie98v; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtOanqcmhxydz2HMUrBxE+hdfkpeNoPfvgEysg3C53OyHsx6reYfMr6C6Qc24uW9+nYHR/ZZ5lm3KQFAZiHNvVNeTgvYHdR0oXTIJm/lfqwA64mf1US4DfsG1QysTYGjXkiuLErikegLAMKLS0acipgbIA1S9EXnqycHttBRcHAv8qs0LFwGuy60h+QDFwvt1zI+gI8YU3Oxl3DnZNal8FIOkoweR3NXhsZFFBmUlgvh6VNWLdV4Yo8RlEoR43KE6Och9X11wJye4PBHGcTjq/5RgA6k66ufJzk46D2jt5XpcldsiuKx4EvoFoSgRxNMaHfQC92tmXhi5owFp5krtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWnAJvu9w9md7Xmz3I9F9/pQzitMXGCKTyeLf00SEvA=;
 b=bruOnp5tixUu7Jz8YU5FMjAuGEWR4wYTOL4jY5RUi01MUeAdikxaRoEfPy38c+yU5FsxlXMP2Jp8BYcr94Hjfb03/xOj/FrWRyjTnFriE/+YNoabJcU/5AllJbaL5h1tclS5KH7p+1egNPsvYqhhivyoZcU6N7RJXPLEMzhkNlFwbEXG6WKOyNAOL6KFd7Q56DgNC/W0IuvP09b/o2xz6z8Zm1GcZneGm8fDIZALFE87vN3kXxqMOR+EptRoX0JN2MNq7Z3symQ3aPrPHb1493nB+QXPFMICRJdvrW7iL9eFvQNUisc7rQHI9BnTZQwpE3oi9N0JczKMp4kHXZX9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWnAJvu9w9md7Xmz3I9F9/pQzitMXGCKTyeLf00SEvA=;
 b=2s0ie98v4/9k0iKOwZZroz7ZowFW3SXaWb4j3JZelVu258RnRu/8bjqlCNt5xwegnqTDIxOWI7DBOALN9lBIt29uEuPYnm+p2d0FthRITJ758GIQ/JReHV3enuUCfP94xrqnOxqlEqNyPzqTR1tes9YzoQ+lvYxWuH0HyfZu5Z8=
Received: from CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::27)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Sun, 18 Feb
 2024 06:27:01 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b9) by CH5P222CA0006.outlook.office365.com
 (2603:10b6:610:1ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37 via Frontend
 Transport; Sun, 18 Feb 2024 06:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 06:27:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 00:27:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/2] AMD PMF Smart PC error handling cleanups
Date: Fri, 16 Feb 2024 19:22:03 -0600
Message-ID: <20240217012205.113614-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: f031bd74-c42e-4168-6d9c-08dc304a9db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+r2b1AXo6tQUtaQ7kw2p6BduQbhNzWh9noHvAOvGKFVlNLqtRtOcKBkXanXPaQoktlg+r5BbF7jTsNjDzvHlMid+IktUhBye+uPiHOs4UOaAoT2/lwSlEMD/MnTnyWAzrO7WoE69e0jGZ2ju4slvBenESyYEk/9azyp2qvU0KI72LFMhJQCTKOjZzLEKvVLfjt2uvWIpV5gl/cc37JK5JrDxAgpEK40pMODod1vjC0tmFCN9l62L3UO3rfuVbSfne7g3X+xm/jMPehqo3p5sH2R8m1hfxrIQCXFBeC13QlxYUJKt1kMolk5sxTzXina7CkMviPKGRz7OT7RVfsJKL4gcv7YYm1UYpH2kD/n1xoAb5VyZA70l2ZLoCIkpafQefVsTIQYu/+dlOblAUMaNsigGEkq1tecFRV8gWgHl9xSTx/GJFFjGPBcqrKQDfTjoDhoSXMKI+Huiv7130ilq9IrSTQXZHiFZIQ+0cSjZjXyZBRVkE/L6vYrZNBcZPRPAMJMsFZA0ddmKr/s/EhVTz/wV2JZet78DXGCt07uPjfJq0WRMuD9EbONvP2ZVrGV3RW3lB1Vq4f3d82wAqLCdPIAF2QP3J+ofyN49q9dlp6sdjraBr5g01zHAlIYjKLUCaYh6OrDTWLnF7NMZvTMqNzYQ5pqYNay7iQ3a13zbiSA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36860700004)(40470700004)(46966006)(86362001)(82740400003)(356005)(36756003)(81166007)(336012)(1076003)(7696005)(478600001)(316002)(26005)(54906003)(83380400001)(2616005)(41300700001)(110136005)(16526019)(426003)(70586007)(2906002)(4326008)(8676002)(4744005)(70206006)(8936002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:27:01.1031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f031bd74-c42e-4168-6d9c-08dc304a9db9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

While debugging the suspend issue for amd-pmf the initial bisect result
pointed at red herrings of cleanup flow problems for
amd_pmf_init_smart_pc().  The actual issue wasn't in this code, but still
a lot of memory is allocated and not immediately released if any of the
error branches are taken.

This series cleans that up so that every step is cleaned up. I believe
this actually fixes driver bugs that "could" occur if a BIOS advertisd
Smart PC as well as ITS auto or CNQF but didn't include a policy in the
BIOS.

Mario Limonciello (2):
  platform/x86/amd/pmf: Add debugging message for missing policy data
  platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()

 drivers/platform/x86/amd/pmf/tee-if.c | 71 ++++++++++++++++++---------
 1 file changed, 47 insertions(+), 24 deletions(-)

-- 
2.34.1


