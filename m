Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7145878571F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjHWLu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHWLu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED900CF;
        Wed, 23 Aug 2023 04:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A60561501;
        Wed, 23 Aug 2023 11:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28566C433C8;
        Wed, 23 Aug 2023 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791455;
        bh=8LLUhYnER6NHg4If5ClhYQ11jKYl73hLNR9IjMOFoGU=;
        h=From:To:Cc:Subject:Date:From;
        b=qBZtdO/9vyUhHsODPx8d0VyXNahln2jOHjZBqsyvfmIBlegnLviDp5op9bIQbFm8Z
         ghNk4o7dv7nKSJL9Atatsill3CYoACxItpAbvSq9scosyA86wzjqQF6Dx3FTYQQ4hA
         g08jr2areF1du2duz7doSZyCxH34lxaxH98lnqvjfY5dPpspFBJIoqHAvVxFt4DSLi
         oAJ4V3cf9Yhxe+HfXFqCz3rAtxPXiqI3UYbEtJa2GlkFNnIk8puPSdHPNTVCyUa/M+
         eWe77kLeYjh47RsGDHc0mLaVDlxiqkykMHR6tPABa2o/0zU5uxFUr4CNNxMbXZQUor
         MfZBuS/+nFo0g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/8] kbuild: do not run depmod for 'make modules_sign'
Date:   Wed, 23 Aug 2023 20:50:41 +0900
Message-Id: <20230823115048.823011-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to
scripts/Makefile.modinst") started to run depmod at the end of
'make modules_sign'.

Move the depmod rule to scripts/Makefile.modinst and run it only when
$(modules_sign_only) is empty.

Fixes: 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to scripts/Makefile.modinst")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index e0d52539a0f1..7d54a0700c6e 100644
--- a/Makefile
+++ b/Makefile
@@ -1877,7 +1877,9 @@ quiet_cmd_depmod = DEPMOD  $(MODLIB)
 
 modules_install:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+ifndef modules_sign_only
 	$(call cmd,depmod)
+endif
 
 else # CONFIG_MODULES
 
-- 
2.39.2

