Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1067B2738
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjI1VLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjI1VLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847051A4;
        Thu, 28 Sep 2023 14:11:45 -0700 (PDT)
Date:   Thu, 28 Sep 2023 21:11:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695935504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7sigFB184YC/SX6XMhV2FIvnc162HpcpbCQDua+9fg=;
        b=WMQg8b6c5ytFhetly6y2zJQaK8TbQgHm8Z3IpIJ0kjaTwNdYBoYHOAqgVA9X5VZXcXkrY/
        RpIGvPGTpFwdCwGfJs4grr1O8qXZRMbmcv7bzHkMCZqBzVBN6NLXf7zHcrhRMmlY1d5Hf3
        dpzyt+ypyJnu4MBqupDCbYCpdYYz33X39UoJfRADOVso7fibsrYg3/ch3Cob7hS8OvHjHT
        9PmlbvDUwdgPyvEm1X8aieiCoqYoY1v9PIQpC/OMkQXwYcxFCBxNjc0N18Wt4QlkfjbN7o
        8N4W6G/lcXcIdRaooeQNf04m45WCCXxthPetqagr3ova+53DDoM1qJsx7QJ52g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695935504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7sigFB184YC/SX6XMhV2FIvnc162HpcpbCQDua+9fg=;
        b=TQ4WV/LfFYDQk+s7osTutVt3WhmoBZ587ugS5qniCb7jFYp2vgc86wKaY0yUyq8yMDvMiD
        ZkZrp7D9h9bM5/Dg==
From:   "tip-bot2 for Adam Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Adam Dunlap <acdunlap@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jacob Xu <jacobhxu@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912002703.3924521-2-acdunlap@google.com>
References: <20230912002703.3924521-2-acdunlap@google.com>
MIME-Version: 1.0
Message-ID: <169593550362.27769.15603585869717433478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f79936545fb122856bd78b189d3c7ee59928c751
Gitweb:        https://git.kernel.org/tip/f79936545fb122856bd78b189d3c7ee59928c751
Author:        Adam Dunlap <acdunlap@google.com>
AuthorDate:    Mon, 11 Sep 2023 17:27:02 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Sep 2023 22:49:35 +02:00

x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Previously, if copy_from_kernel_nofault() was called before
boot_cpu_data.x86_virt_bits was set up, then it would trigger undefined
behavior due to a shift by 64.

This ended up causing boot failures in the latest version of ubuntu2204
in the gcp project when using SEV-SNP.

Specifically, this function is called during an early #VC handler which
is triggered by a CPUID to check if NX is implemented.

Fixes: 1aa9aa8ee517 ("x86/sev-es: Setup GHCB-based boot #VC handler")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Adam Dunlap <acdunlap@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jacob Xu <jacobhxu@google.com>
Link: https://lore.kernel.org/r/20230912002703.3924521-2-acdunlap@google.com
---
 arch/x86/mm/maccess.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 5a53c2c..6993f02 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -9,12 +9,21 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
 	/*
-	 * Range covering the highest possible canonical userspace address
-	 * as well as non-canonical address range. For the canonical range
-	 * we also need to include the userspace guard page.
+	 * Do not allow userspace addresses.  This disallows
+	 * normal userspace and the userspace guard page:
 	 */
-	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
-	       __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
+	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
+		return false;
+
+	/*
+	 * Allow everything during early boot before 'x86_virt_bits'
+	 * is initialized.  Needed for instruction decoding in early
+	 * exception handlers.
+	 */
+	if (!boot_cpu_data.x86_virt_bits)
+		return true;
+
+	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
