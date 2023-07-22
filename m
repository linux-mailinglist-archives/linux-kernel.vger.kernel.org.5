Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137F75D9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGVEsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjGVEsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5333ABD;
        Fri, 21 Jul 2023 21:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBB460A51;
        Sat, 22 Jul 2023 04:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30ECC433CC;
        Sat, 22 Jul 2023 04:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001301;
        bh=t8YlK1uWf9LCj4heDmlRtPcElfIsnxIYNXcfywQoPUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxEWXM0e+9QgvIdfQvgcDoqV9m3IEmvla0iVylQM5PT1J2ODdzugzDYm3EG4sEuED
         lST9iTrfjYxA5Zkfrzcoqfv0RdhhLwaXXCrpKa7udV9SvkZ/tGy2CqDgz3IGJeuOhT
         LevupHhDm6OaLeNnB3dAvhQ+NSAclWISXZA9+iV4QQ6DJixQkFUuaUqS0w5gk3wdoP
         anML9gFduWlZeRoEh9ebtThfiuAvSAbMOalX/5nTVtjnfFL6AzjYrs2DzojLy2DBZd
         WO2ukqtqQmCDF6V20TTb4neErFh/QbBjCIGNtKCvGf9SCN5/nVsyaLVC76bJshobn1
         MW5yM9pwoZP3Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 05/19] kbuild: rpm-pkg: record ARCH option in spec file
Date:   Sat, 22 Jul 2023 13:47:52 +0900
Message-Id: <20230722044806.3867434-5-masahiroy@kernel.org>
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

Currently, we rely on the top Makefile defining ARCH option when we
run 'make rpm-pkg' or 'make binrpm-pkg'.

It does not apply when we run 'make srcrpm-pkg', and separately run
'rpmbuild' for the generated SRPM. This is a problem for cross-build.

Just like the Debian package, save the value of ARCH in the spec file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index a1ce6677880a..0befb4e2ac6b 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -38,8 +38,10 @@ EXCLUDES="$RCS_TAR_IGNORE --exclude=*vmlinux* --exclude=*.mod \
 #  $S: this line is enabled only when building source package
 #  $M: this line is enabled only when CONFIG_MODULES is enabled
 sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
+%define ARCH ${ARCH}
+
 %{!?make: %define make make}
-%define makeflags %{?_smp_mflags}
+%define makeflags %{?_smp_mflags} ARCH=%{ARCH}
 
 	Name: kernel
 	Summary: The Linux Kernel
-- 
2.39.2

