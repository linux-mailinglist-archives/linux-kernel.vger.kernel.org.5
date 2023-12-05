Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBF805DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbjLES3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjLES3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:29:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C4D66;
        Tue,  5 Dec 2023 10:29:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d045097b4cso27879335ad.0;
        Tue, 05 Dec 2023 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701800958; x=1702405758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stzGcH19KP0fN6PjcaFIsGRFjGzenOejH2zUDf42TG8=;
        b=Y3lWeMJLO67QOk54d276y2kgT627gQB4QrhwNjGfUVdSdBF2JbXSwkjeViJTwAOtF2
         LAf14GvStUTX01LDDYjeUsWIE0NRJv5IUnA4q41EhR5T70SawMIEJ6laH6Q55tJ0chA2
         zs/eMh0dfMl8m/0YBGVmznIMgeHRNgJD5S2cz47cA8YFnskqdG3Vl5z1rEFcR3paBBkr
         ywEhtqLx4RYq/wcx4UbnHU5bf2HN/q2s/eewmPV7r75bPoMMtWtOLRqKLf1ymFU/dLfP
         zJjDcSygl8SIZTWUwBoqQK208RH6Pmip2aZiRe3YF+11PcvHasMQzBpkuZfAGCxQTGxE
         1spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800958; x=1702405758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stzGcH19KP0fN6PjcaFIsGRFjGzenOejH2zUDf42TG8=;
        b=r99spiPJnojBGkP5yLeQsTlKq2as7ZyzRj9AXUP1bHi3kNnGcis2FhG2fBjf4zsx4r
         iUxeeuxQeAEphn/ZtwBwBXGde5SVwwmmTRtIiDax8EdiuRYDN19iifC0Z3vDW+O9jYeA
         k/D79YDhIvo291XctU/iCjOszTXCd/jp9NRVyO75ILW2quGz6/Ca470b8UDyHUqjB9vc
         E2NOu2rNH/gyCEC26YsAXrOKa47B/M5o2PSdIMzCrtFMmc92E6HASg0nu7W28fim/QDd
         Yg9Fv7elTnK8HlgHk9dD5g1MdPjdOzzraxfjq5bJfvsPWVn1hrEsh3e2BwfDAncTlPXW
         htsA==
X-Gm-Message-State: AOJu0Yxck/tBH8mJa1cVttFUa2RqTlQhYoGRkDSP/H1+/F4VRgDb9Y9n
        /Inj6eRftaWo0dCMqsfLQjCaKStgt3Q=
X-Google-Smtp-Source: AGHT+IE3jcATXbhx3nt6m6kSPGG26o35XsqOh3of9719nSoBZVZLO0bCVzxt5iVOlvFHmSehFp8T9A==
X-Received: by 2002:a17:903:32d0:b0:1d0:94f8:ab21 with SMTP id i16-20020a17090332d000b001d094f8ab21mr3718069plr.123.1701800957824;
        Tue, 05 Dec 2023 10:29:17 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a801:efb7:8c5b:a158:7e49:e10])
        by smtp.gmail.com with ESMTPSA id jh17-20020a170903329100b001cfad034756sm5779671plb.138.2023.12.05.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:29:16 -0800 (PST)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [RESEND RFC PATCH v4 1/1] scripts: Introduce a default git.orderFile
Date:   Tue,  5 Dec 2023 15:28:51 -0300
Message-ID: <20231205182853.40627-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonardo Bras <leobras@redhat.com>

When reviewing patches, it looks much nicer to have some changes shown
before others, which allow better understanding of the patch before the
the .c files reviewing.

Introduce a default git.orderFile, in order to help developers getting the
best ordering easier.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---

Please provide feedback on what else to add / remove / reorder here!

Changes since RFCv3:
- Added "*types.h" matching so type headers appear before regular headers
- Removed line ends ($) in patterns: they previously provided a 
  false-positive
- Fixed build patterns to allow matching Kconfig, Kbuild & Makefile
  in any subdirectory

Changes since RFCv2:
- Fixed licence comment to from /**/ to #
- Fixed filename in how-to comment
- Fix build order: Kconfig -> Kbuild -> Makefile
- Add *.mk extension 
- Add line-ends ($) to make sure and get the correct extensions
- Thanks Masahiro Yamada for above suggestions!
- 1 Ack, thanks Randy!

Changes since RFCv1:
- Added Kconfig* (thanks Randy Dunlap!)
- Changed Kbuild to Kbuild* (improve matching)


 scripts/git.orderFile | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 000000000000..7cef02cbba3c
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# order file for git, to produce patches which are easier to review
+# by diffing the important stuff like header changes first.
+#
+# one-off usage:
+#   git diff -O scripts/git.orderFile ...
+#
+# add to git config:
+#   git config diff.orderFile scripts/git.orderFile
+#
+
+MAINTAINERS
+
+# Documentation
+Documentation/*
+*.rst
+
+# build system
+*Kconfig*
+*Kbuild*
+*Makefile*
+*.mak
+*.mk
+
+# semantic patches
+*.cocci
+
+# headers
+*types.h
+*.h
+
+# code
+*.c
-- 
2.42.0

