Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FC752B90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjGMUVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGMUVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:21:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E0B270A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:21:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso10790575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689279688; x=1691871688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu/GDhcwUxsvL43jGqclDZQDypGt+f942j4Xw/QXrGg=;
        b=YkD+Q83ltv+kU8HU1a1in/Vn+A/+Xwen6hJBVY+vo3OV5uUfwbiU2zsuoRGcRr6NXR
         QKCBiPjoCJNEBsjd9EFvtNFI+wumxisFxgWc3yqfLfLTeL/CyOeSwCifte3tAXiu8WGn
         XuXtW5w9SXyZEzJcQ/R9i7dj8YGVrFHwxR/pxPvTLTol/tZPHLKNqbjPiZmzf7rFDx6E
         Rh0URafWo0vEiE2KSlyLKp/e9pmgUtMv27OxKaNiIBVOzaumAiv09OiMbpQXw/IE81dv
         O14sgmFFcX3k9cC4fp1hgWZgjMzKx8Rx/H9XFSiAKOudZWz7G/z3nhjSvU4HoDw1y5Oz
         dNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689279688; x=1691871688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu/GDhcwUxsvL43jGqclDZQDypGt+f942j4Xw/QXrGg=;
        b=D7hzYJdF4tu9k8Wwv3D201qjjLEbyyxRu2iyGx0l45gg33Xtt+NRdPiIqZd18fDyfd
         KwmbinifWBZ6O1xbgopfC8WAc8I8t70v5RS55PBJKjWuMskUiFY3Bqc6XsqqDzfC/QYs
         Wjw/+j1gnVX7LUsQiCcAbZklEj1W7yOCgrx7BwBSNmiL1ZeSKd8sKZcjQWPfhVcWo5RO
         GKRTF5C1ZhjPM89Rn7gMrqWd4xStPQKcAXHbPBQ+vB5dA41g8pXfZJVX0MCGLaW8985v
         xaR/rGHej1fHoUbYE/fU5F78d14U03vY2PX1qY5TKhv4l+pvWwyrZbP1EKkbKmP5//h0
         j+YA==
X-Gm-Message-State: ABy/qLYl+Efo5GVvnI8VbgqHxl4LZmW7h7nu9I0ZrOhX2h1lLxigPezY
        kqkAgChTJnpQldxXcGSGxFa8JA==
X-Google-Smtp-Source: APBJJlHBykbtYqkHA08c+4gz/CRYPt9l0egxhftE4bkM/EwH/3Exd9LU6Vp1eWCc+sTTmMpXsjpQlg==
X-Received: by 2002:a7b:c40d:0:b0:3fc:1a6:7764 with SMTP id k13-20020a7bc40d000000b003fc01a67764mr2241997wmi.16.1689279688330;
        Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
Received: from localhost.localdomain ([188.27.129.168])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d560d000000b0031590317c26sm8880170wrv.61.2023.07.13.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:21:28 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, alex@shruggie.ro, marius.muresan@mxt.ro
Subject: [PATCH v2 2/2] dt-bindings: net: phy: vsc8531: document 'vsc8531,clkout-freq-mhz' property
Date:   Thu, 13 Jul 2023 23:21:23 +0300
Message-ID: <20230713202123.231445-2-alex@shruggie.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713202123.231445-1-alex@shruggie.ro>
References: <20230713202123.231445-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For VSC8351 and similar PHYs, a new property was added to generate a clock
signal on the CLKOUT pin.
This change documents the change in the device-tree bindings doc.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Changelog v1 -> v2:
* https://lore.kernel.org/netdev/20230706081554.1616839-2-alex@shruggie.ro/
* changed property name 'vsc8531,clkout-freq-mhz' -> 'mscc,clkout-freq-mhz'
  as requested by Rob
* added 'net-next' tag as requested by Andrew

 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 0a3647fe331b..085d0e8a834e 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -31,6 +31,10 @@ Optional properties:
 			  VSC8531_LINK_100_ACTIVITY (2),
 			  VSC8531_LINK_ACTIVITY (0) and
 			  VSC8531_DUPLEX_COLLISION (8).
+- mscc,clkout-freq-mhz	: For VSC8531 and similar PHYs, this will output
+			  a clock signal on the CLKOUT pin of the chip.
+			  The supported values are 25, 50 & 125 Mhz.
+			  Default value is no clock signal on the CLKOUT pin.
 - load-save-gpios	: GPIO used for the load/save operation of the PTP
 			  hardware clock (PHC).
 
@@ -69,5 +73,6 @@ Example:
                 vsc8531,edge-slowdown	= <7>;
                 vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
                 vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
+                mscc,clkout-freq-mhz	= <50>;
 		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
         };
-- 
2.41.0

