Return-Path: <linux-kernel+bounces-72540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2730485B4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F31280F67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223A25C900;
	Tue, 20 Feb 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/YeIefq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AEA41215;
	Tue, 20 Feb 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417406; cv=none; b=K1/JZvmVI8g+zjvhKio+jIZXLtkd9klvcfJMAgJ/tEFCY9YP49XCeZclPZ+7pVJABr1qu3tc9W/Am+tUoZsDW9ItJrr6Yx/LEYZ4IVpWnyRCSzTGR67RQhhPnegJ5U8DU0ih0AUo7sVRVDDSLfImqn56gUEpbyhk0UbCRFLsKOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417406; c=relaxed/simple;
	bh=Nf/BMUVPzmrkw7nlEkpvKgeiXFDPdOK5C8QKwBwv4oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAlW/9EcTwszJYMrSZ5xAu2q7rdwMo367kkAtxrEwWvSefNSLhIdhKYBY/Imdcnc/wedB3nHFcHcGOy+TV3xrGZKHXWSFbZWWKbaoY2Z5UFblAj44nt7XHUk7X0SwTL5ptrwDY9jScoew4jNvgv+0mMox7KgEsoOGGiMfeR7rfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/YeIefq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6940C433F1;
	Tue, 20 Feb 2024 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417405;
	bh=Nf/BMUVPzmrkw7nlEkpvKgeiXFDPdOK5C8QKwBwv4oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/YeIefq+zuvaG5nrm8GRps/2GdfpASMSkFwHM/hyIti5vHcnsPfnsLGVxSVcSFTd
	 H25HSCjIfoKY/oL/2O+LYXzXuEtue9baI2VNgyw+6+Gp3uH1GLvVhN54oRgeM+P2JB
	 REcBPZLikFNjPxTGF1Tyrrp3BixcXRDjxPxKToZ6E41D3fxfPk0lXfIAigElJH1Gbf
	 NDqreEp+ql/mwKRNcR1bKSOXftdCxg2qPSffRRLv9oAABd3PKvqJmh0odU/ZGA1EOH
	 j8u4t9bN/2axzAtYqTRg3QcUNElTyfi3w03Pa6cL5O1Qg+I/xIFd7CmjPdvo5uoNJv
	 xjfnwBBjeOZsQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcLPQ-000000002WT-0bsS;
	Tue, 20 Feb 2024 09:23:24 +0100
Date: Tue, 20 Feb 2024 09:23:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Message-ID: <ZdRhfCXejhrKQLPC@hovoldconsulting.com>
References: <20240215170258.GA1292702@bhelgaas>
 <a12217ec-ce63-4312-a412-9a5c8d1d92fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12217ec-ce63-4312-a412-9a5c8d1d92fe@linaro.org>

On Thu, Feb 15, 2024 at 06:46:55PM +0100, Konrad Dybcio wrote:
> On 15.02.2024 18:02, Bjorn Helgaas wrote:
> > On Thu, Feb 15, 2024 at 02:35:13PM +0100, Alexander Lobakin wrote:
> >> From: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> Date: Thu, 15 Feb 2024 11:39:31 +0100
> >>
> >>> According to [1], msleep should be used for large sleeps, such as the
> >>> 100-ish ms one in this function. Comply with the guide and use it.
> >>>
> >>> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
> >>>
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>> Tested on Qualcomm SC8280XP CRD
> >>> ---
> >>>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
> >>>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
> >>>  2 files changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >>> index 250cf7f40b85..abce6afceb91 100644
> >>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >>> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >>>  		if (dw_pcie_link_up(pci))
> >>>  			break;
> >>>  
> >>> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> >>> +		msleep(LINK_WAIT_MSLEEP_MAX);
> >>
> >> Just use fsleep(LINK_WAIT_USLEEP_MAX) and let the kernel decide which
> >> function to pick.
> 
> IMO, fsleep only makes sense when the argument is variable.. This way, we
> can save on bothering the compiler or adding an unnecessary branch

I fully agree. Using fsleep() with a constant just looks sloppy (e.g.
with that hardcoded usleep range) and hides what is really going on for
no good reason.

Johan

