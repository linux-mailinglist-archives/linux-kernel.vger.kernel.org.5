Return-Path: <linux-kernel+bounces-140330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA68A12DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296E51F22A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3311D1482E6;
	Thu, 11 Apr 2024 11:22:26 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA913BC33
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834545; cv=none; b=TdLbGOns9kCPLJEwmcWKTQUofCGrSYCsVpSIZAiFutbQrcgRFtdhOxo0oyP1HTsx0VpPzoW5lhEaC6pVQxqoMROhWNxLBsVmrD4CmfHZUNrbODIr6IKbf6OtLFTX9mfVB9YbSVRxJmCvxYigTpo25KySTRookAsfZn/MVKE3tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834545; c=relaxed/simple;
	bh=fTMl6zXHK+rSadzbwABHstG/A9xLT+lsxxrNWzi0tNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbIKWZcZKSFhoXM/am3e+j3AjoBv2vqqUM/1xKutsZonlYSjFxcpLKZL0pqhzNYCIZiXg3gALUuQ7qJnJyssDe92eXLdjiEyxhzUR7nejWIbr9dN/T3KCQqvFiv/o0MpZk4vF2P96WeUFrYg8E20q4NxOAm8myU7D6eiVYxpW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFcfQ2H00z2NW5r;
	Thu, 11 Apr 2024 19:19:26 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id E48D61A0172;
	Thu, 11 Apr 2024 19:22:18 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 19:22:17 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH] sched/cputime: remove unused vtime_account_kernel
Date: Thu, 11 Apr 2024 19:22:12 +0800
Message-ID: <20240411112212.2061899-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100011.china.huawei.com (7.221.188.204)

This removes the vtime_account_kernel() function in generic vtime
accounting. It's never used anymore.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 kernel/sched/cputime.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..29320e66abdc 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -709,18 +709,6 @@ static void __vtime_account_kernel(struct task_struct *tsk,
 		vtime_account_system(tsk, vtime);
 }
 
-void vtime_account_kernel(struct task_struct *tsk)
-{
-	struct vtime *vtime = &tsk->vtime;
-
-	if (!vtime_delta(vtime))
-		return;
-
-	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_kernel(tsk, vtime);
-	write_seqcount_end(&vtime->seqcount);
-}
-
 void vtime_user_enter(struct task_struct *tsk)
 {
 	struct vtime *vtime = &tsk->vtime;
-- 
2.34.1


