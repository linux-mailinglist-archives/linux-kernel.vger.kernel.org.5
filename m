Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52E75D9CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGVEtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjGVEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:49:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC229422D;
        Fri, 21 Jul 2023 21:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DF560A50;
        Sat, 22 Jul 2023 04:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40CAC4AF5C;
        Sat, 22 Jul 2023 04:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001313;
        bh=Yh5NDvGzKmVhPTG6BJRkKiMxxKF+DwrUyiZddGRbJl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=il5/ZfknhIxh0Cr99e+F8tGMNdjpII+DpE7e6jyAMpoJwIG3quo7TDBlPseGCTKSw
         89+eHUWaHfUNPrA1c4Roq+9S7x4dIsDfsUs0SH5i1bgC3Qy6p9D1DwKw66GcnwRyUO
         HAIqPk4XSKrPz0Pq7A8xm0WF9CH0pXGA1BUKv+N2hIK3lj43SsNBINiGOsaPPfUwR5
         R2V0n0o04JiZrDDi/hNpe10Fgr/+0cdlG1TuZU4wfSX1W+nM/sJpuejUt4DKR+sIpc
         pmralMy8/aeoitfO4ycbpNTYhpUrK7hAAjJSB4akeUy+KqTevuSJW59C67Fp7u1KDW
         LUxvJNSub9f/w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 13/19] kbuild: rpm-pkg: run modules_install for non-modular kernel
Date:   Sat, 22 Jul 2023 13:48:00 +0900
Message-Id: <20230722044806.3867434-13-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the same reason as commit 4243afdb9326 ("kbuild: builddeb: always
make modules_install, to install modules.builtin*"), run modules_install
even when CONFIG_MODULES=n to install modules.builtin*.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index a9425d993667..2613e85cd844 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -101,16 +101,13 @@ $S$M
 	%else
 	cp \$(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEASE}
 	%endif
-$M	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
+	%{make} %{makeflags} INSTALL_MOD_PATH=%{buildroot} modules_install
 	%{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
 	cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
 	cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
-$S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/build
-$S$M	rm -f %{buildroot}/lib/modules/%{KERNELRELEASE}/source
+	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
+	ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
 $S$M	%{make} %{makeflags} run-command KBUILD_RUN_COMMAND='\${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
-$S$M	cd %{buildroot}/lib/modules/%{KERNELRELEASE}
-$S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} build
-$S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} source
 
 	%clean
 	rm -rf %{buildroot}
@@ -138,9 +135,9 @@ $S$M	ln -sf /usr/src/kernels/%{KERNELRELEASE} source
 
 	%files
 	%defattr (-, root, root)
-$M	/lib/modules/%{KERNELRELEASE}
-$M	%exclude /lib/modules/%{KERNELRELEASE}/build
-$M	%exclude /lib/modules/%{KERNELRELEASE}/source
+	/lib/modules/%{KERNELRELEASE}
+	%exclude /lib/modules/%{KERNELRELEASE}/build
+	%exclude /lib/modules/%{KERNELRELEASE}/source
 	/boot/*
 
 	%files headers
-- 
2.39.2

