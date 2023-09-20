Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13A17A89B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjITQqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjITQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:46:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C32CF;
        Wed, 20 Sep 2023 09:46:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0329EC433C7;
        Wed, 20 Sep 2023 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695228391;
        bh=v2nZUFJb75Eok75BEHLZ6a+wtZb+ffY5WGQfd+Wp6vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ef6SlilF31FSgPKwuu0WfymO6HNgzAimtyNgVfXKfqv7AxemX3k92g7NZKKmqxQdD
         4SYlOUJ3NC19NmGATgQLggWeCEqmQIj0Dp076wmr1fDow5nW7QNrs5X3UOMv5stdW4
         go6Pi4M76ibE/k/1ED9234/0h+LlBe98GE6wJ2S0His1lg6Nui0QNZZBeBYbaHNqzr
         Xzxxgou53z6XDr51xCg0v5RJ7qzTqlldli/pzFbLObGzy59GAC+dDDH2rysvGW0OIH
         6lRJlV/6Y5Ly4EMtOru/RNpBt18cUeQ/A4SdQf3kDd6px94oLuELcR/sB8x+tWYf1L
         lkgWknBLOspSg==
Date:   Wed, 20 Sep 2023 09:50:39 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio
 used to determine the Type-C port plug orientation
Message-ID: <zigqqjepj54v5vnmhm3r3knwrjd2rfw2njds4ul7vmxq3nfrua@rkupccyyxziw>
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
 <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
 <zhm72wrjg7yazutkinv5lx55dgqtm4hmuexw2ht24fu6txxk3d@oum27inbk7si>
 <7fc7371a-1b2d-ccce-1e73-6bfe70ea2b20@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc7371a-1b2d-ccce-1e73-6bfe70ea2b20@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:09:41AM +0200, Neil Armstrong wrote:
> On 04/08/2023 18:03, Bjorn Andersson wrote:
> > On Fri, Aug 04, 2023 at 03:50:07PM +0200, Neil Armstrong wrote:
> > > On SM8450 and SM8550 based platforms, the Type-C plug orientation is given on a
> > > GPIO line set by the PMIC.
> > > 
> > > Document this optional Type-C connector property, and take the
> > > assumption an active level represents an inverted/flipped orientation.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml  | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> > > index bceb479f74c5..1b0a00b19a54 100644
> > > --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> > > @@ -35,6 +35,11 @@ properties:
> > >     '#size-cells':
> > >       const: 0
> > > +  orientation-gpios:
> > > +    description: An input gpio for Type-C connector orientation, used to detect orientation
> > > +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
> > 
> > This is a per-connector/port property, as such be part of the connector
> > sub nodes rather than as a property of the shared pmic_glink entity.
> 
> This has been rejected by Rob, Dmitry & Krzysztof in:
> https://lore.kernel.org/all/0fbf55e7-2140-751d-5347-f907a46ef78c@linaro.org/
> &
> https://lore.kernel.org/all/20230608154751.GA2750742-robh@kernel.org/
> 
> Indeed the "GPIO" is not part of the physical USB-C connector, but a property,
> and it's not part of the PMIC GLINK firmware either, so ?
> 
> The PMIC function which generates this signal is handled by the PMIC GLINK
> firmware, so this representation is the most accurate.
> 

I don't think we reached a conclusion on the discussion that followed.
If this indeed is the path forward, please document clearly how the next
person should proceed when the need for handling multiple ports with
this scheme arise.

Thanks,
Bjorn

> Neil
> 
> > 
> > Regards,
> > Bjorn
> > 
> > > +    maxItems: 1
> > > +
> > >   patternProperties:
> > >     '^connector@\d$':
> > >       $ref: /schemas/connector/usb-connector.yaml#
> > > @@ -44,6 +49,19 @@ patternProperties:
> > >   required:
> > >     - compatible
> > > +allOf:
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              enum:
> > > +                - qcom,sm8450-pmic-glink
> > > +                - qcom,sm8550-pmic-glink
> > > +    then:
> > > +      properties:
> > > +        orientation-gpios: false
> > > +
> > >   additionalProperties: false
> > >   examples:
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
