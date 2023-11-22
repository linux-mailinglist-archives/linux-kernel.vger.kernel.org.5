Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CAB7F5444
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjKVXJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKVXJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:09:20 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E11A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:09:15 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a94c550cc8so9047439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700694554; x=1701299354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGPBNCqlVNas6AbndJSN5DY6WrC0n52CMV5MihrDmb0=;
        b=b/xO5qees7EqkpwXoWTBlJQDwkyPae1Bap/fGD0Fipu5RkIHG2W6oApLYzpXUohWZD
         Lv6TknkduSPuANWvpbsIPmVXnUzu7St2MUn3IdEEeF7yC3WItp3d5BH7cv3N09JzqOFy
         4ChCRD0pIT1ZyvNatukLevgsoLC//KHllmbfIZnqaDhLEXPlpYACTLJUfe+A7YsIaBAB
         wE+6Sw8R8+MKwt9ftzXoqlPF4yyojvnRfZN/6q586uHBX5dgtB/E+qTNzYHt+cL8yP1s
         3VILge6YFxko+3VZQgyH8x5SMAMndeH1DEk8cQba8TAU4Pcf00ulgLTzO91FSRo/adYD
         8A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694554; x=1701299354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGPBNCqlVNas6AbndJSN5DY6WrC0n52CMV5MihrDmb0=;
        b=Rg78T8Smn9gdsNqc8M7N4kA+u1ybwrP1i5iT4hmId+UtIzGjYs6CkH/9GXED4gJnwz
         FJwFEO0tEiRBhvoZSZiowZsgM5orfxbnr3m/g7xfx7OUAZZEwbDM1QwqjRtYlgoxy9HF
         55RyilzckjzSvsNvU1OZ0kh3cq3LHa904tBRfdb4r0IR37cd9EXzMQj8QqEgjjWHkDU1
         SPkVyb5GQEw1dnvEmrIbqri1yIW/0fhJ8wVGqOUwegzHVSefBIjlpLrU8EmHwhlpr3l/
         kOQYv6y/yc2oza01HqEXKe7SSeOjmnFUn/x15eh5jn7mFiErCvj9SDIHZJjWfElZoRG5
         8ZXg==
X-Gm-Message-State: AOJu0Yx4nrP+nSbLufXmLEXaoSVECMTiTstusEustOmHiD7tztO0/IiA
        4vuqnf3NOwuoInnkmoB2c4mh5g==
X-Google-Smtp-Source: AGHT+IF7dOhUvqzK3l8JX28iP7y9sInGo8bawEHOVGUWubN6lD0OrylMu/vBfpWrPKRkI2Laj9ticA==
X-Received: by 2002:a05:6602:3713:b0:7b0:63ab:a2c2 with SMTP id bh19-20020a056602371300b007b063aba2c2mr4122698iob.20.1700694554628;
        Wed, 22 Nov 2023 15:09:14 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id fm29-20020a0566382b1d00b0043a20ad93c8sm117754jab.41.2023.11.22.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:09:14 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dt-bindings: net: qcom,ipa: add SM8550 compatible
Date:   Wed, 22 Nov 2023 17:09:05 -0600
Message-Id: <20231122230909.895482-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122230909.895482-1-elder@linaro.org>
References: <20231122230909.895482-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SM8550, which uses IPA v5.5.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 Documentation/devicetree/bindings/net/qcom,ipa.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
index 2d5e4ffb2f9ef..702eadccdf993 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
@@ -52,6 +52,7 @@ properties:
       - qcom,sdx65-ipa
       - qcom,sm6350-ipa
       - qcom,sm8350-ipa
+      - qcom,sm8550-ipa
 
   reg:
     items:
-- 
2.34.1

