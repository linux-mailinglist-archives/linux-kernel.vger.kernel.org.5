Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8A77F5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbjHQMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350616AbjHQMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:03:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2A2708;
        Thu, 17 Aug 2023 05:03:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so118125751fa.2;
        Thu, 17 Aug 2023 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692273779; x=1692878579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5VEfMZdJoR1mNUx2hBXldi+YDCIruL2v0+AL2aEWyQ=;
        b=JIYjdBuk4ITkBNqK67p6Y8hxOsbSJ7qgLDbQP93zCoXFrB34/W/zh8mj84yfW+eNW5
         +dIIxD46y5+xF3xucQsw0H+aRLVWlNjNHSfXqmOG72ggAmUZxN2pw1zPw03rjOTTL3y1
         9IyENWFTD60W9Gl/oaQkJT+lVcpdjA3CkG8EYRqiVsk3uCCgfYQJ6ZK7xHULaZRfTb+I
         iMU4Z0/zYphjoAjj45Jcj+lc/NRJ/UhdfW/BYFkISSKap/Echme9SBxNX6E8xqKwpW21
         YgKEbLSUXCxXibQSy6ZdiPFFnLmWL56l/MhHuha4Lu/b1xNxdgeratQZqbC7AndDQ3Fm
         bYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692273779; x=1692878579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5VEfMZdJoR1mNUx2hBXldi+YDCIruL2v0+AL2aEWyQ=;
        b=exgI9L9KOW1Kj7U4Hv5q783lvgVSdPFwtz53Blat9NWm+GRN7GHnisQofCJRmEfJM/
         LRbUpwmt+3w0Uq30JpVcJQmu9+fII1MajkO5NOSrqQP2DkZKwvD3ICTMYMkJ/cE8ASoa
         69xxFFrbTrcFGcOcYscmZf8XUDe7vbvrMu8+LR49QY/JPdhEtmaosEcdDLG5zYP3PZxH
         iEZL9CQVkkW02LUxXPq2zGqPFkF1U4jCVWvwpeJYOXxaxyRRXjCBY406JjY/Ciuw9sZS
         iMecTVYnoYNF+FSveZkHnDjzwISE/z03T+6iUvjU74yd7G9T59FzPZnRtkWkTHX1+VUy
         MJfQ==
X-Gm-Message-State: AOJu0YwgHjgMmQio+3PNNjmqsxMZjWOXJNDdO66KjoUKkMCnlesGGKxV
        fBBt24ICsMeuZ58uLAqf/tg=
X-Google-Smtp-Source: AGHT+IHLsuCIsUqk2ijtb3m9YzVWFeMNLRVfvozm2B7rCUwgRey1Y3W0Sgm2mF3myPV8nN9PgXRZKA==
X-Received: by 2002:a2e:9c44:0:b0:2b6:ccd6:3ec2 with SMTP id t4-20020a2e9c44000000b002b6ccd63ec2mr3565220ljj.36.1692273778470;
        Thu, 17 Aug 2023 05:02:58 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002b9fec8961bsm3981213lji.123.2023.08.17.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:02:57 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] iio: adc: mcp3911: make use of dev_err_probe()
Date:   Thu, 17 Aug 2023 14:05:14 +0200
Message-ID: <20230817120518.153728-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
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

Simplify code by switch to dev_err_probe().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - fix xmas tree order

 drivers/iio/adc/mcp3911.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..a6612d718bf7 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -466,6 +466,7 @@ static const struct iio_trigger_ops mcp3911_trigger_ops = {
 
 static int mcp3911_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
 	int ret;
@@ -482,10 +483,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get regulator (%ld)\n",
-				PTR_ERR(adc->vref));
-			return PTR_ERR(adc->vref);
+			return dev_err_probe(dev, PTR_ERR(adc->vref), "failed to get regulator\n");
 		}
 
 	} else {
@@ -504,10 +502,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get adc clk (%ld)\n",
-				PTR_ERR(adc->clki));
-			return PTR_ERR(adc->clki);
+			return dev_err_probe(dev, PTR_ERR(adc->clki), "failed to get adc clk\n");
 		}
 	}
 
-- 
2.41.0

