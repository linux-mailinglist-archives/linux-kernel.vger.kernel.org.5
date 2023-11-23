Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE93D7F6089
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjKWNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345536AbjKWNmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:42:15 -0500
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1981F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qzDYok5oSedbjSII7O6os148H5o+A9vUBxaMvgxecfA=; b=CuVKMau+FTzX3AXW7KCMXVUHKl
        YfKdpXuCb+4yuztswtlvNNd4yGvdqdnpnYylqNaJZGbKpaPZ+0BtOwrhXJh8kcM61FfUHLTY9Oni6
        Q6F/4ZyQmNU8doDndFglcqLH65C9bSR0EygiFoCSFEuYIHloCCZxqBzmdrp5c/OkF+ZenUpqnPxFG
        ONbLeHkmcFv65XvgL+5kQ3hDGotw80XIPIiLhwRfrTEy0NlMr08wsXIG3SXRYBzjuGm8mRKLoDpTE
        vNHCZw0kEOjACXHwOeaU7iUChT9EOReye7CAqlSMHrym+IllVu7PtQNkc3H86XjmvLi+3OGJ4CprX
        rIpJGVDg==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r69yC-004SaQ-3J; Thu, 23 Nov 2023 13:42:17 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r69yC-00000000LEO-1fTp;
        Thu, 23 Nov 2023 13:42:16 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] riscv: declare overflow_stack as exported from traps.c
Date:   Thu, 23 Nov 2023 13:42:14 +0000
Message-Id: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
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

The percpu area overflow_stacks is exported from arch/riscv/kernel/traps.c
for use in the entry code, but is not declared anywhere. Add the relevant
declaration to arch/riscv/include/asm/stacktrace.h to silence the following
sparse warning:

arch/riscv/kernel/traps.c:395:1: warning: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?

We don't add the stackinfo_get_overflow() call as for some of the other
architectures as this doesn't seem to be used yet, so just silence the
warning.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/include/asm/stacktrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index f7e8ef2418b9..b1495a7e06ce 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -21,4 +21,9 @@ static inline bool on_thread_stack(void)
 	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
 }
 
+
+#ifdef CONFIG_VMAP_STACK
+DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
+#endif /* CONFIG_VMAP_STACK */
+
 #endif /* _ASM_RISCV_STACKTRACE_H */
-- 
2.37.2.352.g3c44437643

