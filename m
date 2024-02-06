Return-Path: <linux-kernel+bounces-54633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0643384B1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3938F1C23455
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2422812EBD8;
	Tue,  6 Feb 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VC6gUytf"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E512DDA7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213562; cv=none; b=DzIUXSAB5OGNVEvVej2EZWHLflo+3gszDPUs0fCBcPVgynqWJUsX/C6dr+0B297ft44FsjhBOD8u6Yj392Y6mkk4qLjK9mApwHB2mUqge33+EmURN3Ys0aRAKXAOq6Qr/gnioEDYYCLxSbUnLHHN3Ih6jp4HYKTkc7iN+/lG1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213562; c=relaxed/simple;
	bh=lY3UreGu6G+vvfhJz/FqnK6WY0i5hwoDMZGsAleCfxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjYRS3izBHm9rVV605C8+uu5XhEbBwA8xZDJ+EySW9cEaNwimRQEZTObDkS5WEoKZ+4XO/AsY3QK42O0Ri/IS9cRABk6IntunPtwprryV0e9KuD2fBJzPS3PwxxoRUTbZPPO6blY7Q0PIacpL43kUAofZisRFA4jIfoAW5qaFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VC6gUytf; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707213557; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6zRZKE0vH1TwxswhlMHg1RYdvnXr9dlTNvD5V78xCRQ=;
	b=VC6gUytfbuX5/QVx7io51/lrfhgMz97eTODlXW9ayw53PxuySBoWn1wNUl4ILz2ADdyclW9d4SEn7GivFy3rgJyD1xUzaUV3bT3onm6Vm7jeTunnCviiCVUETsMIT1h0IHOFRjsymYmP5+cGCnFe03EYJl6PvdG5UgSPnE7p4VM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0DCVOe_1707213551;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0DCVOe_1707213551)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 17:59:16 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv5 3/3] watchdog/softlockup: add SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob
Date: Tue,  6 Feb 2024 17:59:02 +0800
Message-Id: <20240206095902.56406-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240206095902.56406-1-yaoma@linux.alibaba.com>
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt storm detection mechanism we implemented requires a
considerable amount of global storage space when configured for
the maximum number of CPUs.
Therefore, adding a SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob that
defaults to "yes" if the max number of CPUs is <= 128.

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
---
 kernel/watchdog.c |  2 +-
 lib/Kconfig.debug | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 26dc1ad86276..1595e4a94774 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -338,7 +338,7 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
 
 static void __lockup_detector_cleanup(void);
 
-#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
 #define NUM_STATS_GROUPS	5
 #define NUM_STATS_PER_GROUP	4
 enum stats_per_group {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 975a07f9f1cc..74002ba7c42d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1029,6 +1029,19 @@ config SOFTLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon
 	  detection and the system will stay locked up.
 
+config SOFTLOCKUP_DETECTOR_INTR_STORM
+	bool "Detect Interrupt Storm in Soft Lockups"
+	depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
+	default y if NR_CPUS <= 128
+	help
+	  Say Y here to enable the kernel to detect interrupt storm
+	  during "soft lockups".
+
+	  "soft lockups" can be caused by a variety of reasons. If one is caused by
+	  an interrupt storm, then the storming interrupts will not be on the
+	  callstack. To detect this case, it is necessary to report the CPU stats
+	  and the interrupt counts during the "soft lockups".
+
 config BOOTPARAM_SOFTLOCKUP_PANIC
 	bool "Panic (Reboot) On Soft Lockups"
 	depends on SOFTLOCKUP_DETECTOR
-- 
2.37.1 (Apple Git-137.1)


