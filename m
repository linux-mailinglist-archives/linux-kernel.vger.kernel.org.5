Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123CB80AA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjLHRRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHRRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B14AD;
        Fri,  8 Dec 2023 09:17:19 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Yn6+t3whdJaatWtaZyPqOxlM5qqFAMKPg+fW99uUtk=;
        b=Q/63yIW4XWtHFFz7HFR5EdHtbeQqJzr3WUeNSWbuP66EjWSDsV7yRIBM6/6xTXt9NgJ2Nc
        Scgt4sTAHGtW/SG2hms5N2u/gIBdbTtSNyfCrtba/yeqikQRqVKDuf8hKCUUW3Dv3VgYSb
        6R03MQsWRtO68jHTelyzjgRO/DwDFa9hAhCl6bFKj0Pky6QOVY1e5j/QrY30lETI7tZivL
        w93LYPRVlu57uN3GieNdMeefwLiAv6cm31i+vJ/G5AJNG4qOBJXZQfP7MzbZ3GHtWI5oMC
        UCg6VcYwAL1ajbHo5kMUn8D+3Nha5qNxvzcfYUAauwXcnuIb3XAPZ5VYrlSLoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055837;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/Yn6+t3whdJaatWtaZyPqOxlM5qqFAMKPg+fW99uUtk=;
        b=K4JxApCAWVCs843dX1yawpt/OPiaDt+dQIMCgWXKpweuq8GVwtwoaptbrPnOj8nkf8YfX5
        /32lRxyk1ridAjCA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Disable TDX host support when kexec is enabled
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205583649.398.11856254981576868481.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     7ba6ac73f8981bd5ae463108757d0d25388affc4
Gitweb:        https://git.kernel.org/tip/7ba6ac73f8981bd5ae463108757d0d25388affc4
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:56 -08:00

x86/virt/tdx: Disable TDX host support when kexec is enabled

TDX host support currently lacks the ability to handle kexec.  Disable TDX
when kexec is enabled.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-20-dave.hansen%40intel.com
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e255d8a..01cdb16 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1973,6 +1973,7 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
+	depends on !KEXEC_CORE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
