Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA13D7643A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjG0CCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjG0CC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D53F5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:24 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9ec15e014so403674a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423343; x=1691028143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d6DIVKFawOMMIJLnYm8D4xwWB9Dgojb3pJDV5k1BWo=;
        b=IKVSlvEBuLb8cq54LSOaCvpKeohRZhPCwM+ZGrqES/emJidsTD1ZfsklKwzo93ATvi
         ZjsByhGPaaTx2ul5l6jP/tnhBK4nZzmpBcRRpNLig0ruJubaPVDrfdS2BzvUOGsPJIF0
         Ypi5z6UPfqw8t8fgpI3DIp7KtqPRgx1tuY2AhyiYSoY9xuq3fvbIA4We4w0z1WLn1vZi
         2tLifF6mC3wkpDcPGmm51q+YDkNq45vdsulZcO7hNQIjuL2/ip/FSULPgC1y5f5qG0Qf
         gT4i7AGUs+FTXrk5XWmZx7BVJHQVC6TIdkkJwwu4V4F4Lfh6VSRvRmxyK6WDdGCSM0dq
         Oukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423343; x=1691028143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d6DIVKFawOMMIJLnYm8D4xwWB9Dgojb3pJDV5k1BWo=;
        b=KtL/joqJzfy+Vyig9Wj+yvTfkjHHSYxxne33xpGlT9M3ku1dBFyNkpAS31Gef4t7PM
         LS+3IKzele50pwDmKRr2kVMzs9r3nKoAEwouAQmiuG6+v2ENZraeBlkkTkmNqREcLM6I
         +DNhPYasXVuDcpO+g3Rd0+yP2NxwE7Y07vhV3wllj7eta3p8WnAHDkRSGkt4u/6xsGUR
         YBpocc4WBufnuko6/575P3Lj+UEmuo1ElUz9fc42qoeXoPnXsmxB41RI8+GsPrIp6VmC
         QS9QWSOTqqBdaW30JPtGV99ARv90yOLz5SK2hLZKJXJojXQqjd6giHemlajrNFaT3vHE
         Z9cg==
X-Gm-Message-State: ABy/qLbgeowx3b0QqOkrSKb8+EW8boGIQ89MEG5cg1BK8NFqGEcMSS6U
        GHk3na+rBB2B/wcX6gXLNaFqJAiGiG55SA==
X-Google-Smtp-Source: APBJJlFjpHVjAga5y8aJXK5X7B5sanIetM6OhbfApqpDPH85bGk7/kdrEqXpz0n5eJaTDQlJoDzEdg==
X-Received: by 2002:a05:6830:1050:b0:6b9:53ff:7513 with SMTP id b16-20020a056830105000b006b953ff7513mr3980719otp.34.1690423343206;
        Wed, 26 Jul 2023 19:02:23 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a398800b00267f1455d60sm208692pjb.20.2023.07.26.19.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 3/6] bitmap: replace _reg_op(REG_OP_RELEASE) with bitmap_clear()
Date:   Wed, 26 Jul 2023 19:02:04 -0700
Message-Id: <20230727020207.36314-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727020207.36314-1-yury.norov@gmail.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
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

_reg_op(REG_OP_RELEASE) duplicates bitmap_clear(). Drop it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 346b848170e4..9be083ad71bf 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1335,7 +1335,7 @@ EXPORT_SYMBOL(bitmap_find_free_region);
  */
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
 {
-	__reg_op(bitmap, pos, order, REG_OP_RELEASE);
+	bitmap_clear(bitmap, pos, pos + BIT(order));
 }
 EXPORT_SYMBOL(bitmap_release_region);
 
-- 
2.39.2

