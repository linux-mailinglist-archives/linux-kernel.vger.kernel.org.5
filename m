Return-Path: <linux-kernel+bounces-166239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D78B97EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9665FB253A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5899B55C0A;
	Thu,  2 May 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwkGfPJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7A537E7;
	Thu,  2 May 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642753; cv=none; b=D7Tv92b9/L877FQs4ZWw+gM9eSRR/gR1LuQ1Cc3SWEWYTZXf1yfvYdtUjSdI8sQIy+SWyKTZLxQRclumXgndfHdpeyemnAldnP5F1rdST6oWv9wCcYInyGv5YNojce46m4QcmZJAGc7byMzXS8sc7QVER/oGndMEU2CLyRCHbUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642753; c=relaxed/simple;
	bh=8mafKWY5q67jj4nBY0miueGjmv2rHekZuRXfx8X1/P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL5+j+ngaLj/XAakKD5ROWbyT6ToU98N4oT2jGQwEcUxpQMen0mcKzA3ZF6bAhcKN+ip8bRRR+RKpzT9I83h0n8FGb3BnM+auHh6et3fgN4jcZ82ED9eOkPnu/cyMFAdBJMjYWyoJUA6dmZbrphzLZby0SXbR0Og7OmRpk1boWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwkGfPJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA5AC113CC;
	Thu,  2 May 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642753;
	bh=8mafKWY5q67jj4nBY0miueGjmv2rHekZuRXfx8X1/P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwkGfPJm6DBH24B89Ef0+HMIgplOwmlSNufy1z/Pi9SCUlcYcUNftef7joxhQs3E3
	 +I8O6noldS0x5tzlKXmEd9XKN84SO3ZQLkfrzcUjKH+9fCt/Rvo7o7uhxWD1yfnfJe
	 QwWrD+0aHwe9ah/BLzPpkLwWfAfLsFZ2xnHAlvznFYNXGLuQaMoUzvw+E8qLVhsL12
	 skGWNv14m+Wc+L9MDjCylzu/28zbg2faP++K66RAAO9N0VvQ325qavRJArL7V+gTW9
	 WoNtiys8H5Ysc8xamtgMNcRIqK+hk6I6PaO/JlSOelMzWLvNn3RWLbgTkFWV+FUDju
	 3rUw3AEt0aj/w==
Date: Thu, 2 May 2024 10:39:07 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
Message-ID: <20240502093907.GM5338@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418000736.24338-2-andre.przywara@arm.com>

On Thu, 18 Apr 2024, Andre Przywara wrote:

> While we list the "IRQ status *and acknowledge*" registers as volatile,
> they are missing from the writable range array, so acknowledging any
> interrupts was met with an -EIO error.
> 
> Add the five registers that hold those bits to the writable array.
> 
> Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
> Reported-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 48ce6ea693cea..d8ad4e120d379 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -210,6 +210,7 @@ static const struct regmap_access_table axp313a_volatile_table = {
>  
>  static const struct regmap_range axp717_writeable_ranges[] = {
>  	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
> +	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
>  	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
>  };
>  
> -- 
> 2.35.8
> 

-- 
Lee Jones [李琼斯]

