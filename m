Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B309777526
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjHJJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjHJJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31043128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso6349835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661539; x=1692266339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MndypYtimqWx47ssa6TipsWDywYZl6jKKyiOJ5e6wQ=;
        b=BgZuTsBnQIcEbiKxpCFTaYAGSE/pf91bMc65eHED0Ch2hhnsQucs14PtvTZOpNzEMo
         APwUn4TJpCnn7mttawJ5SNZHSJ7ZmaeNNFWTWgFtWUd+CfIHEv6hAg8KrYnLXhV5clu5
         lVErd0uADSlQr2r+1bxQU/bUFs5of4Gl0vOv+0k7xccf8z82TSo5EkzbPdZv7KYyWO7H
         vjdEqOBOap96GT+EARYW6ytXkDtwvdasVTMcgolpTz+7zAun20jEQsopFS2fHuwR5s+d
         ztGJ1Myt8wGu4hDu3A755hNpiVu3MnkB8CSKzIog8Su4Hphprc7TJBiIqt+cB6DlAbQV
         ygTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661539; x=1692266339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MndypYtimqWx47ssa6TipsWDywYZl6jKKyiOJ5e6wQ=;
        b=BkeuZ/uBJAFHEHGKs+Jz6xFxpLvex1iuU0Zqn48ZtUrA0pn47TYMiZvXwFZzbkuTt7
         t2f4aYki/oE6Uh/P1kVdWpaYoVHGz0x3DXSLqXwnp8d/q17a/WAKoy3qAFtGaZRdYx26
         SUieNMkjxZMu4KxlR8YazinARlnR/9Fxtv5ks33NHuQC6x9jVpEkCWnZj1We1BHfgbs5
         s+uFWAi8H8u3xNBhsrvexYnoDSCxXPcKi9RMdd7lMKZYyduzlFFmiUhD25k2E8WSCILi
         TAjylxZerbYFuptD2Qj0jirP2luejP7GqA8xWcG4z11Pw6uFTgNMJRrwZPqIdQB/wlSZ
         J0hw==
X-Gm-Message-State: AOJu0Yy5UXY1jjb3GaPlDUKq39CRmybEnKDn9lH5/lf+/Xi7FAxELnwG
        Ay6Ovr3FJBvi8XaLYWKUzApBwg==
X-Google-Smtp-Source: AGHT+IHVzJomICOvo889M7h65ixaG1lcUa3kKQExp6Cg6l/h2zj1FMty+G/XGFpNRnF9vXehctBCnA==
X-Received: by 2002:adf:e74f:0:b0:317:dfaf:827e with SMTP id c15-20020adfe74f000000b00317dfaf827emr1505852wrn.71.1691661538840;
        Thu, 10 Aug 2023 02:58:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 5/9] mfd: lp87565: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:45 +0200
Message-Id: <20230810095849.123321-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dev_type' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  lp87565.c:95:23: error: cast to smaller integer type 'enum lp87565_device_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/lp87565.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 88ce4d7c50a7..1b7f8349911d 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -92,7 +92,7 @@ static int lp87565_probe(struct i2c_client *client)
 
 	of_id = of_match_device(of_lp87565_match_table, &client->dev);
 	if (of_id)
-		lp87565->dev_type = (enum lp87565_device_type)of_id->data;
+		lp87565->dev_type = (uintptr_t)of_id->data;
 
 	i2c_set_clientdata(client, lp87565);
 
-- 
2.34.1

