Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB876F4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjHCV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHCVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:55:58 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AED3A9C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:55:55 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56c9237e0ffso227745eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691099754; x=1691704554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwJBy26yCQ/MHezd9s4R5qRHYs3iJG1/4Ao8pMVQ4Ow=;
        b=eHBslHzuArU+U8tPXhi5LtJhNVsrjM+cC5Zepdo8Hw+YE4fmqGaEbQgdIYaycpPkmS
         wInlrsiCWpn7gp1LkOaaWkdIQ8qLnC6S+pQGM4UtVZkwVORK/qRior3hEi7qLTGF777E
         UJEw+fll81r0lzgSBL1tkmoT9YqQTaV54U2pft1z050D3DqcwLAPWZqnHi88HcopiYKI
         N5bSVpS3AkUeTcpgQWUhP/CDxzgseEY1RKEx5RmHTymXeoTiZBT2ojEAcMlPgqXtKzaZ
         1wpDjJzttdANWVwKqPpEK7lgonSlRjWMzfeYibpDejADxdmLT5rT6R/Nq2SYG+PiXHEZ
         jA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691099754; x=1691704554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwJBy26yCQ/MHezd9s4R5qRHYs3iJG1/4Ao8pMVQ4Ow=;
        b=kH2WS08uo+hLZbH72AAR/BlnebJQLuIp+XxmLb01KFgKOgDP9F47Leia3r+Dsd95ux
         lDU+UD6GQQC1gVwFL6fVb7ph6V/TcBus+RzXQbk+WjgcZjY6+ko5YvFkgTUStskMl8L9
         jmgzHHttJFFdUk/xlK9IwH8/zXZi3r9HBjM+dcImmc8Cn8ZO60N5+cR6eqd9NQLwIMGt
         uaLDJoIu3iVVDuprZxwl6J2lnVeZh109WV7q/5W3gYA3vy8ruyebMmIB3vpzZY+pXNuG
         3YSvWoALJFqLKNlQosw9cZQcnGrmOZTMogD5AsXjXMUG7glKW+Pd+nfykAXF5AeARZrl
         uDPQ==
X-Gm-Message-State: ABy/qLYc4v7Y42Sf1xNGbg8hL0+LoZ+ScgXsKcBKnGMsffMJt5kqZLIf
        SprtEvfLsP0LFc41GJ2X9geRPZKcUZE=
X-Google-Smtp-Source: APBJJlGMfMXcoawpm2ZKMRznLBMsULAqVn+LBFDlz565oYuOa85h5VDgPCjOLLgjylbhtxVL9sT4wA==
X-Received: by 2002:a05:6820:2108:b0:56c:5e21:c72d with SMTP id cd8-20020a056820210800b0056c5e21c72dmr14882139oob.1.1691099754239;
        Thu, 03 Aug 2023 14:55:54 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:48ea:73bf:1876:eaf3])
        by smtp.gmail.com with ESMTPSA id w15-20020a4aa98f000000b005660ed0becesm321978oom.39.2023.08.03.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:55:53 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power supplies
Date:   Thu,  3 Aug 2023 18:55:05 -0300
Message-Id: <20230803215506.142922-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

WM8960 has the following power supplies:

- AVDD
- DBVDD
- DCVDD
- SPKVDD1
- SPKVDD1

Add them to bindings to improve the hardware description.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../devicetree/bindings/sound/wlf,wm8960.yaml | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
index ee8eba7f0104..82519f6720ef 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
@@ -26,6 +26,21 @@ properties:
   '#sound-dai-cells':
     const: 0
 
+  AVDD-supply:
+    description: Analogue supply.
+
+  DBVDD-supply:
+    description: Digital Buffer Supply.
+
+  DCVDD-supply:
+    description: Digital Core Supply.
+
+  SPKVDD1-supply:
+    description: Supply for speaker drivers 1.
+
+  SPKVDD2-supply:
+    description: Supply for speaker drivers 2.
+
   wlf,capless:
     type: boolean
     description:
@@ -84,5 +99,10 @@ examples:
             wlf,hp-cfg = <3 2 3>;
             wlf,gpio-cfg = <1 3>;
             wlf,shared-lrclk;
+            DCVDD-supply = <&reg_audio>;
+            DBVDD-supply = <&reg_audio>;
+            AVDD-supply = <&reg_audio>;
+            SPKVDD1-supply = <&reg_audio>;
+            SPKVDD2-supply = <&reg_audio>;
         };
     };
-- 
2.34.1

