Return-Path: <linux-kernel+bounces-42588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA184037E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF8E1C21EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AA5BAC0;
	Mon, 29 Jan 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x56ToNpY"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE1604A6;
	Mon, 29 Jan 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526457; cv=fail; b=OZOAKcGt7uunuIVCOTAo3/xfRoF/2YpXR0iJHd4lGxDZ1xk2T8lG5I2A92ea/WqC+2/+FR7jxitq8UwBaaWNOFCTKiucStrLek+4KSQMvUJixI6WJ4CJ5o5H6Gbg8tbxqMp/7EdrFttMOs2eip8ItSQMhh3kopinZjMaUCO0RW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526457; c=relaxed/simple;
	bh=gV2MKB5K6UVyjqqJUMBcPmK3kixaTcrJgvfs09bwCYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaQ1u9ZftaCh/N93zMFXpZVZ3Pm+Luo855qMSQM9vFx65o/9RcVaZzoHJIBCe7B5ppMIH6oT2vs1XcEUSCFHnvgGnO51EaxiWx5k01VHCmyjl5e+dQOQ9AF0ia2oDIvC8S01zvaj/WD2sgUodYW8f9W/pky46FSTbvAP6DQiK38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x56ToNpY; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwuwNl7nYCy+N2xAxm4syTHpTuJ9m4Oy2qhM514t8CLYb3HeuGN+IFkDtzQw+Iqmtnu3d3yIFXsVmeiv6ZzkpkO0rC9W4K35vSKNNYIi3V7n/WEX29z6AOqUgSFzCevNc2GIjOqwBuDYabhnYmMbvBZAqt3qurRkN0Quq0fw2ND0wMcqwxkrTknaUmpKAlSliLAJ0YoVUfG24Z5RfRt1UXIgkqHLLws/Vtb8o4FORb9MqtuyNi185PvHBt/O+TRtm+3quXMCQfJLedYVmkwDakkVezxHmAB3hNfO7bvd+RXCNq1hZ6JZz7wUKPGtjSHPZvIptMBdkQBhtZR7f8AnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPMy8QQOvVtzv+5yS5UcoCje3KI+shnpnly5qLELA8w=;
 b=VikRFJM2kGf0A8G853zCkS9rav9iYVjYDx7KapHKn+CMa2K3NCZvNcqckYTrm89kOVL1JKbE5jv2tg2AmYBk39j9riqZOcFBOSZlvgQZL7XpFA5sBA84YJsqU4qmwbbwskwjiEk2U1+HpfvvN4yrWcFOETgCmhbJ7mSHMS31BXYs1laXXx4Qp8zuEvXWb3QesX97LCG8bi0YLZbpcNPhgbGy9mJLZk0PSvxgbmE0roE71RlCBFE1+2PYjbU5weM9dK9dPtiNm/2KVz9NGCy/Za1Uji+7qbDg94ZTCDmzQWgsktpUTw5SfjWlpWs6XXTDOlpY3F0OhZebHO/f8h+l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPMy8QQOvVtzv+5yS5UcoCje3KI+shnpnly5qLELA8w=;
 b=x56ToNpYdqtTN/vlX1vIXGS07s2a2QHfcVoIxNq6avTgvT/0/5zYzzjiP0eJi0jd52/XJxPa9yz9Ah4tkEkDPt1jXFZoo+Sq5iN+aulTTZ76rKlCwaZrYlA6qwDYJcQpCilU+mIuCDk1il1yU25722qqqZPl0DWrNC3C/i3deUg=
Received: from DS7PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:3bb::15)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 11:07:33 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::5f) by DS7PR03CA0070.outlook.office365.com
 (2603:10b6:5:3bb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 11:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 29 Jan 2024 11:07:32 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 05:07:26 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 3/3] perf/x86/amd/core: Avoid register reset when CPU is dead
Date: Mon, 29 Jan 2024 16:36:26 +0530
Message-ID: <550a026764342cf7e5812680e3e2b91fe662b5ac.1706526029.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706526029.git.sandipan.das@amd.com>
References: <cover.1706526029.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|IA1PR12MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f62cbe-498d-400b-9040-08dc20ba7de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tTqJW20Ojp8i5j1lJ4EUh+czBZvucvUBYJMcgg59LiY9aAiUVbzzIU1PVqJgHRRophA8Ka20PEIWmavxctq/I5hFerByZypfK4+vRKhIpt+l3/Ap5ctKHah1Kj/9Tr7nYjyzIXhsDElc6LAE62ikl2ZQ0m9EHxesgagb/TMeWPSazMygTuTXhTV59h8Jo2cd5C72T66ebg/rGobIgLDJr0Ss1NaZxFI3yqfwOQudMfm43iOJUCma1c7zYbHGILe1+iPSRhELeZ1ZMSg6rkaqI+IUpJ4mWebb18Xmv3mnsxqXnfk0wHmsHAkRc31Lh3Tkm8CXa6g1YWyxFnsK6KOML1CnjcWUwRO52cp5lBhnvZhDTsZ+mVo/b8BSam59dTHhb3qENHwRw5juhJbimx++VVPo8c2lAsc905lFxhV8hHnnliUp8puiYVlVB6dQHUhPdhGP03XBkKFwzJOINXylCeuuvvJBh2OnQLx4CjdGufCqpIFZ+JmJgsjMo8O1P0fZbyW+ZHz85HFpCeAPx/oLb0Wc1k7Gz+lB2dBfDLPDn3NWBnTYPPfzWrMO1pXQRv9T1G5GHqc0tCSMHpnCVW+iscxBARE5K6rDoOYoFcZR1AjXYNmSEALQpeqgIg+J994I+/VoQaULkjySZKfu+tkXtGfGmnHx7YwHvUIn3QyTbh/1FQ2ma60WxGUstdiDXuE5+cOMQ3UU0B7/g+WDc+O01EVDFLhkM4xdiMVIUoffK0ghr0QA4o/xVqNYoF9Xo/7H3X+8bDD/M+hVltNnIeIDdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(2616005)(83380400001)(8676002)(426003)(16526019)(26005)(336012)(41300700001)(4326008)(7416002)(5660300002)(8936002)(36756003)(2906002)(44832011)(316002)(54906003)(110136005)(70206006)(70586007)(86362001)(478600001)(966005)(356005)(47076005)(81166007)(40480700001)(40460700003)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:07:32.5848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f62cbe-498d-400b-9040-08dc20ba7de6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637

When bringing a CPU online, some of the PMC and LBR related registers
are reset. The same is done when a CPU is taken offline although that
is unnecessary. This currently happens in the "cpu_dead" callback which
is also incorrect as the callback runs on a control CPU instead of the
one that is being taken offline. This also affects hibernation and
suspend to RAM on some platforms as reported in the link below.

Link: https://lore.kernel.org/all/20231026170330.4657-3-mario.limonciello@amd.com/
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index ffdfaee08b08..63514c311f44 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -604,7 +604,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
-	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
-- 
2.34.1


