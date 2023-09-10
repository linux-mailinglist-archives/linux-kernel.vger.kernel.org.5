Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668F799E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbjIJMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjIJMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 08:44:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712D1BD;
        Sun, 10 Sep 2023 05:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC84C433C7;
        Sun, 10 Sep 2023 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694349864;
        bh=Owm/hEkZAiMJwPacb9sjFXsQR/7UIHp3uW3zm40nou8=;
        h=From:To:Cc:Subject:Date:From;
        b=FJxjcCIgy/Lgpye7RdAcS3MhvRKPdZxUKt4F7OMM6qpn2yVtfbfzFSZR2QBzU6rj3
         eGUrnaeBsOUxLW2xPsHi5Z0W5jZx89c8AFcqqsWXYRcKQ0dASegEcuriBqbceLdx/1
         cHGSLqBPPWDxOSMsn7EMgAjjo3CwcEFrCbYEzIXvnRgB0G6wsBXCROkun3G/S4BxK2
         5eTuKfBUe/xDrZ5q/xEOKp/kXY06jORK6YeDQ/Cmz7F5JdCulmPtDg7rOwd/IRaxJs
         OpIXzSFTQd/mTD/UD7S04NNE3BEG7swDVEULOjXa/DD8TU6ZiifD5rzC8VN+QzvyGx
         /N2KlNV3mSFXg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Karolis M <k4rolis@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: fix kernel-devel RPM package and linux-headers Deb package
Date:   Sun, 10 Sep 2023 21:44:13 +0900
Message-Id: <20230910124413.1479521-1-masahiroy@kernel.org>
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

Since commit fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package
and linux-headers Deb package"), the kernel-devel RPM package and
linux-headers Deb package are broken.

I double-quoted the $(find ... -type d), which resulted in newlines
being included in the argument to the outer find comment.

  find: 'arch/arm64/include\narch/arm64/kvm/hyp/include': No such file or directory

The outer find command is unneeded.

Fixes: fe66b5d2ae72 ("kbuild: refactor kernel-devel RPM package and linux-headers Deb package")
Reported-by: Karolis M <k4rolis@protonmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/install-extmod-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/install-extmod-build b/scripts/package/install-extmod-build
index af7fe9f5b1e4..8a7051fad087 100755
--- a/scripts/package/install-extmod-build
+++ b/scripts/package/install-extmod-build
@@ -20,7 +20,7 @@ mkdir -p "${destdir}"
 	find "arch/${SRCARCH}" -maxdepth 1 -name 'Makefile*'
 	find include scripts -type f -o -type l
 	find "arch/${SRCARCH}" -name Kbuild.platforms -o -name Platform
-	find "$(find "arch/${SRCARCH}" -name include -o -name scripts -type d)" -type f
+	find "arch/${SRCARCH}" -name include -o -name scripts -type d
 ) | tar -c -f - -C "${srctree}" -T - | tar -xf - -C "${destdir}"
 
 {
-- 
2.39.2

