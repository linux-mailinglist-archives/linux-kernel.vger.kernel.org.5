Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6727E1971
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKFEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFEvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:51:14 -0500
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5876E1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:51:10 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
        id 0FE2848F5A; Sun,  5 Nov 2023 20:51:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 0D51D48F46;
        Sun,  5 Nov 2023 20:51:09 -0800 (PST)
Date:   Sun, 5 Nov 2023 20:51:09 -0800 (PST)
From:   Christoph Lameter <cl@linux.com>
To:     linux-arm-kernel@lists.infradead.org
cc:     linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
        Valentin.Schneider@arm.com,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [RFC] ARM64: Introduce CONFIG_MAXSMP
Message-ID: <fb0e2c3c-0289-f1ed-102e-219b2f9303d4@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ampere Computing develops high end ARM processors that support an ever
increasing number of processors. The current default of 256 processors is
not enough for our newer products. The default is used by Linux
distros and therefore our customers cannot use distro kernels because
the number of processors is not supported.

The x86 arch has support for a "CONFIG_MAXSMP" configuration option that
enables support for the largest known configurations. This usually means
hundreds or thousands of processors. For those sizes it is no longer
practical to allocate bitmaps of cpus on the kernel stack. There is
a kernel option CONFIG_CPUMASK_OFFSTACK that makes the kernel allocate
and free bitmaps for cpu masks from slab memory instead of keeping it
on the stack etc.

With that is becomes possible to dynamically size the allocation of
the bitmap depending on the quantity of processors detected on
bootup.

This patch enables that logic if CONFIG_MAXSMP is enabled.

If CONFIG_MAXSMP is disabled then a default of 64 processors
is supported. A bitmap for 64 processors fits into one word and
therefore can be efficiently handled on the stack. Using a pointer
to a bitmap would be overkill.

The number of processors can be manually configured if
CONFIG_MAXSMP is not set.

Currently the default for CONFIG_MAXSMP is 512 processors.
This will have to be increased if ARM processor vendors start
supporting more processors.

Signed-off-by: Christoph Lameter (Ampere) <cl@linux.com>

Index: linux/arch/arm64/Kconfig
===================================================================
--- linux.orig/arch/arm64/Kconfig
+++ linux/arch/arm64/Kconfig
@@ -1402,10 +1402,56 @@ config SCHED_SMT
  	  MultiThreading at a cost of slightly increased overhead in some
  	  places. If unsure say N here.

+
+config MAXSMP
+	bool "Compile kernel with support for the maximum number of SMP Processors"
+	depends on SMP && DEBUG_KERNEL
+	select CPUMASK_OFFSTACK
+	help
+	  Enable maximum number of CPUS and NUMA Nodes for this architecture.
+	  If unsure, say N.
+
+#
+# The maximum number of CPUs supported:
+#
+# The main config value is NR_CPUS, which defaults to NR_CPUS_DEFAULT,
+# and which can be configured interactively in the
+# [NR_CPUS_RANGE_BEGIN ... NR_CPUS_RANGE_END] range.
+#
+# ( If MAXSMP is enabled we just use the highest possible value and disable
+#   interactive configuration. )
+#
+
+config NR_CPUS_RANGE_BEGIN
+	int
+	default NR_CPUS_RANGE_END if MAXSMP
+	default    1 if !SMP
+	default    2
+
+config NR_CPUS_RANGE_END
+	int
+	default 8192 if  SMP && CPUMASK_OFFSTACK
+	default  512 if  SMP && !CPUMASK_OFFSTACK
+	default    1 if !SMP
+
+config NR_CPUS_DEFAULT
+	int
+	default  512 if  MAXSMP
+	default   64 if  SMP
+	default    1 if !SMP
+
  config NR_CPUS
-	int "Maximum number of CPUs (2-4096)"
-	range 2 4096
-	default "256"
+	int "Set maximum number of CPUs" if SMP && !MAXSMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
+	help
+	  This allows you to specify the maximum number of CPUs which this
+	  kernel will support.  If CPUMASK_OFFSTACK is enabled, the maximum
+	  supported value is 8192, otherwise the maximum value is 512.  The
+	  minimum value which makes sense is 2.
+
+	  This is purely to save memory: each supported CPU adds about 8KB
+	  to the kernel image.

  config HOTPLUG_CPU
  	bool "Support for hot-pluggable CPUs"
Index: linux/arch/arm64/configs/defconfig
===================================================================
--- linux.orig/arch/arm64/configs/defconfig
+++ linux/arch/arm64/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_TASK_IO_ACCOUNTING=y
  CONFIG_IKCONFIG=y
  CONFIG_IKCONFIG_PROC=y
  CONFIG_NUMA_BALANCING=y
+CONFIG_MAXSMP=y
  CONFIG_MEMCG=y
  CONFIG_BLK_CGROUP=y
  CONFIG_CGROUP_PIDS=y
