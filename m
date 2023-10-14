Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4F7C9443
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjJNKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJNKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A69AD;
        Sat, 14 Oct 2023 03:54:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F994C433CD;
        Sat, 14 Oct 2023 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697280892;
        bh=OoujLaw6rocLtMAHQyTp6llYUxnsAujLu8prfeuatAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtecYPhaN4aqgCnBJW7qTsSPlBxit9sARXDoPhSf1Kk/GmGEQL1VeSFxnbFYXGR18
         u+p7kw1QNI0C9x3aIg2T/wSAIadl7XRd5hUY0wLRsExPzb0guUueXGu9RkQVaBhvRV
         zphn5f2Wt3FAYsybHa2AMZv/ooCqs+ueq6ulGcgEEPjUxXVBPK9HHTpxYvk6TQncWR
         +j34lmP2hzWulD6XT6fQSpG1bGA9yQR8qCHpoe/n2KA7XHY5nA52+jl/L4LOKE4CIK
         /xfhPoGdoZ1roeUF2VxKtsLaCHpbzU6AkM6N/KfVO/gqL0XnoThuJVRWM+k4R6By6U
         WdcHO6wmtsxKg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] kbuild: unify no-compiler-targets and no-sync-config-targets
Date:   Sat, 14 Oct 2023 19:54:36 +0900
Message-Id: <20231014105436.2119702-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231014105436.2119702-1-masahiroy@kernel.org>
References: <20231014105436.2119702-1-masahiroy@kernel.org>
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

Now that vdso_install does not depend on any in-tree build artifact,
it no longer needs a compiler, making no-compiler-targets the same
as no-sync-config-targets.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Revive need-compiler flag

 Makefile | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 1ae5d5180f20..fed9a6cc3665 100644
--- a/Makefile
+++ b/Makefile
@@ -277,10 +277,6 @@ no-dot-config-targets := $(clean-targets) \
 			 $(version_h) headers headers_% archheaders archscripts \
 			 %asm-generic kernelversion %src-pkg dt_binding_check \
 			 outputmakefile rustavailable rustfmt rustfmtcheck
-# Installation targets should not require compiler. Unfortunately, vdso_install
-# is an exception where build artifacts may be updated. This must be fixed.
-no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
-			headers_install modules_install modules_sign kernelrelease image_name
 no-sync-config-targets := $(no-dot-config-targets) %install modules_sign kernelrelease \
 			  image_name
 single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
@@ -288,7 +284,6 @@ single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %
 config-build	:=
 mixed-build	:=
 need-config	:= 1
-need-compiler	:= 1
 may-sync-config	:= 1
 single-build	:=
 
@@ -298,18 +293,14 @@ ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	endif
 endif
 
-ifneq ($(filter $(no-compiler-targets), $(MAKECMDGOALS)),)
-	ifeq ($(filter-out $(no-compiler-targets), $(MAKECMDGOALS)),)
-		need-compiler :=
-	endif
-endif
-
 ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
 		may-sync-config :=
 	endif
 endif
 
+need-compiler := $(may-sync-config)
+
 ifneq ($(KBUILD_EXTMOD),)
 	may-sync-config :=
 endif
-- 
2.39.2

