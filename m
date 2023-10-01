Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372157B4776
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjJAMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJAMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:38:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70C94;
        Sun,  1 Oct 2023 05:38:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17380C433C7;
        Sun,  1 Oct 2023 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696163910;
        bh=KEq0sb1sATCnOmr6JZBWJrk3Ia06CKo6O9cePk2xNA0=;
        h=From:To:Cc:Subject:Date:From;
        b=fpPkvQIzkuzvHKi+AOjEeMXdXpMfDC0HgQdMe1hoXfco2RpUEnMf+W5uJFjTxGQlQ
         +aufWVlwkDD0KcCEaX2WtRRDkvK+dTa0fNob1KSzxPZIrP8WM+47xVcrUh3vnFMGej
         hprruBaBT+wAdHU+e8/sTZoQaYbXQ9+5oWDHF6R+HlgTO1K2ofYlGl9Gk0vYgxlJhc
         HBdBwn2QvZM2ym6GVNHE0HOlXU1plMPUZmMI6lpQNwwVH/1WVDgC5yY8zZiFfv1zZN
         mGnRvxM+Ef3OwF4yUN7eAB+SzmbgDzMhZfMIJ67LccNThKW4AO7pVZ5r77IR0AJ1+A
         0WU9RB1mhTI8w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: make binrpm-pkg always produce kernel-devel package
Date:   Sun,  1 Oct 2023 21:38:22 +0900
Message-Id: <20231001123822.1659773-1-masahiroy@kernel.org>
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

The generation of the kernel-devel package is disabled for binrpm-pkg
presumably because it was quite big (>= 200MB) and took a long time to
package.

Commit fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package and
linux-headers Deb package") reduced the package size to 12MB, and now
it is quick to build. It won't hurt to have binrpm-pkg generate it by
default.

If you want to skip the kernel-devel package generation, you can pass
RPMOPTS='--without devel':

  $ make binrpm-pkg RPMOPTS='--without devel'

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 05b8c3e29aac..3addd1c0b989 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -94,8 +94,6 @@ rpm-pkg srcrpm-pkg binrpm-pkg: rpmbuild/SPECS/kernel.spec
 	$(if $(filter a b, $(build-type)), \
 		--target $(UTS_MACHINE)-linux --build-in-place --noprep --define='_smp_mflags %{nil}' \
 		$$(rpm -q rpm >/dev/null 2>&1 || echo --nodeps)) \
-	$(if $(filter b, $(build-type)), \
-		--without devel) \
 	$(RPMOPTS))
 
 # deb-pkg srcdeb-pkg bindeb-pkg
-- 
2.39.2

