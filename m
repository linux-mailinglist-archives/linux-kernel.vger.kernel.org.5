Return-Path: <linux-kernel+bounces-73430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47585C27C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69551F2304F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710877622;
	Tue, 20 Feb 2024 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gHYDTknl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC076C70;
	Tue, 20 Feb 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449671; cv=fail; b=uRaYqrFwm/UUpceVtA3u5qQlwpzIA2UZ0kepXyNPzahzOSMBWzggTrWpQHbSepCv61CfKpvfiKUIPfUFU/nolTkb//PvT30bERIIHZlV4IXuBCtFLjGXoiuWFxh/re/FIDxRSdbCISzCsaUXcXZALVfN//HhBq/r4eTD38iiTNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449671; c=relaxed/simple;
	bh=+HQW4BasbkhQ3kYDz++H8J1f6VVSHm9uTVNMKZwT0mY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/RGwwgD98LM8Ni1D6X5MEN/70RMwc6atZ6IPX9JQN0azfX8wh1HKcKeOLaCJiDwm8IUPnkY6PYaCGI3ls9wtoYLDtpkay29BfRbSaOYThOxuP1bkR9M58xeqaLO1pW84LZEWFXudMju9ayQclg6hZ1NA2Kudz85s78HxYRQQwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gHYDTknl; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3yr8WM0MT+sQWNJ3eHo862lgrOyymF4mrZGvUFO+pwPkSjB0RSFQrB8S4U1NLx+AsLy2BZFu+ZdmQr7CTVs8MGnOGYcxpeF+OZ+rVX0Yp2FKvSEx2tfm7s/lk3+aD13lYS7TfFlDoNqAdwAIqRMK0RyBkEDgWXrauIpNJge86v6sgRp6KnLvIAaFYLViNakzp/nxswMn3+94WmIpWJli+MWEGE25rP9KPre03SCtoG55QM7QReP43Vn/9eXLgA/mNMK/z8YyC+TAD0WtWdKU6xcqtc1Jukqp9CMzf9+teUYl61a5hEhiQyRgV5UNjpancDX7qfRTUGGc4wQoAYOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXjVaes9WvcEc/hGO/IAwZ9eoMnQSc9DHuIV8eE4dtg=;
 b=Gx2Q7UEaKEFK2p5DZwnNlMcj56sLnZo8Ns1hWfQdiek22E+MPKxUDuDcTBD5I4SZsrWgM0AYEAaSc0tBkto5t7ebMcHQHrpO8+daiVCfc4G5U+0RFgpJEjV0/vOjZAnERRuMlmsRX2ANkfEZ4e6JqiOOJUm5MHxvV4qDCnutFGsrTnJoBaA2+bjpsCd+loM8XdIg2ZlIguHmr2ReRF2sawe4D4hhh2cIFv+cDEEz5Uis1hkPFME+wQjseHnQ9H0hyN1VEXTP0Guw0TzHY76mySr5+ehfV1dn0bW2Na2izBL/KXjl/BHcaHu8hUDr6Nj4D02A+OXnQ4bahFW4gv+XVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXjVaes9WvcEc/hGO/IAwZ9eoMnQSc9DHuIV8eE4dtg=;
 b=gHYDTknl3/ZTzvggHey4UNRZPbV3qwr8N8oYoLX1tBvlDvlWD0vcPULx9JxiG3sqnxF2AWVkucimcauUxRtDAHv9/lX+RZOWCMrkCk6kx/BTzgz6GU2TGJUsBtTsfFZm7ahTK9AskfRF1eHOhNV4fCPJSTg0vMLMwpveGdzsrBk=
Received: from SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 17:21:07 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::66) by SN7PR04CA0013.outlook.office365.com
 (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:21:07 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:21:02 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Dinh Nguyen <dinguyen@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
	<linux-pm@vger.kernel.org>
Subject: [RFC PATCH 13/14] nios2/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:56 +0530
Message-ID: <20240220171457.703-14-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: d47161ff-55ea-4463-7bbe-08dc3238535f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wEOKDOza5mlffefVuFQWNIY4NMPhgliKfyeK7TUdlb1rOuZKRr+ziz7Za9+OugSlaP/+4HBh/yxbrfelYhv1KAeoyCoHIsMi7CAQW2LWXul1AQIWVx0miXdM3pwVgu9JLKdVbUoObpSfOusU2rl9cLUNf6A8oZa+3P3gl/ZyYxj8nU8uB8GIh2C5UDOIW60kB3fJ6WOgkDm0CVlY5l+w3B7qEeg+h8bfjP13Q34RxtPGk9EfS1W1wfBTkvhGtDeBd49+ZOhKUti0goEya4hzFhlluu2p2rKhbw2r3xMBH7wXUU21ILOifVhaPC5k25DG5y6hFu+oKcJx+gJojJh7m36XnjuRkSnVqIIDPiX/S8D6zL75T83qnuyq4ebCEY3rlem+KIpIoscYmqiwP8EDuhEyrArb1PBpqjr1fWLgOkipkVK0mK88T9fIzmAk95FvTuqbguTfnc85jTyj704eQU7CrtbPyb/H3aLQMGP90cD3qvhVy1Lx51FDfOl9r0akLifnQDx4TDhK/LwYMNYPmRIWUw+3XE1AKDC3xjuoG9gadGXaHqseaZOA8QntuOG1gE8wA99Nxs/fNG7UU9vTasJSKQyV8xnPd12SjiywXaDUN/Aof3k2i4u6YZ0iWWb3//64BEjbe5FikbiPv5uGNzb0bOgOKydipTtWorwxbHM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:21:07.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d47161ff-55ea-4463-7bbe-08dc3238535f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037

Add support for TIF_NOTIFY_IPI on Nios II. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/nios2/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 5abac9893b32..24882fd5ad11 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -79,6 +79,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
+#define TIF_NOTIFY_IPI		10	/* Pending IPI on TIF_POLLLING idle CPU */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
@@ -91,6 +92,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do on interrupt/exception return */
-- 
2.34.1


