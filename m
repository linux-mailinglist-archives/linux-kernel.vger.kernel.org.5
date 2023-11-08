Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB07E576A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbjKHNDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344708AbjKHNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:03:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91241FC4;
        Wed,  8 Nov 2023 05:02:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF2DC433B7;
        Wed,  8 Nov 2023 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699448578;
        bh=IRNty8bJM+niG8y7TBztVYxFiP9MOAPlR8MjQa49+Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmkBSJz3VYamotMcUSRYyVTJpKvyfH4SHq0C7FsCwyVNJ4KSrjVdqRD1v6Vxxe82p
         MDc+Ta93r+CP7Di/Lj3tgf4btUtVcvWpA5v1wYl+QZ79Q5M8Wxv+Nw37+wWUZQ0Ko+
         HwJSB2Gx0RTGQ5mb+Isxh4TM28m0294JSbD9RIqZp4BVElmbGaNHuRy/I5r+moeoP1
         jCPaRo+RI83CtzxivdPD9wuzUbwRYtugqoZQvm3FEgnbzPIOJkizQnk58xDA/6Fp2d
         /ZO83W53G1V8AJ7fPeSVog3x78qsVn62ZKg1xrU4i9wzYrO9YJLHj3O6H5fDNPp6Ge
         1WoDxE5NsDvGw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 16/22] bcachefs: mark bch2_target_to_text_sb() static
Date:   Wed,  8 Nov 2023 13:58:37 +0100
Message-Id: <20231108125843.3806765-17-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

bch2_target_to_text_sb() is only called in the file it is defined in,
and it has no extern prototype:

fs/bcachefs/disk_groups.c:583:6: error: no previous prototype for 'bch2_target_to_text_sb' [-Werror=missing-prototypes]

Mark it static to avoid the warning and have the code better optimized.

Fixes: bf0d9e89de2e ("bcachefs: Split apart bch2_target_to_text(), bch2_target_to_text_sb()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/bcachefs/disk_groups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index d613695abf9f..1f334124055b 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -580,7 +580,7 @@ void bch2_target_to_text(struct printbuf *out, struct bch_fs *c, unsigned v)
 	}
 }
 
-void bch2_target_to_text_sb(struct printbuf *out, struct bch_sb *sb, unsigned v)
+static void bch2_target_to_text_sb(struct printbuf *out, struct bch_sb *sb, unsigned v)
 {
 	struct target t = target_decode(v);
 
-- 
2.39.2

