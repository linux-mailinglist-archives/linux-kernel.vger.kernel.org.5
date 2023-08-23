Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B3178578E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjHWMJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjHWMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A7FE6A;
        Wed, 23 Aug 2023 05:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0F96257B;
        Wed, 23 Aug 2023 12:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF7C433C7;
        Wed, 23 Aug 2023 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692792502;
        bh=wIaUNDpaxl1iFWGICefIVbACDsnatb+1rW5UeCfqnZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=kJsWMVxrq7Zb5gTMblVZAO5q27JGb9s+/jHSvNC16UjcbmRO6HKzA+47buiAe35Ym
         ZPHTNawLm6l/WZrkJb9J1oR5z0Ym4YFAFvjSHfwU4LFjyl1tfnI2OJDyX70NKCsbiO
         dBhUNSOX04IWtdJk858bEM5Ez5gbMX255+f9D9jLoUg3W5NSbcZrz1GTK+o2Xi2wL2
         DvUkIcBNs1kDHnGIHlQIL/k0L9vQi7aoDWmxIgjImbk4Te3l3Hv9ht6BdS1P7bs9B5
         XwmA8ejfghgW7wY7V3tRcbtIDPnRJVThrMUQLxEEDPN7UZdXdbwneIHgd6uGc+pq2I
         iglt1KiBved+A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: get lib-y objects back to static library
Date:   Wed, 23 Aug 2023 21:08:16 +0900
Message-Id: <20230823120816.824352-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the following two commits:

 - 7273ad2b08f8 ("kbuild: link lib-y objects to vmlinux forcibly when CONFIG_MODULES=y")
 - 7f2084fa55e6 ("[kbuild] handle exports in lib-y objects reliably")

Now, lib-y is back to static library again, and the link order is
consistent w/wo CONFIG_MODULES.

Since commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by
modpost"), .vmlinux.export.c contains references to exported symbols.
If a symbol in a lib-y object is exported, that object is always linked
even without any explicit user in vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Makefile b/Makefile
index 87a9eef3fb4b..71e9c65d9eae 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,12 +1113,7 @@ export ARCH_DRIVERS	:= $(drivers-y) $(drivers-m)
 # Externally visible symbols (used by link-vmlinux.sh)
 
 KBUILD_VMLINUX_OBJS := ./built-in.a
-ifdef CONFIG_MODULES
-KBUILD_VMLINUX_OBJS += $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
-KBUILD_VMLINUX_LIBS := $(filter-out %/, $(libs-y))
-else
 KBUILD_VMLINUX_LIBS := $(patsubst %/,%/lib.a, $(libs-y))
-endif
 
 export KBUILD_VMLINUX_LIBS
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
-- 
2.39.2

