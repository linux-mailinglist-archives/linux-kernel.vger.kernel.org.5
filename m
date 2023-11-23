Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D257F6137
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345711AbjKWOQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbjKWOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:16:16 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D414DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7MbYzx1WwZG7kkxbSNQXQ8lOJbHZOY6MUwMS7TQckk=; b=dakTzhCwvs3zfH7PwWIyFa1pj3
        E0HXSUwXYGbz/8cvZX4f5ddzd61vyujZx03qE9vBtiKdolKmf8rNBeEx/z5pqhJcBD5zeYraE1/ez
        0/hUkgBSpwf4Nqgi9Uvg0275RC8gwTbfNJs+aZiHBg9I8lbwuN0hPVVwWuG9sW0VaRi0/OVLmFDVV
        G+/5VY/X2QoiejsrIw+xq3SLg3qqWS5sMHKZ3PwvME0vZHNO9FPJbZOPxWZGARqYS4FqQJq34uh5V
        v2WXsMhO5F78Wbit5thqXBaDf8awJNyrihM69zTmQFAbSALFOfCLq8Uly09zTY2YWhFHodSVUMXrj
        Z+uMCRUA==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r6AV8-004Tcz-6d; Thu, 23 Nov 2023 14:16:19 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r6AV8-000000015XA-3BGH;
        Thu, 23 Nov 2023 14:16:18 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] riscv: fix __user annotation in traps_misaligned.c
Date:   Thu, 23 Nov 2023 14:16:17 +0000
Message-Id: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The instruction reading code can read from either user or kernel addresses
and thus the use of __user on pointers to instructions depends on which
context. Fix a few sparse warnings by using __user for user-accesses and
remove it when not.

Fixes:

arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:322:24: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/traps_misaligned.c:322:24:    expected unsigned char const [noderef] __user *__gu_ptr
arch/riscv/kernel/traps_misaligned.c:322:24:    got unsigned char const [usertype] *addr
arch/riscv/kernel/traps_misaligned.c:361:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:373:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:381:21: warning: dereference of noderef expression
arch/riscv/kernel/traps_misaligned.c:332:24: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/traps_misaligned.c:332:24:    expected unsigned char [noderef] __user *__gu_ptr
arch/riscv/kernel/traps_misaligned.c:332:24:    got unsigned char [usertype] *addr

Fixes: 7c83232161f60 ("riscv: add support for misaligned trap handling in S-mode")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/kernel/traps_misaligned.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 5eba37147caa..446e3d4eeea9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -319,7 +319,7 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
 static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 {
 	if (user_mode(regs)) {
-		return __get_user(*r_val, addr);
+		return __get_user(*r_val, (u8 __user *)addr);
 	} else {
 		*r_val = *addr;
 		return 0;
@@ -329,7 +329,7 @@ static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 {
 	if (user_mode(regs)) {
-		return __put_user(val, addr);
+		return __put_user(val, (u8 __user *)addr);
 	} else {
 		*addr = val;
 		return 0;
@@ -343,7 +343,7 @@ static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 	if (user_mode(regs)) {				\
 		__ret = __get_user(insn, insn_addr);	\
 	} else {					\
-		insn = *insn_addr;			\
+		insn = *(__force u16 *)insn_addr;	\
 		__ret = 0;				\
 	}						\
 							\
-- 
2.37.2.352.g3c44437643

