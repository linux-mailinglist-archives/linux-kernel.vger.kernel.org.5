Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0975D9B6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGVEsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVEsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF03583;
        Fri, 21 Jul 2023 21:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7354560A50;
        Sat, 22 Jul 2023 04:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBB8C433C8;
        Sat, 22 Jul 2023 04:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001295;
        bh=to0i+TXIMK7bCy8RaewkN9+QjUncbqhaUH3zl5VbVio=;
        h=From:To:Cc:Subject:Date:From;
        b=E0Dmzn2ghuAuyAi1IgYuH4ejF8Z0Xj2/p4wYLJKDRrThlNiyRjhaLkw1zH4NOxMcB
         3QKmJChruhyHnBrqZCO1SF8Ej7yAzL4vlrwhFkshLNhoQCxR49xiLWSTazLK9zSEcC
         LfVwjc/E/dMkbfT9X0US4ypv9fJeLuV3Uol3/tlaPZmpz7Efo96+eux4ivkktrgsoa
         SNFXGGmluQ6RE1Hi5QhGJeznxBa5hTIn+ay/fetmaOGeut5VzkJ7ZrcQnIG4nXQ41n
         mYIoyZvpAtKjL1DRQpjwfSk4h/HfFF0u/uwMXQhJE+gzsC/30R5fDaaifCEOTcbOv/
         +CUc7nKq3Rqgg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 01/19] kbuild: rpm-pkg: define _arch conditionally
Date:   Sat, 22 Jul 2023 13:47:48 +0900
Message-Id: <20230722044806.3867434-1-masahiroy@kernel.org>
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

Commit 3089b2be0cce ("kbuild: rpm-pkg: fix build error when _arch is
undefined") does not work as intended; _arch is always defined as
$UTS_MACHINE.

The intention was to define _arch to $UTS_MACHINE only when it is not
defined.

Fixes: 3089b2be0cce ("kbuild: rpm-pkg: fix build error when _arch is undefined")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 8049f0e2c110..c9299f9c1f3e 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -57,7 +57,7 @@ $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
 
 	# $UTS_MACHINE as a fallback of _arch in case
 	# /usr/lib/rpm/platform/*/macros was not included.
-	%define _arch %{?_arch:$UTS_MACHINE}
+	%{!?_arch: %define _arch $UTS_MACHINE}
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
 
-- 
2.39.2

