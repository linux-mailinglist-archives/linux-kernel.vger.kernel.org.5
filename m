Return-Path: <linux-kernel+bounces-31373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE785832D62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32051C21C76
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16655C15;
	Fri, 19 Jan 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="fbq89MTI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696754FB7;
	Fri, 19 Jan 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682505; cv=fail; b=u2WNxRa+Bcj3N9JK07u1OAaT7gzZK9dMRZ19wqV4a1v1a6VpvrfHfnBMWu+cLnF/BbV90KRrpAQFztlbTjxJ5ns/n14Poq7SW8SYR/LNYp0J5xBDHcRhutOyFSM9FOPVRjP5wEsihXMWz2s2SSR9jByVh5ot6kLf2KyzOCho3e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682505; c=relaxed/simple;
	bh=lKJgzMMvFItMwVXFDHHiMR1aJ0EAGPsUdAMO2223m6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4Xk3ECLzlG4dKccLu5U52+TwtPxBvQFU8GgrGQv7M5HudIDHl+0torLdW6qOpU7SsDhngNREk6xBiFXEgWueJVxtXoklaqqSnTYce+k+lM79E3dpcSoQOFTGAnMVYo+2ajcQ4uZzS7wAso9eZCOqIFClFBpEFDEI6i97hXxpwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=fbq89MTI; arc=fail smtp.client-ip=40.107.20.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdN1uBY6f+yG4ZT1SACKBSQV4bGjVQULMMCg7/RoVy2FCCiykX1qZWgAqgAgLrb7+DyZFPyZyQefRp5PkSrekWduIoEqylUdZ5AT+OIqnGpDQB3JkRrzbYT934K57U0G0bHpZZm76wAq3yrNeczpYqvmf5cmR41nVEop0lJePDz59gbm8aLHhNGJUULZEMG+UU7GiJuvqZIqsi4APcRAARjc+3OIpXW5Cp0KSE6WEFvztGA1SU3RT/DEksRePA2w5+lXY15nbTuaFjDQDliTdld5yVM/BGaMXqe/9i0VvOnJr/I6Cpt45DeszZaPy4rbijPSUD7fVgim6kkhMo6YxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f14UZfOrkAdXRLvTYGXOPyXgQuCznLk+W3L3h5c/ZwQ=;
 b=btQBm5kg+KIZB0xSZifopbSQAAIlcDrmfieqJLSvdL+Yc9SyRSwgcbpeMIj/SNVCdrhYtjHOfzwWN1qj/bGKK2ia+oqmZvC9dBw+U0wpVXmT+SOr/PCQZBu8B9EzyeHQ6zm8R0yLMKxmCM4/JfT+hvKH6L5pmOY8CXKHdGMWuLrShE3PB3zKSSaG8JcURDYCU8M8+u/ZCsLd2dudnMCiOK7ysA1JoChxVNsMfo+zOluPRnk0SUssmQyPRcm0voj/X8Z1bMuHSv6MrJB38RKhsw0ZjIL/0ImOqSs2GlnA+LmLGwJQbAiJhxYiSs2VoselSnMTrNoIBDCOspfT57NOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f14UZfOrkAdXRLvTYGXOPyXgQuCznLk+W3L3h5c/ZwQ=;
 b=fbq89MTIFhFF3Ym9sQzdYdUGRciQw4irq3TZRW8tgTdMFk8I1gQp7Dtkk4x+w0kFHBVudRjL7GgeUi4craYu5yvuS5LJY5MhhMbMoOeHMY/13HsFnbssYSpJADuFjBU+eN63DKiZ4ZyLVz/ZmATejnx2PqhXCeXlolz1aRYVUMYVFjmtD3/Mv4BA6uOXWvgY3Qkhg6r53Z82h+QPFZmizYOUqXppCj0iUteqbRM/2R/6lYh5EeC36zKEFb2+qrl0ixPeN4haL5ERuSvEScBjEZMmDSvgWxqKJzm+gFdgUU1mXlqUNKoccEIfqFE1z6E+vXxzCphatBkAeX2AcOGvaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS8PR07MB7798.eurprd07.prod.outlook.com (2603:10a6:20b:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 16:41:37 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 16:41:37 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] mips/smp: Call rcu_cpu_starting() earlier
