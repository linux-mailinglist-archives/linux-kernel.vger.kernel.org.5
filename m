Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA66A7A3439
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjIQIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjIQIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB87122;
        Sun, 17 Sep 2023 01:03:15 -0700 (PDT)
Date:   Sun, 17 Sep 2023 08:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694937793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6mMpAoyR+8MIVZ+4TL0f3AT7hwqeokELyjDkr/5sAs=;
        b=jXagHvXer0BdG9WCellwy2GsL/OdKKM/7jzdpohpj1tWRB8iqxEAlfoeqag3FUcduUoitp
        9h7OhCP79Qs3suPN7Riizb3ps1DPi5dwz449NWR/PKFE5f/7k2+LoAH9k1yoSZG5m8RP8j
        IFvSdoACW3ywtWxNilCAWq1HrbQVjKYQV2Lmn7eqhmXoAwNz3o3hIUMRQy26qEBk0M7PSD
        26rs9fDHhs8+xjxqMpFx3YSGrBRPIS/kY8w+4stMyEB+oFA5Ef7XaN8r0ZOgBnsX1XLV/I
        1Na86Pbof0l1rZYquS7WXHKfS8tJT5kmo/A1soCnYpsebOrkOSYKEuSpZUvT8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694937793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6mMpAoyR+8MIVZ+4TL0f3AT7hwqeokELyjDkr/5sAs=;
        b=LghqsqWS9Ig7BVkpUYt5aRCz78r38+TyYMdJv90G8k0TOwmtq3qQLL+C3UrhqwLGLp1AJN
        AdTmg5k84q7PheDA==
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Rework NMI "action" modparam handling
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230916130653.243532-1-hdegoede@redhat.com>
References: <20230916130653.243532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <169493779302.27769.15351598278228262188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ec2f16f180ae65b7c7179b4bb71af5fb2650f036
Gitweb:        https://git.kernel.org/tip/ec2f16f180ae65b7c7179b4bb71af5fb2650f036
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Sat, 16 Sep 2023 15:06:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 17 Sep 2023 09:52:51 +02:00

x86/platform/uv: Rework NMI "action" modparam handling

Rework NMI "action" modparam handling:

 - Replace the uv_nmi_action string with an enum; and
 - Use sysfs_match_string() for string parsing in param_set_action()

No change in functionality intended.

Suggested-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230916130653.243532-1-hdegoede@redhat.com
---
 arch/x86/platform/uv/uv_nmi.c | 104 ++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 47 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 45d0c17..e03207d 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/clocksource.h>
 
 #include <asm/apic.h>
@@ -178,49 +179,56 @@ module_param_named(debug, uv_nmi_debug, int, 0644);
 	} while (0)
 
 /* Valid NMI Actions */
