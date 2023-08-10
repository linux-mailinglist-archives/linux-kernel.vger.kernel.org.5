Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C563377841F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 01:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjHJX3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 19:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHJX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:29:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA32713;
        Thu, 10 Aug 2023 16:29:14 -0700 (PDT)
Date:   Thu, 10 Aug 2023 23:29:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691710151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s6/eWlrGBmoQgTeIP00SjJFdU1Spdew9T7FhL8iIRUk=;
        b=Nx6282sV13GYmDEJ4O2TGsVDHDkFTQRnDyDJ0k9lKu/YDrqpRuM+Uy/0q8Ns60WLxaX2Du
        CkgYwOntgWC3Pxcs0nyngKiT4aN9H83wTIi6du4mMsFGD+sDNF3lsThl9znuRXSXVR4eef
        YRdojjA+mVHe4X9rQTocG2UojKNbRBwnz4dnF5kmsKWqdCZSqNAqWrW+lQwgRwrcsSKi13
        f88+ALHQSStot2NW6MhkkM+T6Loa7hyoGNvNpqsGFiNhJK0k1F/EDjc5E+AyAMUyNqauX6
        ZOSWT2uP96qFoW6ElcX3akESnVwBAHFyEHJrhD6fQ6L3AP05YlLRPQ5YNCmPOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691710151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s6/eWlrGBmoQgTeIP00SjJFdU1Spdew9T7FhL8iIRUk=;
        b=lb3qSkE4F6YVvZR20IdRbcIbhS++S65cTsARG1g0xVTjVN1WvkHf9dxcdTWy09PtQFE1eB
        A7/+Rx0wdmwDFMBQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86: Move gds_ucode_mitigated() declaration to header
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        stable@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169171015065.27769.6154799089887294846.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     eb3515dc99c7c85f4170b50838136b2a193f8012
Gitweb:        https://git.kernel.org/tip/eb3515dc99c7c85f4170b50838136b2a193f8012
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 09 Aug 2023 15:05:00 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 10 Aug 2023 09:13:21 -07:00

x86: Move gds_ucode_mitigated() declaration to header

The declaration got placed in the .c file of the caller, but that
causes a warning for the definition:

arch/x86/kernel/cpu/bugs.c:682:6: error: no previous prototype for 'gds_ucode_mitigated' [-Werror=missing-prototypes]

Move it to a header where both sides can observe it instead.

Fixes: 81ac7e5d74174 ("KVM: Add GDS_NO support to KVM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/all/20230809130530.1913368-2-arnd%40kernel.org
---
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/kvm/x86.c               | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 973db04..4ae2773 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -731,4 +731,6 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif
 
+extern bool gds_ucode_mitigated(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19d9ff9..c381770 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -314,8 +314,6 @@ u64 __read_mostly host_xcr0;
 
 static struct kmem_cache *x86_emulator_cache;
 
-extern bool gds_ucode_mitigated(void);
-
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
