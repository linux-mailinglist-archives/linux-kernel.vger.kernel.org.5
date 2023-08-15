Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2777C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjHOAtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHOAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619281735
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FA464BE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AADC433B8;
        Tue, 15 Aug 2023 00:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060505;
        bh=8yzb+sbCX12KdZw39xAAHItl2pY4cwsnTFjWa/DTVAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQpQdGjSNETNvnzLPZG3ecN/fOw0xs2lGstiz8aH9SZVlwB3ahjh3PEsWy7ulohdl
         XQFm+7zIVBfNYqRmAxxI5ib0lWi7Wd0npD8a3I+4HNsWXRelO5Fnl8MES+kZnNRrMi
         syDed7P/hUN2s6KTTmB0oZ0h93D6fAmuOmiWH5+wsGcP8pvD1V15tXky99Ppcf4upv
         vtEFZGSATQzsCUaesp8/gEt8hGbaVgcR/IfqXneMQ7jDfqurZT54VHcZBLO/rgr394
         tNQtixRGJMXWkljhHEfXNTqf6Blcxi8Z2nZRFFF6vdt+Y0Lj+UQp0M6cZ8laM2Hw0j
         RsFwWUZyxgrNQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 18/20] ARC: entry: replace 8 byte ADD.ne with 4 byte ADD2.ne
Date:   Mon, 14 Aug 2023 17:48:11 -0700
Message-Id: <20230815004813.555115-19-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCv2 current
------------
000007e0 <EV_Trap>:
 7e0:   2482 3c01               sub     sp,sp,112
 7e4:   1c28 3006               std     r0r1,[sp,40]
 7e8:   1c30 3086               std     r2r3,[sp,48]
 7ec:   1c38 3106               std     r4r5,[sp,56]
 7f0:   1c40 3186               std     r6r7,[sp,64]
 7f4:   1c48 3206               std     r8r9,[sp,72]
 7f8:   1c50 3286               std     r10r11,[sp,80]
 7fc:   1c58 37c0               st      blink,[sp,88]
 800:   1c0c 36c0               st      fp,[sp,12]
 804:   1c18 3680               st      gp,[sp,24]
 808:   1c10 3780               st      r30,[sp,16]
 80c:   1c14 3300               st      r12,[sp,20]
 810:   226a 1340               lr      r10,[aux_user_sp]
 814:   22ca 1702               mov.ne  r10,sp
 818:   22c0 1f82 0000 0070     add.ne  r10,r10,0x70
                  ^^^^^^^^^
With fix
--------
000007b4 <EV_Trap>:
 7b4:   2482 3c01               sub     sp,sp,112
 7b8:   1c28 3006               std     r0r1,[sp,40]
 7bc:   1c30 3086               std     r2r3,[sp,48]
 7c0:   1c38 3106               std     r4r5,[sp,56]
 7c4:   1c40 3186               std     r6r7,[sp,64]
 7c8:   1c48 3206               std     r8r9,[sp,72]
 7cc:   1c50 3286               std     r10r11,[sp,80]
 7d0:   1c58 37c0               st      blink,[sp,88]
 7d4:   1c0c 36c0               st      fp,[sp,12]
 7d8:   1c18 3680               st      gp,[sp,24]
 7dc:   1c10 3780               st      r30,[sp,16]
 7e0:   1c14 3300               st      r12,[sp,20]
 7e4:   226a 1340               lr      r10,[aux_user_sp]
 7e8:   22ca 1702               mov.ne  r10,sp
 7ec:   22d5 1722               add2.ne r10,r10,0x1c

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index f7c9b3915d10..a030eae93d35 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -167,7 +167,7 @@
 
 	; ISA requires ADD.nz to have same dest and src reg operands
 	mov.nz	r10, sp
-	add.nz	r10, r10, SZ_PT_REGS	; K mode SP
+	add2.nz	r10, r10, SZ_PT_REGS/4	; K mode SP
 
 	st	r10, [sp, PT_sp]	; SP (pt_regs->sp)
 
-- 
2.34.1

