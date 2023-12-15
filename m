Return-Path: <linux-kernel+bounces-859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E70814729
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277231C2316E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA013250FD;
	Fri, 15 Dec 2023 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CdOV0a28";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWyK3Ky9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6267250E8;
	Fri, 15 Dec 2023 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 11:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702640579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Q7Ku4Lhyrtkwj5E1dLtuUeOMVelgb0yIL0BU0v4KUc=;
	b=CdOV0a28viDk9VATTd62WT9HF2p1DzMob50NQ6ItVNh57vobFjy7g6lxQdgwCDqgyYXjgO
	tlKJYgGboJyTBNTx3XejE1PXkC5KUIE78VEWif1JNDKceNNFwIMxReWuIILKGAq/BxQbQQ
	HUMvitqHDjIGwtWVdG5LfXPzl8TQ2v3sttz9sJ6c9iVLkx5V42KzBVlu3fIRzi7HmoTGGe
	aqscEBPkaZCdcdklW02CSwPZ9w8BqgoFouB2NZ3rwcWZ53HY6171tOyJS6NGreskWA8LUS
	KzCQDvLa8g1pWa0IPGSfGRXHSdtsULbahKeIiqs2mDnY+uHmk1Jrb4xz1okqXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702640579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Q7Ku4Lhyrtkwj5E1dLtuUeOMVelgb0yIL0BU0v4KUc=;
	b=fWyK3Ky9g6ice3/RP91y/y22o+Qnjm+gu2WNu+xCTtbFS0Tyg2s9UAKJuVv6epdmte7Q3G
	fPA5fttZJdogOBDw==
From: "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix perf_event_validate_size() lockdep splat
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 Pengfei Xu <pengfei.xu@intel.com>, Mark Rutland <mark.rutland@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231215112450.3972309-1-mark.rutland@arm.com>
References: <20231215112450.3972309-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170264057897.398.420625380438569608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
Gitweb:        https://git.kernel.org/tip/7e2c1e4b34f07d9aa8937fab88359d4a0fce468e
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Fri, 15 Dec 2023 11:24:50 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Dec 2023 12:33:23 +01:00

perf: Fix perf_event_validate_size() lockdep splat

When lockdep is enabled, the for_each_sibling_event(sibling, event)
macro checks that event->ctx->mutex is held. When creating a new group
leader event, we call perf_event_validate_size() on a partially
initialized event where event->ctx is NULL, and so when
for_each_sibling_event() attempts to check event->ctx->mutex, we get a
splat, as reported by Lucas De Marchi:

  WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080

This only happens for a new event which is its own group_leader, and in
this case there cannot be any sibling events. Thus it's safe to skip the
check for siblings, which avoids having to make invasive and ugly
changes to for_each_sibling_event().

Avoid the splat by bailing out early when the new event is its own
group_leader.

Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20231215112450.3972309-1-mark.rutland@arm.com
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9d123e..9efd0d7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1947,6 +1947,16 @@ static bool perf_event_validate_size(struct perf_event *event)
 				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	/*
+	 * When creating a new group leader, group_leader->ctx is initialized
+	 * after the size has been validated, but we cannot safely use
+	 * for_each_sibling_event() until group_leader->ctx is set. A new group
+	 * leader cannot have any siblings yet, so we can safely skip checking
+	 * the non-existent siblings.
+	 */
+	if (event == group_leader)
+		return true;
+
 	for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)

