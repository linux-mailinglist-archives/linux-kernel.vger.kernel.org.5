Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4A7687E6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjG3UXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjG3UXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:23:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49A4E78;
        Sun, 30 Jul 2023 13:23:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31771bb4869so4108939f8f.0;
        Sun, 30 Jul 2023 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690748616; x=1691353416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vYtuaLSa3SGm5E8omUOIenjmbSci2X5VPEYpr2AFA4=;
        b=ZtXACvOSAuWFvc3YOp2Alqp5WlBQl0KfEyzpuv6eY8gclBHIvs0aajZvCYwU/VVwKk
         yHRxigtS8j2wKitnrMiNg/s+VsC2hoZCpuWCEEKOk2p1G4CEOKz5nTyb/d0TVlAD7gEF
         T9DwcNSaMXeZ9M0XuvZ1tyVFm1TaqKFKISZR8+5DY5eCteH+Aeazz5nXPsSY5CQ/0Nz3
         23GTR6lBAuMQcDrR6f8ey44/PnPt9qnMKEpRWwX64KtUgLjKYkYJgc78dL+wSgofrFRU
         XtOPv223adiEn2JE4xvdyuP8mvSUyBZxRWuNGmvj3AmKa59gFCLcC4KrAkqrSEj5r2RU
         3sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690748616; x=1691353416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vYtuaLSa3SGm5E8omUOIenjmbSci2X5VPEYpr2AFA4=;
        b=a9i+EjfHKrpdcLPmRP2C/s5TPgpDC5ThrkFQHZHH/S+HFuyo8bAiIwB3Qc5bPNBdpU
         hk7uhFwYCGdTf8iOIVVXJDXAQhygPyiONyC2SwnyaUhl4yfrJYkgRx6db34U4I6YBr4j
         9GTz8umktfV856smIHZFxyDYgYAXaJ65Ze2SReN061Gw2+IUI6PxSlyoiXVsBmxPsGg2
         acobrPwSEiuu56k3akXePEMFJbASapg4+gJTDGB+/hKHA8+FYJIy85iMeLlIQySOSSr/
         Ilic07iOtbggc49mRtuxhv0J39HaQYkVTzqkA/JywcqIQp/O9/xXGzzJJoVVP5bHcNOe
         yUIQ==
X-Gm-Message-State: ABy/qLYFUjXW7hzkwkCvHQGOc1iBwIE5OKd11tw8VUjaCOGsbqY5DhXo
        1D93IeZzdO3V+x4xyc6GEYhRYs5a/5y96A==
X-Google-Smtp-Source: APBJJlHzJ/scDx/KxfBt5DF6cNHWYrD53yHSjsI6HW8/9R06q8uIAOH959VKXhAax0YHT4vqXJ/lpQ==
X-Received: by 2002:a5d:5101:0:b0:314:3ca0:c8c2 with SMTP id s1-20020a5d5101000000b003143ca0c8c2mr561546wrt.11.1690748615883;
        Sun, 30 Jul 2023 13:23:35 -0700 (PDT)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm10814398wrt.60.2023.07.30.13.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 13:23:35 -0700 (PDT)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH] bus: omap_l3_smx: identify timeout source before rebooting
Date:   Sun, 30 Jul 2023 22:22:40 +0200
Message-Id: <20230730202240.898519-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Identify and print the error source before rebooting the board due to an l3
application timeout error, by delaying the BUG_ON. This is helpful when
debugging, e.g. via serial.

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 drivers/bus/omap_l3_smx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index bb1606f5ce2d..70f4903d5468 100644
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
+	BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
+
 	/* Clear the status register */
 	clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
 		L3_AGENT_STATUS_CLEAR_TA;
-- 
2.40.1

