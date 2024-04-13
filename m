Return-Path: <linux-kernel+bounces-143578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4F8A3B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9301F22703
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8021CAB5;
	Sat, 13 Apr 2024 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="PptWeoWs"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9D1C695
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 04:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712983315; cv=none; b=Q5mWbygKeQSeFJau5BNy8ZV7u6W0io1/382v6+V3xoDDX7nFVcirxYS2p1ttvKVcD6RSsQcYRon8TWhAw/gEj21NQQdzhhrCawEiCgqoj+2NnJP8dN+ETWX0+dnXcgchYbYgpRYsFKSB6LO/y6wvyaoVcp2lV2RNMpVV2B5QrLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712983315; c=relaxed/simple;
	bh=/ypOaozt1jNn/It1XVsIyhjjd3pUgBtzjBA6wsk7oJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+xPnsY/73QyuRQsAWItudTePGoVHtWmjGVUJrGJvNT4YybMrpt2zHfeYD6Yy/gBDe7NpKC+8CG5GVc220+LoFsUsYWAMOGa53EAv4YXP/rE28N/A+3bXXgxPTtAqPsnTzHbJxsnjT6yN4vBSPXVTGVwcyraQfJ4+fjDa/Aao+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=PptWeoWs; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712983313;
	bh=/ypOaozt1jNn/It1XVsIyhjjd3pUgBtzjBA6wsk7oJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PptWeoWsRc+5xr5SzCqtz3BDVd0QqDAP2jXkbefhe0XAPPf0DVsL9IE7E+xHqMQ3z
	 AK61MioeHZndcCKAnN9b5tMNfmx9rrCmyUQo6BQ86KsDhxQ5+wYmXY/4+0yLB57Uwv
	 y4gKeFPvkTRi8V3bqml82VH+M42HUcS3TQYcTEeQ=
Received: from stargazer.. (unknown [IPv6:240e:358:11d1:f200:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 33D1E66D47;
	Sat, 13 Apr 2024 00:41:46 -0400 (EDT)
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
Subject: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is running on a hypervisor
Date: Sat, 13 Apr 2024 12:41:29 +0800
Message-ID: <20240413044129.52812-2-xry111@xry111.site>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413044129.52812-1-xry111@xry111.site>
References: <20240413044129.52812-1-xry111@xry111.site>
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
operation and we should be safe to use PCID.

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
 arch/x86/mm/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index c318cdc35467..6010f86c5acd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -275,6 +275,14 @@ static void __init probe_page_size_mask(void)
  * microcode is not updated to fix the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
+	/* Only bare-metal is affected.  PCIDs in guests are OK.  */
+	{
+	  .vendor	= X86_VENDOR_INTEL,
+	  .family	= 6,
+	  .model	= INTEL_FAM6_ANY,
+	  .feature	= X86_FEATURE_HYPERVISOR,
+	  .driver_data	= 0,
+	},
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
 	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
 	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
-- 
2.44.0


