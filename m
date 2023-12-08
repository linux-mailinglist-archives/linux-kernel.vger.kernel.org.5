Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9791580AC96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjLHTBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549910E0;
        Fri,  8 Dec 2023 11:01:05 -0800 (PST)
Date:   Fri, 08 Dec 2023 19:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702062063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e0J+xS1mZ0HHT3NUtIj/bIdGlok1FYUU5yuG+3+ws1Y=;
        b=2FRlEOOua6dxLXIWPL2BsQyRzNLgEiDIs0o9g6S6VwVZ5SYUrHdnU751aMAwPyjE6jko0N
        5TlI8H2LnQK88Fk5K7e5q3dP2i8oWZULat7Tn+zbsCk0ZMcd9xeIzxQux0M5FeP/UYbtRt
        XfCcSkpHd4YofnKWxcG95UTxv+4AOCu/B/WxKZgH/qpofqDsBoOXrffJvlWGFrp9wVhx99
        Sh9Hna7UoYQyGPHPdSqUnB8Adnu2y7YMXalCEth7Z0YEpOeUl6Ygh6+LeCDwFPR6D9Y/e2
        u/O0FYTZ4cn0+dW4Crt7rKLL2L2ag59k0k416J+o1y0Z50B2JuxpijJOwLURVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702062063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e0J+xS1mZ0HHT3NUtIj/bIdGlok1FYUU5yuG+3+ws1Y=;
        b=1tBNGpYZOfQeB3He5ncNiW468Fdaj/DB1IuvnBex6JRBIaPSoV4u8T0qCWfq5EGLZPrUxr
        WF2ldbPpFomeAJDg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Disable TDX host support when kexec is enabled
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170206206183.398.10384727190560172183.tip-bot2@tip-bot2>
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

Commit-ID:     1363d55c108dfb6280f55a7f5b149017879fe23b
Gitweb:        https://git.kernel.org/tip/1363d55c108dfb6280f55a7f5b149017879fe23b
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:17:32 -08:00

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
