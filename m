Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F81776972
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjHIUFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjHIUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:05:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02310D4;
        Wed,  9 Aug 2023 13:05:02 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:05:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfwImcTI7YaZYZrzmlihZWVOTd+VrMC3wiA0U3w+xDg=;
        b=g02pWa5rGxq/IhPWRz5L5ginA7VzCbT5kMA6ml4aKruJfyPUO5IVwevFZUM0MiJQy7EKOz
        0EInhxfs35m4cl1A6E8cHCPUUgnh0xDPEgpoG/P+sP8/JCYG/bIfgHF8LuYj5ovPOtkclB
        lDHriQcjdf+5Zdno2JVQ3wEcac3C9f+NbwFItBcnYVhJNxswBC2ezKQJPJx0AUP+P5Iovm
        n4ImEQWufpCbZHnkwUzwwZb+IUKCLqS3iIsfol2Xca2h8tcUyl4j0jvobA+HQORrqjVqjP
        d/ZbKtwQlXnA4MNGgZf350HKu8qkfdImvKiq3H8sIsPuvLNNNmJgSxO2knn6lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfwImcTI7YaZYZrzmlihZWVOTd+VrMC3wiA0U3w+xDg=;
        b=SGWljJYDSoa0ShuDlRHzeOMG35gvbEfXvvegN45Tl1jO/i/7tkYZLaD41/wEnA0zcyewWW
        idgxnEOyBSdsTqBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Fix Crestmont uarch
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807150405.757666627@infradead.org>
References: <20230807150405.757666627@infradead.org>
MIME-Version: 1.0
Message-ID: <169161150022.27769.13986653864659019340.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0cfd8fbadd6833d243c9a9d8649ba4a9f4361c93
Gitweb:        https://git.kernel.org/tip/0cfd8fbadd6833d243c9a9d8649ba4a9f4361c93
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 07 Aug 2023 14:38:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Aug 2023 21:51:06 +02:00

x86/cpu: Fix Crestmont uarch

Sierra Forest and Grand Ridge are both E-core only using Crestmont
micro-architecture, They fit the pre-existing naming scheme prefectly
fine, adhere to it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230807150405.757666627@infradead.org
---
 arch/x86/include/asm/intel-family.h                         | 5 ++---
 drivers/edac/i10nm_base.c                                   | 2 +-
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 4041326..49d40ee 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -155,9 +155,8 @@
 
 #define INTEL_FAM6_ATOM_GRACEMONT	0xBE /* Alderlake N */
 
-#define INTEL_FAM6_SIERRAFOREST_X	0xAF
-
-#define INTEL_FAM6_GRANDRIDGE		0xB6
+#define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
+#define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
 /* Xeon Phi */
 
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a897b6a..5abf997 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -906,7 +906,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SIERRAFOREST_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1f59ac5..47e5a94 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -720,7 +720,7 @@ static struct miscdevice isst_if_char_driver = {
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SIERRAFOREST_X,	NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
 };
 
