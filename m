Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B717EED2E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbjKQIKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjKQIKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:10:11 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DC5B3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:10:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b40bf434a3so344410b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700208607; x=1700813407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j05EofG28rFbGboqZoP5R96M/5boTODVV1yGcFQG4wc=;
        b=mJVyOO8BtHnPfIpFqxpT0bIejS+A2tmjfjVCjJYE4KAPY3k349xvijqxcesUkDv+kO
         5rJ9fDTWIaqcObIm2KMkWkX9FrtNM5Kza9hWvK8CPvp4Wv88BBqVt989p9nUGXQmtCPa
         sZ2kDaFXvsVAe0MOmYsXHQwr5ejrcMcC+w7O9eMEA9eGmjwxRoCmlz5/YjJ2sHIMaghx
         k3g0whVxbvVpidItzAd3NtrpDj/QKuhJqpao5SNUOl7PizpFTaksqQEwQcS9lCI/DyMV
         WeGHMW7ebeTwEbHnwwUsB+ACiUstfvA59LhM7gfxuZ4NtE4Jvy6PkvWGxd9FSm4TFcK7
         czYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700208607; x=1700813407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j05EofG28rFbGboqZoP5R96M/5boTODVV1yGcFQG4wc=;
        b=o3ftn13lwxcCF8b1jjgNsRx+WK6S8QI9N2YxBEaEwzzxYdhRs4MgIriGx+8GWZGYRV
         cLgdFTCxI8wZQIKXs6iKt5o9Bl91l6XarO6CeXePa+sVW+zWZAlMXUckDPtOL4cKc1cf
         EpesF6z+rQHOSgAzJN7Gpsf3x9tUTIH44I+Oq/rb68w3XNOCQOohvXwpTdeIaABNSJ9Y
         WoZHdRHllCRDzibFJaHv+dlpDlKNXfvCdQ5sxM7Cp1h6RmRtzzGQKk5ACQrMMKWP6pNx
         +e5rHZCPCpYH8fWw0r7XrbGL4HJHFakYaCCtMvMw2ChfAZT4swF+G2P0yHzXekMWqxai
         RcXg==
X-Gm-Message-State: AOJu0Ywxs8wxtPL7k0qSlk+v3WRUnjDkslLgovC3Xv3OKyRDKctdcpFS
        8l239Gsfvc5kJrxXIVYK8xB60A==
X-Google-Smtp-Source: AGHT+IHJPwPa+W+qlve0ksmPI2HbMgpB1Udyl4DkhXHf7j52pThb0yAsW1NixCCz68Z7g7sLFQuonw==
X-Received: by 2002:a05:6808:1719:b0:3b6:db1b:67b7 with SMTP id bc25-20020a056808171900b003b6db1b67b7mr13677032oib.4.1700208607310;
        Fri, 17 Nov 2023 00:10:07 -0800 (PST)
Received: from fedora.. ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id y5-20020a655a05000000b005b3a91e8a94sm765500pgs.76.2023.11.17.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 00:10:06 -0800 (PST)
From:   Ryosuke Saito <ryosuke.saito@linaro.org>
To:     jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, masahisa.kojima@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: netsec: replace cpu_relax() with timeout handling for register checks
Date:   Fri, 17 Nov 2023 17:10:02 +0900
Message-ID: <20231117081002.60107-1-ryosuke.saito@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_relax() loops have the potential to hang if the specified
register bits are not met on condition. The patch replaces it with
usleep_range() and netsec_wait_while_busy() which includes timeout
logic.

Additionally, if the error condition is met during interrupting DMA
transfer, there's no recovery mechanism available. In that case, any
frames being sent or received will be discarded, which leads to
potential frame loss as indicated in the comments.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 drivers/net/ethernet/socionext/netsec.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 0dcd6a568b06..6f9127d30a9a 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -1410,21 +1410,28 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
 		netsec_write(priv, NETSEC_REG_DMA_MH_CTRL,
 			     NETSEC_DMA_CTRL_REG_STOP);
 
-		while (netsec_read(priv, NETSEC_REG_DMA_HM_CTRL) &
-		       NETSEC_DMA_CTRL_REG_STOP)
-			cpu_relax();
-
-		while (netsec_read(priv, NETSEC_REG_DMA_MH_CTRL) &
-		       NETSEC_DMA_CTRL_REG_STOP)
-			cpu_relax();
+		if (netsec_wait_while_busy(priv, NETSEC_REG_DMA_HM_CTRL,
+					   NETSEC_DMA_CTRL_REG_STOP) ||
+		    netsec_wait_while_busy(priv, NETSEC_REG_DMA_MH_CTRL,
+					   NETSEC_DMA_CTRL_REG_STOP)) {
+			dev_warn(priv->dev,
+				 "%s: DMA transfer cannot be stopped.\n",
+				 __func__);
+			/* There is no recovery mechanism in place if this
+			 * error occurs. Frames may be lost.
+			 */
+		}
 	}
 
 	netsec_write(priv, NETSEC_REG_SOFT_RST, NETSEC_SOFT_RST_REG_RESET);
 	netsec_write(priv, NETSEC_REG_SOFT_RST, NETSEC_SOFT_RST_REG_RUN);
 	netsec_write(priv, NETSEC_REG_COM_INIT, NETSEC_COM_INIT_REG_ALL);
 
-	while (netsec_read(priv, NETSEC_REG_COM_INIT) != 0)
-		cpu_relax();
+	if (netsec_wait_while_busy(priv, NETSEC_REG_COM_INIT, 1)) {
+		dev_err(priv->dev,
+			"%s: failed to reset NETSEC.\n", __func__);
+		return -ETIMEDOUT;
+	}
 
 	/* set desc_start addr */
 	netsec_write(priv, NETSEC_REG_NRM_RX_DESC_START_UP,
@@ -1476,9 +1483,13 @@ static int netsec_reset_hardware(struct netsec_priv *priv,
 	netsec_write(priv, NETSEC_REG_DMA_MH_CTRL, MH_CTRL__MODE_TRANS);
 	netsec_write(priv, NETSEC_REG_PKT_CTRL, value);
 
-	while ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
-		NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0)
-		cpu_relax();
+	usleep_range(100000, 120000);
+
+	if ((netsec_read(priv, NETSEC_REG_MODE_TRANS_COMP_STATUS) &
+			 NETSEC_MODE_TRANS_COMP_IRQ_T2N) == 0) {
+		dev_warn(priv->dev,
+			 "%s: trans comp timeout.\n", __func__);
+	}
 
 	/* clear any pending EMPTY/ERR irq status */
 	netsec_write(priv, NETSEC_REG_NRM_TX_STATUS, ~0);
-- 
2.34.1

