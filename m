Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123037F8AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjKYMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjKYMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:52:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C34EA;
        Sat, 25 Nov 2023 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1700916777;
        bh=eBhOR2st0kYur9zVJzF7EyOPAu0FRzljdghuY8XBOWo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ruCv9eFB2WE77RMf3vbBpk3bVkniSFw8IzlWE7Fz17sBjZveEjpMX/8aQzd/joQC4
         GZXSqv+GOalkDZJhIn4RnxKmGIpU6yxvpQLSJ/+T1d7/sNmHooD6FNhIAtqRE6DJin
         cl4L4Ub8SOMaXprr1Hvc8BN9KOB6cNfx/dSGUBMM=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 25 Nov 2023 13:52:55 +0100
Subject: [PATCH RFC 6/7] treewide: sysctl: migrate proc_dobool to
 proc_handler_new
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231125-const-sysctl-v1-6-5e881b0e0290@weissschuh.net>
References: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
In-Reply-To: <20231125-const-sysctl-v1-0-5e881b0e0290@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700916776; l=4649;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eBhOR2st0kYur9zVJzF7EyOPAu0FRzljdghuY8XBOWo=;
 b=TFErwepsPpof08h6PaKYFgDvwr7V8L6MNxWawrT6FywU47nmnGgngRZWo7O9VIC6e33pJRYvE
 Sbzhxjkb1MYBkiG8Yh7Iyu7dSbhzCyWNshcdo390tV38npbE01v1uDT
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

proc_handler_new() prevents the handler function from modifying the
ctl_table which then can be put into .rodata.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/riscv/kernel/vector.c | 2 +-
 drivers/tty/tty_io.c       | 2 +-
 fs/lockd/svc.c             | 2 +-
 fs/proc/proc_sysctl.c      | 4 ++--
 include/linux/sysctl.h     | 2 +-
 kernel/sysctl.c            | 4 ++--
 mm/hugetlb_vmemmap.c       | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 578b6292487e..d2a37fe88174 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -253,7 +253,7 @@ static struct ctl_table riscv_v_default_vstate_table[] = {
 		.data		= &riscv_v_implicit_uacc,
 		.maxlen		= sizeof(riscv_v_implicit_uacc),
 		.mode		= 0644,
-		.proc_handler	= proc_dobool,
+		.proc_handler_new	= proc_dobool,
 	},
 };
 
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 06414e43e0b5..a7bcc22fdae9 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3601,7 +3601,7 @@ static struct ctl_table tty_table[] = {
 		.data		= &tty_legacy_tiocsti,
 		.maxlen		= sizeof(tty_legacy_tiocsti),
 		.mode		= 0644,
-		.proc_handler	= proc_dobool,
+		.proc_handler_new	= proc_dobool,
 	},
 	{
 		.procname	= "ldisc_autoload",
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 81be07c1d3d1..90ea8cd382d3 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -466,7 +466,7 @@ static struct ctl_table nlm_sysctls[] = {
 		.data		= &nsm_use_hostnames,
 		.maxlen		= sizeof(bool),
 		.mode		= 0644,
-		.proc_handler	= proc_dobool,
+		.proc_handler_new	= proc_dobool,
 	},
 	{
 		.procname	= "nsm_local_state",
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 0817d315fa36..742a99540f2b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1119,7 +1119,7 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 			err |= sysctl_err(path, table, "array not allowed");
 	}
 
-	if (table->proc_handler == proc_dobool) {
+	if (table->proc_handler_new == proc_dobool) {
 		if (table->maxlen != sizeof(bool))
 			err |= sysctl_err(path, table, "array not allowed");
 	}
@@ -1133,7 +1133,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler_new == proc_dostring) ||
-		    (entry->proc_handler == proc_dobool) ||
+		    (entry->proc_handler_new == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
 		    (entry->proc_handler == proc_douintvec) ||
 		    (entry->proc_handler == proc_douintvec_minmax) ||
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2699605c5da5..2dfaf718a21b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -67,7 +67,7 @@ typedef int proc_handler_new(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 
 int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dobool(struct ctl_table *table, int write, void *buffer,
+int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 int proc_dointvec(struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec(struct ctl_table *, int, void *, size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7acd1cde0a5c..c76668f47bcc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -702,7 +702,7 @@ int do_proc_douintvec(struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dobool(struct ctl_table *table, int write, void *buffer,
+int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
@@ -1504,7 +1504,7 @@ int proc_dostring(const struct ctl_table *table, int write,
 	return -ENOSYS;
 }
 
-int proc_dobool(struct ctl_table *table, int write,
+int proc_dobool(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 87818ee7f01d..e61e9fbfd639 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -779,7 +779,7 @@ static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 		.data		= &vmemmap_optimize_enabled,
 		.maxlen		= sizeof(vmemmap_optimize_enabled),
 		.mode		= 0644,
-		.proc_handler	= proc_dobool,
+		.proc_handler_new	= proc_dobool,
 	},
 	{ }
 };

-- 
2.43.0

