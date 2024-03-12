Return-Path: <linux-kernel+bounces-100785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D1879D31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D7D1F22702
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9823144043;
	Tue, 12 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plCmbjZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7714402E;
	Tue, 12 Mar 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277371; cv=none; b=emiKcXZuyTYSx1XjOL6AAbbSCxbRK6H2Rg9KGBeiamqU3drYnlUg26UWNnCiviHQPd5AA1KRizw49DI/CwhPfP/8h905lmZp5zWjgfeEFOr17oynh121GQAf4ToUaRX59HHVV1canpqjg0ruz/VZfIiLWi7ALy47M9vij1T7xpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277371; c=relaxed/simple;
	bh=EELbV3h66cIZskNpLQcQx/zsk5PhRRxOElZqzCOVXZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG5+VQx8K2LEEo1SJRmZqlqapEzLVu6ONmKz6x+at4lvPJ0rSiZqTeuO8r9PFxamjKdpKbFY11VkAcvOof/RbgIVDeXtv9VEcRBnI8bALe5GDkkmZVWEM5s/wLiqBhxK9d9HtrK/w/Fn2+3pRVLFv6IiiSOT1rXXfBSKcw5K1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plCmbjZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AE1C433A6;
	Tue, 12 Mar 2024 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710277370;
	bh=EELbV3h66cIZskNpLQcQx/zsk5PhRRxOElZqzCOVXZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plCmbjZTvLXrpiMV1QNW0lVbw72+EXxcAKT1YY1bP64Nxj1jdcIAAshWXdWYfMiwW
	 GYIVyAHEwI2eTALsmS+LkJHHQ1jQ3wQynU+/omMeYgwLYboKQAV9Qw5Pp32IywYtXt
	 rfI8GGYtHzdzIyjp4wfnlj8mBOOaCPmF6V1PcfAt5k/PeEUiKM6l/7z+bfU76NE5xd
	 dwyiTynE25A8tYC67+ruFJf5LHkz7UCuGCG5pTk7JDgwB4yhl7BhLS+38O8+jcyvGE
	 ii4vQAa6lrEcI/9lGsaQa/rlF8XFsY98pTnz+P0BDRaiRLOVBS/6AhrNUB3ORI/hnP
	 O9btGdQh6tlyQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 3/3] uprobes: add speculative lockless system-wide uprobe filter check
Date: Tue, 12 Mar 2024 14:02:33 -0700
Message-ID: <20240312210233.1941599-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312210233.1941599-1-andrii@kernel.org>
References: <20240312210233.1941599-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's very common with BPF-based uprobe/uretprobe use cases to have
a system-wide (not PID specific) probes used. In this case uprobe's
trace_uprobe_filter->nr_systemwide counter is bumped at registration
time, and actual filtering is short circuited at the time when
uprobe/uretprobe is triggered.

This is a great optimization, and the only issue with it is that to even
get to checking this counter uprobe subsystem is taking
read-side trace_uprobe_filter->rwlock. This is actually noticeable in
profiles and is just another point of contention when uprobe is
triggered on multiple CPUs simultaneously.

This patch adds a speculative check before grabbing that rwlock. If
nr_systemwide is non-zero, lock is skipped and event is passed through.
From examining existing logic it looks correct and safe to do. If
nr_systemwide is being modified under rwlock in parallel, we have to
consider basically just one important race condition: the case when
nr_systemwide is dropped from one to zero (from
trace_uprobe_filter_remove()) under filter->rwlock, but
uprobe_perf_filter() raced and saw it as >0.

In this case, we'll proceed with uprobe/uretprobe execution, while
uprobe_perf_close() and uprobe_apply() will be blocked on trying to grab
uprobe->register_rwsem as a writer. It will be blocked because
uprobe_dispatcher() (and, similarly, uretprobe_dispatcher()) runs with
uprobe->register_rwsem taken as a reader. So there is no real race
besides uprobe/uretprobe might execute one last time before it's
removed, which is fine because from user space perspective
uprobe/uretprobe hasn't been yet deactivated.

In case we speculatively read nr_systemwide as zero, while it was
incremented in parallel, we'll proceed to grabbing filter->rwlock and
re-doing the check, this time in lock-protected and non-racy way.

As such, it looks safe to do a quick short circuiting check and save
some performance in a very common system-wide case, not sacrificing hot
path performance due to much rarer possibility of registration or
unregistration of uprobes.

Again, confirming with BPF selftests's based benchmarks.

BEFORE (based on changes in previous patch)
===========================================
uprobe-nop     :    2.732 ± 0.022M/s
uprobe-push    :    2.621 ± 0.016M/s
uprobe-ret     :    1.105 ± 0.007M/s
uretprobe-nop  :    1.396 ± 0.007M/s
uretprobe-push :    1.347 ± 0.008M/s
uretprobe-ret  :    0.800 ± 0.006M/s

AFTER
=====
uprobe-nop     :    2.878 ± 0.017M/s (+5.5%, total +8.3%)
uprobe-push    :    2.753 ± 0.013M/s (+5.3%, total +10.2%)
uprobe-ret     :    1.142 ± 0.010M/s (+3.8%, total +3.8%)
uretprobe-nop  :    1.444 ± 0.008M/s (+3.5%, total +6.5%)
uretprobe-push :    1.410 ± 0.010M/s (+4.8%, total +7.1%)
uretprobe-ret  :    0.816 ± 0.002M/s (+2.0%, total +3.9%)

In the above, first percentage value is based on top of previous patch
(lazy uprobe buffer optimization), while the "total" percentage is
based on kernel without any of the changes in this patch set.

As can be seen, we get about 4% - 10% speed up, in total, with both lazy
uprobe buffer and speculative filter check optimizations.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f2875349d124..be28e6d0578e 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1351,6 +1351,10 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 	tu = container_of(uc, struct trace_uprobe, consumer);
 	filter = tu->tp.event->filter;
 
+	/* speculative check */
+	if (READ_ONCE(filter->nr_systemwide))
+		return true;
+
 	read_lock(&filter->rwlock);
 	ret = __uprobe_perf_filter(filter, mm);
 	read_unlock(&filter->rwlock);
-- 
2.43.0


