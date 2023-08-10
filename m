Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF4777528
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjHJJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjHJJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A21B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so6061455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691661540; x=1692266340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFuO5hxxZfdPQonjF+3OJq8vcIVSzlxg9gVUs4JTzVc=;
        b=s7ppzoSXQLQxBtitHlQtQUbeSWBZt39Nydg9EJcgmTYLu+1Mfx9sgXrzRAYNULlsxM
         k8DnnJGF1oHjf0125Ac/No6SiAS1nt6h6RWEkG42gs5RBOJbJ43dUKUsJ7bGBuAl87z1
         A9e5FRmOl+wM9VxY7+Av/Mz7/RBUbK2TQeyXPSe7dl8caLPOjdWplXwVLQPArjgevCFl
         9pW4sUG8b983mK9kAATsVq/gEeWEm2LpnF8m4vIHqM6LucPO0bLwv1oNyi24hrmouByb
         PDUR8MfR/MhPvH5xGs60/uco2WBE6EA8q+G9QCpop2VodTuQ2wA8rkWoZK+YYOKFq1m0
         ESCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661540; x=1692266340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFuO5hxxZfdPQonjF+3OJq8vcIVSzlxg9gVUs4JTzVc=;
        b=jewm5tC3jm/lAWa42JRJmmYd6tV64me/2IUfZRdc0Y47U8mI35GqMERTYwZXPgu4ZB
         vxO9SrUlww6L3AGFqu1FkNp3beXsaZKfQZ3lD1YPOGx+3ukr/9zeyh1QGAtzD8WR+IDV
         bJ/3SkL/aiAv20241a7V2AoC+8jY8GcEcRlj1ZSEhp2Dxp7v8Gu+3kEcksAWz364XV7q
         HGU/E/U7b7KeK7CblekOy2bZh11iGb1gwJhaL4L/X027e1x8PBiq6yrHYif0jwgAVY4+
         xLGBdAUyaWPg79bfyOqzbDPIxKDrhchQv8awVfYICTvpKbYeQnZxxCL/adDzln4IqUOd
         h8eA==
X-Gm-Message-State: AOJu0Yw7CM/ac1Vgv6NwkCTXwyDZCt/wRRVfMvNqzcsf11aRNAfG+suK
        dB2YCDv+IeO+p5ZgJ6gYkA7tOg==
X-Google-Smtp-Source: AGHT+IForamv537Mzb3auqFWpWhZvSzFSsI6c+QRtf/dRFBJMkYQoT92gxmF1fSxOMILj0xv468ssQ==
X-Received: by 2002:a05:600c:450:b0:3fe:16c8:65fa with SMTP id s16-20020a05600c045000b003fe16c865famr1544464wmb.4.1691661540340;
        Thu, 10 Aug 2023 02:59:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm1621372wrj.33.2023.08.10.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:58:59 -0700 (PDT)
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
Subject: [PATCH 6/9] mfd: tc3589: Fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:58:46 +0200
Message-Id: <20230810095849.123321-6-krzysztof.kozlowski@linaro.org>
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

'version' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  tc3589x.c:343:13: error: cast to smaller integer type 'enum tc3589x_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/tc3589x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 16df64e3c0be..1a6ab8e7a614 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -340,7 +340,7 @@ tc3589x_of_probe(struct device *dev, enum tc3589x_version *version)
 	of_id = of_match_device(tc3589x_match, dev);
 	if (!of_id)
 		return ERR_PTR(-ENODEV);
-	*version = (enum tc3589x_version) of_id->data;
+	*version = (uintptr_t) of_id->data;
 
 	for_each_child_of_node(np, child) {
 		if (of_device_is_compatible(child, "toshiba,tc3589x-gpio"))
-- 
2.34.1

