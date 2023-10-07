Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA137BC81D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbjJGOBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbjJGOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:01:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8EBC;
        Sat,  7 Oct 2023 07:01:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40651a726acso27864195e9.1;
        Sat, 07 Oct 2023 07:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687259; x=1697292059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGOiBnjw4/x0MkXFgDDiE4Fk7/tgt630it5dnumIjlY=;
        b=GpGVoDYS2RZvwpy+WtWCVFAy1QGYS+a4FkqWnK7KAsjA/u1B3Qyk2R1sTEq84N14kb
         L8eysZVRhcP58NjSgUco1iirLH9d/7kHw9ECfa9YoDY66DkHRxTwj7iirjq2T2h26yy2
         Nbt7k8sfGbHLZZLsD+f97WHl8GSOsOnCzB5CInmlgj1tfnwibYn7XypUsZ70mHX1BbqZ
         KQhoEqJFc2wSaJjjy6z2qhIoBZPB4kFi2irdfDCHhTn1FWAMxC7qsWRRdUsJkQlG4Klx
         MUfHWGiEDyo9AaqltHBPJWeNOCoU+OLJaOcUPHDcc/DEqtScLyBgPzLLqEwHnsys27K0
         5dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687259; x=1697292059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGOiBnjw4/x0MkXFgDDiE4Fk7/tgt630it5dnumIjlY=;
        b=r6jP3OuJYDrxudIyDsuWp6dxC3zQB+KlYJUEhtDhWdsyszc9F9sG3l7c905R0QIB/S
         IbAqMWmH7+H7xYwgxE3YWEIID7SHMihcigeeNaC5NYxxv+d27zaKFAfhzK+LCICR5/8h
         up6j2V06KcUpUzBWvl0qa+3nP6Bhiq86PYrMneIuSbAIfgsYQRrFSbBdpdd0wsWoZz5a
         26IIVwdY/C3WPHFIrQ1NI6AYmP4srY+o0Nq1puqSzsP5qFPhfS6wly4LE9EWoEa3Vix1
         vc5oMh5KEJAASncZ+TF5yvuh/kmTpvpE26Xe00wnSaY/dBGptSYjZcPfUYrfY1Bix042
         8fLw==
X-Gm-Message-State: AOJu0YyA2Fs6eZx4Pb+jPgoEvGxRzPtL4gzngZ+tN+sFBETsvjOXIw8I
        NIUrmMKvAFEd6hZBgn0nsPo=
X-Google-Smtp-Source: AGHT+IFUlOCstpFBtle9vJcHnRwKqht1Ydvm5Cr8wkCt/VplSUpVI+3bXftOtvU7hIWIsuDALe/TQg==
X-Received: by 2002:a05:600c:b49:b0:406:7232:1431 with SMTP id k9-20020a05600c0b4900b0040672321431mr10355053wmr.33.1696687259174;
        Sat, 07 Oct 2023 07:00:59 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([77.22.112.104])
        by smtp.googlemail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm4332043wrx.87.2023.10.07.07.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:00:58 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH 1/7] dt-bindings: ufs: qcom: Add SC7180 compatible string
Date:   Sat,  7 Oct 2023 15:58:25 +0200
Message-ID: <20231007140053.1731245-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007140053.1731245-1-davidwronek@gmail.com>
References: <20231007140053.1731245-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for the UFS found on SC7180.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 462ead5a1cec..f99a933cc217 100644
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
@@ -210,6 +211,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sc7180-ufshc
               - qcom,sm6115-ufshc
     then:
       properties:
-- 
2.42.0

