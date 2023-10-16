Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40597CA488
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjJPJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:51:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A569C;
        Mon, 16 Oct 2023 02:51:44 -0700 (PDT)
Date:   Mon, 16 Oct 2023 09:51:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697449903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR8Xw0VKdm5ZQEx6TOBC00k7PmZ+VxoOGHDSFsEhUTg=;
        b=UQQ1UDKq1BLou1Kv4sRfDPM7j1vFBNWor8254w+F4C1YkYwITSxVPsBsCQL1oP60KQvBR4
        vtcTnea49tG63rd4aF9E5iKtppQJtNwU+HEjcNdgv6hlMhAQQrp8gv9Nkdfu+qf/nSPnkm
        ZFuhAfOvWgRPVHjZaSEkUSZEkvfHvZW7jnqUZu3hUvWYnfrwnHFD9cQfoctsemXk9Thb9E
        C4qAUGwe1LON50q0jdQZSF9ZxervWRZIVF604CThQDjDjWyTHdzz0VqixQCOR3yI6H9Ze1
        7lSuZcqiekIw9OAJ8tZyg1dsMvhIYbdwlGUdFhX8LgXvhuVhIM3Rf8i8DRTddw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697449903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZR8Xw0VKdm5ZQEx6TOBC00k7PmZ+VxoOGHDSFsEhUTg=;
        b=nfeHsiOHPviRCjMr4jdvphs9o1idBB3MqukMmqRWLSauSjZ8TNsTqP5lJW2qxRCNNP2sP0
        PYu2lt2G/+ceFeBg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Pass through error code for
 initialization failures, instead of -ENODEV
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231016060743.332051-1-sandipan.das@amd.com>
References: <20231016060743.332051-1-sandipan.das@amd.com>
MIME-Version: 1.0
Message-ID: <169744990239.3135.3791356843221893982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
Gitweb:        https://git.kernel.org/tip/744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 16 Oct 2023 11:37:43 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 16 Oct 2023 11:42:01 +02:00

perf/x86/amd/uncore: Pass through error code for initialization failures, instead of -ENODEV

Pass through the appropriate error code when the registration of hotplug
callbacks fail during initialization, instead of returning a blanket -ENODEV.

[ mingo: Updated the changelog. ]

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231016060743.332051-1-sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a389828..4429eac 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1040,20 +1040,25 @@ static int __init amd_uncore_init(void)
 	/*
 	 * Install callbacks. Core will call them for each online cpu.
 	 */
-	if (cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
-			      "perf/x86/amd/uncore:prepare",
-			      NULL, amd_uncore_cpu_dead))
+	ret = cpuhp_setup_state(CPUHP_PERF_X86_AMD_UNCORE_PREP,
+				"perf/x86/amd/uncore:prepare",
+				NULL, amd_uncore_cpu_dead);
+	if (ret)
 		goto fail;
 
-	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
-			      "perf/x86/amd/uncore:starting",
-			      amd_uncore_cpu_starting, NULL))
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
+				"perf/x86/amd/uncore:starting",
+				amd_uncore_cpu_starting, NULL);
+	if (ret)
 		goto fail_prep;
-	if (cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
-			      "perf/x86/amd/uncore:online",
-			      amd_uncore_cpu_online,
-			      amd_uncore_cpu_down_prepare))
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
+				"perf/x86/amd/uncore:online",
+				amd_uncore_cpu_online,
+				amd_uncore_cpu_down_prepare);
+	if (ret)
 		goto fail_start;
+
 	return 0;
 
 fail_start:
