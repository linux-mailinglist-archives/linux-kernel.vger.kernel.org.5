Return-Path: <linux-kernel+bounces-88633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24186E498
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2C11C21DAA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A6970AD8;
	Fri,  1 Mar 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4ZRSLhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F3A8DE;
	Fri,  1 Mar 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307824; cv=none; b=scet6aqXdlCZlxcdhjZ6berqU15bcdOB1PJb7rSuh/TFzOo82jz5nA4P34UxkVwByCD3JMaH5sfcxuBzw1Wx1igX6oXcHvzVq3jpPJhs88dVOTzCphfkkFz+jWClvWP3r+KJd02XuvDUsjIkemW/1UdYy8tNXkKSLNi/UgKm40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307824; c=relaxed/simple;
	bh=bG9hQ66MYcnqctgrAOl+DucX9thMeIyw3inwy+5KOqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBxpR5uGYNbuctjKR8UHaiocoGoHskDBaUyVwjBJ+5d+zf2FUse+Z24+P152IIWvfbeeZPqvd2IShqW3wUDgHlGBzINbHslPz4wZMY5RCG04aSGqBj5hwxvlxnCPtbL9ScG2kFOqRNQkAZMhF+O360Eb62HT1gpAirxAdJDSZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4ZRSLhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680CEC433F1;
	Fri,  1 Mar 2024 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709307822;
	bh=bG9hQ66MYcnqctgrAOl+DucX9thMeIyw3inwy+5KOqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4ZRSLhVZixnb8wRCaw8T7ek/UOS49fnu8jBUY918pHyaSHtkJin4mJyCZG0D4aFE
	 3MJH7MdLOkSV3iNdYoFMsNe8fHtdPIyc9pxIIveu9ml9fQlsaZQ5F+cO3CQtOHwNXM
	 Uea2nemNIVtE4aTQWrE7Ug7aiU5whWynJXpzijOA4XM9V/xLT0eSBDbLiZ/OoM3qym
	 SnDG0Nl7WdIp3QRU8I+wjjtQDFJ28Nj7zFGkQC1dmGwAWYs7KKN2Ji092RS4G/Hi0J
	 GklanWOALbNCfJKDyUVxKdYHb7PTc44V/RTAoVofbzkX6l7Q1NZFe5WXqWoT/FoKlZ
	 PRPyunVZ8HPDQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg53B-000000001io-0yeT;
	Fri, 01 Mar 2024 16:43:53 +0100
Date: Fri, 1 Mar 2024 16:43:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH v15 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Message-ID: <ZeH3uXyp3YJTU3cL@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-9-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-9-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:55AM +0530, Krishna Kurapati wrote:
> DWC3 Qcom wrapper currently supports only wakeup configuration
> for single port controllers. Read speed of each port connected
> to the controller and enable wakeup for each of them accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 72 ++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index a20d63a791bd..572dc3fdae12 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -78,6 +78,7 @@ struct dwc3_qcom_port {
>  	int			dp_hs_phy_irq;
>  	int			dm_hs_phy_irq;
>  	int			ss_phy_irq;
> +	enum usb_device_speed	usb2_speed;

You need to remove the corresponding, and now unused, field from struct
dwc3_qcom as well.

>  };
>  
>  struct dwc3_qcom {
> @@ -336,7 +337,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
>  	return dwc->xhci;
>  }
>  
> -static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
> +static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
> +						       int port_index)

As I mentioned, there's no need for a line break after the first
parameter as this is a function definition (e.g. Linus as expressed a
preference for this as it makes functions easier to grep for).

>  {
>  	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  	struct usb_device *udev;
> @@ -347,14 +349,8 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
>  	 */
>  	hcd = platform_get_drvdata(dwc->xhci);
>  
> -	/*
> -	 * It is possible to query the speed of all children of
> -	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> -	 * currently supports only 1 port per controller. So
> -	 * this is sufficient.
> -	 */
>  #ifdef CONFIG_USB
> -	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> +	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
>  #else
>  	udev = NULL;
>  #endif
> @@ -387,23 +383,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
>  
>  static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
>  {
> +	int i;
> +
>  	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
>  
> -	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
> -	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
> -			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
> -	} else {
> -		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
> -		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
> -	}
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		if (qcom->port_info[i].usb2_speed == USB_SPEED_LOW) {
> +			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq);
> +		} else if ((qcom->port_info[i].usb2_speed == USB_SPEED_HIGH) ||
> +				(qcom->port_info[i].usb2_speed == USB_SPEED_FULL)) {
> +			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq);
> +		} else {
> +			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq);
> +			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq);
> +		}
>  
> -	dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].ss_phy_irq);
> +		dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].ss_phy_irq);
> +	}

As I already commented on v13, this should be a per-port helper rather
than special casing qusb2_phy_irq and a for loop for the other
interrupts:

	A lot of these functions should become port operation where you
	either pass in a port structure directly or possibly a port
	index as I've mentioned before.

>  }
 
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> @@ -455,10 +459,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  	 * The role is stable during suspend as role switching is done from a
>  	 * freezable workqueue.
>  	 */
> -	if (dwc3_qcom_is_host(qcom) && wakeup) {
> -		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);

And again, as I said for v13:

	So just let this function update the usb2 speed for all ports
	unless there are reasons not to.

rather than hide it away in an odd for loop in
dwc3_qcom_enable_interrupts().

> +	if (dwc3_qcom_is_host(qcom) && wakeup)
>  		dwc3_qcom_enable_interrupts(qcom);
> -	}
>  
>  	qcom->is_suspended = true;

Johan

