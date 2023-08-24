Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C31786E07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbjHXLeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbjHXLdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA391997
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so504903f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692876815; x=1693481615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT+3PtTEWwow+wvZw0jd3MVENA8M+HVZgmD6YM9pzZs=;
        b=qzfeJ6wS7TKcsaWDOdGCNO04aZT98Y1qdgzZt8seaXw7MrmvEQcgfM+MDHy0Q+4T3k
         aVOf7Ekbmo9Z3DRk4row2gD0VElkwqDphBZgGUhdX2jQvRZovjjGyrUIwA+Dr+1wHQHO
         Y+kPjXy34j8cOzNNNZ+x1FmrZpcaIO0H2M1Hl9i9tVqHSMZzWu9ZoUDQGBbRqUny9CNf
         G2630JQLIX6x7343CLim9m6zk7TTQJhG2aczDLGMrJnycx/Mjspwg4AxXssYJCu6Ve67
         v1d3ZoO7LlysXZQXQxcV11nA+ILKL+bfwZzEaS+ytDabQb5LG5aWywi32xcgYZFzhsli
         mPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876815; x=1693481615;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT+3PtTEWwow+wvZw0jd3MVENA8M+HVZgmD6YM9pzZs=;
        b=juUJbGmM6WpPVcXxMZD/dBD1wvtWYY8VicxwB7cXAR8kJQgKtsJp3L3J9/id+G4r3O
         wZypBOI0Bl9TLgJ/8kpHDaYgcSJj/94sMslLumZjU4yKS6C+gDzMIvHA18vHughv8gt4
         4Sz/Tjz5sgMiY/nyTnP/7u6a9KG3KbvkhLVnaowNju/r++6ZWrRVm/tukKQehPAdRle8
         LAtTPjRG0P4Wj21NOgh6lbRu5stTD2nN36wR4j8vFZkl3wY0DCmq9IWNFbIpU6pVT6DP
         Lm4mmtZ2yySQn2oVgnwuEuo/tT6lqvxpOYYQlFeXxTpQ+zI6Sf6qSdN/NU3ibrhxvKy1
         +apw==
X-Gm-Message-State: AOJu0YxCAywoaSiKW62BzqqdSmVYcb8n/rWQlZ3Qrs3RPtPeA0qq/93w
        Au8Dy0dmcg64Z1U6w6o9+8dMnw==
X-Google-Smtp-Source: AGHT+IEStLNUZ458nU+n7MPhji16NlK4/IAMBvZPbLGDl12OgwPwZ74622bDQM9ISblnXkvZc6EPOQ==
X-Received: by 2002:adf:f986:0:b0:317:dadc:4a63 with SMTP id f6-20020adff986000000b00317dadc4a63mr11316924wrr.8.1692876815529;
        Thu, 24 Aug 2023 04:33:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b003179d7ed4f3sm22063938wrw.12.2023.08.24.04.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:33:35 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 24 Aug 2023 13:33:23 +0200
Subject: [PATCH v2 4/7] crypto: qcom-rng - Add support for trng
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-sm8550-rng-v2-4-dfcafbb16a3e@linaro.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
In-Reply-To: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=inzVwuMARlcbh5HV8mDTw43aUJjgrQvAQ/pIfweiQCc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk50AH8nMEcPo71ueUkKxSD9CIiVFkHWu8XFprPW4l
 U0OF9UKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOdABwAKCRB33NvayMhJ0UgHEA
 DAu8DGfb+eUHnMWlyVwpItoK+XKhSCoDKRcF6x7mOwgKQX+chyG6UbnuDplIGGE9dv/gqdDfCveTew
 bi+uQtoSxAKiJdZbfL39LMnk2kyYFHNDNMyRgfNA7fWuD8L03JK5QaYIblf4HdHIY21mYOhdleohGK
 c6ztv+PfsPuzr9Gv2KwLy6BcU0nX1NZbUni5Fx9MwnmgLAEJCIXXIpIma+Y8SqrRq4/7yO92oY9ved
 DPA0eTQ939cO1KLcFZq62P3Aa6QexWf2lef/+3aoKfZWBtuhb3cBa51mcdcYVWE4wFsGfv5UI8urUD
 aXhVE5IS9bKBX/yhOrhtnbAAGaSl0pQX1RY9vJAPbnRTPzFFIRSlhtUjHrFWCystROKD4f70v8PjAe
 5cdV782+ixr0u/k5KzGheZcMiO/gAu1OQph8NyMumOktnBuw3pnnEM6V9WFjNBgZoXGsdwgjyXDEtF
 qg70OhqI+smFV/K0m0aQgem2bTpvXODQaAUA/yPuDp1qHFpRNP4s0cIOmtjjfovESkxHQ64qyq3Tk4
 VTX1OqNoGZZ1F7ss8FxxsLekfMKMHzzoVUwy39jqS1oQBC8xPAL7vpHzu7fZAoEWI7Js+86cC3W4K7
 eOZDTNg6H0CwJRvd+Iy7lNoNWDseRFc7ELyP3h7XKWTOFRUZo2T15zXbhayA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8450 & later SoCs RNG HW is now a True Random Number Generator
and a new compatible has been introduced to handle the difference.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/crypto/qcom-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 825a729f205e..fb54b8cfc35f 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -207,6 +207,7 @@ MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
 static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
 	{ .compatible = "qcom,prng", .data = (void *)0},
 	{ .compatible = "qcom,prng-ee", .data = (void *)1},
+	{ .compatible = "qcom,trng", .data = (void *)1},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);

-- 
2.34.1

