Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3394476A269
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGaVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGaVEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:04:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0AF1BD3;
        Mon, 31 Jul 2023 14:04:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317716a4622so4578699f8f.1;
        Mon, 31 Jul 2023 14:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690837462; x=1691442262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/CpWMqVZIVmwxj9xybEV/ysoKQRi93AAr0L3ptd/7k=;
        b=V8OJPEhgwQVKKDZAUdMVQjsjdZH0Z6XZc38agvPJ49lqePx66kZ56UKZ9qPYdBb5Xl
         33y+ui26R97ER3sOlRHXgUlYg8uL+Zm+t3BzvobNjSi/2vk7N+WbZJU6BvtIEJ6+r83R
         P/km5o5PRBGcaPDQRdi21Do9VoQhwavgCv6He/yd+5qkjvHTM98CAnWxTxaEiCVeznrJ
         FApeu6+n1gWRZWjYAuzanOr1YklumKClEZjZ7+0mt9o8T/z1xbWl9dgXtTo4K9WBrSxD
         trWN1JSAAmMi7/jNYBSdvKqNhr/PIjyLX7sMfoN+SzYOum/e5AhW1aHrbyf/OE1ykWUs
         oFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837462; x=1691442262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/CpWMqVZIVmwxj9xybEV/ysoKQRi93AAr0L3ptd/7k=;
        b=fRbGJx/8oD6MNZx3M9TyQgUzJr+LmBe/alqPnM7O/qGX/iN9du/Y0AvcTK8wTE1PRs
         AJ3o9dgAZ7hAcazB4z2PT11XVc3SlHOy9iJJI3Y8yOazgHzEObKcCGVqhX44y140XqQV
         ON2m/02nDAJSCwaHkPPGiyNIXBWsI5VEb+gDBtVCabP748ZCM+oVd3lP3SLTDAxfESJ1
         Opy3WJYItFV4KW5huXcP0Yq18x3uu+jz1Ob/cnPk1BfpW3OEESHKWn+GF9/VesXAO2OA
         R3+nNJCyEewPDVuWEEVwYxU+Ui0P0+0JMfXXsLSZsVuP6jtBzCxBVkCdnS0Dp86QtkgR
         QeOQ==
X-Gm-Message-State: ABy/qLaL9PsAtqr7/zIxgJkMY2JC0DldjYk1fGcn9CRvqTG/YYHXzRhT
        aZspGzGIdowbap36efpmVosOnOjjP8ztWtwD
X-Google-Smtp-Source: APBJJlHmHdBlWywp1KA2VKP9KHhfxkpsn5T7ZwNUgi1d81NnregVxzNy+XPCUvf9XgL19lMY8wzbnQ==
X-Received: by 2002:a5d:6ac2:0:b0:317:6a7c:6e07 with SMTP id u2-20020a5d6ac2000000b003176a7c6e07mr655341wrw.32.1690837462121;
        Mon, 31 Jul 2023 14:04:22 -0700 (PDT)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600012c900b003143801f8d8sm14127303wrx.103.2023.07.31.14.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:04:21 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2] bus: omap_l3_smx: identify timeout source before rebooting
Date:   Mon, 31 Jul 2023 23:03:47 +0200
Message-Id: <20230731210347.1048060-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify and print the error source before rebooting the board due to an l3
application timeout error, by delaying the BUG_ON. This is helpful when
debugging, e.g. via serial.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/bus/omap_l3_smx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index bb1606f5ce2d..0ccde12e33c0 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -170,11 +170,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
 		/*
 		 * if we have a timeout error, there's nothing we can
-		 * do besides rebooting the board. So let's BUG on any
-		 * of such errors and handle the others. timeout error
-		 * is severe and not expected to occur.
+		 * do besides rebooting the board after identifying the
+		 * error source.
 		 */
-		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
 	} else {
 		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
 		/* No timeout error for debug sources */
@@ -190,6 +188,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		ret |= omap3_l3_block_irq(l3, error, error_addr);
 	}
 
+	/*
+	 * BUG on application timeout errors since they are severe and not
+	 * expected to occur.
+	 */
+	BUG_ON(!int_type && status & L3_STATUS_0_TIMEOUT_MASK);
+
 	/* Clear the status register */
 	clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
 		L3_AGENT_STATUS_CLEAR_TA;
-- 
2.40.1

