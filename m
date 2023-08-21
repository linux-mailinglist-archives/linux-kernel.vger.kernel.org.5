Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA10D78249C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjHUHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjHUHjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:39:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A622AB6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:39:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31969580797so2704570f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692603562; x=1693208362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvvoCNPW+SPRcYYFwV9MJHrYmRpChy1Zulkziz81bAM=;
        b=x2eWXFeTu5MHKU89TXv9JrRjOoc1CTwPTNzlOGzEZI3irDjcKFt7cutfQx9w03ONAs
         AYVL2DIrZ4shaNnxYsqZoO4P601OSjmcg4vegiQNsQmt9aIzSRCDZJyY9Sa2YFLVXn0N
         QgDl5jzbrHH6w8FHZZOwmWZ21yFYu4RneGufQPdA+nWOiDhIUmgNFjYsxm5jNbbVwLNZ
         bvKGfUopbMBO3oUk/iMJ97fQ5KBpfBLkJH7KiEE22xOCeCus/FxfSBkzA4s2/WKZ5d1y
         mQeJSV04jrVZlHqvqV3NStTTiNHkV85ZikWtyvOBveBCI5A0tuTrDZioQh5/pQPO8OST
         dAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603562; x=1693208362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvvoCNPW+SPRcYYFwV9MJHrYmRpChy1Zulkziz81bAM=;
        b=ktJYeL5w0KpMqVpKLwjMrVKl61dOCrCwkRlsWdpcNb5F6RHjtLs1eGdYg5wLUuOMmI
         frovms8AcGaQ5jD/7T66Chd4rMWxIzTfxO1nQMSlgKWehBfDaNGxEMl+KubN7e7dgjmr
         fh/FTNUPMEnSbqrYsdzux6XmGCAEpwpToPQhHHUFf0N21sJ13F/bMmlvkqU7DXQC9TfN
         9XLD6CHeB3kyahqXzzBqOH6fQUv/X6fG2z4SoROak65uIhFb0mIK8v+V3t3Tttqjq6ks
         r/977rXrVH45q8L47hDjswlxQWVQ/wLDotNHklTTBQ2q54H2DQhnwTUjo687fN61H75s
         KX+A==
X-Gm-Message-State: AOJu0Yxb88pGHhFYXQPbFZ9OC5gJP/6/t8IzuZUhmlnuOdCL0ZDwuCJx
        vQZkIAKORK5lV4zyzXoLCaJ84Q==
X-Google-Smtp-Source: AGHT+IF4j6QeqYufxtGbUEOkc/Nkhwz8mqyHPHwvtvP9BNxajJLbbNv3/UBHGyhuH3OdYq01+HRIPw==
X-Received: by 2002:a5d:62c1:0:b0:317:3d36:b2cd with SMTP id o1-20020a5d62c1000000b003173d36b2cdmr3262181wrv.71.1692603562192;
        Mon, 21 Aug 2023 00:39:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l15-20020a5d674f000000b00317909f9985sm11389092wrw.113.2023.08.21.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:39:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 21 Aug 2023 09:39:14 +0200
Subject: [PATCH 2/2] cpufreq: qcom-cpufreq-hw: add support for 4 freq
 domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-2-2d4d9fc828d8@linaro.org>
References: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
In-Reply-To: <20230821-topic-sm8x50-upstream-cpufreq-4-domains-v1-0-2d4d9fc828d8@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=624;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+ViKGeswVL4o2Q9cF3Vy+0/WfvsqhuHVeAFaB7hburQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk4xSmJ/FPW3Sd/5m1YXYjUbVaegwRAzN5pk9mZYIj
 dI5sbOSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOMUpgAKCRB33NvayMhJ0ViIEA
 Czrx3j39jJjBC4e3U2Y+AUtghL6IM7R8X1UcK5QmQe+JvnnXsfiT389xaqFSZWgip8hL8CCZbQmpW1
 qJOVyJ8JwjkM+XMdanrovLXerC61vqWbwbWd4pxo46tG5D5VbucNt4I5o7DjKMJrmksFASqHEsaIfi
 7uHN5hh1zujEeUoYmv2n0u28hO7cN/dUY+VDguYcO3NYO5PSEY4qe++av4J+WEfi9j9Y+eh0z7nu1L
 ZgEXdxaFIjl0MyasgLGFf+u6o9dik0c0BnkaowhBUAyC3j/R5sLWX+rETpo7o4eXGX13FVuWl8DOgm
 lJ0/wuXUKIIOyS78d0CB+xp3nBnTLa00EfR/ayelrp3DUELuhRKevanpAXQvE3quzVEzGFOvh4NIYD
 mGxA5yk73tBo/c7pko498Dz91YXALFrCfNxwUsxqQ9LlKJUv6v7txcBo6PSMMat5KO0kO3jPuCv9pi
 HcDmHTeIpoIYrqy3rGXq09j9FVHz5yyhI0Pa6rfPzm+8zEEx9lkSFxM4bFQOhPr5tkzsOLAwwcOIHl
 SynEF2FiOoE4HHPLZacnUVXyC09AI2JcumX+WDPJ3yL8zZE6T+KHZy647kok7C0mPmXGt2rAxPQ+bt
 An8ac4VYKINXF4LymDTylQdBqIrhHY9OkmvX2DdfgCNtFQgdkNGWdy+uibNA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for up to 4 frequency domains as used on new
platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index f24cf2eddf1e..70b0f21968a0 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -28,7 +28,7 @@
 
 #define GT_IRQ_STATUS			BIT(2)
 
-#define MAX_FREQ_DOMAINS		3
+#define MAX_FREQ_DOMAINS		4
 
 struct qcom_cpufreq_soc_data {
 	u32 reg_enable;

-- 
2.34.1