-#define	ACTION_LEN	16
-static struct nmi_action {
-	char	*action;
-	char	*desc;
-} valid_acts[] = {
-	{	"kdump",	"do kernel crash dump"			},
-	{	"dump",		"dump process stack for each cpu"	},
-	{	"ips",		"dump Inst Ptr info for each cpu"	},
-	{	"kdb",		"enter KDB (needs kgdboc= assignment)"	},
-	{	"kgdb",		"enter KGDB (needs gdb target remote)"	},
-	{	"health",	"check if CPUs respond to NMI"		},
+enum action_t {
+	nmi_act_kdump,
+	nmi_act_dump,
+	nmi_act_ips,
+	nmi_act_kdb,
+	nmi_act_kgdb,
+	nmi_act_health,
+	nmi_act_max
 };
-typedef char action_t[ACTION_LEN];
-static action_t uv_nmi_action = { "dump" };
+
+static const char * const actions[nmi_act_max] = {
+	[nmi_act_kdump] = "kdump",
+	[nmi_act_dump] = "dump",
+	[nmi_act_ips] = "ips",
+	[nmi_act_kdb] = "kdb",
+	[nmi_act_kgdb] = "kgdb",
+	[nmi_act_health] = "health",
+};
+
+static const char * const actions_desc[nmi_act_max] = {
+	[nmi_act_kdump] = "do kernel crash dump",
+	[nmi_act_dump] = "dump process stack for each cpu",
+	[nmi_act_ips] = "dump Inst Ptr info for each cpu",
+	[nmi_act_kdb] = "enter KDB (needs kgdboc= assignment)",
+	[nmi_act_kgdb] = "enter KGDB (needs gdb target remote)",
+	[nmi_act_health] = "check if CPUs respond to NMI",
+};
+
+static enum action_t uv_nmi_action = nmi_act_dump;
 
 static int param_get_action(char *buffer, const struct kernel_param *kp)
 {
-	return sprintf(buffer, "%s\n", uv_nmi_action);
+	return sprintf(buffer, "%s\n", actions[uv_nmi_action]);
 }
 
 static int param_set_action(const char *val, const struct kernel_param *kp)
 {
-	int i;
-	int n = ARRAY_SIZE(valid_acts);
-	char arg[ACTION_LEN];
-
-	/* (remove possible '\n') */
-	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
-
-	for (i = 0; i < n; i++)
-		if (!strcmp(arg, valid_acts[i].action))
-			break;
+	int i, n = ARRAY_SIZE(actions);
 
-	if (i < n) {
-		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
-		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
+	i = sysfs_match_string(actions, val);
+	if (i >= 0) {
+		uv_nmi_action = i;
+		pr_info("UV: New NMI action:%s\n", actions[i]);
 		return 0;
 	}
 
-	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
+	pr_err("UV: Invalid NMI action. Valid actions are:\n");
 	for (i = 0; i < n; i++)
-		pr_err("UV: %-8s - %s\n",
-			valid_acts[i].action, valid_acts[i].desc);
+		pr_err("UV: %-8s - %s\n", actions[i], actions_desc[i]);
+
 	return -EINVAL;
 }
 
@@ -228,15 +236,10 @@ static const struct kernel_param_ops param_ops_action = {
 	.get = param_get_action,
 	.set = param_set_action,
 };
-#define param_check_action(name, p) __param_check(name, p, action_t)
+#define param_check_action(name, p) __param_check(name, p, enum action_t)
 
 module_param_named(action, uv_nmi_action, action, 0644);
 
-static inline bool uv_nmi_action_is(const char *action)
-{
-	return (strncmp(uv_nmi_action, action, strlen(action)) == 0);
-}
-
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
@@ -727,10 +730,10 @@ static void uv_nmi_dump_state_cpu(int cpu, struct pt_regs *regs)
 	if (cpu == 0)
 		uv_nmi_dump_cpu_ip_hdr();
 
-	if (current->pid != 0 || !uv_nmi_action_is("ips"))
+	if (current->pid != 0 || uv_nmi_action != nmi_act_ips)
 		uv_nmi_dump_cpu_ip(cpu, regs);
 
-	if (uv_nmi_action_is("dump")) {
+	if (uv_nmi_action == nmi_act_dump) {
 		pr_info("UV:%sNMI process trace for CPU %d\n", dots, cpu);
 		show_regs(regs);
 	}
@@ -798,7 +801,7 @@ static void uv_nmi_dump_state(int cpu, struct pt_regs *regs, int master)
 		int saved_console_loglevel = console_loglevel;
 
 		pr_alert("UV: tracing %s for %d CPUs from CPU %d\n",
-			uv_nmi_action_is("ips") ? "IPs" : "processes",
+			uv_nmi_action == nmi_act_ips ? "IPs" : "processes",
 			atomic_read(&uv_nmi_cpus_in_nmi), cpu);
 
 		console_loglevel = uv_nmi_loglevel;
@@ -874,7 +877,7 @@ static inline int uv_nmi_kdb_reason(void)
 static inline int uv_nmi_kdb_reason(void)
 {
 	/* Ensure user is expecting to attach gdb remote */
-	if (uv_nmi_action_is("kgdb"))
+	if (uv_nmi_action == nmi_act_kgdb)
 		return 0;
 
 	pr_err("UV: NMI error: KDB is not enabled in this kernel\n");
@@ -950,28 +953,35 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 	master = (atomic_read(&uv_nmi_cpu) == cpu);
 
 	/* If NMI action is "kdump", then attempt to do it */
-	if (uv_nmi_action_is("kdump")) {
+	if (uv_nmi_action == nmi_act_kdump) {
 		uv_nmi_kdump(cpu, master, regs);
 
 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
+			uv_nmi_action = nmi_act_dump;
 	}
 
 	/* Pause as all CPU's enter the NMI handler */
 	uv_nmi_wait(master);
 
 	/* Process actions other than "kdump": */
-	if (uv_nmi_action_is("health")) {
+	switch (uv_nmi_action) {
+	case nmi_act_health:
 		uv_nmi_action_health(cpu, regs, master);
-	} else if (uv_nmi_action_is("ips") || uv_nmi_action_is("dump")) {
+		break;
+	case nmi_act_ips:
+	case nmi_act_dump:
 		uv_nmi_dump_state(cpu, regs, master);
-	} else if (uv_nmi_action_is("kdb") || uv_nmi_action_is("kgdb")) {
+		break;
+	case nmi_act_kdb:
+	case nmi_act_kgdb:
 		uv_call_kgdb_kdb(cpu, regs, master);
-	} else {
+		break;
+	default:
 		if (master)
-			pr_alert("UV: unknown NMI action: %s\n", uv_nmi_action);
+			pr_alert("UV: unknown NMI action: %d\n", uv_nmi_action);
 		uv_nmi_sync_exit(master);
+		break;
 	}
 
 	/* Clear per_cpu "in_nmi" flag */
