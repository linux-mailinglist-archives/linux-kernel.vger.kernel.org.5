Return-Path: <linux-kernel+bounces-156956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CD8B0AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22301F2315F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711515B99E;
	Wed, 24 Apr 2024 13:29:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3AB15A4B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965380; cv=none; b=XHY9nPbBb1ntQgq/8H9cytgwuoAhZOgiG9xd3cdkG/WsYqqh/ge3saqH/eVzvCI9jc9AC4UntZweeBm4TNyCX/jVBDflvT9CydWDcBn6L2WSvxVIq1322ypEU7opRSe/ck6Q3Ajt7b9kXweNKcv3ke7V0ra6kud/V2xiB34tH4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965380; c=relaxed/simple;
	bh=YeGnNM3NBl2Yub3N76MBgc5Ql6v7CSjam7WnrDHtTxQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJfZ36qGtmULqDSWufCYUutm2/LVkgVhvDC2vZbLO23LI68Xe6IaEXyC2aXEfNTh0rFln+e7lVJZvPiMY1NaxK0NkBLvWmBjFkDdJjTpsW1c4Bn1MKqJY4diWclaxZOTMbW9AjZqHB3+tZpxvXD4+ltKGSSp1qVKgF0wTXpaVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VPfs552B5zvPvj;
	Wed, 24 Apr 2024 21:26:33 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E58918006B;
	Wed, 24 Apr 2024 21:29:35 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Apr
 2024 21:29:34 +0800
From: Cheng Yu <serein.chengyu@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <serein.chengyu@huawei.com>
Subject: [PATCH] sched/core: fix incorrect parameter burst in cpu_max_write()
Date: Wed, 24 Apr 2024 21:24:38 +0800
Message-ID: <20240424132438.514720-1-serein.chengyu@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500005.china.huawei.com (7.202.181.243)

In the cgroup v2 cpu subsystem, assuming we have a
cgroup named test, we set cpu.max and cpu.max.burst:
    # echo 1000000 > /sys/fs/cgroup/test/cpu.max
    # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst
then we check cpu.max and cpu.max.burst:
    # cat /sys/fs/cgroup/test/cpu.max
    1000000 100000
    # cat /sys/fs/cgroup/test/cpu.max.burst
    1000000

Next we set cpu.max again and check cpu.max and
cpu.max.burst:
    # echo 2000000 > /sys/fs/cgroup/test/cpu.max
    # cat /sys/fs/cgroup/test/cpu.max
    2000000 100000
    # cat /sys/fs/cgroup/test/cpu.max.burst
    1000
we found that the cpu.max.burst value changed unexpectedly.

In cpu_max_write(), the unit of the burst value returned
by tg_get_cfs_burst() is microseconds, while in cpu_max_write(),
the burst unit used for calculation should be nanoseconds,
which leads to the bug.

To fix it, we get the burst value directly from
tg->cfs_bandwidth.burst.

Reported-by: Qixin Liao <liaoqixin@huawei.com>
Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..d211d40a2edc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11402,7 +11402,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = tg->cfs_bandwidth.burst;
 	u64 quota;
 	int ret;
 
-- 
2.25.1


