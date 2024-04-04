Return-Path: <linux-kernel+bounces-131476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A589885B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0EE1F23665
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9811C86630;
	Thu,  4 Apr 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oakJHHe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4743745C4;
	Thu,  4 Apr 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235512; cv=none; b=ihuZdeGY6txpWt6j0CLbOpxzjHFhIrvf3uXIJA+6Pd/+3TuFAz/+0yDHRdr5zAwIR5axvHTY/eWNB7RJHVwOi7cXFPBAcUulOrIPBxc/sFxMCWidU69K0MtkijRhXpgmuGDRdyNBm8aMp8T9XALi5FW73UxVZMrWpM/V9a5Ccx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235512; c=relaxed/simple;
	bh=BozSj0OlHtb5l5pjhkdBvyLiA2cXqWoE42TakhWx8TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ0M49u+srJP53UK1xdQZ9FJj4KS8OXpuWHNf59mdFKpZasjr9HnIVeG5T6p4xg0rgW5i3LXDkGSob8Q4lxQWUC/AWJIt2xWVRmSqVDy4kffxM7d1+K9cFNvEOTKB/sg8vbxc9YLxKF0GbquGWCfi0qxZGOsA73pwhZXQaa9HcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oakJHHe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79A3C433F1;
	Thu,  4 Apr 2024 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712235512;
	bh=BozSj0OlHtb5l5pjhkdBvyLiA2cXqWoE42TakhWx8TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oakJHHe8oRQSq3GpOrjs6UB13j/7/4vfGmbVmsov4vw7zoBTvGLzufyTLfyCrRHss
	 f8QAkoY6fhy3FVWicECagTYXH0+7S3+ryWfOjddJk01dp80x0VmGq6qO8tJs/GiPR+
	 3W4zCHro+Te4iuPBdVxFdN1StpZpMRm18PhIS+Xs=
Date: Thu, 4 Apr 2024 14:58:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v19 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <2024040455-sitting-dictator-170c@gregkh>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
 <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
 <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>

On Thu, Apr 04, 2024 at 10:07:27AM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 09:21, Johan Hovold wrote:
> > On Thu, Apr 04, 2024 at 10:42:22AM +0530, Krishna Kurapati wrote:
> >  
> >> +static int dwc3_get_num_ports(struct dwc3 *dwc)
> >> +{
> >> +	void __iomem *base;
> >> +	u8 major_revision;
> >> +	u32 offset;
> >> +	u32 val;
> >> +
> >> +	/*
> >> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> >> +	 * needed to get information on number of ports present.
> >> +	 */
> >> +	base = ioremap(dwc->xhci_resources[0].start,
> >> +		       resource_size(&dwc->xhci_resources[0]));
> >> +	if (!base)
> >> +		return PTR_ERR(base);
> > 
> > This is obviously still broken. You need to update the return value as
> > well.
> > 
> > Fix in v20.
> 
> If one patchset reaches 20 versions, I think it is time to stop and
> really think from the beginning, why issues keep appearing and reviewers
> are still not happy.
> 
> Maybe you did not perform extensive internal review, which you are
> encouraged to by your own internal policies, AFAIR. Before posting next
> version, please really get some internal review first.

Also get those internal reviewers to sign-off on the commits and have
that show up when you post them next.  That way they are also
responsible for this patchset, it's not fair that they are making you do
all the work here :)

thanks,

greg k-h