Date: Fri, 19 Jan 2024 17:38:11 +0100
Message-ID: <20240119163811.3884999-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2024011935-snowman-regain-b820@gregkh>
References: <2024011935-snowman-regain-b820@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS8PR07MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: cd126761-204b-4f34-d1d3-08dc190d80fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K0vK6UVIl7wB6MsgVwQd4DYoenlk/g33HLgs6YHVwcan+evNSnjR7xnZRLJZuazj2UK7XT9TYUsDbNkGTbjAn1pmIOQTTd1AC9ACrOK7nn0d3L6Pqy53dxN0I/6lYoAZ4zMY3+Ykd6PYiZm7TUa0iiKvaPjVI3gQ9QFbkKkA02xVhxFdQgWi9FfP0BkDVVkQTZitN+7xtoNiJPAy/VRTYiXuGTQywnaLEnqFhP0YjwZ0MNgu/5sn2A6hYD+9K7axntp7QafLaWulio43MYQyu+R2j8gAKW3IT1ByWGXm7PB7XeMb5cOWNMjU49TqQJ/mAtYmaZ/YOyeMZDMfCgUGOKo2Bl+IvcO8zQbzGKZ8FWqoYCWS6v6TdvgYpenstQ1YzfbNU6QG8+zOn3lHb7FOI4efNf8arURadsGyAW37o8jAAtHSNDDuV0nUqxupPoeM/zsZAZcAiDwzOrs2L7s3YS9rRNIRQN72EoTQIjihX1e8pcJWFwuNy1BQHjiQxT0okGQmXQwQvvHJzrYUFYEiP3LqZ/dSB+znBfWDTv5gBCQNjNdZMx2zh5u1a7yzfX57H2KUkcWm1uNjLEURtPm0IxX93A/noZljzYPUo0RVigo8S1noB5Y5oLfrxvah+8bPdCa/cKjD42E32KTrhVtZuwi6WBjxOiMpy5rQrkpEAC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(6512007)(83380400001)(1076003)(2616005)(6506007)(52116002)(38100700002)(2906002)(4326008)(44832011)(5660300002)(7416002)(8676002)(8936002)(6916009)(478600001)(41300700001)(6486002)(6666004)(316002)(66476007)(54906003)(66946007)(66556008)(86362001)(36756003)(82960400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h9psAW8hkgNnyNb24OjM0IfAJwuY30gEcvN2huODeHSkjo9ISD+Ful1znIti?=
 =?us-ascii?Q?yPJKnazeH7neE6gQnN9LE3QJTREh8wCaxmyXXiYxgWE/cbCs+PAw3fSxNkII?=
 =?us-ascii?Q?P8QNui33NQffTZ+zLb6c8rbptYRjutSeXfqPjuvWJpqj7c6hdH8OeHkpV7Xw?=
 =?us-ascii?Q?6BEfyqfPS5tC1a+rkN79KoyCiExxykdCpeNOl03KWPvj7Bo85dfevHYVo1hb?=
 =?us-ascii?Q?yyQqpw4Pdl/MhpGaNDr9mUoV5lw8r1LUCpK19lBw5oy5WGJ21lYQtd5oLqqE?=
 =?us-ascii?Q?gvz//bWBrZeoqSAqIks60tba+pMjH7Y/ZZptdg/w00buumQ9rH0vHxIjoam0?=
 =?us-ascii?Q?931YF0+c5XFSmPxy93JrB0gO1XN01gl0sNYManqJtDVCMQctBJIIbj+cc7g3?=
 =?us-ascii?Q?Pgap9+VkaUwh8i/17Ic7Mltf72XVsU/7JtoDRAekVfM8ZhEzK9sSHGXvBxGX?=
 =?us-ascii?Q?3anc8u70/xxwXACueUpdLBWD3cRExQSLILYPStyMfdRTUJWV4n+/j1TUXvAC?=
 =?us-ascii?Q?2mPee24YPqcXFuTy5UuUc8jvyzLQiP0NXtkdyxAM6LRjb+7a81EK4hNxgRgx?=
 =?us-ascii?Q?4PILFoAKxIT+N+VNwtNIn8WacwSa2GXpeaWzzVbq3qj9izqef1uTt1goEqP2?=
 =?us-ascii?Q?cE2imVzpekSuF1xNDtmOdpg4Omg3Dtd52/soG89X1ue0ki/1Ss0b06lt1B7+?=
 =?us-ascii?Q?uyRZ97QIubmNbJTfyU4kFTPSNsNGHNpGjkRkvZocdyFjEPKnH6sanaLCtwEH?=
 =?us-ascii?Q?h0WIVgErwom9hnQd1sV11ywWzfWhcD988lM94SqhaGsxFWApaeSXKfpCAihc?=
 =?us-ascii?Q?+RlamQXuuUvXJBtymUpg6JzxytjmTSrWFCRp0PSmTlj4nH9uBfFeBnW2QIzR?=
 =?us-ascii?Q?uRRPalyWLmM7z1NAsgoAwUOQQuhXK2nCmPozCPBSC4O0Wy9wtkCvYxgbPjIG?=
 =?us-ascii?Q?NBdneoMSUzubdXz5gH1ajqgQzczEvDO24Z7ezzNH5wcau1dwf6NZhAKIbY9/?=
 =?us-ascii?Q?gO+bCM4fhDm7njbxM+uckkESJamwBGjN8e6hFNBMq79RXL5J4tm+UvDIlVCC?=
 =?us-ascii?Q?Iq85iKxa7X5Gi/O5vqLKTT/AbO+1kmznyuoNQjk/MzcaSUght7BFsoXksKpG?=
 =?us-ascii?Q?fD1TE5BRcAP04CLkKwXpFW3P4Qq9X+0Uo7j0Z7+wtR6okDd0ub+Urkeau/qy?=
 =?us-ascii?Q?0E5Ix+wJUX4PEyh3bc0rpyUFuaN5OI88wkw4xVMwqFQH8/9AiOMht15zcbZJ?=
 =?us-ascii?Q?A2Ikzho5FNWaTvg1CAu44CpWoBpoquY+UIHMSJkxSwEBCStQ5qKD/eSuTvm0?=
 =?us-ascii?Q?YaNlD3Ht8KJ+OVfsclmF12Pkw/P15HPmImmX758rISw11ShToFkLyCGewtRd?=
 =?us-ascii?Q?kSKUyTLMXpnuIMk4TxMAKn5M/O5zKFOeL795tZb7PNz25Reiq+QxvalrjTs3?=
 =?us-ascii?Q?evvTRrG+HeYvpYxRURhIZc1D4DTTNG9p6kxHS0uYYJHmUiiAAOeBfjv4tnaR?=
 =?us-ascii?Q?v68fxj08ujImf3S71I0X8/jtA8wqZv9/YbpxsU50l/vwpU1Lq7oNY2n9/S9z?=
 =?us-ascii?Q?ygYQ72XYO2aCHAzbwRle6fdBYx6qeSZDISyirPHoPjZ8JAp0DK6OXHVL9heN?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd126761-204b-4f34-d1d3-08dc190d80fb
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 16:41:36.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjNnu5rD2a/riOTvgU/04xkyMKrXqvihZhBM6pxQlQWt7RiVTx1lsaNtCg49uKQJDCJN98VVtX/jBzRGkxdltf9hTSIDUa/7nRED59n0ubc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7798

rcu_cpu_starting() must be called before clockevents_register_device() to avoid
the following lockdep splat triggered by calling list_add() when
CONFIG_PROVE_RCU_LIST=y:

  WARNING: suspicious RCU usage
  ...
  -----------------------------
  kernel/locking/lockdep.c:3680 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  RCU used illegally from offline CPU!
  rcu_scheduler_active = 1, debug_locks = 1
  no locks held by swapper/1/0.
  ...
  Call Trace:
  [<ffffffff8012a434>] show_stack+0x64/0x158
  [<ffffffff80a93d98>] dump_stack_lvl+0x90/0xc4
  [<ffffffff801c9e9c>] __lock_acquire+0x1404/0x2940
  [<ffffffff801cbf3c>] lock_acquire+0x14c/0x448
  [<ffffffff80aa4260>] _raw_spin_lock_irqsave+0x50/0x88
  [<ffffffff8021e0c8>] clockevents_register_device+0x60/0x1e8
  [<ffffffff80130ff0>] r4k_clockevent_init+0x220/0x3a0
  [<ffffffff801339d0>] start_secondary+0x50/0x3b8

raw_smp_processor_id() is required in order to avoid calling into lockdep
before RCU has declared the CPU to be watched for readers.

See also commit 29368e093921 ("x86/smpboot:  Move rcu_cpu_starting() earlier"),
commit de5d9dae150c ("s390/smp: move rcu_cpu_starting() earlier") and commit
99f070b62322 ("powerpc/smp: Call rcu_cpu_starting() earlier").

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 8fbef537fb88..81f6c4f8fbc1 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -351,10 +351,11 @@ early_initcall(mips_smp_ipi_init);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu;
+	unsigned int cpu = raw_smp_processor_id();
 
 	cpu_probe();
 	per_cpu_trap_init(false);
+	rcu_cpu_starting(cpu);
 	mips_clockevent_init();
 	mp_ops->init_secondary();
 	cpu_report();
@@ -366,7 +367,6 @@ asmlinkage void start_secondary(void)
 	 */
 
 	calibrate_delay();
-	cpu = smp_processor_id();
 	cpu_data[cpu].udelay_val = loops_per_jiffy;
 
 	set_cpu_sibling_map(cpu);
-- 
2.42.0


