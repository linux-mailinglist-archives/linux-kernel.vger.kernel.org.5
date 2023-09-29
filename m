Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC037B3474
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjI2ONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjI2ONQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:13:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E91B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32167a4adaaso13500093f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695996792; x=1696601592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReBi7BC06ODO44p0m+LSvmAR1HhRlF0fwYBoeL/cies=;
        b=y+MDBCG563M0azVA82P9QiUidcI1xqAG91WBP78JW3mi3H72qhjiE16aPMrnZi2unZ
         aTO6xCsOGFGLM/AwlP86oHcO808pzcPZBDoD1reQImJ2v4cp1PaDauEJ7SFw4AMGg85V
         YVcZy0oadH879/ZKUk08TQL6Zn1crgCKyXCOtMa2hTwSEwF/QrENEqJqqGZ5wdtdh5Jv
         OyikaNdV3W8/m4wwV/qWlRpe4JorwzKHRb3ehYYMkC6ixx4RJ9A8yxJ62MiQjCbdrSoA
         akqbjUx/Y/EQFr3HsvBErRCWmnn0oN+q65D05hOHqwhNqeA/jUspG3jyCyVvcERxig30
         +PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695996792; x=1696601592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReBi7BC06ODO44p0m+LSvmAR1HhRlF0fwYBoeL/cies=;
        b=LKYnJKG2S06aN1r3iOD6ChIJSq9iTw+4J4UaZE/PZHqgE9bR4J8Ey9vcAekCknmQ5s
         lrci8UdH9v5TfzjvWjd02cJ1WY4gxvVDrj7UFnT0KUB2hEYNMATzwOth197vFq3JlUlj
         KnMCYLKJrUvlWxGDGurQ77fH0rSDrazNdnB55ORhpdktr7kVp8HFm5yiRTWnumFVedl+
         cNi5mMa6uVva6PGCzP8Kx6dMsLmJvrONH35xTL79pvf2Iod17q895270S0JRvytbACkW
         loiJtPLRTgRuOjYYlxEj2sjsEvps8kJZztE0pXbC+fR1IF7L7VKWUHmnKVUFGW9QQ2zN
         2nuQ==
X-Gm-Message-State: AOJu0YznrbLtBVaFM+pkSyu0EZzCK6RmYlhqi3MrpNXZewQS+zHA5N4S
        uOgpLqM3d4VgGFzO4bXhFZciEw==
X-Google-Smtp-Source: AGHT+IGvAk+reWOwVx+ALcTPS/Xr8hMSn5GOsHrLNzoL8UfdVQw7h+/6lVQUslea0DH5ARmJg9MQJA==
X-Received: by 2002:adf:fc4c:0:b0:31a:d4e1:ea30 with SMTP id e12-20020adffc4c000000b0031ad4e1ea30mr4139783wrs.17.1695996792502;
        Fri, 29 Sep 2023 07:13:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:8222:dbda:9cd9:39cc:f174])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm1513068wmj.41.2023.09.29.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:13:12 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v6 02/14] can: m_can: Move hrtimer init to m_can_class_register
Date:   Fri, 29 Sep 2023 16:12:52 +0200
Message-Id: <20230929141304.3934380-3-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hrtimer_init() is called in m_can_plat_probe() and the hrtimer
function is set in m_can_class_register(). For readability it is better
to keep these two together in m_can_class_register().

Cc: Judith Mendez <jm@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++++-
 drivers/net/can/m_can/m_can_platform.c | 4 ----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2395b1225cc8..45391492339e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2070,8 +2070,12 @@ int m_can_class_register(struct m_can_classdev *cdev)
 			goto clk_disable;
 	}
 
-	if (!cdev->net->irq)
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Polling enabled, initialize hrtimer");
+		hrtimer_init(&cdev->hrtimer, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL_PINNED);
 		cdev->hrtimer.function = &hrtimer_callback;
+	}
 
 	ret = m_can_dev_setup(cdev);
 	if (ret)
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index cdb28d6a092c..ab1b8211a61c 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -109,10 +109,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 			ret = irq;
 			goto probe_fail;
 		}
-	} else {
-		dev_dbg(mcan_class->dev, "Polling enabled, initialize hrtimer");
-		hrtimer_init(&mcan_class->hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
 	}
 
 	/* message ram could be shared */
-- 
2.40.1

