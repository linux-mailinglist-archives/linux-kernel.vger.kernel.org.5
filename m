Return-Path: <linux-kernel+bounces-93390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD8872F00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD79B256CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE35BADE;
	Wed,  6 Mar 2024 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DjJtbwI7"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD715171BB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709707771; cv=none; b=cMepSkBfn1PKBMlCVWVbNbcXzBDF8d+tet6zRghw9Z5NuFYw6DL3Di/awmBJEJ8Iekx5FRB6FBH66V76w7LdW99OXVV1sHa9jAkOpBYaX4wTKIShF0ZOcNUJy+2jcdQ1B1iAoByc7rs4J8GNNbhZLMDXlx+hiiAKUgpCvDKTFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709707771; c=relaxed/simple;
	bh=b/nO7us7hYB0VszOCL9lFmQyRWHDXkJW3ruCl9UdwOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ARJVaf1NCjM57bpI4/xYKGEZOxAuL8OJYfjhmAnpgNHNCjH4CvToKHqgO1z1l8ZrXRoSnnIBGakaGzGQ5cRQDNfy+kjoPIAlV41Phq/6ViUZlyNjew1yNNEUS/AhQaRXIJdAYFfUKRZ1MNHZ0FEg7Uzqt5IjnAQzaIyg2RGc4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DjJtbwI7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709707759;
	bh=b/nO7us7hYB0VszOCL9lFmQyRWHDXkJW3ruCl9UdwOA=;
	h=From:Date:Subject:To:Cc:From;
	b=DjJtbwI7qX1cmaKDD+8DUdHUKG/cSgDfs89ru/WHXMucQU9ls8+3ZjQW1zMY3lqfd
	 SNW3aKEtBONLztlr6FrUcTs1uNfAXOrnyGOwEebLk0/2xv3g6kLWhtzNMaJeTIRwUc
	 vBzWutJ1Ah6QjYTHCTstQVWG5k6Nd4voItAJ9iag=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 06 Mar 2024 07:49:16 +0100
Subject: [PATCH] watchdog/core: remove sysctl handlers from public header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-const-sysctl-prep-watchdog-v1-1-bd45da3a41cf@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOsR6GUC/x3MTQqEMAxA4atI1hOotcjoVWQWkkYNSCtN8Qfx7
 pZZfjx4NygnYYW+uiHxLioxFNSfCmgZw8wovhissc40pkWKQTPqpZRX3BJveIyZFh9nnOhL3rf
 OOuqgDEqd5PzPh9/zvB4R6qtsAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709707756; l=3733;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b/nO7us7hYB0VszOCL9lFmQyRWHDXkJW3ruCl9UdwOA=;
 b=qrN/3paDMKoRS//KvwBvwJRR6orfkwT4cD/VQVa3JvfSu0LVX7MLiwVoLBQ146pY0EJ2fmZLZ
 YPGGyH9q3O9BzqhP+kPfj6RXAmftA2eRCBKwqIdeH7jIysbNAjFNeww
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The functions are only used in the file where they are defined.
Remove them from the header and make them static.

Also guard proc_soft_watchdog with a #define-guard as it is not used
otherwise.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/nmi.h |  7 -------
 kernel/watchdog.c   | 22 ++++++++++++----------
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e92e378df000..f53438eae815 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -216,13 +216,6 @@ void watchdog_update_hrtimer_threshold(u64 period);
 static inline void watchdog_update_hrtimer_threshold(u64 period) { }
 #endif
 
-struct ctl_table;
-int proc_watchdog(struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_nmi_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_soft_watchdog(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_watchdog_thresh(struct ctl_table *, int , void *, size_t *, loff_t *);
-int proc_watchdog_cpumask(struct ctl_table *, int, void *, size_t *, loff_t *);
-
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
 #endif
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 81a8862295d6..d7b2125503af 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -796,8 +796,8 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-int proc_watchdog(struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_watchdog(struct ctl_table *table, int write,
+			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
 				    WATCHDOG_SOFTOCKUP_ENABLED,
@@ -807,8 +807,8 @@ int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-int proc_nmi_watchdog(struct ctl_table *table, int write,
-		      void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_nmi_watchdog(struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
 		return -ENOTSUPP;
@@ -816,21 +816,23 @@ int proc_nmi_watchdog(struct ctl_table *table, int write,
 				    table, write, buffer, lenp, ppos);
 }
 
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-int proc_soft_watchdog(struct ctl_table *table, int write,
-			void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_soft_watchdog(struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
 				    table, write, buffer, lenp, ppos);
 }
+#endif
 
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-int proc_watchdog_thresh(struct ctl_table *table, int write,
-			 void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_watchdog_thresh(struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
 
@@ -852,8 +854,8 @@ int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-int proc_watchdog_cpumask(struct ctl_table *table, int write,
-			  void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_watchdog_cpumask(struct ctl_table *table, int write,
+				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;
 

---
base-commit: 5847c9777c303a792202c609bd761dceb60f4eed
change-id: 20240306-const-sysctl-prep-watchdog-fc8cdd6424c9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


