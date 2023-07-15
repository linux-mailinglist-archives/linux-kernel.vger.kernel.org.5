Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE427547D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGOJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:28 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE33C04;
        Sat, 15 Jul 2023 02:20:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso24938235e9.3;
        Sat, 15 Jul 2023 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412805; x=1692004805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTMQVQh48oncaObvCwMPfvKa0bWzXZnBK799pHg2Dv0=;
        b=OFu9BuALKJBZ4n3EogoL7nsJNvnyesWVGC/L6lnk9wsFPZKW8sL2ag8AMcIyg1sUiK
         +oW0aLrFNsQWBJfLLo4A5yY4keb6z6S9nESDOfzP3q0hFRs1VHYrkXaF3ieDIaVYotYY
         JJMdP4Nn+bNc4JkwzDpE8smQ7Ek/+91skCYH6Yfm7fRQGiTbcn4PcTp6BWX1WsBHDlPo
         xH6Os0z6Yetw9jMgyC3GesSh8cZ31eO9/E/gN6T1CxLm6sNkbFXZF4m9H7rM6jWu8hBK
         X92G4vDun8SgBNnOZQ9j2FIoqxcgZ9Bm1gr33cyTZBHOnHCmgiRj7mVLv7nLxqh/IfPm
         zilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412805; x=1692004805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTMQVQh48oncaObvCwMPfvKa0bWzXZnBK799pHg2Dv0=;
        b=Xh0hxEJzfCPJNz+KbPmQW4NZ3m1SPfpk8hTDTxKuaOigjUjCncfTQmHFZOx8zsL2f5
         gomwztQFfev92Cla8SBs1ShHAn8UrrfOVT/fKsZ51ECptgHSrIVuUFB8IqLE2legno3d
         vdxVAR0WqqqEwFP+cbCLZRVgHi1B3o3fBdx04SFjEUE6rqLiAHlN7rRwCg1koUhsnH15
         2UVi5XnlTdNlnmiUWNT2s/u9OeywqINgNtaVJaQG8O6xJ1lGkNUMEA1N61gSfGfCOhKL
         ogsmrIlboBD3wc54WrYf5cvzw3bJMBTdj5eT3p4ztV9ey0qQlJZMYukUQmdY3eQDlV/z
         Vw5Q==
X-Gm-Message-State: ABy/qLaxcKzm0tZMmAQtnFRqDU/rbevi6jXLK6MaZPpe6O3A/uzzVxKA
        cNUdqRC9l72Gb52Lds3scZ4=
X-Google-Smtp-Source: APBJJlGe5WNlzAnZQnjWkBYvOFkemYCghTl7dvPK7vHmlZd5JnAx/H1GUb56PQkGy7CW4yfbMSjROA==
X-Received: by 2002:a05:600c:247:b0:3fb:b6fa:9871 with SMTP id 7-20020a05600c024700b003fbb6fa9871mr5184620wmj.14.1689412804527;
        Sat, 15 Jul 2023 02:20:04 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:04 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/7] soc: qcom: socinfo: Add SoC ID for SM7125
Date:   Sat, 15 Jul 2023 11:16:10 +0200
Message-ID: <20230715091932.161507-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715091932.161507-1-davidwronek@gmail.com>
References: <20230715091932.161507-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID entry for Qualcomm SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..785b88e2da54 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -371,6 +371,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA429W) },
 	{ qcom_board_id(SM8350) },
 	{ qcom_board_id(QCM2290) },
+	{ qcom_board_id(SM7125) },
 	{ qcom_board_id(SM6115) },
 	{ qcom_board_id(IPQ5010) },
 	{ qcom_board_id(IPQ5018) },
-- 
2.41.0

