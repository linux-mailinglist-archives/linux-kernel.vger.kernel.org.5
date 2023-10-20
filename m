Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088D7D0DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377125AbjJTK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377025AbjJTK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E99119
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40806e4106dso4024685e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799362; x=1698404162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uq/c1O+wi+Li74Qe8dqIPXwWq5ovqnWT6YA9szi7Fs=;
        b=mN8QUuP/+XweH1SoMTJQEyvqUoVGVrK6DQLYbEVMBuXn5mEDsn+iMFU1gKxpF1dIuX
         8B7WOarSVLK7A2O38jCuSy68vgsH+SoEpL/USC+nN7051WSSHfi1k5EHUrrQM2389skv
         plIQCtMEC76l7uOIZDgto2+XiFR/TyY9GsfJxf8d181FHir6P3hxUA5FgsQrmHg59h1g
         P4pmxYp3lwgG/UdX/wWuSQNwN76AES/ZqJh/S6bv5Mwgt654uLjCxvuAZw2Xb7xGk7uU
         idKRJbRYirqgmRE63PTcoB51gN9jevXsiK1N6jh4VIREoFHckCKtJeVnxAl01eQV8BiN
         p7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799362; x=1698404162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uq/c1O+wi+Li74Qe8dqIPXwWq5ovqnWT6YA9szi7Fs=;
        b=Tmi8pD1LzbcwWnRRGiXwvD5B7fZjXkNuohS5muFX5dmEpZdFgs2P3QMbzzEnbbx6vS
         oRZ1DvoDwR82QbNYGY/oDusiA8TMGME1stE/CSbClZAo7sbECr5gRKKwoN+Jj7SK2F5e
         rvl1kmhrBmRtouuRmy27+jDGqjchtntBdJX9upQOdt5j8iV5CbmnnqjuAZXHzm5UQZSF
         4GtJhm/wzH3WJoKlDJotrayH6u3yuGSsrwZTIXDo3Il/H7t4MIDRw0gbP8ptJifHc997
         /HLzTpJM3WKrMNxm6kPOgxiAricyU/8WdjVjlSNc4nLQ55t1I/UYk6Q5+tEKkM/Jih6W
         8DgA==
X-Gm-Message-State: AOJu0YwNIknM4kkOCJhPCwS7yKDhFEBSJEGxDGF7/GNeg/QQxghR+aUV
        ntxTB5S+kIKtBm1NIRjgxygHvg==
X-Google-Smtp-Source: AGHT+IG7PpN/tjXyv0xHLXNWMr2ATDIZzu5+J/2D2g/LohU+cWxtY9aJ/x2INvqbWGVB1+lKEBN7VA==
X-Received: by 2002:a05:600c:1d26:b0:405:3924:3cad with SMTP id l38-20020a05600c1d2600b0040539243cadmr1373735wms.15.1697799362557;
        Fri, 20 Oct 2023 03:56:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:01 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/6] nvmem: qfprom: Mark core clk as optional
Date:   Fri, 20 Oct 2023 11:55:40 +0100
Message-Id: <20231020105545.216052-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca.weiss@fairphone.com>

On some platforms like sc7280 on non-ChromeOS devices the core clock
cannot be touched by Linux so we cannot provide it. Mark it as optional
as accessing qfprom for reading works without it but we still prohibit
writing if we cannot provide the clock.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 14814cba2dd6..525be03b7bba 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -423,12 +423,12 @@ static int qfprom_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->vcc))
 			return PTR_ERR(priv->vcc);
 
-		priv->secclk = devm_clk_get(dev, "core");
+		priv->secclk = devm_clk_get_optional(dev, "core");
 		if (IS_ERR(priv->secclk))
 			return dev_err_probe(dev, PTR_ERR(priv->secclk), "Error getting clock\n");
 
-		/* Only enable writing if we have SoC data. */
-		if (priv->soc_data)
+		/* Only enable writing if we have SoC data and a valid clock */
+		if (priv->soc_data && priv->secclk)
 			econfig.reg_write = qfprom_reg_write;
 	}
 
-- 
2.25.1

