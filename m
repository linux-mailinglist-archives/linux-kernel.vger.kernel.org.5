Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF079E6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjIMLiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbjIMLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:38:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4200173E;
        Wed, 13 Sep 2023 04:38:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F97FC433C7;
        Wed, 13 Sep 2023 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694605089;
        bh=NjwWLoIbmcBjw9qBYI11QfNE6lfJieDTK6MDYKZZGNE=;
        h=From:To:Cc:Subject:Date:From;
        b=gZFTatLF1uEsqurqOmmsA3CNkNaxJ0Zw84AnKKp0Lrc864Z/PUFoh0Ngvx5V4G0b4
         V2BLSg7cbESyA9rSQmqum8mFtbLKnIv/F+l4pICNh8DEmr2RjeAcCO1QyRjhKmOF8+
         wb5RBUhl6bqGOBLyihYqygeQLm1JYJ5DnNqlmH0th6wKpU5WIxiE4TLvW+4yBA56z1
         xTU1GKqAbPMKyBtO+vNh5hmQA4Quqbw69FEjrhkJj/uswOEKCnLqMyF+3Ml8zW1vh7
         fJBjlqnca0EpQ1pRZsG77TESna82DFx9gCdOBc+MFHTct2AQy4h+3IrceCKtLge7wx
         /wB+YDct+56Jg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: kbuild: explain handling optional dependencies
Date:   Wed, 13 Sep 2023 13:37:52 +0200
Message-Id: <20230913113801.1901152-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This problem frequently comes up in randconfig testing, with
drivers failing to link because of a dependency on an optional
feature.

The Kconfig language for this is very confusing, so try to
document it in "Kconfig hints" section.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 858ed5d80defe..89dea587a469a 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -573,6 +573,32 @@ above, leading to:
 	bool "Support for foo hardware"
 	depends on ARCH_FOO_VENDOR || COMPILE_TEST
 
+Optional dependencies
+~~~~~~~~~~~~~~~~~~~~~
+
+Some drivers are able to optionally use a feature from another module
+or build cleanly with that module disabled, but cause a link failure
+when trying to use that loadable module from a built-in driver.
+
+The most common way to express this optional dependency in Kconfig logic
+uses the slighly counterintuitive
+
+  config FOO
+	bool "Support for foo hardware"
+	depends on BAR || !BAR
+
+This means that there is either a dependency on BAR that disallows
+the combination of FOO=y with BAR=m, or BAR is completely disabled.
+For a more formalized approach if there are multiple drivers that have
+the same dependency, a helper symbol can be used, like
+
+  config FOO
+	bool "Support for foo hardware"
+	depends on BAR_OPTIONAL
+
+  config BAR_OPTIONAL
+	def_tristate BAR || !BAR
+
 Kconfig recursive dependency limitations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.2

