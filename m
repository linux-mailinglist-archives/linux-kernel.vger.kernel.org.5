Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A953577A82E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHMPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjHMPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C971719;
        Sun, 13 Aug 2023 08:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEA063283;
        Sun, 13 Aug 2023 15:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CA9C433C9;
        Sun, 13 Aug 2023 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941979;
        bh=wipUm36EeLOhsTYkjnhUDKD8iAG8BWULxaga3ruaIlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+8Z8E/D7OruKMbN2nbh2306aZzGCluFm8vMUEkTdAT6iAugXp6g6LqWvF3lRHMIi
         1MafmUMtge8UUiPEG6G/dw+EKAqo1rqX4kK6Ksn5u7CVSHlLt7AEJnoCnIIGCukkvr
         f2d9BfbFL+hzGFb71Hb0URUjbD/1cWmGE2ldoUhDCGBLiJSAodSvMR5yloKWNuh09n
         tailTglVIQu855KMWl4/By41ctZ6Xz3y8LDgv4F6AqOpa3o5XKpoNOiO4EvrjoHApV
         gbymAHcJ3OqCam2MO3PKEIU95ZsIwrcO1ehNCkxB6q4G4glvjeQ+P+mXzYdsNuEAHH
         JOeOwEaHdkyOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.4 51/54] LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'
Date:   Sun, 13 Aug 2023 11:49:30 -0400
Message-Id: <20230813154934.1067569-51-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 54c2c9df083fe1d4a9df54d9876f32582ce6d77a ]

This is a port of commit 4fe4a6374c4db9ae2b ("MIPS: Only fiddle with
CHECKFLAGS if `need-compiler'") to LoongArch.

We have originally guarded fiddling with CHECKFLAGS in our arch Makefile
by checking for the CONFIG_LOONGARCH variable, not set for targets such
as `distclean', etc. that neither include `.config' nor use the compiler.

Starting from commit 805b2e1d427aab4 ("kbuild: include Makefile.compiler
only when compiler is needed") we have had a generic `need-compiler'
variable explicitly telling us if the compiler will be used and thus its
capabilities need to be checked and expressed in the form of compilation
flags.  If this variable is not set, then `make' functions such as
`cc-option' are undefined, causing all kinds of weirdness to happen if
we expect specific results to be returned.

It doesn't cause problems on LoongArch now. But as a guard we replace
the check for CONFIG_LOONGARCH with one for `need-compiler' instead, so
as to prevent the compiler from being ever called for CHECKFLAGS when
not needed.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 63a637fdf6c28..95629322241f5 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -106,7 +106,7 @@ KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
 
 KBUILD_LDFLAGS	+= -m $(ld-emul)
 
-ifdef CONFIG_LOONGARCH
+ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
-- 
2.40.1

