Return-Path: <linux-kernel+bounces-86473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017EB86C5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BB01C21574
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72549627EB;
	Thu, 29 Feb 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhfaqvoG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A75B5D2;
	Thu, 29 Feb 2024 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200031; cv=none; b=fs8D8uq0CDuFk8SfKP3PO/bATlH16iuKtnZm3aZbDUldPqD0jh7cqBY+10+qjv3J0befnjSONcvrrwAiDkG860pYlwVYO2cgC/V3aXLerXBeuPLFxXNit/AILNYpGCBe7vb9+dlAyaOCVy79RYi978zj3o9IjBwfLkqFyJ5P92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200031; c=relaxed/simple;
	bh=xc+qRjR0bWdnBIKs1iZ20uh/Wq/YWbOq3AIghhd6LfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8efQjdTdCNz3C2M4r211sZ9bkLV8lSQnyTSX6uSVeb1HkiOb+o1twUzdU1S4iXGilV2wTNH7VzqjddubK33HTdqhOY9P9Y5lJBzk3um22/lJMKme8DzrzxYpdI6rV7GruAlyh9WFRDGFocIHXXrLBHV7rGdhC9Hw2bn9pzNRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhfaqvoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F596C433C7;
	Thu, 29 Feb 2024 09:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200031;
	bh=xc+qRjR0bWdnBIKs1iZ20uh/Wq/YWbOq3AIghhd6LfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UhfaqvoGfdj3afa6zQC7Y8B5MFpwLcInlkfwmi/p3rpe3opbROvbbdeKBjsUyyafR
	 e4bq0ftGNcwoct8km6fPaK6Qy9VzQs0SNdoJoajf2GaQBYHojuJDJdj8Yi0+TRNExF
	 beeI+ve9/2S981guPre8Ian9A20elKPZKV3qrmQjzyynmKR80aN68onGGsS3hLHeKp
	 iiHyeBvB/zaSnqo1BRj4/xCd8H80Hk2EqYwDG70BrI6hL+UnD8o4a9q93rCnhjUh3f
	 3AkFmnJxe+T5kc/nHJijw9P0cfndWaxUgi6dIdzh4H3ejlByecFU1nS93Y5UxQs896
	 8b4hVH6vXduDQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfd0Z-000000000me-15w5;
	Thu, 29 Feb 2024 10:47:19 +0100
Date: Thu, 29 Feb 2024 10:47:19 +0100
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
Subject: Re: [PATCH v15 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZeBSp0EWnHo8Wbsv@hovoldconsulting.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
 <20240216005756.762712-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216005756.762712-3-quic_kriskura@quicinc.com>

On Fri, Feb 16, 2024 at 06:27:49AM +0530, Krishna Kurapati wrote:
> Currently Multiport DWC3 controllers are host-only capable.

I already asked you to rephrase this so that it becomes clear that you
are describing a property of the current hardware (and similar
throughout the series):

	https://lore.kernel.org/all/ZTI7AtCJWgAnACSh@hovoldconsulting.com/

> +static int dwc3_read_port_info(struct dwc3 *dwc)
> +{
> +	void __iomem *base;
> +	u8 major_revision;
> +	u32 offset;
> +	u32 val;
> +
> +	/*
> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> +	 * needed to get information on number of ports present.
> +	 */
> +	base = ioremap(dwc->xhci_resources[0].start,
> +		       resource_size(&dwc->xhci_resources[0]));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	offset = 0;
> +	do {
> +		offset = xhci_find_next_ext_cap(base, offset,
> +						XHCI_EXT_CAPS_PROTOCOL);
> +		if (!offset)
> +			break;
> +
> +		val = readl(base + offset);
> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
> +
> +		val = readl(base + offset + 0x08);
> +		if (major_revision == 0x03) {
> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else if (major_revision <= 0x02) {
> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else {
> +			dev_warn(dwc->dev,
> +				 "unrecognized port major revision %d\n",

I still think you should merge this with the previous line even if you
end up with 83 chars.

> +							major_revision);
> +		}
> +	} while (1);
 
> +	/*
> +	 * Currently only DWC3 controllers that are host-only capable
> +	 * support Multiport.
> +	 */

So again, also here, rephrase the comment so that it is clear that you
are referring to a property of the current hardware.

> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
> +		ret = dwc3_read_port_info(dwc);
> +		if (ret)
> +			goto err_disable_clks;
> +	} else {
> +		dwc->num_usb2_ports = 1;
> +		dwc->num_usb3_ports = 1;
> +	}

Johan

