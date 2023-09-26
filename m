Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C87AEE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIZOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIZOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:07:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05193EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:07:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317c3ac7339so8616759f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695737222; x=1696342022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fL7byGgITI5Pp0Gd+G4m6HpKfvXhtfMbVSSCjqe9VQ=;
        b=BnCASo/Tc6qi8EZNvvmtD3lpKkDK5Jr10FBAjpayIpuUuTWRz+oWq5JIEXd8y8Oi9y
         5MbEsapYW42020HkaAUkZGGEG1TxizLzNgG+0sLORgH4dbUuOe8B/yo8Fmac0/LSOWRm
         vnGYrva4u1M3QdsYVkLOiU+wVOiOkkW6MJfbPxtqcvKSqClcAfBYIYkWKqwkXtUjOM4a
         x1IuOqaJZ37If7bT35bvHgR3EZNHfQX4+jROIFzLAhXQ5pAOWeAeHA1lubjEQ2FT4o52
         rbIf4hqF71maWXWVBUQiz1x+Dqla2Elt4xhwbwveJAOhcRqLxHIR6LZRcHoWWPTK/ivS
         32Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737222; x=1696342022;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fL7byGgITI5Pp0Gd+G4m6HpKfvXhtfMbVSSCjqe9VQ=;
        b=G3Tc54qQTs7iDAD3R1atvP0IvpIw0ucE36nDlgqJq8nafSrntaTQYkabOATYM9ZLVi
         RbO7Z+rmAN76IJmNvTnKb20WpEhGWVm5cXq5Cf66tTFvx+24pNc6cLscOGplsFqAu2HW
         HgmdK6sP90sFYK/CsPAYVm5EF5ci021wwnUGVR5BTuh6Ps2ouk+rk9dDGI2D2sqDV6RN
         D6KBWqhMN4RrvJSlSVp/8myAcj0kLBkWoXZO6/B/V8DZRhQw0SOIDwJ06FCvYruv6c3/
         a8H4T7gZrnfGsNXck2dA2kGL2blgPD6U78KbO1oyNrMHCR77TaRW0FHP5m1bSGldCXfw
         Gcrw==
X-Gm-Message-State: AOJu0YwvuQBZBmpcyjRtgBLApXrAOIgvlDVIvVRG2lneIS3cQfPmu/Pb
        rLJmZsmNJ3Lu036DLIKEHosYDQ==
X-Google-Smtp-Source: AGHT+IHrmM3RsXnpLcivnylPyp5TD1hIjaMqvfDzbaCd3y/aleld6b+go0DyjpPmtjDYj1lye7oReA==
X-Received: by 2002:a5d:4c85:0:b0:317:6ef1:7939 with SMTP id z5-20020a5d4c85000000b003176ef17939mr9042370wrs.23.1695737222048;
        Tue, 26 Sep 2023 07:07:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b003215c6e30cbsm14632256wru.104.2023.09.26.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:07:01 -0700 (PDT)
Date:   Tue, 26 Sep 2023 17:06:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3 net] dmaengine: ti: k3-udma-glue: clean up
 k3_udma_glue_tx_get_irq() return
Message-ID: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The k3_udma_glue_tx_get_irq() function currently returns negative error
codes on error, zero on error and positive values for success.  This
complicates life for the callers who need to propagate the error code.
Also GCC will not warn about unsigned comparisons when you check:

	if (unsigned_irq <= 0)

All the callers have been fixed now but let's just make this easy going
forward.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/ti/k3-udma-glue.c                | 3 +++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 789193ed0386..c278d5facf7d 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -558,6 +558,9 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
 		tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
 	}
 
+	if (!tx_chn->virq)
+		return -ENXIO;
+
 	return tx_chn->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 31e84c503e22..24120605502f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1747,10 +1747,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		}
 
 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (tx_chn->irq <= 0) {
+		if (tx_chn->irq < 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);
-			ret = tx_chn->irq ?: -ENXIO;
+			ret = tx_chn->irq;
 			goto err;
 		}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 89c0c3449d98..3c611b9aaecf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -317,9 +317,7 @@ static int prueth_init_tx_chns(struct prueth_emac *emac)
 		}
 
 		ret = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (ret <= 0) {
-			if (!ret)
-				ret = -EINVAL;
+		if (ret < 0) {
 			netdev_err(ndev, "failed to get tx irq\n");
 			goto fail;
 		}
-- 
2.39.2

