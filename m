Return-Path: <linux-kernel+bounces-32178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31C8357B6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA82281C65
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82443383AE;
	Sun, 21 Jan 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STl59HRD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B773538DD0;
	Sun, 21 Jan 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705868640; cv=none; b=H+jUuBJDfvC1MC0toZIUbngMGt3xIfDsOmMKDcPx0QnE0eecv0YkKMaI3h4EwRHfgDnatGTRHSNMKpDjZUGbpHV/RVz+INUuyO0DtCEMhBO8Dc7/qhN274nrBiJbBLUrpO3Qv0SUOeEwTmji6JIMjwZ44k8MJV2eTfsBT5h+juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705868640; c=relaxed/simple;
	bh=hs42N2C+xUm1gTqinAojhsQuAhZQ8ePYG1KOf7Y3jvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnN9UJ8h5KCbw8uSCo1aEd1Ku9R4eG0b8eCthqipnYYwTS3dSOTS+SwyUMSwTZztjoYYXg223XkyACLOpTYB2d04R7n7F1xCe3AkJhi8yg1vkSvFnuJ//21A5uKkhbDk7/XcVOrN4hz4BMIWrIcA2FpLyKmlCuztatWJTjZW8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STl59HRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747F5C433F1;
	Sun, 21 Jan 2024 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705868640;
	bh=hs42N2C+xUm1gTqinAojhsQuAhZQ8ePYG1KOf7Y3jvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STl59HRDNEhQUcRD+Ao/1CPpITABUWET2BiI33saPSP/zZtZDtXtRDPgHlzXFsg6W
	 IgBehHqPwlOx+Yzwi+bkezRfWUt1mM1PkVHdtcxEZxWWEKzaM+/Upr+K5FT6S6hBi0
	 DqqjyxOZPeER/CbsXuUMcTMeJah/Yf/OJP8U3aXdFYSEbQSopEScsxfmJQ8MT5Uvlz
	 p6Nk+1GjgUjIEVU2GjFgagweDfpEBxae6Y1bPifVKBE5eRFbyGFlpp9QH7ZXUjh48v
	 UWejpf52lH3k3jbMQ+wvj1XovESjt38Cu6+3KoF8nuTq7/vAevfE1DFj7GJ1se/Jfb
	 8ATmuHZDiDCjQ==
Date: Sun, 21 Jan 2024 21:23:54 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a
 dedicated macro
Message-ID: <k5ih3vurmzrirgfzy62r5nezm2sxp3zf2qa2bhzowybthkvduv@wjywn55v5hmj>
References: <20240120170001.3356-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120170001.3356-1-semen.protsenko@linaro.org>

Hi Sam,

>  	void __iomem *regs = sdd->regs;
>  	unsigned long val = 1;
>  	u32 status;
> -
> -	/* max fifo depth available */
> -	u32 max_fifo = (FIFO_LVL_MASK(sdd) >> 1) + 1;
> +	u32 max_fifo = FIFO_DEPTH(sdd);

Why have you removed the comment? Perhaps you could place it on
the side in order to remove that awful space.

Not a biding comment, though:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi

