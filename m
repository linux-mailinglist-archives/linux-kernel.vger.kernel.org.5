Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90F7C435E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjJJWEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJJWEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:04:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26C98;
        Tue, 10 Oct 2023 15:04:11 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:04:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696975450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/9Sso2alxhsb0I75/YmVzI4zCmw+dUkaR4lEvo/XEU=;
        b=Vn0PBfL+YE2HoK+kf5JJ38nxe6DUwGKUUM4+2XPmn1C+0sB4YHFP+KbBGCDlWA6wnvEEHD
        hiMSWkKgomRpbZDpXxQtEAuCJhO/0Yg2LuXj+kFVOTEAaichDp1XYwVQXNNQGKhsUlYc4F
        6HLArONryo2BJchVj6Zb5b4VVLkKxisNuhlLmdLQzBFHvb7XJG7IHfGpkfxuyVOgF/7DIm
        yXoYR4XMnDmz9IYJg++LmwpQ/HKKpasBTR8MvNhqz4aWAZSk9/8BcMuN9FMfk4YiJZD2Bp
        d2eUk0DJieOcaRG4aw56kfTISX+U9lSbP2ibohU+QksC33ictZYwcRVgv8mahw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696975450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/9Sso2alxhsb0I75/YmVzI4zCmw+dUkaR4lEvo/XEU=;
        b=g/4XYwMeRhbzqu/smi6nubCAnhTy4cv3A2z8PywVtN7+shujPsPc63XYs1YWRkAO/UW6VP
        npKeEwntNJpe2WBw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Disable named address spaces for KASAN
Cc:     kernel test robot <oliver.sang@intel.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231009151409.53656-1-ubizjak@gmail.com>
References: <20231009151409.53656-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169697544974.3135.4822379707412006238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     e29aad08b1da7772b362537be32335c0394e65fe
Gitweb:        https://git.kernel.org/tip/e29aad08b1da7772b362537be32335c0394e65fe
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 09 Oct 2023 17:13:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Oct 2023 23:57:35 +02:00

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
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
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
