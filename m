Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4007EF873
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjKQURy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346176AbjKQURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:17:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4E120;
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507be298d2aso3159051e87.1;
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252262; x=1700857062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKYe02DmJmwFFNmiKnLALvfB/P1IY/5H1knBpaadyWk=;
        b=nPRPt3g7Z/CH1gvKNd4FBLUuA9et40alOtFznl/dMHP3Azw0/68hsCLvqjtVGF+PN0
         VRVuOwkokYcNbQs6Y5q2Ztslc15inOynpPNOWXIA9M869JpMwQr1IzDjo/Hxa4MCvt3v
         xhkd1jIlCW3TuGWfeGNSXvGjQcRW2tTpmjynUNbCFNU1gHAQwBa/Qmz/FHZvadq8P8BT
         YgwQfwEGJGvii+NLZW5wB7w1mvv1nnCOL7ihykypKEG8fSiW6hhTLmTuv0WDPyA+oxfO
         VV0OxwQHbrZwK5OuHYbefaWlvNlWBwyP/8QuUq0CoyXVc2Xq42/8p+IyOREXQ7XyqBbE
         1sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252262; x=1700857062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKYe02DmJmwFFNmiKnLALvfB/P1IY/5H1knBpaadyWk=;
        b=IhC+6Hje16Rw+eYnvVBMi6jB5WUurQHhzbBq14ddForiWrEmt+Vj9TYRG9GlQo7C/V
         uFRlPFaLkXKSKEJZInM1WBYK+4MN7W3w1c/4xKC7QdRrkR8wtyhe9aFbh1igjljdPQL1
         IH8gSXOvxjcxvHwlmOfQL0Ned4aL0KvJnd5PI6r/nKxMYkXUQa4VrYJ1DvRM4lwDjg2o
         DUrIz3Pv1/OQGrIbaZkuw7Pk5FJGib8gIbTU2ZSfmCsnRjBxnRGbpLUOjw7JlGvYrIEx
         lDe4O46KRSeU0YhaYm+VXGsprSwcl7Zk7MQeuSfgnyDjvXoYOFjpM/1NiMZ5QIVoUAYg
         Rovg==
X-Gm-Message-State: AOJu0Yz+zW67KJegdq0UgTa7Yst9UxNEC/SQV5LyBqVUoMHoOWHIpGTx
        Me2IZtwbVJPZd6PD+x2Ncd8=
X-Google-Smtp-Source: AGHT+IFe0hmC2VgViHFT5wuAsjrdil67dwDNZQZv0yUV06HkOxSpStTOzG2BPmbrbVMIt2AXxBTN/w==
X-Received: by 2002:ac2:5a04:0:b0:50a:9652:31d2 with SMTP id q4-20020ac25a04000000b0050a965231d2mr451791lfn.15.1700252262115;
        Fri, 17 Nov 2023 12:17:42 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:41 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible string
Date:   Fri, 17 Nov 2023 21:08:34 +0100
Message-ID: <20231117201720.298422-3-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117201720.298422-1-davidwronek@gmail.com>
References: <20231117201720.298422-1-davidwronek@gmail.com>
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

Document the compatible for the UFS found on SC7180.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 2cf3d016db42..192217ea1d24 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
+          - qcom,sc7180-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
@@ -212,6 +213,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc7180-ufshc
               - qcom,sm6115-ufshc
     then:
       properties:
-- 
2.42.1

