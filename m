Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ADA763787
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjGZN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGZN1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:27:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969FE2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:27:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so442755b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690378047; x=1690982847;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lxc77XWTDPTeWKbOVls7trvqC1maeRESKQ7JlGBAVk=;
        b=tzlf/K6lA2nbzCK73P1REKEDFjco9nWhyDMS8OpMrVB0n5mWFKtD++dNg2lByeu7m0
         d/zJYAKzFrMg3vWf5aU7sOnjhvN5QHBX0y7FQ9UYQgnKfr9xuvMsFHiYG2QDmHD7k+8q
         wvw/MD+Gf1t21AqrcccEsCI6otUTJ+XKxBvHL62rhWbUpKt55bqx0UCVcaZlogJ81HYp
         Tlhm31L8wPRXG3h53U/ofo4BB5wXwgYOqIGcj+szBaXFhZSG9s6mA/xAfsKweCycf+hG
         V4WdnEeL5ZPUsyVYERCtTl0/y3YymEbtIwL0xCguLZsY5qIrXdFrHUa1iF3dlgHOdJRZ
         vCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690378047; x=1690982847;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lxc77XWTDPTeWKbOVls7trvqC1maeRESKQ7JlGBAVk=;
        b=iIujL7abBGdVAsUAekAgCDnaB/iqdLjjWVA6rC7H8t3DHoP7KIs4w8WkSKKf5saAqS
         ZxMmLoC6gwM1/9Badc28JG8mnjy/M/esJ9Q6EHjcIezuqzrss7XeW5a84MOhufqBxfEU
         HeNns3U7h6jtuzqEniXZR57uyqKjC/eekvNsMbC2QMe98+0qPHFzBX9d0Q1i8hdYLQyA
         x1mjbq3vgehHQWqmzzhD0Qr2qftgBWA3b4u0KyQAnNUOkoDL7F3XeLkNtiwSZcVHh3Ag
         lgDyNGnpSQU+D9NlPaQwBrQOYLgwBsZqG5s0QWubdCI0P00In+ezQT1fB5s0O3deXV9N
         TuGA==
X-Gm-Message-State: ABy/qLZyJ6iQlI4zI08Ek8MqJHdBeJLeuKrwQ6XJ/Tjun8nvLz5Gykg5
        GRUIW/X1pIdhwXUBUOYng/jB5Q==
X-Google-Smtp-Source: APBJJlEkGaXvYl0Z4D2WNxjIzaFmZ0xG0IQslvweGeXL3npbZc6MEWn92JA3fL7KJSzJy2bGF2OmTQ==
X-Received: by 2002:a05:6a00:2d09:b0:667:e17e:85c1 with SMTP id fa9-20020a056a002d0900b00667e17e85c1mr2058353pfb.1.1690378047425;
        Wed, 26 Jul 2023 06:27:27 -0700 (PDT)
Received: from x-wing.lan ([49.207.50.231])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11485918pfu.29.2023.07.26.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:27:26 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: display/msm: mdss-common: add memory-region property
Date:   Wed, 26 Jul 2023 18:57:18 +0530
Message-Id: <20230726132719.2117369-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and document the reserved memory region property in the
mdss-common schema.

For now (sdm845-db845c), it points to a framebuffer memory
region reserved by the bootloader for splash screen.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v6: Re-sending with review and ack tags. Ideally this
    dt-binding patch should be marked for stable as well,
    like the follow-up sdm845-db845c.dts patch in the series
    but it can't be cherry picked cleanly on older LTS
    versions. I can do it separately if it is required.

v5: Moving the dt-binding to mdss-common schema with
    updated commit message and property description.

v4: Adding this new dt-binding patch, in qcom,sdm845-mdss
    schema, in the v4 of the follow-up patch for
    sdm845-db845c.
    https://lore.kernel.org/lkml/20230712130215.666924-2-amit.pundir@linaro.org/

 .../devicetree/bindings/display/msm/mdss-common.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index ccd7d6417523..84ed2757ded5 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -77,6 +77,12 @@ properties:
     items:
       - description: MDSS_CORE reset
 
+  memory-region:
+    maxItems: 1
+    description:
+      Phandle to a node describing a reserved framebuffer memory region.
+      For example, the splash memory region set up by the bootloader.
+
 required:
   - reg
   - reg-names
-- 
2.25.1

