Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9807BC825
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344019AbjJGOBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343974AbjJGOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:01:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E22C2;
        Sat,  7 Oct 2023 07:01:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb94eso30183565e9.0;
        Sat, 07 Oct 2023 07:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687261; x=1697292061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw8zYERSqEu+kmYmyCghLNxuUwk+IwP5R5Agq5Rn9uQ=;
        b=h7i+N7n8y22I5Vvh/XvDLa4NIyhH9MysBhnNmZMryzp/BqEhGlL7370XKt0a1CUUQn
         D71QGctiAjan71l8TVKYj3kx3KcGKI/cFcSJy+JpMhYHX/L1XJ+Vw3ZhCwmgqUQ+Qtl+
         QJDbZ4a7HIbiVB0sMFkhIUuT9RXv9aC4/y5Izmj87H1oWDKOmqka6CqP0OuOYWVtAZZ1
         pIs/4HlsOC8VHjIBro9brJb1STJsbrU2nBO+peNTAB1HITh2Nem9x0//jlp38MNuB713
         DduXpuVqpWQwBRtxAUucGa1ykwLZQNN5UDTZNmEdAH3q91CuKDJq0ZiOf54dQsUPUkvA
         Dr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687261; x=1697292061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jw8zYERSqEu+kmYmyCghLNxuUwk+IwP5R5Agq5Rn9uQ=;
        b=IzTg1303HEhkpEmtrBs77TRFGsR18q/YJCLetmW37Rn5mPArj2IBhUP/tKhf3zN32u
         Vv+3HjRsp+YelfRqHm8co0u5FUdrmQPCMsnp+qbtsCvpKIH8JK42Fu9tPKP0apikRpVB
         2M/GAqjharNILVIhehgtdvsPAyAfbL0z2RrmOHEoK0XzGsIoUaBBnQc3J+tbCbqWXuUo
         fNTEsCZaTC1+NcHM/AS6VROXsR9mE+h1QLOph79Ri+Nvrpcla3AZxKU7hSkPACtKg8DN
         zbuBlvkAiMh/OZHNStISEK0md6MMgBUKF8hd7TJO+8KTOalpBALUekgPgLIYwh2Puw44
         7gKA==
X-Gm-Message-State: AOJu0YwDF1uGpsrjYmW5VfOcFLD8y8blwd/9liDvwCRb6Cbk/xRRzcmM
        4nsHge2N8E6NzNXMWGpmCv4=
X-Google-Smtp-Source: AGHT+IFQptrEpwlPW9ot1SQ6UuDVRo1gaRXqfUiACI4NmGULahJnOISsiOOHpR3YvXdLnvR9QM+HrA==
X-Received: by 2002:a1c:6a18:0:b0:405:4a78:a892 with SMTP id f24-20020a1c6a18000000b004054a78a892mr9155691wmc.9.1696687261384;
        Sat, 07 Oct 2023 07:01:01 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([77.22.112.104])
        by smtp.googlemail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm4332043wrx.87.2023.10.07.07.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:01:01 -0700 (PDT)
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
Subject: [PATCH 3/7] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
Date:   Sat,  7 Oct 2023 15:58:27 +0200
Message-ID: <20231007140053.1731245-4-davidwronek@gmail.com>
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

Document the Xiaomi Redmi Note 9S (curtana) smartphone, which is based
on the Qualcomm SM7125 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48a0954..42461b0f19a1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -984,6 +984,7 @@ properties:
 
       - items:
           - enum:
+              - xiaomi,curtana
               - xiaomi,joyeuse
           - const: qcom,sm7125
 
-- 
2.42.0

