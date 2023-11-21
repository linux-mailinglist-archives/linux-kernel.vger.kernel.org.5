Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E797F3A83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjKUX50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjKUX5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:57:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D71A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:57:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA97DC433C7;
        Tue, 21 Nov 2023 23:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611034;
        bh=Fkwx/7dQoGPA1O843IBgRSOzjaXZ20gyiZMK5qWVDQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c01rYmA+0CI4XR/8U9hC++WrFzlDXyIYnsbGSyyfW036RN4nYUTUeme3vmska38aM
         wIWQ8k6/WfO+bitXUsyNMcN6vIGTHhpH/YOgqwx6LlQmo5RhvngfYtwMdv2Kd46Inb
         NCutzrvuFJoGA9kEGcWNj3T8PtFBh+LYPanD1qpaeKfuM31HKDDP5NFf0jpyyMbgAy
         +kYx4U9W1mge/911DdSElhawseIECJNwwTuW4/8U9yjkiF3IfJ1T3nsRj5oW2IKBWE
         B5ijq2DeQWWR3wrIgO3uHAYBaXZGhX5aZWMlgd38aM6TTlECz+onG4YbqCPJHaIIMN
         6Brw+jm64NG4A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86: vdso: use $(addprefix ) instead of $(foreach )
Date:   Wed, 22 Nov 2023 08:57:00 +0900
Message-Id: <20231121235701.239606-4-masahiroy@kernel.org>
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

$(addprefix ) is slightly shorter and more intuitive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/vdso/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index cbfb5aab5e9c..439b52772e69 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -40,8 +40,8 @@ obj-$(CONFIG_IA32_EMULATION)	+= vdso-image-32.o vdso32-setup.o
 
 OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
-vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
-vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
+vobjs := $(addprefix $(obj)/, $(vobjs-y))
+vobjs32 := $(addprefix $(obj)/, $(vobjs32-y))
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
@@ -112,7 +112,7 @@ VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
 
 # same thing, but in the output directory
-vobjx32s := $(foreach F,$(vobjx32s-y),$(obj)/$F)
+vobjx32s := $(addprefix $(obj)/, $(vobjx32s-y))
 
 # Convert 64bit object file to x32 for x32 vDSO.
 quiet_cmd_x32 = X32     $@
-- 
2.40.1

