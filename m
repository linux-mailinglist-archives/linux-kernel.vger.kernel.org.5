Return-Path: <linux-kernel+bounces-128433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE243895AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D9C287865
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F515AAA1;
	Tue,  2 Apr 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxQQ1VEH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53715A496;
	Tue,  2 Apr 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079312; cv=none; b=XRbMCl7VL1KXVqBVAm8helNT8eA302X3OaKokXfxgHl2g3Ej119ZyA4/SaZYWX0iNyq0o/ToHmQmaxBQRDiGbg4UZfr/z0dKspDAuQ05QMxMpsQY91khLpo0PG3/agwCcuCaTZnsJMQLgR4bMGPxbmbFbsD4VDGbAU55jEJIRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079312; c=relaxed/simple;
	bh=wBzm8T6Rb34bpqT8Nq4+CojqhG7K4UEU04DtqV8upio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNmIWI21F9lLUBNLCiYfc5L71HQxm9X1683g9H/W6thR65fkHDtbGy3RCYp7If1wFz68kmJuU11ru2TG31Wd8s4frzR0iiPeLlOAWaVgIB8UFa7jDXGx3jfexdEMpovFKHRBdDec096pUAGcSuq+K0xEw0jXAEWLRjifJ5gCPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxQQ1VEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D085CC433F1;
	Tue,  2 Apr 2024 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079312;
	bh=wBzm8T6Rb34bpqT8Nq4+CojqhG7K4UEU04DtqV8upio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxQQ1VEHWgEPT1gb+G4jyVk0mqkUI51x7+PHLcooEtUgUnJf/tIA7miamZ/EDDP5c
	 yGw8Hzmzx9sTXwcfa5Dw9O6OofDPLYISF0nUMRe3MIKOzGXkoAUcnT/yegABGHGo9l
	 +QTs7orcgkCIe/3UBRVGNGV0Dqo8oYfnFFXDmSYm2Cg+xv2IxLJKGDj6JzvJrmM+o7
	 oRB1C5OIbPfppwyC2g3idUgOmJoheRXKnfdp8QJhu5zQlwCrhhhmqXSBb5K+3tAksk
	 tb2pPY3F5rjha/cB88tnBb1kh0hueBUyvKehpqYssZYsxD56j84BHePlz6+RTaQMij
	 fbWy4GWFfTOaw==
Date: Tue, 2 Apr 2024 12:35:08 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
	Andy Gross <andy.gross@linaro.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8996: Add missing UFS host
 controller reset
Message-ID: <g4a6gl47kfjx47ww36qnwp7zgvbd5gi5r7d26ibitfrybaa3l4@gvnz2mhsdf4s>
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
 <20240129-ufs-core-reset-fix-v1-3-7ac628aa735f@linaro.org>
 <CAA8EJpphzwoCaetGfnM8dE478ic1-BMqXKA3XVLeC9j5BBu3SA@mail.gmail.com>
 <20240130065550.GF32821@thinkpad>
 <CAA8EJpqZYp0C8rT8E=LoVo9fispLNhBn8CEgx1-iMqN_2MQXfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqZYp0C8rT8E=LoVo9fispLNhBn8CEgx1-iMqN_2MQXfg@mail.gmail.com>

On Fri, Feb 09, 2024 at 10:16:25PM +0200, Dmitry Baryshkov wrote:
> On Tue, 30 Jan 2024 at 08:55, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 11:44:15AM +0200, Dmitry Baryshkov wrote:
> > > On Mon, 29 Jan 2024 at 09:55, Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > UFS host controller reset is required for the drivers to properly reset the
> > > > controller. Hence, add it.
> > > >
> > > > Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > I think I had issues previously when I attempted to reset the
> > > controller, but it might be because of the incomplete clocks
> > > programming. Let met check whether it works first.
> > >
> >
> > Sure. Please let me know.
> 
> With the clocking fixes in place (I'll send them in a few minutes) and
> with this patch the UFS breaks in the following way:
> 

Was this further reviewed/investigated? What would you like me to do
with this patch?

Regards,
Bjorn

