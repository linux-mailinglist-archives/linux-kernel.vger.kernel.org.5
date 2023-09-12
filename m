Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC479D9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjILUEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 910B9E4B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694549039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ZYzFeDTqv4NEk2wsriVo1Hlnvd32x/xng7r2s4VeXY=;
        b=KrsxQQ+kdemdpikZgZHmMI5N5Jgzdf6awi2tTNEiH37kBYbSj/AuH2Q0wZGc8CpmAY9Ew+
        tsvCQDJWmnh6jkTX9k6LUF9E7A7WZd1q1hsFZxULdePioXLZ+7YUD6QoQ/z9pVParKaYae
        ZkC7sBs73257To0YdgcTaLHT3+x3+0E=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-h8rAhY95OrCQlh_760Ij8A-1; Tue, 12 Sep 2023 16:03:55 -0400
X-MC-Unique: h8rAhY95OrCQlh_760Ij8A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3aa0fabef2cso6583392b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549035; x=1695153835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZYzFeDTqv4NEk2wsriVo1Hlnvd32x/xng7r2s4VeXY=;
        b=LTLNXefQVHYblVnG4OUzMqea1+r6ZX0uN6pMzrrQHXZKu2tmh9iKogAuT3fmqLRiPq
         hUFTOGUL2uOGQe/LzBqDrCYzIRRgH5G9splTVz5/tjxyRRJ39oR/qklkpr63BLQth44p
         lxTP+X+1c1AcJENn55lvYGKOGa/sZ+n8WxG9LDB7GcbASvhVb9c4rswzQGc//PEZCuv8
         Duhwo0TYbLWdNns7ncjhKilTWGg2DOylNRhT6RA2mo7qaCUU5SN34tlx2hAWFsbZrNYo
         w62U+QmzAf9o7Q41PIS68htlC2ZNoPXjrdlkwD80QQZLFys6rt+6yuNXoyhcezLIOH4A
         XknA==
X-Gm-Message-State: AOJu0Yxt0w40CJ9a3zIqIXqD/UJ6PafLy5Xh3xwvgiNqGqGX+tLL+QuC
        xINEHIOVVbICWQdbYX/0flVuDpqQBTgHBPcDo3FrMfUOZJq/vGc5fIwfFveVr0u0Wd9q9mzhjR9
        3OG4sKo55b/HZBhprKbdYObX7
X-Received: by 2002:a05:6808:1911:b0:3a7:4cf6:f0cb with SMTP id bf17-20020a056808191100b003a74cf6f0cbmr999770oib.21.1694549034959;
        Tue, 12 Sep 2023 13:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbU7InQsgkmNtcTiyXiWp9rVtCDfO6fOeyfnKePLxrfgxFwK6FDaKwWpI+QBLrh8fEbC2YsA==
X-Received: by 2002:a05:6808:1911:b0:3a7:4cf6:f0cb with SMTP id bf17-20020a056808191100b003a74cf6f0cbmr999749oib.21.1694549034711;
        Tue, 12 Sep 2023 13:03:54 -0700 (PDT)
Received: from localhost.localdomain (201-13-138-24.dial-up.telesp.net.br. [201.13.138.24])
        by smtp.gmail.com with ESMTPSA id z10-20020a056808048a00b003a42c45c109sm4542720oid.2.2023.09.12.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:03:54 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.or
Subject: [RFC PATCH v3 1/1] scripts: Introduce a default git.orderFile
Date:   Tue, 12 Sep 2023 17:03:33 -0300
Message-ID: <20230912200335.65096-2-leobras@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing patches, it looks much nicer to have some changes shown
before others, which allow better understanding of the patch before the
the .c files reviewing.

Introduce a default git.orderFile, in order to help developers getting the
best ordering easier.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---

Please provide feedback on what else to add / remove / reorder here!

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

 scripts/git.orderFile | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 000000000000..fe985046613f
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,33 @@
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
+*.rst$
+
+# build system
+Kconfig*
+Kbuild*
+Makefile*
+*.mak$
+*.mk$
+
+# semantic patches
+*.cocci$
+
+# headers
+*.h$
+
+# code
+*.c$
-- 
2.42.0

