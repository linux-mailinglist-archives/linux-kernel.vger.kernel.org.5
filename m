Return-Path: <linux-kernel+bounces-131477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E489885F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A688B28F0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95486AE9;
	Thu,  4 Apr 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dOG/EwnY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C884FDC;
	Thu,  4 Apr 2024 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712235535; cv=none; b=U62ebtWRMqeSOZ2zJIVbHy5wazrNRPIsUwCutjWd4hbODBkisNJMyVzOQDeb+2/+JmcFc9rfK40oA4RI+IFBUGTRZyfyMqqEsHIW/TYsTBYi8NPdpkuVQqbww3WwUKV53VBp1Umkr+lvyofghB5bt99H1/xxnrrT5yehSK0O4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712235535; c=relaxed/simple;
	bh=e4z/GzRWpDRXJLhe/4fG3IWJDUVrYxWUreNz72c6e0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKCOlcI2DyIMwJNeJu9S05V9MrVe5jeLc8iLnR2IiJ54zEdmvH+6dyvi9+eOxO9TCr2ZbcYSEuWhvJgey1pQv8gRnqpWAVQVzqMDznI49+Fp8PrcAkD1WChPRuQi2dOTJPBuvKA0u+HP/8dS0wESqoFHbURtBC3CVnJkinnKGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dOG/EwnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F5C433C7;
	Thu,  4 Apr 2024 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712235535;
	bh=e4z/GzRWpDRXJLhe/4fG3IWJDUVrYxWUreNz72c6e0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOG/EwnYIgKjruqwEAD+H0CxE1B+woRHqrJtY9qL4W91RDu3+X6kKn2qLP1sUnaTr
	 6dv482jyRH45C6wg6Lft+D5d91FCNNUH+/naPq4ArQLsd9MCoiyoi0rhdrntjLFwDI
	 o0DoZRv+CA7WYblM95Nfdc2pg6bg3Pz1OfBJINH0=
Date: Thu, 4 Apr 2024 14:58:52 +0200
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
Message-ID: <2024040436-wife-winner-9a25@gregkh>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
 <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
 <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>
 <2024040455-sitting-dictator-170c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040455-sitting-dictator-170c@gregkh>

On Thu, Apr 04, 2024 at 02:58:29PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 04, 2024 at 10:07:27AM +0200, Krzysztof Kozlowski wrote:
> > On 04/04/2024 09:21, Johan Hovold wrote:
> > > On Thu, Apr 04, 2024 at 10:42:22AM +0530, Krishna Kurapati wrote:
> > >  
> > >> +static int dwc3_get_num_ports(struct dwc3 *dwc)
> > >> +{
> > >> +	void __iomem *base;
> > >> +	u8 major_revision;
> > >> +	u32 offset;
> > >> +	u32 val;
> > >> +
> > >> +	/*
> > >> +	 * Remap xHCI address space to access XHCI ext cap regs since it is
> > >> +	 * needed to get information on number of ports present.
> > >> +	 */
> > >> +	base = ioremap(dwc->xhci_resources[0].start,
> > >> +		       resource_size(&dwc->xhci_resources[0]));
> > >> +	if (!base)
> > >> +		return PTR_ERR(base);
> > > 
> > > This is obviously still broken. You need to update the return value as
> > > well.
> > > 
> > > Fix in v20.
> > 
> > If one patchset reaches 20 versions, I think it is time to stop and
> > really think from the beginning, why issues keep appearing and reviewers
> > are still not happy.
> > 
> > Maybe you did not perform extensive internal review, which you are
> > encouraged to by your own internal policies, AFAIR. Before posting next
> > version, please really get some internal review first.
> 
> Also get those internal reviewers to sign-off on the commits and have
> that show up when you post them next.  That way they are also
> responsible for this patchset, it's not fair that they are making you do
> all the work here :)

"you" meaning Krishna, sorry for any confusion here.

