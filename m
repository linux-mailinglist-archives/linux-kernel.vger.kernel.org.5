Return-Path: <linux-kernel+bounces-140685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B728A17BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D992846C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79824A04;
	Thu, 11 Apr 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="OT0wS8Hw"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57D1865A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846623; cv=none; b=YK98G5eyHfYKuLtW3r1dtjYJs8uOk5DmLKzalvcxoPSYsAu/lsFOGOXyFawBi/47bEYSBUjBOgAuf6EVOEx6R+QA6jROiV8pv0MZJR/vaA/L1yQFKNeNiNk9fw3EYaO8U/UWMLf9goA+mgt+QzQ8AfJbSj9QErU2kVqr2KAizK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846623; c=relaxed/simple;
	bh=koOBQ3Z44ypR6NQitkysuOhab6CFAR8ivaxRCIRFuvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4Y0qagJdtwUJnkQmCduVNoN6QrrrrWzUYlqeBov+y66ms5C7JI8u8+w9BUbQeZfG7sdJlceqvD/FTAXFdvzAOG/byM2Mtxsc0SwAgHu8uu5JkYmLAbc1CHr2/QYX3itkgelB21X3DgYHTQfZuTdco7S5ND23F1K90f3WvbgY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=OT0wS8Hw; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712846621;
	bh=koOBQ3Z44ypR6NQitkysuOhab6CFAR8ivaxRCIRFuvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OT0wS8HwgqKnDxl2iTWdboUcgVCzlFides50BJvedp01vlHZ2PbkFP12wtzuKS8mL
	 QiHkHQ0/WBot531WCUdlTpIzuUqdbZWKzOxj9jzjlGimreBlXl9CQCuFFxoV2FuT51
	 qgAtBvFaDf3q02SupK9zPFZP6bn7Qtg9Hc++TGVs=
Received: from stargazer.. (unknown [113.200.174.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CF08B66EAB;
	Thu, 11 Apr 2024 10:43:37 -0400 (EDT)
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
Subject: [PATCH v7 2/2] x86/mm: Don't disable INVLPG if the kernel is running on a hypervisor
Date: Thu, 11 Apr 2024 22:43:22 +0800
Message-ID: <20240411144322.14585-2-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411144322.14585-1-xry111@xry111.site>
References: <20240411144322.14585-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel erratum for "incomplete Global INVLPG flushes" says:

    This erratum does not apply in VMX non-root operation. It applies
    only when PCIDs are enabled and either in VMX root operation or
    outside VMX operation.

So if the kernel is running in a hypervisor, we are in VMX non-root
operation and we should be safe to use INVLPG.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c318cdc35467..e69d227ea123 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -296,7 +296,14 @@ static void setup_pcid(void)
 
 	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
 
-	if (invlpg_miss_match &&
+	/*
+	 * The Intel errata claims: "this erratum does not apply in VMX
+	 * non-root operation.  It applies only when PCIDs are enabled
+	 * and either in VMX root operation or outside VMX operation."
+	 * So we are safe if we are surely running in a hypervisor.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) &&
+	    invlpg_miss_match &&
 	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
-- 
2.44.0


