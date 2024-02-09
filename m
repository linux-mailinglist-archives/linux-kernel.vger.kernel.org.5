Return-Path: <linux-kernel+bounces-58954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F37084EF20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FF9284F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B64A39;
	Fri,  9 Feb 2024 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8GBLmI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FA566B;
	Fri,  9 Feb 2024 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447490; cv=none; b=bF300LjvIMR1p8Z6vlAe7tEzcltTWCE06Q9+m/mSLJOX8AcJSOA3DchNqAUnOgjCVW0nkKtYpObVqpAEbRio4LTCjzePG3HYm47woPgtS/mCX44XGhBMY7JvxnqWMiwY9260XQf9i5YzGOMOX4tnpNKF64TujBLInU3LeyTMCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447490; c=relaxed/simple;
	bh=O6tZ+fYl7FRTA7z10dP+6aZ2JMB2G71SnA15ER/vzZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2hOXRsScnPVxTew0huKj9FGuaJR+//7jxBen2LfOoSjfY8Fy0puQyxFCEB7shKv5V6vl9piNirXYDhuQZhgyIpFhHe/DBscKpguDboiRBLKX7M4y7bsaGEl7kplhsgbf1muz/WPjy6cbIpfMAtHgZaVNzsXeo11kZDW6lhvQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8GBLmI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBE6C433F1;
	Fri,  9 Feb 2024 02:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707447490;
	bh=O6tZ+fYl7FRTA7z10dP+6aZ2JMB2G71SnA15ER/vzZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8GBLmI3HQAq4O/vM1CMTji8ClaWqjF7VG2bAwCyWOJ8ii2lZIgJ+3YX5PEvkbIp4
	 myVI4KPU2bRAOW1jmGts/blJkMeYkz4HY3qwmbNqmoZCpF/h7V2DB8zkEkv8K7Xr+y
	 TNIwawYEdvN7hjfNYVC0kj5VImPo+vbyBWtErTbgt51w3MKZJySEivH7JfYlKvM3fk
	 MfZAUW/hodEde/vvwR2i7BgSyN96Dq3IIcbvsbHAP6H2GISZXHiMMlcf3zV0426rPA
	 y/nj2uZ74+7Vq1eTu39S8pnBefVit7No1UbG82TSBpgtc4pUHvcAbLCA8D/IPECOD4
	 2AR6zAH9ny+NA==
Date: Thu, 8 Feb 2024 20:58:06 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v14 8/9] usb: dwc3: qcom: Enable wakeup for applicable
 ports of multiport
Message-ID: <ptndm7ku72e7dsga2tv6wd4jznpkuxapaqfbw7tl4v3s6yazkn@speemw4a2ubn>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-9-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206051825.1038685-9-quic_kriskura@quicinc.com>

On Tue, Feb 06, 2024 at 10:48:24AM +0530, Krishna Kurapati wrote:
> DWC3 Qcom wrapper currently supports only wakeup configuration
> for single port controllers. Read speed of each port connected
> to the controller and enable wakeup for each of them accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

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
>  }
>  
>  static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  {
> +	int i;
> +
>  	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
>  
>  	/*
> @@ -414,22 +416,24 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  	 * disconnect and remote wakeup. When no device is connected, configure both
>  	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
>  	 */
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		qcom->port_info[i].usb2_speed = dwc3_qcom_read_usb2_speed(qcom, i);
> +		if (qcom->port_info[i].usb2_speed == USB_SPEED_LOW) {
> +			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq,
> +						    IRQ_TYPE_EDGE_FALLING);
> +		} else if ((qcom->port_info[i].usb2_speed == USB_SPEED_HIGH) ||
> +				(qcom->port_info[i].usb2_speed == USB_SPEED_FULL)) {
> +			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq,
> +						    IRQ_TYPE_EDGE_FALLING);
> +		} else {
> +			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq,
> +						    IRQ_TYPE_EDGE_RISING);
> +			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq,
> +						    IRQ_TYPE_EDGE_RISING);
> +		}
>  
> -	if (qcom->usb2_speed == USB_SPEED_LOW) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
> -					    IRQ_TYPE_EDGE_FALLING);
> -	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
> -			(qcom->usb2_speed == USB_SPEED_FULL)) {
> -		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
> -					    IRQ_TYPE_EDGE_FALLING);
> -	} else {
> -		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
> -					    IRQ_TYPE_EDGE_RISING);
> -		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
> -					    IRQ_TYPE_EDGE_RISING);
> +		dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].ss_phy_irq, 0);
>  	}
> -
> -	dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].ss_phy_irq, 0);
>  }
>  
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> @@ -455,10 +459,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  	 * The role is stable during suspend as role switching is done from a
>  	 * freezable workqueue.
>  	 */
> -	if (dwc3_qcom_is_host(qcom) && wakeup) {
> -		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
> +	if (dwc3_qcom_is_host(qcom) && wakeup)
>  		dwc3_qcom_enable_interrupts(qcom);
> -	}
>  
>  	qcom->is_suspended = true;
>  
> -- 
> 2.34.1
> 

