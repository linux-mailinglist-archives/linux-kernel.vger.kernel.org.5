Return-Path: <linux-kernel+bounces-37472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17C83B08A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECB71C209BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008A7F7D2;
	Wed, 24 Jan 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T4WiChGj"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F257C08B;
	Wed, 24 Jan 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118790; cv=fail; b=e3IEu2N/9tlOYI0Kd6wlcKgSVKAMH4hanDyLbqGR5GlyfAOSJRcojWbZdaHYvdPfcwjQqSe3R445G3/3/yu7BUecsK2c5EyuKI6i/BBW01aTcGXaAdIOVxFLjIHCwT5p2O6JzEumKc9gKq7WIU1sxKeVsv9pdcz3cUNH6P/6KDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118790; c=relaxed/simple;
	bh=pLXEeu5AUTY0lXQVFbSlPTGM8hifEOLN8y55qnXpz7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mej/RkUgypwYpcHV9cUtSYgZSnC1EkLbRcl84eb1vlupwcvsK1r8PCZ8Wjkg/OT9t2s7EoTEGB8qQnCLRsNByv12DUj3cOdlkyIhp2ySpGk1FSwT2VZ/aRcnw0vbct1H5B+oKm/TcDU7Y8KtMPnkUqD3l3Mhyb3F4t5o6NagO6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T4WiChGj; arc=fail smtp.client-ip=40.107.101.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNmTZAIPrWttnj++GATfYvb+lT43tFVIvGhjAmgCkjGtMu1DQr0aD5pSOCilGqc9PR8lcTAhLk8u3y6TMhRiWYoC24C40WZTHrxQtj7hkNUCKEcoUPWW8SYv5o+Sy83nORFB6+chCNcCDuZOEhuf59Pko4IpvgfvRUoT7mDCdf3uYIgOfvL0WJrKNEVBf/Uk0Qr7BvPk6DOcjDkTNkQ1wq9oNzEUUjXHITgVLXIdqHTgtKqlbGyx3naAtIVk0ozT28vpuNKta+p8wq8fvnqyNVg2ky5j9d99PRQVJP1aF7AyLvuHcY2oRSsTwGwpQFJTEOWYgCLiiWl0Q3kgjD/pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfB/j9lhCHvu8Pijbw6rDDaNOzMD/oxR8qbbNXqK2Jg=;
 b=U3Yv2Z+wvHcuzFpjeqxBd5IO6DvEoIDFI9OKMRwZyFClIE6JkeKwk+N6L9bUgMyq1bOCJI3H+xYvb2A2RDIXugGd/8064cAnbeCEbBLi0A52OpfpPJWaRqINsWH9iAMNidp2/JO+Y2EZHPEzpRpnNy62nbtDylDggKmYy7ozqHuPIr1aPUgpDKwovYOeMeblE7ltWpAswKFhn1me7bomdp11qQ0LQZKWFBH24+udcBAW8PJTGeG9hzJ5JJjPOYJS+m+yEr7mplL75h9FvNgHsNuWCioij+MpjMqguBrxXChOHB1AiwR/CsWAfNUb1Arx58H/QEdYco29Q+M2sJV7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfB/j9lhCHvu8Pijbw6rDDaNOzMD/oxR8qbbNXqK2Jg=;
 b=T4WiChGjZsX4D59qzAK9Uk6ZwIbebXaduN7T2RcAnigsjWHGHOFu89OzTLwBJZ/Qeh3U/FszbN2RyWTTy/50/4BhntfEbh91kgrU5tZQJhoFOzdavTTTXc1d5Epf1kPFYFV7cJwwQfWgGlHveaxTatWhVwChhvU6PoJkPJLwlFw=
Received: from BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:53:06 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::fa) by BYAPR02CA0051.outlook.office365.com
 (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 17:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 17:53:05 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:53:01 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
Subject: [PATCH] x86/resctrl: Fix unneeded variable warning reported by kernel test robot
Date: Wed, 24 Jan 2024 11:52:56 -0600
Message-ID: <84128a3c83654493f637b8349153af10d69e2752.1706118776.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202401241810.jbd8Ipa1-lkp@intel.com>
References: <202401241810.jbd8Ipa1-lkp@intel.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: d1891647-e394-45d1-87eb-08dc1d055150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yIGm3rOYQ+JH1iC8EWmfQNLkj7cic4VZRlYlq9trMxp+LGOEV82biXgoqYyqiqhqtNlTZIxqXaB9+vOz7pvMbM8iX4I8OuVclub4Cgu9w0xfRY86ybhGarqSIOpNxMOgK2Hotx7qS6CmFuDbmSusbe0c5KYnehWbdmVSii3fixaxZG+7c3G32UuGkhIqyJhB4PimEhrAuWujHVCNBdK+ENON2hMwG0qh44El45b4lKCk8pxtyXrruEZYcLw/8na1gLpKs9OHeximvDOnUIfiKe+hxluCf1xXii1/Poft9phHSJmXE5Tk94oL5JpiBTajAvjpTVTd9ABBrEQvhwNO5RZbNT+yDkXQWp2wHxOKlUdQOK+0QqdcAdXCAWZZ77dvqMOug++XRc88KBsWlKlotW/QnQEfaGWuLp9U3kS3h8Jz8aNsBCDJSG7dbjlcJB0wZ0bozDmquYiizsIiRD8OcB/tbivmGSMuGvrIVZk6bHtQW2x3h82hBr72X82aPG5SDVcf9kh+e6MVh2HBmpdJMDnB8bgzdh1symkaoMMwhsNuCu3Yhb6cLkY4yo+PV8B0jqPssVvip3WXbFcE8bbdMiAjRTwgd2oA8CMX9+XTU6YntG17drAKxnbbCv5zKanVZ5/I1vvx/c58yhwH2WncQ57ica1x7zYcojn8CfiR047aLlJ6o2w/DbEgoxfJJlVfvzQGbxTzY9ZBx0b9EscBjI++hDJoSOEoG6RfIekhYIIo81fyGH0RqSG9JrDJVbra25drehW14oLdth7Aq88pewnWYhXQ5HR5DEQ3EOUmZV5CGM0THPTCz/gyIzZnLC2A
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(36840700001)(40470700004)(110136005)(70206006)(316002)(70586007)(26005)(54906003)(40460700003)(40480700001)(2616005)(82740400003)(356005)(478600001)(966005)(81166007)(16526019)(7696005)(6666004)(8936002)(4326008)(8676002)(5660300002)(7406005)(7416002)(47076005)(83380400001)(44832011)(41300700001)(336012)(426003)(36860700001)(86362001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:53:05.4635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1891647-e394-45d1-87eb-08dc1d055150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456

kernel test robot reported the following warning after the commit
54e35eb8611c ("x86/resctrl: Read supported bandwidth sources from CPUID").

cocci warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:1621:5-8: Unneeded variable: "ret". Return "  0" on line 1655

Fix the warning by removing the variable "ret" and returning 0 directly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401241810.jbd8Ipa1-lkp@intel.com/
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2b69e560b05f..6057f96df73f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1618,7 +1618,6 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 				   struct rdt_domain *d, u32 evtid, u32 val)
 {
 	struct mon_config_info mon_info = {0};
-	int ret = 0;
 
 	/*
 	 * Read the current config value first. If both are the same then
@@ -1652,7 +1651,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
 	resctrl_arch_reset_rmid_all(r, d);
 
 out:
-	return ret;
+	return 0;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
-- 
2.34.1


