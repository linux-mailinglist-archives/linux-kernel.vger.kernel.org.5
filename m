Return-Path: <linux-kernel+bounces-95847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBC8753F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDE4285B55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFF12F5AD;
	Thu,  7 Mar 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="KBmnAZoZ"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3312F398;
	Thu,  7 Mar 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827843; cv=fail; b=QUkDYwwOhzEfAuNxYcNvxus+1plOmrZQT/w8i7zwxFBdnd3RbjWbCflCx4mpNk2gwozqy9uc1WKSnzSarqMIoMyLOE+0EloEfC8pSjT7M8aD1GL33y+hKsntDv7YlTquuWvUTnHtgtGlb5J1IF+5k5Kr9hZdBiBCiHmXFgTvL00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827843; c=relaxed/simple;
	bh=FyL1TIdRw7pA0INNS3qF+bUPVTarkVqNyQc1P0KbsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GHAVBFFc4M6xeP27zLZTsIyruz2ROKSQHcrM5ljNqApQG7O26CqXa40nyMk/RNJ1V0r+UmaLuuy9w7XJjbas/B8vwYB5S89jMemLZNn1dXZXwf59Ml/f+7lvenSVBmQRbbH5RKIHe+VlDzn1PXTRAqk5a5uLEoUYUlA0PQPPQvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=KBmnAZoZ; arc=fail smtp.client-ip=40.107.15.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tky4If3BSSPBfaNvc00MQjSqPVH2txA5xd4Log1GXwuNOcndYK78uF0q9j4Dj0UHc82ECS1WurtwyLgCnePehyQWJ1QvTiHeba7qtjqRYTE3rCLTH8HS5wsE6g36PVcwwbJyj9SEDvJ0TRCi3aRsUPMXzTKYuXWLGyzl2d6wcmnhSAyENHVCWUKo7lOUYW2K/RZ6yTdt2xKT54Of4ES3LYAiqLz5UGvXvGimN0e2yK41widEtfrFLNNhnA0ZGONWR77RUHwrrp6kGFGZvL+YUHLA8fOPHYYZReFWmj42X40Ll+TgR/x/sYqfKqJzo1gpULM+Y/vvjSasT4oNz964LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEEZzLRjMEJZen1ABnA6SH9kn2DAWfdI95+xWbjCWVQ=;
 b=aRevz8xvXXZGWy28zWm3S5uJ9czxb/hnYZQG3nXKGjewDJYKaOGnPUufrBQqdrOuR/J7Tu+mhfIx/zhUh6VjZcDz/MHwIFN7vbfMViDMFKaheTux+XAlNnTAUd/DHX/zJJS9o9Z0LuVBvdM5gGAgxx/g6Qhq4GURd9sK1qvPCgVZ1HYUsDv7LfZgWVRI7GrAXUes2jaDeAllCW0m0eR6d3jwjSFtmujqcE1/LrF92NI/f8N/QV3aX/b9Q47Q+eKYB2xWgO3/PbI2WhScutSuooI7R6LdzxyeHzM/3AhoaK1emDAE7bpKhp8xPgvAh6LqCn8cYuYAFh82azmoRcvgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEEZzLRjMEJZen1ABnA6SH9kn2DAWfdI95+xWbjCWVQ=;
 b=KBmnAZoZ1ZeIdctYGHSnomy3sA/YktrGqWrlZsEgLvb9miOy1RgAFm75RPQulK2Yak4TsDgP/Kv/Q+kzVBt36MEWaQSwiVEbN6hxkrPI2GJCO7dIM2oP9k8a84ZSIyGdOe6fpBrpoeNyJm9hy27kb977BlpUCAQs+HOJDgTZDwh+PxoxZqW6sZo8jGvGWPyLJ/dnVL/fvXx2aLQ0FZRc76x0G3HaI6dzd/ZKu0yOQ6GuSMsh8PIDbz4vBvLoK9bjP6aXOcazERZc4G2xoT1Asqdj307iDHefBywUZ/ZLEKOPSX3MAl5ahu47zxIIUM3zi1Ab9wsVk1nq2RTH6Cprcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PAXPR07MB8723.eurprd07.prod.outlook.com (2603:10a6:102:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 16:10:37 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 16:10:36 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Russell King <linux@armlinux.org.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU splat
Date: Thu,  7 Mar 2024 17:09:51 +0100
Message-ID: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PAXPR07MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdf6f0d-e30c-4ed5-2c3d-08dc3ec12017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gG1garISxyrd+MJmcPm0zLk/CmEY0xyBIIjf3+WJ40kkyJ0AVdrptjYpyEDVc/j1hm0XxbxmhcwmHBZAgr/Y4b9M7cZ7WZjeyxtYkYPEL5IksOD5JHmlGpgZ1reofC1VnXbXsWpcJw4GAasD20bX1ivincElvYjhSTu2ex9QYrY/opcn8dax3wau+P0l6vlP0nuAJJKTWQeC7C2HhxD93KNF1Q9wISy3hflk4Vle/eVFE9afmzpTNjYw1HUglJxzJ3KbVQs0f6BtioJ/sDiar6yvG2TqIZAbZ2etkU4vAvjUAqVn2CQlOxTo4vugTOQywHcOXSqnEgUuTp20pK/ccc5HDYwJ+EQh4sMQaKIMoLBIxvkh8uVeuAfJhUVi9Hg6YEUliPGBWQrnM7X1zXAFkHJ1xGC65FSCnQoTh7T1aoktTMYsxj+9T+Kj5SFQhe3FpG8lMUOw5kxn1D+NDn4lWYTCJJ4+R1t4Cp4MHHUSPjQ3q6Q+1A/O53+WMz32zXGtEXicc2l3ZZ29KomxePlGeUNPT9VRpCRd9WtfVRfLLHuNQQtgG3dNUZ9pxb19RSu8gTwryfTLJKZDW3w6zHAnPWEDvGEV2wmQnsVNLEx25JICpBQ+/ial5cTNOWxl4b8Dx8xEfF1kkPZLjzS47hUtQkmjFHcIo3I7Sac66WHky36P4IIeJHsRtZ4BpLdj8uOMGpWFQGzWsKb28GFwR2H2JNp3/oJDoUjJp5J+DD88VJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5fFDlDO+x7TihxCiDDDhoY5zNSaeij+cFi2SfFJMZ75NSLrbuRS+tpX+2FtB?=
 =?us-ascii?Q?3naKf0weP5VX7s5XGcUKBAaLUJrXjEMTWdkXKyW+TpEPUvXMRfzZNisEEMdQ?=
 =?us-ascii?Q?C1x99iPDWL0N4Z9IZ6VDXJdiJ/OlXyv2LdHjyQ0X5SnrEaAS9AO4ggatXmc2?=
 =?us-ascii?Q?8idK21wVbQK4GqCac6g1CNU52PWerILV8N0j4x1Z3aQzFbFh9bE642FN4JXH?=
 =?us-ascii?Q?JXdyx0DYA+sm6XzgxQbsEoRzvChRWSpHudUcW9loxXDRvLYazKcuV5nYLlDt?=
 =?us-ascii?Q?H1PEE0uzfD3Ao0M0EOa3sJDzJYTp22G8eNvQfqGTn3pQo9/9iqKQNfVa+zaj?=
 =?us-ascii?Q?yNEywxkacy9ey7BgGxRc6b3Wn2BpPQQDgFoa+jXuRGr9sTE+7weKowLttWDk?=
 =?us-ascii?Q?rE0D/p9/1xVDw6ikN8Bw7i+T9LsW7hp3Z8JU4lPirMFAn5fhhOTK5c0if9Yz?=
 =?us-ascii?Q?2ghI0EDfymvtEnnP+J8vLT/oQX+QsKPRITbzJdXcItSgUTuljBGIRGTLjHCu?=
 =?us-ascii?Q?sYpctjPZyPS8Ddo+9WbFc2ZAs0kG8mW3VkZi6UVIfmU3Twt0PtX+2Y2WGUui?=
 =?us-ascii?Q?7ha2bMooaDJKkU3ouSjv6vKIfoi4N+RHU4E3ineRRaktlqKu0zb36Exqwf1i?=
 =?us-ascii?Q?+wHExUoBqLlujl1jMu9emr2YrSdx186zLaDXhI96g1MNoWNInL71b9GYLuvC?=
 =?us-ascii?Q?ESkF4JyvfcJsGiuhO6mz5x8BBT50FR2FPigPngdez0l2HJZTYzMwblNb38hr?=
 =?us-ascii?Q?5V+MSLnebE8SGpQxcDVf3N8DhgOWefNNbnpaG3QlqdMpl5tFj1/99ppjCpFy?=
 =?us-ascii?Q?poJSq9Lq6J8utj1kYxbZB1DSYsCYNp/GgipPCfyJxsAf/xRLCK3rssATYmiw?=
 =?us-ascii?Q?25SU1R5bk1UHBPExfLU/xmWsGfXYCQLUC3D7N3gmOTRMONzxCtILkHMaiJZ5?=
 =?us-ascii?Q?HPbo+rwwlnOJkYcnwv1VjLZWHPBa77vWZqfzyvGz5F41nKHXD96Vc1spRmEF?=
 =?us-ascii?Q?Q+1k3NV7tvK5w5ArbJ0bWCDn0qtGYynpt3kQwxDq/dKfV97mj2fgZ3IUq2w/?=
 =?us-ascii?Q?NKdUx8qBso0cKPoCtxOmz1lnCHpHWfaUhYOPKjKuv3UgdBQhYBsnaW2CG/1T?=
 =?us-ascii?Q?VUjmrs2ttO5PpQ3YDC02lDfT9bBvmXPfFo21fwosm0JxchzzxWqW5asof2C3?=
 =?us-ascii?Q?iW5azVgsxoTfxFeFaVMSZEKPSHVyDDwjWRKGw8EGgElgAW9Atms+1AH4DQYa?=
 =?us-ascii?Q?vYupMldXCU9/aon8Q7azhvzP+mWs44IhoChA3ldKTT1sMTlGzJzlwQE7v/0n?=
 =?us-ascii?Q?x3L35Lizm4qzTn2a7X5UdWEeykFda4KfgospKh13aMuA4ai8AcZhF7n+8mGA?=
 =?us-ascii?Q?i+2++W8JghupU+bXoOzJrlYjR3z+FuBH6tpBFAUXHAcv+EatgwI1SCUqZ1vo?=
 =?us-ascii?Q?QoUM6vWE5faOQAE51PMbP/L5gwKg+XeUsbW+V/IaMon1XGMdSZnnuXACGFSR?=
 =?us-ascii?Q?kUWqXdXETxtp/VK3kRDj6udNV9sOlyqnP2u7idjoEYHOAuPXAkRReYW1/bT9?=
 =?us-ascii?Q?+WboRfyTId3TCkGmfSsrCQxRVfiqsUg6t5DLGi0T3kjmXesosFtWq9iN6aYs?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdf6f0d-e30c-4ed5-2c3d-08dc3ec12017
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 16:10:36.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VgSLwm8oHtCNKSrEck7Vr1ikBN/RZA2G0t8WRH6u9LlL7PadTI1mUtX6xnAzXwLyVJgRtOhX9kwVf5egrEQUKeOLLok74Efsl5llcRdAx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8723

With CONFIG_PROVE_RCU_LIST=y and by executing

  $ echo 0 > /sys/devices/system/cpu/cpu1/online

one can trigger the following Lockdep-RCU splat on ARM:

  =============================
  WARNING: suspicious RCU usage
  6.8.0-rc7-00001-g0db1d0ed8958 #10 Not tainted
  -----------------------------
  kernel/locking/lockdep.c:3762 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  RCU used illegally from offline CPU!
  rcu_scheduler_active = 2, debug_locks = 1
  no locks held by swapper/1/0.

  stack backtrace:
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-00001-g0db1d0ed8958 #10
  Hardware name: Allwinner sun8i Family
   unwind_backtrace from show_stack+0x10/0x14
   show_stack from dump_stack_lvl+0x60/0x90
   dump_stack_lvl from lockdep_rcu_suspicious+0x150/0x1a0
   lockdep_rcu_suspicious from __lock_acquire+0x11fc/0x29f8
   __lock_acquire from lock_acquire+0x10c/0x348
   lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
   _raw_spin_lock_irqsave from check_and_switch_context+0x7c/0x4a8
   check_and_switch_context from arch_cpu_idle_dead+0x10/0x7c
   arch_cpu_idle_dead from do_idle+0xbc/0x138
   do_idle from cpu_startup_entry+0x28/0x2c
   cpu_startup_entry from secondary_start_kernel+0x11c/0x124
   secondary_start_kernel from 0x401018a0

The CPU is already reported as offline from RCU perspective in
cpuhp_report_idle_dead() before arch_cpu_idle_dead() is invoked. Above
RCU-Lockdep splat is then triggered by check_and_switch_context() acquiring the
ASID spinlock.

Avoid the false-positive Lockdep-RCU splat by briefly reporting the CPU as
online again while the spinlock is held.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/arm/kernel/smp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3431c0553f45..6875e2c5dd50 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -319,7 +319,14 @@ void __noreturn arch_cpu_idle_dead(void)
 {
 	unsigned int cpu = smp_processor_id();
 
+	/*
+	 * Briefly report CPU as online again to avoid false positive
+	 * Lockdep-RCU splat when check_and_switch_context() acquires ASID
+	 * spinlock.
+	 */
+	rcutree_report_cpu_starting(cpu);
 	idle_task_exit();
+	rcutree_report_cpu_dead();
 
 	local_irq_disable();
 
-- 
2.42.0


