Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F32777525
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjHJJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjHJJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:58:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D74E0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31783d02093so706031f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661535; x=1692266335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT30MW4jzOeQi1uZyE7Ccpk1TKZvogpCYUy/NOvSbr4=;
        b=AJWA9DjnuW6YJYPEhAurKTlb9MzzWpjanEuGmxAhIcghAxzAJj7cy0gLt+n5uLkKS8
         6jWGVQAgR9ofnRWZLJpcr/Ihz/+MZaiEZUdR9KNLCbXiwf7vZMZaFMVuy5JEzEi5WptB
         O27JpOfWnh3XuMMbepD1wCALaOytQKI/OM+Lk5wwKnlDvCCXlh+nCu+wOH3OXJRbPD+3
         poOhQyXLn+ylCJ9XmnDkuCLddpTMe/9jPqFHNzoKyUIy8Ch03Ll501sfzFAGxkOVCwHg
         9KroNgqx5Zipbm8KzYl/k6rqXe1TwA68AukW+4bYi0Y3aajsHmfHk7mp8zFjzocizvIt
         im1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661535; x=1692266335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT30MW4jzOeQi1uZyE7Ccpk1TKZvogpCYUy/NOvSbr4=;
        b=kc6LvxF8JHPNIahDVLQU+LOtquNcf2yjyy2Av+96nOreV3wr4tdV8IB6iJuKu+oVCE
         VgR8I+Lkn0NdsJz8HlmA2IGeX412ExVAW4444TNwX0YAimQfnUC7tLgbdQIETV2923z9
         KDx4vI+eK7w+8SEtEPjVHMYfPv1+qJn/DRqDTzM6pvruOz/NZDFlgGj7sTt0K8Q7La9P
         c95O0/5rgo/lLNKYsJr9w83d22wl6pLsoqBm5A/HN0sgmo9+LiHg34ZdDFsPagD5gZp2
         IBECnxGPtdGjD13ALZwkRJv1W4nGr4nRfoAlFV0dnHUQvD/cztrmn0iNj4p9c3OHmcng
         DTRg==
X-Gm-Message-State: AOJu0YxBbrL2vdHUVq4VScmxw60CxDBN4NJzLAEdBGGfntRTp7akAvK8
        SMeA+1dORRu4Rdcpy8XbtbSoVQ==
X-Google-Smtp-Source: AGHT+IEFVgI7lrkYa1atMPu7ocBsjYe8mkIm4LQuqGXlcvMqYeI3ii/7xo+wgL8Nj+yvoj43cJFNxQ==
X-Received: by 2002:a05:6000:8e:b0:317:6849:2d39 with SMTP id m14-20020a056000008e00b0031768492d39mr2015146wrx.10.1691661535636;
        Thu, 10 Aug 2023 02:58:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:55 -0700 (PDT)
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
Subject: [PATCH 3/9] mfd: max77541: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:43 +0200
Message-Id: <20230810095849.123321-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
References: <20230810095849.123321-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  max77541.c:176:18: error: cast to smaller integer type 'enum max7754x_ids' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/max77541.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max77541.c b/drivers/mfd/max77541.c
index e147e949c2b3..10c2e274b4af 100644
--- a/drivers/mfd/max77541.c
+++ b/drivers/mfd/max77541.c
@@ -173,7 +173,7 @@ static int max77541_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, max77541);
 	max77541->i2c = client;
 
-	max77541->id  = (enum max7754x_ids)device_get_match_data(dev);
+	max77541->id = (uintptr_t)device_get_match_data(dev);
 	if (!max77541->id)
 		max77541->id  = (enum max7754x_ids)id->driver_data;
 
-- 
2.34.1

