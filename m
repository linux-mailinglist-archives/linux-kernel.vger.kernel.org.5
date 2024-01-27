Return-Path: <linux-kernel+bounces-41441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0163983F177
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E77B24E99
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A47200B2;
	Sat, 27 Jan 2024 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK4rkd8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E531F946;
	Sat, 27 Jan 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706396749; cv=none; b=jFBKTRRiFP42dkcF1go+7eXZY+fxXkia6e3bzTo9uburC8zOgnSYB5sgaSC0RXItEbsIbM0grVMptQNaxEP2gTjqORbkRUTw8F/pj79f3hX1uvhN30Mh4WTyiimq/hdiZujyNHlib8EolWOXmeKTPl/H9yvjF4vuUG/xWfmev5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706396749; c=relaxed/simple;
	bh=/yaiKqzmIqnD8fr1qIOUHF0xjSRO2KGj2637HcMaerY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBqftbnwWSuUPi2TsaDTireo44NonNoiKAVdo0CtcFKO63+lyPVIV0OMcCMz7rvLEsvgQVWqlXWmHXHPBlb8QJjWasKHQId9AwN8L+tbCtEVmpNuugXINOrybBb3OJFCoof6yE2H8Mg1JGC/sHpgsg+q4tJgRpbM1fFT7a4cUAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK4rkd8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8E1C433F1;
	Sat, 27 Jan 2024 23:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706396748;
	bh=/yaiKqzmIqnD8fr1qIOUHF0xjSRO2KGj2637HcMaerY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MK4rkd8Ulvzp65xBfacaVnFBaCqEfhiKN5k1B7YRXHECj5lCi7z2q3o8YlONV9yON
	 zlkX6PGszyWdhQaqB+u8Jj7G6F7mKeeHJTzogLqNWIrsjY7oLppQ7xvSF87/TX+TCK
	 fbtBqcYD1Fv3IpButCg636K5EJw8IXJ3Pf2HfahvEky1xgOOeOxGnGOi5m/L6+5jt+
	 TztClaMoDgoqXDjNz6HA7whjHmNURG3e4ZeBrIu1KsF0Osu3QvJ3Uga1iyU3mpRa86
	 jcsnvKmN+skibxV1447hVfMTD8LuAlzWP9cmaX/n8sQdiczitRNBW/+6GO0JrYtPuN
	 yeTpmQwNLrgCQ==
Date: Sat, 27 Jan 2024 17:05:45 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Re: [PATCH 09/18] clk: qcom: gcc-sm8250: Set delay for Venus CLK
 resets
Message-ID: <5vi4an3kgmekjnfupigr6ukxrwanieavvvzmxv2vy3wozjjh3z@ulvjm7qmtbbc>
References: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
 <20240105-topic-venus_reset-v1-9-981c7a624855@linaro.org>
 <0cbedc75-cacf-43f8-a1f9-284546ad548a@linaro.org>
 <19eceba8-dfc3-40d0-a681-8c47a0248cfd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19eceba8-dfc3-40d0-a681-8c47a0248cfd@linaro.org>

On Tue, Jan 09, 2024 at 10:33:39AM +0100, Konrad Dybcio wrote:
> 
> 
> On 1/9/24 01:34, Bryan O'Donoghue wrote:
> > On 08/01/2024 12:32, Konrad Dybcio wrote:
> > > Some Venus resets may require more time when toggling. Describe that.
> > 
> > May or does ?
> > 
> > I'd prefer a strong declaration of where this value came from and why its being added.
> > 
> > May is ambiguous.
> > 
> > "Downstream has a 150 us delay for this. My own testing shows this to be necessary in upstream"
> 
> Alright
> 
> > 
> > Later commits want to add a 1000 us delay. Have all of these delays been tested ?
> 
> No, we don't support Venus on many of the newer SoCs..
> 
> 
> > 
> > If not please describe where the values come.
> 
> They come from the downstream Venus driver as you mentioned.
> I checked a couple different downstream SoC kernel trees and
> tried to assign the values based on what I found in a kernel
> for that platform. Some are fairly educated guesses.
> 

It would be nice to have documented for which cases you guessed (and in
which downstream kernel you found other values?), so that if anyone is
coming to the tree later with conflicting information they have a better
chance to reason about the discrepancy.

Thanks,
Bjorn

