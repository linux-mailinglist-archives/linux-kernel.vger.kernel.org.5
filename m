Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B376BD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjHATXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjHATX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:23:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF299C;
        Tue,  1 Aug 2023 12:23:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so66021185e9.2;
        Tue, 01 Aug 2023 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690917806; x=1691522606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlk6j8VV67xBiOXhkkLv1ZO7Ahk1E6BY8WoLyYVNMug=;
        b=UYzqulpjcLYc93ibI7pV7LkMJrbhG+EhG4tGkg1bb+zZDLSx/je74kmggGqE4u5xtQ
         4SuwuS8uxiPsOG55BrauC1Ud1h4Wfld4SyRVMzOV76GPO20ujwITdQWaFvH5bq1PuMNW
         VsJkwnKUO/s/Y2fX2627Aqt5ne+g02cd3iGLy7Q0A7D2fG5FAfO9Xmmbjdy473OkVpjE
         6X6uVKNr+x/Y7w6l8FC0Tji3cR3mX59cXMJdKkeH+NFwJKSG7eAXtfXrmyO7LUWppWp1
         C4YCvsS0JzxIeyoZoikNwOmao0l5oMP6qffsni3tNv7UhmrIqjbysm555J4ODV3TbZEu
         fZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917806; x=1691522606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlk6j8VV67xBiOXhkkLv1ZO7Ahk1E6BY8WoLyYVNMug=;
        b=FtQByuZQ6IqSIZ8lmq6FbDYmaTza2z0GtJTRTi1KLWbxTCcW/VT/2EnIUWtsquJLlq
         FJz+tq/djrqWbEf9b9gKwaLKWhjwoV37MB/0h1Z+7YYkTFIAtBXMAhcNJnxCD5aFVJtM
         +xIOIkNqZEgKEIIc44EhqHQE6+NbPIUXNdsGwfhPlSQ7OqiFVy/cHWVaquelHSHzkPyy
         u7DmXAwxFj0X+lYE6C5s59ULaZZ5UqdvbjASvGxv+DM4AyihLvJbc8qcd2pbJCnv5YLv
         jVJ0StOI68znAi2AipbOxSIB08SQ3mMmcx1MmpG0Ize4GV2+E6Z3bsxExU+Su7axK51I
         UFYA==
X-Gm-Message-State: ABy/qLZfdVW9OKCpQ3V7mTphJOhS65/uLXdsbOgHkeDKTiSuYmPC/1aM
        7aGIkielqI0lkS1sOfarlUNnghmVpbsRBJ1t
X-Google-Smtp-Source: APBJJlHkLCPO6wXTQd+QQ6GHrr3bApuwv25MFWtutmy46mhyw1ovpsntGhdUUzyWTbLU3bi2/6/EwQ==
X-Received: by 2002:a05:600c:2216:b0:3fe:16d3:7d60 with SMTP id z22-20020a05600c221600b003fe16d37d60mr3411254wml.9.1690917805870;
        Tue, 01 Aug 2023 12:23:25 -0700 (PDT)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4206000000b00317a04131c5sm7895582wrq.57.2023.08.01.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:23:25 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, maemo-leste@lists.dyne.org,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v3] bus: omap_l3_smx: identify timeout cause before rebooting
Date:   Tue,  1 Aug 2023 21:22:40 +0200
Message-Id: <20230801192240.1063764-1-absicsz@gmail.com>
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
timeout error. This is helpful when debugging, e.g. via serial.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/bus/omap_l3_smx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index bb1606f5ce2d..8e1a38bfcd8b 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -166,19 +166,10 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 	irqreturn_t ret = IRQ_NONE;
 
 	int_type = irq == l3->app_irq ? L3_APPLICATION_ERROR : L3_DEBUG_ERROR;
-	if (!int_type) {
+	if (!int_type)
 		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
-		/*
-		 * if we have a timeout error, there's nothing we can
-		 * do besides rebooting the board. So let's BUG on any
-		 * of such errors and handle the others. timeout error
-		 * is severe and not expected to occur.
-		 */
-		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
-	} else {
+	else
 		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
-		/* No timeout error for debug sources */
-	}
 
 	/* identify the error source */
 	err_source = __ffs(status);
@@ -190,6 +181,14 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		ret |= omap3_l3_block_irq(l3, error, error_addr);
 	}
 
+	/*
+	 * if we have a timeout error, there's nothing we can
+	 * do besides rebooting the board. So let's BUG on any
+	 * of such errors and handle the others. timeout error
+	 * is severe and not expected to occur.
+	 */
+	BUG_ON(!int_type && status & L3_STATUS_0_TIMEOUT_MASK);
+
 	/* Clear the status register */
 	clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
 		L3_AGENT_STATUS_CLEAR_TA;
-- 
2.40.1

