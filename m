Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B47F21B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTXyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjKTXyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:54:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1AECD;
        Mon, 20 Nov 2023 15:54:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E136C433C7;
        Mon, 20 Nov 2023 23:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700524488;
        bh=IkpIZj++DJgUNFvrpRT/go6WOMEZiOgtvEqU2kpcy+o=;
        h=From:To:Cc:Subject:Date:From;
        b=DXz+XwPxEaFg7E7aF4yQHNjaOd0eD2gksxKsFF5RcAx6Piy6+mqkPE/LFE6Y+w08D
         cKVqaeX3XHn0x6zx72LzYWnSwZYz1pG6/BSUTzdl9vZZfTHT9kzL2hTMYVIzgsLgb4
         3ZB2TnJOTaJkS50yuU2XazXA26XROj9RYl9aE1DDviJG6ilLzaxd1PDVRSwtpN4ce8
         lW6lOGVC7Fu2j/tBgfXexhrRCL47I7SZW4td35vY9QOVkYemQxl09jYzKWk1RnvOY/
         usQhTteBKJ/GyUHq0XDgSUsTha+EuXM2f/RMYCkm7b7GXqBQQngOUxtCDJKDf2vrSl
         34jcPPxiWQUkg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove unneeded $(foreach )
Date:   Tue, 21 Nov 2023 08:54:23 +0900
Message-Id: <20231120235423.4103310-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use $(foreach ...) for iterating over just one
parameter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/kernel/vsyscall/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/vsyscall/Makefile b/arch/sh/kernel/vsyscall/Makefile
index 6e8664448048..118744d349e2 100644
--- a/arch/sh/kernel/vsyscall/Makefile
+++ b/arch/sh/kernel/vsyscall/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += vsyscall.o vsyscall-syscall.o vsyscall-syms.o
 
-$(obj)/vsyscall-syscall.o: \
-	$(foreach F,trapa,$(obj)/vsyscall-$F.so)
+$(obj)/vsyscall-syscall.o: $(obj)/vsyscall-trapa.so
 
 # Teach kbuild about targets
-targets += $(foreach F,trapa,vsyscall-$F.o vsyscall-$F.so)
+targets += vsyscall-trapa.o vsyscall-traps.so
 targets += vsyscall-note.o vsyscall.lds vsyscall-dummy.o
 
 # The DSO images are built using a special linker script
-- 
2.40.1

