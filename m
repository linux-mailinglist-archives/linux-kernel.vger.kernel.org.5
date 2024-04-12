Return-Path: <linux-kernel+bounces-141811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CD8A23C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12D61C22639
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07460DDC3;
	Fri, 12 Apr 2024 02:30:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36028FC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889028; cv=none; b=J/efxeUXSJZ81HJV/c33R+iGU0ncpwGUj6qhBN2Nk4t+EN6MXCOVzSvc+aImZxxJ5anngfPf2n3m7QyzLSSrSWH/iaIK6KLsZeRXrrG040Tcoivv1CGzAF84/PV3hQtolV2PpNju1KL0WfUo5e3xwc4E+sK+F3CMjC+fKNtYY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889028; c=relaxed/simple;
	bh=HVYMqLb0FbGAYbjnXpo3nnNB8UYlSekA3Z5qGEWtkPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O80OePUezgOioX7ZbJXC+nyJFxIMSqupSMQjZtzgJX2QR7utdFY/wxwYolduFYTYB+E3OfuUo/g2g6i5LCj/ZOXUHocJh0WfP54q4idEIW4/LllHPG0+HDsJsz+jj3dCA9Vh8ilyQblRciA4lwVYChsZC7W5wRCiPBkJelSLQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG0p66S4szwRQY;
	Fri, 12 Apr 2024 10:27:26 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D6C9140427;
	Fri, 12 Apr 2024 10:30:24 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 12 Apr 2024 10:30:23 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH] sched/cputime: arch_vtime_task_switch() should be declared for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
Date: Fri, 12 Apr 2024 10:30:12 +0800
Message-ID: <20240412023012.2933240-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The arch_vtime_task_switch() is only used by the native vtime accounting
code not the generic one.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 include/linux/vtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 005d0870e41b..9f0bad8d8617 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -10,7 +10,6 @@
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_user_enter(struct task_struct *tsk);
 extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
@@ -25,6 +24,7 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
-- 
2.34.1


