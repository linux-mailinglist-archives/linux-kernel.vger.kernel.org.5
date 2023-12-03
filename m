Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593880226D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjLCKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:14:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7371F3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:14:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB5C433C7;
        Sun,  3 Dec 2023 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701598465;
        bh=SGw12HvAh6TeQkpp7+yNIE4rnwWaTLqwCH5qBGJLnPo=;
        h=From:To:Cc:Subject:Date:From;
        b=NmJ1avpbXG/IdCjt2tV9705sdIZXNYxaRNYb0NrLDWYjC2HRPhwatyCll0V5oRvIC
         LRcqvi1UI1OApssEtcpQgzI5myhiaDRfGWy9iHvusH5/eFZFyM8WP21OerrNKTtflB
         k1edi6XjHZFpY4Rh3JzXO7EFua+u/OtTZeTowPwFn5mXQFSkTfHDLGmmjQCkN2Zriz
         jGLr344AvH2DLlh9vvhYOWDrKZIZeDNCOcrWtOCPrC6788/UTmfAqP+ptVgZDpcYD9
         scHM14/olcPuel7rjRcG4MlezAJszmFQBcTgGVGSqtmpA0bLOKUXduV8agxgo3ALUk
         tb3irtm0FktYQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 1/3] sparc: vdso: clean up build artifacts in arch/sparc/vdso/
Date:   Sun,  3 Dec 2023 19:14:16 +0900
Message-Id: <20231203101418.1910661-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vdso-image-*.c, vdso*.so, vdso*.so.dbg are not cleaned
because 'make clean' does not include include/config/auto.conf,
resulting in $(vdso_img-y) being empty.

Add the build artifacts to 'targets' unconditionally.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index d08c3a0443f3..eb52d0666ffc 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -24,11 +24,8 @@ targets += vdso.lds $(vobjs-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
-vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
 obj-y += $(vdso_img_objs)
-targets += $(vdso_img_cfiles)
-targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
+targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
 
-- 
2.40.1

