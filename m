Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03DE7B0425
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjI0M3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjI0M3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:29:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609E193;
        Wed, 27 Sep 2023 05:29:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-406402933edso24203735e9.2;
        Wed, 27 Sep 2023 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695817774; x=1696422574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqrlAO5sztrD1NimOBbmkaeWGCBRbknzZR3MhxUtqJk=;
        b=naup93iuZZIHBNrg7x06YTu29vDlozLnf14gcX4NkFnP6km2GgY81WxeMEtmhst4r4
         pXuXP5UsTUccFlTLz/3epMlW9SKXP711dtH7vsqqO4DE2HMfn40P5M8tSfLVfoTYjDtd
         Ra9cAQ3K3SITOUIk0S0ssbYv9Klv1NvLXP8tQq9RRUEX0QzPr0ZCVRIKigu3OJJqDcUR
         IrTbxI0Q6wEzatIL5UdCIo6GQiWUKeoGYIsjb7VmLQOmivsF2oR5aTspp5Uq2W+Aq3IO
         DfWMVnDTGHoNOc8uqjbhNlm5aRmz/FTM4J3z5Y3Z2YvCWbDCcuMWudGChxsLsD2i/zN9
         An5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695817774; x=1696422574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqrlAO5sztrD1NimOBbmkaeWGCBRbknzZR3MhxUtqJk=;
        b=hKJJDlEhKrkL1CRTAcLW2N/P8UBEoB9JHpo2DQeJS/gQxofnwyHjaGF9Pe071uyHw1
         NRX9WUVFy3D46ZZfp7z1Efw+G5Q6SXFVU9GXTux9bFyTao41jHGplag/ceVvfr2Me1g7
         oa20BYvfJuJeVoSYaC470OQaxkz0qbJyMquosi/C2gb5nA66yQDhuyujahyZjUbQNT/q
         Ew2JRSmXhk36jqS5sKobKKTqfWCRtAvi2zGFN94d6HPw4v9/Ju9iwe6GUrO9IZxEaYUj
         lg355CAvqDnndUXZCFJeMgxbKTXFur3LRN0Xsx9CyYWmPwkkHTO2qPAgUzUoMRD5mk+f
         ESig==
X-Gm-Message-State: AOJu0Yw2cpzrqIBF94V8mn2QEhAikQsmPQHx87MlUcTcGMyiq7I3L4fb
        nbRpYzUDbk+5UEOkTTkLMfI=
X-Google-Smtp-Source: AGHT+IF5xtLdTh5ebA3MvomjOgILvnz4IhFIHGw6vrUOiVXXmVjun0KXM08k7tob5hnd5+T2RFQvmA==
X-Received: by 2002:a5d:5348:0:b0:315:8a13:ef17 with SMTP id t8-20020a5d5348000000b003158a13ef17mr1430106wrv.65.1695817773679;
        Wed, 27 Sep 2023 05:29:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id 8-20020a05600c230800b004042dbb8925sm4521218wmo.38.2023.09.27.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:29:33 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/2] dt-bindings: net: snps,dwmac: DMA Arbitration scheme
Date:   Wed, 27 Sep 2023 14:29:27 +0200
Message-Id: <20230927122928.22033-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Document new binding snps,arbit to program the DMA to use Arbitration
scheme. (Rx has priority over Tx)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..4499f221c29b 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -442,6 +442,12 @@ properties:
     description:
       Use Address-Aligned Beats
 
+  snps,arbit:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Program the DMA to use Arbitration scheme.
+      (Rx has priority over Tx)
+
   snps,fixed-burst:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.40.1

