Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA137D0EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbjJTLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377216AbjJTLmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:42:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5A1735;
        Fri, 20 Oct 2023 04:38:40 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/anh6AC/AwmDf2AAEdv/RKw3Yf0xO05F/r1eb9NtfLk=;
        b=HnF17PevroPiBpl3l3wv0dbUWeB0kr1TJVXgG7QQbZ4Xrs6pMGzKq4Mhrgy9GlT6a89uMs
        8QjY7BNaCDnO9y5x480L1KzyS7Umzqw8+KD3DTfFW2XtlvaSH82Adc0DhH1J8Ic8yThJnn
        OX3jKOX9+t5Bhi2Sq8Q3UNIoMEdvcRpc9hiht/DHKpsByjucmMeSX2e1UbRr/Vzvg/MgOH
        QV5yq5ZTwiS3/kYfVd3gVzp/9aM7d+/sdcsfbYT/RnJfNa5jMzzXSTqkDQhEmx28qkOGIl
        6JVSnPtAeN1wHGQ/h5zeNfl+rPCkyvl9+OpEbdLzNAsIz5kSvOcyjOtruS6V/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/anh6AC/AwmDf2AAEdv/RKw3Yf0xO05F/r1eb9NtfLk=;
        b=VIpXVuf7GEH8KBN2FEWORPOK6G+uq1eHN1Apf5/uAF2dl4Ae/8U1GIbKROwDIRcKIFoa7e
        8VXhdcgI3KQi+tCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Provide CONFIG_MICROCODE_INITRD32
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.236208250@linutronix.de>
References: <20231017211722.236208250@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188387.3135.6426131850936558292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     fdbd43819400e74c1c20a646969ea8f71706eb2b
Gitweb:        https://git.kernel.org/tip/fdbd43819400e74c1c20a646969ea8f71706eb2b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 18:28:41 +02:00

x86/microcode: Provide CONFIG_MICROCODE_INITRD32

Create an aggregate config switch which covers X86_32, MICROCODE and
BLK_DEV_INITRD to avoid lengthy #ifdeffery in upcoming code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.236208250@linutronix.de
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfaba..011cb7f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1313,6 +1313,10 @@ config MICROCODE
 	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
 
+config MICROCODE_INITRD32
+	def_bool y
+	depends on MICROCODE && X86_32 && BLK_DEV_INITRD
+
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n
