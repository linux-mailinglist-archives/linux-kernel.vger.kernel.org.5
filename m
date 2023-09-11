Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5059879C2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjILC2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbjILC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0F11411D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4199C433BA;
        Mon, 11 Sep 2023 23:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694476581;
        bh=u8grHSUih0zlT7CklXW0wcQgc5UDX4ocDwoCjXz+YmA=;
        h=From:To:Cc:Subject:Date:From;
        b=YnRzXMFyyF3dBrvBj16uexyMo4wqHU4lETNKicL+cfyBex9ZS0TN4zPYnSCfJz2m0
         KQycwz1aNJrMtq+UTlY1AWW6vhYKYXNRPu4NYdiGUl9Q4fbHUraiLt2q4dgGHGZiIX
         i88MYFkn1AEOmbxgElmBMd6DvJfSwVuqskZx+iHBJFLUghyMcTmlTIRITgxQ4uK9st
         toTf/fGcll9uW+r+dWVM6M2e9S//jXpR39mhhgIFvgW1+lRGdIpLBUqjCnMCt5UBXQ
         NAUSfRVYgskJ5asuyl5XKQDeAe1dMjDbqemZrlqFbx9X6014jhlJytMT39f2f2AOMw
         r0UEqsXP5exlg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool: Fix _THIS_IP_ detection for cold functions
Date:   Mon, 11 Sep 2023 16:56:13 -0700
Message-ID: <d8f1ab6a23a6105bc023c132b105f245c7976be6.1694476559.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1384090530db..e308d1ba664e 100644
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
-- 
2.41.0

