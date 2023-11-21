Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AB7F3A82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjKUX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjKUX5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:57:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9B21A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:57:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044C8C433CB;
        Tue, 21 Nov 2023 23:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611030;
        bh=YIz9IynczYR7U90yH62Boq0adsyZcqNtIbOqQHRnXxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AECmMPUzvp8OXYGuSbkcsiIb34EBjISMOkmWB2e0PFYP0yRrPV111M7GOBfowZNN9
         up76BEiuiYJqSAR34fIl/dpeV+M26AGqlNgIZ7weQvatRSoSNPHb3QmAgVL+NwA7V5
         kbxf7LyKTuUlSZ2k1FnPL1qQlEpdpaICq0hfnIxKsk1srhCMPrZuW3Gs4wTfFhGaBk
         1XdJ2mBbU8cpu56+aOe41iJTYfvsUDQQ7WyE/tpkmg0hE0B7635Pib6QFRcFp2APo6
         9JLgWVBezkbY/5MKejlBvALX+U4PPadgpAjAyNoIGOLgl8yYOcCE0I2RDhYOzISAHP
         cBXqqqbqpFBjg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86: vdso: consolidate targets and clean-files
Date:   Wed, 22 Nov 2023 08:56:58 +0900
Message-Id: <20231121235701.239606-2-masahiroy@kernel.org>
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

'targets' and 'clean-files' do not need to list the same files because
the files listed in 'targets' are cleaned up.

Refactor the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/vdso/Makefile | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1608f7..2038d9c8e527 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -55,11 +55,8 @@ targets += vdso32/vdso32.lds $(vobjs32-y)
 
 # Build the vDSO image C files and link them in.
 vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-vdso_img_cfiles := $(vdso_img-y:%=vdso-image-%.c)
-vdso_img_sodbg := $(vdso_img-y:%=vdso%.so.dbg)
 obj-y += $(vdso_img_objs)
-targets += $(vdso_img_cfiles)
-targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
+targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
 
@@ -190,5 +187,3 @@ GCOV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
       cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
-
-clean-files := vdso32.so vdso32.so.dbg vdso64* vdso-image-*.c vdsox32.so*
-- 
2.40.1

