Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F681785727
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjHWLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjHWLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF31E5E;
        Wed, 23 Aug 2023 04:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBF1657A1;
        Wed, 23 Aug 2023 11:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A59C433C8;
        Wed, 23 Aug 2023 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791463;
        bh=37LRz30ny/2YtsWajTxwFgePE/bkcRu4z9qqVGYU0fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gASx3gsERnDseTFtIvf6L+RZKnriMxcsLx4fT++ZCeuPubUkRzOAQMbuHwJnjd/yF
         59iFq70WIRzWHW7tTzI8upycG1vSzXDw6ajx+/lTWBSFbyj8bp4Tk9HuZG09Ylh8xT
         azmqOIzbn6ke44rNtBbyXoItg7iv3ipp/ltods8cXsP9itCBzHTkvUSzaawfacVgRD
         nJQVP6B/s/0J02nSZO8RKMvF8k6DgRKDd9fBqOnvfiG3+6yrs2W0x0Cqdy3TtyV7Ig
         6BRiugtjqUXfGqtyVmckGysdW71jFtBwdV9ea/efGqd1BBdgrQANG+fmRVqTCAEelc
         S7RfKfg8PsUzA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/8] kbuild: reduce the number of mkdir calls during modules_install
Date:   Wed, 23 Aug 2023 20:50:45 +0900
Message-Id: <20230823115048.823011-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling 'mkdir' for every module results in redundant syscalls.

Use $(sort ...) to drop the duplicated directories.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modinst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 7a64ece9b826..5d687a453d90 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -9,6 +9,13 @@ __modinst:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
+install-y :=
+
+PHONY += prepare
+
+prepare:
+	$(Q)mkdir -p $(sort $(dir $(install-y)))
+
 modules := $(call read-file, $(MODORDER))
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -27,6 +34,7 @@ suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
 
 modules := $(patsubst $(extmod_prefix)%.o, $(dst)/%.ko$(suffix-y), $(modules))
+install-y += $(modules)
 
 __modinst: $(modules)
 	@:
@@ -35,7 +43,7 @@ __modinst: $(modules)
 # Installation
 #
 quiet_cmd_install = INSTALL $@
-      cmd_install = mkdir -p $(dir $@); cp $< $@
+      cmd_install = cp $< $@
 
 # Strip
 #
@@ -95,6 +103,8 @@ depmod: $(modules)
 quiet_cmd_depmod = DEPMOD  $(MODLIB)
       cmd_depmod = $(srctree)/scripts/depmod.sh $(KERNELRELEASE)
 
+$(install-y): prepare
+
 else
 
 $(dst)/%.ko: FORCE
-- 
2.39.2

