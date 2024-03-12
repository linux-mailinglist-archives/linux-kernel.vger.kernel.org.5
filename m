Return-Path: <linux-kernel+bounces-100617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC55879ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05F51C219EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C11386B6;
	Tue, 12 Mar 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qmh0TvsG"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E181386A8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265409; cv=none; b=Yfb1ed3y+rA41BZ5kkXY1sK/ZenS1a2TgozoGA5WCXyObNJiBNJLaiuR/n6RTe7d9lWVshd9a5y0MhsCzmybHZsS+AhRGYIn+h+FDeBboMcb9Wm7BSiScgat0shXj3HwA1Tda3HOjEAq9ApIvc+rmlKppDBQr/Q+O/wUJuP9Kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265409; c=relaxed/simple;
	bh=H00csud4xXE5wrj2N6lwCF20l54YbU7FPX4Gmaz4ahU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=V+Ckp3J4kY7NdpwtXX3dyojgecHPVAdKUT1UUgqPj/CLdbCUhZaj0M+O1nPtMsAQ97O92vu4t+vSl9fI+eZ4VwQd7TxgrBjHOx3JvdMjkuGouAhu854lnOWVfdjGsfmwzSE2fgHqVqm2/oYW/++Zy9Rr4B/REt3v53casSPvf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qmh0TvsG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF2B820B74C0;
	Tue, 12 Mar 2024 10:43:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF2B820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710265408;
	bh=B9yQJmvYei2J5JKWsQYB++2MotWF5wwXr9Eyy/3kyXw=;
	h=From:To:Cc:Subject:Date:From;
	b=qmh0TvsGiUhUnf6/EXiDBXyg6hlbekS7dTBUSk7FA1i7nDcGNHhKxpZtkAQgKLSJg
	 8WwGTmR3NKjnHOkCYeN8IDb4EJMJw2bXGp+EUqPUKozziMMQ/YTDYAuc8pE3VKPrBF
	 HK+F7X8VSGDsVDXKqkaG6qR9Rcw36IDuTLP1+Qho=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	sgeorgejohn@microsoft.com
Subject: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
Date: Tue, 12 Mar 2024 10:43:24 -0700
Message-Id: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently for DeviceTree bootup, x86 code does the default mapping of
CPUs to NUMA, which is wrong. This can cause incorrect mapping and WARN
on a SMT enabled system like below:

[0.417551] ------------[ cut here ]------------
[0.417551] Saurabh sched: CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
[0.417551] WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
[0.417551] Modules linked in:
[0.417551] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.71-microsoft-hcl+ #4
[0.417551] RIP: 0010:topology_sane.isra.0+0x5c/0x6d
[0.417551] Code: 41 39 dc 74 27 80 3d 32 ae 2d 00 00 75 1e 41 89 d9 45 89 e0 44 89 d6 48 c7 c7 00 a6 4a 88 c6 05 19 ae 2d 00 01 e8 6e 1f cb ff <0f> 0b 41 39 dc 5b 41 5c 0f 94 c0 5d c3 cc cc cc cc 55 48 8b 05 05
[0.417551] RSP: 0000:ffffc9000013feb0 EFLAGS: 00010086
[0.417551] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[0.417551] RDX: 0000000000000003 RSI: 0000000000000086 RDI: 00000000ffffffff
[0.417551] RBP: ffffc9000013fec0 R08: ffffffff88778160 R09: ffffffff88778160
[0.417551] R10: ffff888227fe26da R11: ffff888227fe26c1 R12: 0000000000000001
[0.417551] R13: 0000000000000000 R14: ffff888216415040 R15: 0000000000000000
[0.417551] FS:  0000000000000000(0000) GS:ffff888216400000(0000) knlGS:0000000000000000
[0.417551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[0.417551] CR2: 0000000000000000 CR3: 0000000208809001 CR4: 0000000000330ea0
[0.417551] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[0.417551] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[0.417551] Call Trace:
[0.417551]  <TASK>
[0.417551]  ? show_regs.cold+0x1a/0x1f
[0.417551]  ? __warn+0x6e/0xc0
[0.417551]  ? report_bug+0x101/0x1a0
[0.417551]  ? handle_bug+0x40/0x70
[0.417551]  ? exc_invalid_op+0x19/0x70
[0.417551]  ? asm_exc_invalid_op+0x1b/0x20
[0.417551]  ? topology_sane.isra.0+0x5c/0x6d
[0.417551]  match_smt+0xf6/0xfc
[0.417551]  set_cpu_sibling_map.cold+0x24f/0x512
[0.417551]  start_secondary+0x5c/0x110
[0.417551]  secondary_startup_64_no_verify+0xcd/0xdb
[0.417551]  </TASK>
[0.417551] ---[ end trace 0000000000000000 ]---

Add the correct mapping of CPUs to NUMA node as per DeviceTree to fix
this issue.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/mm/numa.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e..9dacf60 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -601,6 +601,23 @@ static void __init numa_init_array(void)
 	}
 }
 
+static void __init of_parse_and_init_cpus(void)
+{
+	struct device_node *dn;
+	int cpuid = 0;
+	int nid;
+
+	for_each_of_cpu_node(dn) {
+		if (cpuid >= NR_CPUS) {
+			pr_warn("NR_CPUS too small for %d cpuid\n", cpuid);
+			return;
+		}
+		nid = of_node_to_nid(dn);
+		numa_set_node(cpuid, nid);
+		cpuid++;
+	}
+}
+
 static int __init numa_init(int (*init_func)(void))
 {
 	int i;
@@ -645,6 +662,9 @@ static int __init numa_init(int (*init_func)(void))
 	if (ret < 0)
 		return ret;
 
+	if (acpi_disabled)
+		of_parse_and_init_cpus();
+
 	for (i = 0; i < nr_cpu_ids; i++) {
 		int nid = early_cpu_to_node(i);
 
-- 
1.8.3.1


