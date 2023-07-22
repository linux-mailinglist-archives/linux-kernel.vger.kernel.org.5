Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5227375D9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjGVEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGVEuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717F49D6;
        Fri, 21 Jul 2023 21:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BCD560A66;
        Sat, 22 Jul 2023 04:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC55BC433CA;
        Sat, 22 Jul 2023 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001322;
        bh=gIGxS34xwv5NpXZcfC9AaBQEdsBf6s43cS3YwnJ+Ftc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RS9DH271H+aEdQwyuVGvK4kBz0UmFUzuLF0i0tyWYK8sNzUm/C2aB5xhjLgBRPEYw
         GlRZeb+ElAZz3MmOebTdETVntOdVEY8WqhV+wlwZFsNQzP/rotqnFb3dSv/cw/3nto
         qPw9yrQ/+1puX6wKNRuBI5YQXrDBuDNJmiUWZu7LjzahUVog8shGKbGgnZ3sWo+307
         A9wkSWHjiGr/vUCVxPEMI1FiIoNVIJhAnxnDJnhIDb+gRxkrzKYrAUJ+359uYRB7hI
         pDu1PnRfolaa6HkMt595NRYyx3R86FpL+O/6klXOLKEL5FZao2xDBAuOgtP+mHlrL4
         6SoVYLTU8aYkg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 19/19] kbuild: rpm-pkg: skip build dependency check on non-rpm systems
Date:   Sat, 22 Jul 2023 13:48:06 +0900
Message-Id: <20230722044806.3867434-19-masahiroy@kernel.org>
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

Commit 8818039f959b ("kbuild: add ability to make source rpm buildable
using koji") added the BuildRequires: field.

Checking the build dependency is fine, but one annoyance is that
'make (bin)rpm-pkg' fails on non-rpm systems [1]. For example, Debian
provides rpmbuild via 'apt install rpm', but of course cannot meet the
requirement listed in the BuildRequires: field.

It is possible to pass RPMOPTS=--nodeps to work around it, but it is
reasonable to do it automatically.

If 'rpm -q rpm' fails, it is not an RPM-managed system. (The command
'rpm' is not installed at all, or was installed by other means.)

In that case, pass --nodeps to skip the build dependency check.

[1]: https://lore.kernel.org/linux-kbuild/Y6mkdYQYmjUz7bqV@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 0ace3973a0d1..85beab0363d7 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -92,7 +92,8 @@ rpm-pkg srcrpm-pkg binrpm-pkg: kernel.spec
 	+$(strip rpmbuild -b$(build-type) kernel.spec \
 	--define='_topdir $(abspath rpmbuild)' \
 	$(if $(filter a b, $(build-type)), \
-		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}') \
+		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}' \
+		$$(rpm -q rpm >/dev/null 2>&1 || echo --nodeps)) \
 	$(if $(filter b, $(build-type)), \
 		--without devel) \
 	$(RPMOPTS))
-- 
2.39.2

