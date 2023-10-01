Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF867B47CA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbjJAODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjJAODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:03:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E29F;
        Sun,  1 Oct 2023 07:03:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E2FC433C7;
        Sun,  1 Oct 2023 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696169025;
        bh=3LIpQH6MN3tTgISuUJS+MrG+dyX1WcYUgjAL90yBmcw=;
        h=From:To:Cc:Subject:Date:From;
        b=diyT5n3Erw4CBxvvAhE+uw79QY8yXl0wxr2XxAzsWWWiMipbv6ppyuz5whMdCsAzZ
         P4Nq21lPh8xZiSKO6NxWsc4gugxca7mbR0ZZINH1tOYgfRyWIHTYTtSjHshhDVn+38
         8ooR2zg12DbTUWM1+B0jyDxB1inkTxlJsV+1uybnHNOKtIRDn2nhrSLJjwhJ7T51a/
         vC+QpSxSj3PEXq/JcT13CtDF2ylIoQZ/z4LorY5tw+ohaUgDac48L6WhDDA3gMlXGk
         ltnt3GNKP0aZRONOw6c7fDJaybnwWVOzcogt7DAk5o6Flko8fYBqLObBc6fTXNecRt
         Z0GkUNbHqQGUA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: remove stale code for 'source' symlink in packaging scripts
Date:   Sun,  1 Oct 2023 23:03:39 +0900
Message-Id: <20231001140339.1707548-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d8131c2965d5 ("kbuild: remove $(MODLIB)/source symlink"),
modules_install does not create the 'source' symlink.

Remove the stale code from builddeb and kernel.spec.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/builddeb    | 1 -
 scripts/package/kernel.spec | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index bf3f8561aa68..d7dd0d04c70c 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -64,7 +64,6 @@ install_linux_image () {
 
 	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
 	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
-	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
 
 	# Install the kernel
 	if [ "${ARCH}" = um ] ; then
diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index ac3f2ee6d7a0..3eee0143e0c5 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -68,7 +68,6 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
 cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
 cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
 ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
-ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
 %if %{with_devel}
 %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
 %endif
@@ -101,7 +100,6 @@ fi
 %defattr (-, root, root)
 /lib/modules/%{KERNELRELEASE}
 %exclude /lib/modules/%{KERNELRELEASE}/build
-%exclude /lib/modules/%{KERNELRELEASE}/source
 /boot/*
 
 %files headers
@@ -113,5 +111,4 @@ fi
 %defattr (-, root, root)
 /usr/src/kernels/%{KERNELRELEASE}
 /lib/modules/%{KERNELRELEASE}/build
-/lib/modules/%{KERNELRELEASE}/source
 %endif
-- 
2.39.2

