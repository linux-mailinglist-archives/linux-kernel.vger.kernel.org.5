Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E476E318
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHCI3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjHCI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:28:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D533AB6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3402E61CC6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0034DC43391;
        Thu,  3 Aug 2023 08:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691051191;
        bh=fjxWdl9NmQdDwhM5ZKtH0mdm+UmjLs4KGMTSYInCLOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeExSGNArapYCallEIwOX8qDGOPGJMI4G2dmUxh7c9DdfS75Ur5qdYJR8JBD91ihm
         ZXRv9YT8Al2voUbmcnhm7LWBPS7yEkAEBB0nr/k9pU2eKx3Lotp1SRVdTdu5z0WmBj
         p81RUKDKFk3UEaUbgfl5IBsMIoYAjqDfGoz8AoC0a/ALAma/6FZLx2wpVAvEQ5xW0l
         MTYe7vYOKuSn8s5iGdpJHBGp/FoTLS7D16o8/BozLBmmMzCVFg/RNx0s6rGNrhG+La
         QlERLC9JjmAFOX22dxWsST2nH2S5uYK2Z6CXASk6cpAeKp9Ls0kJnRseaZCQKLdQS+
         4zNXOTBP5eevg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 3/7] x86: avoid unneeded __div64_32 function definition
Date:   Thu,  3 Aug 2023 10:26:15 +0200
Message-Id: <20230803082619.1369127-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803082619.1369127-1-arnd@kernel.org>
References: <20230803082619.1369127-1-arnd@kernel.org>
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
v3: improve code comment
---
 arch/x86/include/asm/div64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index b8f1dc0761e4b..9931e4c7d73f3 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -71,6 +71,12 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #define mul_u32_u32 mul_u32_u32
 
+/*
+ * __div64_32() is never called on x86, so prevent the
+ * generic definition from getting built.
+ */
+#define __div64_32
+
 #else
 # include <asm-generic/div64.h>
 
-- 
2.39.2

