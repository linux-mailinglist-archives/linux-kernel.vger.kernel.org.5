Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E87A0294
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbjINL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjINL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD18C1FC4;
        Thu, 14 Sep 2023 04:27:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRBlDdvNX+xiBakKbGmgdBA7yGQ28OOQgzP56FD+i7o=;
        b=4eBXmGwcp83L99p3eMsO+ARfOgjRZqEqHGoDav2I0yZssORjx44c7YX1C9ywMIAVebEq3u
        hUPWQkobsA3tavka9SESEfMjqIZjEFaP6OwvlRdxwbsakwbBAIz1ojG5TqOt6SzHKJbdZe
        KyYzu7a+m2fZBhcCfDVhmsQYXrMpNNL9+/uNKSSopNrY20iCGrXMIagm5EKjnzBhpK336y
        zV0FmdNXyafLXBGs6qFY9/BWDUmlMUwseCv2ANIAd99QwHq6FnGrL9cJfbXbRIgxY+rydq
        OUuYzkYVp6zsAdDWh7JWhL62GR7Bk+aKaBH2X2nb8sezDIBOJe+V600zp3eJ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690824;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRBlDdvNX+xiBakKbGmgdBA7yGQ28OOQgzP56FD+i7o=;
        b=In2b9ZSlDBtF2SH7VtsLcsUbsaHO229ih/cCaClOJpQrPZQ1AVpZc+vjaMh0fvxSlgtGOX
        EOoWkNhY+5FHdtDw==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Compile entry_SYSCALL32_ignore() unconditionally
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-4-nik.borisov@suse.com>
References: <20230623111409.3047467-4-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082375.27769.12443727333195550673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     370dcd58548a360bbf8a65b89b410d09f56bf0c6
Gitweb:        https://git.kernel.org/tip/370dcd58548a360bbf8a65b89b410d09f56bf0c6
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:06 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86/entry: Compile entry_SYSCALL32_ignore() unconditionally

To limit the IA32 exposure on 64bit kernels while keeping the
flexibility for the user to enable it when required, the compile time
enable/disable via CONFIG_IA32_EMULATION is not good enough and will
be complemented with a kernel command line option.

Right now entry_SYSCALL32_ignore() is only compiled when
CONFIG_IA32_EMULATION=n, but boot-time enable- / disablement obviously
requires it to be unconditionally available.

Remove the #ifndef CONFIG_IA32_EMULATION guard.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-4-nik.borisov@suse.com

---
 arch/x86/entry/entry_64.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3be71ac..f71664d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1511,7 +1511,6 @@ nmi_restore:
 	iretq
 SYM_CODE_END(asm_exc_nmi)
 
-#ifndef CONFIG_IA32_EMULATION
 /*
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
@@ -1522,7 +1521,6 @@ SYM_CODE_START(entry_SYSCALL32_ignore)
 	mov	$-ENOSYS, %eax
 	sysretl
 SYM_CODE_END(entry_SYSCALL32_ignore)
-#endif
 
 .pushsection .text, "ax"
 	__FUNC_ALIGN
