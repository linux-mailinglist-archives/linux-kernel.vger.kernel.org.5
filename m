Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9C76B09B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjHAKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjHAKNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:13:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9110CA;
        Tue,  1 Aug 2023 03:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36C761525;
        Tue,  1 Aug 2023 10:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C32C433C9;
        Tue,  1 Aug 2023 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690884713;
        bh=Mema2WOgggjRLjdeivhOjSi5gn1KSKttjlm9f2Ugbak=;
        h=From:To:Cc:Subject:Date:From;
        b=ZtE0jhP0INdoMt0NEZyGTqVWtT5JhKgQXBsn01xmytSWej5pW6CRuPWX80pbrW4RJ
         r+yg86qARF+D09fxyJ9wbWW8inJt2sPUmwCyAJRKLy/euBTQAj0OMclx6Yd2OyWKYf
         U05nVa+gFKDcKJLFcjY6ZOQMkAHG2MLUnQnk69FZRwEixkR+PXGOPxWP4RT9A9Z4fm
         xxMxMmIUdRMK3PbJzn9r7zvDDkZjxXfQs983LhOH1tI2rddnUfnoGYl3OVaHhuAs0o
         jp999v4DdwwH1uNgZyc5VD8Cav9Mhqoe4D+winfUGGQNfh0dGFHJjY9235wGZTxhHp
         opxuJO8WnBq1Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] crypto: arm64/aes: remove Makefile hack
Date:   Tue,  1 Aug 2023 19:11:46 +0900
Message-Id: <20230801101146.1550814-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Do it more simiply. This also fixes single target builds.

[before]

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
    [snip]
  make[4]: *** No rule to make target 'arch/arm64/crypto/aes-glue-ce.i'.  Stop.

[after]

  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- arch/arm64/crypto/aes-glue-ce.i
    [snip]
    CPP     arch/arm64/crypto/aes-glue-ce.i

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/crypto/Makefile        | 5 -----
 arch/arm64/crypto/aes-glue-ce.c   | 2 ++
 arch/arm64/crypto/aes-glue-neon.c | 1 +
 3 files changed, 3 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/crypto/aes-glue-ce.c
 create mode 100644 arch/arm64/crypto/aes-glue-neon.c

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 4818e204c2ac..fbe64dce66e0 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -81,11 +81,6 @@ aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
 obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
 aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
 
-CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
-
-$(obj)/aes-glue-%.o: $(src)/aes-glue.c FORCE
-	$(call if_changed_rule,cc_o_c)
-
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
diff --git a/arch/arm64/crypto/aes-glue-ce.c b/arch/arm64/crypto/aes-glue-ce.c
new file mode 100644
index 000000000000..7d309ceeddf3
--- /dev/null
+++ b/arch/arm64/crypto/aes-glue-ce.c
@@ -0,0 +1,2 @@
+#define USE_V8_CRYPTO_EXTENSIONS
+#include "aes-glue.c"
diff --git a/arch/arm64/crypto/aes-glue-neon.c b/arch/arm64/crypto/aes-glue-neon.c
new file mode 100644
index 000000000000..8ba046321064
--- /dev/null
+++ b/arch/arm64/crypto/aes-glue-neon.c
@@ -0,0 +1 @@
+#include "aes-glue.c"
-- 
2.39.2

