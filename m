Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6A8031F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjLDL6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjLDL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DA1738
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9769AC433CC;
        Mon,  4 Dec 2023 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691055;
        bh=SyiutF6r1lYIBhrZamcCKmSjbvADpqrs+8irYVNoqts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0b2PVdLqrFPaIeHzatnB0JuZ9dTmwindq3FicXcUcWOKG2XetUUX+fgOaPU6zWE3
         wwaVaQM6qkPhyo6ZQGmK8EsRLF/7hL7pe7Mo9Fzqabdq083ZidoFeptc55i4cXo8+2
         AHLLhkPeFGeE8RjrA1GRn1pGavgJ0BAcAxWxcVvUPDaPuKG4M5CPlMg5B1FyQ/965O
         wQZP+CGclMW5ZTGn+BC25vOJ/95gsZCnD14DJYhzyQM5xxNtrm4JoyHczPeojyb3Oq
         CvegkX/CPWsFhq5iNEau5i6tm2sU+iKZuWikhNVwBRUSf7Rh+eM/aZzjT19MUSscWx
         1SWSG4K+pG0XQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 08/20] mips: move jump_label_apply_nops() declaration to header
Date:   Mon,  4 Dec 2023 12:56:58 +0100
Message-Id: <20231204115710.2247097-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

Instead of an extern declaration in the C file with the caller, move it
to an appropriate header, avoiding

arch/mips/kernel/jump_label.c:93:6: error: no previous prototype for 'jump_label_apply_nops' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/jump_label.h | 3 +++
 arch/mips/kernel/module.c          | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index c5c6864e64bc..081be98c71ef 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -15,6 +15,9 @@
 #include <linux/types.h>
 #include <asm/isa-rev.h>
 
+struct module;
+extern void jump_label_apply_nops(struct module *mod);
+
 #define JUMP_LABEL_NOP_SIZE 4
 
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index 0c936cbf20c5..7b2fbaa9cac5 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -20,8 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/jump_label.h>
-
-extern void jump_label_apply_nops(struct module *mod);
+#include <asm/jump_label.h>
 
 struct mips_hi16 {
 	struct mips_hi16 *next;
-- 
2.39.2

