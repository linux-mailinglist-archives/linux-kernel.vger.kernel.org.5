Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501C77BE74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHNQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHNQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019FE65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5236a9788a7so6209270a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032032; x=1692636832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbrWg1Qz0KH3Qccenl+/SPqOk9dbSBcuvMF62khAq+E=;
        b=SDmVWnZzc1Hu0EX2+71EJt8KzB3HKk+6dwFzADxPCFIOX174Rq2A3qV6N7pNb5aJDz
         tDxUCn/wgQikjJUUaBgetrAPD6LDGBK+AALcvPbr4J9MeMEzu1qqULD3yXcW95C/Dv17
         M3aXnzfQUJPGCB4ir+5d8V30VrHOI/As8aVncLs0Q0l+gKECAj0WFXA6WtxvFo/tX+B/
         TNwkPSKV3F8/BW+/QGE3IIjkuzlsHjQEasMzdAv5+RdjflcU2gAJvVohxWsXf/PehneM
         Tk0gQuqkKPGjQhmauN8RFuSC8OqYp/1Rvbdh7LyIs0fknPboybRXIp6+ykd6FZ9DyRST
         7JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032032; x=1692636832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbrWg1Qz0KH3Qccenl+/SPqOk9dbSBcuvMF62khAq+E=;
        b=UhXgmpYK/16sDT2Zk+H05kiZAQRu/NXQCdkNR9gCISD7sT6ji9qEtHpeyi+gKQKYfC
         moniugPtdZ5/bRrkVR0rtB54j/6DDPNVU29a3pxhTluhLjBXfdSbXqxgXMUSMJjheIBd
         S8raZCfi8unclHDo5cgvd8ccgw/VtYgOeMZwiPQc7XOl/vXBJ7duZwhUtZnKBeGdL3iT
         ZJHI3HfHgFRUhpsRHIwM22AE1d6IRSrA1k0zd/4USg5SXuhnYIGhfxSXfeS9jXYKghS2
         /fnhmqFfXvWCmPSjFjBlHvH7n+rGkMCohS+KMIW9Hr3RQnFMH2yUaXA5yL7vulUAhz1+
         jSBQ==
X-Gm-Message-State: AOJu0YxRoN63+XRgeeCbly1+fTm/0G05vcavrhQDH/PG5chmqHulJYmZ
        c1DSj0Wa180rTH+iV/+iU1vHSw==
X-Google-Smtp-Source: AGHT+IEErsEg4l0UlkUeiCxwxNN0e9wFjeT9NR35DkvMRqNLeZeWvBzhy713omaE6q6YdUwa/Ae+CQ==
X-Received: by 2002:a05:6402:4d4:b0:523:3fff:5ce2 with SMTP id n20-20020a05640204d400b005233fff5ce2mr7237008edw.41.1692032032028;
        Mon, 14 Aug 2023 09:53:52 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 15/22] dt-bindings: nvmem: Add compatible for QCM2290
Date:   Mon, 14 Aug 2023 17:52:45 +0100
Message-Id: <20230814165252.93422-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index bdfc6d36a400..8740938c32eb 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
           - qcom,msm8998-qfprom
+          - qcom,qcm2290-qfprom
           - qcom,qcs404-qfprom
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
-- 
2.25.1

