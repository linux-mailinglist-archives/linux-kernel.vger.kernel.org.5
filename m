Return-Path: <linux-kernel+bounces-117002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90188AB40
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504E4B33415
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F64E127B50;
	Mon, 25 Mar 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4nlOKDq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23686640;
	Mon, 25 Mar 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369867; cv=none; b=TmHt2Mm4fOx0anpW/XCtrt27b3hrFYvjTwlhtaLha1UKLwY0BXxZ7tPPRyGFmcUhH3XCx9qfNr7uzqoMxIx68t+fM3HwWozOnAfMvgpvxLjI6yYNjli0/A2enISVEl/KOKD060Hat3Yt5g7PCI0Aum2aN056YWBScd5EMjzrsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369867; c=relaxed/simple;
	bh=zUJo6272FnK84jmyw4NnOmR4XYdb9pIOT23e/3uwzOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt1Yt6gAoZwwqQapZYPJfFg/t02hxpFszr3fZxkco2StE1KHzkg8gDFwXV8GaDn8R0O0u1mnuhKILw+BiCSmsZXyy2xGyJP/ACHSgPMh/2nO/YdM/UlaztBTu4mgzJIxVXaftJmx9b42XE18V4m9HvbY6rgDXVlmKBBitXA3wpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4nlOKDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F5EC433F1;
	Mon, 25 Mar 2024 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711369866;
	bh=zUJo6272FnK84jmyw4NnOmR4XYdb9pIOT23e/3uwzOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4nlOKDquaafKy61MH0lk5iXUXr8eqGXSPQWJh9ekyP8FxbcUD1zo79mJK5m2HmUE
	 qbktwDhqeSxwO4aO8kFWEzNsmHi31FEGZG5w8+JjZA4XpQ+c2Acnuz5rEmiw381bTt
	 hhpJiuH+3eme/Hjt2esaB18vrXiN9zZpbnmZ0zu9iHvFS5nJyUG2OHCBYRvUZFxcKJ
	 jgTZmJqkfyUwKnmqpGWpySkGxB+H3bun9VDqfRk3SrE+DqqU2hjG4qsXH7wveLQMl0
	 nLOGIi6nzebFCPOVi9OdwJIHrBqW49VMik3PCom09jHK7oRVG9DX2VHxmVt2xXixWo
	 TkDtDiPK5OVUg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rojTt-000000001R6-39hs;
	Mon, 25 Mar 2024 13:31:13 +0100
Date: Mon, 25 Mar 2024 13:31:13 +0100
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
Subject: Re: [PATCH v16 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZgFukaLXo4DNwfEK@hovoldconsulting.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
 <20240307062052.2319851-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307062052.2319851-3-quic_kriskura@quicinc.com>

On Thu, Mar 07, 2024 at 11:50:45AM +0530, Krishna Kurapati wrote:
> All DWC3 Multi Port controllers that exist today only support host mode.
> Temporarily map XHCI address space for host-only controllers and parse
> XHCI Extended Capabilities registers to read number of usb2 ports and
> usb3 ports present on multiport controller. Each USB Port is at least HS
> capable.
> 
> The port info for usb2 and usb3 phy are identified as num_usb2_ports
> and num_usb3_ports. The intention is as follows:
> 
> Wherever we need to perform phy operations like:
> 
> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
> {
> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
> }
> 
> If number of usb2 ports is 3, loop can go from index 0-2 for
> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
> if the first 2 ports are SS capable or some other ports like (2 and 3)
> are SS capable. So instead, num_usb2_ports is used to loop around all
> phy's (both hs and ss) for performing phy operations. If any
> usb3_generic_phy turns out to be NULL, phy operation just bails out.
> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
> phy's as we need to know how many SS capable ports are there for this.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

