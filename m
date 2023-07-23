Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FD75E464
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGWTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGWTIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:08:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC81D1AE;
        Sun, 23 Jul 2023 12:08:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso27757665e9.1;
        Sun, 23 Jul 2023 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690139287; x=1690744087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In+Nbgpp4Ts/8QxOtUkYSlQfGp22n+NCuDjC/vLoUgk=;
        b=muL1ww666UbsSuYWZyb+oTA0BHPnCi0ChyK0OpIAR1VoDLUY4EUKqPgkdOdaqtAVAE
         1ZrVnRCdGZA/kIbBJ/76EyTvEDIw1pO13ArRyR6gOZ2NoJJJ2kHxLJsaW0S1ZUrR5nuO
         XEFK3s1cybfPrJU5Q8/NSbgNGyoeBeqe4elyml+C6YgTtIIjwgBdPAOtkZj6oMz9voYJ
         vA6mm8jczOEmrSACaYPI056wONZcXTp5HKyNHyPJqepKowiLl2YJRGk9BcgPEWTOo1//
         987JvyntS3N3+voc9+DcgkJu7LMOxGr/VVYAJNRaFSB6VjP3bM+gZmDKyRWL1pMEzw4U
         oElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139287; x=1690744087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In+Nbgpp4Ts/8QxOtUkYSlQfGp22n+NCuDjC/vLoUgk=;
        b=J+NAS50lMB0hlAN3f9NjUJKpw7AYUhAuKrNX0R+gvBvW/sZ3MGCdbnJMskWxomuGmT
         19VCPfx4MgpN555dbPqL4pYLsZZRaOPG53430Yek0YrRNdLB4cpT3W7rM2AosSP4f6Z6
         4x+RCaGFv0BTI+ESJ2aBi32vZVWaelSlx/agv9IU8AgRsEFzGK4BpVPl76uOd/YsE/OD
         nGQFyd2WBPnAg8RawuWIDXfDUpOoikpRGyhWpiE8bILoETTpcH8Z+D1yNIzq3FAxGInh
         phTvg/G5lUF6VTo09QkZTBtAaGDJCKXa0bK+xU+nWWyggzt4BklJVAbJ0PSionHRg1YL
         6C2A==
X-Gm-Message-State: ABy/qLacVufqTmZqZXwIHNndRgRY9pNtR10aKxKqlErCr3IikBoU3/+/
        uEisMR47pzcphT6zCE3N4sU=
X-Google-Smtp-Source: APBJJlG/eav1BPFSifwunUCA8aiTN/3usCKWi016aDKfJvGcjZqbRdpc3Z6A8RSTjQc3Q/OJF60sTQ==
X-Received: by 2002:a7b:c5d6:0:b0:3fb:a2b6:8dfd with SMTP id n22-20020a7bc5d6000000b003fba2b68dfdmr5637493wmk.32.1690139287261;
        Sun, 23 Jul 2023 12:08:07 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.170.196])
        by smtp.googlemail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm2843320wmb.12.2023.07.23.12.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:08:06 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v4 6/7] arm64: dts: qcom: Add SM7125 device tree
Date:   Sun, 23 Jul 2023 21:05:07 +0200
Message-ID: <20230723190725.1619193-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
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

The Snapdragon 720G (sm7125) is software-wise very similar to the
Snapdragon 7c with minor differences in clock speeds and as added here,
it uses the Kryo 465 instead of Kryo 468.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm7125.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm7125.dtsi b/arch/arm64/boot/dts/qcom/sm7125.dtsi
new file mode 100644
index 000000000000..12dd72859a43
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm7125.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#include "sc7180.dtsi"
+
+/* SM7125 uses Kryo 465 instead of Kryo 468 */
+&CPU0 { compatible = "qcom,kryo465"; };
+&CPU1 { compatible = "qcom,kryo465"; };
+&CPU2 { compatible = "qcom,kryo465"; };
+&CPU3 { compatible = "qcom,kryo465"; };
+&CPU4 { compatible = "qcom,kryo465"; };
+&CPU5 { compatible = "qcom,kryo465"; };
+&CPU6 { compatible = "qcom,kryo465"; };
+&CPU7 { compatible = "qcom,kryo465"; };
-- 
2.41.0

