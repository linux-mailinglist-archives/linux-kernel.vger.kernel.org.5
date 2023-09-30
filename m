Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A337B3FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjI3KdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3KdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:33:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D8D193;
        Sat, 30 Sep 2023 03:33:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so18964776a12.0;
        Sat, 30 Sep 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696069999; x=1696674799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRfD2frfJCrCV8FZTJoVzCkfiyFyj4/PvBoUWy9PR30=;
        b=jTOE/jJbTKyQCwYWeGs5tL1nrkKdkPWfVR6uCIsFZWAmVok4yMyl9vQxcubiqgRAOJ
         JDh/wZr6kIZIvPQYxQszcgiOs6Kzjs9meexWdmO3Nwbv/2ZtuPIdfd0hrJaSe/qSt40N
         yu5hD6HWqbnAu0y3FwuU4S5+FubsuCAop5Z/sdtg7iDaAjRDIIaGS2wTSeGtd2Ssfkkz
         /1LYpW4Au1VVHwt+sbC7/gMoZ3ryWKeXugokh9kRT93/xEfgpNBbSN9Dh4+cwGhsO+a+
         vl5Gr5E6HiiCspsLKIfmaoqdoQCqNOk99L6Z2ur6frivmKxDWAExBE3Q0bclGV9m4XRv
         IdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696069999; x=1696674799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRfD2frfJCrCV8FZTJoVzCkfiyFyj4/PvBoUWy9PR30=;
        b=Bd19onfnTBPJ9zvq8lQdYbfqUDR9V7d2ADli/2Kw/Smm1DrtDGN4Bl0gf88C4/H24I
         qDVLsUb41UJCgFT9P2gT5plnB6AggjC22i7T/ktIsRqyHFF4EGX9n7Kb69CFQ6wuUqCx
         iCcLiKtgNFwIVILIkxBigim0SzbqLGKd06LxpMv2vsCI/BO2LU2erkd9KN5K5tUx4A7T
         wMwR77kqfWLXOoyixCT3XNEywSzmaqJNlhCF5o4letMMj4ECiufuW9M1E++5kYil88u5
         WNcYd8Pbonf2bmAVCU2MldPVGqU8Mds0Ukv/DmDNwwxtnkqvUpjW3+EByIc6D8c7Ias2
         XHCg==
X-Gm-Message-State: AOJu0YyW2tnODsrY7gC9mp5CCsYr7TrGdL5PFzbVS0fQrs2SOZf03MVl
        1z3vG4R1Syo/N5vOycQ/b9o=
X-Google-Smtp-Source: AGHT+IGSAjPXCSuAJi756PZrGHD8E9gNkMqAeOK2j6EnB3ivcMQVACVNWzcMAMGeXQ7WU8uK6gpPdA==
X-Received: by 2002:a05:6402:1846:b0:530:7ceb:33c with SMTP id v6-20020a056402184600b005307ceb033cmr6334475edy.4.1696069998899;
        Sat, 30 Sep 2023 03:33:18 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id r22-20020a056402035600b00530ccd180a3sm12406097edw.97.2023.09.30.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:33:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_tdas@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
Date:   Sat, 30 Sep 2023 12:32:24 +0200
Message-ID: <20230930103316.234103-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Allow passing QMP PCI PHY PIPE clocks to the IPQ8074 GCC to avoid having
to do a global matching by name.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 52e7831a8d6d..2d44ddc45aab 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -27,11 +27,15 @@ properties:
     items:
       - description: board XO clock
       - description: sleep clock
+      - description: Gen3 QMP PCIe PHY PIPE clock
+      - description: Gen2 QMP PCIe PHY PIPE clock
 
   clock-names:
     items:
       - const: xo
       - const: sleep_clk
+      - const: pcie0_pipe
+      - const: pcie1_pipe
 
 required:
   - compatible
-- 
2.41.0

