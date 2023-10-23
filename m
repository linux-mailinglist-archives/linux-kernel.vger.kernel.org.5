Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA27D3B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjJWPrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjJWPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:47:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5239D;
        Mon, 23 Oct 2023 08:47:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF3EC433C7;
        Mon, 23 Oct 2023 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698076028;
        bh=L40xDQVgTfM0jKjY2CcPMsYuyMAVupFmFZq0N07DI+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbnK38bPQPrn092XhaR2cO/AxY4uEXjnMQcpC/NMA4g9AOotvxHqhhb8JjZVlNh5p
         oB2FU40IkKtsr3pZCmQVe51Lr5/HnWBgZsWMQGvZ64zfZAY54H8mymRuRdAcimCse5
         xL7UmT8q0D24Y0kqT/1VUpYyXsNAqiVjcXwlr0Hu/A4hfqXcuE3hpV0cF6PQV+Xi2y
         Wx1tS2qxw+84a4lTKT6VkzZiIvuiWF3rQtSLm7nPb3rMCMjvNWcFBuI1y97XII3rRs
         BRq4B6aNjAvrANDVhKkizGr3qX4UYGsxdi/14X66cP6GOTKAYmdHzHW6uQb2LKIVSZ
         CyAZrzZt+q6Ng==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qux9F-0001yj-3D;
        Mon, 23 Oct 2023 17:47:22 +0200
Date:   Mon, 23 Oct 2023 17:47:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
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
Message-ID: <ZTaViatsRY7LCbIX@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-7-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-7-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:18:02PM +0530, Krishna Kurapati wrote:
> Currently wakeup is supported by only single port controllers. Read speed
> of each port and accordingly enable IRQ's for those ports.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 65 +++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 863892284146..651b9775a0c2 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -90,7 +90,7 @@ struct dwc3_qcom {
>  	 */
>  	int			phy_irq[NUM_PHY_IRQ - 1][DWC3_MAX_PORTS];
>  	int			hs_phy_irq;
> -	enum usb_device_speed	usb2_speed;
> +	enum usb_device_speed	usb2_speed[DWC3_MAX_PORTS];

This also belongs in a new port structure.

>  	struct extcon_dev	*edev;
>  	struct extcon_dev	*host_edev;
> @@ -335,7 +335,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
>  	return dwc->xhci;
>  }
>  
> -static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
> +							int port_index)

No need for line break (since it's a function definition).

>  {
>  	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  	struct usb_device *udev;
> @@ -348,12 +349,10 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  
>  	/*
>  	 * It is possible to query the speed of all children of
> -	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> -	 * currently supports only 1 port per controller. So
> -	 * this is sufficient.
> +	 * USB2.0 root hub via usb_hub_for_each_child().

This comment no longer makes sense with your current implementation.

But perhaps this should be done using usb_hub_for_each_child() instead
as that may be more efficient. Then you use this function to read out
the speed for all the ports in go (and store it in the port structures I
mentioned). Please determine which alternative is best.

>  	 */
>  #ifdef CONFIG_USB
> -	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> +	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
>  #else
>  	udev = NULL;
>  #endif
> @@ -386,23 +385,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
>  
>  static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>  {
> +	int i;
> +
>  	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
>  
> -	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
> -	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
> -			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
> -	} else {
> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][0]);
> -		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][0]);
> -	}
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		if (qcom->usb2_speed[i] == USB_SPEED_LOW) {
> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
> +		} else if ((qcom->usb2_speed[i] == USB_SPEED_HIGH) ||
> +			(qcom->usb2_speed[i] == USB_SPEED_FULL)) {
> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
> +		} else {
> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DP_HS_PHY_IRQ_INDEX][i]);
> +			dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[DM_HS_PHY_IRQ_INDEX][i]);
> +		}
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][0]);
> +		dwc3_qcom_disable_wakeup_irq(qcom->phy_irq[SS_PHY_IRQ_INDEX][i]);
> +	}
>  }

The above is hardly readable, partly because of the 2d array that I
think you should drop, and partly because you add the port loop here
instead of in the caller.

A lot of these functions should become port operation where you either
pass in a port structure directly or possibly a port index as I've
mentioned before.

[ I realise that the confusion around hs_phy_irq may be partly to blame
for this but since that one is also a per-port interrupt, that's no
longer an issue. ]
 
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> @@ -454,10 +461,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  	 * The role is stable during suspend as role switching is done from a
>  	 * freezable workqueue.
>  	 */
> -	if (dwc3_qcom_is_host(qcom) && wakeup) {
> -		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);

So just let this function update the usb2 speed for all ports unless
there are reasons not to.

> +	if (dwc3_qcom_is_host(qcom) && wakeup)
>  		dwc3_qcom_enable_interrupts(qcom);

And then iterate over the ports and enable the interrupts here as you
did above for the pwr_evnt_irqs.

> -	}
>  
>  	qcom->is_suspended = true;

Johan
