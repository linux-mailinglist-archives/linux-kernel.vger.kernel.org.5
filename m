Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAC79C6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjILGWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjILGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:22:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA60AF;
        Mon, 11 Sep 2023 23:22:32 -0700 (PDT)
Date:   Tue, 12 Sep 2023 06:22:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694499750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIKe3BGZAvYyd6OF2U38OylY1u4o8nivsPg6ghqA7go=;
        b=wwZTh3Kd7DOhT+nfic9ynlU3jnAuNf7c0W0mEDrN4uKEcWbKRrkKQj/PDAUdV5/JAcehSb
        CcstLCoh5lj93q6FjyckVnqeSTeJsYSaHLEUxofQnTM3DdUZjmBrr9QD6dx39xoRTJsTat
        7A6YBHeXekcq+K4vzPpgECeAlBEVvnIsejh24xuOZ/5lvZphw89cl8ZBNeqTw8fGx0YT6a
        u+9fXADOc9zMqT1X4VghGN/cKQEkAGvEiz8/AwODfX/Ly3SZb7jPMpaSFM5lo/VYGY4we3
        kdFYpZvK4WGomkdR0h8hNzFbO4/hJhx2/CBFXWRX6Vtmbicv3XiCR6d0mGZhmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694499750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIKe3BGZAvYyd6OF2U38OylY1u4o8nivsPg6ghqA7go=;
        b=3539uvpMEJOIkXB25Vmqmz78+g6XjsGzHwJrdWOtHu0fDN70yBXWJkDyB4oEIc7xefxE8n
        hndvcTXNlFQbhaAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix _THIS_IP_ detection for cold functions
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d8f1ab6a23a6105bc023c132b105f245c7976be6.1694476559.git.jpoimboe@kernel.org>
References: <d8f1ab6a23a6105bc023c132b105f245c7976be6.1694476559.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169449974941.27769.5966361475129342374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     72178d5d1a38dd185d1db15f177f2d122ef10d9b
Gitweb:        https://git.kernel.org/tip/72178d5d1a38dd185d1db15f177f2d122ef10d9b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 11 Sep 2023 16:56:13 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Sep 2023 08:16:54 +02:00

objtool: Fix _THIS_IP_ detection for cold functions

Cold functions and their non-cold counterparts can use _THIS_IP_ to
reference each other.  Don't warn about !ENDBR in that case.

Note that for GCC this is currently irrelevant in light of the following
commit

  c27cd083cfb9 ("Compiler attributes: GCC cold function alignment workarounds")

which disabled cold functions in the kernel.  However this may still be
possible with Clang.

Fixes several warnings like the following:

  drivers/scsi/bnx2i/bnx2i.prelink.o: warning: objtool: bnx2i_hw_ep_disconnect+0x19d: relocation to !ENDBR: bnx2i_hw_ep_disconnect.cold+0x0
  drivers/net/ipvlan/ipvlan.prelink.o: warning: objtool: ipvlan_addr4_event.cold+0x28: relocation to !ENDBR: ipvlan_addr4_event+0xda
  drivers/net/ipvlan/ipvlan.prelink.o: warning: objtool: ipvlan_addr6_event.cold+0x26: relocation to !ENDBR: ipvlan_addr6_event+0xb7
  drivers/net/ethernet/broadcom/tg3.prelink.o: warning: objtool: tg3_set_ringparam.cold+0x17: relocation to !ENDBR: tg3_set_ringparam+0x115
  drivers/net/ethernet/broadcom/tg3.prelink.o: warning: objtool: tg3_self_test.cold+0x17: relocation to !ENDBR: tg3_self_test+0x2e1
  drivers/target/iscsi/cxgbit/cxgbit.prelink.o: warning: objtool: __cxgbit_free_conn.cold+0x24: relocation to !ENDBR: __cxgbit_free_conn+0xfb
  net/can/can.prelink.o: warning: objtool: can_rx_unregister.cold+0x2c: relocation to !ENDBR: can_rx_unregister+0x11b
  drivers/net/ethernet/qlogic/qed/qed.prelink.o: warning: objtool: qed_spq_post+0xc0: relocation to !ENDBR: qed_spq_post.cold+0x9a
  drivers/net/ethernet/qlogic/qed/qed.prelink.o: warning: objtool: qed_iwarp_ll2_comp_syn_pkt.cold+0x12f: relocation to !ENDBR: qed_iwarp_ll2_comp_syn_pkt+0x34b
  net/tipc/tipc.prelink.o: warning: objtool: tipc_nametbl_publish.cold+0x21: relocation to !ENDBR: tipc_nametbl_publish+0xa6

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/d8f1ab6a23a6105bc023c132b105f245c7976be6.1694476559.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1384090..e308d1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4333,7 +4333,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 		}
 
-		if (insn_func(dest) && insn_func(dest) == insn_func(insn)) {
+		if (insn_func(dest) && insn_func(insn) &&
+		    insn_func(dest)->pfunc == insn_func(insn)->pfunc) {
 			/*
 			 * Anything from->to self is either _THIS_IP_ or
 			 * IRET-to-self.
