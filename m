Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCA7F616C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjKWO1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjKWO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:27:09 -0500
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B06110C7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KsEGyo4xLuPNHGa1b7DoFLq+js4MZH59xg//d2NjkOE=; b=tdaFQMUbrOWxmVNenjZWG9hSvE
        KCa3l44k/k+jfnOjKCkQ3bpyv3V0yEXW/dSJ4FfxtU7f3OMQ9SPp8T6aZcJ9fuXQ7YbvgNWsbLKEr
        TI8pbF5w9zHSaVCFNFcdfnKNYso4A95r2mfnWnTjpoeIC6+hAxr/wvidPiy0sCsC1mm+iHh9R3nE+
        g0MSSrdphNd0FJ0NnSjGhvr7piw0qzXLC3beMi0hjXuq1vWRvvMKTTmOSMqin+4kmvJKwPUi04z4Z
        FRrUVYR8SbSc4Wt5ZtMBtEfxJs/Jhi4UpxhhKDtknHg0vXtLrXaFZ9LOaPW+SUjo6u47jfh5ZkVNg
        d4XOLwag==;
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1r6Afd-005B1Z-S3; Thu, 23 Nov 2023 14:27:10 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
        (envelope-from <ben@rainbowdash>)
        id 1r6Afd-0000000165i-3trc;
        Thu, 23 Nov 2023 14:27:09 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] riscv; fix __user annotation in save_v_state()
Date:   Thu, 23 Nov 2023 14:27:08 +0000
Message-Id: <20231123142708.261733-1-ben.dooks@codethink.co.uk>
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

The save_v_state() is technically sending a __user pointer through
__put_user() and thus is generating a sparse warning so force the
value to be "void *" to fix:

arch/riscv/kernel/signal.c:94:16: warning: incorrect type in initializer (different address spaces)
arch/riscv/kernel/signal.c:94:16:    expected void *__val
arch/riscv/kernel/signal.c:94:16:    got void [noderef] __user *[assigned] datap
Fixes:  8ee0b41898fa26f66e32 ("riscv: signal: Add sigcontext save/restore for vector")
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 88b6220b2608..33dfb5078301 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -91,7 +91,7 @@ static long save_v_state(struct pt_regs *regs, void __user **sc_vec)
 	err = __copy_to_user(&state->v_state, &current->thread.vstate,
 			     offsetof(struct __riscv_v_ext_state, datap));
 	/* Copy the pointer datap itself. */
-	err |= __put_user(datap, &state->v_state.datap);
+	err |= __put_user((__force void *)datap, &state->v_state.datap);
 	/* Copy the whole vector content to user space datap. */
 	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
 	/* Copy magic to the user space after saving  all vector conetext */
-- 
2.37.2.352.g3c44437643

