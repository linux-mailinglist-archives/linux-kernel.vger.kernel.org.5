Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7C7C8618
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjJMMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjJMMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:49:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6BCE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bb94eso24842935e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697201348; x=1697806148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiaCno1Cki4OtE1E+EgTilOhT2MrMJ0BC3Kv4Ue7uvQ=;
        b=rzPdHBxeAGqbNZGZyJI2WnCU1yeRAqEwP9+mzlaqLHVFJV1u3eCZtc7l7vNbrfLmhd
         n12A8pskiPVyNlRErbEo+08Qhoz/SXaLKqLo8lCOBEtmXeDw6cbkjwx6CgbuOYERy38b
         Jy7YCS5mqTfdiSxy4obDJmy68I4C4Lz+Yc8yebpqDpVMGXThIvy+GwWhue7w8c2d/fe1
         o5zZIgThBl2wULrkud4ArKV6NIvWK68HhElNTTEbty/RiB5OhMgO78e6fz473c2OKSeV
         4HciuhIyDQp1arMfTeKQ+rG1/kkUJRZM75k/9KPOIwCb4ue8Yf2+v+MdrxRhSfm2v4tq
         x/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697201348; x=1697806148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiaCno1Cki4OtE1E+EgTilOhT2MrMJ0BC3Kv4Ue7uvQ=;
        b=LvQfDOmQ3OQ9baDLDB9qrbSC8cuxok2h12PVAfoQlwmBUb2lLDz905Fv0UNCSC+yBu
         SmFUYmZFD9xyd9bYPAlv3ApC2c6D5ww+ghwbTrCr49Pv8z4nm7R/jMTq46W+IaDoJa3V
         Miy2mavUVcKoZNgmyfdRaz3dar+KNopktqyRo/ASpUKMuek3N2IMZ7ZA1vnDUersuATm
         VKj7bu1sAR2qPHyZiaac/uwemNDJN8tOJHqSd1zWPRRu4jyb7xFMxMJHaDe0nKxoNC2I
         yE1L3bHD9IRqq4f2h3pcNCn5DktNlDWm+PGNhs9mHwgIY9lLq7znx8QgefITAygSfzD7
         iEDA==
X-Gm-Message-State: AOJu0YwuMs4WC4ee+WxHEmBLsqwb0XVxIxykQEju1oz8xA8moBBklbrR
        ZR85Q5a2oZhxbUwKBWp1A7NDRQ==
X-Google-Smtp-Source: AGHT+IFSAWeADK/LylWFWR5v+r/zgZoQ7OqvdDN0xEJIePMxiVodt8PPRIFgMAeTmtGHfhDKm4qPKA==
X-Received: by 2002:a05:600c:296:b0:405:3d04:5f4c with SMTP id 22-20020a05600c029600b004053d045f4cmr24657674wmk.38.1697201347982;
        Fri, 13 Oct 2023 05:49:07 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0032d81837433sm8035438wra.30.2023.10.13.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:49:06 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: imx: correct nregs for i.MX6SLL
Date:   Fri, 13 Oct 2023 13:49:02 +0100
Message-Id: <20231013124904.175782-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
References: <20231013124904.175782-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=VXzzuBjGovIZdjKOBAafd6q8qna2BkyWeVmiGwnnsPc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlKTzA8bppvXB9FnVMC7R/ZD2Hr6nbkf2Dt8Hps rwFzYqrkY2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZSk8wAAKCRB6of1ZxzRV NwZSCACMkgE92fdpQe3WnUoRls6kZnM/SJCgMZrsJXSWhYgKPNYLxynww1zwWLlys2HS9XWl+Ly gMXLnXPvh4+VaRr4izwUKZBVmyVKSQYO6jIlPcyUg4BdDlZ5xk1D2W1aZETYnwRrkXeOVpC5bAo OyYndcjVy6cxQl0Wo7wyf7u+zhG/rt6BFpDFNOE5R3vA9bPKz+oLSVdQPaVwamtA8OvM6nWogSW 4747y12HyErlXwrXEtdfI3b0jeMgNlFBl/f3EBQTOOjjjAgXpi29UJfvDmG2xIOIvE2N+xNzI9P c05+ibZZVAzTJ2AXSVZqCAaDfMQAUqQp60mlyeCuk7hj9CcE
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
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

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6SLL should be 80 per fuse map, correct it.

Fixes: 6da27821a6f5 ("nvmem: imx-ocotp: add support for imx6sll")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index a223d9537f22..7302f25b14a1 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -498,7 +498,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,
-- 
2.25.1

