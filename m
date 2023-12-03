Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728298021A3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 09:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjLCIFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 03:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 03:05:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4C125
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 00:05:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42534C433C8;
        Sun,  3 Dec 2023 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701590753;
        bh=M2GMrw4loolCdNbmGSsgw9g7ot6QbobVN3Xw7lbG/rU=;
        h=From:To:Cc:Subject:Date:From;
        b=TNblV9JxiWK9vM5Uzfx7EhgT61zuRC+CsWQPb9fqZXVyeswt9NNqjbxL1jqTLMvag
         QbAyup2l15WPZEy4o7QJoG6reqzPQ6DWyIUrv4GpbUFZW15twpTbasZZ9MrR6mPenP
         RvcK4lyNnhV4GD+StEWvqbHz9Zfe0o6Ah91LvT883+/NCOBXlVEZwwhP8JVYs1mGmc
         CwyE93JcXybDN+mQN3obYGyf+1QH9EemO701U2LNCYTfJqQeMGSZuvTLLEjfr/pPEy
         MtCuJFxjX4BOUtxe5lp1+WtYdn7hV3WcYVG0sDiqXCcYjxSPdHwAiUpL/StN4rxOEs
         8AwNWFbYaN9vw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: determine base DTB by suffix
Date:   Sun,  3 Dec 2023 17:05:48 +0900
Message-Id: <20231203080548.1869540-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the -dtbs syntax, you need to ensure to list the base first,
as follows:

    foo-dtbs := foo_base.dtb foo_overlay1.dtbo foo_overlay2.dtbo
    dtb-y := foo.dtb

You cannot do this arrangement:

    foo-dtbs := foo_overlay1.dtbo foo_overlay2.dtbo foo_base.dtb

This restriction comes from $(firstword ...), but it is unneeded to
rely on the order in the -dtbs syntax.

Instead, you can simply determine the base by suffix because the
base (*.dtb) and overlays (*.dtbo) use different suffixes.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e01..cd5b181060f1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -83,8 +83,8 @@ dtb-$(CONFIG_OF_ALL_DTBS)       += $(dtb-)
 multi-dtb-y := $(call multi-search, $(dtb-y), .dtb, -dtbs)
 # Primitive DTB compiled from *.dts
 real-dtb-y := $(call real-search, $(dtb-y), .dtb, -dtbs)
-# Base DTB that overlay is applied onto (each first word of $(*-dtbs) expansion)
-base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m, .dtb, -dtbs)))
+# Base DTB that overlay is applied onto
+base-dtb-y := $(filter %.dtb, $(call real-search, $(multi-dtb-y), .dtb, -dtbs))
 
 always-y			+= $(dtb-y)
 
-- 
2.40.1

