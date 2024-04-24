Return-Path: <linux-kernel+bounces-157628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A08B13CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FF9288348
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFB413BAE7;
	Wed, 24 Apr 2024 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db4GSOgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC81F5E6;
	Wed, 24 Apr 2024 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988307; cv=none; b=fwsRyXwm+0CH+K5uO9Z3I3teIhqmnYHhFGAVfJnvRObDQofrf2GUh3bx2134A7XCfmDSZEMpmU9RaieoAGjm33UFLX/053zYddxV2IESQqG6L2FeXh7Epmg4cS0htLKrc8kVv308X4qbqyQl4VqwxNrD/rYrraBRSwcCuVujMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988307; c=relaxed/simple;
	bh=jtmAwDifDGJc40Ti3DRzPkHknfQW48k+SMlypzp4lZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAE3izWFWBbHVtnhALdJA1WhZxb44GfR3RUlPq4X2KfScn/gHoR+1+UY/M3JCYUoHwm51+b3S/qwUAxKqvho+no9lOHJO+2bchiITayiPTEJeunQDyUf6iaThkBV1tkdlnFpks8pQjL7RdAEo+nesB6XMcngw3pGRjML3NXBGTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db4GSOgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA47BC113CD;
	Wed, 24 Apr 2024 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713988307;
	bh=jtmAwDifDGJc40Ti3DRzPkHknfQW48k+SMlypzp4lZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=db4GSOglHvJENshh/vuBu/MLHkqgfDPrR2ydUtSVPJW1JBWLfYzHD1EI/2jFTjMFU
	 0qKcqROUzsG5HeNOHNV0wC+nNbhxA1OjgvPLxNoER+83PNobrfSjTsfoTsXjTnbKH2
	 Hxvc7HvrRGU6Sp/ghYnWzpcWIyOSBxBsWa64WEEVFSi08Lm9tcpfYbFdEOjuTd/FsW
	 AWhlGaFX6Najj/9S/Lm5mhtUdQ73nsUJjp6HhavsN+3rzArL3v5KBaQHyGiwzSR7Pu
	 LgcQHjxXucVDpuy6qa3wcDJEFVrlfIuJkzCMaM9+3ryonnulvfCNMgqky3vx+lELhP
	 55v+0hyja4Wrw==
Date: Wed, 24 Apr 2024 14:51:44 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	ebiggers@kernel.org, linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	saravanak@google.com, willmcvicker@google.com
Subject: Re: [PATCH v2 01/14] dt-bindings: clock: google,gs101-clock:  add
 HSI2 clock management unit
Message-ID: <20240424195144.GA360683-robh@kernel.org>
References: <20240423205006.1785138-1-peter.griffin@linaro.org>
 <20240423205006.1785138-2-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423205006.1785138-2-peter.griffin@linaro.org>

On Tue, Apr 23, 2024 at 09:49:53PM +0100, Peter Griffin wrote:
> Add dt schema documentation and clock IDs for the High Speed Interface
> 2 (HSI2) clock management unit. This CMU feeds high speed interfaces
> such as PCIe and UFS.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/clock/google,gs101-clock.yaml    | 30 ++++++++-
>  include/dt-bindings/clock/google,gs101.h      | 63 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 2 deletions(-)

This collides with André's work adding HSI0. Perhaps combine the series 
or even the patches and just send clocks as a series. Then it is clear 
who should merge it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

