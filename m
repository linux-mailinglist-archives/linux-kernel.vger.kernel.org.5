Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F975C81C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGUNqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGUNqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD70D1731;
        Fri, 21 Jul 2023 06:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C5661B30;
        Fri, 21 Jul 2023 13:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664BAC433CC;
        Fri, 21 Jul 2023 13:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689947160;
        bh=7/8un7O0KbffM2Qk+6DZGKZkr/Uh/KXBMa5+rJ58feo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ry7vFJvp9lNVxfPbd1yKD9O3pf/xY0X8oj/sjYZZxkZOGwXmmCsHFnCs2sh9wZ75W
         al6oCVkkwa41ZHvej0bfpAPg8v9tHWPGQS8k/qaGlIv/RIZu/3HbRNcF1orKpgrH3z
         O51xW4dpN38f4BWnSRX+njUmECTN2RHeKwX26op1OWPfq38aLZVag4JwnI4w/zhwGZ
         WnLJiYcs9F2UW69HNMM4+/VKenS2ysU3bNSsASrWYcZZMXAPmD6oGIGaVjOrld9ASH
         lv9i2JWgWqSmMAhxk3k50WYI93Q4xQWaLkMEq7TOh4BXrUOEMHzrNTg4DRayDrUW5Y
         sGSS3QEu8D9TQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] UML: use obj-y to descend into arch/um/*/
Date:   Fri, 21 Jul 2023 22:45:48 +0900
Message-Id: <20230721134548.3438376-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721134548.3438376-1-masahiroy@kernel.org>
References: <20230721134548.3438376-1-masahiroy@kernel.org>
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

I like to use obj-y in as many places as possible.

Change the core-y to obj-y. It fixes the single build issue. [1]

[1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/um/Kbuild   | 2 ++
 arch/um/Makefile | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/Kbuild b/arch/um/Kbuild
index a4e40e534e6a..6cf0c1e5927b 100644
--- a/arch/um/Kbuild
+++ b/arch/um/Kbuild
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += kernel/ drivers/ os-Linux/
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1735a562453d..82f05f250634 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -22,10 +22,6 @@ ARCH_DIR := arch/um
 # features.
 SHELL := /bin/bash
 
-core-y			+= $(ARCH_DIR)/kernel/		\
-			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/os-Linux/
-
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
 
 HEADER_ARCH 	:= $(SUBARCH)
-- 
2.39.2

