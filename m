Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD35761A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGYNtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjGYNs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A531FD0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BB46171E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C0C433CA;
        Tue, 25 Jul 2023 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690292932;
        bh=v5mmMDcLa9Qz+qTohnDO/9Jf2svRDFSXLGnLYI1Fcc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFLrP4GFqOQh1yYxfBN3ODV9bJRXnvbtT/GzhtfnMr9ePZxfUcUQ5Tpbu6wCPpWiv
         DEWidaqarR3eOw48om02/LZ0u+9Rm8NttxomDfeRglYP1kAkaxYz8U7vwU952avJxp
         0z4EZWQHx9tE+V6WXJWWFalOHebK3xkhBjtd+p7wxI3Nz22nLbokLkXvbWjdjuZ6zX
         bgiBdi+0YLD8sUs2wGrHHeDRn18ppYuUEwtRBChFKIc+vtRklup8j10Wj6oeDl6/vG
         WnGaZP7eTI80FgbsesszEcFL11NNEu0hhaHcJNQsehnI1n5xnpbjlio1NAwdRNFEdd
         QQjkIiZqz2AyA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function definition
Date:   Tue, 25 Jul 2023 15:48:34 +0200
Message-Id: <20230725134837.1534228-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725134837.1534228-1-arnd@kernel.org>
References: <20230725134837.1534228-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

The __div64_32() function is provided for 32-bit architectures that
don't have a custom do_div() implementation. x86_32 has one, and
does not use the header file that declares the function prototype,
so the definition causes a W=1 warning:

lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]

Define an empty macro to prevent the function definition from getting
built, which avoids the warning and saves a little .text space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/div64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index b8f1dc0761e4b..9826d5fc12e34 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -71,6 +71,8 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #define mul_u32_u32 mul_u32_u32
 
+#define __div64_32 /* not needed */
+
 #else
 # include <asm-generic/div64.h>
 
-- 
2.39.2

