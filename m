Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F77FD47D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjK2Kkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Kkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:40:35 -0500
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013009.outbound.protection.outlook.com [52.101.64.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11281F4;
        Wed, 29 Nov 2023 02:40:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgtIDUXXkdftmd3P1b/iXbpB2m6VAf87+YcDBorTQLWZeiJ+WEL1I9rQ57uNdOmxRldAz8mqGz+kYNqHo31+kbm9b1ehS8G3sW3IYJQmJvev9rA/Bu4lqatI0BLtLGf1+IhK2E9AegsiWOZ7CNmysgnHENiKcqyobmmuMhT4z8tDZJOOVIIYSWIWVN6ky3bL1a7njlFlmMykkudz6dIny3AH2eJOow9xaAOM+rcn0BqNWI+xi/sJk0xzPuFD2JVUmOMH0ub6uGoGb96IX3LiPKvBeb3062Y3VMApDhj7sKlYNYEW6HPTMWhQKEkl2HrIS5OX/aFmnDmztmBmecaHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6LIrnC9kJX3cXKQlLlBnj2uLKWyLKFP+T/775UA/f8=;
 b=i/ubzpMou8nxWgTrGwJq2RRhLxQBhUtGC4STmcI2SMeErDAnPlP8xGqxI03OO88sp2GFmLAokXYqAat1m4kDNEm/92udtXXjtGnERuAw2IkMMKsWcU5y2EHLHC64BEMhMmwLKMnV/4cxM8HxMb9LQCL8QROZpyXoIUekAuwpdKMgOtd+4K92HO0Gdh5/Z47RLTEOPREhm6mwW0LAdQKAZI9KFgUxi9lZIGFhaPXEziS/SjuSH2p7+UeesxBGTbKBa4vAF4dbX89bOTu11vllTlaX66PLn92wxArrZfonMOs6T3HLxvDcUIROaShtFJPq3N1Dv5NTcXS8ccr5AWWS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by DS0PR05MB10176.namprd05.prod.outlook.com (2603:10b6:8:15c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 10:40:37 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a6f3:b0ad:90f:e26a]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a6f3:b0ad:90f:e26a%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 10:40:37 +0000
From:   Ashwin Dayanand Kamat <kashwindayan@vmware.com>
To:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        bp@alien8.de, brijesh.singh@amd.com
Cc:     kashwindayan@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jroedel@suse.de, stable@vger.kernel.org, ganb@vmware.com,
        tkundu@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com,
        amakhalov@vmware.com, namit@vmware.com
Subject: [PATCH v2] x86/sev: Update ghcb_version only once
Date:   Wed, 29 Nov 2023 16:10:29 +0530
Message-Id: <1701254429-18250-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0183.namprd05.prod.outlook.com
 (2603:10b6:a03:330::8) To BL0PR05MB5409.namprd05.prod.outlook.com
 (2603:10b6:208:6e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB5409:EE_|DS0PR05MB10176:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b39c6c-aad2-4cbd-e2de-08dbf0c79f9c
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amNLHAgHXz4+eWDmks5AzFpsYwQwx1Mn6ykuFgzMbfeJeQgf1pZw8fTGxiNN4CeOlj1LGZ/dUDUZiYEoDRDZViZ0u5tQZjQeCncJeyDNirdJ+0Qlj5FUpdJ1Tf7MPTNIVOOYb7Is8tDyNAmTIs7znlLFZRBbVse+zQCGlPdkGD0vvMCpjLCqnIl3vSgMKpKJYkChMUU/G3QvVi+j8HJfnJlh/aFTXHOgQEFPvtStMx3NkM5afMF15bYTX1Jj5Ud/+jZUsltkJZ1byAn3LKgxRJPhv8vT1sCW7gAcum2abwzOIHF+SB1Wkh5kPFVw59LmotFnO3H/deBvh3oaNYI9KpsobwjLKpfu1y8//1JYS+IuljGQF3r32FOov0UOJ23whMLGBv6j7/U4aUPODzDhlrECY72n6p1GeR76cdCygn7GPW4WAzoRh0QPrzJz6QMFF/W4Pk1Ma8hwBPyAum/UGTe34/9dSKyXGBc4USmu7Ds99DaJYr9SZXacnFZuBJG4hJra+lVyHhDFVS6dBqvRIaURnnwNnvprrD9i4cNyNvanuCekSZ/Apgya8NWvVd2WFZKXYFj22h+01pTvXGFVvUOBjuAsvZS2NxmwpG1tmDmFDA0Q1LQ+u5G7dR/27H4LBzcNIWRN868JokiuWYhgUBd/7Ac55rs0qNmrs8apdgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5409.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(66899024)(66946007)(66476007)(316002)(66556008)(8936002)(8676002)(4326008)(6486002)(478600001)(2906002)(15650500001)(41300700001)(36756003)(86362001)(7416002)(38350700005)(6506007)(5660300002)(38100700002)(107886003)(26005)(52116002)(6512007)(83380400001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UEtu8bXPI2Qnr6J3OlaF+QT1PtCoRpIFjSQpn/1gCGddnsexX8Y+NwsUnH+O?=
 =?us-ascii?Q?WHrJDar1PLxhRp/nlo2D71y/Lk+QpDfOCGcuXwqoOXWIjPnbLtNNPzYW6c3Y?=
 =?us-ascii?Q?IAIL3VUc/9ZoPLuH+9UUzDJwD5/GZztA5Pb5WSsYUKXqkd6MNjLIAmTwfEbP?=
 =?us-ascii?Q?21DRRJQtGZ7V/tOztT7eVzmgJf1CSN8ff4s7IElSCBULEU9JLKwspwJvGDEQ?=
 =?us-ascii?Q?kwH8egXLdTvyfay/CCUDSnV7x7fbCjw5xCenNu1lPBGcvZf0PZ3S7xiNqm5H?=
 =?us-ascii?Q?mFlP04gqQQtiJPqSV9/BnMRoPas62rgJfA1goAL89pjhBwmG+PfNHWwvyRQ0?=
 =?us-ascii?Q?NzZVw19u+xoV0cts6zD6YFifdqB9HofDZDA8VISm6rAwFY1ItfOfrrO2lwQa?=
 =?us-ascii?Q?f4anvIPqtlJRFFrmlKSJhwTdo8hwBnbeomp/XGwprp6JhBhgwpF41QGe1gNi?=
 =?us-ascii?Q?UQ7C9m1pqeX7e2WSeOaVvUdprUs8bnF4OQQBkUH4Sb24ajOnBml7I9spiMTF?=
 =?us-ascii?Q?GY3tHBjXwFYraimw74njZnWTn54vOURpnwuhelzh3JCv7keSrLZiPHCgXdH0?=
 =?us-ascii?Q?MekgPi4YtCm4S5qvWQg6BchW5Q4V1ZmJ8qGgrRKm7VIhMGUV590GlSjsIP6K?=
 =?us-ascii?Q?nTqWPZ9QYWnLAkYOt5YcTGxN1ncn1OBIKnAQDav4DpZ9f/4z1YqHzLO/wOgT?=
 =?us-ascii?Q?77C4yVaEcLCh7MW4nmb75110svdcPu1oclmwV3L4bhJQtUnDrkcLkj7OU15M?=
 =?us-ascii?Q?iyqp/4D8S3mIOXzPAhSWj9yJIJ/mHv+rZv7iYhpYegOzbFemI1UcS+04rGw/?=
 =?us-ascii?Q?hOBj0H1PwAXvTDg5cR5vOGH7i0JgsElWZg8dZwLZT+JVvk5ZM6po5TEq/V9R?=
 =?us-ascii?Q?ke7SFRNqNIcn0i+x8nhLlJnJpvgBPTeMGBfwd0mBzqr9CRaRYsZKYvu+dlS1?=
 =?us-ascii?Q?vRmIhQkllye+i+YhVwBTiEPqbSMqOjMWonavodBl9BBcbYZVf0rh0Zpj+yEq?=
 =?us-ascii?Q?PJ8AY9Fo7bUjet/ydC6ELjZ/R1O9Xlm/jA7/DsLpmQhaIV4ZjRXN0R9y4Ke5?=
 =?us-ascii?Q?wFxZocIyc40bOAvfS5logqi1wT2+KKsJr6ZQ4gGEVzRZpSS0x/1XZPeh3Ggi?=
 =?us-ascii?Q?37H4rcrDoGswGC312lQjCZYSzp5RH2tGSAsKa62oWVOn6NTyLKzZvv+kTMk0?=
 =?us-ascii?Q?bcXf4ulpHHyukxlbxOf9D5OANiXCXPpaB5ZipkEC/PBKSVH7ighhEg5hqj+I?=
 =?us-ascii?Q?7OddB623cE7jmxbI93QcccZi3lKX/s133OqeIih6qJpl58Y5a+k69Bf33ImO?=
 =?us-ascii?Q?6D1kN1qghrdcH4Fuux6AiDOEGe5GhLhQmeSkq4IZpgPZbMGAhUWYmeq7u61O?=
 =?us-ascii?Q?z2DkRMT5po4qPrlXd+9HojxJavhqgufbfBRHBkhtl6aacAIZhMTb2Ugs95BO?=
 =?us-ascii?Q?z/0Z0sxIiAGMZN7ouiqiVuCv+lxYVI/Sb3r2Rp+gmDXU3ai5CJ22SpvdIbad?=
 =?us-ascii?Q?hiPgHofSAHOb3RASEMaBPRoaS8v/IRnk10QLdmBE+pn/W8hiApkEgdjeqrmu?=
 =?us-ascii?Q?k4L+CPe6NtkyWy9ZJrrTfw/9v8d4sQhYeyCjexdBc/R4zw4WsLrcA2nz1FsW?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b39c6c-aad2-4cbd-e2de-08dbf0c79f9c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:40:37.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESOjEIImYKyoZODsoECSwG6ejuPvZm/JeaAT+VPwGI5q/TsSFMb/ZiLVKvfwCVd64ZJFOrZ7J7Gaa7TCKOh/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR05MB10176
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>

kernel crash was observed because of page fault, while running
cpuhotplug ltp testcases on SEV-ES enabled systems. The crash was
observed during hotplug after the CPU was offlined and the process
was migrated to different cpu. setup_ghcb() is called again which
tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally this
is a read_only variable which is initialised during booting.
This results in pagefault.

From logs,
[  256.447466] BUG: unable to handle page fault for address: ffffffffba556e70
[  256.447476] #PF: supervisor write access in kernel mode
[  256.447478] #PF: error_code(0x0003) - permissions violation
[  256.447479] PGD 8000667c0f067 P4D 8000667c0f067 PUD 8000667c10063 PMD 80080006674001e1
[  256.447483] Oops: 0003 [#1] PREEMPT SMP NOPTI
[  256.447487] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.45-8.ph5 #1-photon
.
.
.
.
.
[  256.447511] CR2: ffffffffba556e70 CR3: 0008000667c0a004 CR4: 0000000000770ee0
[  256.447514] PKRU: 55555554
[  256.447515] Call Trace:
[  256.447516]  <TASK>
[  256.447519]  ? __die_body.cold+0x1a/0x1f
[  256.447526]  ? __die+0x2a/0x35
[  256.447528]  ? page_fault_oops+0x10c/0x270
[  256.447531]  ? setup_ghcb+0x71/0x100
[  256.447533]  ? __x86_return_thunk+0x5/0x6
[  256.447537]  ? search_exception_tables+0x60/0x70
[  256.447541]  ? __x86_return_thunk+0x5/0x6
[  256.447543]  ? fixup_exception+0x27/0x320
[  256.447546]  ? kernelmode_fixup_or_oops+0xa2/0x120
[  256.447549]  ? __bad_area_nosemaphore+0x16a/0x1b0
[  256.447551]  ? kernel_exc_vmm_communication+0x60/0xb0
[  256.447556]  ? bad_area_nosemaphore+0x16/0x20
[  256.447558]  ? do_kern_addr_fault+0x7a/0x90
[  256.447560]  ? exc_page_fault+0xbd/0x160
[  256.447563]  ? asm_exc_page_fault+0x27/0x30
[  256.447570]  ? setup_ghcb+0x71/0x100
[  256.447572]  ? setup_ghcb+0xe/0x100
[  256.447574]  cpu_init_exception_handling+0x1b9/0x1f0

Fix is to call sev_es_negotiate_protocol() only in the BSP boot phase (and
it only needs to be done once)

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Co-developed-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Bo Gan <bo.gan@broadcom.com>
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
v2:
As per the review comments given by Tom Lendacky,  did below changes in v2,
 - Moved sev_es_negotiate_protocol() after initial_vc_handler if-check in setup_ghcb()
 - Added Signed-off of Co-developer
---
 arch/x86/kernel/sev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70472eebe719..c67285824e82 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1234,10 +1234,6 @@ void setup_ghcb(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
-	/* First make sure the hypervisor talks a supported protocol. */
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
 	/*
 	 * Check whether the runtime #VC exception handler is active. It uses
 	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
@@ -1254,6 +1250,13 @@ void setup_ghcb(void)
 		return;
 	}
 
+	/*
+	 * Make sure the hypervisor talks a supported protocol.
+	 * This gets called only in the BSP boot phase.
+	 */
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
 	/*
 	 * Clear the boot_ghcb. The first exception comes in before the bss
 	 * section is cleared.
-- 
2.39.0

