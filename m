Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D14763DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjGZRmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGZRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7C2685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19D9F61BE6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2CAC433C8;
        Wed, 26 Jul 2023 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690393323;
        bh=fOYigNePlsrUb3dRqIC3/Ob7Qzi/aiqzn31+xV+bzaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+M6E067FfjPCZKuJZ9lNLLwnZz6jYodnhLy8yF03C92zX0IDO+m+B0T3XW7vgkWO
         ohRoqa0nqbgJGOpOmKbL4G/WsqqPzBga43sKWCQuGiNdPONCwZR2FpotNJJF+VoDsG
         GecnymJv0fJbCrZ8cig1QeUA390l7lo07iri5hS+3Dd+IgmGCQ7+pMhqBTaMwwUqY+
         bviq+VCCP4wowizlnlhzQcmp9Jkjq8YeCwvKbxVjEQysKW6NxMCTvnjLSsmtp+3a7g
         WYuiCHaG+Z9eK1oFo7F+f9RxSRMzM9YMqwuWgzSjTI540Z3RGbmbPFFycCmpgJ2Rgc
         tJeSD92FmJhXQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] riscv: vdso.lds.S: merge .data section into .rodata section
Date:   Thu, 27 Jul 2023 01:30:23 +0800
Message-Id: <20230726173024.3684-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230726173024.3684-1-jszhang@kernel.org>
References: <20230726173024.3684-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .data section doesn't need to be separate from .rodata section,
they are both readonly.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index d43fd7c7dd11..671aa21769bc 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -29,7 +29,13 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
-	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+	.rodata		: {
+		*(.rodata .rodata.* .gnu.linkonce.r.*)
+		*(.got.plt) *(.got)
+		*(.data .data.* .gnu.linkonce.d.*)
+		*(.dynbss)
+		*(.bss .bss.* .gnu.linkonce.b.*)
+	}
 
 	/*
 	 * This linker script is used both with -r and with -shared.
@@ -44,13 +50,6 @@ SECTIONS
 	.alternative : {
 		*(.alternative)
 	}
-
-	.data		: {
-		*(.got.plt) *(.got)
-		*(.data .data.* .gnu.linkonce.d.*)
-		*(.dynbss)
-		*(.bss .bss.* .gnu.linkonce.b.*)
-	}
 }
 
 /*
-- 
2.40.1

