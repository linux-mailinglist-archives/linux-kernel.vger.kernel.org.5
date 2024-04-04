Return-Path: <linux-kernel+bounces-131025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFF898222
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275C81C25C28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF25A10F;
	Thu,  4 Apr 2024 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isiCW9ao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27845788E;
	Thu,  4 Apr 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215310; cv=none; b=YuYYssVuFkbv2DlcxlOELbcwZyeO4iJBDv/A1/X3T7FV6SiMSW1m5lfiaYmrk6KkR+O6UnqAs/JGF4AevH+AcuifRzPWIERG8g7Q4RboBh4g0GP77py+ybKoygJweIXW2W5QLnzEkEH0eHXaEa2f3Mi1e/Hwaxq9rvzPWvD3kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215310; c=relaxed/simple;
	bh=22vZWXLBQ/ZELh5sGxipXuq06Byi+TSROvhbyLYjZaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4DIdqPr/OPzciWcasSslzR2Eiss/XOkyQQq2dN22vI+rotYL7lZX9DU7eBZYL05TOS3vBE/uwgWIiCV3+DbMvzcrq7NAybB+l1PmA9bjYiCflx4d0ZE2pufaLpH2CKiZjIiuiPS0ngxv1BYToSmLKjcRX6IpiRwWFCcDLSnOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isiCW9ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CBDC433C7;
	Thu,  4 Apr 2024 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712215310;
	bh=22vZWXLBQ/ZELh5sGxipXuq06Byi+TSROvhbyLYjZaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isiCW9aooMMlPBu1aW4OeDBXwx1ElO+rKZNkOcQJiCdUpcmSUWjCt0Xv1k5Gw1ixf
	 A9MrG9mvxq2fQ8OguEC92SwbwpVVix50aqA4TB6340FabXp3HyGy4JAXsJTkYstK84
	 RQ/zpcHXY7pJw6ZLct71XueRGQGPBDc+D6P+9BdSKBaLZS6Rdj4nNuGBEwyH8akM/B
	 I8Gg8gUcixNSrgNQTFH6mUIvi983LKNg7vMJ3pBbC1KdAeOtAv50gKIeJIQ4HxFHRw
	 GP0dFbLU1h86BAJ4Nq74A67yQKnIoFMGfwuZYAc4hiVm/HNn/5Xt5FU5PWSGbOwfQY
	 sV7pn3rLLblrA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rsHPy-000000008Ay-3Ttx;
	Thu, 04 Apr 2024 09:21:50 +0200
Date: Thu, 4 Apr 2024 09:21:50 +0200
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
Subject: Re: [PATCH v19 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404051229.3082902-3-quic_kriskura@quicinc.com>

On Thu, Apr 04, 2024 at 10:42:22AM +0530, Krishna Kurapati wrote:
 
> +static int dwc3_get_num_ports(struct dwc3 *dwc)
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
> +	if (!base)
> +		return PTR_ERR(base);

This is obviously still broken. You need to update the return value as
well.

Fix in v20.

Johan

