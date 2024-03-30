Return-Path: <linux-kernel+bounces-125661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFAE892A3F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344DE1F22433
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430C41206;
	Sat, 30 Mar 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBkJQNjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3224A03;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=YyZtDEsFziNpiYfe8pTUXuTo2EoAKykXWVJWAAP0Ycf4dBeBSMLLOTccIR2l05hxoeeAZzKu5sXfB6NzKdt8s+v5rEZeZncFQdSEh9ReKgE7I0i/trEbtB8Y/y1UOXlff6IKwrg0hyQNVMxxyRhL79WPXQpCj+EpITLZJKHMCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=bebuIwcUBNMtYbSzdkVNlj0yN3Mms/4B8BSns5s9jWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGytvjMe4oCbrEIMB9oeWTl8ysc6giLPLB03B4hi9D6j+kW/pg6ScXKQ7WgXiCdMpSYdOPdUXlKrAJCft/7KNiFSV9TT52Qj3rJ91G2+Zcrmd1g3O/pM34tn7YF61JJKSC4kDCf4nUKNPTkbQIUYeKnR+QeA1Ji+hBWrArySujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBkJQNjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BC5DC43609;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=bebuIwcUBNMtYbSzdkVNlj0yN3Mms/4B8BSns5s9jWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bBkJQNjm6+iwK7Oo9ZKoxNPmM3KMVEUXraK+5rpydUUIlhQ3PfN0XSdH7C9+wPHmR
	 cBcCs8E6sUbfGsTKzwQBSJwE14ia6ZB7xJNCzTpEsroVuYh4iDEZOCVBZ1Kol6VJ2o
	 kA4QD/IKVxnYS23KTndmvSLuJZ+uL9d3F7EvR1pUCjZIYgflD8Uk9Ewdmg0UtJzWXs
	 fCirwBwTgORYFKUMCZufd89cmOjNcTA4VqNEMFfH+IIBqj2m+hSooSiMbqcUjtQetj
	 gSMc4ScZ+QKsfIeWfbYS//UIfMf3dfxZ6bnDc7SBo3nPjTD9dngiVwJztg8miM0UZE
	 FRgqmQOKOMxWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4FCD128E;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:45 +0100
Subject: [PATCH 09/10] sparc64: Fix number of online CPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-sparc64-warnings-v1-9-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Atish Patra <atish.patra@oracle.com>, 
 Sam Ravnborg <sam@ravnborg.org>, stable@vger.kernel.org, 
 Bob Picco <bob.picco@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=4552;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=dn/Iq8dROBgEtbrmvGqdZDKLIQGxfIlMZA5xlo5LiLk=;
 b=Mm0tyHZeXe/t+CUAz0TIDK29Bnh9pWuLw9N9PngOUrSliPSuEf3HaRhoErcq25a4YyE9mnLixJng
 DR+0exWWCpJJ9L0PynCkfmAWNCYEio9DUJVIyayOkKqpOy3h29V7
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Nick Bowler reported:
    When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
    CPUs, I noticed that only CPU 0 comes up, while older kernels (including
    4.7) are working fine with both CPUs.

      I bisected the failure to this commit:

      9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
      commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
      Author: Atish Patra <atish.patra@oracle.com>
      Date:   Thu Sep 15 14:54:40 2016 -0600

      sparc64: Fix cpu_possible_mask if nr_cpus is set

    This is a small change that reverts very easily on top of 5.18: there is
    just one trivial conflict.  Once reverted, both CPUs work again.

    Maybe this is related to the fact that the CPUs on this system are
    numbered CPU0 and CPU2 (there is no CPU1)?

The current code that adjust cpu_possible based on nr_cpu_ids do not
take into account that CPU's may not come one after each other.
Move the chech to the function that setup the cpu_possible mask
so there is no need to adjust it later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: 9b2f753ec237 ("sparc64: Fix cpu_possible_mask if nr_cpus is set")
Reported-by: Nick Bowler <nbowler@draconx.ca>
Tested-by: Nick Bowler <nbowler@draconx.ca>
Link: https://lore.kernel.org/sparclinux/20201009161924.c8f031c079dd852941307870@gmx.de/
Link: https://lore.kernel.org/all/CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com/
Cc: <stable@vger.kernel.org> # v4.8+
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Atish Patra <atish.patra@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: Vijay Kumar <vijay.ac.kumar@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/smp_64.h |  2 --
 arch/sparc/kernel/prom_64.c     |  4 +++-
 arch/sparc/kernel/setup_64.c    |  1 -
 arch/sparc/kernel/smp_64.c      | 14 --------------
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index 505b6700805d..0964fede0b2c 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -47,7 +47,6 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void __noreturn cpu_play_dead(void);
 
@@ -77,7 +76,6 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
-#define smp_fill_in_cpu_possible_map() do { } while (0)
 #define smp_init_cpu_poke() do { } while (0)
 #define scheduler_poke() do { } while (0)
 
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 998aa693d491..ba82884cb92a 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -483,7 +483,9 @@ static void *record_one_cpu(struct device_node *dp, int cpuid, int arg)
 	ncpus_probed++;
 #ifdef CONFIG_SMP
 	set_cpu_present(cpuid, true);
-	set_cpu_possible(cpuid, true);
+
+	if (num_possible_cpus() < nr_cpu_ids)
+		set_cpu_possible(cpuid, true);
 #endif
 	return NULL;
 }
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 1d519f18d2b2..63615f5c99b4 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -671,7 +671,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
-	smp_fill_in_cpu_possible_map();
 	/*
 	 * Once the OF device tree and MDESC have been setup and nr_cpus has
 	 * been parsed, we know the list of possible cpus.  Therefore we can
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f3969a3600db..e50c38eba2b8 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1220,20 +1220,6 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __init smp_fill_in_cpu_possible_map(void)
-{
-	int possible_cpus = num_possible_cpus();
-	int i;
-
-	if (possible_cpus > nr_cpu_ids)
-		possible_cpus = nr_cpu_ids;
-
-	for (i = 0; i < possible_cpus; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-}
-
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;

-- 
2.34.1



