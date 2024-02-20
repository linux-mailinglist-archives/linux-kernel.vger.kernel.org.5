Return-Path: <linux-kernel+bounces-73415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7585C242
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069591C21EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EA76C76;
	Tue, 20 Feb 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R4B8JA2I"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1784626C6;
	Tue, 20 Feb 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449419; cv=fail; b=HDFEG/ouS1psBd5FsumM7U4EglthtgutQa3+DCCct/KLyT2e71KxvSgpbe6vPb7LjQtuOtslP1Cp4Zb1J/fazRAzCPUnSIuJw8HFZiyWHF+tWLtkzy4ZbbIvSApBh1tyC38o60WSroza7vbrDqggWnCYbQt0vxxHC8vCm/Lotpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449419; c=relaxed/simple;
	bh=nTX0Yqbs+ChiTX9rrkVuJ/FiD1fwWJ2d1FI7naJp33w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBr7ikyC8Q19TlTrw7gW7ey3QQITt/fB5H17Q1NiVBn3b+l5tl2XVfJFvpcOMoqk/JjcBrmRSFDOooevBJxH6/0IurY5XzWUdTknhXuL3q8ShDtg1pdG8uR22KQV+eAROftI0OS9wBm2YIE3LrU4+0qsVQ3irQRePIvyRhZRBcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R4B8JA2I; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGkWBz2TPnDVod1/AewZap0NV7EfFsj7N1ZIRbBQMupcwSWZyQY7DCSP2nDtpK2FjxQ2gk3AW68tsTB5gxao+3Hz44Zm7KPZjLVP4di0DxkDwu56Q1xCIff22pGHolXIm2g4yjLy/BZ29fx/DSb/cmjdQ33mW5EpL9BrWhY4TQwozZUtab4kYXHL6T0heiCV25PdT2F/QzUhNRaJJDHsiK51lVGPH9s/PM48/zoh7x9A3fnHiuKM43NWjMeUQ39KJmDT4u26RyGVDXCJF4HyCts10skuMag5rqM63COt+y7z/cQEF8UOpAMcYX/iKXO5fpPUp5GuomYPii0ixGGFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ5Bg8ms8TlJV83NKqR3M1spyrSm2VyPoRqbg+vdDVY=;
 b=GWA85CBg4a47oZAYm1aACfr+K8T8GG3esui1scEJNak5FeUVCSOp2zIO0Gg9Sp4cZ5xaoGTgFDF36dt7sfgdt43R/ypRKHPSIA5BjbzzmY1BYP7abU4Ejco5H2vIZ337VEORC2uijPfoYHjGazkXZ++lAffByDt8pZ/4MgmfFsuyIxxXIvZ8F7T36VmKw47bZegrXhPwkXLrvS0eUbSWTllwunrO0WqUUV7Q84Fr67Qfdr7mTsKataBnF+3Mq6mgnX2eOG/+Gz4XMtJe+WTm3DVeYvcIBbJzqx0L+k4mv5Tcl4QKHiWZ6s7oUXsKCjnfEdYcYgvbMnMq71lf0QqiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ5Bg8ms8TlJV83NKqR3M1spyrSm2VyPoRqbg+vdDVY=;
 b=R4B8JA2IbzadnZHtnXAd6+wqwGR6xeo/wqY7So7qk+0A8FAGJbw0V2T7/TaKSJVDTCvV3AoVl6LQWiJdYE/VGmdRtZrBQS6xTKn8GOG8pF3MpdgPGm+p9c/MvtWAihm5AKqYncuS3g2dcfbqAM2ySd7x/DR4j115en5y4I9CYKo=
