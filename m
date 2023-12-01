Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62912800CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbjLAOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbjLAOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:09:37 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668781B2;
        Fri,  1 Dec 2023 06:09:43 -0800 (PST)
Received: from [185.238.219.102] (helo=akair)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1r94D6-006uXL-CN; Fri, 01 Dec 2023 15:09:40 +0100
Date:   Fri, 1 Dec 2023 15:09:37 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        kristo@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: ti: Convert interface.txt to
 json-schema
Message-ID: <20231201150937.3631ee99@akair>
In-Reply-To: <221ba6a3-c4c2-40cd-b1d8-8170af78c784@linaro.org>
References: <20231127202359.145778-1-andreas@kemnade.info>
        <7a62ed8a-b0e3-4881-90d7-b8f5d38e482e@linaro.org>
        <20231128093241.707a4fa0@aktux>
        <7361082a-f271-4ef4-9dad-06ee7445c749@linaro.org>
        <20231128214116.22dfff1e@akair>
        <221ba6a3-c4c2-40cd-b1d8-8170af78c784@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 29 Nov 2023 09:15:57 +0100
schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:

> On 28/11/2023 21:41, Andreas Kemnade wrote:
> > Am Tue, 28 Nov 2023 09:41:23 +0100
> > schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:  
> >>> If the interface clock is not below a ti,clksel then we have reg.
> >>>    
> >>
> >> This should be expressed in the bindings. It's fine to make the reg
> >> optional (skip the description, it's confusing), but the ti,clksel
> >> should reference this schema and enforce it on the children.
> >>  
> > Well there are other compatibles below ti,clksel, too, so should we
> > rather add them when the other .txt files are converted?  
> 
> This binding should already be referenced by ti,clksel. When the other
> are ready, you will change additionalProperties from object to false.
>
I played around with it:

--- a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
+++ b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
@@ -33,6 +33,11 @@ properties:
     const: 2
     description: The CLKSEL register and bit offset
 
+patternProperties:
+  "-ick$":
+    $ref: /schemas/clock/ti/ti,interface-clock.yaml#
+    type: object
+
 required:
   - compatible
   - reg

 
That generates warnings, which look more serious than just a
non-converted compatible, so lowering the overall "signal-noise-ratio".

e.g.
from schema $id:
http://devicetree.org/schemas/clock/ti/ti,clksel.yaml#
/home/andi/linux-dtbs/arch/arm/boot/dts/ti/omap/omap3-overo-tobiduo.dtb:
clock@c40: clock-rm-ick: 'ti,index-starts-at-one', 'ti,max-div' do not
match any of the regexes: 'pinctrl-[0-9]+'

I think we should rather postpone such referencing.

Regards,
Andreas
