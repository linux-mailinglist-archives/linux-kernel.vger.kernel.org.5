Return-Path: <linux-kernel+bounces-134517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDB89B26B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5500C1C20A6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DE374F1;
	Sun,  7 Apr 2024 14:06:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4823D69
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712498810; cv=none; b=nhwBfMqJRwPiEz/4F8S6RhqxqD2rQZEEU0zrWOYknu5oBM4YdKwW7wqhPvKnsYHljRCLNY5ebYZzgSuY50aOTBCN/TgTW+DV3lAIblKS9l0GpdXWWkld+DjFnLzIu5tJZAEG3vCnaDA5POvH96GYmF4hHdTYgIVo3q4f6BfQV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712498810; c=relaxed/simple;
	bh=Kii0gY/EBW6uAwevm92uivZAwYfIo7iVJfu2f8inU+8=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=OcdB/yiWbuGirODAjwwNGuQhtbmo+bOBmgXXHSmM2Pe/SBD5KfauWHftQh9fYYtc7Mb5ZPFrbR6sz9MsrhXQvRIm1Oe7BkXSpM4DMG5tKpmF5k6Bj125RLALe4Wgcrlf2/nr/YPjPhz27F9X8ylZvcgc5fkewtP2/3zU/oydm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VCDXF64xdz1wqRh;
	Sun,  7 Apr 2024 22:05:49 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (unknown [7.185.36.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EF4B1A0172;
	Sun,  7 Apr 2024 22:06:44 +0800 (CST)
Received: from [10.67.110.25] (10.67.110.25) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 22:06:43 +0800
Message-ID: <47b4a790-9a27-2fc5-f2aa-f9981c6da015@huawei.com>
Date: Sun, 7 Apr 2024 22:06:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From: "zhaowenhui (A)" <zhaowenhui8@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER"
	<linux-kernel@vger.kernel.org>
Subject: [bug report] WARNING: CPU: 0 PID: 49573 at kernel/sched/rt.c:802
 rq_offline_rt+0x24d/0x260
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)

Hello,
Recently, our machine triggered a warning in __disable_runtime. The 
dmesg are as follow:
[  991.697692] WARNING: CPU: 0 PID: 49573 at kernel/sched/rt.c:802 
rq_offline_rt+0x24d/0x260
[  991.697795] CPU: 0 PID: 49573 Comm: kworker/1:0 Kdump: loaded Not 
tainted 6.9.0-rc1+ #4
[  991.697798] Hardware name: SuperCloud R5210 G12/X12DPi-N6, BIOS 1.1c 
08/30/2021
[  991.697800] Workqueue: events cpuset_hotplug_workfn
[  991.697803] RIP: 0010:rq_offline_rt+0x24d/0x260
[  991.697825] Call Trace:
[  991.697827]  <TASK>
[  991.697830]  ? __warn+0x7c/0x130
[  991.697835]  ? rq_offline_rt+0x24d/0x260
[  991.697837]  ? report_bug+0xf8/0x1e0
[  991.697842]  ? handle_bug+0x3f/0x70
[  991.697858]  set_rq_offline.part.125+0x2d/0x70
[  991.697864]  rq_attach_root+0xda/0x110
[  991.697867]  cpu_attach_domain+0x433/0x860
[  991.697870]  ? psi_task_switch+0x11d/0x260
[  991.697873]  ? __kmalloc_node+0x1dc/0x390
[  991.697877]  ? alloc_cpumask_var_node+0x1b/0x30
[  991.697880]  partition_sched_domains_locked+0x2a8/0x3a0
[  991.697883]  ? css_next_child+0x61/0x80
[  991.697885]  rebuild_sched_domains_locked+0x608/0x800
[  991.697890]  ? percpu_rwsem_wait+0x160/0x160
[  991.697895]  rebuild_sched_domains+0x1b/0x30
[  991.697897]  cpuset_hotplug_workfn+0x4b6/0x1160
[  991.697899]  ? balance_push+0x4e/0x120
[  991.697903]  ? finish_task_switch+0x8d/0x2d0
[  991.697905]  ? __switch_to+0x126/0x4f0
[  991.697909]  process_scheduled_works+0xad/0x430
[  991.697917]  worker_thread+0x105/0x270
[  991.697922]  kthread+0xde/0x110
[  991.697928]  ret_from_fork+0x2d/0x50
[  991.697935]  ret_from_fork_asm+0x11/0x20
[  991.697940]  </TASK>
[  991.697941] ---[ end trace 0000000000000000 ]---

The corresponding code is :
802    WARN_ON_ONCE(want);
Because this WARN_ON_ONCE hasn’t changed from BUG_ON under linux-6.1, it 
will trigger panic in those version.

More information:
1. RT_RUNTIME_SHARE is enabled.
2. We continuously create and remove cpu cgroups. We use cgexec to do 
some tasks like "tree" or "ps" in these cgroups and the rt_runtime_us in 
these cgroups are set to 2000~6000.
3. There are frequent cpu offline/online operations, so it will trigger 
__disable_runtime.

Every time we run these operations after reboot, this warning will 
happen easily.

---
Regards
Zhao Wenhui

