Return-Path: <linux-kernel+bounces-49516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC69846B5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06677293178
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3017999;
	Fri,  2 Feb 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUuMsC4s"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B1604B4;
	Fri,  2 Feb 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864181; cv=fail; b=gqPvAsiTRH6U2lyCK7HA6kSSBGN9C0ukwoelFF6ZNUKpEE/DmyNDWpCYZr2eu+TNJ+uD+v0HaRf/4YOOC/3pdXKTMQ02F8Y8MnGxwJDc6axieAoiVYMndccwY5kMZlW+lrcXQgDD2vT8vJh8sYSmh6hWcvEkJAo/bRNtQ5yE0No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864181; c=relaxed/simple;
	bh=parJunbqZZM7FLADqKwaaiZMdZ97E7FxPQ3zim1LUl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyUG74HSWaVBkqvkvYrz02APSSUV+gKD2ahUUUZotgsOCyuKoB4IL3z53MV++I/h4E4YjR3EDyrhVwgSGC9/D3EmTBKDbQ7M6DFZchC/efjc2cASGA0UGZXVxZlCprN/CGGUV2KeVrqH2ZLlfMd/yezbShXlQiKP3FaRcJan99U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iUuMsC4s; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRxm3fzNoLPS/LIcEv6CYoicRA5AnhhJNCnhRTasBN+uLLt22Ka3FzvAUouJGCZJMwrX8l8rLsAPSFzCzdS+kI3eCxaeFV7qHcBIWpkLeYOwoakFgopRAhx9QhFMImyMFb/KxOvw91lzJ62lRrohdw8IpIIaO5yegTeW5p44ecpWSVWAKRkO9nMt3Pib+EfZ78BYapG2FrcjVWbsjJ9kmW0C3p7HmSe9usk0DC+4sZ2T8sGqxpdHyI2j4fXJiV4/BtnlEffhtnb7AlAt0DgwlHER8VZ5PwxEvlSckpj+1tJwWOCtdxm6gBf+Gfcu7oGamKq4eiESHg0zhYvjrIziuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=XBTDf3+sniEe5Qkyosz7clsYZSX3Ux7ExIpqypVPXu7Qh66Xd++J4+Id8G2JcIfdwAk+0LblhXTswcpE5QxcwfqVzr9/h6Kqxn40vzOhLoJ1kNbjlK3KIujSEn6bhfMX8CxZ2mDyO+d82t1qJMTuavc3zlc31nIf7f7Riw/+OtpquzGEfpm84a4dIdfTcLHsQoYohsWG0m3HH5Ph1KjUN+InNvH23OVdovnIAkAcf6qzCIs41kfr33kfWQTmeqOoIuaNgmXklHoSTQ4mmtuhy3fmrJ61mSp98og2y4V+zpiXC1DYGgoJXIKSsg0Nv66ywk1uQgl5Y5yGQ9vXT7K1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QpCmGfGhowPUaMtKNBh5csgXHDS1etmh/Yo0jzAQY=;
 b=iUuMsC4sLeRfSiJaqCxbwZkYJkFLvqfxMAit3fSCv74knrRDEJeaIuNHwgAp2eCgO7U0muX4eZ1itJig8RPHiGeefLy8r5hQEWkw13+ABpQrz3YwusRUdfsRazLr+yXyDsOnNGmoRwExznVkPceoWc3PfrGmvASY2qYpUT12H1A=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Fri, 2 Feb
 2024 08:56:17 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::ef) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:13 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/6] ACPI: CPPC: enable AMD CPPC V2 support for family 17h processors
Date: Fri, 2 Feb 2024 16:55:33 +0800
Message-ID: <f6ace4124c45e523e984b4eeab3760b95a70b72d.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b127a1a-c4cb-4db1-4920-08dc23ccd179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	afWJE/VGznrUBQSIvDHC2ysayP/BV8tfHYmjEHK3p7RRH4icBcKM7LJ9I+Bj/X5UAN6o57khXx7AX6iMMBFXBYDDMyvG3IPo1xHaezgqXsBClXoJu3uwd+2pvyC4EztdmacYPudIRUIOGNGIct9oVXAD7Xj4EccWyUgClnngbtooeXlFRqDuvzqzUy73zgS5bcyR/XDm5bj2Ya7Uo8Q2BOGW7dCb2Uiun9zcR+lwLGb5FN2fTpnlOZISgfUP2/m/oModXJotuLUOL3zrBSyzmEBka0G2zREBw4we+1DRgN+KYoP6TmXmIlobHyJCbR3uW9H/1BwhGQVd+Z4epmrNsZFgpUGVxfpsxtHd7Hb7EBO5WS6wiB7QkMgr4F+T8P8xDzkTHq8a9si3XP2yrmQVEDYVFTjTNAxZXKC4VmLVefedR7Ab2W/1XmCMQ1Yb0ipCUmUoGsTrftaWjcj2Xzd3uxuKqs/64UofpVWKS2oxYnxAocLmHNgmD5bRgp+eYo06YUuhBuLebQbP2slkDVnukq/FsRksX5DtQWvpU97+ZnVp5c4yF8dBK3ihoC5R9XwSrokERIn7xLroc8Iybjl5M3Ox56IXEyIwZRkVoxpba7wxtJF6MEFW0ATs9ZF7KYIivr7k/CA/zqUvq4/iUIx0s8qh86ptQ3A9MQZpsyXHfsq0I7lE3VGQRI85L837VJIYTLkogF6143QWGqEOk7XFr0iWGGG0nrIqSJvJ4PJdTIjBqfo1W//UF4dtoqyvs6yvCnyeGzmg6w8R8tp9GwyrqqRpcuw4t2rx8lTV4f1k1gKQsPFnSnindwdtCZyZqBYx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(336012)(40480700001)(40460700003)(36756003)(47076005)(426003)(7696005)(26005)(36860700001)(478600001)(83380400001)(16526019)(82740400003)(6666004)(356005)(81166007)(70586007)(2616005)(110136005)(966005)(2906002)(316002)(6636002)(70206006)(4326008)(54906003)(5660300002)(44832011)(86362001)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:17.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b127a1a-c4cb-4db1-4920-08dc23ccd179
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996

As there are some AMD processors which only support CPPC V2 firmware and
BIOS implementation, the amd_pstate driver will be failed to load when
system booting with below kernel warning message:

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

To make the amd_pstate driver can be loaded on those TR40 processors, it
needs to match x86_model from 0x30 to 0x7F for family 17H.
With the change, the system can load amd_pstate driver as expected.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Gino Badouri <badouri.g@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218171
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


