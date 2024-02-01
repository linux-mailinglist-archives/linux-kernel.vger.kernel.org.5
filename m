Return-Path: <linux-kernel+bounces-48368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B985845B04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4A61C263DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D05F496;
	Thu,  1 Feb 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwRdsEgn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43E5F49E;
	Thu,  1 Feb 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800430; cv=none; b=fFWik2sO5Ogu1H7jwMJKSNdUQu9p3/NFL68P0WfyREhIk1+tkmQV5G1y0tJwL16+N9z/HOUB8Ci7Ht/YuGTig/bHyqbhZGSWpX86Op0QdkAutWB6sshOkrBNwWCk5c5bIfiygQbXBSMRLVHQk9tot67msBDH+3bdfxKg2P514l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800430; c=relaxed/simple;
	bh=J25LSF02c3Gihi6ywJToP8/0dpuIX20uFfdRTlYxyRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Giya0wkA4NM5SBmK7pVoD+r/vzGsxxAsMEqCA0OV+241RwzkKQdtEsgwoLPYw9IK5kTdaugCAdatSqjr4odZWRMma9ajh4/t9q+5xHHoKAyM9mrtaHVDTer7UykelmbE2iHNTXPmlYgIe0We8F4nyxaP4Tq5COt1w21bW3yZUfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwRdsEgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F423DC433F1;
	Thu,  1 Feb 2024 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706800429;
	bh=J25LSF02c3Gihi6ywJToP8/0dpuIX20uFfdRTlYxyRg=;
	h=From:To:Cc:Subject:Date:From;
	b=WwRdsEgnfVREwIGEX7L2Y0qvFc4a+QOfttbXdf6t8ZoZNJqEAF6ntKisAF9lamz/c
	 CKCOXaJCB1NwUOAuFSWq5OWNXl4pXVdZJnYhNcZuW8JGTQ8u0Z4Sosso2c5GgnCgPB
	 7dR5pfRAW6HrAqvmWuJCBnh6Y5X0kIVJ/KhHUPFuPT9K03GqVRjJtfGP6m6hNgbZP2
	 X3Sn7bLvYa98cxeGVu0bS+gecxyjnBFLZlorUBZQDP2GS/v+EMk8hjl0Evn3X1dB5N
	 EIKY1bGR+sRwskTDZMEvuuAvwRImAxta9NDT3WI6wbIW8tPUXCNpYlze1Q51t/tRyl
	 8tmRRAUrucKXg==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Date: Thu,  1 Feb 2024 16:13:39 +0100
Message-ID: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the timerlat's hrtimer is initialized at the first read of
timerlat_fd, and destroyed at close(). It works, but it causes an error
if the user program open() and close() the file without reading.

Move hrtimer_init to timerlat_fd open() to avoid this problem.

No functional changes.

Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..a8e28f9b9271 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2444,6 +2444,9 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
 	tlat = this_cpu_tmr_var();
 	tlat->count = 0;
 
+	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
+	tlat->timer.function = timerlat_irq;
+
 	migrate_enable();
 	return 0;
 };
@@ -2526,9 +2529,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
 		tlat->tracing_thread = false;
 		tlat->kthread = current;
 
-		hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-		tlat->timer.function = timerlat_irq;
-
 		/* Annotate now to drift new period */
 		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
 
-- 
2.43.0


