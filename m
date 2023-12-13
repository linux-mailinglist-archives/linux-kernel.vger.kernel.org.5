Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF4981079A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378142AbjLMBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378241AbjLMBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:21:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2115.outbound.protection.outlook.com [40.107.95.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C311B1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKG+yeJ9817yOCGI85oEGKaUc9NvBdfrp2g8jsF+1Z+Vd5q/wnjmZHUD7fYN8ZEEWVro/tTo7sPDsIqFUMankB1YD8ghFfBx1Vj7mAKrivjYT02UaWC6PrTgYJn0dppmpxhOgLmZdzDmQ4ODwnRFeWkNUjHSiR2bkdlO9SwA5poRPmDPc5rct4nVZpopNeNLUn/aV8YSHp73yDSemSFysqJqNApBX3EpKBwJT6u4u/uTl9RAVBWREHv2XJarNBkqp3qJsND7gxV3u/qA98NGcSIVBLMnV7VgfEK+pzMHC0c+PIIJSNbBJ8Si4Jzg302HijUXRc7c6/vuEp6MZx6JPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOKijS4U0NzKl1abCkWnmh83fhEoa5LWGcwHbkgMCEM=;
 b=jxWIEblsM52H0VdFgI3euoggPp8oy5Bws014dbxIaR5NPuu30DCAF/zbnViPIIo33EpoapEC0lbjAzL7KMvhEm5O7+z6NfDO/91Sm/yL3vKAyN8EP3wO5wy3paIY0mB2XaQcKRq0y7CwccSg1775CmqTT9dvEQdgvM4Y4JVVaygACBQKzzNfe5WqA8e1rs1yScu3tt7tAoJADfDtgxzvhS+Wmr9xEzBMkDcPcd/3wcWcWtE3DFRb2yGtsARgymTXuRmG2OwN/jtSblCEm+RmwQxW8HpFD7v9RZAEDHi/tQzCIXEvVqvt0gyYo4Vcc8IaUwkCJOlR1goH7vmh2cCsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOKijS4U0NzKl1abCkWnmh83fhEoa5LWGcwHbkgMCEM=;
 b=pdwNcQhOwSaC9LyCti+bYmEXpxyMyp1Pe7vhMTwdhbbDC00GUD+VlERZtpQRM6UCGtkE9M1dOe7jUxumQ3QLnDEEbRNjwlRlG2p16emsHee5jhFrdnQy+72OGyACc/kZ0RiyeBXOx5XOsT17Xw5DuSjpZ3uIT4Vu8hvhE7VXk0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 PH7PR01MB7845.prod.exchangelabs.com (2603:10b6:510:1d9::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Wed, 13 Dec 2023 01:21:10 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7068.027; Wed, 13 Dec 2023
 01:21:09 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     patches@amperecomputing.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: irq: set the correct node for shadow call stack
Date:   Wed, 13 Dec 2023 09:20:46 +0800
Message-Id: <20231213012046.12014-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::23) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|PH7PR01MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac29b40-6ae0-4b45-09c3-08dbfb79c959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PeqgoVqklGX2sePeJn6wxFIcw9G98D1ARq4BHXGVy4wxJ9mrHRlRSO0syNcSpFV3lMleOl062/ch8JccvWQTztkdXIAWkzcl1bah7mlt6dIC6zcOol8XSQEkqUH9ZZRQhzU+vvGnKO1J2SlTGas/WBZYwn4pUM4vjBBkAmsLn8vTXQw76Zg8Og/WbMTLv5oP3nsdOrpjUUGHuPAGblSte3gkL6HOtMk9zgF89tYt6didbm7jDFT/yKjIb9+fr/AaeRLRPXNS5mEgQaH7vmvv/2EMg6aQs3cfqR3u5xZT3Tjim4HqvVQxDn3lL/bgUZkybx9pkbfVDdHx8cpJqPUVoZ1RJbXE3NMOY4oc13zWl9Vyj21kY1sBpMX4R/I+H6RuLprWJt2Pr7LNJyiCe6vjHu1Tb34GhoYesjIVLEsoo7VL7dl9TMri22a26uBRM7iMh+8JbT7lQfAG7CcXiJxm2GXaNH9g4MTWjsG3QrqzneEXDPP8UyreRgdn+FhxH0JVuL/tio6PiM/LcoHptaoSJFNf/6zQGl+uuL896C4SVjRMHeoyO895tI5M5dk/QU0GGU7BOk1sOf/t5W26Icq8USZ3r9D3xSpGIK8Lbvrutk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(4744005)(5660300002)(38350700005)(2906002)(6486002)(6512007)(6506007)(1076003)(2616005)(107886003)(6666004)(478600001)(52116002)(966005)(38100700002)(83380400001)(26005)(86362001)(8936002)(4326008)(66556008)(316002)(6916009)(8676002)(66946007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Itwmr7NtVEt/WVUcd5ZnHEyM3wjqeBdnaigPgzBG/Wl5/ULmhHDm9ZJIm21?=
 =?us-ascii?Q?VVt0urWfleMM1aS48RZfUuUNqC0TRS68Jocj0VJ9iQ4T22ax7h5iW+fdu+ix?=
 =?us-ascii?Q?gAO97N3fnkgf0L4kRtHOBzlZfCpMPUSp9sxEMdmP5R4Qteg0RGjj2w9pDQMo?=
 =?us-ascii?Q?f24svPFNr1+CiZmg1tBQoPbmic6I1RumHsXEqpt4UnXcN1lPaaiqkeB1jcW1?=
 =?us-ascii?Q?FptcSNjws6/+Poq6fxiUX446GVRwSwmCopGo0RVcRGpBIVx9ko2dgcWrrgEp?=
 =?us-ascii?Q?H6JXpGBpWYW49QYZp/3+UZ6P2FfPQIhzWt4NHUa+buWABYFObsu/vn5gMSk6?=
 =?us-ascii?Q?u0V2jshYMO6EsFBn80ekb6oC9Pxp4xlnFf/fVzNd9T32Kf1hgJcwko8hVZD2?=
 =?us-ascii?Q?PcMH2G9w0YtcO68n3y36uFO+o0EsSK/5RvKo7Fu49jQfd5C8G8HqZv+IbFGJ?=
 =?us-ascii?Q?lsy+L7anwYtmK+IFOaFK/sJ5TpHFKmGjWcHppgjNf45yXsDR273qSjAYY4Vp?=
 =?us-ascii?Q?6pD+GNkCimv6zLhE2J866CrorzVgpD7PrElkPXk6vMfoSK0EwDyFk0Pa96Ub?=
 =?us-ascii?Q?djmNQOMJDTxpupzq7QBQM398GyfexV/ZR7hQM3KQ7oyqfbYbvVGph1XrWWdl?=
 =?us-ascii?Q?y7AaDjypDZqaFj4DHuNm5AoV+GC4mRrR/DTu6pbVuJcrCQPtOLVSTPBdzj8e?=
 =?us-ascii?Q?Wn5fAO33b+kk8p1h1D88c1rEEAEzaPY5VuBo3IOP+Ev5VHoPQ8fxLMurFJyw?=
 =?us-ascii?Q?b7Oi46Q+BECH5AlnA3xOlep1cdvwn6CtHEDMrcKhMDl1DWJnrvb1IzZCxTQa?=
 =?us-ascii?Q?YjtCxzMdra5l6/MgG7EcOG4FiZDQXcQXKzP82iiOtVYOo7E556GT+kzFZzm6?=
 =?us-ascii?Q?ttkQA408VSYRjBJOJYVourEAkH0Rfa5rBpIEEycLGppGxUJ6G+TcgaVVctC1?=
 =?us-ascii?Q?HidsSbZELyBbTcBwnj1fqzjOYyEqzMaNTjt/JYNjiluG5KqxS79XNvqCMjrK?=
 =?us-ascii?Q?R+Q66d7aYbDGXSSqZmOgeWd44NW6xDwl7LscCAC/0W/anZdUK5cV2tPi102n?=
 =?us-ascii?Q?kN35GfgG7YwT31Eh/03a0JSXyDlgiP9jrvyfUVSTC3GqUjhz4oNatOP3LsWI?=
 =?us-ascii?Q?hJAFKMC2LXhNDzWbuppuiJQ5wttQ65DpBXMPBkLEG0/vgsjsYZodClQ6ibCz?=
 =?us-ascii?Q?TdD/FJ4WyCa7IGp6uq1TTEcBYyxz+E20ENFz4z9bSBDCeFJ94wGuFoLJtjqj?=
 =?us-ascii?Q?O0tFgwA1u4qZ6aDnFLz69ukyaRliEr6Gw+8EP/4/o6o6eLq5jFW9d5mNwXGR?=
 =?us-ascii?Q?dAw/eanE+80YParhoTTV3CLgw9zU1T27iVye8X4aVg7NwUgAlD3YprQ8TA23?=
 =?us-ascii?Q?ktQ7hOBtUV8mTl1iDCWmie34pzgStEWrwfTk6Ww/XiLroPiPlYkcmtjVns1b?=
 =?us-ascii?Q?RPsk8tyca0mGeSJPX9gP9HLonWpCv/KjVMgJ2iMvjbX4wiM+F70b4ly5kV/U?=
 =?us-ascii?Q?bdhqHKYf28ET6TE9LEgFBWLTBvMSFcp80y0pEJBfhxwblbkNit39KFNS2QFB?=
 =?us-ascii?Q?u8BloR+mxEEezMjy6TCf7Vj6pWjrkxcTO1LApuzG1leMz9pQmdR0NT9WZygh?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac29b40-6ae0-4b45-09c3-08dbfb79c959
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 01:21:09.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAhx7+oTEf/Mu3ySO1IDY5k4gj9VYyAlnHd45d5u5qh1bad4dKBktp3I3laKyVpBVG7IN95ns7cfhOTZLozQUWzT8os25T2vcplp5X+RX1yweM/kXRm/wUpqcvusYZKy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7845
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_irq_stacks() has been changed to use the correct node:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=75b5e0bf90bf

The init_irq_scs() has the same issue with init_irq_stacks():
	cpu_to_node() is not initialized yet, it does not work.

This patch uses early_cpu_to_node() to set the init_irq_scs()
with the correct node.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 9f253d8efe90..85087e2df564 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -48,7 +48,7 @@ static void init_irq_scs(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(irq_shadow_call_stack_ptr, cpu) =
-			scs_alloc(cpu_to_node(cpu));
+			scs_alloc(early_cpu_to_node(cpu));
 }
 
 #ifdef CONFIG_VMAP_STACK
-- 
2.40.1

