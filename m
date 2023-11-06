Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773B07E1A40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjKFGc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjKFGc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:32:56 -0500
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11010000.outbound.protection.outlook.com [52.101.51.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D554B8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl31Zz7rOXIenj6jrVPg9zT/gX8puzMtLdbkCXue0Nwk9/7Y1aDNoDXxgIq+OB9Yc+7tRznQqZ6m5AsnKW+viTFSzr1zluchsG/sHpIvz0gRSoKpne37voweW8M6Mc8HA7XCd9W1JiCgityxNlXr48cPbJkP5Ez1vaizxghwKYieOvQ/6nzHbE1ddKbQI56ZEs/v0EnFT/d1sydF8xBF1YYegF2IZA2HUp44FDZ2hLgalsNGXnF2maM4aiWtTDhZOc52nPhJ+k4pGBh7LpZ29x1VnxGbtcRp9RP7A1bmh5hrsU2Ld7KaYSo3Arv8T29RADcDo10+L6bPDI3DEtXjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iopd8bJIDHe0kJ2XnHWGyZuLeUApZmKHz2KTZxSQr/o=;
 b=bh/8Xe9aRWO/dZd4iTyJqB38XGoMTuUgRBcRhfgUkhvWhuDcSW76UDPpXsZvTjuQN0tIJxeUuYdcjYbFuMap1Qn9Fj1FvXVqP02enx/V0PvRIYazRnmBcHGmr7wSkMCos0unF3AZwjueovaS0zgXiW4fjoqtsQufV6V8qRjTEVVWzSkqbLYPWlRWNHGxBIhTMk0Hm5KgY4qY5lPU0bcR0jyqEEptc3ON9ud0RlwBeY58EAsk0Tu/4iVsI9d/26RWOY9o3Z2xMow3wvIFeiR9GA14Pwzmh2CY1V+GjZrUE8MsxZRQeazNE8PUiyKNbShRzaRCfAUsjk0Ej0yvCvrfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iopd8bJIDHe0kJ2XnHWGyZuLeUApZmKHz2KTZxSQr/o=;
 b=txH86eP4YlwwSK3cP+ecWYEP9XjZEBJO8WapGINRj0kjeepZzgC8VU9BPwk1l+yJaIX6SmFd1xIsZd0cIQL2+NCcWGnbyTbbYIRxShQVPJvb5/CFEZTtxfqTjSYsXvgD6i76sIC+jk2QTWVaNUgUukFWRZVAG/FAJfDhTJ1tmXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by SN7PR05MB9359.namprd05.prod.outlook.com (2603:10b6:806:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 06:32:51 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a2e2:a1b2:a151:1684]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a2e2:a1b2:a151:1684%6]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 06:32:50 +0000
From:   Ashwin Dayanand Kamat <kashwindayan@vmware.com>
To:     linux-kernel@vger.kernel.org
Cc:     kashwindayan@vmware.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, thomas.lendacky@amd.com, jroedel@suse.de,
        brijesh.singh@amd.com, ganb@vmware.com, tkundu@vmware.com,
        vsirnapalli@vmware.com, akaher@vmware.com, amakhalov@vmware.com
