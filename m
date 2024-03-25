Return-Path: <linux-kernel+bounces-116663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DFC88A228
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6222A7F14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7012D775;
	Mon, 25 Mar 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Md4omKf"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878CF12FB2E;
	Mon, 25 Mar 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352894; cv=fail; b=kWpaWjShhjVjzNDIuJ68uqxlYzk8SugCq7qUc4nrd2Bzzr3z4nXpjh1P1FjUpqTMzOR8IwdlQuqnG1YXI4Fty5NRUpwCSckAekGYV1zfZ+XURoIxTyS+LFFHsTGYk2nJ+HOk5ASGdA/OyXmFJrUIhC3G0IDAeHZ6aPw4MzQ7Jn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352894; c=relaxed/simple;
	bh=iZv74CmoZGurHvQI8tPHqluS7iizI7hqU4DwMB+nDAk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzoVQte3JWUOhOZiVB0DLu7oyYa0DBBGRcRuroyhnFuZxazl8rvyhrsYHaQjzKXyJNr6+5/AAuiAPPH0wZEmvXEZPCFjF1m/kfjbVomId6mRgHInxC8j65OwvDc6APjX5gmaQ9GPk/qKNBwZyXGl6TTyCWYRZUzbMu0SaUhDsOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Md4omKf; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltv1/qsEdP2rKtNSN1r4Za821LaX8X0OjZVRI6Thf6hw8F3knKjN06drWPKRndZgb5Dxp7h3+EwQqYHsgw4zkU/ZUBagwLLCwubbd9xHe3U7k3xVkqpA2u3JtTdCQAq2vrHy1a2Klf8LF3QAn4ktuu0eZID5NN2gM9JttQJmVSl0WGe2Xx3dg/fNpQWnbEkXGA2jeFAxdMtPPm+uMwBsyn15swCJ6Cxr4q72SWZF7EItFK4MbAgP9Cphnm1vtKTwbCkTE7DsplR4Etr0nB7SA0FMpwiebyEqii5Jimo62ehuZ6te3mK1n4eo24PqqQvV5ZnrRVdXLOfZGekY9u7COA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDt1yvNo4Yksi7q2cqwb7obd5KNjsDRaZBxghmPXiEA=;
 b=NkpqRiV11+TOE9LnGqbLG8zVM20DOHrVBzFLzJiMrmbYm7WXus67ZyiRm0cuAynP7op5Z7k3T2ApGo89x7jZtVla+60bnaUTG8j8Ite3lUVDMqxnUqBOf4apPSraje96cVY+rvf0RXaNMiHNcBLts8QPmsZBifnpN19py7jE61RBXpC4eR1IicXRDE/KyFDBqrF+urcqsKEbq3LGSTyhn3eUoWSbJKUiktYXWIiNq4QtHASxZdTLFXcH9qYceiOiDzGwc9X1PDzJFe3g1Yr98Vy+b2S4bbAl0fukXvlZeAyBt4GcR03/DI+pImTtMN8Ku9IPVlqkKDquou8Md7T2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDt1yvNo4Yksi7q2cqwb7obd5KNjsDRaZBxghmPXiEA=;
 b=1Md4omKf72DsYBUYWZHY6h3DnJ4zATw6YSKy9C0dA25eISPg75d6+Rh5exmFyGNakxG4n7wR7vuKd/3VKs1RpSX4B1Ilv7ir7ruE2Wp0Mc8bCpf7eYECz5JunT//UvhnoBddsCY0gSTF7jXq7ZKitQPbZoNt9KT/VypOm8kkF4E=
Received: from BYAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:a02:a8::27)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:48:10 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a02:a8:cafe::4f) by BYAPR03CA0014.outlook.office365.com
 (2603:10b6:a02:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 07:48:09 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:48:02 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<eranian@google.com>, <irogers@google.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/2] perf/x86/amd: Update generalized events
Date: Mon, 25 Mar 2024 13:17:52 +0530
Message-ID: <cover.1711352180.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: f8816cb7-2b32-4e5b-f0a2-08dc4c9fea6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUlfJk/XEZPqyAIcxCb3lLbQHqmrkqeDN8i9xvmChe1YESeXRB4V0QmGCvUWkQ3j3HsiDTcxsasCKNwa38sUMbPWPM6WfjP6127hK614HzvXLd2jP8kmmDjCx+jVVVTfyJ/r34bdtoN9aGNQ1Z3dzq+MGaX1bn2rz19MoPcNqQrfwEIJQctXS06zobT83Og96OmIpMhojpZGJzNGuamgaD71L7vhNhmETiiX2uckE5tCWlbfkRGJZ6BLp6M/YuW7WzfxMBz6RlgX7d7AIuZaHU22hk2TeuN/cGWLVTuZ3FxD54+f0FtgeLBha7yuaxEalpMES6XSlcT5RxRsmaHluCMhC8Dk+BIDmH5m1ZqKqpJWLz2jNUAL2nggYIPorJ1h/HUScqI6dhVZwTr9i7PD2cidGSk3Y4xieMUOVxqfULHdbIOGw9KqfQF1bl+Pm5wkK8UZMjb1HpCayll8/Tx8RdKx5Z2PMvO7SzdFYfEMe1SNTchCZvkmDVy3VyZ9rnbv2K6L+iCTYLhN4qmaCYKKjyfvZDm54SyBb+l9YROVGCRbC/k9lCErleClQTVGtxP9xYCS39pNjXdBZvEl40CSLEOsnp8MP0E01W3uuj3EdsbBCTLIxyt7q8CVEHhwBE0nFlBQ2lapXEZCLv2xPqaOvhp7hiMDUz2KdhsWzHf7uRmSk5G5QfhjP+QN2jkFxUlvDDCUIQiCJrKpl9yhAtTp+57Gxb186WgIAlwX+ubRr43luRLQ6LtHS3dHRSBM4vk9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:48:09.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8816cb7-2b32-4e5b-f0a2-08dc4c9fea6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

Update mappings for some generalized hardware (PERF_TYPE_HARDWARE)
events. This includes changes to the stalled-cycles-* events and the
addition of the ref-cycles events based on the core microarchitecture.

Sandipan Das (2):
  perf/x86/amd/core: Update stalled-cycles-* events for Zen 2 and later
  perf/x86/amd/core: Add ref-cycles event for Zen 4 and later

 arch/x86/events/amd/core.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

-- 
2.34.1


