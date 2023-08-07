Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91081772EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjHGTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjHGTbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:31:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7621726
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:31:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4240990f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436693; x=1692041493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAPKS4SAXmZKxicJb9ydkGPtaas2WIonOZ7to+HEfxA=;
        b=tOmh3T/d1Kx4g5+xfWbagK8zeGuje07up/l4PO1tcHXwuVmvIvKezEFEUOszEceBwv
         WLoDiMbUQkX8jTprThvfI+94af++yK1HBv5TLq1zf5liFa6GUHWuLrbyYBO0KyAAx0sW
         G2YMRuSYtUZkPA6TUkDb0scVx1tV5W+yGsHfFKU+iwvrWydYuU/0Yd+dyq0Z6CgdXhCl
         kxKph2hAcWnEy/TuTREzxTULR40oj+9vctCBPlWjIp1S+PjMazFOy9kN+l9V1dn6ae0X
         x8M6Hk9pZxtjeD89oR/plTnS6CIGysZeXPcQ6k/Tppw434ibY95fOMnSJJIDiU5GfYxO
         OpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436693; x=1692041493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAPKS4SAXmZKxicJb9ydkGPtaas2WIonOZ7to+HEfxA=;
        b=ayYEAN6jtgNPSf2r3+II1FnY5Z4vhhFjjfYNnJX3PV7XYknfW1CvVYUY+Grchh42tw
         7PT5GbJCsjjupFuZWTxriB/ldVcjjamOivjByDPaaZVGamidQDlqOHeDBeTNTtZHp1YK
         bLiUZdSnATWatqgaHa+dAQJINvUj1tIrjjjro7JChihV8X/kvSEsvpkNdj6CGI95e7CX
         XLbHtF0TY/hF9xSnMEoVkD4Fg0y65qTcug4ryxblQJt4VjF0wYcTfPo081Q8QltyVgo7
         IMEZqSl+HKZ9i2Oy3krclPIF5oVFLjJ3B+W8DkAVz9BtbG96iJUdXlJkAUKKikjQ4wry
         B7Jw==
X-Gm-Message-State: AOJu0YwSerWNzwB1CSnf/aqp8HKSssRdHAResL5Glc2B+RphnGZAqYai
        vetHi0nuYGqGC7gpQPt/ulWJsw==
X-Google-Smtp-Source: AGHT+IFftT9bB5ixmjqvw1q7hvp1QMCeUhqraDuekV0noaWoXd5f9+2RWAbtpR5sMmr8DxPlkMO5oQ==
X-Received: by 2002:a5d:6683:0:b0:317:67fa:eeb4 with SMTP id l3-20020a5d6683000000b0031767faeeb4mr7411809wru.57.1691436693519;
        Mon, 07 Aug 2023 12:31:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003fbdbd0a7desm15985654wmj.27.2023.08.07.12.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:31:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: net: snps,dwmac: document the snps,shared-mdio property
Date:   Mon,  7 Aug 2023 21:31:01 +0200
Message-Id: <20230807193102.6374-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807193102.6374-1-brgl@bgdev.pl>
References: <20230807193102.6374-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Two MACs may share one MDIO lines to their respective PHYs. In this case
one of the MACs is the logical "owner" of the bus, while the other can be
considered a secondary controller. Add a new property that allows one
MAC node to reference the MDIO node on a different MAC over a phandle.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..f9c2285674d1 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -500,6 +500,12 @@ properties:
     required:
       - compatible
 
+  snps,shared-mdio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the mdio node defined on a different MAC node which this
+      device shares.
+
   stmmac-axi-config:
     type: object
     unevaluatedProperties: false
-- 
2.39.2

