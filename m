Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0079F0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjIMSCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3385019AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694628085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q6i31kdPNVz2CcylcU0YqxIfavYRU5SffpbaRRY0/L4=;
        b=LRfs7Bzrh+7rjhGm7b2aHxuFquE+PEhzvFztT7Zwejtfo/SzQYM+g6+CYSWXk1X/25B89x
        FNeWdiWLbUV/Qw5OWoj9NWhoZS3bJL1TlpDxJShYLLQ6no22TZT2DW94nO20P/CYzOVclB
        UR+eicZtA6xBTR0X9TJFKBaFTfkTjwQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-cLQ3GeOMMR-WZg_i5JKMJA-1; Wed, 13 Sep 2023 14:01:23 -0400
X-MC-Unique: cLQ3GeOMMR-WZg_i5JKMJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DADCE805B32;
        Wed, 13 Sep 2023 18:01:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C8212904;
        Wed, 13 Sep 2023 18:01:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
Date:   Wed, 13 Sep 2023 20:01:11 +0200
Message-ID: <20230913180111.85397-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework NMI "action" modparam handling:

1. Replace the uv_nmi_action string with an enum; and
2. Use sysfs_match_string() for string parsing in param_set_action()

Suggested-by: Steve Wahl <steve.wahl@hpe.com>
Cc: Justin Stitt <justinstitt@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Also change uv_nmi_action to an enum to replace a bunch of
  strcmp() calls
---
 arch/x86/platform/uv/uv_nmi.c | 104 +++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 47 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 45d0c17ce77c..b92f1b4adeb0 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -178,49 +178,57 @@ module_param_named(debug, uv_nmi_debug, int, 0644);
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
 };
-typedef char action_t[ACTION_LEN];
-static action_t uv_nmi_action = { "dump" };
+
+static const char * const actions[] = {
+	[nmi_act_kdump] = "kdump",
+	[nmi_act_dump] = "dump",
+	[nmi_act_ips] = "ips",
+	[nmi_act_kdb] = "kdb",
+	[nmi_act_kgdb] = "kgdb",
+	[nmi_act_health] = "health",
+};
+
+static const char * const actions_desc[] = {
+	[nmi_act_kdump] = "do kernel crash dump",
+	[nmi_act_dump] = "dump process stack for each cpu",
+	[nmi_act_ips] = "dump Inst Ptr info for each cpu",
+	[nmi_act_kdb] = "enter KDB (needs kgdboc= assignment)",
+	[nmi_act_kgdb] = "enter KGDB (needs gdb target remote)",
+	[nmi_act_health] = "check if CPUs respond to NMI",
+};
+
+static_assert(ARRAY_SIZE(actions) == ARRAY_SIZE(actions_desc));
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
+	int i, n = ARRAY_SIZE(actions);
 
-	/* (remove possible '\n') */
-	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
-
-	for (i = 0; i < n; i++)
-		if (!strcmp(arg, valid_acts[i].action))
-			break;
-
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
+	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
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
-- 
2.41.0

