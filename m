Return-Path: <linux-kernel+bounces-105755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2093687E3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7451F21643
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3869E1CA89;
	Mon, 18 Mar 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ur+N3kXV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5C22089
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745380; cv=fail; b=OlcJlPT7dUd6Yxmeeiap0Xoc+dR+xIX7YKJ61lJe/IAyY//PBE+wDY/tnNWY2kAb/4vTTC6unFt3kyrWM3BjUn4j+1tv9XzJGplXX20u59WtdlBTu33ccDzTMBftqLiVVbd5tlQptVcrkyWoH6XmvWxMdiyBuuXrPox13aBK//A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745380; c=relaxed/simple;
	bh=+nyU726WCyGOzlx0LHdrXlZzw1Hihj9qhGZSoGU93B8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWJy8yYijEkDe2sQPJFgpmKH/lYnDGXhaCoTBRFYlmYaNodwO9ULOiFjGAIAKCS2RNatExkRgo6BqTZBf1L9m2fJi9XOJhbllsfPh3lTzc8SLj8hh+gMHYSKBW+3pY5Ebh2TOHXKa4zXlv6oNbcka10ygDto+SjHMjLhjU7Pl+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ur+N3kXV; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrAW/DJlShCVfBY5JLleOS59zwrqm06+IHPkWy26eC89vUsLUjsHu49CK3SgZ/L25pJGfrB0DDdmszgn2IGaO+h03u1kwrW9400uTi+2L61iXiBx7manhoammt5x1b1LGZk1pY3NGoh78drxhDUMgKN2PjrGrW/7lxvbsnLzaJB/IteyQLLurmPn7kIpK2Aal07L5tXPm9c0OmiDof+4OUtsBE0xGXieWzT+0rPJDtjT5t5Eea/fUS2rKALYJKX+0DshooZrv9pKTzDhW+BzjV84yZ6mCxqsD5DiaiXDxAsUVV3+XCUcvNkEZUPGnPrp2j3AGjJo1odigdbluWnmiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozAMeWlcir8kjOpBLqgk/m1LAQaPiiMJb26sGSAzAQA=;
 b=OCoRWJRjjqbzzSJbaDkd+iSFuGBr8FD5nt14rUVgh8k36CRTGycSpj6Ku51P3NUyBXm2QTFEgu9PpRqTq6PrdK2zRFUQ+xlv2Edw6JDRdPI+z//zE/LB+WtV5bB9nDXUidWugrX+dqmvfYNuawd3vI6DkuvhPV4nvQOZGRc9VTYElmuRenJyNCL+MprKHqavtvh96ujWft8iXGu7IakHg+WPoXKbXNE6OHoZtIFnN+0gASJeJjj5O1av9SbuIfQ2fPWraojQwEJFxx5FCR88jjaH2OtQ/lfopSpuZLhvsE/bwBYx0IdqILVY6jkZb0wfRAXSoQQg5mmk47xD3RyXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozAMeWlcir8kjOpBLqgk/m1LAQaPiiMJb26sGSAzAQA=;
 b=Ur+N3kXV27+ciZtTULRUW/aefU+iEJPxnnfEG4ZWgMHlWGZ8GkBITjaovgPUogQuU6YKYXD7M7uoMMFt90hvMQQHKJih8ViJYSl7lWBILhbDCepFN5nDgfHhZyfNdDCMrNcE+iro+KpbL7EfLY2WFdez6qfE9ECxqTQwuUcjlIg=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:02:56 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::2b) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 07:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:02:55 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:02:54 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <elena.reshetova@intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <seanjc@google.com>, <michael.roth@amd.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <bdas@redhat.com>, <vkuznets@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>
Subject: [PATCH v2 2/3] x86/mm: Do not zap page table entries mapping unaccepted memory table during kdump.
Date: Mon, 18 Mar 2024 07:02:45 +0000
Message-ID: <8e11825bb3e4a7472bf0cb30c72ae013c25ac8c9.1710744412.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710744412.git.ashish.kalra@amd.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com> <cover.1710744412.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed8c327-59cd-430b-a400-08dc47196fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fpp3CzjUUFVKIkICICCPEawgOT0YHft3HFNXdXwA1O4QwbwbiS+F6mE4Rnzm4HEmw3GhU8oCirfBqi2/fuk7Fk9W1iwtdEGkS0p8IDW2v82forHm8NppsPlcbpTTm1JU0fJ6RH3Pc6nrDKnn80wNryu8dO6WgXrjiq35u1SJdLFiMqjkQUFNzL3zGsl3ewsJZ7kMi3ZuidO0ql/RmtDDD7K6ll1U+hjCv8SiH75wVZxtvWA6IiLD9hZAhwpgedtniYUOGP0N1aoGwW1HSpPpnk5w99ME1uQNmvTuVKybjWejd+kXtWt31K1KI2mflCsZ+3YUJiTPZKiw8pgfMtuGPEP06VIUD9LWLku4gyWsT7+gNrzjhSoFdUlX0pnVEyibEL6e6ZTGebApJ/jYIL40DitMXjOykvxI1j88nxwWi94FFj/8SPQlx4RqP4JX9ZDbPdiXLSCXixn4MJgG0E8EPIpbRLDr2kGvgL8F6ijR8ztW4/0g3IVlD4fxsgIehGN1njcpt1rJCD6oK/ZdRkxUs3/w+Ox2g7cuGYwoQcE9DVuTuuno6t7Orav7RWH/FpB4avMan7ynf4y9YIIVN3PwcFTFk1nK1mxKDxoTu1U/+hj50IUF4FINxoyGZzHTLJDhvsZ+h2iplQ9GrT6bzI6gD3RpvCWus8rJgPY8XbuyAuAOQ/3LVOcVx9NR9lFhHqHOTlZC2QloMjOA7IceBwwtNvqEky90sL8Ko9SxKFTIpxZZ+L6tFVPhUTwEH9NYP3WG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:02:55.5406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed8c327-59cd-430b-a400-08dc47196fdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

From: Ashish Kalra <ashish.kalra@amd.com>

During crashkernel boot only pre-allocated crash memory is presented as
E820_TYPE_RAM. This can cause page table entries mapping unaccepted memory
table to be zapped during phys_pte_init(), phys_pmd_init(), phys_pud_init()
and phys_p4d_init() as SNP/TDX guest use E820_TYPE_ACPI to store the
unaccepted memory table and pass it between the kernels on
kexec/kdump.

E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
be required by kernel to function properly.

The problem was discovered during debugging kdump for SNP guest. The
unaccepted memory table stored with E820_TYPE_ACPI and passed between
the kernels on kdump was getting zapped as the PMD entry mapping this
is above the E820_TYPE_RAM range for the reserved crashkernel memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a0dffaca6d2b..cc294a9e9fd7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -469,7 +469,9 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pte_init(pte, __pte(0), init);
 			continue;
 		}
@@ -524,7 +526,9 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
@@ -611,7 +615,9 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_pud_init(pud, __pud(0), init);
 			continue;
 		}
@@ -698,7 +704,9 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
+					     E820_TYPE_RESERVED_KERN) &&
+			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
+					     E820_TYPE_ACPI))
 				set_p4d_init(p4d, __p4d(0), init);
 			continue;
 		}
-- 
2.34.1


