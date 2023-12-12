Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA280F39C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376411AbjLLQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjLLQwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:52:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E62A6;
        Tue, 12 Dec 2023 08:52:26 -0800 (PST)
Date:   Tue, 12 Dec 2023 16:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702399945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CBQKIzBHvmHbFR0vvi376YhJIbWWWEO5G2eP0prtvbI=;
        b=ihjxz0sF9EMfdrXZE9M7sw6d2WwZNp2UD/O/wlnQoC4vb9qGPnOstrKX/4rKPs4IC8vnEA
        01Erm3rupejesrugmfuoAv9rAvgrvzi7c25ppmbC41BU9XGtH65AiQw/NndczY1FLfnivr
        6V79Fzaujo9H0a7pKYLQgKUAVaHuPlZuA+OFYojnnrTXpb5Nh0WEZ3H9R3RWOlb75LBAU4
        OXufRjjUOiA07iOIEdiBSjFXFqCq5Qrn8MtWYfXqapFsEk8na1G5AGmphGHKl3FKEm0emt
        SrDbSEXza2ycje/6ZpiHnnRv/XAP1Iaw20cfqvf95GxIa0Se2Cpwkoc8E/rm6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702399945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CBQKIzBHvmHbFR0vvi376YhJIbWWWEO5G2eP0prtvbI=;
        b=oYq6InmoULF4ET5l3925YZqEEpk5ED497mTr4Q68QhIQm9zDv50zlhtgr+Xsrbv3T8TcYU
        pAqSXFzPnOx/x0Bw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Disable TDX host support when kexec is enabled
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170239994445.398.4539362134762884474.tip-bot2@tip-bot2>
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

Commit-ID:     cb8eb06d50fcf4a478813a612f68c38cca45c742
Gitweb:        https://git.kernel.org/tip/cb8eb06d50fcf4a478813a612f68c38cca45c742
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Dec 2023 08:46:46 -08:00

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