Received: from DM6PR07CA0057.namprd07.prod.outlook.com (2603:10b6:5:74::34) by
 IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 17:16:53 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::d) by DM6PR07CA0057.outlook.office365.com
 (2603:10b6:5:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:16:53 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:16:32 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Richard Henderson
	<richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, "Guo
 Ren" <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen
	<dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
	<stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
	<deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
	Andrew Donnellan <ajd@linux.ibm.com>, Nicholas Miehlbradt
	<nicholas@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Tony Battersby <tonyb@cybernetics.com>, "Brian
 Gerst" <brgerst@gmail.com>, Tim Chen <tim.c.chen@linux.intel.com>, "David
 Vernet" <void@manifault.com>, <x86@kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-csky@vger.kernel.org>, <linux-openrisc@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH 02/14] sched: Define a need_resched_or_ipi() helper and use it treewide
Date: Tue, 20 Feb 2024 22:44:45 +0530
Message-ID: <20240220171457.703-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220171457.703-1-kprateek.nayak@amd.com>
References: <20240220171457.703-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4538b806-c25a-4501-e9cd-08dc3237bba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gb3AWsI9V6f7lyIRtbyfoEfeN8iiv3gh+6Rll8d3JYM2FzPIuZpBaUItICl59D5B4OKr824hL7zcbvB5ZGm50UhhsD/Ihhl9eRrP8zPzbhYYV0eQ2hz3ooNM+XwXMmV87douEQtUUlZ5DpJTxR1mplG0P/eURhdzY9+6mXCF5ClNEMdsgWMuKjckxwnKb3pbaGxmOIOgYpmaPyLbqyJfW7MbJvrDqfyWY5+7drXpebbW6qx/eMi6uEs01WEXil3RAeIVNIKL+wDZb5d6+0bM+05SewSJ+Y8PCajl9GmOtVECXGljCte3j9IU2w4TIJBmr2rKlJBWMlpwOHQq7C5Fo5238bLvcsjSNSRCfzmgHcH8fNQ9Kfp0hpT3pHORb8+sUfvvKARD3L9VYH5sBBIG9E90mbOq+ZRzh77kFNmB6IF8j7PpCv9YrNp3uwfv8pk7ukRiGoG8s5ioE/NhNxx126uvmf1f2RokXKh/qeXczd7gwy/2kbiDghldUiNltwCUWJ0VXp8cGuRS/SrFcdH//f/RsDbvHc3imNHQha38CWMwF3diofli8wx4VDJaVHnXSL4SAOEqlvgfinoD2zNoDuMxs7zHl25Ckjp2JvtwLQtnJSb0bs4AzuF8Rb8U9LnvydUAiqiJjOAdDa6yVvZNAJhs1R1VAOmkF/g7aI7RoUs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:16:53.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4538b806-c25a-4501-e9cd-08dc3237bba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Currently TIF_NEED_RESCHED is being overloaded, to wakeup an idle CPU in
TIF_POLLING mode to service an IPI even if there are no new tasks being
woken up on the said CPU.

In preparation of a proper fix, introduce a new helper
"need_resched_or_ipi()" which is intended to return true if either
the TIF_NEED_RESCHED flag or if TIF_NOTIFY_IPI flag is set. Use this
helper function in place of need_resched() in idle loops where
TIF_POLLING_NRFLAG is set.

To preserve bisectibility and avoid unbreakable idle loops, all the
need_resched() checks within TIF_POLLING_NRFLAGS sections, have been
replaced tree-wide with the need_resched_or_ipi() check.

[ prateek: Replaced some of the missed out occurrences of
  need_resched() within a TIF_POLLING sections with
  need_resched_or_ipi() ]

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Guo Ren <guoren@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Tony Battersby <tonyb@cybernetics.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: David Vernet <void@manifault.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/include/asm/mwait.h      | 2 +-
 arch/x86/kernel/process.c         | 2 +-
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 drivers/cpuidle/cpuidle-pseries.c | 2 +-
 drivers/cpuidle/poll_state.c      | 2 +-
 include/linux/sched.h             | 5 +++++
 include/linux/sched/idle.h        | 4 ++--
 kernel/sched/idle.c               | 7 ++++---
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..ac1370143407 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -115,7 +115,7 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched())
+		if (!need_resched_or_ipi())
 			__mwait(eax, ecx);
 	}
 	current_clr_polling();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..ca6cb7e28cba 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -925,7 +925,7 @@ static __cpuidle void mwait_idle(void)
 		}
 
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		if (!need_resched()) {
+		if (!need_resched_or_ipi()) {
 			__sti_mwait(0, 0);
 			raw_local_irq_disable();
 		}
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..77c3bb371f56 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -79,7 +79,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	dev->poll_time_limit = false;
 	ppc64_runlatch_off();
 	HMT_very_low();
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
 			/*
 			 * Task has not woken up but we are exiting the polling
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 14db9b7d985d..4f2b490f8b73 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -46,7 +46,7 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	snooze_exit_time = get_tb() + snooze_timeout;
 	dev->poll_time_limit = false;
 
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		HMT_low();
 		HMT_very_low();
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..225f37897e45 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -26,7 +26,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 
 		limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
+		while (!need_resched_or_ipi()) {
 			cpu_relax();
 			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
 				continue;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03bfe9ab2951..63451f6f25b9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2258,6 +2258,11 @@ static __always_inline bool need_resched(void)
 	return unlikely(tif_need_resched());
 }
 
+static __always_inline bool need_resched_or_ipi(void)
+{
+	return unlikely(tif_need_resched() || tif_notify_ipi());
+}
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..d739ab810e00 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched_or_ipi());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched_or_ipi());
 }
 
 #else
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 31231925f1ec..fcc734f45a2a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,7 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
+	while (!need_resched_or_ipi() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
@@ -153,7 +153,7 @@ static void cpuidle_idle_call(void)
 	 * Check if the idle task must be rescheduled. If it is the
 	 * case, exit the function after re-enabling the local irq.
 	 */
-	if (need_resched()) {
+	if (need_resched_or_ipi()) {
 		local_irq_enable();
 		return;
 	}
@@ -255,7 +255,7 @@ static void do_idle(void)
 	__current_set_polling();
 	tick_nohz_idle_enter();
 
-	while (!need_resched()) {
+	while (!need_resched_or_ipi()) {
 		rmb();
 
 		/*
@@ -336,6 +336,7 @@ static void do_idle(void)
 	 * RCU relies on this call to be done outside of an RCU read-side
 	 * critical section.
 	 */
+	current_clr_notify_ipi();
 	flush_smp_call_function_queue();
 	schedule_idle();
 
-- 
2.34.1


