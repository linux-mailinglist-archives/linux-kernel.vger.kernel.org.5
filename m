Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8CD7B5B7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbjJBTlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJBTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:41:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A63A9;
        Mon,  2 Oct 2023 12:41:05 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:41:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696275664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA8px2Gs5zicIf3ntSyEajmuGJx7VXeR5XlyhlMdO4o=;
        b=v6zqlENEQnGO4kWR/9Nx7ejWOe62pY6AYBvpPLgKiY1qucegi+0N2uZF+Is82M49QFzE91
        rJeAYp7L5yMD1akzeocaobLysn+sBNZMYA1mhXNjAFy9p4e0lu1sm+GZit7Pr6PnBSCddM
        Cf6eqrImQXmMwAHZrqFCGh43+QPd2gYjnpO3NXIDB1UfFawDYkVRRI9pXVbGkOJviIhPZZ
        ei9DNuRaw3YtATxMmcmKFmOxI6aNqr1AOMarEs+ZYUm+xrC0AUJ31bXiAuI/mjQjGSH+n0
        O3mflOHRq2zomivmyJPzcrMj2hmFSaG1miW28mkEGuLTjzCK5OYZO0j7Yg535A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696275664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA8px2Gs5zicIf3ntSyEajmuGJx7VXeR5XlyhlMdO4o=;
        b=DnHtqKhIrFeqqu+r+mohesOs43Edd0brDinvYpKAwy12DQD+D3Wxvk3wkJ8rKVvgd7NMwl
        j9Jyy8mH9Su5onDw==
From:   "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/numa: Add Devicetree support
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1692949657-16446-2-git-send-email-ssengar@linux.microsoft.com>
References: <1692949657-16446-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Message-ID: <169627566214.3135.17645034772157973524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0c436a58292d0ca1af213ede75b2508995c8af0b
Gitweb:        https://git.kernel.org/tip/0c436a58292d0ca1af213ede75b2508995c8af0b
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Fri, 25 Aug 2023 00:47:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 21:30:20 +02:00

x86/numa: Add Devicetree support

Hyper-V has usecases where it needs to fetch NUMA information from
Devicetree. Currently, it is not possible to extract the NUMA information
from Devicetree for the x86 arch.

Add support for Devicetree in the x86_numa_init() function, allowing the
retrieval of NUMA node information from the Devicetree.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/1692949657-16446-2-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/Kconfig   | 1 +
 arch/x86/mm/numa.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfaba..aab5e32 100644
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
index 2aadb20..c79f12e 100644
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
