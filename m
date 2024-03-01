Return-Path: <linux-kernel+bounces-88515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E9086E2C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7826928C8C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D003D6EB6D;
	Fri,  1 Mar 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzhhzQ/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B86200C4;
	Fri,  1 Mar 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301042; cv=none; b=RmFhEy8MMRteSPlw+A1mI2dBzpMN9Lp7p/dR1Hb2iAnf066IOXWU2hXOVdfe6tmJ21lFbuB0FsOOIyi36TCeQU9KCRPHy4UVRhl9SEKQdou7M/zO1we5/AK3yj2JSI0B0wU7EL+eP2L+OM7kqHZSg6u0wIFf1FJske8fcBVy+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301042; c=relaxed/simple;
	bh=a9du7YH5/xmHXiPWd6cBsVA2DhhI1MQvCTVDaeNeBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFtOMTXuT2fWCWCz9dCt7GOcYpWcqRXTlSLAncoBeUdshyJgYqe9g3yGodmrcZpXjqQsSyiusQDt8o75o8rXM1GQpASm+gldnNE7yGM0mSkd3lRKvxCXNKRWQB9CEKZO/cWNolWkroXoTDdKH1lWqIJNzNt9yijM2ejDQlJ4DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzhhzQ/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6F1C433C7;
	Fri,  1 Mar 2024 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709301041;
	bh=a9du7YH5/xmHXiPWd6cBsVA2DhhI1MQvCTVDaeNeBNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PzhhzQ/c/roz+DKJnhWaJPE4szILpILfA98zx8MPP5jw3h+HZAjtET1eM7rmcXi7Q
	 D5uQDIABUhd2h+HIYea/1XWL+wjZl43gleFd93f7jWmfzETLhICmNxQ28AbZnSmWto
	 8lDcYKPHqt6yXDHeaePD81js9PatWPO+7W5/9G3eDDWkJwt4E9ZjePokRPGw+tKgmY
	 88HAf/zXuv14yFvesEJuJl+Fz5GOxeN8QeZTzT0hxxlTWWH8kK7nfIX6661pbjjTLT
	 MW/hsR5bs0oORp1yQMVM+sXVwlclijqBxHnl8mrJ970QqvCc8DT+rfiuiS8xh17LID
	 ZZ2W+ftejySEw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg3Ho-000000001Ng-0FEq;
	Fri, 01 Mar 2024 14:50:52 +0100
Date: Fri, 1 Mar 2024 14:50:52 +0100
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
	quic_jackp@quicinc.com, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: Re: [PATCH v15 4/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <ZeHdPJZbeGO8u9XX@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-5-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-5-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:51AM +0530, Krishna Kurapati wrote:

> @@ -1398,22 +1464,36 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>  			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>  	}
>  
> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
> -	if (IS_ERR(dwc->usb2_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb2_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb2_generic_phy = NULL;
> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb2-phy");
>  		else
> -			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
> -	}
> +			sprintf(phy_name, "usb2-%d", i);
> +
> +		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb2_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb2_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +						"failed to lookup phy %s\n", phy_name);

Please move the format string to the previous line as I already asked
you to do (e.g. as continuation lines should be substantially shorter).

> +		}
>  
> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
> -	if (IS_ERR(dwc->usb3_generic_phy)) {
> -		ret = PTR_ERR(dwc->usb3_generic_phy);
> -		if (ret == -ENOSYS || ret == -ENODEV)
> -			dwc->usb3_generic_phy = NULL;
> +		if (dwc->num_usb2_ports == 1)
> +			sprintf(phy_name, "usb3-phy");
>  		else
> -			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
> +			sprintf(phy_name, "usb3-%d", i);
> +
> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
> +			if (ret == -ENOSYS || ret == -ENODEV)
> +				dwc->usb3_generic_phy[i] = NULL;
> +			else
> +				return dev_err_probe(dev, ret,
> +						"failed to lookup phy %s\n", phy_name);

Same here.

> +		}
>  	}
>  
>  	return 0;

Johan

