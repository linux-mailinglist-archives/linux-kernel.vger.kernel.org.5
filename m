Return-Path: <linux-kernel+bounces-73426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89785C270
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E5A281DED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A47762F;
	Tue, 20 Feb 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i2yNorKf"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE27641C;
	Tue, 20 Feb 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449588; cv=fail; b=hdmxY8Xo9Zaltw6lpXdQqJzDBvOfg49+Hpkn+y5lWp6o4Tsr5/JuyanMzLuItPEaDxhMsYFycYf46posg5kDvycux36kFPyrPecDvukkJ2aysOgxbctN3fdOBgqkFroeEvueri4UsVxgZAHOX3p7YMIXXIbAsjvRsyqIfKndg4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449588; c=relaxed/simple;
	bh=YM/LTpdMLdNFjAxSHp97qp3qUMedeEe0S2mJuD1PbH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+QZp9ydzyLoHi7jy88NLMdD/L/OdE7GuA6slbirO9fs/PI4EwIwLEec07pp5ghAjv4IivMMb40p9QLCc1VKnng9RJdOIhW1CD+T/Po/W/0XW+GtUYkvcKkFNxUgF/R6TGSQGy8JTM8hlhTiOILmqdmIOsIZBvJEimQT4Qh9Kqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i2yNorKf; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeF/cO/cpMWWeYyIPeqKIL4VuYeJ/ghxm1LiFNmfkoitPgHfyDvXsmaj8SthF/4CseruqUqyDVJ/6OvX3THFAgY4qtc6/YesuzgqfTQtnC6+Vl9+stmowVXEfrIunE63u/4S5TnsXZGp+VdUOBssjqiDCdonuG8PEj5gi0siiSVyiAzli3OqA2iZZMy70mIvnBQQ0ngoejz4I8iGoApbxcrOLEBHzuj3ViIdOyVCvXdyradQLSfVixiVIhoYzeebkR/YzcEi4y/mGrx/Fb8ribVnAL9OqCnVPIW5IF2EV/8o4DUWeHnaHrRwFQKnX6bvULMHLl51ySQPbeMkRUZavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc3/OhSnWCgw/Tp922CJ/tCJQsW336Sp0VQltfMY5sY=;
 b=P7c1EJpEvI6O8Gl2aJ8c7ILY7ZKO/6Iq1gPi8ZQnXOX+vn3SjSFfD4olJsQkHpsModMuXxKpM9k5JpJXcPBH1UipBU75GBvuoqHtSKuCGeoLFxXYj+zFQ0DfJnMAZFqTH9KLbmjVaTOUnm8bKEkoYA1ViZaNsIRMtG+H5HiRirZBXuVDJfOKEg0J43+/fqp3w41iKpcoa+/DjJqCTKI4P02nyQp1rXh9SPcgNPBkihFtsnYzu3CusLtc7LFfsAV2dadm2K9012VANVIzv0mHO4bgGw01wGXqP7Afmnngcfn0WTkJmNQRPFpmSY3hXTdgnRn6IzeWseZP7ySBYF8ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc3/OhSnWCgw/Tp922CJ/tCJQsW336Sp0VQltfMY5sY=;
 b=i2yNorKfEBr+0ib1FdDRWZY9gY58G9XbYKITaZpISibNkrFbH+J2KRrm2ZBM2arr+9hrU/CXKbZPvz1rQEErpzm2vm0vKfiDhh3qGgBeJwuSeJLvVjXP6xnPhtMtqREC4Ph6YgDpsivGvIDr6YMHLC73jNXUTNJukMOa2bTq2hs=
Received: from PH8PR15CA0024.namprd15.prod.outlook.com (2603:10b6:510:2d2::9)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 17:19:42 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::24) by PH8PR15CA0024.outlook.office365.com
 (2603:10b6:510:2d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Tue, 20 Feb 2024 17:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 17:19:41 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 11:19:34 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Daniel Bristot de
 Oliveira" <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-sh@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 09/14] sh/thread_info: Introduce TIF_NOTIFY_IPI flag
Date: Tue, 20 Feb 2024 22:44:52 +0530
Message-ID: <20240220171457.703-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: de553326-5489-4601-27d7-08dc32382036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ayclTJLhpxzbtafcpJ7mkNgERCWyXJWHq02pSQ7B8sFboQfua624O6xtIaqiQcoX27V/yv+zwmnMPQZBHjrhVY7SK/FsM2ePzwGohMXz1aXAFodELLUmq3U4QWCtDzf5VC+kv1KbviaBYBUqp1BMwJUnM6rqgyTh/5tvw0NEUPRQwwtDV4baU4xEaDLFo7/IOTAPvzqmkqsMs+OqJiVUEmJuvCqsfQtkTig79QMyVT2hP/69HTPjNhXZjIokik9XlNMF6TSQjKpcuG5XL0ZBV6P+WeprKjPtSj5c/6SmfnItclDdCLs5mXf0xcRzoxxO+PdMeao7vG9U9NvI0iNaVHRFWf7CtmO7VXVejvbP+oUXIygJvQwn9J4/RT85gSRjfMQeDv1ki+3v+HQdEo48YvBEEZLIyq81f629dXggjizPn5hf4JA+DnwRZGjYHKblcvot+lIaGXco4bO/IEeK7YJDWg07friHazUiyS2lYvmiuVxYeDl3tB2Vwgo9VO59X7+PUTY2qPqB14U8lHhMqiluE9PKgqs3o/BLJKZ6U2RLJ2bZillB0utSRNa4lxTafzqG8B+2C2Qipyn21SirKaU/hOkS65/6vRO6wBDQBdiP9c30LPQbFEDEjJR5YgIB/ct56HSUfgf3NKuLWXRMdK7HlS936YW+pTMWKBxKrtw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 17:19:41.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de553326-5489-4601-27d7-08dc32382036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958

Add support for TIF_NOTIFY_IPI on SuperH. With TIF_NOTIFY_IPI, a sender
sending an IPI to an idle CPU in TIF_POLLING mode will set the
TIF_NOTIFY_IPI flag in the target's idle tasks's thread_info to pull the
CPU out of idle, as opposed to setting TIF_NEED_RESCHED previously. This
avoids spurious calls to schedule_idle() in cases where an IPI does not
necessarily wake up a task on the idle CPU.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/sh/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 9f19a682d315..8cd9d2a5361b 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -106,6 +106,7 @@ extern void init_thread_xstate(void);
 #define TIF_SECCOMP		6	/* secure computing */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_SYSCALL_TRACEPOINT	8	/* for ftrace syscall instrumentation */
+#define TIF_NOTIFY_IPI		9	/* Pending IPI on TIF_POLLLING idle CPU */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 
@@ -118,6 +119,7 @@ extern void init_thread_xstate(void);
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_NOTIFY_IPI		(1 << TIF_NOTIFY_IPI)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do in syscall trace */
-- 
2.34.1


