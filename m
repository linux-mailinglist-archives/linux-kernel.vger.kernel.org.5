Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB77CFE03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346320AbjJSPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbjJSPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:36:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408E126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:36:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso8067091a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729760; x=1698334560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tulhhblHrcCah8iPxnvKfrb/Qib8qF8UaGqM5t3jbq0=;
        b=T4ut6afZaEtRAQVP/c1ieEU9hVwQ2IAcQf2dWNUf8f51dY+9mk6doykLCHn3JxVy1r
         R83U63tazSsb36Qo+QCTF67bH2cRB7YWvKBKufK/a0kmkXEcoGotbgR7GyAEsVfuaiyZ
         Sh9bnW0GXOneYP03FhsmjhqtcDHjT7DLuwIIK9B+gOuc4nyDC37M1hFDoiRXq5T8oNZu
         AdaH8hn1qoGWh0AUQv6VNY6RTGT11UzLGcmgg9h0CxeUPrxa0c1UwhpPOnT8JEiNQj7g
         NQLv6RClASQkTmwwLUslKxsGqtilH94HBv2mUQhxKIcpucsbJP1JFC61wa42Qoq4ctya
         7HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729760; x=1698334560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tulhhblHrcCah8iPxnvKfrb/Qib8qF8UaGqM5t3jbq0=;
        b=Z8icAfJcW6lkX581NgczX2vGb9iyph8FOzseBuCMs5nqm5oqMfG7rm1VUlcJRKw3iz
         y6hAET1YvMZwBgRp9ClR308EaKExgoBGcx83G31MfXyQZ6YSFULwU+AhzJD9x5eqbv9b
         +9lmHNS0bC6LBh7gs2g164rf10YHyOL+sewIhiY9M1v4eRWgZ6iQESA8EuWQwgyzz+2Y
         U8BegtNNgvpyVHr27OWj+Zk+hSc9nd94xUlsQEdTGNLzRT2Hi1RXfWEBfFS3aJCqE8CT
         IMIZm5ChBM0Lv3j0VjIYC3eD9YQUKbgCmwnrQx4qK2ajR7t7Xm50Kg8RbMij46yRT3Re
         df3A==
X-Gm-Message-State: AOJu0YyU9/jIV68To+8ZIDgxT1EpnPyh/ZG1EDn0N8ZgAt3c2jX+dji1
        +ts3xAaWvvY+NwvrR+cUvwa9jA==
X-Google-Smtp-Source: AGHT+IGNhUCwSgjJIlC+Kc1pNz6Qg02U10hXnQsaMQCy/FidnXeNoyfRdij7ZAi4eWS4G4DjWbAC/w==
X-Received: by 2002:a05:6402:2741:b0:53d:8320:efcb with SMTP id z1-20020a056402274100b0053d8320efcbmr2430553edd.36.1697729760130;
        Thu, 19 Oct 2023 08:36:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id c64-20020a509fc6000000b0053ebafe7a60sm4743875edf.59.2023.10.19.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:35:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add WSA2 audio ports IDs
Date:   Thu, 19 Oct 2023 17:35:40 +0200
Message-Id: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines for audio ports used on Qualcomm WSA2 LPASS (Low Power
Audio SubSystem).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 39f203256c4f..c5ea35abf129 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -139,6 +139,11 @@
 #define DISPLAY_PORT_RX_5	133
 #define DISPLAY_PORT_RX_6	134
 #define DISPLAY_PORT_RX_7	135
+#define WSA2_CODEC_DMA_RX_0	136
+#define WSA2_CODEC_DMA_TX_0	137
+#define WSA2_CODEC_DMA_RX_1	138
+#define WSA2_CODEC_DMA_TX_1	139
+#define WSA2_CODEC_DMA_TX_2	140
 
 #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
 #define LPASS_CLK_ID_PRI_MI2S_EBIT	2
-- 
2.34.1

