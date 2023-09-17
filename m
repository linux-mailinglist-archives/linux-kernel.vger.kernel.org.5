Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D22F7A3775
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjIQTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjIQTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:20:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A8115;
        Sun, 17 Sep 2023 12:20:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66821C433C9;
        Sun, 17 Sep 2023 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694978416;
        bh=zlezv61pkEtIb39QJV+KksqxpQMU0fbcIUj51bSEwrY=;
        h=From:To:Cc:Subject:Date:From;
        b=oIzJcm+yqSjU0N+/nDHU6W2dBiG4y1dTlpVyxYVZl0TvEkebI5Rsm40kS+rbblFIW
         J9xYHqsfQSEGE/hrzWSnkCdsJc14eqkd2Z6cYnhuD2DqR3KVwaVBv1ceygvjxD7mp0
         uSsZ9ztBuXxelRCElu1PTfkmN1VXpCVK1alE09zCaD6Ea3nwiJToHlkkSga0AmfxZF
         kJgY8RZB3FIxnaemnt6Qai0L4mOWctRk2BrqAUoNF6zQgCQJGZ894J/ExJ4LauKIxE
         23CBrwm9tnAbGXXh1B2eSPvGstmkbum93JCxt3rbGQriU32RhBdOPt18egKTEpabXP
         kIIlN/4gJDHQQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] Documentation: kbuild: explain handling optional dependencies
Date:   Sun, 17 Sep 2023 21:19:59 +0200
Message-Id: <20230917192009.254979-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

This problem frequently comes up in randconfig testing, with
drivers failing to link because of a dependency on an optional
feature.

The Kconfig language for this is very confusing, so try to
document it in "Kconfig hints" section.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix typos pointed out by Nicolas Schier
---
 Documentation/kbuild/kconfig-language.rst | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 858ed5d80defe..0135905c0aa35 100644
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
+uses the slightly counterintuitive::
+
+  config FOO
+	tristate "Support for foo hardware"
+	depends on BAR || !BAR
+
+This means that there is either a dependency on BAR that disallows
+the combination of FOO=y with BAR=m, or BAR is completely disabled.
+For a more formalized approach if there are multiple drivers that have
+the same dependency, a helper symbol can be used, like::
+
+  config FOO
+	tristate "Support for foo hardware"
+	depends on BAR_OPTIONAL
+
+  config BAR_OPTIONAL
+	def_tristate BAR || !BAR
+
 Kconfig recursive dependency limitations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.2

