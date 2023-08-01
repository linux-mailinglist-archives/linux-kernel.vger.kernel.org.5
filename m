Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97176BEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjHAUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHAUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784B1722;
        Tue,  1 Aug 2023 13:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AFC616EA;
        Tue,  1 Aug 2023 20:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D34EBC433C8;
        Tue,  1 Aug 2023 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690922591;
        bh=C0I3Ru7GOW95oqbdSWRCdIV1RALO1IK4Jpy3kgeDRGU=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=Lqve3I6cH3czggt0HoV5slmlN4T4zTo9Icns7Xl/n5Hf0BwWRBmKUmXc8IrXuMTmJ
         iC3WgV92E70Va2qNju4RBhgduQRPFIT5DKTkV/ykL8MEa9v/copUXYI07zn9MvvnoD
         SBgBNeGcIBa/P9MPU96pgWOzyn9aC6E8lhqWLv54VtW7n1xbAnu9EqS0JBngXM9onB
         Ix4FsYogjfmgVbHi98Thcjwa6cOT8xzgwnG5JiSowJV0dqAwP+iSguj39MHQpj+nnm
         CrpZ1CQS90MM06x9SeJzYSiYb+YnAhPZvAs8SJKIphA+2u2l7KHg8+2hk0YCMJ5WiW
         Sla5mU9sJyQfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id BAB58C0015E;
        Tue,  1 Aug 2023 20:43:11 +0000 (UTC)
From:   Nathan Lynch via B4 Relay 
        <devnull+nathanl.linux.ibm.com@kernel.org>
Date:   Tue, 01 Aug 2023 15:43:07 -0500
Subject: [PATCH] powerpc/rtas_flash: allow user copy to flash block cache
 objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-rtas-flash-vs-hardened-usercopy-v1-1-2e99cf9e2bed@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAFpuyWQC/x3NTQqDQAxA4atI1g3MD1jaqxQX0YmdQBklsaKId
 3dw+TbfO8BYhQ3ezQHKq5hMpYZ/NDBkKl9GSbUhuBDdM3rUhQzHH1nG1TCTJi6c8F+dYZp3dC9
 qU4ht77yHqszKo2z34dOd5wWga1b/cQAAAA==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690922591; l=3523;
 i=nathanl@linux.ibm.com; s=20230206; h=from:subject:message-id;
 bh=7SUjRaAqad/a9pJchkB3VHzS+si/gdmTstqU0MaHrlA=;
 b=u2yXJ1USIHBZnDyFxJ/BYcgYZAEArFBRYWN27AoxZ2K5TbQo/YNf74+f1y6Tez0VodPXdoRKj
 fIJeLfXp44uAkqunq4GulH6Q0kEhdoRZn6sszqffJyKSH/FUInksig5
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=6daubz/ymoaMF+8voz7UHwnhluEsmDZuqygIIMWpQQY=
X-Endpoint-Received: by B4 Relay for nathanl@linux.ibm.com/20230206 with auth_id=27
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Lynch <nathanl@linux.ibm.com>

With hardened usercopy enabled (CONFIG_HARDENED_USERCOPY=y), using the
/proc/powerpc/rtas/firmware_update interface to prepare a system
firmware update yields a BUG():

kernel BUG at mm/usercopy.c:102!
Oops: Exception in kernel mode, sig: 5 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 2232 Comm: dd Not tainted 6.5.0-rc3+ #2
Hardware name: IBM,8408-E8E POWER8E (raw) 0x4b0201 0xf000004 of:IBM,FW860.50 (SV860_146) hv:phyp pSeries
NIP:  c0000000005991d0 LR: c0000000005991cc CTR: 0000000000000000
REGS: c0000000148c76a0 TRAP: 0700   Not tainted  (6.5.0-rc3+)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24002242  XER: 0000000c
CFAR: c0000000001fbd34 IRQMASK: 0
[ ... GPRs omitted ... ]
NIP [c0000000005991d0] usercopy_abort+0xa0/0xb0
LR [c0000000005991cc] usercopy_abort+0x9c/0xb0
Call Trace:
[c0000000148c7940] [c0000000005991cc] usercopy_abort+0x9c/0xb0 (unreliable)
[c0000000148c79b0] [c000000000536814] __check_heap_object+0x1b4/0x1d0
[c0000000148c79f0] [c000000000599080] __check_object_size+0x2d0/0x380
[c0000000148c7a30] [c000000000045ed4] rtas_flash_write+0xe4/0x250
[c0000000148c7a80] [c00000000068a0fc] proc_reg_write+0xfc/0x160
[c0000000148c7ab0] [c0000000005a381c] vfs_write+0xfc/0x4e0
[c0000000148c7b70] [c0000000005a3e10] ksys_write+0x90/0x160
[c0000000148c7bc0] [c00000000002f2c8] system_call_exception+0x178/0x320
[c0000000148c7e50] [c00000000000d520] system_call_common+0x160/0x2c4
--- interrupt: c00 at 0x7fff9f17e5e4

The blocks of the firmware image are copied directly from user memory
to objects allocated from flash_block_cache, so flash_block_cache must
be created using kmem_cache_create_usercopy() to mark it safe for user
access.

Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
I believe it's much more common to update Power system firmware
without involving a Linux partition, which may explain why this has
gone unreported for so long.
---
 arch/powerpc/kernel/rtas_flash.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 4caf5e3079eb..6a837264a196 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -698,6 +698,12 @@ static const struct rtas_flash_file rtas_flash_files[] = {
 
 static int __init rtas_flash_init(void)
 {
+	const unsigned int objsize = RTAS_BLK_SIZE;
+	const unsigned int usersize = objsize;
+	const unsigned int align = objsize;
+	void (* const ctor)(void *) = NULL;
+	const unsigned int useroffset = 0;
+	const slab_flags_t flags = 0;
 	int i;
 
 	if (rtas_function_token(RTAS_FN_IBM_UPDATE_FLASH_64_AND_REBOOT) == RTAS_UNKNOWN_SERVICE) {
@@ -709,9 +715,9 @@ static int __init rtas_flash_init(void)
 	if (!rtas_validate_flash_data.buf)
 		return -ENOMEM;
 
-	flash_block_cache = kmem_cache_create("rtas_flash_cache",
-					      RTAS_BLK_SIZE, RTAS_BLK_SIZE, 0,
-					      NULL);
+	flash_block_cache = kmem_cache_create_usercopy("rtas_flash_cache",
+						       objsize, align, flags,
+						       useroffset, usersize, ctor);
 	if (!flash_block_cache) {
 		printk(KERN_ERR "%s: failed to create block cache\n",
 				__func__);

---
base-commit: c3cad890877f59aeeaf5a638aa7a7c0612c16fa1
change-id: 20230731-rtas-flash-vs-hardened-usercopy-09a6d236b011

Best regards,
-- 
Nathan Lynch <nathanl@linux.ibm.com>

