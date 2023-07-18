Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F37575F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGRH62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGRH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:57:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D919AF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:20 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so54353135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667038; x=1690271838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79dyPF1dW9iLj8dVCiBHfNzjd/8aXcogMMHx2+UBEFs=;
        b=xI6AhBHEiKGjBrjg6uWp3lc7OX1cZK2+z2t0JWTkBKNpr6bKX0j8ybY94cE9Qvxtd2
         NeJ9Bou7u/EX3ApYjhheLQn6Nim97a2CqSr5wOxZJd6Jpqe54YdoIrmy/4+qG9q/i3K9
         7536+NwJnzHh5vTL8NTvvTxOk3yr7fVXDBoH++y4BjKksGKPhOJ4DcXmF7cfVfygfDes
         15La8AuakdxulH21iIyXu5JiY5sm0L4PMjTubKC7bshxxxlh9YYvA1usk84rXhf1UHMS
         /uJtZiO5SzOblMAmPH7S6znzQLQnmylotQrgVefghFmp0HwTbwOB8345p2ovKMdDgTri
         RsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667038; x=1690271838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79dyPF1dW9iLj8dVCiBHfNzjd/8aXcogMMHx2+UBEFs=;
        b=SscxJkChtY0SdoArQY0SYVAYyVxgdsMl2WCJ7X+EqK+g1tYLzyV8AdoG70VjS5sJRG
         v2yOWLdYXbUx5lx35x74rnK/w0QgxijyHV8TjcOTszjsaqQ4VETif+S/fS8bUNhWBrE5
         +RYNkKtis//N/APvYPvvRkk6eIzQEvG1J1poitaM9yYQKgphhOKRJwmxpDBNdylobr6F
         K5ALEDnChfym3qaIUnAIfv+Tt7/6hSM1QuwmDo0FWzEj2GmjXJ78zut0Or1oU0Ebxg3S
         YSyT9Yh7qCzFkHTLwbXVKj19EU6u5qqGL4UJ5gHOH2oemTXTGUmKne4rnW3vvm87kqIK
         s8TQ==
X-Gm-Message-State: ABy/qLZoywjWIglUDzVqmVo83MqOGrmWIlqFSzbEl1CyH4qcs752RweT
        NhuisaTnvEsPs9DuyuKZChp6VQ==
X-Google-Smtp-Source: APBJJlHvNdgDo+D/5tJJf1TEpiShOTGIC7973pb53PfUXVIwE5WGe7lLeWNeuBWUXfC16Qkyg+IP6g==
X-Received: by 2002:a7b:ce19:0:b0:3fc:4ee:12b4 with SMTP id m25-20020a7bce19000000b003fc04ee12b4mr1177310wmc.32.1689667038811;
        Tue, 18 Jul 2023 00:57:18 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:18 -0700 (PDT)
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
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 07/12] can: m_can: Cache tx putidx
Date:   Tue, 18 Jul 2023 09:57:03 +0200
Message-Id: <20230718075708.958094-8-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m_can_tx_handler is the only place where data is written to the tx fifo.
We can calculate the putidx in the driver code here to avoid the
dependency on the txfqs register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 +++++++-
 drivers/net/can/m_can/m_can.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6a815812ae38..45e8afb1b795 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1482,6 +1482,10 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (cdev->version > 30)
+		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+						 m_can_read(cdev, M_CAN_TXFQS));
+
 	return 0;
 }
 
@@ -1771,7 +1775,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
+		putidx = cdev->tx_fifo_putidx;
 
 		/* Construct DLC Field, with CAN-FD configuration.
 		 * Use the put index of the fifo as the message marker,
@@ -1805,6 +1809,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
+					0 : cdev->tx_fifo_putidx);
 
 		/* stop network queue if fifo full */
 		if (m_can_tx_fifo_full(cdev) ||
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index d0c21eddb6ec..548ae908ac4e 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -102,6 +102,9 @@ struct m_can_classdev {
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
+	// Store this internally to avoid fetch delays on peripheral chips
+	int tx_fifo_putidx;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-- 
2.40.1

