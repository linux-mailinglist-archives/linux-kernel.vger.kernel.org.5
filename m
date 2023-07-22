Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2A75D9B9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGVEs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGVEsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E13ABA;
        Fri, 21 Jul 2023 21:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFBE260A51;
        Sat, 22 Jul 2023 04:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47478C433C9;
        Sat, 22 Jul 2023 04:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001297;
        bh=CDil0JK2xmUHuM70QKfOZW0pk8H2R7ZRW4rGvSI1TTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXeCIRVombrbgT0Y07kWVLU/V7YkpYnP+NN4JBZxBqvg3m5d8u9RbLLqio+iloFxi
         y3PWAG0rfHznRAhmFL0p3CmBzfR+/DmhSwinrswO6BPHoEEn2YUBVjjETXDFMbQI22
         BaSbJJUfo8sb01+RTgiDi6ChZwr9T/hdDtawJVT9LfPZq3Z1sgJSY9DmdMttIZN+IN
         41Bq7qDEt/TWjsrvlqzUMzaPTw+rSDSnZdNEvnjJpKyKGCWdd89hXY0dinks1s5yq/
         YFJjiN5UgtJxGfrUekikG6KeGnDcb5Vk2pbyniToR6UminDnKCRevw27kAq1pM2XtG
         +DRmtLaN9rcrQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 02/19] kbuild: rpm-pkg: remove unneeded '-f $srctree/Makefile' in spec file
Date:   Sat, 22 Jul 2023 13:47:49 +0900
Message-Id: <20230722044806.3867434-2-masahiroy@kernel.org>
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

This is unneeded because the Makefile in the output directory wraps
the top-level Makefile in the srctree.

Just run $MAKE irrespective of the build location.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index c9299f9c1f3e..a83b17b4a0d9 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -12,7 +12,6 @@
 # how we were called determines which rpms we build and how we build them
 if [ "$1" = prebuilt ]; then
 	S=DEL
-	MAKE="$MAKE -f $srctree/Makefile"
 else
 	S=
 
-- 
2.39.2

