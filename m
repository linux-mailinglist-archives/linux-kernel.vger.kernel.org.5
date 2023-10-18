Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373DA7CDED8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjJROOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbjJRON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:13:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605FD171B;
        Wed, 18 Oct 2023 07:13:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F062AC433AD;
        Wed, 18 Oct 2023 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638386;
        bh=IAM9CKLaPtNXubWoOm1/p0ts6fbbUCbkGOnaiX63Cy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qFTH4B63ai6zWgvNDeY8DhhdgLCcRRAVcS1xEXJxKBRHjBEBNKC2ZP9udb/IGYrW9
         X9MHypwuoCrzhs3QvtaxO0W8DvwXAndCrn5Mww7GFj0XnNMI+ScD7XjR+zBEioWRk4
         lgAtTw7RgEQDKk3gGJurDAfOIsjJ0eSh9USe320l9gbsTOm9rfNNs2duzxiKJ/ewn6
         C5SctS27IOMSCn4228ZurmagccUMaDF4VTxago4M6B6sjboI3I/3F76f8yFMc98+I2
         HpmPFABpiq7E2pDGu5DuRwpS3ndBWXfqTGx2x7+0PjctOmGLeR1v/d6brKaAC77P3d
         17cwl12MXALBQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, npiggin@gmail.com,
        sv@linux.ibm.com, masahiroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.5 27/31] powerpc/85xx: Fix math emulation exception
Date:   Wed, 18 Oct 2023 10:11:44 -0400
Message-Id: <20231018141151.1334501-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141151.1334501-1-sashal@kernel.org>
References: <20231018141151.1334501-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.7
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 8e8a12ecbc86700b5e1a3596ce2b3c43dafad336 ]

Booting mpc85xx_defconfig kernel on QEMU leads to:

Bad trap at PC: fe9bab0, SR: 2d000, vector=800
awk[82]: unhandled trap (5) at 0 nip fe9bab0 lr fe9e01c code 5 in libc-2.27.so[fe5a000+17a000]
awk[82]: code: 3aa00000 3a800010 4bffe03c 9421fff0 7ca62b78 38a00000 93c10008 83c10008
awk[82]: code: 38210010 4bffdec8 9421ffc0 7c0802a6 <fc00048e> d8010008 4815190d 93810030
Trace/breakpoint trap
WARNING: no useful console

This is because allthough CONFIG_MATH_EMULATION is selected,
Exception 800 calls unknown_exception().

Call emulation_assist_interrupt() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/066caa6d9480365da9b8ed83692d7101e10ac5f8.1695657339.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/head_85xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index fdbee1093e2ba..f9634111e82ed 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -396,7 +396,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, unknown_exception)
+	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, emulation_assist_interrupt)
 #endif
 
 	/* System Call Interrupt */
-- 
2.40.1

