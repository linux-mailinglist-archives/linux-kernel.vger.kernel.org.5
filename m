Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295F80CC08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbjLKN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbjLKNzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:55:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A6C30DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:54:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF81C433B7;
        Mon, 11 Dec 2023 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302840;
        bh=wdNJDgqHvDzQr6q3lTGtBsDgx/ijcaDTNNN6qwjaRC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3xjA0mPON5y9hqfrcIgIc/MOZd1DVa6Z+3NRujO/rvhRp39mnwEw7iVmpquAjejI
         H3xn6oQIsdRUevtkFNo9vcyT8cPC8UKyF91hU9DODbeYBJAVhkaCb1JufSm5xN5TLI
         70JF6vDwQjfQ3ESCxvTeKjrcUtIHaXZrRw2s0B56n+i96DJwuYmelK7JDgaLYQk10+
         lx458Ufq4gnd8IeVIFcEJK5jyp9X7UKxsuUoSN2YuRQJgl4CXXanZ3FIMRTu7CVWpJ
         GlbSyuenluKSisDNOO2vvjhT4pKMExnIdZQmD1Uo0YHUKAAN3WjQ/aQZRnu+KFqJJe
         yX0SA/+PuKNOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     WANG Rui <wangrui@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        nathan@kernel.org, loongarch@lists.linux.dev, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 45/47] LoongArch: Apply dynamic relocations for LLD
Date:   Mon, 11 Dec 2023 08:50:46 -0500
Message-ID: <20231211135147.380223-45-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: WANG Rui <wangrui@loongson.cn>

[ Upstream commit eea673e9d5ea994c60b550ffb684413d3759b3f4 ]

For the following assembly code:

     .text
     .global func
 func:
     nop

     .data
 var:
     .dword func

When linked with `-pie`, GNU LD populates the `var` variable with the
pre-relocated value of `func`. However, LLVM LLD does not exhibit the
same behavior. This issue also arises with the `kernel_entry` in arch/
loongarch/kernel/head.S:

 _head:
     .word   MZ_MAGIC                /* "MZ", MS-DOS header */
     .org    0x8
     .dword  kernel_entry            /* Kernel entry point */

The correct kernel entry from the MS-DOS header is crucial for jumping
to vmlinux from zboot. This necessity is why the compressed relocatable
kernel compiled by Clang encounters difficulties in booting.

To address this problem, it is proposed to apply dynamic relocations to
place with `--apply-dynamic-relocs`.

Link: https://github.com/ClangBuiltLinux/linux/issues/1962
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index fb0fada43197e..390867fc45b84 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -80,7 +80,7 @@ endif
 
 ifeq ($(CONFIG_RELOCATABLE),y)
 KBUILD_CFLAGS_KERNEL		+= -fPIE
-LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext
+LDFLAGS_vmlinux			+= -static -pie --no-dynamic-linker -z notext $(call ld-option, --apply-dynamic-relocs)
 endif
 
 cflags-y += $(call cc-option, -mno-check-zero-division)
-- 
2.42.0

