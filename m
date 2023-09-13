Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D6C79EC70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbjIMPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbjIMPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC31A1BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wA/deTDyR3rOGKniPdSBTa4tEgxl+2pJ7p2k7fGC+MM=;
        b=UHyQObB5uN70NcUdT/JUDnxMgL69vU7HH4u8eXzLRLT9jzQw0j0p/KOigKkjG2Oar+2rwS
        jqr6rHfnuLAd+vG0iS1CkyS3C2ScoJIB6X3qqKOOVJ1qKhI7hZu3effHF3jlimt0QGifju
        77boq91JtQFalJWg3ZL4+WzM0CbJlvE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-GaVubWuIPveFiQ1f0tTftQ-1; Wed, 13 Sep 2023 11:17:05 -0400
X-MC-Unique: GaVubWuIPveFiQ1f0tTftQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6441E18056B4;
        Wed, 13 Sep 2023 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1204E40C2009;
        Wed, 13 Sep 2023 15:17:01 +0000 (UTC)
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
Subject: [PATCH] x86/platform/uv: Use sysfs_match_string() for string parsing in param_set_action()
Date:   Wed, 13 Sep 2023 17:16:56 +0200
Message-ID: <20230913151656.52792-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the custom, hard to read code to:

1. Make a copy of "val" with any potential '\n' at the end stripped
2. Compare the copy against an array of allowed string values

Linux has the sysfs_match_string() helper exactly for cases like this,
switch to this.

Cc: Justin Stitt <justinstitt@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/platform/uv/uv_nmi.c | 48 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 45d0c17ce77c..44bacb547c65 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -179,17 +179,27 @@ module_param_named(debug, uv_nmi_debug, int, 0644);
 
 /* Valid NMI Actions */
 #define	ACTION_LEN	16
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
+
+static const char * const valid_acts[] = {
+	"kdump",
+	"dump",
+	"ips",
+	"kdb",
+	"kgdb",
+	"health",
 };
+
+static const char * const valid_acts_desc[] = {
+	"do kernel crash dump",
+	"dump process stack for each cpu",
+	"dump Inst Ptr info for each cpu",
+	"enter KDB (needs kgdboc= assignment)",
+	"enter KGDB (needs gdb target remote)",
+	"check if CPUs respond to NMI",
+};
+
+static_assert(ARRAY_SIZE(valid_acts) == ARRAY_SIZE(valid_acts_desc));
+
 typedef char action_t[ACTION_LEN];
 static action_t uv_nmi_action = { "dump" };
 
@@ -202,25 +212,19 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 {
 	int i;
 	int n = ARRAY_SIZE(valid_acts);
-	char arg[ACTION_LEN];
 
-	/* (remove possible '\n') */
-	strscpy(arg, val, strnchrnul(val, sizeof(arg)-1, '\n') - val + 1);
+	i = sysfs_match_string(valid_acts, val);
 
-	for (i = 0; i < n; i++)
-		if (!strcmp(arg, valid_acts[i].action))
-			break;
-
-	if (i < n) {
-		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
+	if (i >= 0) {
+		strscpy(uv_nmi_action, valid_acts[i], sizeof(uv_nmi_action));
 		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
 		return 0;
 	}
 
-	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
+	pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
 	for (i = 0; i < n; i++)
-		pr_err("UV: %-8s - %s\n",
-			valid_acts[i].action, valid_acts[i].desc);
+		pr_err("UV: %-8s - %s\n", valid_acts[i], valid_acts_desc[i]);
+
 	return -EINVAL;
 }
 
-- 
2.41.0

