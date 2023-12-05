Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290458055C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442158AbjLENYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjLENX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:23:59 -0500
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76511AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701782646; x=1733318646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zngyCLs919oe0BSu6dF3WRfqoVmoP9Zc74naBRwpoKw=;
  b=VPX0TOOtEWtZ5MtN4XoZkfJBuSF7SFpuxGxTCi5HeeIXzeLcQQVjKBXd
   4staQ+7V8dKP/HfrthauN+ZYIVRmwk1iCRDdoBhLManI4/BW8wLMOV9Aa
   9o8LBfTZFTP5h1dOo/9vzRdYVAr+4obJ49xkgdRC+E5pa2zft3eivhmXC
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,252,1695686400"; 
   d="scan'208";a="374236312"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:24:03 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id D440E40D7D;
        Tue,  5 Dec 2023 13:24:01 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:25120]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.224:2525] with esmtp (Farcaster)
 id 8e3c481d-2cdf-4384-85b3-1ed52c5be55a; Tue, 5 Dec 2023 13:24:01 +0000 (UTC)
X-Farcaster-Flow-ID: 8e3c481d-2cdf-4384-85b3-1ed52c5be55a
Received: from EX19D037UWC001.ant.amazon.com (10.13.139.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 13:24:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D037UWC001.ant.amazon.com (10.13.139.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Dec 2023 13:24:00 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 5 Dec 2023 13:23:58 +0000
From:   Jack Allister <jalliste@amazon.com>
To:     <jalliste@amazon.com>
CC:     Paul Durrant <pdurrant@amazon.com>, Jue Wang <juew@amazon.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86: intel_epb: Add earlyparam option to keep bias at performance
Date:   Tue, 5 Dec 2023 13:23:54 +0000
Message-ID: <20231205132355.76306-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205131359.66338-1-jalliste@amazon.com>
References: <20231205131359.66338-1-jalliste@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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

This patch introduces a kernel command line "intel_epb_no_override"
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

Sorry it looks like I had missed the v2 flag from the subject, also the
commit message did not include the correct rename compared to v1.

This should all be fixed in v3 now.
