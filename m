Return-Path: <linux-kernel+bounces-118107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96288B40E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164221F67633
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E38384FDA;
	Mon, 25 Mar 2024 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="isrUjIEf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902C8287F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405679; cv=fail; b=isYeV8Ki34MNm+D0K3j7oI6luvgUOtvQz7S76pqBaDz2aAP80Kvt3j/zdi8e8sKDcVX9BTehdLhe0rLV6UL5mJJpDu8CWI1r6wa5KqKgwetSAp/c+ypaLangn3NqM00QO8JeWdJ2L1KFaoN1ZXMV4BmjudQ0y2jt0chIXalOzdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405679; c=relaxed/simple;
	bh=OWB8YqMR6+ubxClvOGMFr/5+2vbqxc8R+T+UHSSCbvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lb6DEvl8WJSuYDbed3kvBIDTk6J473xxDAH8ofeIWW/XotafO93yU1ZCGGE3nR78FwyasLOdAeMsth1lr08NCGtzpt2kOx6Tuo96RkiSvRq6aeR4Th0AStdFo+m/onEswp0iNvPYeTYv9dbRWf8S1lYvNI4vObJoqr3Ihatjn18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=isrUjIEf; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGzhXlGD99vUI79XfB7j+0mhOfMp0CgOa0rQNDmD2G9CsfnrCxXgczhSBhT8yKrc3b0F32wlDMxmH0SqQG7oVUXiG7JD0kR5QGbmTp6YL/7nUiTfMz+gPL+60SP4YjX9tGfz70dlKH9vyBDbPfBMcZEXmjTmvzxHQmokwGGT9jeTD8rsKTaMxuFoHRryxndF/hwG2mBEM9kEL0ON7nGteXnRhfdwfEpnUkYXzbqW5YeuQSLb0uxvTjBfVqjkP6kQO+jXFS3MUd7LqTHPj2dFy9XbzwqdcPBrttdXd3uIDnkptRxIpKuPp1OXDOONc9+QbxurGzemWA6Rs57nS/nvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAmK2+/fKsarqC5Jy2zMoU/XCCPURo4lIHxka8k69Vk=;
 b=S7DNmy5scsBkxEARwusmxomFUBXjpDM12cjvRkeKTT9CYfsuwA8Mr5GhPjVnPlRwfQ8pZaPmAZ/vDw6vzX3FlyFW4PN2x6CIRzHokkw6TyfLBBn2OVscqkrPd21JEz/j5lZnHh78JHIqGMx37UMxShgJz80HBq8MAI7lqN+vuphn70kASM8FkFXNSWKiBYg3e6MNilAlR3FriUf6Eq45wtYHve6aW5d8fwwFg3zAEYh+EVGofROXDmT9BT3jGosURS5xa9uKwZ8LlS57pkJLKIUR74jeoAvF3L/Wa7x9TXkyA8xeh/6TldHRz6uv56X6PSC2Rp/hxUAeWjLxXlmOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAmK2+/fKsarqC5Jy2zMoU/XCCPURo4lIHxka8k69Vk=;
 b=isrUjIEfCKCmfEi4wA8hPtPfxm0ydTT1K+LOgbuSCLrdIDR5hIDh5702ayGe3yFTuCNzV5GXVVq5nkURds27QdiYX+f1WrdhDzREi7DCjcfsBxokcO2Ctf3OcvDCH7htg8AiNvgmrEalRlQe5yww+tKpjlAbSCsT6+7yPRalWRw=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 22:27:56 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::8a) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:55 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:54 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 10/14] configfs-tsm: Allow the privlevel_floor attribute to be updated
Date: Mon, 25 Mar 2024 17:26:29 -0500
Message-ID: <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711405593.git.thomas.lendacky@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2d899d-20de-468e-c910-08dc4d1ad153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VzN0MVft/99+JJBOnvw/0AyvHgx5QAB4BFF+4y82fK3Yug1KrnHt9JbklmjnljUD/iWKElUuwGaHfVISAhT0xveybF+7tJJRcPcI7zmVxjXVBzWuski4JKbtoxQo2CnR/bkHW1KQnkE5vOQXrRUNjgDNwLWYT5QPo7ieaqOAWC5JtyGC7ISl/mkAYwejrTVLeHRQ/Ri4V6HMzthtmNeJAAndzsWgeX25azJXhDdB4bPQxX0WQI2KMb1k/AdtHgNVaNIgOxuq/xIVzO6OJpsZ4J3mDvrHqzFKAU7ekVm/IL1PR5WxbA8KAG1IszeqJxgyQVUZK2cE/QXW4M/xczN9ngixVA0Jst2K76d2w5UNeKyip6SwaIKKtLQxDtLD0xFIZw9/I9kdWx1AKeNDB5k/37mpJDpJwLMuLHJdPlelhqZOcCs8x/6uQg+G5Nm/VaIMVmUihooMmvGHLPSUe1NQuUbyXfxIGMhtJNUPZcJ7J2xYJD9KXDyuf9ACL6H6D0qdTthoH3l+mOkqSXV39Jr/19fUCNCpAZDc0ylb5ZbyPMSKMHyle672AfWhaCiRf6mMOB6kNbrTDUeWBevKQxiNkU2eLF3tCdPQHKrTq/pIU57bbrTO5/xB8QDvHAFlTS5E7FqDQfDehyxrEW5BZtM+M/riOq2QO/FlCz0s98Wp5NbgfK33mbzqC2IAXdmik1CmbFSzwc97xoOq9p+telmuF+IMVx5L/0CdOSHHngq4AX/SRo2YG+kF8XH7Ipr6QesA
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:55.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2d899d-20de-468e-c910-08dc4d1ad153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

With the introduction of an SVSM, Linux will be running at a non-zero
VMPL. Any request for an attestation report at a higher priviledge VMPL
than what Linux is currently running will result in an error. Allow for
the privlevel_floor attribute to be updated dynamically so that the
attribute may be set dynamically.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
 include/linux/tsm.h                     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 1ff897913bf4..bba6531cb606 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
@@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	/* Set the privlevel_floor attribute based on the current VMPL */
+	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
+
 	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..50c5769657d8 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -54,7 +54,7 @@ struct tsm_report {
  */
 struct tsm_ops {
 	const char *name;
-	const unsigned int privlevel_floor;
+	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 
-- 
2.43.2


