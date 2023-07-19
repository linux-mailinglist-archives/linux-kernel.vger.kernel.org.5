Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345B575A246
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGSWsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGSWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094A1FF9;
        Wed, 19 Jul 2023 15:47:33 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8BTHQ7pBpYtAgK36iWl38TXsRPCr6YngSby2bITbJ3I=;
        b=c2jAOpoOAsaJBZocjZCu8i+xIDIFLxL+PhPGvoQs9Tg4e/EoJhp0yeFDIEMX4d7v/22PMq
        3verXIHv+M88m02Xm7lXQR4QmRcMX15b30N+kewXBO7GT6vsUfek9V9rGiB7svpNeiymGz
        hSpPL9GBjbvORZMElcX3ffAcxz3y5qrbZWa5dwtKeYa1WmCIsEI2rEXhlyfg/kvInTBb9e
        HRhts7j6TrG4JvJTPH7IJuvJCA5oWosyDrtgQ8Nbr2gGPRkBGwGvdRP7mJn6VFmZS4LlAV
        mMqTDWQbDF5g8tGx63rn6hpqeirAfc7BCZjOY2iD3PktGOmBRd7Wq3A5eQBm7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8BTHQ7pBpYtAgK36iWl38TXsRPCr6YngSby2bITbJ3I=;
        b=YRfJolYymDr5/6Bj9fZOWxC0VktrZN2c3ubjeKjmFtE5Z0WsZ+HzKQqr+ueNd2D2N+y7Ow
        +wpfhoqr6/m0YYBw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Check that SSP is aligned on sigreturn
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685014.28540.14547624168811413141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     580c301b703f720a18bf0a03cedf57f961d80eea
Gitweb:        https://git.kernel.org/tip/580c301b703f720a18bf0a03cedf57f961d80eea
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:58 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:50 -07:00

x86/shstk: Check that SSP is aligned on sigreturn

The shadow stack signal frame is read by the kernel on sigreturn. It
relies on shadow stack memory protections to prevent forgeries of this
signal frame (which included the pre-signal SSP). It also relies on the
shadow stack signal frame to have bit 63 set. Since this bit would not be
set via typical shadow stack operations, so the kernel can assume it was a
value it placed there.

However, in order to support 32 bit shadow stack, the INCSSPD instruction
can increment the shadow stack by 4 bytes. In this case SSP might be
pointing to a region spanning two 8 byte shadow stack frames. It could
confuse the checks described above.

Since the kernel only supports shadow stack in 64 bit, just check that
the SSP is 8 byte aligned in the sigreturn path.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230613001108.3040476-33-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index f02e8ea..a8705f7 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -252,6 +252,9 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	unsigned long token_addr;
 	int err;
 
+	if (!IS_ALIGNED(*ssp, 8))
+		return -EINVAL;
+
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
 		return err;
