Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9289F7F3A84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjKUX5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjKUX5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:57:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099C1A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:57:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF890C433CC;
        Tue, 21 Nov 2023 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611036;
        bh=Kbe8XGZbLDUllBFU/Mfn+D2rr3svacMDADLa8sIZMi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUNEFwrZo225RtXVaOe/hy+9Kvk/BDvCi0m0LK/GZN9DL8vPOWrhlAUEqW4o69p0e
         Rr6JSs06aPB9kL8BU3tnPfugX+oMtpUSGg6UZ2QaUUxgIhCEYfmUs2Xb8QKdknTF27
         55Opvav/2/yfgE+9o35iaZGTGWOTzz4sKpKyCf3fqhWslI5tfiOfoSLExDrxPmyKJW
         9+TwJ8ReL+/R77yKVO3CtZm9xUeE8dUXzEoCNJcC3XH/tBROytVwoUxHXeB+KdIt6k
         EXRmQtkK8vshbpVr6ISpOGV2wx6J5bXklopRc0DTPdzcCYHYlHMAXs/syv8/YBYCbB
         UvpzJntMow/ng==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] x86: vdso: use CONFIG_COMPAT_32 to specify vdso32
Date:   Wed, 22 Nov 2023 08:57:01 +0900
Message-Id: <20231121235701.239606-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121235701.239606-1-masahiroy@kernel.org>
References: <20231121235701.239606-1-masahiroy@kernel.org>
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

In arch/x86/Kconfig, COMPAT_32 is defined as (IA32_EMULATION || X86_32).
Use it to eliminate redundancy in Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Makefile            | 3 +--
 arch/x86/entry/vdso/Makefile | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..0899e71ddcc6 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -296,8 +296,7 @@ install:
 
 vdso-install-$(CONFIG_X86_64)		+= arch/x86/entry/vdso/vdso64.so.dbg
 vdso-install-$(CONFIG_X86_X32_ABI)	+= arch/x86/entry/vdso/vdsox32.so.dbg
-vdso-install-$(CONFIG_X86_32)		+= arch/x86/entry/vdso/vdso32.so.dbg
-vdso-install-$(CONFIG_IA32_EMULATION)	+= arch/x86/entry/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_COMPAT_32)	+= arch/x86/entry/vdso/vdso32.so.dbg
 
 archprepare: checkbin
 checkbin:
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 439b52772e69..7a97b17f28b7 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -35,8 +35,7 @@ OBJECT_FILES_NON_STANDARD_extable.o	:= n
 # vDSO images to build
 obj-$(CONFIG_X86_64)		+= vdso-image-64.o
 obj-$(CONFIG_X86_X32_ABI)	+= vdso-image-x32.o
-obj-$(CONFIG_X86_32)		+= vdso-image-32.o vdso32-setup.o
-obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
+obj-$(CONFIG_COMPAT_32)		+= vdso-image-32.o vdso32-setup.o
 
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
-- 
2.40.1

