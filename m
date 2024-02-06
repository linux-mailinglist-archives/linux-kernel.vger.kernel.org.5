Return-Path: <linux-kernel+bounces-55441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9A684BCBA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1441C2270C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30081E56C;
	Tue,  6 Feb 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="dHBKmQ4B"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0E134A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243007; cv=none; b=n2P2dec922svhenIoMJuiTmvi459Wa2E5PZeZe5NoheOK+dWGcMMK5XbA89Bjw/8DULAo+NRRQ4pHdTWEuR4vuHu4HyvG8nm+9/ymTQ6YW1q6aFtExgNuMOk4w+NYrQoREGpr8srAYypOtbYMGVLtdNnrrbOdMSleffpFhOekBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243007; c=relaxed/simple;
	bh=Kxq4sAvN5Fs2sIsPglHruFBuErxB15QsWcASPc5lT0Q=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=fZdIgBNa0PbKStpvhaD1v+f8RIFU1NH+nyzIan7lMuoyUqKpkJPT87WkDzg365OnHPPK7YMwnx/3A4MSsor17LA7Hz4PBJGS0W5kdnmJDYxOwZNQuF0A4goKRxk/OCvqo7SJQJesVZ8htr/OowVvlsxLZZKHk0Kokv9P1z0fQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=dHBKmQ4B; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1707242999;
	bh=Kxq4sAvN5Fs2sIsPglHruFBuErxB15QsWcASPc5lT0Q=;
	h=Date:From:To:cc:Subject:From;
	b=dHBKmQ4BHy52GP3uyL/6OewvtDCvQAl73DQsCoM3ERD4Zt3W7zQRZ27bJRXFJI5Eg
	 VxeVaHDzouRpY2ewEI0xXRnrTP9FzGyA3S9hx4GEjc8KRBozUMvFtnso8CTQ7VpZUK
	 K1zSEx7Q4+RYHO7sR23yOjTRfUNo68EIjhXI8hDx/V20gjUG2bDjM5L6zApYfo//pA
	 k5DaKUu0lrD3RJCqSgFZ6M4/YnoHVWiXDLoNiSbV8QE1EfaUie4Q8t1cLskKuicRY2
	 js6kn6JI9WFsohDyHKW8tdZn3p8PMGxVV6m2Q5upOLldNy113gSO/vRCZA4ENtK8S5
	 yAs6BEbzEfbBA==
Received: by gentwo.org (Postfix, from userid 1003)
	id 8475940A93; Tue,  6 Feb 2024 10:09:59 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 83AC940788;
	Tue,  6 Feb 2024 10:09:59 -0800 (PST)
Date: Tue, 6 Feb 2024 10:09:59 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: catalin.marinas@arm.com, Will Deacon <will@kernel.org>
cc: Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com, 
    Valentin.Schneider@arm.com, akpm@linux-foundation.org, 
    anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>, 
    dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk, 
    robin.murphy@arm.com, vanshikonda@os.amperecomputing.com, 
    yang@os.amperecomputing.com
Subject: [PATCH REPOST v2] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Message-ID: <e0d41efb-a74e-6bb5-f325-63d42358c802@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Can we get this merged for 6.9? The patch has been around for awhile now.



Ampere Computing develops high end ARM processor that support an ever
increasing number of processors. The default 256 processors are
not enough for our newer products. The default is used by
distros and therefore our customers cannot use distro kernels because
the number of processors is not supported.

One of the objections against earlier patches to increase the limit
was that the memory use becomes too high. There is a feature called
CPUMASK_OFFSTACK that configures the cpumasks in the kernel to be
dynamically allocated. This was used in the X86 architecture in the
past to enable support for larger CPU configurations up to 8k cpus.

With that is becomes possible to dynamically size the allocation of
the cpu bitmaps depending on the quantity of processors detected on
bootup.

This patch enables that logic if more than 256 processors
are configured and increases the default to 512 processors.

Further increases may be needed if ARM processor vendors start
supporting more processors. Given the current inflationary trends
in core counts from multiple processor manufacturers this may occur.

Tested-by: Eric Mackay <eric.mackay@oracle.com>
Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>

---

Original post: https://www.spinics.net/lists/linux-mm/msg369701.html

V1->V2

- Keep quotation marks
- Remove whiltespace damage
- Add tested by


Index: linux/arch/arm64/Kconfig
===================================================================
--- linux.orig/arch/arm64/Kconfig
+++ linux/arch/arm64/Kconfig
@@ -1407,7 +1407,21 @@ config SCHED_SMT
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
+config CPUMASK_OFFSTACK
+	def_bool y
+	depends on NR_CPUS > 256

   config HOTPLUG_CPU
   	bool "Support for hot-pluggable CPUs"

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

