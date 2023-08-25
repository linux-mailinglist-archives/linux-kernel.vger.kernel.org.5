Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199DF788137
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbjHYHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbjHYHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:47:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33F8E1FCA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:47:42 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9B4C52127C8D;
        Fri, 25 Aug 2023 00:47:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B4C52127C8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692949661;
        bh=cKXYj+kO59fIp3emYh3qbh+q8zVOQYiiaCp08jZX+RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crSQa6qMj+z9MptiO3x9x6K6NwdtRKwArb+/9G/swA64+RzCLrOa67vDFpM3fbL1K
         xEnvK34ZOEs75zRrrkyiggMN3YFMVRxWYyYl05ZJoBfsU9dv5r2uSRDakweMWywjXE
         ZSbmsH4tMg6W8ErCPV2eFKmTV7FMQOeYSsMH1aho=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: [PATCH v2 2/2] x86/numa: Add Devicetree support
Date:   Fri, 25 Aug 2023 00:47:37 -0700
Message-Id: <1692949657-16446-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
References: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V has usecases where it need to fetch NUMA information from
Devicetree. Currently, it is not possible to extract the NUMA information
from Devicetree for x86 arch.

Add support for Devicetree in the x86_numa_init function, allowing the
retrieval of NUMA node information from the Devicetree.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/Kconfig   | 1 +
 arch/x86/mm/numa.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..16ac287e9628 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1534,6 +1534,7 @@ config NUMA
 	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
 	default y if X86_BIGSMP
 	select USE_PERCPU_NUMA_NODE_ID
+	select OF_NUMA if OF
 	help
 	  Enable NUMA (Non-Uniform Memory Access) support.
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..c79f12e449ea 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -3,6 +3,7 @@
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
@@ -733,6 +734,8 @@ void __init x86_numa_init(void)
 		if (!numa_init(amd_numa_init))
 			return;
 #endif
+		if (acpi_disabled && !numa_init(of_numa_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
-- 
2.34.1

