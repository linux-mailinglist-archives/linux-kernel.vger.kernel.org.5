Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6577477BE71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHNQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjHNQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BEE63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so6182211a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032026; x=1692636826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIxugXrkudBwSwc6x90Kd8GE84xI+CyYS+zoHyNssfM=;
        b=m0fpaX5MD6USYuxSoqYrgEr0lAO3hVgAQpPUKnxapwH/W0jATjQVYv5YQs0edsKVnh
         vYYpBU7PekSxfIXldmN/R8uxPaFSYFm/Hd04F+rjpsSfYf25KK26D8q5bixQdAy5sApS
         YeIf2lCm6GYS5unxqUNpyK+oXYHR8iaeAm6EuEE98Rb3cDIGdr2eFzlQBCw5/agDOTbw
         hVO3uJzhT/aBN288jNqwvqT4JnXsEQcTEdzzbnVk2Z0barK1MbGhO3jE50iubIEcUuaY
         3o9goSl2Zm+9uiYZsTXLLdVPj8kqdNt6h7HG5BdAbY7VxOq0wCurlKSmeJ2jk7F1gcYs
         UBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032026; x=1692636826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIxugXrkudBwSwc6x90Kd8GE84xI+CyYS+zoHyNssfM=;
        b=YjP8LyOswCOFb0+vgfsdUCZH4z+OHCZvrwxeNXFbZFKZwobnZWfUdEqddmskG75Bjp
         1gJiUvAnST05FX0fcnzJFb8UoPyeLgTSMeUWa7GEHMduP/WUOtu4ahSpNAwYixaNn9S/
         JY2RqBOV2TuNvtOrIzWqUM0l6Q18N0g312E00Tbu1u2Hs49oExL4vOgnOVR3a2d4upFp
         o9rS1eNQUmIEpsbBNH1OJAp4h/BTH0jKMs25sQ2ZLOP/1aKC8xcuYKkCz2vjqQQ5G4g7
         Vw/kt+Vb1+nrPXhQY36IBr9PE2HmCw6LZtfrTRZGTphwV3N1Yi7QqKBCzBH/6998YIii
         8v8g==
X-Gm-Message-State: AOJu0YzTGM2NHJG+7dssRV4Tzxk5CA+QnReydl7KoTBkCWZH3bvsHw9q
        KnX5YFP0XsVpV9OKeSX8NAOmcQ==
X-Google-Smtp-Source: AGHT+IFmj6Wp5rsKktLmY4h03gXfF8BklL2PAgHRNEmpLgR96wDcvqSDwzTb4lKvtEeWdH7MV/xBGg==
X-Received: by 2002:aa7:d852:0:b0:522:586d:6f3a with SMTP id f18-20020aa7d852000000b00522586d6f3amr6996555eds.6.1692032026483;
        Mon, 14 Aug 2023 09:53:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/22] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
Date:   Mon, 14 Aug 2023 17:52:40 +0100
Message-Id: <20230814165252.93422-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Matti Lehtimäki <matti.lehtimaki@gmail.com>

Document QFPROM compatible for MSM8226.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 6cd4682a167d..bdfc6d36a400 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -23,6 +23,7 @@ properties:
           - qcom,ipq8064-qfprom
           - qcom,ipq8074-qfprom
           - qcom,ipq9574-qfprom
+          - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.25.1

