Return-Path: <linux-kernel+bounces-150292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220918A9CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30F1286A28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC216D307;
	Thu, 18 Apr 2024 14:20:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B816C858
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450029; cv=none; b=MegMiypgnM7y61X8R+clRnk3O+EyQNjLAdCjngZdd1ShBlN5zbPw7l4bdSH3bt5PEYqbYp8NNrgG/0dcbOtXFD7DaN7GKFIBY3azbDPBDr96/tQpTve0eeRb6J0btu20Olq61GISM7vRrn0ow3BG9C/lftWn8kwfKUhVpcBbXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450029; c=relaxed/simple;
	bh=yYVvpcOskMq+Dm99ZR8HiRWQFwVnOKj+FuHqdimshpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2qs/12Gpp2UpUfsFQttrnWD5fJrskMjzcdGlBVpSuFWojnE/R83jwZUmkgAzLer5zdakO6l9w71VrEgn1zzRQzSx/haHCgxK/OQWgstxqQ4MOcSTX29u2jJ0dbAGfNW/rZorfifxszxdqDkAPHTd9SyXctoH6/psAic+o9JeiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VL0GK16f1zwSgx;
	Thu, 18 Apr 2024 22:17:13 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F5B6180073;
	Thu, 18 Apr 2024 22:20:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 22:20:16 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH v2 0/2] mm: convert mm's rss stats to use atomic mode
Date: Thu, 18 Apr 2024 22:20:06 +0800
Message-ID: <20240418142008.2775308-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Since commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter"), the rss_stats have converted into percpu_counter,
which convert the error margin from (nr_threads * 64) to approximately
(nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
performance regression on fork/exec/shell. Even after commit 14ef95be6f55
("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
the performance of fork/exec/shell is still poor compared to previous
kernel versions.

To mitigate performance regression, we delay the allocation of percpu
memory for rss_stats. Therefore, we convert mm's rss stats to use
percpu_counter atomic mode. For single-thread processes, rss_stat is in
atomic mode, which reduces the memory consumption and performance
regression caused by using percpu. For multiple-thread processes,
rss_stat is switched to the percpu mode to reduce the error margin.
We convert rss_stats from atomic mode to percpu mode only when the
second thread is created.

After lmbench test, we can get 2% ~ 4% performance improvement
for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
improvement for lmbench page_fault (before batch mode[1]).

The test results are as follows:
             base           base+revert        base+this patch

fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)

[1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/

ChangeLog:
v2->v1:
- Convert rss_stats from atomic mode to percpu mode only when
  the second thread is created per Jan Kara.
- Compared with v1, the performance data may be different due to
  different test machines.

ZhangPeng (2):
  percpu_counter: introduce atomic mode for percpu_counter
  mm: convert mm's rss stats to use atomic mode

 include/linux/mm.h             | 50 +++++++++++++++++++++++++++++-----
 include/linux/percpu_counter.h | 43 +++++++++++++++++++++++++++--
 include/trace/events/kmem.h    |  4 +--
 kernel/fork.c                  | 18 +++++++-----
 lib/percpu_counter.c           | 31 +++++++++++++++++++--
 5 files changed, 125 insertions(+), 21 deletions(-)

-- 
2.25.1


