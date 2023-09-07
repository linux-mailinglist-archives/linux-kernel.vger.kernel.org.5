Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0525797A3B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjIGReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjIGReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:34:09 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [IPv6:2a02:1800:120:4::f00:10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D392
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:33:43 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4RhL535PX0z4xT4x
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:41:59 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A00T1C8whw061hyaQ; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002mAD-Ux;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGg-00CMi7-6v;
        Thu, 07 Sep 2023 15:41:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 39/52] m68k: sun3: Fix context restore in flush_tlb_range()
Date:   Thu,  7 Sep 2023 15:41:40 +0200
Message-Id: <a7fd6a347bb0454a37c940f5580a289dff2423ed.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    In file included from arch/m68k/kernel/traps.c:42:
    arch/m68k/include/asm/tlbflush.h: In function ‘flush_tlb_range’:
    arch/m68k/include/asm/tlbflush.h:191:28: warning: variable ‘oldctx’ set but not used [-Wunused-but-set-variable]
      191 |         unsigned char seg, oldctx;
	  |                            ^~~~~~

Indeed, the old context is saved, but never restored.  Fix this by
adding the missing call to sun3_put_context().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
This issue seems to have been present since the introduction of Sun3
support in v2.4.0.
---
 arch/m68k/include/asm/tlbflush.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
index b882e2f4f5516f8d..3ab329a03c76c8d8 100644
--- a/arch/m68k/include/asm/tlbflush.h
+++ b/arch/m68k/include/asm/tlbflush.h
@@ -208,6 +208,7 @@ static inline void flush_tlb_range (struct vm_area_struct *vma,
 	next:
 		start += SUN3_PMEG_SIZE;
 	}
+	sun3_put_context(oldctx);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-- 
2.34.1

