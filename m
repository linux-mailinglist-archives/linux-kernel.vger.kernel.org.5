Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AE805599
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjLENOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjLENOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:14:06 -0500
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071ED120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701782052; x=1733318052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSJlca4xBejtCeIUqyK0VgdZ900slw7mcW1vqgZbHNw=;
  b=s8mjyu65S2U1fhMw4R5qQwN9TwaWRw5FV2zk6QYqqNGtSdHFQtb2lWDu
   wXMHPVtH4CWjemRFiduZaHCsbh8vaeYYO7hIwbpIitxwkBnmN2V7DMAxV
   YWRr20g3AFvbMIdwi7sUOhtewPNUy3YOdapGEaR27dT2LvN3kdgsEP7ZM
   M=;
X-IronPort-AV: E=Sophos;i="6.04,252,1695686400"; 
   d="scan'208";a="623364236"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:14:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 0F9E4812FF;
        Tue,  5 Dec 2023 13:14:06 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:14418]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.84:2525] with esmtp (Farcaster)
 id 7fe427f2-f048-42ad-b344-5ae159f3585f; Tue, 5 Dec 2023 13:14:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7fe427f2-f048-42ad-b344-5ae159f3585f
Received: from EX19D032EUB002.ant.amazon.com (10.252.61.47) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 13:14:05 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D032EUB002.ant.amazon.com (10.252.61.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 13:14:05 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39 via Frontend Transport; Tue, 5 Dec 2023 13:14:03 +0000
From:   Jack Allister <jalliste@amazon.com>
To:     <rafael@kernel.org>
CC:     Jack Allister <jalliste@amazon.com>,
        Paul Durrant <pdurrant@amazon.com>, Jue Wang <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
Date:   Tue, 5 Dec 2023 13:13:57 +0000
Message-ID: <20231205131359.66338-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAJZ5v0izUiGa2rU_8Oiygj40434Bvr2tooUqOpyUBRrM4BekeA@mail.gmail.com>
References: <CAJZ5v0izUiGa2rU_8Oiygj40434Bvr2tooUqOpyUBRrM4BekeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain scenarios where it may be intentional that the EPB was
set at to 0/ENERGY_PERF_BIAS_PERFORMANCE on kernel boot. For example, in
data centers a kexec/live-update of the kernel may be performed regularly.

Usually this live-update is time critical and defaulting of the bias back
to ENERGY_PERF_BIAS_NORMAL may actually be detrimental to the overall
update time if processors' time to ramp up/boost are affected.

This patch introduces a kernel command line "intel_epb_keep_performance"
which will leave the EPB at performance if during the restoration code path
it is detected as such.

Signed-off-by: Jack Allister <jalliste@amazon.com>
Cc: Paul Durrant <pdurrant@amazon.com>
Cc: Jue Wang <juew@amazon.com>
Cc: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/cpu/intel_epb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba91321c..cbe0e224b8d9 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -50,7 +50,8 @@
  * the OS will do that anyway.  That sometimes is problematic, as it may cause
  * the system battery to drain too fast, for example, so it is better to adjust
  * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
- * kernel changes it to 6 ('normal').
+ * kernel changes it to 6 ('normal'). This however is overridable via
+ * intel_epb_no_override if required.
  */
 
 static DEFINE_PER_CPU(u8, saved_epb);
@@ -75,6 +76,8 @@ static u8 energ_perf_values[] = {
 	[EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
 };
 
+static bool intel_epb_no_override __read_mostly;
+
 static int intel_epb_save(void)
 {
 	u64 epb;
@@ -106,7 +109,7 @@ static void intel_epb_restore(void)
 		 * ('normal').
 		 */
 		val = epb & EPB_MASK;
-		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
+		if (!intel_epb_no_override && val == ENERGY_PERF_BIAS_PERFORMANCE) {
 			val = energ_perf_values[EPB_INDEX_NORMAL];
 			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
 		}
@@ -213,6 +216,12 @@ static const struct x86_cpu_id intel_epb_normal[] = {
 	{}
 };
 
+static __init int intel_epb_no_override_setup(char *str)
+{
+	return kstrtobool(str, &intel_epb_no_override);
+}
+early_param("intel_epb_no_override", intel_epb_no_override_setup);
+
 static __init int intel_epb_init(void)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
-- 
2.40.1

