Return-Path: <linux-kernel+bounces-137482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E989E2BD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C601F238E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B610156F36;
	Tue,  9 Apr 2024 18:50:51 +0000 (UTC)
Received: from relay162.nicmail.ru (relay162.nicmail.ru [91.189.117.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21639156F2D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688651; cv=none; b=AjfqJa4KlXELu/KSytT6xZeBdRONRUjeLM0sAMCwd9gRY/lDOD595w4jBytw19xLzMByMffKOYUY/h/RpY04t5uceECkWyqPkwV3n9y6jy1QmnIfC7US80Xk2xiIeV3Ip1eMa343bpRPzWBAi5BqeaLOPA+n/E4YYJkOpofh4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688651; c=relaxed/simple;
	bh=7mpDaExakoQ07v+dHggo5nRAbVx93Whw/EtsFEU4P3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaoA/Kmrbr6iXhHAunR0pw5vaEbAqcFAd4QdqGBKgV6zkKLxHsELB8nP2iXD0ir7m2hLLGQeIlGvxTuKyc0mJzPErDIAyFrWMotmWBH3L1aM3I9yyK91yB7OAlB0D91p20WQUznhFYUjohbQTeCtMf8KIR/I8nmMxfAoc1ATfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.136.255] (port=5328 helo=mitx-gfx..)
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1ruGEe-00014w-9e;
	Tue, 09 Apr 2024 21:30:21 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO mitx-gfx..)
	by incarp1105.mail.hosting.nic.ru (Exim 5.55)
	with id 1ruGEe-007wXR-2s;
	Tue, 09 Apr 2024 21:30:20 +0300
From: Nikita Kiryushin <kiryushin@ancud.ru>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] x86/smpboot: Add map vars allocation check in smp_prepare_cpus_common
Date: Tue,  9 Apr 2024 21:29:39 +0300
Message-Id: <20240409182940.664482-1-kiryushin@ancud.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

As of now, zalloc_cpumask_var for various maps in smp_prepare_cpus_common
is not checked.

If allocation fails, it will not be known, unless the not-allocated map
will be accessed. The situation seems not very realistic now, but could
get more relevant in the future, as number of cores (and amount of
allocated resources) grows.

Add a cumulative status for all zalloc_cpumask_var() calls in
smp_prepare_cpus_common() and error message in case the status signals
that any of the map var allocations failed (per cpu).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
 arch/x86/kernel/smpboot.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 76bb65045c64..3b24c2e1fa3b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1042,11 +1042,16 @@ void __init smp_prepare_cpus_common(void)
 	}
 
 	for_each_possible_cpu(i) {
-		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
+		bool ret = true;
+
+		ret &= zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
+		ret &= zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
+		ret &= zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
+		ret &= zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		ret &= zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
+
+		if (!ret)
+			pr_err("Failed to allocate map for CPU%u\n", i);
 	}
 
 	set_cpu_sibling_map(0);
-- 
2.34.1


