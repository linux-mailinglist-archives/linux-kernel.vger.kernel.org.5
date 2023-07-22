Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2898375D9C9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjGVEt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGVEtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BB5420B;
        Fri, 21 Jul 2023 21:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65A7B60A4E;
        Sat, 22 Jul 2023 04:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1DCC433CA;
        Sat, 22 Jul 2023 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001310;
        bh=fBL9JE5iepvra98mZ0IoB0g7RFTsWLA/SDkRPTHrAaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcYnw9kXlTlBpvjRum6fzEUZ8kOXy+Q5Eb6/zToLfcb+HO2UVJQBpdYNLPGDI8XLT
         IScI6lQR/jkzEyHiRUDZ/g5XJsEruKQxZP5vlopbm6PEmB1uOf4dT/V+qSVqXhKt1R
         XC1+C3X5HpqtS4bhzNx0t1xsGWVC5auC5/7i8rEKDre+e3yJ7K2YDcdzYY3uFlenY7
         VGguZPUx0v4EmY3W3Orto4VQim8tnh9Ej9u3NTy5rS6fs7mWjUY2a1U6M8JbYjXBPD
         D+flhjKFBMIumd/Yv2J0n18AdobDDUk3Xt7xs9l05Oo8OyG7PfJeUUjU/5g0Ye3Tmw
         dj70gXNaRilLA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 11/19] kbuild: rpm-pkg: use a dummy string for _arch when undefined
Date:   Sat, 22 Jul 2023 13:47:58 +0900
Message-Id: <20230722044806.3867434-11-masahiroy@kernel.org>
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

If this affects only %{buildroot}, it should be enough to use a fixed
string for _arch when it is undefined.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 783e1997d94a..22b980cf3d00 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -36,6 +36,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 %define ARCH ${ARCH}
 %define KERNELRELEASE ${KERNELRELEASE}
 
+# _arch is undefined if /usr/lib/rpm/platform/*/macros was not included.
+%{!?_arch: %define _arch dummy}
 %{!?make: %define make make}
 %define makeflags %{?_smp_mflags} ARCH=%{ARCH}
 
@@ -55,9 +57,6 @@ $S	BuildRequires: bc binutils bison dwarves
 $S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
 $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
 
-	# $UTS_MACHINE as a fallback of _arch in case
-	# /usr/lib/rpm/platform/*/macros was not included.
-	%{!?_arch: %define _arch $UTS_MACHINE}
 	%define __spec_install_post /usr/lib/rpm/brp-compress || :
 	%define debug_package %{nil}
 
-- 
2.39.2

