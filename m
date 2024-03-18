Return-Path: <linux-kernel+bounces-106510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D187EFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D95B1C21FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DB5917B;
	Mon, 18 Mar 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJgg29Y0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B5156758;
	Mon, 18 Mar 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785865; cv=none; b=A/o1z0uUfLdK2ROvvP7S1/2d6XjnCo4X8uHm86S7ez6tlXLwEcAG9S5wfcEbA7GSKLMByyvYAjn+5bexbVIBKLSecphYgAjq7if5MnxYFlTYy+aAIUYRUIBho6HjpLiKwJ5vCg8ptfJq2CtVCyuhaVghQxFNKaUVkanoGki4+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785865; c=relaxed/simple;
	bh=U9oCw1odVmOqvb/OZWEqiwrY/4XbjPGtO9KdGOsYVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZr4KHrEWnPgRpxX0WcOeCxSXgNL/eXAJueObFCjFInhIoV4T1U7E5+ssx7f4VNBwZ4F/CDqYQF3nGMIDtu0Oxdb7w45wPwIf1joPrBed0QxU0oRKNPvrhw2+cKLIBbsoZhaAwgzhxIdy1xjuCNxUQMgdEkbYWAxyJnCzJ8YlBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJgg29Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CF9C433A6;
	Mon, 18 Mar 2024 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785864;
	bh=U9oCw1odVmOqvb/OZWEqiwrY/4XbjPGtO9KdGOsYVUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJgg29Y0irfwUw4LAtRRC8MmtnRjV2J6zdwQYhk5ED5CcDtPotUSKv7gU+iC7QnQC
	 zJnfXuAUPKK+cwpA4XlgherY8S/XwyJeAfkAMW62IAfFnShi7KEIz+k6eNAbSuz1ho
	 yZgHrF7iZzVQJ0SSf/QTbpmAv5QCL+AtNQFGhE2IVR9u0ia/6TW9MOoflmTsJwkL1t
	 +uhsrvQHU398ynzqSl6ul9+8NBspa5OJww3DZLIOK+rdeCzH0JuJsdOuxp1/yXJMK9
	 DVydC1qPi1dC9yerrifQkzn4W0IYkDhkQojVGC2dYIAJC80pXVRyIknzeHdlA773av
	 5MIPfcXSeoM3A==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 3/3] uprobes: add speculative lockless system-wide uprobe filter check
Date: Mon, 18 Mar 2024 11:17:28 -0700
Message-ID: <20240318181728.2795838-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
References: <20240318181728.2795838-1-andrii@kernel.org>
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

This patch moves this nr_systemwide check outside of filter list's
rwlock scope, as rwlock is meant to protect list modification, while
nr_systemwide-based check is speculative and racy already, despite the
lock (as discussed in [0]). trace_uprobe_filter_remove() and
trace_uprobe_filter_add() already check for filter->nr_systewide
explicitly outside of __uprobe_perf_filter, so no modifications are
required there.

Confirming with BPF selftests's based benchmarks.

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

  [0] https://lore.kernel.org/bpf/20240313131926.GA19986@redhat.com/

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b5da95240a31..ac05885a6ce6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1226,9 +1226,6 @@ __uprobe_perf_filter(struct trace_uprobe_filter *filter, struct mm_struct *mm)
 {
 	struct perf_event *event;
 
-	if (filter->nr_systemwide)
-		return true;
-
 	list_for_each_entry(event, &filter->perf_events, hw.tp_list) {
 		if (event->hw.target->mm == mm)
 			return true;
@@ -1353,6 +1350,13 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 	tu = container_of(uc, struct trace_uprobe, consumer);
 	filter = tu->tp.event->filter;
 
+	/*
+	 * speculative short-circuiting check to avoid unnecessarily taking
+	 * filter->rwlock below, if the uprobe has system-wide consumer
+	 */
+	if (READ_ONCE(filter->nr_systemwide))
+		return true;
+
 	read_lock(&filter->rwlock);
 	ret = __uprobe_perf_filter(filter, mm);
 	read_unlock(&filter->rwlock);
-- 
2.43.0


