Return-Path: <linux-kernel+bounces-140683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE58A17B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3212D1F219B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7F17C9E;
	Thu, 11 Apr 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="QRXz7/pD"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFBF17C61
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846620; cv=none; b=ufGraQMkjWBspWDSJwCZ0pPKpuiT++N1y077mH+T84fiU1onNcVjmt9jtztI+D5aPWxwCSBvEoZIx5a9U1SJicN1IV7GbKWz1SuaSbav3uhdSfNexdowGLgwXuTRY0KnrZqe3fj6DPmnA4UIvzUznEJnn5hQZ2B+tp0bdzrP13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846620; c=relaxed/simple;
	bh=5dwBI9khdYJeiWpel/yUUnsS8SPNZ9Fqg7qfToEvfZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAzqq4W8tIhCccDHB1m9WDtn7CVDo2Koq+9+pzjxN0wMYhc7ZMbRMONiJJg2hLHVTGbBvzs++mYa7l2tY63BzJw2XrgOHtPSAi+P2+6BzMvY+0Ne4a+n/NV4T85NR4Qggi1HuI9BWNtaUSneV3Pq7r5bmirWgoay8XQTH3UxURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=QRXz7/pD; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712846615;
	bh=5dwBI9khdYJeiWpel/yUUnsS8SPNZ9Fqg7qfToEvfZY=;
	h=From:To:Cc:Subject:Date:From;
	b=QRXz7/pDt/jVzuDcjihSy6iw0ML9j0uiHYjKbmGJq9JXtHn2NYOSBi2MnKsCASoya
	 uxcIWQvnh6Bet0wMOs8zc0vVoKlnrjcUuT4BEJzeE4Y7z0nBOQTXoB98ugqcpU+Kmp
	 QE/5myHeUWrEQS0pV7PTDYmgLnq/5rRLIDd7w/Dk=
Received: from stargazer.. (unknown [113.200.174.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1E7D266EA9;
	Thu, 11 Apr 2024 10:43:31 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH v7 1/2] x86/mm: Don't disable INVLPG if "incomplete Global INVLPG flushes" is fixed by microcode
Date: Thu, 11 Apr 2024 22:43:21 +0800
Message-ID: <20240411144322.14585-1-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the "Processor Specification Update" documentations referred by the
intel-microcode-20240312 release note, this microcode release has fixed
the issue for all affected models.

So don't disable INVLPG if the microcode is new enough.  The precise
minimum microcode revision fixing the issue is provided by engineer from
Intel.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..c318cdc35467 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,33 +261,43 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
+#define INTEL_MATCH(_model, _fixed_microcode)	\
+	{					\
+	  .vendor	= X86_VENDOR_INTEL,	\
+	  .family	= 6,			\
+	  .model	= _model,		\
+	  .driver_data	= _fixed_microcode,	\
+	}
+
 /*
  * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * on these CPUs when PCIDs are enabled and the
+ * microcode is not updated to fix the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
+	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.44.0


