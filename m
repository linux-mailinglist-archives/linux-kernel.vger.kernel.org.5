Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CB7BC02E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJFUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjJFUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:18:09 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F50100
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:17:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6907e44665bso2233423b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623471; x=1697228271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M6YwZjvr1n2rReATmOsCl4/nRWCKGZ1ZgYFpaWNXvg0=;
        b=EVL+eVa3KsRKrxwxM9roulDeXC4NboWlhS04/2Tzj/Xu477y+FZ3o2jYAmXlapjP8D
         LXKxej68NE4SHG3PRa8xD1dffV3N/dHrWrAXhzqWl5rsLR7r3f28dUYvz3XW5SYWxhTn
         hpl4ubqwUHdiD11Pb6jNEa+AKlaAmhzUgk9UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623471; x=1697228271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6YwZjvr1n2rReATmOsCl4/nRWCKGZ1ZgYFpaWNXvg0=;
        b=OTyCeOexIrz0scDdEvOddcuQbXjxj6oU64eecIuWccB+EZdaEj6UrW2QOhFsXGsL44
         ItZoreDftyynqGFNbgJsLADXRK1BvIGMEisHk0ZhNxOcT3bRKWkV6HT1e7KoyqciR8LB
         EW6JKkSd5pHgdf/A+UDmiVkZaHPZ1RNTNrshxVuptqg1dkqvjlHgT8+MHquq8LQcKuNT
         9i1mUtxK6iKc9eO3T4HzJyEHmR1MGh/cu1VRxcJagRw4KRRAM+0eICkSjqdU0uooLh3l
         NhLrcX1LT52VTzXh3Ftmhju+t7PkeDqmsz9azhmJQBo+e/AQltJD6SE6qYULDoR70K5z
         OifA==
X-Gm-Message-State: AOJu0YzirD80OOnp3zMXK67acwLWZFmKyJDcU3H2lM0NRXZc3AG1odAL
        7oTvnOaGZjME0ie2yCxCF4ctIQ==
X-Google-Smtp-Source: AGHT+IGCGO/cXTptgEcWlTMcxY5y14yHjew/epDhANqohnxpsz/a2MTS0rt9OpO+iHMmFQASendtCw==
X-Received: by 2002:a05:6a00:814:b0:686:24e1:d12e with SMTP id m20-20020a056a00081400b0068624e1d12emr10202159pfk.30.1696623471603;
        Fri, 06 Oct 2023 13:17:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bu3-20020a632943000000b005657495b03bsm3711505pgb.38.2023.10.06.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] driver core: platform: Annotate struct irq_affinity_devres with __counted_by
Date:   Fri,  6 Oct 2023 13:17:49 -0700
Message-Id: <20231006201749.work.432-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=keescook@chromium.org;
 h=from:subject:message-id; bh=KxdzKJ0tyfEaDG8yDFbaDj7zdUPNncMi/SrMW85pCgE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGttEdKoPsgisFKN+sc/je+mRE7+YQ67EeQ2R
 TIPo+ZI1O2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrbQAKCRCJcvTf3G3A
 JiUiD/0RVB9iHYUQ/FQYj8q8DSYzDgIYFkSRrwjxH5iPpaHW8oj2mmim8HgBEz1VIDqO+p0VM5p
 aiL/CdQrHlZC3x2FSA+BsLAF1k+HCwHIM9TdtsoWpn2tvVRWJHM1u0zMwJmAG2pd0h0j0AEba9L
 x/WGtSFmIMIexH2aaSQLfCas3GTZZt6aR7r5OXBDqmDYUaA79fEZOvEsO38Iwl//7xNSjvJrlgp
 d45d5jsSjBKXL88ijkWOmgJ9/bubUOTSTn7IFMEFYmUdBu6KInG0yGi+H5wvdK090l5eGWxY4H9
 XFwOqMrCkiD0iaCYnqc8Yb9UjYr8+mICYLthH+179hts4zSS120ZSNTYY9juYfK18m6eUl+w2Se
 Mr6ALao0wMI8wOhuRLlmjkzA+yLwtnOHXeNINLUCy7kgXwoXzHEgyHyCFfcKfZTqlWwxmoZB9f/
 Qq05MfgERPqFCEuigvSMdiEklLYBVAD8pOy1MyoO6VH1/6lYhMF/WMT9WERicUOIIR67Qac8XBW
 9iHani7cPxpsLYljbnSgwyxKjz6j++nbA5wk7hw3IXHLTb1gf8W7p2VuJrU9dTshhYHn2yKe3OS
 yHCcvlP6Gq1KtD9ZjtMeUmjCCqs/bc4JuC8t/Wtd60aScKhqn9mFtdzx3rVSrgckTShD4+q8/LS
 tCdD8QJ jzU4PZLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
irq_affinity_devres.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..07216889d3ba 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -291,7 +291,7 @@ EXPORT_SYMBOL_GPL(platform_irq_count);
 
 struct irq_affinity_devres {
 	unsigned int count;
-	unsigned int irq[];
+	unsigned int irq[] __counted_by(count);
 };
 
 static void platform_disable_acpi_irq(struct platform_device *pdev, int index)
-- 
2.34.1

