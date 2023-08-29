Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0E78BCE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbjH2Cj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjH2CjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:22 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EE13D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:20 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5733aa10291so2668366eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276759; x=1693881559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VbD+SR5jCur1/t4RnPL1xcIxaeNUhQeZ+KfWJc7SsU=;
        b=o6vNJy8bdSDXxfI81GjNkpisiD7xoP+4R5TMu+r1JHX6yBbq/I+ZHVzZYqUQvUJn8s
         Qcq0GUxTOMmu4m/4EDT+eNqdpHqIW3sCT/mK137j9K6thZg2V9GwvD5iszDZS9May/rr
         HwkvGA00kI6bFLrU1Ds6O7UiVq4R2oZe7CAOEWG05yXoU9Nas94OPbEPGjuniW7seE77
         DUiVb2fkDYt7AEcqVZbluhaiqwVYsBRakcSq5O3gA1ShyFQf5ywd+1LtA+Ua+/mmLBh3
         JpW5KQHQYD9pFINGsh1NMLRAFCsKqOpiK3AHrKSvYtre3ON+XVSFkQJsVUI1jUT1MEc+
         Yayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276759; x=1693881559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VbD+SR5jCur1/t4RnPL1xcIxaeNUhQeZ+KfWJc7SsU=;
        b=Efzn5mM4vvjMx3Rbm3ueuq3wEEUbsovDRc17PB18WPB+JkGstiHY71NZXGeoEq2B5y
         giuH2ZCmtvf4GzWa2YqgjnqSKvH1nSItcuE1Hz1YMowYl7vWcqAr91Z1zcoib+AuACzR
         IrnQ81cJuwUbut/8TxH9yJOQRF8MZXvi0gDmkmPlbT6wGu720u4hyHDvjN0NCHvusGMj
         CisVVf184VSV9mYduYgp0Inu2PoFIYUEJK0gVclJVcA0AXJZ6aJNTaMFb+SYGyDN1GbN
         3Z5Ch4+4JSKjghzyfnltQtH82ATdEuNrvjiyZooXEmGbNyCdtJPtHacAYb1IDbWjr108
         A6ew==
X-Gm-Message-State: AOJu0Yz+WsBPxjnSR8tnUpgW3odtne0Lq4Ods/whNR9GQpHJ8rqL8lWA
        EFOCrRBtcezGOc0L+ctd0JkSWU0/3dY=
X-Google-Smtp-Source: AGHT+IFHFCIk3gU9oude655DrvwVhztcRTvGKWomnRN7fFsUrjeIqz0YNAddtpGdRs7rwQWa9mJCtw==
X-Received: by 2002:a4a:3c5e:0:b0:56c:77b6:6d46 with SMTP id p30-20020a4a3c5e000000b0056c77b66d46mr13666749oof.9.1693276759042;
        Mon, 28 Aug 2023 19:39:19 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id s15-20020a4aad4f000000b00573a7d8f382sm415075oon.36.2023.08.28.19.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:18 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 3/8] bitmap: fix opencoded bitmap_allocate_region()
Date:   Mon, 28 Aug 2023 19:39:06 -0700
Message-Id: <20230829023911.64335-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 250715260d95..3c069944dd83 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1315,10 +1315,8 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
-			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
-		return pos;
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
 	}
 	return -ENOMEM;
 }
-- 
2.39.2

