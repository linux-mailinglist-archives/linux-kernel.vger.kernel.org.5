Return-Path: <linux-kernel+bounces-51735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6B848EB0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A52835CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FD249E8;
	Sun,  4 Feb 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oPEUsN4s"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC582263E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058335; cv=none; b=CfyoSEZyiW5I+M9WpmkfAQ1lfCp1YZkCoYGc22MHFJ0PyTpTNJ+Mp4dZsxFbBFZE9X7iWh+9/n0tKkCQ9BKo2xww0WSXoNu+jtMrN6A8lB+wcI2FA+4aGBqsb/tk1ar8ML9MpmA6NEZ70ZTm8gYwfugi3x2zHxmkhXkvpFwynTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058335; c=relaxed/simple;
	bh=7Law9ljRW3QDm/qpuBOMmG+RDf0WSd4kRpeuwMpabF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tb1EegmXYam3iLRl1x1haKOMd8Xqn5OZLsGWU4CzNFdfCQWLgGbyerA4xxSZs0ZG3rwa5rKYfiHnUOEZVTHFunRMB8lu6JOAMbnj5KrzE9UDzOgBmVINPzt4VNPw6L2lOoNPk9PMsgNPIP2XiqfVzBS1jBkoCxtc+Aqk/U2DMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oPEUsN4s; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707058326; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1aIE2l+wx3ThQkg4ZY8lGbbMkz4SlO/OXHAps4v7kP4=;
	b=oPEUsN4srA5CQWQd315Ixz5iZVulFIZ8b7PzMPHblmH7wJxtvl3wcFTcxwduAd1TTEj9FSnS/Lr4fZmmH9sSLatdQvIYSRVVlvA/URIZi8E7el3P7yDrH57b+EF42B1uzHRqC7r3QxnFrQu+jA092k9hWGoybRd8awQcD97lf0Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W00xP-z_1707058323;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W00xP-z_1707058323)
          by smtp.aliyun-inc.com;
          Sun, 04 Feb 2024 22:52:06 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv4 3/3] watchdog/softlockup: add SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob
Date: Sun,  4 Feb 2024 22:51:54 +0800
Message-Id: <20240204145154.11069-4-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20240204145154.11069-1-yaoma@linux.alibaba.com>
References: <20240204145154.11069-1-yaoma@linux.alibaba.com>
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
index d31120c3e9d1..a2722935a381 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -338,7 +338,7 @@ __setup("watchdog_thresh=", watchdog_thresh_setup);
 
 static void __lockup_detector_cleanup(void);
 
-#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
 #define NUM_STATS_GROUPS	5
 enum stats_per_group {
 	STATS_SYSTEM,
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


