Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10136803D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjLDStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjLDStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:49:19 -0500
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E006AF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:49:25 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id C612C48F40; Mon,  4 Dec 2023 10:49:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id C4BA448F2E;
        Mon,  4 Dec 2023 10:49:24 -0800 (PST)
Date:   Mon, 4 Dec 2023 10:49:24 -0800 (PST)
From:   "Christoph Lameter (Ampere)" <cl@linux.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Matteo Carlini <Matteo.Carlini@arm.com>
Subject: [PATCH] ARM64: Dynamicaly allocate cpumasks and increase supported
 CPUs to 512 (was: CONFIG_MAXSMP to allow up to 512 cpus)
In-Reply-To: <01d7531b-3d5c-989d-58ac-60861249fd3e@linux.com>
Message-ID: <8c21b27a-fbab-890d-40d2-ba460b0e3900@linux.com>
References: <6a854175-5f89-c754-17b8-deda18447f1f@gentwo.org> <52b8a7d8-aa4c-46db-a7f5-f36c92ad5380@arm.com> <01d7531b-3d5c-989d-58ac-60861249fd3e@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New version of the patch after feedback from Catalin:


From: Christoph Lameter (Ampere) <cl@linux.com>
Subject: [PATCH] ARM64: Dynamicaly allocate cpumasks and increase supported CPUs to 512

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
