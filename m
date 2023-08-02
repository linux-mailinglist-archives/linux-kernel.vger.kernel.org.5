Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6676DA9B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjHBWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjHBWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:19:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5B273B;
        Wed,  2 Aug 2023 15:19:35 -0700 (PDT)
Date:   Wed, 02 Aug 2023 22:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691014773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YYSeP3oTtOgkXh3frpkRHENndWycgT3hC5KKAYr/xc4=;
        b=aUyktOCoWVy2dkudEpDzUOpJ+B1vEhiDi51hFRuFBkXsWHTiDd3bXySxAFrU5bkZlCNWU/
        otyQEf3zGG2+i582aCWTzRI6uxTbTUyLlHcLFTjTGasta7cVwiTyCwdFQbZRkmVBgYzigk
        7/eljzA5aINn/TZRn/t1vSIeNaxYR/h2oxQXt893KV0poimcGKUtgQHfkUcl6TnHcPgpSB
        cKxi0bC3Z53hu3QuQDf0b5cEPS0HtMKQpW3Aso2Oku0xJ8iJgHk4S56AZ5/LfOi90SCbpg
        s/3fxW9sUO7m7E6DYIuAb/+1aTwF8KJZBATgAjPwt/7XSSp/8qGFAunOiMV6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691014773;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YYSeP3oTtOgkXh3frpkRHENndWycgT3hC5KKAYr/xc4=;
        b=XPkSbV8ouVr3q++gx0Hhc3gxNZR/dzq5W6quyNcwbGnK6n50Ltt9QphxxIvmlmEMJXjPvB
        4Br5odGD8qxLGkCQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Check that SSP is aligned on sigreturn
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169101477238.28540.7777670713206141397.tip-bot2@tip-bot2>
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

Commit-ID:     b93d6c78829ad1e22486ccc93d04bf77e45597df
Gitweb:        https://git.kernel.org/tip/b93d6c78829ad1e22486ccc93d04bf77e45597df
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Aug 2023 15:01:50 -07:00

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
