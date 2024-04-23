Return-Path: <linux-kernel+bounces-154875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4858AE246
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF5C1C21A27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383A535D6;
	Tue, 23 Apr 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pjmsJBd0"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EEF37147;
	Tue, 23 Apr 2024 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868492; cv=none; b=PGhR5A+bkFKXZeTMoJOSNGQZNq99Dol0varl19SKJVZGl0LFDhT/KXgnvH1jltbKM/6XYQ+SRQqkOTIBIwgweFBmOdoZLBpXK/qq/lSYuo2/R4htsUgDVzbSgfdhe+nJLx3J6VTBPrczgJnig4yl8OE7u/dRnzKwSJ3QS3qqsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868492; c=relaxed/simple;
	bh=KwbPcjrXsaN9eBiRQy+fJ9TI6jMFZegKAgDYMpZNJdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l18kxxCFT/BxRPW/zJyLh+BketoqJsNCycat3dCAYSgEJBdcP7HLMh+A+yLIe6u7/o1znvc9Ce/2gEg4p8IVLMRc5B8GZTtFRiyvrvatAOMkCW8s7/OXJbGoPERiPB21iGtZneCALF2DBzXshdG5Es9F5/vFh4SMIpJ0LsjFjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pjmsJBd0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713868488;
	bh=KwbPcjrXsaN9eBiRQy+fJ9TI6jMFZegKAgDYMpZNJdM=;
	h=From:Date:Subject:To:Cc:From;
	b=pjmsJBd0v+P59KM67nzYcRDzVTYZlnVLnM4dpCMlJFmnik6IGbQMQ3WhUmQeVH2dN
	 7ZcFK1cb8ULPCZF1S20yh+Leutr4nyumJji4ATkCq8dH/15QHRDrMOiTI1GexJM/pp
	 u5kHBpOlp9ERu9vwGlcifI+DF+e8mFRz68hEecME=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 12:34:25 +0200
Subject: [PATCH] admin-guide/hw-vuln/core-scheduling: fix return type of
 PR_SCHED_CORE_GET
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALCOJ2YC/x3MQQqAIBBA0avErBNGs4iuEi3SphwKDaUIwrsnL
 d/i/xcSRaYEQ/VCpJsTB18g6wqsm/1GgpdiUKg0atUIGyKJZB0t18F+Kw47kzDYttJqNNh3UOI
 z0srPPx6nnD+NHGzzaAAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>, 
 Chris Hyser <chris.hyser@oracle.com>, Josh Don <joshdon@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713868488; l=1859;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KwbPcjrXsaN9eBiRQy+fJ9TI6jMFZegKAgDYMpZNJdM=;
 b=JGquxRziWJbrB0Tbk8Ppl9VeteFIloDvuyOExYZGiqPT81OPpbtPqZNAfzkxoB1t3AHAKoBbX
 KLKCKKJzT1lBpL7VvsFV1xY8gIi4iuLpjh64HbiJa8QtfYC/c9LUY0N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

sched_core_share_pid() copies the cookie to userspace with
put_user(id, (u64 __user *)uaddr), expecting 64 bits of space.
The "unsigned long" datatype that is documented in core-scheduling.rst
however is only 32 bits large on 32 bit architectures.

Document "unsigned long long" as the correct data type that is always
64bits large.

This matches what the selftest cs_prctl_test.c has been doing all along.

Fixes: 0159bb020ca9 ("Documentation: Add usecases, design and interface for core scheduling")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/util-linux/df7a25a0-7923-4f8b-a527-5e6f0064074d@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index cf1eeefdfc32..a92e10ec402e 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -67,8 +67,8 @@ arg4:
     will be performed for all tasks in the task group of ``pid``.
 
 arg5:
-    userspace pointer to an unsigned long for storing the cookie returned by
-    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
+    userspace pointer to an unsigned long long for storing the cookie returned
+    by ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
 
 In order for a process to push a cookie to, or pull a cookie from a process, it
 is required to have the ptrace access mode: `PTRACE_MODE_READ_REALCREDS` to the

---
base-commit: 71b1543c83d65af8215d7558d70fc2ecbee77dcf
change-id: 20240423-core-scheduling-cookie-b0551c40b086

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


