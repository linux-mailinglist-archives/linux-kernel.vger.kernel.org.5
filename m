Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D076F7D47C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjJXG4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjJXG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:56:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FED592;
        Mon, 23 Oct 2023 23:56:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C924DC433C8;
        Tue, 24 Oct 2023 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698130573;
        bh=EV4VOJE8vL5U09j1FWreOW/O4tPUOMNuDQvuEyy9q84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IV6DlaEAIJr9GrDxMfFMEbjQMrcJvLcsy0GuqAeJN080WDLom6NDCL+nVn7+eudl5
         hkO49bsu+tzH0wXYnpbY9DKa1NnNBA/KjdX5M630I2Ut5N9NEUkAHZsQfMMhKCd6cx
         WseiUXJJtBp7gqkkRi9AuWayM+PYG+VwK6MSJV1qXwIl9lqjwoaHTa9e6nmocZJrnD
         fNIHAfbETiDI5Vjw5CLNp1oI+z7d2kqBexPb/xlzStqqNRMceBRdM4O5/CKMIutdXm
         K9C1wvvYfWAuY826aPYbS8pPHUUGKWRElfG7k/PiXh3Re6EpnSubweH0GbZuWpNU/8
         FoQo0ZYsW4+7w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBL3-0003aq-0n;
        Tue, 24 Oct 2023 08:56:29 +0200
Date:   Tue, 24 Oct 2023 08:56:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 05/10] usb: dwc3: qcom: Refactor IRQ handling in QCOM
 Glue driver
Message-ID: <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-6-quic_kriskura@quicinc.com>
 <ZTJ_T1UL8-s2cgNz@hovoldconsulting.com>
 <14fc724c-bc99-4b5d-9893-3e5eff8895f7@quicinc.com>
 <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:42:31PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 7:37 PM, Johan Hovold wrote:

> > Right. And I assume there are hs_phy_irqs also for the first two USB
> > controllers on sc8280xp?

> There are, I can dig through and find out. Atleast in downstream I don't 
> see any use of them.

Yes, please do post how these are wired as well for completeness.

> > Can you find out anything more about what hs_phy_irq is used for? It
> > appears to be an HS wakeup interrupt like the dp/dm ones, but there are
> > not really any details on how it is supposed to be used.
> 
>   This IRQ is really not used in downstream controllers. Not sure if its 
> a good idea to add driver code for that. I did some digging and I got 
> the reason why I first said that there is only one hs_phy_irq for 
> tertiary port of controller. The hardware programming sequence doesn't 
> specify usage of these 4 IRQ's but the hw specifics mention that there 
> are 4 of them. Adding driver support for these IRQ's is not a good idea 
> (atleast at this point because they are not used in downstream and I am 
> not sure what would be the side effect). For now I suggest we can add 
> them in bindings and DT and not handle the 4 hs_phy_irq's in the driver 
> code (meaning not add the hs_phy_irq to port structure we plan on adding 
> to dwc3_qcom).

But there is already support for these interrupts in the driver. You
work for Qualcomm who built the thing so surely you can figure how they
intended these to be used?

You need to provide this information so that we can determine what the
binding should look like. The implementation would also be simplified if
we don't have to add random hacks to it just because we don't know why
the vendor driver you refer does not use it currently on this particular
platform.

> Also I plan on splitting the patchset into 4 parts (essentially 4 diff 
> series):
> 
> 1. Bindings update for hs_phy_irq's
> 2. DT patches for MP controller and platform specific files
> 3. Core driver update for supporting multiport
> 4. QCOM driver update for supporting wakeup/suspend/resume
> 
> This is in accordance to [1] and that way qcom code won't block core 
> driver changes from getting merged. Core driver changes are independent 
> and are sufficient to get multiport working.

No, you clearly did not understand [1] at all. And stop trying to game
the upstreaming process. Bindings and driver patches go together. The
devicetree changes can be sent separately in case of USB but only
*after* the first set has been merged.

If the code had been in good shape from the start it would have been
merged by now. Just learn from your mistakes and next time things will
be smoother.

> [1]: 
> https://lore.kernel.org/all/d4663197-8295-4967-a4f5-6cc91638fc0d@linaro.org/

Johan
