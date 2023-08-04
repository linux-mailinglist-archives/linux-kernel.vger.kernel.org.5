Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D56770097
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjHDM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjHDM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:56:18 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F9946A8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1691153771; bh=ZMXn8jVebSrtDL/LBnjGzGXwPqNhsZz6dbtGGMrDzdM=;
        h=From:To:Cc:Subject:Date:From;
        b=j52ZqcX3hlCsROiovI7K3ufrvQbD4+1eZJDWNURt85bBy5bhkdRCnJseSXRxqlI/C
         w5poC7S7IF8ag+vZ2ZxtjeF+uk87kX1lA/UCuvsFa0UeRC2ZHaOfdjmJedckrLjde3
         2NTodXEeSykH3g9dARM29xIURFvU61z/MSAS0pDk=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 79398600CE;
        Fri,  4 Aug 2023 20:56:11 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] LoongArch: Drop -ffreestanding from CFLAGS
Date:   Fri,  4 Aug 2023 20:56:09 +0800
Message-Id: <20230804125609.2054719-1-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

As explained by Nick in the original issue: the kernel usually does a
good job of providing library helpers that have similar semantics as
their ordinary userspace libc equivalents, but -ffreestanding disables
such libcall optimization and other related features in the compiler,
which can lead to unexpected things such as CONFIG_FORTIFY_SOURCE not
working (!).

As it turns out to be the case, removing the flag does not impact the
LoongArch kernel's normal operation at all; so just remove it to
restore expected libcall semantics globally on this architecture.

Closes: https://github.com/ClangBuiltLinux/linux/issues/1897
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index b1e5db51b61c..db0d7210272d 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -83,7 +83,6 @@ KBUILD_CFLAGS_KERNEL		+= -fPIE
 LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
 endif
 
-cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
 load-y		= 0x9000000000200000
-- 
2.40.0

