Return-Path: <linux-kernel+bounces-72741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A734585B837
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468761F26842
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D72612CD;
	Tue, 20 Feb 2024 09:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gOlGqt/D"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C660244
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422619; cv=none; b=UwBS/Qo3a43UMrKkTi+H+qLBxEhqkdevZvTSqK2qZ/hX8oOYa9Qjg/03JVfFOQW4nTaITm9i6YioZhLpKa7J9FWTbFz/5lbRRMkBTdB+WkKuOb5vCLO59LiYLV6+WAqMv54W9D1jz5SbbaDdi/Vsg4RW/QUx1fKijz0cRl2Sc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422619; c=relaxed/simple;
	bh=Pc+2+/vicu8XiIRtXQihQ0eQ9Yu0XvrHSeD0RBFf9Ek=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZUmKujevcrwFxJTHKzACt4TtKED/Kokze0BJC/10gQ6jW8DF5dilwYF8Q6zv8ogDhivPPt6Pf1k5F0glqyC8q1f4R1ZezeE2vE4AQR/5FRE+PRj5gP05OWyi4u76cmWwIXcZVNGuN2UhJNgn6zzJMxnLkjAIE9aI/j4WYGYMY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gOlGqt/D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63C19208360E;
	Tue, 20 Feb 2024 01:50:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C19208360E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708422617;
	bh=3W4h4uwYh9kgjiCp95bdEHo8yCZlRGw0RiGys4AyqXo=;
	h=From:To:Cc:Subject:Date:From;
	b=gOlGqt/DvMESbE+KajpygWnefeYTuLU3APOtS4/x8x6PWyxUL7euqP9YtK4kavAR/
	 2Sin1jD6nfypTzdJNfel2jtZBnbi0TUAL0e4WiBAOrAECsewVwJHpMK23LWNah4E7B
	 AwAdH9ZPdyc+AIsd3yCIjyH48jBHCK4KiTdiS+Sk=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	libo.chen@oracle.com,
	mhklinux@outlook.com
Subject: [PATCH] x86/Kconfig: Allow NR_CPUS between 512 and 8192
Date: Tue, 20 Feb 2024 01:50:13 -0800
Message-Id: <1708422613-15714-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Today there is no way one can choose any value between 512 to 8192
for NR_CPUS seamlessly. NR_CPUS is guarded by NR_CPUS_RANGE_END which
is further dependent on CPUMASK_OFFSTACK to allow NR_CPUs > 512.

For x86, CPUMASK_OFFSTACK can only be enabled either by selecting MAXSMP
or DEBUG_PER_CPU_MAPS. Both of these options has a cost to pay. MAXSMP
will increase the NR_CPUS to 8192 which will have impact on kernel image
size whereas DEBUG_PER_CPU_MAPS will have additional run time overheads.
Thus there is no good way to have NR_CPUS anything between 512 to 8192.

Fix this by selecting CPUMASK_OFFSTACK if NR_CPUS > 512 and
let NR_CPUS_RANGE_END set to 8192.

On a Hyper-V system where max number of CPUs are only 2048, this
patch saves around 1 MB of kernel image size, compare to MAXSMP.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---

I want to mention that in ARM and other archs its very simple
to select any value for NR_CPUS. This is an attempt to have more
flexibilty in x86 arch as well to choose NR_CPUS.

Some of the earlier discussions reated to it which could be of interest:
https://lore.kernel.org/lkml/1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com/
https://lore.kernel.org/lkml/794a1211-630b-3ee5-55a3-c06f10df1490@linux.com/

Another approach I can think of is to allow CPUMASK_OFFSTACK to be enabled
more freely like the below patch of Libo Chen, that will also solve the
problem I am addressing. But I feel this patch may have impact on other
archs as well and I am not sure if that is in best interest of all the archs.

https://lore.kernel.org/lkml/20220412231508.32629-2-libo.chen@oracle.com/

 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 07a0c8d4e9c7..458f3f250d7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select CPUMASK_OFFSTACK if NR_CPUS > 512
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
@@ -1006,8 +1007,7 @@ config NR_CPUS_RANGE_END
 config NR_CPUS_RANGE_END
 	int
 	depends on X86_64
-	default 8192 if  SMP && CPUMASK_OFFSTACK
-	default  512 if  SMP && !CPUMASK_OFFSTACK
+	default 8192 if  SMP
 	default    1 if !SMP
 
 config NR_CPUS_DEFAULT
-- 
2.34.1


