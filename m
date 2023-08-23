Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97D78572B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjHWLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbjHWLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00110D8;
        Wed, 23 Aug 2023 04:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9F165EE5;
        Wed, 23 Aug 2023 11:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE280C433BC;
        Wed, 23 Aug 2023 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791467;
        bh=ppMUv0qLwsFmCUlGZJ1h69t/Ezpj7sAWUVh2xcrRGhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u55izHtNM83xo+KNviVMW6hJuLR0ipOxmL++Qw726xia7DnlmR+IhknA1t8iHR7lp
         AS2P762LWUcvgSqANgDl3aUFiD2vrTMQfQ+cgN7dtr8Pnmti10l7IpYsHH+JnX+fAy
         0Q7xhCfyaW6Jwxj4HCYLOkci6MepfljpcUVPDWvianMj0ISgPG8alH9TZeeF16R0Ee
         I9H3/QjGxEXfpf4v5THgyvp8e0wrhGR4a9rWgg6KN0qr4W047kVUm9Iqi5ZOsW6IHi
         PCoUE3vrH/WDgrsNwGgH57lENYZBT32rcW+JPBosHMjXSgyO8rsXKJsfnapylA6dLC
         PVzdu1wvZ28kQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 7/8] kbuild: support 'make modules_sign' with CONFIG_MODULE_SIG_ALL=n
Date:   Wed, 23 Aug 2023 20:50:47 +0900
Message-Id: <20230823115048.823011-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d890f510c8e4 ("MODSIGN: Add modules_sign make target") introduced
'make modules_sign' to manually sign modules.

Some time later, commit d9d8d7ed498e ("MODSIGN: Add option to not sign
modules during modules_install") introduced CONFIG_MODULE_SIG_ALL.
If it was disabled, mod_sign_cmd was set to no-op ('true' command).
It affected not only 'make modules_install' but also 'make modules_sign'.
With CONFIG_MODULE_SIG_ALL=n, 'make modules_install' did not sign modules
and 'make modules_sign' could not sign modules either.

Kbuild has kept that behavior, and nobody has complained about it, but
I think it is weird.

CONFIG_MODULE_SIG_ALL=n should turn off signing only for modules_install.
If users want to sign modules manually, they should be allowed to use
'make modules_sign'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modinst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index dc7c54669082..33d424a3f265 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -106,7 +106,6 @@ endif
 # Signing
 # Don't stop modules_install even if we can't sign external modules.
 #
-ifeq ($(CONFIG_MODULE_SIG_ALL),y)
 ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
 sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(srctree)/)$(CONFIG_MODULE_SIG_KEY)
 else
@@ -115,13 +114,15 @@ endif
 quiet_cmd_sign = SIGN    $@
       cmd_sign = scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
-else
+
+ifeq ($(modules_sign_only),)
+
+# During modules_install, modules are signed only when CONFIG_MODULE_SIG_ALL=y.
+ifndef CONFIG_MODULE_SIG_ALL
 quiet_cmd_sign :=
       cmd_sign := :
 endif
 
-ifeq ($(modules_sign_only),)
-
 $(dst)/%.ko: $(extmod_prefix)%.ko FORCE
 	$(call cmd,install)
 	$(call cmd,strip)
-- 
2.39.2

