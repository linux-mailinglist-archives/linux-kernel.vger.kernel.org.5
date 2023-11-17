Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37EC7EF318
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbjKQM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKQM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:56:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF7D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:56:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31622C433C8;
        Fri, 17 Nov 2023 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700225788;
        bh=yco5pbCsXVo4oB/2D289CCmrjEJWr/ntTfP78uZgSQg=;
        h=From:To:Cc:Subject:Date:From;
        b=SyUUwtGZuBn4aCSski5/plxAqG2+LmPMq9vD7y1k4dUlLrsJyGo/NWNMEBQxD5DCL
         EgtiZ1dJSvVWbLuYP2Pyasc3X2OCJ+gCGVfeBP+YDe7N5UgRsJUl74jOiAUfxACFcV
         AyL8KDVvUp4DGZ0Nj0BVSkTgu/GHu3z5efDTS/DlaFIzWaGfK1olMftzdaXQq/3Etb
         Iux6pio2DEnkfR7/Tkvke2cAyFbQC0n9x5HfhjuOwBKCcNBaLhg1azu8t99A2bZ7e7
         qK4as0pB0uV6ZJbAg0hmRdjfGu9Lt8Z9aKMAhAelAd5tRJTd1diteDfq/QootGHcPa
         m6HJPrvkAtZWg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] arm64: vdso32: rename 32-bit debug vdso to vdso32.so.dbg
Date:   Fri, 17 Nov 2023 21:56:19 +0900
Message-Id: <20231117125620.1058300-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make vdso_install' renames arch/arm64/kernel/vdso32/vdso.so.dbg to
vdso32.so during installation, which allows 64-bit and 32-bit vdso
files to be installed in the same directory.

However, arm64 is the only architecture that requires this renaming.

To simplify the vdso_install logic, rename the in-tree vdso file so
its base name matches the installed file name.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile               | 2 +-
 arch/arm64/kernel/vdso32/Makefile | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..4a1ad3248c2d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -200,7 +200,7 @@ endif
 endif
 
 vdso-install-y				+= arch/arm64/kernel/vdso/vdso.so.dbg
-vdso-install-$(CONFIG_COMPAT_VDSO)	+= arch/arm64/kernel/vdso32/vdso.so.dbg:vdso32.so
+vdso-install-$(CONFIG_COMPAT_VDSO)	+= arch/arm64/kernel/vdso32/vdso32.so.dbg
 
 include $(srctree)/scripts/Makefile.defconf
 
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 1f911a76c5af..2266fcdff78a 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -118,7 +118,7 @@ endif
 VDSO_CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
 
 # Build rules
-targets := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso) vdso.so vdso.so.dbg vdso.so.raw
+targets := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso) vdso.so vdso32.so.dbg vdso.so.raw
 c-obj-vdso := $(addprefix $(obj)/, $(c-obj-vdso))
 c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
 asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
@@ -127,15 +127,15 @@ obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
-include/generated/vdso32-offsets.h: $(obj)/vdso.so.dbg FORCE
+include/generated/vdso32-offsets.h: $(obj)/vdso32.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
 # Strip rule for vdso.so
 $(obj)/vdso.so: OBJCOPYFLAGS := -S
-$(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
+$(obj)/vdso.so: $(obj)/vdso32.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/$(munge) FORCE
+$(obj)/vdso32.so.dbg: $(obj)/vdso.so.raw $(obj)/$(munge) FORCE
 	$(call if_changed,vdsomunge)
 
 # Link rule for the .so file, .lds has to be first
-- 
2.40.1

