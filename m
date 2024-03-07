Return-Path: <linux-kernel+bounces-94836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 769308745C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02308B21561
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB544C98;
	Thu,  7 Mar 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="WRye+pJL"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B22F28
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775913; cv=none; b=RRPl3PuR7l16igxCsqz9ca+QF+qOP83bAFKqgGXtYUvDWypzZwxCGyUkqn9Bm0xAZoha/zkfsn0pvli4oAKAcgJ0d/9XuhRpEZhyhlBvnCrwbix6QZTC/sYhFNT13A8/r7Gf7iOSkVCwsE+6GzwfvIeCvm6P0C+PYPGrWyBEdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775913; c=relaxed/simple;
	bh=aWSwUSkgwGQnBYXx/O6wZsg2pJVaxfIK5ZiFu+4pJiM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=l1VQzacF0BGjidSQLzd3fX+mAYHUMCbqezd6YhKw9oA8wIKQrfq4klWR20RNhBt3SSJVeJwIN5TC+gr2K3CNRbGzlPvBAWgqiuqqgOX92VbTTi0wJW4T7yJ1j3F4hfCbXFm41ZhZMH78sDFph9F5q0bcqCJEpIIxng5ZNrsFwMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=WRye+pJL; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1709775904;
	bh=aWSwUSkgwGQnBYXx/O6wZsg2pJVaxfIK5ZiFu+4pJiM=;
	h=Date:From:To:cc:Subject:From;
	b=WRye+pJLR+trpFSDcZ4fJaP+w34FsxMv4jhCYGzeYBguKZj9sMfw4npzfW5R8+vbt
	 ff+pUuLlIOGn02EhmiXQ/u/sL3lpx97bT45tNjeYLGkTxKv82V2Fi3kqErb/hndxF7
	 y0tOM0LoYWspgM4XpLviFf82ReGKWy1xgMrmBwo0Zy7BTuYlBCEE1s9lYLQHBu4CnW
	 6E/qupm8E4VN91Y2UBGfOPzeaNqBECudKuo8XTFINnJoaWInraLbRvhJpxZViYel7V
	 hc73NxJOs8nsNGoBxUHjubsZl13uOqQk0ncgN3THtki13nDyjrWfsGMGEv6Qmezpy1
	 sd3LWJ9sjRWYQ==
Received: by gentwo.org (Postfix, from userid 1003)
	id 3501440A94; Wed,  6 Mar 2024 17:45:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 30B1240789;
	Wed,  6 Mar 2024 17:45:04 -0800 (PST)
Date: Wed, 6 Mar 2024 17:45:04 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Mark Rutland <mark.rutland@arm.com>
cc: catalin.marinas@arm.com, Will Deacon <will@kernel.org>, 
    Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com, 
    Valentin.Schneider@arm.com, akpm@linux-foundation.org, 
    anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>, 
    dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk, 
    robin.murphy@arm.com, vanshikonda@os.amperecomputing.com, 
    yang@os.amperecomputing.com
Subject: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase supported
 CPUs to 512
Message-ID: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Currently defconfig selects NR_CPUS=256, but some vendors (e.g. Ampere
Computing) are planning to ship systems with 512 CPUs. So that all CPUs on
these systems can be used with defconfig, we'd like to bump NR_CPUS to 512.
Therefore this patch increases the default NR_CPUS from 256 to 512.

As increasing NR_CPUS will increase the size of cpumasks, there's a fear that
this might have a significant impact on stack usage due to code which places
cpumasks on the stack. To mitigate that concern, we can select
CPUMASK_OFFSTACK. As that doesn't seem to be a problem today with
NR_CPUS=256, we only select this when NR_CPUS > 256.

CPUMASK_OFFSTACK configures the cpumasks in the kernel to be
dynamically allocated. This was used in the X86 architecture in the
past to enable support for larger CPU configurations up to 8k cpus.

With that is becomes possible to dynamically size the allocation of
the cpu bitmaps depending on the quantity of processors detected on
bootup. Memory used for cpumasks will increase if the kernel is
run on a machine with more cores.

Further increases may be needed if ARM processor vendors start
supporting more processors. Given the current inflationary trends
in core counts from multiple processor manufacturers this may occur.

There are minor regressions for hackbench. The kernel data size
for 512 cpus is smaller with offstack than with onstack.

Benchmark results using hackbench average over 10 runs of

 	hackbench -s 512 -l 2000 -g 15 -f 25 -P

on Altra 80 Core

Support for 256 CPUs on stack. Baseline

 	7.8564 sec

Support for 512 CUs on stack.

 	7.8713 sec + 0.18%

512 CPUS offstack

 	7.8916 sec + 0.44%

Kernel size comparison:

    text		   data	    filename				Difference to onstack256 baseline
25755648	9589248	    vmlinuz-6.8.0-rc4-onstack256
25755648	9607680	    vmlinuz-6.8.0-rc4-onstack512	+0.19%
25755648	9603584	    vmlinuz-6.8.0-rc4-offstack512	+0.14%

Tested-by: Eric Mackay <eric.mackay@oracle.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>
---


Original post: https://www.spinics.net/lists/linux-mm/msg369701.html
V2: https://lkml.org/lkml/2024/2/7/505


V1->V2

- Keep quotation marks
- Remove whiltespace damage
- Add tested by

V2->V3:
- Add test results
- Rework descriptions


  arch/arm64/Kconfig | 16 +++++++++++++++-
  1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..4e767dede47d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1427,7 +1427,21 @@ config SCHED_SMT
  config NR_CPUS
  	int "Maximum number of CPUs (2-4096)"
  	range 2 4096
-	default "256"
+	default "512"
+
+#
+# Determines the placement of cpumasks.
+#
+# With CPUMASK_OFFSTACK the cpumasks are dynamically allocated.
+# Useful for machines with lots of core because it avoids increasing
+# the size of many of the data structures in the kernel.
+#
+# If this is off then the cpumasks have a static sizes and are
+# embedded within data structures.
+#
+	config CPUMASK_OFFSTACK
+	def_bool y
+	depends on NR_CPUS > 256

  config HOTPLUG_CPU
  	bool "Support for hot-pluggable CPUs"
-- 
2.39.2


