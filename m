Return-Path: <linux-kernel+bounces-118824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1468588BFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332C2E7E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4779DF;
	Tue, 26 Mar 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfuy0lN/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3629A0;
	Tue, 26 Mar 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449837; cv=none; b=hElQiJnLtf5m0tSObpbP8q7/0W4X8MEf7qcJAFQUW+bOH4GMonLSisBFGEyDEevNBYKs2j3K4vMq+1IjVq/dahCU6sPfbaFKZkeJMnB2UEoTplWxs45eYVxv5P4KM5B/cafs+Bjz8bCAd2XJlDZp89kyggJkay2/567mCkDdkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449837; c=relaxed/simple;
	bh=vwyF+iRB3lA+0ZCjAOIqFFU72W87k8/58YHoJa8WpLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlcWIUdl8TTxxrBA+DM1rv/N9HovJUE9YBGsq/iDWXmkZqrlrRlyPYk+qY08bEm3R+tGEuTWva9uN+3N4rHWnjQkHClL9vbh64LtG0PDzGxeTHzg7QiCS7pO9NQg9ScXBakB87Rk2SAPUjnznwItqiqSUrRU00tx5cycbvNgdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfuy0lN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66389C433C7;
	Tue, 26 Mar 2024 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711449836;
	bh=vwyF+iRB3lA+0ZCjAOIqFFU72W87k8/58YHoJa8WpLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfuy0lN/KkDKyqzc/6Jezrot7iUFD9NrHKfw8jx5XhqWYXw4VTEgWxdF8ZsikQrfG
	 90McEfcuNo4rsreuwIZZI7U5HkFMULmFC/hM4VAuYElGq5C4xiXGnXzwfN+TON4H6V
	 nwWWJD6dzlo6+eob9+tLpY9kngamg1oT322hcGqHVdeKEpx+OTyBjdJDB8g+MnF31L
	 xawQ5PDCIHt4xgFxu1PQewr/PTUgmYk79IHOwCBkw2HElDS3Eod8msriyEEZCw/7Rc
	 66x8oMX/NVKqNFewcYObhvp/UfVNZZmWyQgUq0huGHEhDhMlgEzl7t82KXmyEfxwwz
	 KEhKlBv+uVfHQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rp4Hj-000000007jO-0ymj;
	Tue, 26 Mar 2024 11:44:03 +0100
Date: Tue, 26 Mar 2024 11:44:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v17 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Message-ID: <ZgKm89rq4D8SqYQL@hovoldconsulting.com>
References: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
 <20240326102809.2940123-8-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326102809.2940123-8-quic_kriskura@quicinc.com>

On Tue, Mar 26, 2024 at 03:58:07PM +0530, Krishna Kurapati wrote:
> On multiport supported controllers, each port has its own DP/DM
> and SS (if super speed capable) interrupts. As per the bindings,
> their interrupt names differ from standard ones having "_x" added
> as suffix (x indicates port number). Identify from the interrupt
> names whether the controller is a multiport controller or not.
> Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
> along with non-multiport ones accordingly..
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 137 ++++++++++++++++++++++++++---------
>  1 file changed, 103 insertions(+), 34 deletions(-) 

> -static int dwc3_qcom_setup_irq(struct platform_device *pdev)
> +static int dwc3_qcom_setup_port_irq(struct platform_device *pdev, int port_num, bool is_multiport)

Here you use "port_num", when it's really a (zero-based) port index.

Please change to "port_index".

>  {
>  	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
> +	const char *irq_name;
>  	int irq;
>  	int ret;
>  
> -	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
> +	if (is_multiport)
> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_num + 1);
> +	else
> +		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_irq");
> +	if (!irq_name)
> +		return -ENOMEM;

> +static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
> +{
> +	char irq_name[14];
> +	int port_index;
> +	int irq;
> +
> +	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
> +	if (irq <= 0)
> +		return 1;
> +
> +	for (port_index = 2; port_index <= DWC3_MAX_PORTS; port_index++) {

And here you use port_index, when it's really a one-based port number.

I explicitly used "port" when we discussed the update here for this
reason ("port_num" works too).

Please fix this last thing in a v18 and we're good to go.

> +		sprintf(irq_name, "dp_hs_phy_%d", port_index);
> +
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq <= 0)
> +			return port_index - 1;
> +	}
> +
> +	return DWC3_MAX_PORTS;
> +}

Johan

