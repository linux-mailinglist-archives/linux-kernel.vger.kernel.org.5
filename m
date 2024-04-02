Return-Path: <linux-kernel+bounces-128180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35790895742
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3403C1C228D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A013BC04;
	Tue,  2 Apr 2024 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="onOcYKkH"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705813A24A;
	Tue,  2 Apr 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068836; cv=none; b=H+/2ZT1BmWWUWsLvDi2RznGEHGatz4R/5/8XhIoihQqysLp6RhGuyUI+XMrpTSSzMJwS5uV2F57brsZKA3RojY9lu5vBxvRCkamiYCSDh3RjP3deJnGFtNamoRXecHzskZOpch0IjsZwm3gU7dPp3pDC7J+zQlRUg/pKGAABgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068836; c=relaxed/simple;
	bh=YvVmVZvz7J+cr8gENpnBQYE+cXgUIQDILN5r7tZQ7Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bv1x09Tg05Ah2R/gRwUNxdnUBPyLm70N8ab7P7lhe6syycw19/fTQBhfORfc+W+IbnXuZzTdX+GmHX/QS+yRLAOHGYUzxPPYf0JBOQW2TPc7QYO9QR0L3t50P7hljj1ul2nnLZM/xVgrT+Jiczo/b43gJ04SR++KmgXV4mL1CMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=onOcYKkH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 66E1F20E8BE4;
	Tue,  2 Apr 2024 07:40:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66E1F20E8BE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712068834;
	bh=l7q/Xpa0oUdw6nw11CmHiga/JBvqg3PJnzbMoVZzr2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onOcYKkHQPd5L+zdY0DjwxgjbBKRQtqipRK3Kqgi+U4iT3QBgLToQAxCYOeq8O+kh
	 RnoGQtfvbR2dZJKUU5FKRRy4SBsVbAoYKZiyJa5YEQ2XKkO9KzH7IEvT6+Ks8HKdOU
	 0v2Jh9HPDGQKjt28+6sH4At7gTcC9bPY8IymMHZg=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH v2 4/4] x86/of: Change x86_dtb_parse_smp_config to static
Date: Tue,  2 Apr 2024 07:40:30 -0700
Message-Id: <1712068830-4513-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

x86_dtb_parse_smp_config is called locally only, change it to static.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/include/asm/prom.h  |  2 --
 arch/x86/kernel/devicetree.c | 18 +++++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 02644e010514..365798cb4408 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,12 +23,10 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_parse_smp_config(void);
 void x86_flattree_get_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_parse_smp_config(void) { }
 static inline void x86_flattree_get_config(void) { }
 #define of_ioapic 0
 #endif
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index b93ce8a39ff7..8e3c53b4d070 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -279,6 +279,15 @@ static void __init dtb_apic_setup(void)
 	dtb_ioapic_setup();
 }
 
+static void __init x86_dtb_parse_smp_config(void)
+{
+	if (!of_have_populated_dt())
+		return;
+
+	dtb_setup_hpet();
+	dtb_apic_setup();
+}
+
 void __init x86_flattree_get_config(void)
 {
 #ifdef CONFIG_OF_EARLY_FLATTREE
@@ -307,12 +316,3 @@ void __init x86_flattree_get_config(void)
 	if (of_have_populated_dt())
 		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 }
-
-void __init x86_dtb_parse_smp_config(void)
-{
-	if (!of_have_populated_dt())
-		return;
-
-	dtb_setup_hpet();
-	dtb_apic_setup();
-}
-- 
2.34.1


