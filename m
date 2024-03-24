Return-Path: <linux-kernel+bounces-112816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF422887E87
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4171C208C1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035FFBE8;
	Sun, 24 Mar 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="AKP17Gxe"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F1F9EC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307154; cv=none; b=rPsCHi8iuH/CWqZ9mA5MUP8exEFvzixW6UPKvNwVlmwsLiYqrCxbd8jpuIs26fBfZfZWFVYZQ93uCBSpT7LLt0H5V9DnFPwVri/vmIDEs+7pJYl5Rr9M33cJieUXJ8rCZRNNzG1pP9MpWxI6Mgdpv+S+onrbq+xCE64lLwzjBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307154; c=relaxed/simple;
	bh=tgO22Q9yqEl4xTkxs57KMZtwHtF8TrCvj8tYkyXVw8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxSVjNdowb7xH605XpUtUD1raGvhFspas9Gv0jnWLk9elbXlyw9FVFAwifMozTDe3rSqWMPZtvQ+90Cv5x9V8XTdlaq4HbssrR0slAoZvAKxv7GyLqk35z8d2Bp7TACXUAVfMSqwOcu7enLE1kuKXk0srVwrmXK/2SAxvgeuPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=AKP17Gxe; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711307149;
	bh=tgO22Q9yqEl4xTkxs57KMZtwHtF8TrCvj8tYkyXVw8c=;
	h=From:To:Cc:Subject:Date:From;
	b=AKP17Gxev8kIv2QPAtTKDDY/7PdBAJFi4w0M5rnuVnJ35USratbY+r+APk8uhAN+Q
	 K/cVpo597rKAy3f15H7loTEy1UaUHTqi5vHar7FDv1JEBBeL09OXxwyy7I+bv990q8
	 lEpJqgneeesqNuTp2FoZinE4FQq7FSU0YAIwqBTg=
Received: from stargazer.. (unknown [IPv6:240e:358:11fe:a000:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id EA8A0668E6;
	Sun, 24 Mar 2024 15:05:44 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global INVLPG flushes" is fixed by microcode
Date: Mon, 25 Mar 2024 03:05:03 +0800
Message-ID: <20240324190503.116160-1-xry111@xry111.site>
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

So don't disable INVLPG if the microcode is new enough.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..c52be4e66e44 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,33 +261,41 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
+#define INTEL_MATCH(_model, _fixed_microcode)	\
+    { .vendor		= X86_VENDOR_INTEL,	\
+      .family		= 6,			\
+      .model		= _model,		\
+      .driver_data	= _fixed_microcode,	\
+    }
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
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x34),
+	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x432),
+	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x15),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x122),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4121),
+	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x34),
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
+	if (invlpg_miss_match &&
+	    invlpg_miss_match->driver_data > boot_cpu_data.microcode) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.44.0


