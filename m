Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668578F4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbjHaVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjHaVgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:36:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D2B8;
        Thu, 31 Aug 2023 14:36:06 -0700 (PDT)
Date:   Thu, 31 Aug 2023 21:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693517764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk5jjoXgGlu8gnn5MTPI3slRJ81FhamdcflE0t7Q7+M=;
        b=dPLBbbJG40MBWhcilhhQn5bXzV5pHpArFhjY9cZT6JDZNeBBSt+q+fMS+mJR4yXekVEAV5
        oP9fSilHsZHrSzsnf3owrINKTda49BXb++N6VRRnYEMDOOBnmL+GIfLqcUFrdzArR6jK3u
        BtCBC3nbvg/UmRVddSaMAo8QlsvWsuB0z8W3/sCmDYiExzzA1kftZcqXXEePBpJlbT7hJQ
        j8M7uxqb1yHJtnDq99iZSmr9sL7SZMHRjF0rTdQz4xv9J9pEHekJgmukLjgP9xeZj13qZ8
        CR7sEL6pijXfq5ALbBGKis0/hjkUJBD0WGpU+x9q8fAG/cIl1o/JHJ3kusTo4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693517764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk5jjoXgGlu8gnn5MTPI3slRJ81FhamdcflE0t7Q7+M=;
        b=ikgdvKdQrTRKm7QMbmzRKLaoZ3Ui+bqh0Rs84oowfNBvErZNt5xaV8lRSqHg9ol9qJHYXi
        nK8wEBYZeDZUciCg==
From:   "tip-bot2 for Jim Mattson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xstate: Fix PKRU covert channel
Cc:     Tavis Ormandy <taviso@google.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230831043228.1194256-1-jmattson@google.com>
References: <20230831043228.1194256-1-jmattson@google.com>
MIME-Version: 1.0
Message-ID: <169351776397.27769.630866137224277838.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     18032b47adf1db7b7f5fb2d1344e65aafe6417df
Gitweb:        https://git.kernel.org/tip/18032b47adf1db7b7f5fb2d1344e65aafe6417df
Author:        Jim Mattson <jmattson@google.com>
AuthorDate:    Wed, 30 Aug 2023 21:32:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Aug 2023 23:29:49 +02:00

x86/fpu/xstate: Fix PKRU covert channel

When XCR0[9] is set, PKRU can be read and written from userspace with
XSAVE and XRSTOR, even when CR4.PKE is clear.

Clear XCR0[9] when protection keys are disabled.

Reported-by: Tavis Ormandy <taviso@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20230831043228.1194256-1-jmattson@google.com
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1afbc48..a27b4f7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -71,7 +71,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_ZMM_Hi256]			= X86_FEATURE_AVX512F,
 	[XFEATURE_Hi16_ZMM]			= X86_FEATURE_AVX512F,
 	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
-	[XFEATURE_PKRU]				= X86_FEATURE_PKU,
+	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
 	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
