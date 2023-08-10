Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6287783CF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjHJWuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjHJWt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:49:58 -0400
Received: from out-94.mta0.migadu.com (out-94.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413192D51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:49:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691707796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dL6Ngh+RAsXyB4bL14IUKXOWyHxi2/XnqLmZv3QLPZQ=;
        b=G9D1ygqU6bbwFGM7Kci4Z/8jwSyUr8F/yB30/CiYLshmPVQBjrE6hbeiDs0EpOveaKmXdN
        abyrTmC6w5uXLqUAqv6nXO4vdpnyGm2vkIaCUcqKdpOpHEeae7AKXB75xTLPF5mhRp+iOL
        Rdu1P3R3GnLiOWu8MdOte7DD9Tx8D1TPZfAAk/6146hGldYLfclp14L7G71CyDQHSq4HKG
        h6rEBXWFAaN3rtgXktGERljrZLgCjd9TFQVl6YaznzZ+OkMlYT/G/5jITG2vSQHB5Iu2lR
        8AT2tG8Tgrrq0PLx5Rg1848NOX3W7AySaIWc2EJZ1UaQs2YOeiv3xqhC8DqxSg==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8782: Add max-rate property
Date:   Fri, 11 Aug 2023 08:49:30 +1000
Message-ID: <20230810224930.3216717-4-contact@jookia.org>
In-Reply-To: <20230810224930.3216717-1-contact@jookia.org>
References: <20230810224930.3216717-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WM8782 can safely support rates higher than 48kHz by changing the
value of the FSAMPEN pin.

Allow specifying the maximum support rate the hardware configuration
supports in the device tree.

Signed-off-by: John Watts <contact@jookia.org>
---
 Documentation/devicetree/bindings/sound/wm8782.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
index 256cdec6ec4d..a68061a3e671 100644
--- a/Documentation/devicetree/bindings/sound/wm8782.txt
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -7,6 +7,7 @@ Required properties:
  - compatible  : "wlf,wm8782"
  - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
  - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
+ - max-rate    : max supported audio rate configured by FSAMPEN pin, defaults to 48000
 
 Example:
 
@@ -14,4 +15,5 @@ wm8782: stereo-adc {
 	compatible = "wlf,wm8782";
 	Vdda-supply = <&vdda_supply>;
 	Vdd-supply = <&vdd_supply>;
+	max-rate = <96000>; /* FSAMPEN is 1 */
 };
-- 
2.41.0

