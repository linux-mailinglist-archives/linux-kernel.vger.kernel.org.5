Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989C7BA59D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbjJEQSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbjJEQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A1D7A88;
        Thu,  5 Oct 2023 00:20:21 -0700 (PDT)
Date:   Thu, 05 Oct 2023 07:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696490418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTTaaaHUArHDIckU4VjtEm1/89+COnB9H9apqfgESMg=;
        b=LHoilc1NEVEyzWv2dAp99zCSgkT5FDatf1kPASupwJya2U1ecXsG2mv+Xm1zeGJgHXld0L
        hZ8tZKfA3Bzr5py0I9asKc14QiRFkrtBebcbKI0t+S024DeA2EbKpDOsatN8tFM3lst0rj
        bsLCmojiIr2skLUO+50pNYfds3iyIAKyDj7i1X6yven7s1fx52GQkHcMGXcma5WuBQadKj
        rGcmX3u7NbnfTTSed3kAlIPB+NgANGc2SXOqrd/eQc5p8Igzsuwz/zvkYxm0xDQ3+U7vJV
        ZmYQmEZoSdDtVluHCLKS/uy3YFbsRu31lqVb8MShIT9G7+v0wTWb7lEi+dwvwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696490418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTTaaaHUArHDIckU4VjtEm1/89+COnB9H9apqfgESMg=;
        b=dUcnnAkk+dSBMVDqDyF+Bw+bMgw4Trfl+s8413XpT92kBhhyFWQmmlAkT1TQjHjPD+ghyR
        nnB9SxZBVOgivJDg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Enable named address spaces with known
 compiler version
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231004145137.86537-3-ubizjak@gmail.com>
References: <20231004145137.86537-3-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169649041819.3135.15323683986344973215.tip-bot2@tip-bot2>
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

Commit-ID:     1ca3683cc6d2c2ce4204df519c4e4730d037905a
Gitweb:        https://git.kernel.org/tip/1ca3683cc6d2c2ce4204df519c4e4730d037905a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 04 Oct 2023 16:49:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 09:01:52 +02:00

x86/percpu: Enable named address spaces with known compiler version

Enable named address spaces with known compiler versions
(GCC 12.1 and later) in order to avoid possible issues with named
address spaces with older compilers. Set CC_HAS_NAMED_AS when the
compiler satisfies version requirements and set USE_X86_SEG_SUPPORT
to signal when segment qualifiers could be used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20231004145137.86537-3-ubizjak@gmail.com
---
 arch/x86/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777..ecb2569 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2388,6 +2388,13 @@ source "kernel/livepatch/Kconfig"
 
 endmenu
 
+config CC_HAS_NAMED_AS
+	def_bool CC_IS_GCC && GCC_VERSION >= 120100
+
+config USE_X86_SEG_SUPPORT
+	def_bool y
+	depends on CC_HAS_NAMED_AS && SMP
+
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
 
