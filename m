Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F66766F40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbjG1OTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjG1OTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F871724
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so23179475e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553967; x=1691158767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KudsjLXhwuLL2d8mNXrF7qeXjTkj4g+r6rSckABUYoI=;
        b=Z2kDCPjN1LPXmd6+dLzNEdwFl0tm/J1OLyqOgx9lpAsei0DTcOZ9Rm1TDDyeMaVx4Q
         3TANE5fPp+7puCmC7KkIkWm8DLldEvX2ymDm6Z3g86nbpRbss9VIUAsUEukjSlLf107L
         l07dHdPmuGB1D1F6XIuVwYaY4mWWFIc2GEC4tbe4UoB6KPJdJHyPrTjvWZkFocjJMFFh
         INI30gTj79+BSROU9eSzL7vz5c9j23uYGU+fMqgGmzsmpmPKqyRIc8wCFo9ra4nfADpW
         AujkGy8Gsl+XROI4Q/lME/cNih96/ktTbwm7FBKcBPack9lbfXjLSlqPdw+pCbBH/j+5
         MFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553967; x=1691158767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KudsjLXhwuLL2d8mNXrF7qeXjTkj4g+r6rSckABUYoI=;
        b=IAQ8Zv+9+99a1nj2lZDBALXSnbAsB9nYgtOknWu9w/rgTCchNB34/hWsHduJcuNpIj
         q3ooMm51P3MHGYESU+CdcGELWS6d9ZWoNPqdVcgliNn4WAhyHynhN9GZkn1CRd0RUCJn
         qghlmtqTjJZiyC43IaSR/14TwnJAAW/tvamYNbWguiLQ6WhIK3AOYbfHX43Ln6GKNPWZ
         K1DvHDzBK96APS6IgcmyDQpOwt/kuNlaUZwMMKjgm/2cTTlU3vMe7vhGBKhyrv0BzDSB
         jeuoB/lPjhlU9SwuWsvnjCmSrQ7MztVyxq7lufVe1f/Q0M8zph4eC+4YNs/VoNzlZcey
         9Svw==
X-Gm-Message-State: ABy/qLasG3DWUity7VvH0TF9X2MBdiFAfbCEZZGRu+FpZFNZEsMEfPv6
        8GGjkf10xFh/ynmvc3b1YJvGew==
X-Google-Smtp-Source: APBJJlFlCbcYPtP9PubsLuQd0EaqWiZsnjn2BGoHiyX0S1ujBgKIIU8F6mzjr6MSr0vf3fYIXplKTw==
X-Received: by 2002:a1c:4c12:0:b0:3fd:ad65:ea8b with SMTP id z18-20020a1c4c12000000b003fdad65ea8bmr1857466wmf.12.1690553966984;
        Fri, 28 Jul 2023 07:19:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:26 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
Date:   Fri, 28 Jul 2023 16:19:18 +0200
Message-Id: <20230728141923.162477-2-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
References: <20230728141923.162477-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two new chips do not have state or wake pins.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
index e3501bfa22e9..170e23f0610d 100644
--- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
 This file provides device node information for the TCAN4x5x interface contains.
 
 Required properties:
-	- compatible: "ti,tcan4x5x"
+	- compatible:
+		"ti,tcan4552", "ti,tcan4x5x"
+		"ti,tcan4553", "ti,tcan4x5x" or
+		"ti,tcan4x5x"
 	- reg: 0
 	- #address-cells: 1
 	- #size-cells: 0
@@ -21,8 +24,10 @@ Optional properties:
 	- reset-gpios: Hardwired output GPIO. If not defined then software
 		       reset.
 	- device-state-gpios: Input GPIO that indicates if the device is in
-			      a sleep state or if the device is active.
-	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+			      a sleep state or if the device is active. Not
+			      available with tcan4552/4553.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device. Not
+			     available with tcan4552/4553.
 
 Example:
 tcan4x5x: tcan4x5x@0 {
-- 
2.40.1

