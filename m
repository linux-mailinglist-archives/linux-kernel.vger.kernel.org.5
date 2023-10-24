Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497247D480E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjJXHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjJXHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:10:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D266128;
        Tue, 24 Oct 2023 00:10:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB329C433C7;
        Tue, 24 Oct 2023 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698131434;
        bh=Z4ErVGiETF75rMOL77a2488vSE0IFuWOrinZbfg0xPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1yvNZZu5DGvgXDyFCxcIM+jrzKgSuFMG+l1IKizIC0Ats6DvD1G/mxrkDCB3sfNx
         R5LDhxL2dbPjedFA0Hvuw906WKqNA0R5oeCJ4WZh+D3krVYPeS5lKl1+jqaySXDf8L
         vpjsRItS1Fk6qju6gvPaGdTAg2jAIxqg3f3ovud6mF4xPqXEgDvJZq+OHJXy1fYQsW
         kJO4+5wN4DRaMU3oFwEUg1Kyb2olF5eqElYRIEXFqY/9RCH1yAkWp4lIWe7y8QchbC
         E/vA4wWRavESOPgeErsXvQ+SewOT1QseLUoSFFU6Ulk4Lq0erlFCkJmnm2aUTd0Mz2
         QumVTpQ1bl62A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvBYx-0003dX-0K;
        Tue, 24 Oct 2023 09:10:51 +0200
Date:   Tue, 24 Oct 2023 09:10:51 +0200
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
Subject: Re: [PATCH v13 06/10] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Message-ID: <ZTdt-wyCHh3i0SlK@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-7-quic_kriskura@quicinc.com>
 <ZTaViatsRY7LCbIX@hovoldconsulting.com>
 <7e9bdd65-35b7-43c2-810a-2cd81f736084@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9bdd65-35b7-43c2-810a-2cd81f736084@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:57:04PM +0530, Krishna Kurapati PSSNV wrote:
> On 10/23/2023 9:17 PM, Johan Hovold wrote:
> > On Sat, Oct 07, 2023 at 09:18:02PM +0530, Krishna Kurapati wrote:
> >> Currently wakeup is supported by only single port controllers. Read speed
> >> of each port and accordingly enable IRQ's for those ports.
> >>
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
  
> >> -static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> >> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
> >> +							int port_index)
> > 
> > No need for line break (since it's a function definition).
> > 
> >>   {
> >>   	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> >>   	struct usb_device *udev;
> >> @@ -348,12 +349,10 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> >>   
> >>   	/*
> >>   	 * It is possible to query the speed of all children of
> >> -	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> >> -	 * currently supports only 1 port per controller. So
> >> -	 * this is sufficient.
> >> +	 * USB2.0 root hub via usb_hub_for_each_child().
> > 
> > This comment no longer makes sense with your current implementation.
> > 
> Can you help elaborate on your comment ? Do you mean that this API 
> doesn't get speed on all ports, but this has to be called in a loop to 
> get all the port speeds ? In that sense, I agree, I can change the 
> comments here.

It does not make sense to keep only half the comment after your update
as it is a suggestion for how one could go about and generalise this for
multiport, which is what you are now doing.
 
> > But perhaps this should be done using usb_hub_for_each_child() instead
> > as that may be more efficient. Then you use this function to read out
> > the speed for all the ports in go (and store it in the port structures I
> > mentioned). Please determine which alternative is best.
> > 
> Either ways is fine. We would have qcom->num_ports to determine how many 
> speeds we can read.

That's not the point. I'm referring to which alternative is less
computationally expensive and allows for a clean implementation.

Please do try to figure it out yourself.
 
> >>   	 */
> >>   #ifdef CONFIG_USB
> >> -	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> >> +	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
> >>   #else
> >>   	udev = NULL;
> >>   #endif
> >> @@ -386,23 +385,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
> >>   
> >>   static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
> >>   {
> >> +	int i;
> >> +
> >>   	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
> >>   
> >> -	if (qcom->usb2_speed == USB_SPEED_LOW) {
> >> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
> >> -	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
> >> -			(qcom->usb2_speed == USB_SPEED_FULL)) {
> >> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
> >> -	} else {
> >> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
> >> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
> >> -	}
> >> +	for (i = 0; i < qcom->num_ports; i++) {
> >> +		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
> >> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
> >> +		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
> >> +			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
> >> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
> >> +		} else {
> >> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
> >> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
> >> +		}
> >>   
> >> -	dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0]);
> >> +		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][i]);
> >> +	}
> >>   }
> > 
> > The above is hardly readable, partly because of the 2d array that I
> > think you should drop, and partly because you add the port loop here
> > instead of in the caller.
> > 
> > A lot of these functions should become port operation where you either
> > pass in a port structure directly or possibly a port index as I've
> > mentioned before.
> 
> With your suggestion, yes, this can be refactored to be readable.
> 
> > 
> > [ I realise that the confusion around hs_phy_irq may be partly to blame
> > for this but since that one is also a per-port interrupt, that's no
> > longer an issue. ]
> 
> I don't want to add support for this right away [1]. I would like to 
> keep hs_phy_irq outside the loop for now.

No. Stop trying to take shortcuts. Again, this is upstream, not
Qualcomm's vendor kernel.

Johan
