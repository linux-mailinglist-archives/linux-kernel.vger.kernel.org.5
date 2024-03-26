Return-Path: <linux-kernel+bounces-119466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9288C95B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4B11C634D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18C1BDE6;
	Tue, 26 Mar 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="jEPq4Tol"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A0641
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470644; cv=none; b=eiBgDRkfN8WqnpPKZYmORga+c/FPymUUGHI+s1xTdUEs9UMhB0DF7YU97sqVHCb23r0McAULtLd2D7BpjjQp8WC+u8XCg5FhQBtjtuD0jghr/EtSfeXmA3V0SE0xxREFoLeSRBNk6ndbU6gqqXuhu59wNG0O+66OB0YDXT0+ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470644; c=relaxed/simple;
	bh=zSKC4GHTI0sii/KWS6qMFiGNmweeFzJI8GJyuu01y2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1c+deYjoOzNNxxY82bo73nTRY93MmwJybDqk+rLAD4Piw+qtP8r8awIwAc6lq/fUpMEIRPda4ot3+HGaCIm1xtzx+lX37kQ+qtPt66wL9toB09gWhch/zHa59j2//cFCspgJStzw3sOkE5GusNpdCimYivk0nMHlvxBHCJ3KWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=jEPq4Tol; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711470638;
	bh=zSKC4GHTI0sii/KWS6qMFiGNmweeFzJI8GJyuu01y2o=;
	h=From:To:Cc:Subject:Date:From;
	b=jEPq4TolAtPcXb0lndYSGgmn9E3AfMQrJVb5hZunOZfgPLR6cel/PNw+3RL430RkD
	 VDMNYKU4QeNWvQD3L50a1fP1dhQpe20gKhvnjnR9yaUXPh75mOWGRmeeBrH0Am6gbw
	 0EOgw6xtjiRWdGjx4lYz1DB/irAAmuyOMJ2Jq8+0=
Received: from stargazer.. (unknown [IPv6:240e:358:1190:6500:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 194B767050;
	Tue, 26 Mar 2024 12:30:33 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v4] x86/mm: Don't disable INVLPG if "incomplete Global INVLPG flushes" is fixed by microcode
Date: Wed, 27 Mar 2024 00:30:27 +0800
Message-ID: <20240326163027.16591-1-xry111@xry111.site>
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
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..475b2d728acc 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,33 +261,48 @@ static void __init probe_page_size_mask(void)
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
+	/*
+	 * The hypervisor may lie about the microcode revision, conservatively
+	 * consider the microcode not updated.
+	 */
+	if (invlpg_miss_match &&
+	    (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	     invlpg_miss_match->driver_data > boot_cpu_data.microcode)) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.44.0


