Return-Path: <linux-kernel+bounces-46061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590328439E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA2B1F276A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0556E2A2;
	Wed, 31 Jan 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IE8EOUIM"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D54204B;
	Wed, 31 Jan 2024 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691065; cv=fail; b=lkGueLNHegXdsB1XAx1GCw2TwpUf3iQnRlwZOzKQ2wUgDUKFQ71sbGQNKka9aD2oQKYWqrvQxeRS0rX3Vt8uVnk8TBr922uuUnx3ApfvNLC5WUOY6P1ObsAGY64LcxasBw8HmM5TqT9sBoFcWYRN9AJBnutbkm2REnIWXhUMDZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691065; c=relaxed/simple;
	bh=DuK/W7eXFUV7VxsyvaECcE5d2VFyrC5LIIan7BYgMgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2pZn9rlx+9j0YY6AmhWrgsQKmig3PslBVM7BRPbqk33f9sJLTp0GzY7pRD618m8DH/LAN7OvQXDT6OSw7wtHvJGSnRO9sWqt6hHx2lFByPfDBhb33nJDNOAEOWpuRVsoeg7WSN9YZyhUhyJSqTnWFB/iPi50fVlFpQnkfLincU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IE8EOUIM; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE+iOXzTD9Ov0yl2LCgpTSHjZpHOZ21zuTAyb6Qrj11G+rCO96iDWZOrsHLYXrHTXeLqTepMQ1RBynlo8MIDkcX5uaMxJjKPARleo5jIocCh9VmZ7XKYouOZfq+Of+UwevNr3qwMAmtGWk4K7OR7f4SE/cqK1dSH9jU64ocb+uorMudjW7nh4M/21TcN1igEET5wOaRFwbcsXxrR9+kpfW5WmLOTGzBUVc6DcVAyJubiQLELV8V2h2b25Dcysw1u4O0kG+ZPiSkFS4qBxk03sIASZlR0XaipO22+e7+w2mG3RcYwzn02JVH/cT/YXKSJXmiK7cpw6p1+cYXwXXNWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tL4jcpFYFds1DbnDgc3SHzn0Gf6keZ5r4t3Rwsr2qQ=;
 b=YCPtSi1Va1NEtERxOLt3XngYKkLL8RsIQpXxlbHI431jSkri4is67n8jsZtXxQiKokHkPSwwtLJpE10iFUIVgmv0ob//Ggwoz6dEwA0vDtJKDEQKSGQEKPn+WJDkm/TtaW9NKxgqNPYbDQjPnWXaKLLUfCyD8N/lmu4CgC2ABFu+DjEZ+bs3V9DLe4v7cEkWjANnfn+qiClpiI3BdkG+npYediz/e7zH1PdyDJMYjcwexomzK1gxFqZBfCvkpcE+PPQ9QakNce2bOlAS0I3e7JrFiM9PdfaiCD8b4RwTV6S8oYGG3x+l/lGL7wXQ2psowQEDl3Ne0C8Mv3KoVN3AYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tL4jcpFYFds1DbnDgc3SHzn0Gf6keZ5r4t3Rwsr2qQ=;
 b=IE8EOUIMSgC+Q2LgaoWI0yXkbWVjXM6mF6WkQ2IUk6w6huyo3+h4vwe5n666/fkv2j81gyyq989ekaZRRqPvZ9qvCRkvASRd9dMgLq2GnCdyrIon/I9oiDa/JzklJm808nnqStlvgdupilFDoyDnWBZfeWKr0xTDxQarQ2LgxKU=
Received: from DM6PR07CA0106.namprd07.prod.outlook.com (2603:10b6:5:330::15)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 08:51:01 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::ab) by DM6PR07CA0106.outlook.office365.com
 (2603:10b6:5:330::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 08:51:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:50:36 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Wed, 31 Jan 2024 16:50:16 +0800
Message-ID: <3a2a5bb22f9ec853cc8762fa1795a75fa1106f22.1706690577.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706690577.git.perry.yuan@amd.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2f035b-2ae8-4058-245b-08dc2239bff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ghBkP41aDH7vZ89saWjlfT7q3ZGkgYDa5PVOgm84Qk99fY8qcsimGxxyEENiaqQDjjY9IugE83nD6iMe2364CCT4AxotIJHfyHWY30jN5yMwSI0U4qnthE8z4GQ+mDeNspbxpEUa8QZAwEdQgOywrkNA+0CoId9NW79KoLMu75TeYTb4PDESeTmFjo9kTLAOyRyfPh4iEXW+NldDpmybfdozobImJWwzm0W/wrsbz9UY+Z9Y+9zseuGq9jOjPg2wIF0gxDAQRE6RnO6L30d0v/6ylttlcEDL9ZWUC8b5SMF33zCeFqVfXkuP60vYSJIIH8rdHbit3ueXaHoOZ0v+nelRO6Dug8H2Z9LMdFAMOR/xpXNFbwk+KyV1468EeSPCk623HyLzgogZ5ckiAwxAYOPtKoTTqsSPRRhxFrw3Opxj7ggdlNBXwyoO6VXr2q04KoIHgd0TpgUuSgEXFTkK5hOoCgTBuP22Gp2foWk9jvQUI8OtjlxzzMAOCag5PbUQgPM8/V0MDqT1M8hKGzwF837IvWT7yjsg0yDmPvT7kUKa67Et3IOUGXWfWP9qVnNWDIyouS16tVA3QHJVM+FCKXIkzUIgUqdFRt0pvfyPY+/qJdByt5CHp3SiKnZCfe20yu24nmQ/7lGAmlecwJ5/xNmSxPAg6884VY5eUUVhfo46EFVR8oLwV7dTwKgWRgnuvpMSg706FCux4ma4SOxkiclFYYdpIJB2Xo36YuZHDhHzVZic5SR8Dr/uui8aEzBrvDm6YJI0+uB1AphVdV7c9JJDWz3mHJcBI7zv4EwebFEb6Ss+0rQ+E8k/YglGlG7E
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(36756003)(41300700001)(70206006)(70586007)(86362001)(316002)(110136005)(6636002)(54906003)(47076005)(6666004)(336012)(426003)(2616005)(16526019)(7696005)(26005)(478600001)(966005)(40480700001)(40460700003)(83380400001)(82740400003)(5660300002)(44832011)(356005)(81166007)(36860700001)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:00.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2f035b-2ae8-4058-245b-08dc2239bff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

As there are some AMD processors which only support CPPC V2 firmware and
BIOS implementation, the amd_pstate driver will be failed to load when
system booting with below kernel warning message:

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

To make the amd_pstate driver can be loaded on those TR40 processors, it
needs to match x86_model from 0x30 to 0x7F for family 17H.
With the change, the system can load amd_pstate driver as expected.

Reported-by: Gino Badouri <badouri.g@gmail.com>
Issue: https://bugzilla.kernel.org/show_bug.cgi?id=218171
Fixes: fbd74d1689 ("ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/kernel/acpi/cppc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 8d8752b44f11..ff8f25faca3d 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -20,7 +20,7 @@ bool cpc_supported_by_cpu(void)
 		    (boot_cpu_data.x86_model >= 0x20 && boot_cpu_data.x86_model <= 0x2f)))
 			return true;
 		else if (boot_cpu_data.x86 == 0x17 &&
-			 boot_cpu_data.x86_model >= 0x70 && boot_cpu_data.x86_model <= 0x7f)
+			 boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x7f)
 			return true;
 		return boot_cpu_has(X86_FEATURE_CPPC);
 	}
-- 
2.34.1


