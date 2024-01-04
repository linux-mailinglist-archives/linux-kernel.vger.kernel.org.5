Return-Path: <linux-kernel+bounces-16415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D55823E25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70001C20A91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8032208B7;
	Thu,  4 Jan 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mmErWhrp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A488208AA;
	Thu,  4 Jan 2024 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704359169; x=1735895169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PRSjukXkmLIXcwBItHRAGuv5kZcF5d0JPSbYQAMvWf4=;
  b=mmErWhrpZmT5REosIuhZsTGTHwbcrcyDQMJ8Fz0NruuvacYhnJJI2Bkr
   Z9uVQ2/t6wCqOG2Jsr3toPEr/XzcD4JELRIedKwFOR2GOkx7r+5c7Bxg5
   dxPpmPbyxklpKa40pUt7iMIUoQrOz3xbd8KjC94ELMaB1ei6m/tc5GFVP
   s=;
X-IronPort-AV: E=Sophos;i="6.04,330,1695686400"; 
   d="scan'208";a="380164508"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:06:06 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 06DCE803F1;
	Thu,  4 Jan 2024 09:05:57 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:49859]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.3.99:2525] with esmtp (Farcaster)
 id d8b6c571-1e69-4fed-9426-64179444ede8; Thu, 4 Jan 2024 09:05:56 +0000 (UTC)
X-Farcaster-Flow-ID: d8b6c571-1e69-4fed-9426-64179444ede8
Received: from EX19D033EUB001.ant.amazon.com (10.252.61.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:05:56 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D033EUB001.ant.amazon.com (10.252.61.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 4 Jan 2024 09:05:55 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 4 Jan 2024 09:05:54 +0000
From: Jack Allister <jalliste@amazon.com>
To:
CC: Jack Allister <jalliste@amazon.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Paul Durrant <pdurrant@amazon.com>, Jue Wang
	<juew@amazon.com>, Usama Arif <usama.arif@bytedance.com>, Jonathan Corbet
	<corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Paul E. McKenney" <paulmck@kernel.org>, Randy Dunlap
	<rdunlap@infradead.org>, Tejun Heo <tj@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Yan-Jie Wang <yanjiewtw@gmail.com>, Hans de Goede
	<hdegoede@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6] x86: intel_epb: Add earlyparam option to keep bias at performance
Date: Thu, 4 Jan 2024 09:05:48 +0000
Message-ID: <20240104090551.46251-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ff3a0382-734d-4f46-bd35-ffa1f53a3ac3@intel.com>
References: <ff3a0382-734d-4f46-bd35-ffa1f53a3ac3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Buggy BIOSes may not set a sane boot-time Energy Performance Bias (EPB).
A result of this may be overheating or excess power usage. The kernel
overrides any boot-time EPB "performance" bias to "normal" to avoid this.

When used in data centers it is preferable keep the EPB at "performance"
when performing a live-update of the host kernel via a kexec to the new
kernel. This is due to boot-time being critical when performing the kexec
as running guest VMs will perceieve this as latency or downtime.

On Intel Xeon Ice Lake platforms it has been observed that a combination of
EPB being set to "normal" alongside HWP (Intel Hardware P-states) being
enabled/configured during or close to the kexec causes an increases the
live-update/kexec downtime by 7 times compared to when the EPB is set to
"performance".

Introduce a command-line parameter, "intel_epb=preserve", to skip the
"performance" -> "normal" override/workaround. This maintains prior
functionality when no parameter is set, but adds in the ability to stay at
performance for a speedy kexec if a user wishes.

Signed-off-by: Jack Allister <jalliste@amazon.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Cc: Paul Durrant <pdurrant@amazon.com>
Cc: Jue Wang <juew@amazon.com>
Cc: Usama Arif <usama.arif@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++++
 arch/x86/kernel/cpu/intel_epb.c               | 22 +++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..d28f2fc41c0c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2148,6 +2148,15 @@
 			0	disables intel_idle and fall back on acpi_idle.
 			1 to 9	specify maximum depth of C-state.
 
+	intel_epb=	[X86]
+			auto (default)
+			  Work around buggy BIOSes to avoid excess power usage
+			  by forcing the performance bias to "normal" at boot-time.
+			preserve
+			  Do not override the existing performance bias setting.
+			  Useful if a previous kernel or bootloader's setting is
+			  more desirable than "normal".
+
 	intel_pstate=	[X86]
 			disable
 			  Do not enable intel_pstate as the default
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba91321c..01d406177751 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -50,7 +50,8 @@
  * the OS will do that anyway.  That sometimes is problematic, as it may cause
  * the system battery to drain too fast, for example, so it is better to adjust
  * it on CPU bring-up and if the initial EPB value for a given CPU is 0, the
- * kernel changes it to 6 ('normal').
+ * kernel changes it to 6 ('normal'). However, if it is desirable to retain the
+ * original initial EPB value, intel_epb=preserve can be set to enforce it.
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
@@ -213,6 +216,21 @@ static const struct x86_cpu_id intel_epb_normal[] = {
 	{}
 };
 
+static __init int parse_intel_epb(char *str)
+{
+	if (!str)
+		return 0;
+
+	/* "intel_epb=preserve" prevents PERFORMANCE->NORMAL on restore. */
+	if (!strcmp(str, "preserve"))
+		intel_epb_no_override = true;
+
+	/* "intel_epb=auto" not explicitly checked as default behaviour. */
+	return 0;
+}
+
+early_param("intel_epb", parse_intel_epb);
+
 static __init int intel_epb_init(void)
 {
 	const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
-- 
2.40.1


