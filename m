Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337D7E0C54
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjKCXg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKCXgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:36:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFD10D0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 16:36:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc58219376so23775585ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 16:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699054560; x=1699659360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1s0HtUb56FJexT+QBsAgKXm2XZYTg/G7gzdgJqBk4g=;
        b=ivw3kAB0wg+FRoxBawA14FUFgASd0Y39q+vgLD3W2KoDZ7qJ1PgQ2FZBmnsF2gfSz7
         qe0FdAYZxE8Sz0yq9jE2efW35v82vXJEhaSTFkDiR+UIq4Grf3LDlatkP1pA0VW7xLHo
         f7h+Z8IT1sEySKjdm078vBpQxgQCbjp/HPEp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699054560; x=1699659360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1s0HtUb56FJexT+QBsAgKXm2XZYTg/G7gzdgJqBk4g=;
        b=b+/BqI+k9YysFKD1xZ19xZKJ3XnChr1uzjRhaPd+vOgH7yK22TR2ZQSY9l+boG1y49
         6RAlLsNiSjhSdfS/xxzcyJLdn2KJUwzflP/GozUKUaSt6fgYRz9JFeaafb4yl/tAmDOS
         wNeA8Zk8yAYyj7U+90YuIIZbwpqp6j2rledwW+GqifmVl5JNxSv6USU/oHvCs9vIDWcQ
         kvKEusPR4LARyWbh6qxZYNC+q9/RXDGDEXaD++ez4xvAggwBDV1mRV6AOub91b78qU28
         U8ylhZ4KiqYSlOxUwlGDOqeJkhvQJDHTFh5KQlo5RovEV5b5AEo2LYC2OzoGpBQ639OE
         8+EA==
X-Gm-Message-State: AOJu0Ywq21lmqauHs9aRK5OKYQmZLNWx949MR1R9gzIY16psqvqY7YN9
        G7bZAbscAJC2pOcjJm5KsfnP5w==
X-Google-Smtp-Source: AGHT+IFQR7Nep3YfpY2xPcCAywlJbGHYPaDT0QE2ucIjE0ouT2fVM4EsiBFgSd7g4MIqCTN/Acs+Yw==
X-Received: by 2002:a17:903:1390:b0:1cc:2f05:7edb with SMTP id jx16-20020a170903139000b001cc2f057edbmr19381125plb.35.1699054560588;
        Fri, 03 Nov 2023 16:36:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5195:5e72:f5bb:e3f0])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001b8b2a6c4a4sm1878114plb.172.2023.11.03.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:35:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] dt-bindings: watchdog: qcom-wdt: Make the interrupt example edge triggered
Date:   Fri,  3 Nov 2023 16:34:35 -0700
Message-ID: <20231103163434.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
interrupt should be configured as edge triggered.

Update the example in the bindings.

Fixes: 7c631cdff391 ("dt-bindings: watchdog: qcom-wdt: allow interrupts")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 5046dfa55f13..681d1efbaf2f 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -121,7 +121,7 @@ examples:
         compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
         reg = <0x17c10000 0x1000>;
         clocks = <&sleep_clk>;
-        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
         timeout-sec = <10>;
     };
 
-- 
2.42.0.869.gea05f2083d-goog

