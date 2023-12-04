Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC08802C64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjLDHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjLDHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D46FF;
        Sun,  3 Dec 2023 23:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676351;
        bh=jiUoP9EILBqjXJdhjCd6wCOIBwbA+1GPrmYgkgR4m/M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YZPlhHxEX6oI7g8G2LKXf/0qWZsZyCVOccYQzag5Ib0JfOmdslPSqC02Lm5IVfa3V
         NfYWDXaB1wpUtcwFKNl/iui8AG1y0biZQzCEo/kstXkAPmgY865s0R0m17Uq6kJPoA
         5Hhw+R4gLkxRIE/ks80cNBL7k4qMXjau4nE8joP4=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:14 +0100
Subject: [PATCH v2 01/18] watchdog/core: remove sysctl handlers from public
 header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-1-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=3077;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jiUoP9EILBqjXJdhjCd6wCOIBwbA+1GPrmYgkgR4m/M=;
 b=N668jhYnDq/m98yRu3KJUDGYvbbTXjPausZ1wtJee7HDZsf73TfhAf+uRsaSar7Bl1MjM4b1f
 y4xDB12U1prASWAMR2lxo2BG40azT17eSnNK1xvNxwTk7wvRe1prpvc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions are only used in the file where they are defined.
Remove them from the header and make them static.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/nmi.h |  7 -------
 kernel/watchdog.c   | 10 +++++-----
 2 files changed, 5 insertions(+), 12 deletions(-)

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
index 5cd6d4e26915..0fe72e89627d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -772,7 +772,7 @@ static int proc_watchdog_common(int which, struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog
  */
-int proc_watchdog(struct ctl_table *table, int write,
+static int proc_watchdog(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_HARDLOCKUP_ENABLED |
@@ -783,7 +783,7 @@ int proc_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/nmi_watchdog
  */
-int proc_nmi_watchdog(struct ctl_table *table, int write,
+static int proc_nmi_watchdog(struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	if (!watchdog_hardlockup_available && write)
@@ -795,7 +795,7 @@ int proc_nmi_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/soft_watchdog
  */
-int proc_soft_watchdog(struct ctl_table *table, int write,
+static int proc_soft_watchdog(struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_watchdog_common(WATCHDOG_SOFTOCKUP_ENABLED,
@@ -805,7 +805,7 @@ int proc_soft_watchdog(struct ctl_table *table, int write,
 /*
  * /proc/sys/kernel/watchdog_thresh
  */
-int proc_watchdog_thresh(struct ctl_table *table, int write,
+static int proc_watchdog_thresh(struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err, old;
@@ -828,7 +828,7 @@ int proc_watchdog_thresh(struct ctl_table *table, int write,
  * user to specify a mask that will include cpus that have not yet
  * been brought online, if desired.
  */
-int proc_watchdog_cpumask(struct ctl_table *table, int write,
+static int proc_watchdog_cpumask(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err;

-- 
2.43.0

