Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35697FEE93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345242AbjK3MGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345246AbjK3MGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:06:03 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE77510E0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:06:09 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54A8740E0030;
        Thu, 30 Nov 2023 12:06:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bpf7qVXMcwnS; Thu, 30 Nov 2023 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701345962; bh=9dP0TJJ/LppPdb/yXwY5SKXW1CExGOh+BdZLgiaBTbM=;
        h=From:To:Cc:Subject:Date:From;
        b=d+EtK9AbBkaBLtMgxJc07DZcfspYT50ovqdM8WcqFicXGq+MYRMnQTCBZhJhZqGCs
         fL74vxDeceFITqOzsrAkPd2PwVYi42IFQ0U+JCT8J3tZCppH7Nkhck9PL3/OooDMEB
         xpoK+eOFR/kYOP/ZTjw6fr/0f9K2mljpLSAx5z+XlBW7TH9QlfQrzon/nHNv5Wyatc
         scYj/d5nCWUp7HIRj9X3hfAhwAO6o4uaI2bzxb8xuHVM/jlpm+iJ99ZcGvq+7UexUL
         WVtlpbzlttlNvmxCL1Dnu6akTQyQeI+5f3vNahs8nxZMMol9nQoVwcJur1JfuiLRnD
         P4X52x5cGmoLBl296uxLdRgEHkClbgFNMor1S7A/Bl96But+ofS6GG4qmDAV9s1q8P
         ll/pcstH9Fg0d930IN1YKoLqLKmuNSKCt3c63DV4xPSctnxIGO0QNVrOwj+dqQVmf9
         x53G933ObPGEFGaVhP3mkQ4NEQUQh7Z1WqVLGBsmCes7c87xO7/i9BTZ/zYqAN6rWi
         aKHv9VCEMI8DvK7haLg10k4h6Ks2YszxABLiCtL1cJgTRGLGhnBP6w08Ujhgen0L7C
         gkVDeySsQYgrpK8wqp/vVJS8pajQl2eCicmqDpqRN2PMfNo2Qghkja5PGuVgaFNa4Q
         8Af7ci/xwICI2u51nf7NV/7k=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4840440E0173;
        Thu, 30 Nov 2023 12:06:00 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Date:   Thu, 30 Nov 2023 13:05:52 +0100
Message-ID: <20231130120552.6735-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Having KASLR enabled makes debugging a kernel completely useless because
virtual addresses are not stable, leading to people poking at kernel
internals to have to go and rebuild with RANDOMIZE_BASE=3Doff.

Just disable it on debugging builds where it is not needed anyway.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c456c9b1fc7c..da94354b1b75 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2159,7 +2159,7 @@ config RELOCATABLE
=20
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image (KASLR)"
-	depends on RELOCATABLE
+	depends on RELOCATABLE && !DEBUG_KERNEL
 	default y
 	help
 	  In support of Kernel Address Space Layout Randomization (KASLR),
--=20
2.42.0.rc0.25.ga82fb66fed25

