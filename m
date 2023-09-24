Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10CD7AC8B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjIXNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIXNSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:18:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3009F170F;
        Sun, 24 Sep 2023 06:17:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630BC433BB;
        Sun, 24 Sep 2023 13:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561450;
        bh=t9Xk/x5uTc12jjguLUmrTd//G1EkDbcQ5Y+KI6nZyno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxeduMDPM0iTXt3JQgHpc+/Whg+8MoUU+QQQ1Jlhw+Wj3snFMBfpiwG6XJrUGL2dn
         TK0pEmOjb38j6AvOgRVYG4nSLa4A58ybB6pqphx+V2TXGMlSD2KGIsjul630pyOROn
         cfcWCKtIZ6G2sBhWs81xSUVaqlq+ZFgNrI51vYLCbw3W3jX2w96iK5QnvylAChWsET
         yFL+rAAr/QwTw9Rl/Sm/Z3++23fwukmriN4tm7zEkDOkM/NFbX08pCSHTc9eSaMmXP
         XlbruURe+up8XEv4nZPh/i/6vk6UVON75DLtUioFJbCHbJZbAl6ELG1ytvxp8lzyGr
         coYZcHch/ktMA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, peterz@infradead.org,
        nathan@kernel.org, ndesaulniers@google.com, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 34/41] objtool: Fix _THIS_IP_ detection for cold functions
Date:   Sun, 24 Sep 2023 09:15:22 -0400
Message-Id: <20230924131529.1275335-34-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 72178d5d1a38dd185d1db15f177f2d122ef10d9b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1384090530dbe..e308d1ba664ef 100644
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
2.40.1

