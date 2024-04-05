Return-Path: <linux-kernel+bounces-132411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F2B89948E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2080C1C20DD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5F3224DD;
	Fri,  5 Apr 2024 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kl3pFkAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2DC138;
	Fri,  5 Apr 2024 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292245; cv=none; b=Wc2dqQHT1Hg39cy0GRCRKAXJFcRtzfVZhQjNV64vRuTzVmWfSbHFabvzvysPfp21kqPGb5pnbTnH6phzgP1C5EcJUoHekMDEicjb+uOeWxbtxGtkyKEvLBSqjsaf2WndfnvNjvrNky6vOOEnFcHlAffmuM0+w0175P0rkShs5KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292245; c=relaxed/simple;
	bh=nP5LSoPmz6tMExekbFggHQmASZ3xuQAUPcPQ6315p7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwG8jG8IPX2Ly9u4vL0/TKrq1aEgisam1CDtXprbgkuiqb07AYMuwBAwmn/jkmfj9Q5muuJi0TaQpg5bdkRDOePE4RSxQaaQUKrGji/x1IDJutzjnvWUvAa7019pTdKMPQX1Ayn7BlwWBgR+KnHbMRajrVmPVgl+QJ99SVeeDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kl3pFkAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1DFC433F1;
	Fri,  5 Apr 2024 04:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712292245;
	bh=nP5LSoPmz6tMExekbFggHQmASZ3xuQAUPcPQ6315p7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kl3pFkAptITw2b7BMS4ccJYJ2GNDXaJVO9O2I+YNvsiM4STCe/AskFJrIQiE8WtpP
	 xcSI6CknCzHADaD8kDSEBWy3SgeAMTngU2YKd79J8ItyAAgzk6tqee3uDuv79S5pGO
	 LlRwKqADyKQhOzkI6QSxHbDPYcBRKhwCn9LulNRg=
Date: Fri, 5 Apr 2024 06:43:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan@kernel.org>,
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
Message-ID: <2024040558-undercut-sandbar-7ffc@gregkh>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
 <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
 <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>
 <2024040455-sitting-dictator-170c@gregkh>
 <Zg9THGBRuppfw4y+@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg9THGBRuppfw4y+@hu-bjorande-lv.qualcomm.com>

On Thu, Apr 04, 2024 at 06:25:48PM -0700, Bjorn Andersson wrote:
> On Thu, Apr 04, 2024 at 02:58:29PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 04, 2024 at 10:07:27AM +0200, Krzysztof Kozlowski wrote:
> > > On 04/04/2024 09:21, Johan Hovold wrote:
> > > > On Thu, Apr 04, 2024 at 10:42:22AM +0530, Krishna Kurapati wrote:
> > > >  
> > > >> +static int dwc3_get_num_ports(struct dwc3 *dwc)
> > > >> +{
> > > >> +	void __iomem *base;
> > > >> +	u8 major_revision;
> > > >> +	u32 offset;
> > > >> +	u32 val;
> > > >> +
> > > >> +	/*
> > > >> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> > > >> +	 * needed to get information on number of ports present.
> > > >> +	 */
> > > >> +	base = ioremap(dwc->xhci_resources[0].start,
> > > >> +		       resource_size(&dwc->xhci_resources[0]));
> > > >> +	if (!base)
> > > >> +		return PTR_ERR(base);
> > > > 
> > > > This is obviously still broken. You need to update the return value as
> > > > well.
> > > > 
> > > > Fix in v20.
> > > 
> > > If one patchset reaches 20 versions, I think it is time to stop and
> > > really think from the beginning, why issues keep appearing and reviewers
> > > are still not happy.
> > > 
> > > Maybe you did not perform extensive internal review, which you are
> > > encouraged to by your own internal policies, AFAIR. Before posting next
> > > version, please really get some internal review first.
> > 
> > Also get those internal reviewers to sign-off on the commits and have
> > that show up when you post them next.  That way they are also
> > responsible for this patchset, it's not fair that they are making you do
> > all the work here :)
> > 
> 
> I like this idea and I'm open to us changing our way of handling this.
> 
> But unless such internal review brings significant input to the
> development I'd say a s-o-b would take the credit from the actual
> author.

It does not do that at all.  It provides proof that someone else has
reviewed it and agrees with it.  Think of it as a "path of blame" for
when things go bad (i.e. there is a bug in the submission.)  Putting
your name on it makes you take responsibility if that happens.

> We've discussed a few times about carrying Reviewed-by et al from the
> internal reviews, but as maintainer I dislike this because I'd have no
> way to know if a r-b on vN means the patch was reviewed, or if it was
> just "accidentally" carried from v(N-1).
> But it might be worth this risk, is this something you think would be
> appropriate?

For some companies we REQUIRE this to happen due to low-quality
submissions and waste of reviewer's time.  Based on the track record
here for some of these patchsets, hopefully it doesn't become a
requirement for this company as well :)

thanks,

greg k-h

