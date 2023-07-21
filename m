Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D075D086
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjGURTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjGURTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:19:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989F113;
        Fri, 21 Jul 2023 10:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9086461D2F;
        Fri, 21 Jul 2023 17:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9483CC433C9;
        Fri, 21 Jul 2023 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689959952;
        bh=ZR06M3d0gZKRb4qFO1k4EYXqLJ5GJPGsvI0z3w1cJFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvNmnzl1Nwu+J/6xOdGaUdPqmOhwTHqfFaC3Xk7KzAE4rMXToL7/R3DzDEgIEkiyo
         dortXv3BM//zgrIWSD06NieLEU6/Y6fYZ7qT1yqPpIqEgPeqF4NsGop3fc+INGGQCs
         Y4gp+mQLcdjuI+ap/hA+6Is0i7ARKR2QuICuuoTZ0JuJTbqdwbkoXS94rGeihsiblC
         b3nnNopcsvLnmco09z4Lw0nobnNtlC4yXVxtwv1ngJtdx4EDkgU0EP55zt/l/BrRiK
         GzdA82oPy0L/zobquahYfr/Cn6YtJsm0JV+glig0tVHHxC3BSRNj5HcR9Dt2dmyDUY
         RyMakPBm5ZESw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 2/2] UML: use obj-y to descend into arch/um/*/
Date:   Sat, 22 Jul 2023 02:18:57 +0900
Message-Id: <20230721171857.3612639-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721171857.3612639-1-masahiroy@kernel.org>
References: <20230721171857.3612639-1-masahiroy@kernel.org>
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

The single build rule does not work with the core-y syntax. [1]

Use the standard obj-y syntax.

[1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Rephase the commit log

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

