Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BBF7AC86E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIXNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjIXNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:16:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82F71723;
        Sun, 24 Sep 2023 06:16:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C82C43397;
        Sun, 24 Sep 2023 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561375;
        bh=CPD5cAd3UaaukwSt0nuFKO6B+Lw57G4Q75f27knbMNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKjgorE/VBuVrL8fzaRRxCDHSK2zvsj1/Yrju+/7bwTWnMLtF9NjG4QCBSeUuerQg
         ysdRI1Z63XUE9RE9fO6dpoLjkfAPveP/pL6f8yl96rlJ77fAfieH4g6BiCd59QP5zt
         IJKdtksbTqvYkCd4wEUF3ukx6ZIlGrWtqk3p+ekJS8ab9QSgpA+uFxIzrUaxS5Smt9
         lFU9MZ3NzWBqU+qJVG99c9pc+crF83RG5bCaTH6cLKRHHaHtzVCV9iNt/Ub/On4zsD
         3q9WS9pJQIQDw00C8Kw29hIre0Utr/GZ/lX5EUa3RPjRQoilWJBYCV+FKtMV95FEl2
         eru8ndDMAMKIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org
Subject: [PATCH AUTOSEL 6.5 20/41] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
Date:   Sun, 24 Sep 2023 09:15:08 -0400
Message-Id: <20230924131529.1275335-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit aba7e066c738d4b349413a271b2a236aa55bacbc ]

CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
to provide the required information about the EFI runtime mappings to
the incoming kernel, regardless of whether kexec_load() or
kexec_file_load() is being used. Without this information, kexec boot in
EFI mode is not possible.

The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
CONFIG_EXPERT is enabled, so that it can be turned on for debugging
purposes even if KEXEC is not enabled. However, the upshot of this is
that it can also be disabled even when it shouldn't.

So tweak the Kconfig declarations to avoid this situation.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14f..68ce4f786dcd1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1955,6 +1955,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_RUNTIME_WRAPPERS
 	select ARCH_USE_MEMREMAP_PROT
+	select EFI_RUNTIME_MAP if KEXEC_CORE
 	help
 	  This enables the kernel to use EFI runtime services that are
 	  available (such as the EFI variable services).
@@ -2030,7 +2031,6 @@ config EFI_MAX_FAKE_MEM
 config EFI_RUNTIME_MAP
 	bool "Export EFI runtime maps to sysfs" if EXPERT
 	depends on EFI
-	default KEXEC_CORE
 	help
 	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
 	  That memory map is required by the 2nd kernel to set up EFI virtual
-- 
2.40.1

