Return-Path: <linux-kernel+bounces-36200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFE839D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5EA1F24004
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F93654BD1;
	Tue, 23 Jan 2024 23:55:26 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064854279
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054126; cv=none; b=SaQtiDpoviB+io7kjbxWqoPW9aUBF2f99K/+UqMEnyNPM9U7LpmxHB9djzAjZPsZSI5nAotDe8Ejwz7XojqDpZM7PIdlAocS23saqTiXYyO0Z8JvqnUyt7luchMEvQTY1nkOXXvHcSbyg1QyZ8vjRQylIEVtUIbjzkDEC0xBuqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054126; c=relaxed/simple;
	bh=C5xMKVjqOXilRG6ejuzDVLIExZYLJBWitpCA1gXEet0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cAsf9CuCKZhevJm/XQI/RUrcUgNqgwEN/4XKuhiGVDq/nhrBphROejYlSNBcqxA5PR20hB3rPK5rKZWdisDgY3mKt6H4sjYfZBiDOSDw2cw7p1TJIpOSUJpkvJpnKGSxTtOFsUCQnBogHnukxVPiM2XNv3llcY8bTywwGmZJF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 0EC8640A93; Tue, 23 Jan 2024 15:55:17 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0B6AC40788;
	Tue, 23 Jan 2024 15:55:17 -0800 (PST)
Date: Tue, 23 Jan 2024 15:55:17 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Eric Mackay <eric.mackay@oracle.com>
cc: Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com, 
    Valentin.Schneider@arm.com, akpm@linux-foundation.org, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, 
    dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk, 
    robin.murphy@arm.com, vanshikonda@os.amperecomputing.com, 
    yang@os.amperecomputing.com
Subject: [PATCH v2] ARM64: Dynamically allocate cpumasks and increase supported
 CPUs to 512
In-Reply-To: <20240118175350.23344-1-eric.mackay@oracle.com>
Message-ID: <7ab6660e-e69f-a64b-0de3-b8dde14f79fa@linux.com>
References: <affb2c00-695a-47af-77f6-ea1c3f298fb7@linux.com> <20240118175350.23344-1-eric.mackay@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

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

