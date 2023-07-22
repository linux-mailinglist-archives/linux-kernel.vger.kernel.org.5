Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2F75D9C8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGVEtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGVEtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05E3C3E;
        Fri, 21 Jul 2023 21:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E744C60A4C;
        Sat, 22 Jul 2023 04:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45568C433CC;
        Sat, 22 Jul 2023 04:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001309;
        bh=GAV/eLhMDGBWsU4RkH60dgfKVcN7IvGPnaFM8V2OKes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lp6FOQo44sQPExuQZjESFj1zb62XPACYDO5tkQkWDaiHdCTv9LFS0Q9KtXa0ffkPj
         K9ek+TTO6Tg1il21/dLxohqckw9/8aSrqZuyrrPyIQU6DX7NNFTlC+a6KRe+AU5Ye2
         dN7PHYzAvJ4gldhG/Uc4t5x2NXmbL3hR2EOY2aVtjKv+ADOt/iEI3IK59F/Qcehfxl
         t8KbPuPRgL9WzkyKAce/SRAI5PSAWWOjWeKDFYNYfpaFmVB8ywDqXdnW25u2LVl/XJ
         1U2jeyYQ1lap77PVhtvRQ8Z5AtBKbrzQb+VE39IM6Yieh99JNDPHWeVxN8ceJCS/da
         e8HBT9m2E+noQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 10/19] kbuild: rpm-pkg: derive the Version from %{KERNELRELEASE}
Date:   Sat, 22 Jul 2023 13:47:57 +0900
Message-Id: <20230722044806.3867434-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
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

Avoid hard-coding the Version field in the generated spec file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 22e290d23d8a..783e1997d94a 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -27,8 +27,6 @@ else
 	M=DEL
 fi
 
-__KERNELRELEASE=$(echo $KERNELRELEASE | sed -e "s/-/_/g")
-
 # We can label the here-doc lines for conditional output to the spec file
 #
 # Labels:
@@ -43,7 +41,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 
 	Name: kernel
 	Summary: The Linux Kernel
-	Version: $__KERNELRELEASE
+	Version: %(echo %{KERNELRELEASE} | sed -e 's/-/_/g')
 	Release: $(cat .version 2>/dev/null || echo 1)
 	License: GPL
 	Group: System Environment/Kernel
-- 
2.39.2

