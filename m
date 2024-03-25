Return-Path: <linux-kernel+bounces-118105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F087988B409
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C532C609C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9C83CD2;
	Mon, 25 Mar 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GkaW2C2X"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2D879DB9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405665; cv=fail; b=qHLNSDb1FYhNEkAp4jE+Ul8GEVuy8ruKMYhSCVsIenPnl1xo1+vdR+q5K4wqmYXwCn87Gz8145OL4nK47A0MDJhs9LbhLbdoWPkaFryLgPqxfpXmyIEyI8pMrZMqW5EogTabTNIhnZnjinxR3RFwUye0v3+p+JjJNiB6zDZVJSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405665; c=relaxed/simple;
	bh=DGGY+b1Ik7ExH648RwoVZml0FpCXCoSzYz63F3dGB8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiEMryXHkEtnpndInLyx3H6o5v4SOliWwaQzbvFWKKKEwz1Bm1MG2l6soO/x0ohiUSF5TiNaiD1UbITpmgZwXkdt4LTqKDbl5g6OtEl3K4yj47v57KwZIlD84PWG/Q4qF00vDlijKwWnmmo4q5xZJhb2uzmuoEsv1UDCIuZARxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GkaW2C2X; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbofx6DfP7gg+GnKEwAZ8PmmWXC92JLxFe7eWTM6q4va4m9cyMWIYk5h1E32u4lrrFDjwL9+1O8QW9jSeuRrhOwLPp4/7Ili1budCWzjdhkkBF3MOmTK/vlM5w4IzNpXMC1Qe70eqBTC1Gt24039O8GqFSULUOy9jm0APLJNoBzsrKzeeT04K9kCksebOryKkfT+p5yUUANYpfWkKV7tabhBkofX3BzWV4ZZBd12upMjQk4VeR/Xl4PSuk105KrRaYPpWrFa60SqHiYxp6GJCS01T2s4FXMSNHzeinAjGKcoBoYrwbhHa4IxLNRKgXb8mE7DGKH9HF3lCud0hucwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUFekUHq3ri6fK8WX25LSjrtTNUyC2BaVsA3y2IVSSs=;
 b=PbacovLkcaF0rWEpDa/eAZ3iwkLXAl0zBv3R6pJMQI8gY1prkXBeMlWRDup/UT2q+4OpZN/rBjwAf5588xrLBE0BsSi0NePiYP3+HdDLrb4BLtVo5vft/VREjb9R0bpjncC+jsN5pvWnKtv5i0rUNN3xhN3TVDdJsZGSnpFMyjQzAombZC57NKU3apXRLUsTz0TxEEgmHbWR3P2f3S1Kn0KugW8t8bbiaRsFfq9QbZMgmAeQ9uS52oS3k3NBm9rC4tG6EjgHUCK5fMIJLeRBVQhS7PeWSQ3G3rnmwVo+RHjSicAcaVBZDLP1gjPs4VxLwqmbUYwfLxlB8UAwm2WCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUFekUHq3ri6fK8WX25LSjrtTNUyC2BaVsA3y2IVSSs=;
 b=GkaW2C2Xxv1z3AjLtNPo4CL7F+Mq+/FRY/foYrTahsS0MeSjn8S2zczdqXIznwNTNCZ3p149ExxSWNHv/IQVh0dA0bixgjlLiIgIQQf3LVCq9+nQuMKLyYX0b24l5IQdWKNByaLHH0ohR8ug5sFQfYbOt+1K/GxIuiKZqZuGQAY=
Received: from BYAPR08CA0014.namprd08.prod.outlook.com (2603:10b6:a03:100::27)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 22:27:41 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::bf) by BYAPR08CA0014.outlook.office365.com
 (2603:10b6:a03:100::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:27:41 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:27:40 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 08/14] x86/sev: Provide guest VMPL level to userspace
Date: Mon, 25 Mar 2024 17:26:27 -0500
Message-ID: <b50936fc4dc0ca96773e2dab9582fb0d760424e7.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 22961b62-8807-4b65-c0ef-08dc4d1ac8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G3b0Xlvsz8J3p2ZW05hcY797clPm1oiqeauQEHO8/EbTgBD0ft09Eyly6jTiV05uuCATrrJF1W3cin9XrTIeUz9hWnIqo8VLJiQyj5i1jSXwbHu72JwQroY0YE4+pU20Gkmns2IIVtcZlMwkmm1Kd30q53SB+EC+dP1G6DdSp8/agi9H82qvYWcpiMGTg0gBCeaF+pZTXK3k+FOratwLy7W07GEigjkfDsrJFFirCL4Gx5WuHoFfn5UCyG9/Fh36zmBWNdVn4Km4AQHE3g2bdjK/R55sz49DwHrbJ6tV1F0QMojKQMegv7/EvQ1L8y3s6czlw6FJkvq+T1ko8iYRRVUuKPE7oAvvycMlmcDgdSyrRZCzgNYT3byOXnuh9ajiWUzE2Hy6qOAkF3iliSHbAInApWC7mgAISTfzp5zhjd6569Yv7vj7/cN+dPMj38vM5O4CqpERkn4eOLpGmN8nCejNwYaal42QNH3Sjpb2PYPO0yMY5q/1asOD5T+6GfIJQietTAkQSvGdfjPYPt4AEQkDWsQoVjaL/HCGdq8x5EF9vAJ2CmNXQsR6DZsoF9SH9Vy0usnTCgp4BbzxbPSxDsNa89XzLWV+Lh6JN6e6k1TbLRJQvTv4EM5LKwj22J9wUcGrjyl0rFz1z6We4bxyXSljX3BDvte6cmNdKjKv0Ij3mmsqvU9A8iogIAvpKmqMqPNgb1B5wOvw+pvu6R4JutwF9ceAzHEqHNrMVLRVFbTpk0NlBHTfAKCDS+RmGcbk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:27:41.2614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22961b62-8807-4b65-c0ef-08dc4d1ac8d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

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
index 7f399ea87a3c..b027b00e315d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2527,3 +2527,40 @@ void __init snp_remap_svsm_ca(void)
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
2.43.2


