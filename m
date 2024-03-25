Return-Path: <linux-kernel+bounces-117055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB388A67F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A5C1C3CA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6613E022;
	Mon, 25 Mar 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0CfJBIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC977440B;
	Mon, 25 Mar 2024 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370931; cv=none; b=hZKzIHODgqOyZF7L+3IEc2CLIG3DV3FB5YUzJx7QBJ8bloslk+HawjdFC3HT1X2b4Sju0YM/s2R+b75B4DgW9fC3Ogpekyet7o0val94xL6+mazgvcG1SZZg/pD4JJYALBhFQV043L3vx9UbAz5KB9fzf0bS6zNoDargCJ9nelo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370931; c=relaxed/simple;
	bh=iRD16UiH7hTocRQ9SdX7iMdmAToWubYP+iIOkYgDzLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmNq0m8sQLmfYSqkHBcorMFzlcZI6KfOI4qOi+NK4lxVSbMhi1v/qsKIG46EsH3Ce0HMWbJMnMaEXtTtGuZHuXRKMI7wLeBLI5pqD73q4BjxErbSjSdVEj6r+5YurD/XX1dv+1zGEc307KLDNBjF6G/jGRybObnJZ5jOa70Ji08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0CfJBIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B90DC433F1;
	Mon, 25 Mar 2024 12:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711370931;
	bh=iRD16UiH7hTocRQ9SdX7iMdmAToWubYP+iIOkYgDzLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0CfJBITHHlgzbXGUIqXuGHxZsFtaZAjXZsCOb44hqcSFKVOUea+fCBltGLe8T2Lc
	 W/YlY6rIziro2yZhYt7f1cK4jXZuqERJRiSLryMwiPB5rbmA8rib43EgtBBXCNNu4C
	 rjlgkDp5c9SAFeHRgq071PLm6ofKJmJIA01A+1cmXZJ9DaQomCmoWDoYDJNSI/tuHc
	 ZZs2ToX8NBuo/bpyMtlf7LHisyL/jGr7jjbPVzw3Mk+zsn6JhndcYLxTsXaRhCufIT
	 ycKGVVw4dfWedG+1c/+nqqM9DSwsalrSrfdu88uNP8CfBg4ZumIdg/cevcK2dZwvqa
	 +KXI40WQWktdQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojl4-000000001Up-0XcL;
	Mon, 25 Mar 2024 13:48:58 +0100
Date: Mon, 25 Mar 2024 13:48:58 +0100
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
Subject: Re: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZgFyukBXIIwZo7v-@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-8-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-8-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:50AM +0530, Krishna Kurapati wrote:
> On multiport supported controllers, each port has its own DP/DM
> and SS (if super speed capable) interrupts. As per the bindings,
> their interrupt names differ from standard ones having "_x" added
> as suffix (x indicates port number). Identify from the interrupt
> names whether the controller is a multiport controller or not.
> Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
> along with non-multiport ones accordingly..
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 146 +++++++++++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 34 deletions(-)

This is much better. Just a couple of nits below.

> +static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
> +{
> +	const char *irq_name;
> +	int port_index;
> +	int irq;
> +
> +	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
> +	if (irq > 0)
> +		return 1;
> +
> +	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
> +	if (irq > 0)
> +		return 1;
> +
> +	for (port_index = 0; port_index < DWC3_MAX_PORTS; port_index++) {
> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_index + 1);

Please use a stack allocated buffer for these strings as we don't need
them any more after this function returns.

> +		if (!irq_name)
> +			return -ENOMEM;
> +
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq <= 0)
> +			return port_index;
> +	}
> +
> +	return port_index;

I think explicitly returning DWC3_MAX_PORTS here would be more readable.

> +}
> +
> +static int dwc3_qcom_setup_irq(struct platform_device *pdev)
> +{
> +	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	bool is_multiport;
> +	int ret;
> +	int i;
> +
> +	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
> +	if (qcom->num_ports < 0)
> +		return -ENOMEM;

Just return 'ret' directly.

> +
> +	is_multiport = (qcom->num_ports > 1) ? true : false;

And no need for the ternary operator:

	is_multiport = (qcom->num_ports > 1);

> +
> +	for (i = 0; i < qcom->num_ports; i++) {
> +		ret = dwc3_qcom_setup_port_irq(pdev, i, is_multiport);
>  		if (ret)
>  			return ret;
> -		qcom->ss_phy_irq = irq;
>  	}
>  
>  	return 0;

With that fixed:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

