Return-Path: <linux-kernel+bounces-33835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B666B83707E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D565BB2DFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51163FE32;
	Mon, 22 Jan 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNydHcMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD563FE28;
	Mon, 22 Jan 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945001; cv=none; b=OGRkyB/d1mZ+KeHKbI8cbqbZIN0tVA6F6w1D3MhTNbt0sALGkRjTxj29hYqD1sQOs1QMacZJdVgbI04ZnmXdBzj7F9Od+NDuXlmlATyancA1ZPV8lDPb3hXOuc7HsxgKGVlxpbTS6GnqhMU4kj8fc0QxU8YCgqICtnDKbDYOEkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945001; c=relaxed/simple;
	bh=Do6GH6AFLzNEnY0lWxGGX8GYLxuoxZy9j7mds6kAXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byK4cZRH7HSQx7DPSAFL0xOjk07ujLQcQwFl4egwRPw6q6LiwKHnDgLpo7cR4bzhW8KUI3TX/jk/9LTdWL1G7qjli1pkisODiVmOOK1wTeE/NXNK1J547m8LCs2OT6esc4M6UD9bKwiOXikSu8ApmpsCaMA/dcweztY2uD3xrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNydHcMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3F0C433F1;
	Mon, 22 Jan 2024 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705945000;
	bh=Do6GH6AFLzNEnY0lWxGGX8GYLxuoxZy9j7mds6kAXtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNydHcMc7/QEWugoSfbb5DWGOsn4aK0LhJI/R6p3sYhfcxjihuoQJMsx+CLWiP4Rp
	 iEjmCVn28bQmDNgNOSCty7gUppgoTTJ5FcGqnSqk1yYwm0oZcfd1F1MaNdFGsQN5Hp
	 nOCX5iUjak5ju5xd7nDQ0NU4HQAd6ixUqMn6AOJqwyvTzVur3V9rp+ZjN4u3GEOWtT
	 Ncr++vP9S2Q0J33y/DRBGQpE9xQpt7CTGuOCHMTy8LItf/pZAfCCyDUdEqelwLgOho
	 QWYZvo5owITvfDI1bS5prylQ1daAB6DvisORykBpQ3ichc1dv+WW5Xe+0c0izoy8Ix
	 FC+xyP+nhIApA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRyE7-000000000su-3oVt;
	Mon, 22 Jan 2024 18:36:52 +0100
Date: Mon, 22 Jan 2024 18:36:51 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp: Fix PCIe PHY
 power-domains
Message-ID: <Za6ns-xhN3N-cmIr@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-1-13d12b1698ff@linaro.org>
 <ZY6sh8nlEUyEfL0u@hovoldconsulting.com>
 <20231229170334.GA9098@thinkpad>
 <20240122172528.GE3176@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172528.GE3176@thinkpad>

On Mon, Jan 22, 2024 at 10:55:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 29, 2023 at 10:33:34PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Dec 29, 2023 at 12:24:55PM +0100, Johan Hovold wrote:
> > > On Wed, Dec 27, 2023 at 11:28:26PM +0100, Konrad Dybcio wrote:
> > > > The PCIe GDSCs are only related to the RCs. The PCIe PHYs on the other
> > > > hand, are powered by VDD_MX and their specific VDDA_PHY/PLL regulators.
> > > 
> > > No, that does not seem to be entirely correct. I added the power-domains
> > > here precisely because they were needed to enable the PHYs.
> > > 
> > > This is something I stumbled over when trying to figure out how to
> > > add support for the second lane pair (i.e. four-lane mode), and I just
> > > went back and confirmed that this is still the case.
> > > 
> > > If you try to enable one of these PHYs without the corresponding GDSC
> > > being enabled, you end up with:
> > > 
> > > [   37.709324] ------------[ cut here ]------------
> > > [   37.718196] gcc_pcie_3b_aux_clk status stuck at 'off'
> > > [   37.718205] WARNING: CPU: 4 PID: 482 at drivers/clk/qcom/clk-branch.c:86 clk_branch_wait+0x144/0x15c
> > > 	
> > 
> > Technically this patch is correct. PHYs are backed by MX domain only and not
> > GDSCs. Only the controllers (PCIe, UFS, USB) are backed by GDSCs. The fact that
> > you are seeing issue with PCIe Aux clock suggests me that this clock may not be
> > applicable to the PHY but it needs to be enabled for working of the PHY somehow.
> > I'll try to find the details on how exactly it is needed.
> > 
> > But if I get the answer like, "This clock is also sourced to PHY directly", then
> > we may need to add dual power domain for PHY (both GDSC and MX).
> > 
> 
> So I answer I got from Qcom is that this clock is only applicable to the PCIe
> controller and not PHYs. On some platforms, there is a separate PCIE_PHY_AUX_CLK
> coming from GCC that is used during L1SS state. I think that caused confusion
> while adding PHY support for followup platforms and folks just used PCIE_AUX_CLK
> since they couldn't find the actual PCIE_PHY_AUX_CLK.

Thanks for sorting that out.

> I've prepared a series to fix this mess, but I want to know how you end up
> seeing the above "clk status stuck at off" issue. Is there an actual usecase for
> powering up PHY without controller or you just experimented with it?

As I mentioned, I ran into this when experimenting with how to enable
the "companion" PHY for four-lane support. There shouldn't be any use
case for it (apart from using it to determine that the current
description of the PHY resources is incomplete or incorrect).

Johan

