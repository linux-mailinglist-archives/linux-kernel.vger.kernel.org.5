Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1797F5D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbjKWLFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbjKWLF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:05:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461171BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:05:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB220C433D9;
        Thu, 23 Nov 2023 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700737534;
        bh=lp+rEggxgbuHN1BPGYgpeRufkP5k9akySuiKFW/Pyuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bp72z2ZYfxFgUAViqgqthrZ1n/G7s220umdBTqhNPpOWDzVmZqOG7Ddmr+XT6+7z4
         Gz3HgSoUmx1tvsdGJhVZ+4xWIUm+F07UIf+HzuZqTiusqThvyILWdgfo39uCwPppu6
         cUD0tMyRtrmcZKYLJO2vHQuI9MrS5R7/3S5RjH6Yu8ZdxOM4qzrBppe22kufQzaDSB
         DSth/LrC/07UaI/iVo3dd5j+Aijmgiybw27x91endbEgxLHU0BLdaY/xbdwSLZT03U
         iqWMnnQ8i8djzeYPImFi2FXWlSgPezJJCuKZyzuiVSpo6mqr0s8jCqEcVQGeMdNjTm
         6FOgf1zP9yQTw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH v3 2/6] jffs2: mark __jffs2_dbg_superblock_counts() static
Date:   Thu, 23 Nov 2023 12:05:02 +0100
Message-Id: <20231123110506.707903-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123110506.707903-1-arnd@kernel.org>
References: <20231123110506.707903-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This function is only called locally and does not need to be
global. Since there is no external prototype, gcc warns about
the non-static definition:

fs/jffs2/debug.c:160:6: error: no previous prototype for '__jffs2_dbg_superblock_counts' [-Werror=missing-prototypes]

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/jffs2/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/debug.c b/fs/jffs2/debug.c
index 9d26b1b9fc01..0925caab23c4 100644
--- a/fs/jffs2/debug.c
+++ b/fs/jffs2/debug.c
@@ -157,7 +157,7 @@ __jffs2_dbg_prewrite_paranoia_check(struct jffs2_sb_info *c,
 	kfree(buf);
 }
 
-void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
+static void __jffs2_dbg_superblock_counts(struct jffs2_sb_info *c)
 {
 	struct jffs2_eraseblock *jeb;
 	uint32_t free = 0, dirty = 0, used = 0, wasted = 0,
-- 
2.39.2

