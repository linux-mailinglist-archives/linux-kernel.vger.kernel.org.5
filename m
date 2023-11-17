Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A938C7EF87B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346221AbjKQUSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjKQURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:17:48 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25772D6D;
        Fri, 17 Nov 2023 12:17:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9e1021dbd28so334449766b.3;
        Fri, 17 Nov 2023 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252263; x=1700857063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGuQp1NGPuXoUiEpdYzJcjnNBJsSPeD9FSB3a1HAj1M=;
        b=d5ANkJoPQtJXml+tCrqkDVTOtXSSgaKrvS9T6jS1/BQPrRgk8+XDXYth2JqZKjlk7r
         1eUVTzBGVctIsI0fbebBg/7Xb4ROVAEyalK9lUKjkJ4RCReshq3Wjc7nKTwieNHkqAyE
         UIf14xDfRPphhMAQ+DfCu2IEy/Pf0DCA52nPvhY9Cz6vN1sH2iFurP4WFAym2O3tuXgL
         S/tXWanmbhSTq5r8VHHGh4qa5KuD8TMq6rsMb6bFL1Gvwj4lUWqQLfetkI9uBkI2NwFT
         MpQGYXFpSxDa9Hp89wqxSg6qhS1qmZIvzracuynqOFMr2H5femB7UMc5vRn64rffENVi
         ixaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252263; x=1700857063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGuQp1NGPuXoUiEpdYzJcjnNBJsSPeD9FSB3a1HAj1M=;
        b=ZswDmvQBVE/KcPISkxz8BnuIURLQr2tjepRTStl+ckvVbJ+P0iFyVSC8tQRwO9Uw6X
         RV9dAOR5FpFwxp0Jlutgd421i5qFIsMiZULbtM0o4tnFVSfM4uurE5kVgmUVI9f7e3eR
         YtCtusx6ezhMwrd/MOxmwkxH/gWxq/SZEoJKaXQr/Uphn2iVm0BPdJMl5dZhacSXVnZu
         4GzqhYt5Hl1Me5Z/GyG2swpcp6PGeP/+2V7Ls5w0CuQi91xnByO9QaRADdpA8Rs3D3CK
         zZ9HiDZ5cFNkzxjHqo7LARM0f2csODsmGNPSvNk9zvBxL1H0VVbDVSP4rzwLspmYPboH
         Fyng==
X-Gm-Message-State: AOJu0YxsG3Kq9s/PADVft6qcdQt4IbL3VBR8ovHTetNUxc0l1BH1Kg97
        G5opZ2iicClLOdi+yjCcOTk=
X-Google-Smtp-Source: AGHT+IE3rA8zaqiNTqTRHOawRQfjIKcBn8sQ+QJjTatFpE5dBQnss7wIZFSXu/flSG5JfdkY4fA+LA==
X-Received: by 2002:a17:907:a781:b0:9ae:5fe1:ef01 with SMTP id vx1-20020a170907a78100b009ae5fe1ef01mr207293ejc.37.1700252263223;
        Fri, 17 Nov 2023 12:17:43 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:42 -0800 (PST)
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
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 3/8] dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
Date:   Fri, 17 Nov 2023 21:08:35 +0100
Message-ID: <20231117201720.298422-4-davidwronek@gmail.com>
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

Document the QMP UFS PHY compatible for SC7180

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 8474eef8d0ff..5faa1cb3a12e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7180-qmp-ufs-phy
       - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
@@ -102,6 +103,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc7180-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
-- 
2.42.1

