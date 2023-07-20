Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084F275A8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGTIHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGTIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:07:44 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5C6213C;
        Thu, 20 Jul 2023 01:07:39 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTPS Server V6.0(2903814:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 20 Jul 2023 16:07:29 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 20 Jul
 2023 16:07:28 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 20 Jul 2023 16:07:28 +0800
Date:   Thu, 20 Jul 2023 16:07:28 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Message-ID: <20230720080728.GA10433@linuxcarl2.richtek.com>
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
 <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Krzysztof:

On Wed, Jul 19, 2023 at 11:44:45AM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2023 11:24, alina_yu@richtek.com wrote:
> > From: alinayu <alina_yu@richtek.com>
> > 
> > Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> > 
> > Signed-off-by: Alina Yu <alina_yu@richtek.com>
> > ---
> > v4
> > - Modify filename to "richtek,rtq2208"
> > - Add more desciptions for "regulator-allowed-modes"

...

> > +
> > +          regulator-mode:
> > +            enum: [0, 1]
> > +            description:
> > +              describe buck initial operating mode in suspend state.
> 
> There is no such property on this level. Aren't you mixing initial one?

It's the initial mode in suspend-mem state, should I modify that like this ?
        patternProperties:
          "^regulator-state-(standby|mem|disk)$":
	    type: object
	    $ref: regulator.yaml#
	    properties:
	      regulator-mode:
	        enum: [0, 1]
		description:
                  describe byck initial operating mode in suspend state.
...

> 
> > +            enum: [ 900000, 1200000, 1800000, 3300000 ]
> > +            description:
> > +              the fixed voltage in micro volt which is decided at the factory.
> 
> I don't understand this property. Why this is different from min/max


Because ldo has fixed voltage, so I thinks I could use a property to
represent the fixed voltage directly. Do you suggest me modifying that like this:

regulator-min-microvolt = <900000>;
regulator-max-microvolt = <900000>;

Using min voltage equals to max voltage to represent fixed voltage, instead of self-defined property ?


> microvolt? Plus, you use incorrect unit suffix.

if I change "richtek,fixed-uV" to "richtek, fixed-microvolt",
will it be a correct unit suffix ?

Best regards,
Alina
