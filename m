Return-Path: <linux-kernel+bounces-40746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A583E514
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A3E1F23B04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E115811B;
	Fri, 26 Jan 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8q3pmV3"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B415732D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307432; cv=fail; b=RVlqntnkg+x0tMyZ+kb8l6jmFrb5dBRlMHHbZb5KMYZPB/dFif5FmB8ANNkDDlck4684CFLMP1iFMOOH9crv92bE0VjQ/KSlGIBcbI9mNfPMZJPzUxaUBPUqZsA0D6Ajdy97vNo6FJpcAg9zwBhRFQwSkIXmkCzC8pmlG7O1XHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307432; c=relaxed/simple;
	bh=0n6m2Zsfr66giVTEkIIr/zW0oHNb8RD5ygAUH7zWIEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJtDY+pIB/iAbDj5Ts7qYGSAnsdznDKp9EVImPkuYwlkxJkOAzQ/X+yC4eB0oXJfngHiJQM+MLw7iNIXLt15+OlofzZfkjj3oulbAxFcmDDwAh8wpwBB3Mgfb6Scspe/HGtIqXofVmlMC/agmR2S2rbu/0wZ+UX7kNhhSvJvuDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8q3pmV3; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3bZZYXvkrjzSH8vW8q1FNCtwCL0Sw2Ukgl7RK/X5/26OTKLDgtSbfirvmQ3cbti8BmF+qV94nK092DIwdzBvTVd2b9qBIF71HQnuLW7NB5HyyjE0uLRBtrScRZM9STZaaBtmiWxkpiYxpjC24CQhLhgmrfzK/tVG0lfP7SayPXP0xORchu3txKUWDFe7735URC81W8ynpez7HsP7664MR6+TQ0/ZfCmxIb7nA3Fz3wMsqAl2JyGxus1EIlMlAEdE8SRyRzezajjxtHyczhRMJpBGVWyvX0kr2aNTg4GDv8M58no1rie51LfC9lw4uV0XXfWTS3wEQK5lnV0c/MAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKMspNQivsAnHFX55tmTi7IRJ3oYh7RnrB9iZYusHCY=;
 b=XEKqV6ugSI11+uD2ihU2QKppItOuefDX6INzHk0DVPaqBqkHmA7aE0KHSFeLR8zWdXilexV4iOBwcv3t9blpcTN5sZG6KREBs+VuGRzYh9eGbQXU5EA/Z1vkWCf5zlWM6dhxNHW2fQgiHx11AB7mdtXiPiOwwjgW14CIZrdWfIOv5XsXLtRi3FYvma5yOPW/8VUaqB6fuCP8NvuJfhc+lC2rD7R11ysDNqbePdl59gdzZFxDxNwgD6q1psb8JOW/vRlDY1wyoFYmg6vnHIhxQoA4XLS5/86r8hHR9FmC0OKGuUQQE+7ut/PUnqM3qZoOuos04Ofk686ZzehhIN3ZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKMspNQivsAnHFX55tmTi7IRJ3oYh7RnrB9iZYusHCY=;
 b=r8q3pmV34FAW64YvSFMM00lS4NlprIgRhMZKyLV7Rq1/Nk8yd55Zto2JS1ntcnTwDXGVVIbvBTQx2JH7khfq0/tGtJeITeq6j1XkBvvV8Tbwy2BjytsoxC9MS2STZngSkMPpwZX13WQ5TjMI4/rPrpO00Y/2j1LbcVqMqvjhFUA=
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 22:17:08 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::48) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 22:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:17:08 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:17:07 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 08/11] x86/sev: Provide guest VMPL level to userspace
Date: Fri, 26 Jan 2024 16:16:01 -0600
Message-ID: <61316ac5a8217f0397da87c78c2db08580ad75a5.1706307364.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1706307364.git.thomas.lendacky@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: d872a322-783d-46ba-33b8-08dc1ebc8939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p0d1a6xWCJESKieas5AN8KtPyghMdNawWIKYBYY3OsZWTZ/c0zmAjj82Ki6Qf16ZGRQcZ4h/JP+WpJv6n8hwGrcNkSlP3mPOtoQDEtqR1DJlpoBrVFWwGE8jPPqKylBsH0XeK2HIKWCflSGWknFb1z+x+6+sQjOkYVnVVVTLcqXzhRIruOppMaU8a8w9OLJkpz4TIpdgxL2ABNxis5adQK2gOJdLX9cEwok8a/FoTvlFXFxVX5tQew9jo480hAwEywyBbzcAqwp6T23ZOrsKytDoB5VotZh73e+GTeo6E9CaaCBitzv7VUFp8gv4ILLTVKxTdSr7LM9wpfc1O4V2UQWD3NKa8GJpo7v1YaKD6+7+PBMkf/fofCXGBr8kzFWIzhejHkiDw4RmdB2ETTaONrJ04l+EsjbzVIofFX9UOPyCGT29Tttjb57hy194nz6M2o+X5OY6or8C1HcCh8K5c6jVYu1IqhgDcjrpioahV+ornZAiAusrHRbkcU8yoCTgRgut3y+Zf/xN+2DE0IXcoP1nBzB6+gMSfbpJ5CEdNwt6nRLWvgICe+whl9B8DWw7rz2BpRKQrKgVBijjq7WNkl6uVNia0tUCoGE+Ki8/oQMwFLtL+EMkzgrgohQS07zp1P5IXNwca/G7V1iHLVzz4ekcOi+MhgPxyZtRnpYJLsXbOfkv1KG3KpFxODQzMl8whpgdnRzS+rxCQXD5sF+LQOTiLV1Jiz5EWK32fFz1LIWv0TW712lpvHFrI3nCOujkJ8r2aWXpvcnMerde+U5Wxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70586007)(2906002)(426003)(6666004)(316002)(110136005)(2616005)(26005)(7416002)(336012)(8676002)(356005)(54906003)(16526019)(5660300002)(36860700001)(83380400001)(82740400003)(4326008)(36756003)(41300700001)(81166007)(478600001)(86362001)(70206006)(47076005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:17:08.3898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d872a322-783d-46ba-33b8-08dc1ebc8939
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

Requesting an attestation report from userspace involves providing the
VMPL level for the report. Currently any value from 0-3 is valid because
Linux enforces running at VMPL0.

When an SVSM is present, though, Linux will not be running at VMPL0 and
only VMPL values starting at the VMPL level Linux is running at to 3 are
valid. In order to allow userspace to determine the minimum VMPL value
that can be supplied to an attestation report, create a sysfs entry that
can be used to retrieve the current VMPL level of Linux.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 121a9bad86c9..9844c772099c 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2479,3 +2479,40 @@ void __init snp_remap_svsm_ca(void)
 	/* Update the CAA to a proper kernel address */
 	boot_svsm_caa = &boot_svsm_ca_page;
 }
+
+static ssize_t vmpl_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", vmpl);
+}
+
+static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+
+static struct attribute *vmpl_attrs[] = {
+	&vmpl_attr.attr,
+	NULL
+};
+
+static struct attribute_group sev_attr_group = {
+	.attrs = vmpl_attrs,
+};
+
+static int __init sev_sysfs_init(void)
+{
+	struct kobject *sev_kobj;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	sev_kobj = kobject_create_and_add("sev", kernel_kobj);
+	if (!sev_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
+	if (ret)
+		kobject_put(sev_kobj);
+
+	return ret;
+}
+arch_initcall(sev_sysfs_init);
-- 
2.42.0


