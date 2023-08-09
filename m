Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B47776AC9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHIVLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHIVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA21E76
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B7FF63992
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA46DC433C9;
        Wed,  9 Aug 2023 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691615462;
        bh=BzKO4U1A9Pg48evAvr4KXsSow72w1vhtSaYZE8tLaDE=;
        h=From:To:Cc:Subject:Date:From;
        b=JdUnJ78Kq9r+M/3baHIQcsnjr+sQWETJMmrjepw2tReZhw8wppIYENuXflmJJhwu0
         QrV2XcW6GcNTkM/uWOUjXrFSwX4ro+pbKiEgrkH+LcZG6djX9d+HJX+Dbq4dFSszTe
         RbsCs4UNI4DgZTAk7ViZprEeOj9q1NnfyPgqAPoAVQ8deIfQnoAo5+KGdf/D5IXLzo
         l3IbaW2ZeMT0aKgVZnrcT0awqinPCtr++mfZnCdyPy/jUJ73PrfDO0SgUX2xaP4N5C
         UR80Ns0A2toOUhDh8GtUdFYoTHdGAl3llEGo5gYxtvCmhxlUZO4n0qjo3sOAMQDOZz
         QGTfem6LgJ5uQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] m68k: define __div64_32() to avoid a warning
Date:   Wed,  9 Aug 2023 23:10:49 +0200
Message-Id: <20230809211057.60514-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The generic __div64_32() definition is built on all architectures that don't
provide this as a macro. m68k however neither defines nor requires __div64_32,
so it should define an empty one to avoid the warning:

lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/include/asm/div64.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/m68k/include/asm/div64.h b/arch/m68k/include/asm/div64.h
index 365f39f5e256f..df1f6b450cc51 100644
--- a/arch/m68k/include/asm/div64.h
+++ b/arch/m68k/include/asm/div64.h
@@ -31,6 +31,9 @@
 	__rem;							\
 })
 
+/* defining this stops the unused helper function from being built */
+#define __div64_32 __div64_32
+
 #endif /* CONFIG_CPU_HAS_NO_MULDIV64 */
 
 #endif /* _M68K_DIV64_H */
-- 
2.39.2

