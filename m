Return-Path: <linux-kernel+bounces-152377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326878ABD89
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D345B20BFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0F4AEC7;
	Sat, 20 Apr 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FiZxmcEg"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A06481DD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713650779; cv=none; b=SrKgnVxT/2832O2Bn7Qj0bS8ov07dgHmeCNUTLpqJ4D8kN5jXqfdIYrY4WAbjlwM0Rs4Cmvmkj5DN1abpLrjFCvCruiHyRvqkDSSGJNGqJDWzyvb9s/dGpGFAQEGnL9IoqusAs1rdfwftpetE0NqblaZaRtbRZLb07bbOLR+y5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713650779; c=relaxed/simple;
	bh=Q3/st490ZVEV0a95obH5fbPRSiIaOiRP9188COAHvts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYuOqI+w/bz2Pwbu1mhjF/3CJPFYSc98pGaGgSfzACQu+6FAbjAMEBHAmWiKV8gTo8slXXgKV9/KKgwxMwFL4gepHFwLg0+eZr01NCuW9ZNxJ/+KAl2h80xMSaOTl8lfC6C7SWtGUiPnB5WVBAXwgsCbWO08QWGxL8HKXQoNCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FiZxmcEg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713650772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VoccYVdC4pUrUz867A0VVlKD6/J156Gylfus5CpWqMk=;
	b=FiZxmcEg321RzEpIqwbCMcmGiHPhbqX4k9zyztUFJt7+THaROuP1c5rl/IWS5ka0oKoQ34
	4QS19BGPMwGUhI/IupAxE1yRIZa1bhCe4s9t8zOADEHjxvTiMVAjQWtBx2Uq+s0SpaVLyh
	LYCqJ5O9Jd7Y9cq50wZQxGh0KHneflM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] bcachefs: idle work scheduling design doc
Date: Sat, 20 Apr 2024 18:06:01 -0400
Message-ID: <20240420220604.496611-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bcachefs has various background tasks that need to be scheduled to
balance efficiency, predictability of performance, etc.

The design and philosophy hasn't changed too much since bcache, which
was primarily designed for server usage, with sustained load in mind.

These days we're seeing more desktop usage - where we really want to let
the system idle effictively, to reduce total power usage - while also
still balancing previous concerns, we still want to let work accumulate
to a degree.

This lays out all the requirements and starts to sketch out the
algorithm I have in mind.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/idle.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 fs/bcachefs/idle.h

diff --git a/fs/bcachefs/idle.h b/fs/bcachefs/idle.h
new file mode 100644
index 000000000000..b1717635581e
--- /dev/null
+++ b/fs/bcachefs/idle.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _BCACHEFS_IDLE_H
+#define _BCACHEFS_IDLE_H
+
+/*
+ * Idle/background work classes:
+ *
+ * We have a number of background tasks (copygc, rebalance, journal reclaim).
+ *
+ * SUSTAINED LOAD REGIME
+ * ---------------------
+ *
+ * When the system is under continuous load, we want these jobs to run
+ * continuously - this is perhaps best modelled with a P/D controller, where
+ * they'll be trying to keep a target value (i.e. fragmented disk space,
+ * available journal space) roughly in the middle of some range.
+ *
+ * The goal under sustained load is to balance our ability to handle load spikes
+ * without running out of x resource (free disk space, free space in the
+ * journal), while also letting some work accumululate to be batched (or become
+ * unnecessary).
+ *
+ * For example, we don't want to run copygc too aggressively, because then it
+ * will be evacuating buckets that would have become empty (been overwritten or
+ * deleted) anyways, and we don't want to wait until we're almost out of free
+ * space because then the system will behave unpredicably - suddenly we're doing
+ * a lot more work to service each write and the system becomes much slower.
+ *
+ * IDLE REGIME
+ * -----------
+ *
+ * Many systems are however not under sustained load - they're idle most of the
+ * time, and the goal is to let them idle as much as possible because power
+ * useage is a prime consideration. Thus, we need to detect when we've been
+ * idle - and the longer we've been idle, the more pending work we should do;
+ * the goal being to complete all of our pending work as quickly as possible so
+ * that the system can go back to sleep.
+ *
+ * But this does not mean that we should do _all_ our pending work immediately
+ * when the system is idle; remember that if we allow work to build up, much
+ * work will not need to be done.
+ *
+ * Therefore when we're idle we want to wake up and do some amount of pending
+ * work in batches; increasing both the amount of work we do and the duration of
+ * our sleeps proportional to how long we've been idle for.
+ *
+ * CLASSES OF IDLE WORK
+ * --------------------
+ *
+ * There are levels of foreground and background tasks; a foreground operation
+ * (generated from outsisde the system, i.e. userspace) will generate work for
+ * the data move class and the journal reclaim class, and the data move class
+ * will generate more work for the journal reclaim class.
+ *
+ * This complicates idle detection, because a given class wants to know if
+ * everything above it has finished or is no longer running, and will want to
+ * behave differently for work above it coming from outside the system (which we
+ * cannot schedule and can only guess at based on past behaviour), versus work
+ * above it but from inside the system (which we can schedule).
+ *
+ * That is
+ * - data moves want to wake up when foreground operations have been quiet for
+ *   a little while
+ * - journal reclaim wants to wake up when foreground operations have been quiet
+ *   for a little while, and immediately after background data moves have
+ *   finished and gone back to sleep
+ */
+
+#define BCACHEFS_IDLE_CLASSES()		\
+	x(foreground)			\
+	x(data_move)			\
+	x(journal_reclaim)
+
+enum bch_idle_class {
+#define x(n)	BCH_IDLE_##n,
+	BCACHEFS_IDLE_CLASSES()
+#undef x
+};
+
+#endif /* _BCACHEFS_IDLE_H */
-- 
2.43.0