Subject: [PATCH] x86/sev: Update ghcb_version only once
Date:   Mon,  6 Nov 2023 12:02:41 +0530
Message-Id: <1699252361-1286-1-git-send-email-kashwindayan@vmware.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To BL0PR05MB5409.namprd05.prod.outlook.com
 (2603:10b6:208:6e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB5409:EE_|SN7PR05MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de87c79-67f3-43ac-5d2c-08dbde9232b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxDy/EUW8dVEJ5fFQf1IIGZ+RQE8+FSnbbmMSJb63DZdo8bK3KI8lyyuJ4LmqW7Pf7HfmC8T2b7hjhyhi+v8f8JCzH9Wq9U3Rdh2rgG4aJrywS/xA+E9ubXsrbfNAScduJO7nl4CUmpCA3Add0MxsndGynx0Kc0L2vwWIIu2U7Mi2YVN+Lj36Pg8HWsSFaABJvTZHXYwGnbhNmWDfz4Lk+7LjChr0FlaV3iLGdk87z3BgTRRBjbcb1Oftv/23Y7hhbC1eMd8GQC6mZFGJY/Yly0YC+BMQeFN74kfhRqYbjqGmQ1wGDL+E5kMLd+ie3xr8UTTraqp/tMcRyfJ/Dd7H1h8Z09sLtJOPGcmAiULfBN9uGpR2xCdvUGQ2IkhcV23/GXSfzYuP+gv8HQOhOCSbjc/jIofJ4fLrDJbsh6EWs0MDkYsQZVeRJ0D/ASZLp/U1E2hVmyHCf35hm6cTlN8EvHyqvk68vNwEmu5TCvglDVEIrqFQaATyIW9Mj2+P3nNrQ8DItS9AUVStaKJARJ0wT/nPopvTZHv9OA7G6+ASap2ZEXfRVfOOOjNfaj9Bsbt4fqNgC5LfHc51KeeGmK17kowPGVzxjTS3UpKBZX3XE+IUG9fvEG4XsG4j9ofcLkqyLBqHYqAKYN3VF6oJqynKpVp33mz4KITo4CRV1zG5tI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5409.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(107886003)(41300700001)(6512007)(6506007)(52116002)(2616005)(6486002)(6666004)(7416002)(316002)(83380400001)(4326008)(8936002)(8676002)(5660300002)(15650500001)(26005)(66476007)(66556008)(6916009)(66946007)(38100700002)(2906002)(86362001)(38350700005)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BzOxQo6sgK9LNSwXkJl/LU7AlvCeRfCsgwtI1aseyQGFWSd52w/sWQJiIR+N?=
 =?us-ascii?Q?2idYulJbvcosus9nBQRlyRBHUiURy4EBfllp/HHD0/6ZfMEA+z1MA/r6tZKx?=
 =?us-ascii?Q?Gzl9OkktMmZSyb765IE6abIGc0kJQh2s9wsA5Dq5qM/cBYK75oZMYngKTj7U?=
 =?us-ascii?Q?Wu0aLSYn6ZGmMgeZmZScjkq03RSZIMOEYyP+8vi+OXosQRQrhSPRHzV3esRr?=
 =?us-ascii?Q?sIumi+EZo6ceGt0ZaW3ulDunIFK2y4flVFFr8ioBNNMC5YkfKFVtLyZ641Th?=
 =?us-ascii?Q?1VGBwk+swjNJH1PTuyiFp7gIXhkV/kqig3OKR7MTovqKWFLdgEawqmoh0hOV?=
 =?us-ascii?Q?hLjh0UmFw5dBBB06lCI85OomwjNP50aq61CfBfAdPjIUWB/2UAGdzfzlXA+q?=
 =?us-ascii?Q?KgKiURZP+eho7RRqobkchjg1QoYgFBbBivBA7ILxaeKziQMgY1bUrmec2u2l?=
 =?us-ascii?Q?IzyP/F/XO6bbT2W2/m6mXAPjcQi/ZfaI5wmJS3L7a7Tan7ny7SJFJqoeKLIu?=
 =?us-ascii?Q?m6vUnqShGx2Q6AQBnmxVCs17B2h4zh2399qCttok8LQhQUbI6Z53iNpCPPoR?=
 =?us-ascii?Q?bnPMcQuGoPaSZkfVCCo0ws2km18+ndhwWI0fc61UFg1Kkvir6Ly2KiG7rYAp?=
 =?us-ascii?Q?wbjqqfcuZPuCf129+yHt1FeG7nxXSREEg5vTMppB/ofo1P4nmkpsHPkwaW6E?=
 =?us-ascii?Q?zgiSEuP2kpKeZESUif8i9CWP/7uS4VCRZtHIneE3+swOEJRUgjXyA88FcnDw?=
 =?us-ascii?Q?xAuZkswDH1k+puThXje6drVXBXICh5iyZCzPij/QvnMtBAUHrRjF2xYNyMx7?=
 =?us-ascii?Q?pKk7fMJUpEfqwIlBIwyR2m0Bq9ja7pV3SDlhZ9vsxtAALLy5DRYs/1caBv2W?=
 =?us-ascii?Q?5GyNV7AOrZL1uHw0VElGde9++c0M45XYiZUTfbM9CZrJjskngHTcZzcUGyjC?=
 =?us-ascii?Q?MMEVFU7zqvohSWoz8Zuxv5YIm3fzaOqySSniSYXsFDTt2VNf6y/Cz167JOjd?=
 =?us-ascii?Q?tPQwyT/t6+151SNTW/f7Ffr2aL7COUA2NqOIVB9nffDM172x1Nw+0svTXI94?=
 =?us-ascii?Q?MAlHWDu3vxCAXC2WKI3FFvUFbN5bb77m8eB6TzVzy07oD/UowAossQmpXbvP?=
 =?us-ascii?Q?6it1n5UbeEsN4I+TTsslgeb6AxcLySg38VrQlr0kcCdMS2DIhmlcazZKqo0F?=
 =?us-ascii?Q?yKdnBThhbZvJTudjxiW6JNgG2+YTmr1IdAgNNObn3aZ2dbMDLxjU1BI3oVvb?=
 =?us-ascii?Q?1nAvwET7rq8FZ5VkAREV4JRG2cQtvzcVBFxE0zD39SRWO6qnrCIBYz5G26xm?=
 =?us-ascii?Q?Sm6jdZDu1LpF3W7jOfI3O36e9mN6l1ViWDzYIg1wnYdLBCt4kp8xVV2cJKr3?=
 =?us-ascii?Q?kVHqUpbSUtXqqN4/euQFq+ashKABsQKfQTbZZGrt9EzrQPaTyJbIg3/kNU5r?=
 =?us-ascii?Q?ZgRLpDYBDIy9hgIDWm3GeRF5bKqUPqcBqWeugfMPigW3NFtUuQ913pTvaO6k?=
 =?us-ascii?Q?agT0QEXoPNTquw/j2DlcBaGddHjMoFBYokUC773aJ/KmToC9LR9DC8ZWViS0?=
 =?us-ascii?Q?xlArWavqHXvnWc+hudjaztwbdf89rbLWR0zD/3oT?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de87c79-67f3-43ac-5d2c-08dbde9232b9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:32:50.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jO4SHBP1Ro1Uw6FrM89Db+zt4GFM0iXgMAw7+HwWMxsAwZq+ZnWGmNyS9Gkh30LGi3Wktlkv4N54vH1b960mng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9359
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fix is to avoid updating the variable after it has been initialised during booting.

Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is active")
Signed-off-by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Co-developed-by: Bo Gan <ganb@vmware.com>
---
 arch/x86/kernel/sev-shared.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..a447908f2b4d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -144,6 +144,9 @@ static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
 
+	if (ghcb_version)
+		return true;
+
 	/* Do the GHCB protocol version negotiation */
 	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
 	VMGEXIT();
-- 
2.39.0

