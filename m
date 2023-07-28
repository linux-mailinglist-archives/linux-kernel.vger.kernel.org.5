Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484DC766B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjG1Kz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjG1Kz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:55:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D71BC6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:55:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26B3620CE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CC4C433C7;
        Fri, 28 Jul 2023 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690541725;
        bh=KiJekQvrYKFV+Wo4fuymS0vHZbJ6vimMcoU3XpuBEPc=;
        h=From:To:Cc:Subject:Date:From;
        b=iGq+jEykNKtWVUol0RQTBkbIWYLn8/FBSfap1epA8o9SY3qb/5N3iGUDWf825Abav
         JEkTq72fJEq04tlkQxBvomBVqIdYCNkS6tAZ4La1fO0OejVen4VwVXIWs/14R8qsAc
         Lptjb5BYmOUtn4nb1WfBgvCvs8Cadv7bs7g7jZs18LOwt3TyJdEZijYh6cLvhdd/TW
         fPKuwexfJuc15t4AFHSfr5Nx71yz4sWiY12i6TkU26F7ea3lZShUf/S9apGqtK3iPP
         +SDL0W7L1lbDg7aLxZ2jDjyji3aOdbNFdU8jB54uvl5lNv52XgaEExmkzt8I/GDpdJ
         iqcP3WJIs85+A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] Revert "mm,memblock: reset memblock.reserved to system init state to prevent UAF"
Date:   Fri, 28 Jul 2023 13:55:12 +0300
Message-Id: <20230728105512.2258393-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

This reverts commit 9e46e4dcd9d6cd88342b028dbfa5f4fb7483d39c.

kbuild reports a warning in memblock_remove_region() because of a false
positive caused by partial reset of the memblock state.

Doing the full reset will remove the false positives, but will allow late
use of memblock_free() to go unnoticed, so it is better to revert the
offending commit.

 WARNING: CPU: 0 PID: 1 at mm/memblock.c:352 memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:352 (discriminator 1))
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc3-00001-g9e46e4dcd9d6 #2
 RIP: 0010:memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:352 (discriminator 1))
 Code: 00 00 48 8b 43 18 48 c7 40 08 00 00 00 00 48 8b 43 18 c7 40 10 00 00 00 00 48 8b 43 18 c7 40 14 00 04 00 00 5b c3 cc cc cc cc <0f> 0b eb c2 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
 RSP: 0000:ffa0000000077e78 EFLAGS: 00010206
 RAX: ffffffff82f4bc40 RBX: ffffffff82f4bc18 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff82f4bc58 RDI: ffffffff82f4bc40
 RBP: 0000000000000000 R08: ff1100207ffd4d00 R09: 0000000000000002
 R10: ffd4000081ff9d00 R11: ff1100207ffd4000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ff1100103f200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ff1100207fc00000 CR3: 000000207ea18001 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
 ? memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:352 (discriminator 1))
 ? __warn (kbuild/src/x86_64/kernel/panic.c:673)
 ? memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:352 (discriminator 1))
 ? report_bug (kbuild/src/x86_64/lib/bug.c:180 kbuild/src/x86_64/lib/bug.c:219)
 ? handle_bug (kbuild/src/x86_64/arch/x86/kernel/traps.c:324)
 ? exc_invalid_op (kbuild/src/x86_64/arch/x86/kernel/traps.c:345 (discriminator 1))
 ? asm_exc_invalid_op (kbuild/src/x86_64/arch/x86/include/asm/idtentry.h:568)
 ? memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:352 (discriminator 1))
 ? memblock_remove_region (kbuild/src/x86_64/mm/memblock.c:348)
 memblock_discard (kbuild/src/x86_64/mm/memblock.c:383)
 page_alloc_init_late (kbuild/src/x86_64/include/linux/find.h:208 kbuild/src/x86_64/include/linux/nodemask.h:266 kbuild/src/x86_64/mm/mm_init.c:2405)
 kernel_init_freeable (kbuild/src/x86_64/init/main.c:1325 kbuild/src/x86_64/init/main.c:1546)
 ? __pfx_kernel_init (kbuild/src/x86_64/init/main.c:1429)
 kernel_init (kbuild/src/x86_64/init/main.c:1439)
 ret_from_fork (kbuild/src/x86_64/arch/x86/kernel/process.c:145)
 ? __pfx_kernel_init (kbuild/src/x86_64/init/main.c:1429)
 ret_from_fork_asm (kbuild/src/x86_64/arch/x86/entry/entry_64.S:298)
 RIP: 0000:0x0
 Code: Unable to access opcode bytes at 0xffffffffffffffd6.
 RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  </TASK>

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202307271656.447aa17e-oliver.sang@intel.com
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

Hi,

Looks like I didn't wait enough for kbuild :(

Linus, do you prefer a pull request or to pick it right away?

 mm/memblock.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c39b36378f5d..f9e61e565a53 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -374,10 +374,6 @@ void __init memblock_discard(void)
 			kfree(memblock.reserved.regions);
 		else
 			memblock_free_late(addr, size);
-		/* Reset to prevent UAF from stray frees. */
-		memblock.reserved.regions = memblock_reserved_init_regions;
-		memblock.reserved.cnt = 1;
-		memblock_remove_region(&memblock.reserved, 0);
 	}
 
 	if (memblock.memory.regions != memblock_memory_init_regions) {
-- 
2.39.2

