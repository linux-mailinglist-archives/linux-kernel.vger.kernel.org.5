Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7C79C42A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjILDbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjILDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 091AE40F65
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694484730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pVho9DFdy9WX2sV5QCNmMLyT6ZAwYjpgqtFPu/9HvYo=;
        b=MqBzbay1B1jbEaaVCKPnNwFMCP4EeUZ0eXpXWRP9NiGTAl6URboqxHELrzQIaf5xlx+X+n
        jgti3ANRJk6CR/Ue+dMMQ+EX345iPfU2IZ8rjhKBqb3hFi0kx2Amw+rJ2W7Yd7uVeqzWCe
        Y9XLpkfMTPtHqBdaVttwRDb/QmCc8vU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-x0qv35VfN4e9TPzPOkMByQ-1; Mon, 11 Sep 2023 19:45:39 -0400
X-MC-Unique: x0qv35VfN4e9TPzPOkMByQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bb31e13a13so4949069a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 16:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475938; x=1695080738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVho9DFdy9WX2sV5QCNmMLyT6ZAwYjpgqtFPu/9HvYo=;
        b=fQsy5XZqcmgUVFJpeiaLE4tztMOicAg8R80MSVqW4eggwx2+TnBWTHD0GXqQjYnFfn
         ODOANoql0yOeCyT7meGRtVLiXFn9S/83ENMG4IDwEsm9ELYvU4JJxxkvfOiSJqReGkUd
         CM4IJVk3u2uCq6x38yBoVukWy3/+6kueTwaz0ikk2xDbS3/FAmH/jCPcvE0DhTRjQMiy
         1xUbB4Dj9Ui99kDB5P8HVks0iZKgLkZQ3F0PDtLHRvopNENphIHzzBJ39xyFHAR5+Rve
         Mq1EIvq2aGfjwDPeu6w+ga0BWsWA94/HAUveEM/b8kmj39R3Ecyn4MQ0WOQK50ElYzkn
         +Hog==
X-Gm-Message-State: AOJu0YxMOdFl+8M8sFH4j9GBrL2ykOjsK+AtmtpeRcmTY6aDUZHfoKsb
        SnHJMIlROQQAP50+9BRd8GkW+mR3/TSRkfsrznjZrD91BFAwj8qfOw6g0/raz5Fl6xRFY7L15x4
        aqUw+sNkMvd1bpOaJtiTGx1NA
X-Received: by 2002:a9d:6d19:0:b0:6bc:c542:6f75 with SMTP id o25-20020a9d6d19000000b006bcc5426f75mr12808185otp.0.1694475938733;
        Mon, 11 Sep 2023 16:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPpJM2jDI9Nw3z0LJidGHjDMA/sa6wLPPzWY/rhO4GYN6s/67nHlerNd4ErB5Sr6FlG6KNOQ==
X-Received: by 2002:a9d:6d19:0:b0:6bc:c542:6f75 with SMTP id o25-20020a9d6d19000000b006bcc5426f75mr12808172otp.0.1694475938540;
        Mon, 11 Sep 2023 16:45:38 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a803:c91:da45:7fbc:86c3:920a])
        by smtp.gmail.com with ESMTPSA id a2-20020a9d6e82000000b006b89596bc61sm3547839otr.61.2023.09.11.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:45:37 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [RFC PATCH v2 1/1] scripts: Introduce a default git.orderFile
Date:   Mon, 11 Sep 2023 20:44:17 -0300
Message-ID: <20230911234418.38154-2-leobras@redhat.com>
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
---

Please provide feedback on what else to add / remove / reorder here!

Changes since RFCv1:
- Added Kconfig* (thanks Randy Dunlap!)
- Changed Kbuild to Kbuild* (improve matching)

 scripts/git.orderFile | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 scripts/git.orderFile

diff --git a/scripts/git.orderFile b/scripts/git.orderFile
new file mode 100644
index 000000000000..819f0a957fe3
--- /dev/null
+++ b/scripts/git.orderFile
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+# order file for git, to produce patches which are easier to review
+# by diffing the important stuff like header changes first.
+#
+# one-off usage:
+#   git diff -O scripts/git.orderfile ...
+#
+# add to git config:
+#   git config diff.orderFile scripts/git.orderfile
+#
+
+MAINTAINERS
+
+# Documentation
+Documentation/*
+*.rst
+
+# build system
+Kbuild*
+Kconfig*
+Makefile*
+*.mak
+
+# semantic patches
+*.cocci
+
+# headers
+*.h
+
+# code
+*.c
-- 
2.42.0

