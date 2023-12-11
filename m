Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBD80C9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbjLKMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbjLKMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8648E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so21228565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702297874; x=1702902674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcGVygFqpR8Db5zL41FG9Nnjti+dXKsBMHzFUY86aEI=;
        b=OjRKB1P/OCXA1hCX7YrA9h7LtY8YUBZkI2tF/2rnBJBpRro0Lgx0HXSYm7Yy4IxG6V
         JiEQYna24C564wr8/OGuj2N0WiOKzvi7tCR1dZ62SS8UH4Cml9uTLugrYi4DDzzKtofx
         Os6DVPxo7Bj/aQ2JQ3eLvFd2k06b0wR5b+wZYEuWSoVkrSW27ZdRMlBcRvzU9So4yFDq
         i1Y202RbnEdEIo8dM2zWb9MsLYAaah1X54d8dnZjW0ryuyLO5KWrGj6SrhDejeZ9K8m4
         GF4lseUmSNQrQdX8O69smFNHWNb8SGjU9cJuQ6bsdkgIPTDfMuQHXhq8yXasUafIleyA
         1Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297874; x=1702902674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcGVygFqpR8Db5zL41FG9Nnjti+dXKsBMHzFUY86aEI=;
        b=rkLDhHNp6IuwcndnYSR3eFe3bUr4efngyyLpeaWJf/vCJ7WpKVHmwYUt0HTNbULOU8
         ijPs9BtgnegWp2uO8fFekhXu3KNvzfSvpnRNRz8R2ni52ACPxsmLZKO3LwVp24vq9Dm/
         Fmpt1GCubS0VdCQrVjjnmn5pn4ETq0KTQytw0mpHa52hvfAJ9bN8nmRxcvaoH896BShC
         x0oyaaT8Y9j8DVLes+UDQLxCr1a5En0QVpLfykeM2mrTa8nIs/b+41VhAC1VfCG1nv7M
         sTGzYZfMR1nBYOdh3aPOxn0RRrvZ9aUjTXAVXlxWIQFNRu/yxoSHTALpasSLp+3r9MPw
         LH1w==
X-Gm-Message-State: AOJu0Yy8awcPUwUx2qhTkKPptXPecsnnC3Pnxi0FwURYp9xiqokHdcO+
        xwSlkFZawBVw1R4r9M0AYiQEEw==
X-Google-Smtp-Source: AGHT+IEgRmUvqRfWL2mgGWOrAr42GAbQoTNF3qLYb8HpdTObG+vmkW4PZV39SZlVRZ5xK8rpQ42IqQ==
X-Received: by 2002:a7b:c456:0:b0:40c:2c0e:3196 with SMTP id l22-20020a7bc456000000b0040c2c0e3196mr1221840wmi.19.1702297874408;
        Mon, 11 Dec 2023 04:31:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm12932313wmr.5.2023.12.11.04.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:31:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS WSA
Date:   Mon, 11 Dec 2023 13:31:04 +0100
Message-Id: <20231211123104.72963-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
WSA macro codec, which looks like compatible with earlier SM8550.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
index 5fb39d35c8ec..06b5f7be3608 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml
@@ -19,7 +19,9 @@ properties:
           - qcom,sm8550-lpass-wsa-macro
           - qcom,sc8280xp-lpass-wsa-macro
       - items:
-          - const: qcom,sm8650-lpass-wsa-macro
+          - enum:
+              - qcom,sm8650-lpass-wsa-macro
+              - qcom,x1e80100-lpass-wsa-macro
           - const: qcom,sm8550-lpass-wsa-macro
 
   reg:
-- 
2.34.1

