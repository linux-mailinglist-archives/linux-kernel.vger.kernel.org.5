Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807D80C9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjLKMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjLKMbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9978E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso56565985e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702297872; x=1702902672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fHF1MoshH1NMiiExL+9DYVxymX7ra4O3Ex0Iu1m030=;
        b=IIejYrFlFrmVT3QZWhYH3XRkWGNe0UaJSHRVTFMTr/gQEjO+bxmP/8NIW4+ydnc/MI
         +WQ1jOkhKlhasY7LfBQRBBMwE07x2+/R1gQnsbqhrT1qdzhk+qyZZvDla6IrMDY+8s74
         +NZ+tkqoPO2PKLufFsbzjHwfJFy9/baBLFob2paodWnkjForSZqhaF0LFEMzUcBfolG5
         7b2ESMFnRs1hOHsd5C2re/N4Q8mI7qfml5CGNlsU9L4qqS9v1v25iaXl/nVSf/7TxNNh
         oTv0FDwa/f/2sxkPdzdtiP9V7FuNEanNE/NAElA/89QHEN8AoOZY2RmHjb64p8H+cWSP
         7PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297872; x=1702902672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fHF1MoshH1NMiiExL+9DYVxymX7ra4O3Ex0Iu1m030=;
        b=A0DXlwj1P5US4Sl+CauQqw94uX/Q6zgopRb+ZDRnecaMG0558GdRWeKXYKG5GHQirG
         vqMcWXf13QM1GvLEtgb1gbhdvubjfSudVQhLy6Su8a5W9UQ4TeMzh9h/wVwt5BQUb4Db
         cpbl8p1xCPSCibgSObok9VjgPXsx2bv3TgpzmjXyilaLFif1/fKJ9IKHYxP6jJ3ojH0u
         xFax8a2OFogLCas6/dPSj9VE9AjWjU/gCj/MRH8lZecVj7wNHfVS6D0Ltfg69HG5IufW
         D14KJgWYvt0A/FNBXRCoS2BBo4aCngPFazq+nroxDbfkIB+Sq1dqOuJZ/smdwu2d6DY3
         rd7A==
X-Gm-Message-State: AOJu0Yw0BhWUTgN4X4BzNAhY+S7Uh2QiiqhfhCq1zUz6RWxsPhhovx6o
        gL3F6ioL3l82QIfQRKd35fBKfA==
X-Google-Smtp-Source: AGHT+IFhLh+o2/YSAv/NSFuu3qqjkPLbe6RTQxxI5s75iK6leejwAde+aW5OIximFnGDWjYIaPxR7w==
X-Received: by 2002:a05:600c:1f1a:b0:40c:16ee:3219 with SMTP id bd26-20020a05600c1f1a00b0040c16ee3219mr2528379wmb.165.1702297872668;
        Mon, 11 Dec 2023 04:31:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm12932313wmr.5.2023.12.11.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:31:12 -0800 (PST)
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
Subject: [PATCH 3/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS VA
Date:   Mon, 11 Dec 2023 13:31:03 +0100
Message-Id: <20231211123104.72963-3-krzysztof.kozlowski@linaro.org>
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
VA macro codec, which looks like compatible with earlier SM8550.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index ca6b07d5826d..c03ff9472a85 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -19,7 +19,9 @@ properties:
           - qcom,sm8550-lpass-va-macro
           - qcom,sc8280xp-lpass-va-macro
       - items:
-          - const: qcom,sm8650-lpass-va-macro
+          - enum:
+              - qcom,sm8650-lpass-va-macro
+              - qcom,x1e80100-lpass-va-macro
           - const: qcom,sm8550-lpass-va-macro
 
   reg:
-- 
2.34.1

