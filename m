Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD67A369B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjIQQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjIQQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:41:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC8ED;
        Sun, 17 Sep 2023 09:40:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31f7638be6eso3571179f8f.3;
        Sun, 17 Sep 2023 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694968857; x=1695573657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeueOuoVmZw39cDuG06Cps8ippAl5MH5eqOWbaiqh3g=;
        b=TH8UdH3kkLSkJhxPtP4i3HsgVHkgqLeJmYY8bZINLmHF/LqKsHnWEujZE43zcfHz3k
         3V8qrFourTv+Q5Ep06GZl/20NIIbtUFXSepNk0R5snenoL0h8M+4cW9DupyrRJ87RnQp
         S/gAn79KqoTX90DQBQYqSKDs+CagqltpOKysk4c6CRj41MvUTkS45y06uZhhXhassJra
         czokkwiawiQXczUGx8f2YgPL2NTxkX43lmaKTW+7sbi3GsWlb2V3h6soSW1Rz4XJMm/W
         tYPi2byUdLSqBy9qo4DFftF7SLsripbDYyw7R8LcClN1PjbeTudVYCA3IjHVhAwu+A+b
         ldmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694968857; x=1695573657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeueOuoVmZw39cDuG06Cps8ippAl5MH5eqOWbaiqh3g=;
        b=UXndguQL/2ZNm/pkAkvE9/8xyWf7w7jNA13QPg5mB8USFQEIzVFMThcZel6FoI9MFk
         xvgGEfbXxqmUVXMN96eKv+gEI/lBroQwyIpUPBjumHYs7eNEONJChsIbffWWvBL/l7Gz
         /Dbly7n0uXnkEnBXfLmglDHVGzEZEvS8plgzPpjEaUKx8VOrQnvh+92d6S4IRpfiHXyp
         ixtishFoeVcRLslW7ioXOeqsuCGk48SN6c8LhNTPB93qUgo0H0gET+auIGFBOwO+SKzC
         F9oo7Jt4gqzZETs2C67d92TKZf4JUFm6qJvT1gzoGO3PuBN6bIj7xsMI9vYX9XOV8HnN
         SVJg==
X-Gm-Message-State: AOJu0Yynky6gS0WyE04aOnfocYpzWrSj5WkQRC5LhiPgUufF0PwVKTZp
        MaETn9p9DpFMEBa0Az9I2x0=
X-Google-Smtp-Source: AGHT+IGTqIGzd6ml6FDFPMOmxfNyieEjeC/D/9aiVZaJI3bXyy9mIfH61JwcHIOVEReS3zCv3OJiCQ==
X-Received: by 2002:a5d:5504:0:b0:314:dc0:2fca with SMTP id b4-20020a5d5504000000b003140dc02fcamr5756561wrv.29.1694968856668;
        Sun, 17 Sep 2023 09:40:56 -0700 (PDT)
Received: from localhost.localdomain ([109.38.142.63])
        by smtp.gmail.com with ESMTPSA id jl6-20020a17090775c600b009ade1a4f795sm2879205ejc.168.2023.09.17.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 09:40:56 -0700 (PDT)
From:   Stefan Moring <stefanmoring@gmail.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronxi.de,
        festevam@gmail.com, linux-imx@nxmp.com, linux-psi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sre@kernel.org
Cc:     Stefan Moring <stefanmoring@gmail.com>
Subject: [PATCH 1/1] take in account bits per word instead of assuming 8-bits
Date:   Sun, 17 Sep 2023 18:40:37 +0200
Message-ID: <20230917164037.29284-1-stefanmoring@gmail.com>
X-Mailer: git-send-email 2.42.0
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

The IMX spi driver has a hardcoded 8, breaking the driver for word
lengths other than 8.

Signed-off-by: Stefan Moring <stefanmoring@gmail.com>

---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a8a74c7cb79f..498e35c8db2c 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -662,7 +662,7 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 		if (spi_imx->count >= 512)
 			ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
 		else
-			ctrl |= (spi_imx->count*8 - 1)
+			ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
 	}
 
-- 
2.42.0

