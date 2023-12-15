Return-Path: <linux-kernel+bounces-273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073A4813E89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAA8B21C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BA4815;
	Fri, 15 Dec 2023 00:06:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859507EA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 8FEFF40E8E; Thu, 14 Dec 2023 16:05:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 8D6B440E89;
	Thu, 14 Dec 2023 16:05:56 -0800 (PST)
Date: Thu, 14 Dec 2023 16:05:56 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Valentin.Schneider@arm.com, 
    Vanshidhar Konda <vanshikonda@os.amperecomputing.com>, 
    Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Robin Murphy <robin.murphy@arm.com>, 
    Dave Kleikamp <dave.kleikamp@oracle.com>, 
    Matteo Carlini <Matteo.Carlini@arm.com>, akpm@linux-foundation.org, 
    yang@os.amperecomputing.com
Subject: [PATCH] ARM64: Dynamically allocate cpumasks and increase supported
 CPUs to 512
Message-ID: <794a1211-630b-3ee5-55a3-c06f10df1490@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

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

Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>

---

This was discussed earlier and this updated patch was proposed at 
https://lore.kernel.org/linux-arm-kernel/6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org/T/


Index: linux/arch/arm64/Kconfig
===================================================================
--- linux.orig/arch/arm64/Kconfig
+++ linux/arch/arm64/Kconfig
@@ -1407,7 +1407,21 @@ config SCHED_SMT
   config NR_CPUS
   	int "Maximum number of CPUs (2-4096)"
   	range 2 4096
-	default "256"
+	default 512
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



