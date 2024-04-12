Return-Path: <linux-kernel+bounces-142400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56828A2B20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F447B21A29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EA502A9;
	Fri, 12 Apr 2024 09:24:54 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5759481B3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913894; cv=none; b=hBSCyPjgFvn8nd6KvY0MSt7rvQ6bG6Cs0NDgve3bF0m18paN6ByDo0/030Ldkdie6szRfIJ4hc9m0H+X/TfGFXmNgYUUSLhuvZaXqzUNR1BHRrMHXR8TgZKbMG+gBuXlLSk9jSx79jPFv0Qbi/0ILic6l7ZCoBfhlMvo6BzrrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913894; c=relaxed/simple;
	bh=Xa3t50b6PPs+Ieq8myf7Kosb9ibYsErP7gw16hTayaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UqT9T5xFKisnwRw2lcVF0hXIz/2gFuDyaOC1GIvnZrfzre3k/P+nbMzqrBjizIlWrKDLjpDu009nAQPpFQO9Y0JknGDRXqdiRUPweXbjCFarkCnY5w3D3znzb05uGFhNvNrxlxxQl2R2zaF83oEm0f++2wFBD6Hpi+7LYKUgpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VGB2d3X4jz1wrPX;
	Fri, 12 Apr 2024 17:23:53 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id BE13D140156;
	Fri, 12 Apr 2024 17:24:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:24:48 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <dennisszhou@gmail.com>,
	<shakeelb@google.com>, <jack@suse.cz>, <surenb@google.com>,
	<kent.overstreet@linux.dev>, <mhocko@suse.cz>, <vbabka@suse.cz>,
	<yuzhao@google.com>, <yu.ma@intel.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>, <zhangpeng362@huawei.com>
Subject: [RFC PATCH 0/3] mm: convert mm's rss stats into lazy_percpu_counter
Date: Fri, 12 Apr 2024 17:24:38 +0800
Message-ID: <20240412092441.3112481-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Since commit f1a7941243c1 ("mm: convert mm's rss stats into
percpu_counter"), the rss_stats have converted into percpu_counter,
which convert the error margin from (nr_threads * 64) to approximately
(nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
performance regression on fork/exec/shell. Even after commit
14ef95be6f55 ("kernel/fork: group allocation/free of per-cpu counters
for mm struct"), the performance of fork/exec/shell is still poor
compared to previous kernel versions.

To mitigate performance regression, we use lazy_percpu_counter[1] to
delay the allocation of percpu memory for rss_stats. After lmbench test,
we will get 3% ~ 6% performance improvement for lmbench
fork_proc/exec_proc/shell_proc after conversion.

The test results are as follows:

             base           base+revert        base+lazy_percpu_counter

fork_proc    427.4ms        394.1ms  (7.8%)    413.9ms  (3.2%)
exec_proc    2205.1ms       2042.2ms (7.4%)    2072.0ms (6.0%)
shell_proc   3180.9ms       2963.7ms (6.8%)    3010.7ms (5.4%)

This solution has not been fully evaluated and tested. The main idea of
this RFC patch series is to get the community's opinion on this approach.

[1] https://lore.kernel.org/linux-iommu/20230501165450.15352-8-surenb@google.com/

Kent Overstreet (1):
  Lazy percpu counters

ZhangPeng (2):
  lazy_percpu_counter: include struct percpu_counter in struct
    lazy_percpu_counter
  mm: convert mm's rss stats into lazy_percpu_counter

 include/linux/lazy-percpu-counter.h |  88 +++++++++++++++++++
 include/linux/mm.h                  |   8 +-
 include/linux/mm_types.h            |   4 +-
 include/trace/events/kmem.h         |   4 +-
 kernel/fork.c                       |  12 +--
 lib/Makefile                        |   2 +-
 lib/lazy-percpu-counter.c           | 131 ++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/lazy-percpu-counter.h
 create mode 100644 lib/lazy-percpu-counter.c

-- 
2.25.1


