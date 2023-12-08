Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698B80AA85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574542AbjLHRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjLHRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F5619B7;
        Fri,  8 Dec 2023 09:17:31 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6sn/q+Lf9Vys8HE8Q9OZp/hbFWi+ZcNFf4rbDZnvtG0=;
        b=P65HzoyrqomKcJ1af6uUqxwjqj2xGIjDnT2pgXIi6baPTSUp9UN8pJaMX9h4wG3yk35U84
        QhzElKnaoY14m5L0K4yW8eLaTWuAIZptB03RMSmWeZ4jh5Ovpm1UC/EJukZI1Qr/40pI2l
        XKiUh2uwdV9zxL3yk4Fh2egpFPEKcXC49I+hxzGSxisXAQTXARyV7rPaPwlXnKtYB0fdSU
        C2UqmVzhMljdWyCJNW4hmcT86Vtkdd6L5mhMuTKUjj3gqZ/pkdzaAbf57V8kJI1K4wZcC8
        8fI/UJnB4bcEZf5C09Rxe5smQr6Mc3ZnEVdGrrBz8uSlCYowadnVoExKMdBgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6sn/q+Lf9Vys8HE8Q9OZp/hbFWi+ZcNFf4rbDZnvtG0=;
        b=qg+vpTrB7Bd216HtZswJ6mGVlw10jxvV23aK9g7lTasyApqHPMK5bI7vF6Rs+CW7tBPx+M
        B6G5CRNQlqRiYTBA==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Make INTEL_TDX_HOST depend on X86_X2APIC
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205584919.398.2651946847851808390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     3115cabd935ade76fbe61154d1e405158e548272
Gitweb:        https://git.kernel.org/tip/3115cabd935ade76fbe61154d1e405158e548272
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:23 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:03 -08:00

x86/virt/tdx: Make INTEL_TDX_HOST depend on X86_X2APIC

TDX capable platforms are locked to X2APIC mode and cannot fall back to
the legacy xAPIC mode when TDX is enabled by the BIOS.  TDX host support
requires x2APIC.  Make INTEL_TDX_HOST depend on X86_X2APIC.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/lkml/ba80b303-31bf-d44a-b05d-5c0f83038798@intel.com/
Link: https://lore.kernel.org/all/20231208170740.53979-3-dave.hansen%40intel.com
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41..eb6e639 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1970,6 +1970,7 @@ config INTEL_TDX_HOST
 	depends on CPU_SUP_INTEL
 	depends on X86_64
 	depends on KVM_INTEL
+	depends on X86_X2APIC
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
