Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3039803B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjLDRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLDRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:30:07 -0500
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E583
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701711013; x=1733247013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fQvqyzhKNSpH75iOyv0njx6smvL8ePbeR9+sM58QB7c=;
  b=fHewXLSBvrBymwFtXRQxYOpue4DLbsCrrahQnan88K2/wAtI8egyQH+p
   30DjARUDdHNXAmFsXQzX3xhsZkKlSt1RUBEuz7c+gub+M8UnMoVpYkOYo
   jqurDPvP7MIFgJsYQiwWkGjlQRZlkp3nWTeq3BfZsuTEnu0NTzmAQX7xa
   A=;
X-IronPort-AV: E=Sophos;i="6.04,250,1695686400"; 
   d="scan'208";a="48146294"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:30:09 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 0A36F80E0A;
        Mon,  4 Dec 2023 17:30:04 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:51872]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id 5544904f-6150-4258-b571-018841d91ae0; Mon, 4 Dec 2023 17:30:04 +0000 (UTC)
X-Farcaster-Flow-ID: 5544904f-6150-4258-b571-018841d91ae0
Received: from EX19D037UWC002.ant.amazon.com (10.13.139.250) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 4 Dec 2023 17:30:03 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D037UWC002.ant.amazon.com (10.13.139.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 17:30:02 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39 via Frontend Transport; Mon, 4 Dec 2023 17:30:01 +0000
From:   Jack Allister <jalliste@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <rafael@kernel.org>, <len.brown@intel.com>
CC:     Jack Allister <jalliste@amazon.com>,
        Paul Durrant <pdurrant@amazon.com>, Jue Wang <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>, <x86@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: intel_epb: Add earlyparam option to keep bias at performance
Date:   Mon, 4 Dec 2023 17:28:48 +0000
Message-ID: <20231204172849.18753-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
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
 arch/x86/kernel/cpu/intel_epb.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba91321c..0c7dd092f723 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -50,7 +50,8 @@
  * the OS will do that anyway.  That sometimes is problematic, as it may cause
  * the system battery to drain too fast, for example, so it is better to adjust
  * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
- * kernel changes it to 6 ('normal').
+ * kernel changes it to 6 ('normal'). This however is overridable via
+ * intel_epb_keep_performance if required.
  */
 
 static DEFINE_PER_CPU(u8, saved_epb);
@@ -75,6 +76,8 @@ static u8 energ_perf_values[] = {
 	[EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
 };
 
+static bool intel_epb_keep_performance __read_mostly;
+
 static int intel_epb_save(void)
 {
 	u64 epb;
@@ -107,8 +110,12 @@ static void intel_epb_restore(void)
 		 */
 		val = epb & EPB_MASK;
 		if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
-			val = energ_perf_values[EPB_INDEX_NORMAL];
-			pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+			if (!intel_epb_keep_performance) {
+				val = energ_perf_values[EPB_INDEX_NORMAL];
+				pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
+			} else {
+				pr_warn_once("ENERGY_PERF_BIAS: Kept at 'performance', no change\n");
+			}
 		}
 	}
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
@@ -213,6 +220,12 @@ static const struct x86_cpu_id intel_epb_normal[] = {
 	{}
 };
 
+static __init int intel_epb_keep_performance_setup(char *str)
+{
+	return kstrtobool(str, &intel_epb_keep_performance);
+}
+early_param("intel_epb_keep_performance", intel_epb_keep_performance_setup);
+
 static __init int intel_epb_init(void)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
-- 
2.40.1

