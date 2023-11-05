Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B07E16F3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKEV4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEV4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:56:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E0CC;
        Sun,  5 Nov 2023 13:56:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32fc2720c47so412251f8f.0;
        Sun, 05 Nov 2023 13:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699221399; x=1699826199; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oZyK94BwxnPjiynzKWPcRjofBhXc5/t3fdP2O17Q1BE=;
        b=WF3TB0nhvNBIxleGAK82wJPzwEBEL1cvkWzJEO6dWkQeSGAxWuWBmeFOV9Bkl3sR9t
         K8mFdHPTR2vVSZKoxSX/4Jq7ZwledBaTVTWyCSTLJJE78O7HLTw14nzu0UuyPTc7wtLc
         05Et2MT5uFoDaQW7aEIIdUolUBVmGB9xE869iUax8rus4fHxNQamWOFKruVCGNEuMufE
         HWPZE/O82kX7z4V1sc0EdV8JoBtR8XYR1L4Brs03h3Pucd4OTyiN2Ruc59NB/++r7Ab8
         Z6UW5LHUoTrp8dpwkAMdrE+VPpjqyUSXOD5yG6ZfaWyW88DcnIuvfQszV0NT97JvDS2Z
         t0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699221399; x=1699826199;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZyK94BwxnPjiynzKWPcRjofBhXc5/t3fdP2O17Q1BE=;
        b=j+N6d4MTMZT/bYIWQQt2Qf7+dtqYvvKGvHlXXFsTa+7oPJlfBlm+YLdPvFx6TAejWh
         qeE6e+uJ/oDbk94xPBAywgIIv4C5TdxQQILhfX2BKHxB/c9zwSbm1650TfSCHYiIQtZv
         HRCvF8ATCBwmAPteA7mHHVEtGSGUvnjqRO2iXLWlOLNbkGI+47ymcU0sEWiZbf2HaH1D
         iIfx6vR8m5bYG96xscf+51SKPeCg1EmdAibcvsW2+KXSErqvCzCvy/PKZq3TKgriH1hM
         neXdEkTXyZl8lHhiwC9FNAd3R6/Le4Aq+n+dCKDrYfD/ekhaDXMWK7xh104PWWvQGPkA
         xB8Q==
X-Gm-Message-State: AOJu0YzAsq+72OuVHxodxksdUkvFNOpJYq+u54gghzvlUZ6L5mCuwOGa
        mlWEY8bO12ONERgJZvwkD3Y=
X-Google-Smtp-Source: AGHT+IGGUFyXszet77503FbROEgLDtTV5l17NytQZXjeiUNPUpm8Nm7ASHsSmRyFYcISgxfbKOoAAQ==
X-Received: by 2002:a5d:414f:0:b0:32f:8372:dfe8 with SMTP id c15-20020a5d414f000000b0032f8372dfe8mr13518354wrq.1.1699221398680;
        Sun, 05 Nov 2023 13:56:38 -0800 (PST)
Received: from localhost.localdomain ([94.203.174.192])
        by smtp.gmail.com with ESMTPSA id o17-20020adfcf11000000b0032da319a27asm7728038wrj.9.2023.11.05.13.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:56:38 -0800 (PST)
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To:     masahiroy@kernel.org
Cc:     dmitrii.bundin.a@gmail.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu
Subject: [PATCH v2] kbuild: deb-pkg: apply short -R and -j options
Date:   Mon,  6 Nov 2023 00:56:22 +0300
Message-Id: <20231105215622.17493-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
References: <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long version --rules-file and --jobs are available since 1.18.8
while their short analogues -R and -j have been added since 1.14.7.

The option --rules-file the way it works currently was introduced in the
commit 5cd52673aabdf5eaa58181972119a41041fc85f2 of dpkg dated 23.07.18
with the following changelog entry:

* Fix dpkg-buildpackage option --rules-file parsing. It was trying to parse
  it as --rules-target, which due to the ordering was a no-op.

The current behavior of the long version --rules-file is guaranteed to
be in use starting 1.19.1 and might cause build failures for some
versions newer than 1.18.8 even in spite of being documented that way.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---
 scripts/Makefile.package | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 2bcab02da965..af96319be98e 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -148,7 +148,7 @@ deb-pkg srcdeb-pkg bindeb-pkg:
 	$(if $(findstring source, $(build-type)), \
 		--unsigned-source --compression=$(KDEB_SOURCE_COMPRESS)) \
 	$(if $(findstring binary, $(build-type)), \
-		--rules-file='$(MAKE) -f debian/rules' --jobs=1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
+		-R'$(MAKE) -f debian/rules' -j1 -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch), \
 		--no-check-builddeps) \
 	$(DPKG_FLAGS))
 
-- 
2.17.1

