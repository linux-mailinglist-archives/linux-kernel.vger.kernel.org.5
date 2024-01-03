Return-Path: <linux-kernel+bounces-15664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8642822FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520D21F23EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CD1A703;
	Wed,  3 Jan 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OKle+6Yq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B041A5B6;
	Wed,  3 Jan 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704293184; x=1735829184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qMGObbzevwrsqS9R/lsiIBQqNq1KVLRx8f7pbsk2p24=;
  b=OKle+6YqiH82tixAKYSUOhrOWx3fTevYshm2u5jh38kzzHfGlrdhiu+C
   iAt1jFReDMNd1r2KtGyOHqXXevdcRMf7+PAzo4Jy7gTGUXWMFo8Y3EfYp
   YTLW64I6m9M6HX7tWMT7PjKgk1H09FkI6yVbfaMypGlhD4iKlM4jJU3Ty
   k=;
X-IronPort-AV: E=Sophos;i="6.04,327,1695686400"; 
   d="scan'208";a="263423795"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:46:22 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id E2E8660A99;
	Wed,  3 Jan 2024 14:46:20 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:30180]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.243:2525] with esmtp (Farcaster)
 id f9054cef-49b7-484a-b648-0b1e618e9049; Wed, 3 Jan 2024 14:46:19 +0000 (UTC)
X-Farcaster-Flow-ID: f9054cef-49b7-484a-b648-0b1e618e9049
Received: from EX19D033EUB004.ant.amazon.com (10.252.61.103) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 14:46:19 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D033EUB004.ant.amazon.com (10.252.61.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 14:46:19 +0000
Received: from dev-dsk-jalliste-1c-e3349c3e.eu-west-1.amazon.com
 (10.13.244.142) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Wed, 3 Jan 2024 14:46:17 +0000
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
Subject: [PATCH v5] x86: intel_epb: Add earlyparam option to keep bias at performance
Date: Wed, 3 Jan 2024 14:46:04 +0000
Message-ID: <20240103144607.46369-1-jalliste@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <83431857-7182-471a-9ff1-9dac37e5a02f@intel.com>
References: <83431857-7182-471a-9ff1-9dac37e5a02f@intel.com>
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
 .../admin-guide/kernel-parameters.txt         | 12 +++++++++++
 arch/x86/kernel/cpu/intel_epb.c               | 21 +++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..5602ee213115 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2148,6 +2148,18 @@
 			0	disables intel_idle and fall back on acpi_idle.
 			1 to 9	specify maximum depth of C-state.
 
+	intel_epb=	[X86]
+			auto
+			  Same as not passing a parameter to intel_epb. This will
+			  ensure that the intel_epb module will restore the energy
+			  performance bias to "normal" at boot-time. This workaround
+			  is for buggy BIOSes which may not set this value and cause
+			  either overheating or excess power usage.
+			preserve
+			  At kernel boot-time if the EPB value is read as "performance"
+			  keep it at this value. This prevents the "performance" -> "normal"
+			  transition which is a workaround mentioned above.
+
 	intel_pstate=	[X86]
 			disable
 			  Do not enable intel_pstate as the default
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index e4c3ba91321c..419e699a43e6 100644
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
@@ -213,6 +216,20 @@ static const struct x86_cpu_id intel_epb_normal[] = {
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


