Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82E47F7570
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjKXNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKXNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:45:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C71BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:45:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C789FC433C7;
        Fri, 24 Nov 2023 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700833541;
        bh=EzqT4v8vZXGnSVX9M8qsp06zVhLbFhH0kYlZVwhXdTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9CzBtB2XVBvWvf4qEK3/cdglI9Ej7m5YdPkCvTE+vmSq5ifMZ2s4WhZWi1FX+EXn
         TRyZ00bY4BMjVSHD4o4EYG5nFg6paKOdsFYqoXpj0ZYYd/4/m6FZN03E28fvxwYaa0
         g217e4oJwaTF2ou1LKMh5Fyn0oVi8xOHeExMJ3HE2SKEFeCuj/E/syDZMFAHBvC74o
         w3qn/gPd+hCVGb4mXNnmDwlHA4rSNFL5BAY+onlyPUL9JrJp3IbyKG5IMZ7VknUqRe
         mi9L9uzoAZY9rvSSx6sh1Nttv1AWD+eMAnnA3MsIXVqT64ts57gqtq0fSmqvnbGmV9
         yECsf5Sc3zlRw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r6WVN-0000to-1Y;
        Fri, 24 Nov 2023 14:46:02 +0100
Date:   Fri, 24 Nov 2023 14:46:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH 1/6] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 bindings
Message-ID: <ZWCpGdJRexnk98IN@hovoldconsulting.com>
References: <20231122191335.3058-1-quic_kriskura@quicinc.com>
 <ZV9dYpTYRXn63tXe@hovoldconsulting.com>
 <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1192d91f-11bf-44af-953a-14e08e2b6ca8@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 05:32:37PM +0530, Krishna Kurapati PSSNV wrote:
> > 
> > Thanks for sorting this out.
> > 
> > It seems like we have a few combinations of these interrupts and we
> > should probably try to define the order for these once and for all and
> > update the current devicetrees to match (even if it means adding new
> > interrupts in the middle).
> > 
> > Instead of adding separate compatibles for the controllers without SS
> > support, I suggest keeping that interrupt last as an optional one.
> > 
> > But IIUC we essentially have something like:
> > 
> > qusb2-:
> > 
> > 	- const: qusb2_phy
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> > qusb2:
> > 
> > 	- const: hs_phy_irq
> > 	- const: qusb2_phy
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> > qusb2+:
> > 
> > 	- const: hs_phy_irq
> > 	- const: qusb2_phy
> > 	- const: dp_hs_phy_irq
> > 	- const: dm_hs_phy_irq
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> 
> This combination doesn't exist. So we can skip this one.

Ok, good. I thought you said some QUSB2 platforms used DP/DM, but I guess
that means they don't have the qusb2_phy interrupt then.
 
> > femto-:
> > 	- const: dp_hs_phy_irq
> > 	- const: dm_hs_phy_irq
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> > femto:
> > 	- const: hs_phy_irq
> > 	- const: dp_hs_phy_irq
> > 	- const: dm_hs_phy_irq
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> > Does this look like it would cover all of our currents SoCs?
> > 
> > Do all of them have the pwr_event interrupt?
> 
> Yes. From whatever targets I was able to find, only one of them didn't 
> have the power_event irq. Rest all of them had. I will recheck that 
> particular one again.

Please do. The driver polls the corresponding status register on all
platforms currently, and perhaps this interrupt can one day be used to
get rid of the polling.
 
> > Note that DP comes before DM above as that seems like the natural order
> > of these (plus before minus).
> > 
> > Now if the HS interrupt is truly unusable, I guess we can consider
> > dropping it throughout and the above becomes just three permutations
> > instead, which can even be expressed along the lines of:
> 
> Infact, I wanted to do this but since you mentioned before that if HW 
> has it, we must describe it, I kept it in. But since this functionality 
> is confirmed to be mutually exclusive of qusb2/{dp/dm}, I am aligned to 
> skip it in bindings and drop it in DT.

As I mentioned elsewhere, it depends on whether it can be used at all.
Not simply whether there is some other mechanism that can be used in its
stead. Such a decision should be left up to the implementation.

That's why I said "truly unusable" above. It's still not clear to me
whether that is the case or not.

> > 	- anyOf:
> > 	  - items:
> > 	    - const: qusb2_phy
> > 	  - items:
> > 	    - const: dp_hs_phy_irq
> > 	    - const: dm_hs_phy_irq
> > 	- const: pwr_event
> > 	- const: ss_phy_irq	(optional)
> > 
> 
> This must cover all cases AFAIK. How about we keep pwr_event also 
> optional for time being. The ones I am not able to find also would come 
> up under still binding block.

No, we should avoid that if we can as with two many optional things,
these quickly gets messy (one optional interrupt at the end is fine and
can be expressed using min/maxItems).

If the "qusb2+" combination above isn't needed, then we're down to four
permutations, which is few enough to be spelled out explicitly even if
we decide that the hs_phy_irq should be kept in. Without hs_phy_irq, it
seems there's really only two permutations.

Johan
