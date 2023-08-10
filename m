Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF067776C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHJLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjHJLUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:20:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D42269F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5234f46c6f9so996118a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666402; x=1692271202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZOeWP2uVJNQooQGaWrKsom5vyBYi2Cs+dRQqMbSinA=;
        b=uhoOcvUVe0bA9VDaUDB4CZbwjc5LjFePldDAsSpXK/ssG/QT0MLJREbMIGY33+qJIq
         VkUuYjbOa+iNIk6eFCWlUwc463Mk0BbV5tnKsxPA7l0FjZGRtj+lyuMFEliYLbCpbNaq
         FjDJ7xIbMOJLCoJeVrYiwbo7q0M8NtkjaoyAXbxx1q8MTvy2Pug1EUgprmo6nAmkXIbC
         baHYZcn9h0ph6NxdatVgHCgdjmnyBV8MCEAlwmaOXNMQt8IduJOKuZIk3XEe4sw+bM2Z
         z/DvTBh0iG6Lj8magBqNfYKtBRfUAF2AJFV0Qy+FspzQRLDeCnMCQ1Wz0xBBmdbBF/r6
         jY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666402; x=1692271202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZOeWP2uVJNQooQGaWrKsom5vyBYi2Cs+dRQqMbSinA=;
        b=PBmXdeKLw5qBusieoEyLxDpJi36RqoP21hGMM9VoXlzgtBykyv3Wq8eO5GI7ij9dwb
         s/uvksSJ9Bqrnpn9bYK/vWfDTJXYPyysy6Y2RmWdRcOgcdi1mkFKJFZvhY391NYGjjQc
         V27ZKkZ5WEkvcpcWggwLt0pI/B1SuATv2Z2RVuIw9NX6yNb2XI3gq/s9VKTkCMceDjkr
         pY7A5iH459EHXlHRWTn/3wf0opNUmlxdMwU8CxIcvHHgznMSb3OURN3yr9IC8YA2iWgw
         kD8bL3ce41xXNOEOHAVU7c+j5IQ1wxPPPme+YZMxTYFNdnxpFmX2XtGppoKS/7gq/wUy
         pWaQ==
X-Gm-Message-State: AOJu0YzOdw9hVZgP1iiNrFkRxeME3YZq/XWXHXFmmDhz3waT7BOthAfT
        p/HvQuVEdsEewsLOq+4ZAbC5NhCuTfCkd26hiAt+vQ==
X-Google-Smtp-Source: AGHT+IEb7M7bOgezkAsIz5lgjpCqtLrCj++G22+kk8Us63mXo1tAqwqs1h6gIoztO+7rG9pP/dFhIg==
X-Received: by 2002:aa7:c148:0:b0:523:6c47:56f8 with SMTP id r8-20020aa7c148000000b005236c4756f8mr1903226edp.18.1691666401948;
        Thu, 10 Aug 2023 04:20:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7d94a000000b0051a2d2f82fdsm672190eds.6.2023.08.10.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:20:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 13:19:56 +0200
Message-Id: <20230810111958.205705-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
References: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'family' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  drivers/phy/broadcom/phy-bcm-ns-usb3.c:209:17: error: cast to smaller integer type 'enum bcm_ns_family' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/broadcom/phy-bcm-ns-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index bbfad209c890..69584b685edb 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -206,7 +206,7 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
 	if (!of_id)
 		return -EINVAL;
-	usb3->family = (enum bcm_ns_family)of_id->data;
+	usb3->family = (uintptr_t)of_id->data;
 
 	syscon_np = of_parse_phandle(dev->of_node, "usb3-dmp-syscon", 0);
 	err = of_address_to_resource(syscon_np, 0, &res);
-- 
2.34.1

