Return-Path: <linux-kernel+bounces-112761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E5887DDE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E783C2816C3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3C1BDE0;
	Sun, 24 Mar 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Eh2oGUIJ"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C07481B9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300014; cv=none; b=iePUldfYOMlLl4fHyffHWk+TpoWtt60zCTTXz+0tgmWGSK71rWigNnzcZgsCzY+P7dv9yWt0orqiAdoHXfpo71VxYnVhf6zGVzca6Y0R9v2hKlpKZR9UJmJ3Bfvcsv11nEB2K7BAffidKJofTsc7814+vlhjfW+hkOxB8uxjuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300014; c=relaxed/simple;
	bh=nmOulUcc9l/hTjA8emsER/2x+28dkEwIk8p2JOkhcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLM2ELZz5gVaASXj0yFp9qviQJYMJVGXtIMlZZN7R/rQDIfYHDPzbQk0ALXpT9woB0T5e3qZH90CwflAPY7jBupm7gw3Hk52jV41m3qPNTtQV2FwTeS/p3gcRN7qtL+JAqOhhJMCw8c27fFad0TGkA7vi6xxyCY+hhvHFAXvXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Eh2oGUIJ; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711300007;
	bh=nmOulUcc9l/hTjA8emsER/2x+28dkEwIk8p2JOkhcXs=;
	h=From:To:Cc:Subject:Date:From;
	b=Eh2oGUIJwxGLPtExxvk402z8bdPMJJ4m4Yp8Ipep7IrXUI8YrUr79bwtRQKzWxw+g
	 WgK8L2bvEO8xMOHhmm1XfrZphrQW4np615lfVBVhk5UomDGDcqW+f4OzXS1WI1YFqy
	 PW9wybo3iy/RHd5fbitkBmiLDi2AWQZ76mNAzs8M=
Received: from stargazer.. (unknown [IPv6:240e:358:11fe:a000:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E5EE166BF3;
	Sun, 24 Mar 2024 13:06:42 -0400 (EDT)
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
Subject: [PATCH] x86/mm: Don't disable INVLPG if "incomplete Global INVLPG flushes" is fixed by microcode
Date: Mon, 25 Mar 2024 01:06:30 +0800
Message-ID: <20240324170630.76084-1-xry111@xry111.site>
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
 arch/x86/mm/init.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 679893ea5e68..a6a2f38c3999 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -279,6 +279,25 @@ static const struct x86_cpu_id invlpg_miss_ids[] = {
 	{}
 };
 
+/*
+ * INVLPG issue is fixed with intel-microcode-20240312 for all
+ * affected models.  This table is taken from the release note
+ * of this microcode release.
+ */
+static const struct x86_cpu_desc invlpg_miss_fixed_ucode[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		2, 0x34),
+	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		5, 0x34),
+	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		3, 0x432),
+	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		4, 0x432),
+	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GRACEMONT,	0, 0x15),
+	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE,		1, 0x122),
+	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		2, 0x4121),
+	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		3, 0x4121),
+	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		2, 0x34),
+	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		5, 0x34),
+	{}
+};
+
 static void setup_pcid(void)
 {
 	if (!IS_ENABLED(CONFIG_X86_64))
@@ -287,7 +306,8 @@ static void setup_pcid(void)
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	if (x86_match_cpu(invlpg_miss_ids) &&
+	    !x86_cpu_has_min_microcode_rev(invlpg_miss_fixed_ucode)) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.44.0


