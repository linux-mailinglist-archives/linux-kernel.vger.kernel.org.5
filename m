Return-Path: <linux-kernel+bounces-70688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D23859B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AD31C218AB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5F6AC2;
	Mon, 19 Feb 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3x7XCU8"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A00533CC;
	Mon, 19 Feb 2024 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708315086; cv=fail; b=o1bJSJBXXVQyn3cbWLgSW4K91c8Gje6fiQiPfNHxhLwM/zx23YceF4iiSWyqn2Mb/jiTSrIMCY979K9mF27vNYOTgJcOFmfW8orUGIoN0XEhZeINn2HeFsRhkfYlG5ye8yfsKjBr4/MEX3Le/rMx3dj9XgVzQezkXMvbOyMZxuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708315086; c=relaxed/simple;
	bh=QP3Z7PV42JzXmj/C5mIltR+wanmWc+N2o5vsQe6Phg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDoB3WiBxL+HVgx4P38eA7eVfIVVP4I5AyucTBWVvTzyl3gsqXNdvQFTFX+UOXprzIA3rIJrXjAoM+g9AgufU4KKR6bYzlMkjQJhO7dgd1MGu+L6k2AusbBy+I6/VkHSd16cmwz1hzmcBhwee5vGKVBhJUr8lXEIBbLmZCbnNWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3x7XCU8; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ps7L4uLbddblsfcvXRu3a2KlhcQ4bcE0N7A6Kbvu6pDPG8gvPBHfnViJfoJLNBNBjgrB+lft94xXndgsb9luL571Cx2yLgKiqkSWv6vxNXJ1aU2HvVnRUAFR5tXkfc2sBn7K3FGasa8ClGRxX+Pte1IjFK/MkFllcxxT351ctxf6+WTeJTDSoeeqyFLTOA+r66CvnzD+guDDP64cIaIasDhzrj8jjPabzEesGw/XwZLHKhEG+fczElyhqlFR7muu38/hzzk3jDHlpsKUEY9og0psY/8CSnTrFB4tLKQ+kcKwNHFzeOU9RTqLg55vKoT+tfeSUxb/fMOcW2JPID6oMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOgmnhU8M2bjZ43Lrv0A9ll0gwRP8pNgM5MomfQMQ3M=;
 b=ej+5FdEVC41SEL2uSxAPqPF3kTUlX8nGKZm5608efwTHxw9qvOhH2A87JH9dJrs/bMt7kMo7HIicbZRRuGl847EHzCFgoFh1cPZRwkTvusnDsv5TWA11s2t9mphH19LMvhrYzdduo6vrbzWiFceboe7RvLtXDOSaWC0+GoOz3Kb2oGG8QQSGw5T93yBH+UJaqo5lywak0f5xeq4NCdlU/cDlPEu4xdD0f7WO+lTYzlCQstUrJGINvoA/2U0W+VwTlP2Hko5/UmDAQN0IONibWNEnf1j8gz7hPoGSbfSuqBt6xxWh7kRiGtxjxdFjGxK4sGnHct9y2oXmJ1smz2zakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOgmnhU8M2bjZ43Lrv0A9ll0gwRP8pNgM5MomfQMQ3M=;
 b=p3x7XCU8cLsRJEYRX0yCUQWawkr0U8PBn2rq0pBWcb+48t8tEP6bkDMFRuy+YfGN3HPKOTThbPmOt9vV2oEBs7ZLWJj7I9nxU5EJb6+R5BkH8sf9oKZW0fJC+NjVh/j9HUcOEBrprBcC875YxbaB5fyy1ikqH91wLH220up9ElM=
Received: from CH5PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610:1f0::25)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 03:58:02 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::c5) by CH5PR05CA0023.outlook.office365.com
 (2603:10b6:610:1f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15 via Frontend
 Transport; Mon, 19 Feb 2024 03:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 19 Feb 2024 03:58:02 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 21:58:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hdegoede@redhat.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Only update profile if successfully converted
Date: Fri, 16 Feb 2024 20:23:11 -0600
Message-ID: <20240217022311.113879-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 46322f33-1c63-4f1f-551a-08dc30fef863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kqU/JZaRgY8uHASU04FPIZEbl6vsFO1ftoXCFrdwLh9GsUFSIAL9ZkkaXpR2xx5fLInlOddMHDvzgbUk5Imix9zEftEQ6uqn0a8pj6heFuYFRMNum3XSZeujB5uvEbOq1aGHqPseFXf1Ml6xUj9FWSn6G2PXVDm+dm0woKnsvjFCKLnmK4Lf9KmfqwrHoYKSm/x7/vlJ7qfaqnIifSzeXXpxFiN8JOH7K/iO/UHeOzRy6ev0+anmabdO7RzZZS8mSR78QEl+uls2gSBs0ZIIVAJuVz6VOBq2nMh/RULyjvLgXdgXafZyqbMKTXdYUzTrcV/rxjW1rsRXfhddICupgvRYe9kUsNUHdjs7V/Y8z0IaSdqv5zuM5Eu5bRKrmhA58jjqGsJQ4XfkD87UdNbLXZbwc1nii263PDMUXtN188sibnoxodp2+ll0y2uCV6I2rgi5ntSzxKPITSq65u7vfpitSZ4qnFN9qbmEr0o3l/PV+7KSO6KKbC5p1kI9cDJOc4FR9MiMgIj/DwdBQHv94Pg0P3MbL6VmrpyackqquFlfRKJdvlSiUQJMQeNiH6uf5nePjE494WgOdpKam0ALfxaqttZXSBrCiakVkQm+z2Rn1k2ZKzx6OlpP61zOR60XPlbY4s1LeQ4LM1E+6DMx/5QQnKv6KQs7YHqAegzJCqE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(230273577357003)(186009)(82310400011)(64100799003)(36860700004)(1800799012)(451199024)(40470700004)(46966006)(15650500001)(2906002)(44832011)(5660300002)(426003)(26005)(16526019)(336012)(1076003)(8676002)(8936002)(70206006)(70586007)(316002)(4326008)(41300700001)(2616005)(83380400001)(86362001)(7696005)(478600001)(6666004)(54906003)(110136005)(81166007)(36756003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 03:58:02.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46322f33-1c63-4f1f-551a-08dc30fef863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027

Randomly a Lenovo Z13 will trigger a kernel warning traceback from this
condition:

```
if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
```

This happens because thinkpad-acpi always assumes that
convert_dytc_to_profile() successfully updated the profile. On the
contrary a condition can occur that when dytc_profile_refresh() is called
the profile doesn't get updated as there is a -EOPNOTSUPP branch.

Catch this situation and avoid updating the profile. Also log this into
dynamic debugging in case any other modes should be added in the future.

Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile support")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
BTW - This isn't new.  I've been seeing this a long time, but I just finally
got annoyed enough by it to find the code that triggered the sequence.

 drivers/platform/x86/thinkpad_acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c4895e9bc714..5ecd9d33250d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10308,6 +10308,7 @@ static int convert_dytc_to_profile(int funcmode, int dytcmode,
 		return 0;
 	default:
 		/* Unknown function */
+		pr_debug("unknown function 0x%x\n", funcmode);
 		return -EOPNOTSUPP;
 	}
 	return 0;
@@ -10493,8 +10494,8 @@ static void dytc_profile_refresh(void)
 		return;
 
 	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
-	convert_dytc_to_profile(funcmode, perfmode, &profile);
-	if (profile != dytc_current_profile) {
+	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
+	if (!err && profile != dytc_current_profile) {
 		dytc_current_profile = profile;
 		platform_profile_notify();
 	}
-- 
2.34.1


