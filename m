Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF317547DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGOJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjGOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864E3C02;
        Sat, 15 Jul 2023 02:20:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso26956575e9.0;
        Sat, 15 Jul 2023 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412803; x=1692004803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnVCby4OzPzkMY2F/B5v8SGADAGIqKWRP6OZFHSrWRw=;
        b=VkQi3RlvOhFSRYWKw9dMDmDiqjbmiZddvl4R4S0nQcI2Pu4uqN4elqX9SgHhzOcI0y
         tgADBbSRHXHN3JVd8DsmjRgOKOS+Bax/HLZ9nwH1xqntRMjQSNAYB5ppL6IiygNA1WMf
         Y6dnX/CwUb74MA2zyNeHw7Kv3tM9tJy3jdE1RM5kIwerLk8v89UBwN0yjC+aZTnVifMy
         R+jcfNs5Y3WWlyfQiOO8VC/EdHIU6vzxOweqxzbsnjRP6criyvNDyLMkI5Lalz4l2aH1
         AfbMq1ez0Nna51Rc5oC7YA41IBeQAQBaDOiYMeGMByqZRaX3jq/K2O8tzyg19H3uRDct
         eigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412803; x=1692004803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnVCby4OzPzkMY2F/B5v8SGADAGIqKWRP6OZFHSrWRw=;
        b=Vc15Ze8ab5losw/w2OKKTUAu/PL++14OMnZVZV3WR1cAjVdrXKHvlv9arynOZLCAHM
         sYpF0GtMwdUntA3UCDIiO6iVipRWwjH8dEIpdfBTWO+FQ4hhUBXHtxHDwjEsUvXaeLFs
         haONzYvIV6/1RhsSbbA36zVNDsmpoDCU9Wlgy2rWxkroKGGIeOgRAou7P8hKNRVLthj6
         HWSec+M0sPi0tU3P/ZAu6zCFyELR4yIXG3VnDP1hhXJsluzdTVcbj7X18HU4twOxqWZk
         W8OUhy8cldB1v3s3GBWPATvgIkICOj66I92P0eF0RD5svtHgcx25G5Jj+Z8qV6Oj7erQ
         4eOA==
X-Gm-Message-State: ABy/qLZMB/l9g28vWt9mWX4c1MyDIiyLa3nsMIC3RvtQnTOm7XJtzgvz
        9KqmFSFemOgGJB+So5pa4Pc=
X-Google-Smtp-Source: APBJJlHephmSGNo6yqNxglL8a1kuciWQYQvlLXQHxbUJ7SvTRxdl6PXgHC6AvEI3g34VvK+WvYHMDw==
X-Received: by 2002:a7b:ce08:0:b0:3f6:1474:905 with SMTP id m8-20020a7bce08000000b003f614740905mr7127494wmc.29.1689412802500;
        Sat, 15 Jul 2023 02:20:02 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:02 -0700 (PDT)
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
Subject: [PATCH v3 2/7] dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
Date:   Sat, 15 Jul 2023 11:16:08 +0200
Message-ID: <20230715091932.161507-3-davidwronek@gmail.com>
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

Add the SoC ID for Qualcomm SM7125.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index bcbe9ee2cdaf..6a8dd2e42b24 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -215,6 +215,7 @@
 #define QCOM_ID_SDA429W			437
 #define QCOM_ID_SM8350			439
 #define QCOM_ID_QCM2290			441
+#define QCOM_ID_SM7125			443
 #define QCOM_ID_SM6115			444
 #define QCOM_ID_IPQ5010			446
 #define QCOM_ID_IPQ5018			447
-- 
2.41.0

