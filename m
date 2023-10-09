Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9A7BE555
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377016AbjJIPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377008AbjJIPsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:48:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8979F;
        Mon,  9 Oct 2023 08:48:50 -0700 (PDT)
Date:   Mon, 09 Oct 2023 15:48:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696866529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+oVfTqC76j1KleFzCRJpniXRpnWmOtaWGkOw3CLm40=;
        b=fWgVwznJNgeb84FfDdHd94HRXiUBq0xYEEt0oszfFWhUYRWaUgpDt2XWwWymndEwNn+9Ww
        0A54jIrPgv1iY3w0VeIkT4ZyE3bcYf7tfNABXRN2uSESargfl+qrwMVQs8wQEB4wu/Sjpr
        Ky0qnszVHHk7WQ7ZGz7BqFicf4VS3hSCgm7s7YVPX3abWZx1I9uwkBy8LoRTUwiOytN3L3
        IVJcXPUvrdmPFbewpeEGag8dtrfddxWToCfz31NyHF5FJTTWSqca4cCc4DLNyGe9NVh5rE
        MDLePgdICsD+wTBV6KwyX+qos7LmVkBbxRUoLoRSDOfE5BjqJUoe/qTx4oZ6dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696866529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+oVfTqC76j1KleFzCRJpniXRpnWmOtaWGkOw3CLm40=;
        b=hy+xM6zhPbLTGo3aOxhEEYGNSFGnFR3S2eZS930IepxoEgSOhnUx00fK3w7RP2QYBu2XVd
        UO2bL9+lFiRLXQAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Disable named address spaces for KASAN
Cc:     kernel test robot <oliver.sang@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009151409.53656-1-ubizjak@gmail.com>
References: <20231009151409.53656-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169686652860.3135.1102963688830441762.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     a3c7a64f9b764e200338130253dfe4488db03f4f
Gitweb:        https://git.kernel.org/tip/a3c7a64f9b764e200338130253dfe4488db03f4f
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 09 Oct 2023 17:13:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 17:45:05 +02:00

x86/percpu: Disable named address spaces for KASAN

-fsanitize=kernel-address (KASAN) is at the moment incompatible
with named address spaces - see GCC PR sanitizer/111736:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736

GCC is doing a KASAN check on a percpu address which it shouldn't do,
and didn't used to do because we did the access using inline asm.

But now that GCC does the accesses as normal (albeit special address
space) memory accesses, the KASAN code triggers on them too, and it
all goes to hell in a handbasket very quickly.

Those percpu accessor functions need to disable any KASAN
checking or other sanitizer checking. Not on the percpu address,
because that's not a "real" address, it's obviously just the offset
from the segment register.

And GCC should probably not have generated such code in the first
place, so arguably this is a bug with -fsanitize=kernel-address.

The patch also removes a stale dependency on CONFIG_SMP.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231009151409.53656-1-ubizjak@gmail.com

Closes: https://lore.kernel.org/oe-lkp/202310071301.a5113890-oliver.sang@intel.com
---
 arch/x86/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ecb2569..54e79d3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2393,7 +2393,12 @@ config CC_HAS_NAMED_AS
 
 config USE_X86_SEG_SUPPORT
 	def_bool y
-	depends on CC_HAS_NAMED_AS && SMP
+	depends on CC_HAS_NAMED_AS
+	#
+	# -fsanitize=kernel-address (KASAN) is at the moment incompatible
+	# with named address spaces - see GCC PR sanitizer/111736.
+	#
+	depends on !KASAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
