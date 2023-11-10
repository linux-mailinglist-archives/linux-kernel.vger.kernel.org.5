Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030657E802D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjKJSHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjKJSFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C32A25E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 02:44:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6182C433C7;
        Fri, 10 Nov 2023 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699613054;
        bh=yViYqOJVdcBEk5fwPiwK27bzW7FkRKcbTn6zst1rjt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qSLHNlzm4RnBkdR24TluN7Dng6mOBC3pzmQzkUClpylay3CL16NwjJ4Alj7CX5f9F
         f80FulVCDie4nGya1NifjrM6e1++EFxYSeROku/SICA4BjLLyLTmIF1HM8/9JdEsTP
         0+V2tqprbkPF+dNDMKlgOHfiq1Swk4V5j7J6eYKrF1aipAA6F33s5wP34O7pnwzeQt
         Jox5DBmzqhJzsaslk6mATLVU6HIlMivBY5xCcCWj4GG7xmQ0SraDM8cRLywLjECZ9/
         I8TdDIOkFhDlXm/5suafwLqc6rwkcUS5i5c01ugOYrykmTRFJvO5Ji7Ul7EcMOpP59
         itVv9KhxpAHrg==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r1Ozh-0004rg-14;
        Fri, 10 Nov 2023 11:44:09 +0100
Date:   Fri, 10 Nov 2023 11:44:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <ZU4JeenAf_K8liAI@hovoldconsulting.com>
References: <ZTY7Lwjd3_8NlfEi@hovoldconsulting.com>
 <cabf24d0-8eea-4eb5-8205-bf7fe6017ec2@quicinc.com>
 <ZTZ-EvvbuA6HpycT@hovoldconsulting.com>
 <fb5e5e1d-520c-4cbc-adde-f30e853421a1@quicinc.com>
 <ZTdqnSHq_Jo8AuPW@hovoldconsulting.com>
 <04615205-e380-4719-aff1-f32c26004b14@quicinc.com>
 <ZUz4RD3MjnLlPn6V@hovoldconsulting.com>
 <2b19b5e2-5eb0-49e0-8c47-8aff3d48f34e@quicinc.com>
 <ZU31gx-LY5GBJGPU@hovoldconsulting.com>
 <dc20ecc0-f930-49c5-9e21-5a6e4c8ce637@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc20ecc0-f930-49c5-9e21-5a6e4c8ce637@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 03:31:15PM +0530, Krishna Kurapati PSSNV wrote:

> Controller-1:
> u_usb31_prim_mvs_wrapper_usb31_hs_phy_irq	SYS_apcsQgicSPI[806]
> Controller-2:
> u_usb31_prim_mvs_wrapper_usb31_hs_phy_irq	SYS_apcsQgicSPI[791]

Thanks.

> > Yes, but, again, you never enabled them in the PHY (cf. QUSB2) so it's
> > hardly surprising that they do not fire.
> > 
> There is no register in femto phy address space of sc8280 (which I am
> currently testing) where we can configure these registers like qusb2 phy's.

Right, so they are not enabled (and possibly cannot be enabled).

> > So then including the hs_phy_irq for most of these SoCs was a mistake
> > and we should drop it from the bindings?
> > 
> > What about the QUSB2 SoCs that also define DP/DM, are both useable
> > there?
> > 
> > And if so, is there any reason to prefer one mechanism over the other?
> 
> No. I didn't ask this question to hw team whether dp/dm are used in qusb2
> phy targets. Let me ask them.
> 
> While I do so, since there are no qusb2 targets present on femto phy's, do
> you suggest we still add them to port structure in dwc3-qcom ? I am inclined
> to add it because it would make implementation look cleaner w.r.t code and
> also spurious interrupts are not getting triggered (which was my primary
> concern as it was never tested).

Yes, that's what I've been suggesting all along. It's a per-port
interrupt so that's where it belongs. 

We should still try to determine when each interrupt should be enabled
and how best to implement that (hence all my questions).

For example, if there is no use for hs interrupts on SoCs using femto
PHYs we should fix the bindings. If we can use dp/dm on SoCs using QUSB2
PHYs, we should probably just ignore the hs interrupt when all three are
defined (especially since that functionality has never worked anyway).

Johan
