Return-Path: <linux-kernel+bounces-45019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFE842A85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D5CB2613E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B912BEAF;
	Tue, 30 Jan 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOAoU27o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424376C6A;
	Tue, 30 Jan 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634626; cv=none; b=XvlbItcCjRPyN9wwlpHTqCEjkhJ2k88Kg3w984RLV9a4GlhM56huZn7k6dTfxqHF/RicnsIdhV3KVoqvZatIANTF/ffm5dGOOnd+DcZBcCPgAOJl9ZhQi34+/ZvxVZeXQB0z/abMrvLk09kRGH6Z410jKidSSxrk9aoWu29y5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634626; c=relaxed/simple;
	bh=og6jQJBHeHMmvk9NQZFiuw3bMyKwy04HOIksyUv5hDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXMABRkv0gU1o3EuZxJcfc6ZEK2Wd67UoykuAX1wHOsIovgsJzccq9jknpCM+SO4a0zSGlH0CPwYpknSTHZXKg7X4MqUkx1IHMV04rUges+9vnotDFjqmuaj2vU6gJeNsgwion1V3qSbMYOADtdWkx5zaYnYoNfMrCtGF/gSFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOAoU27o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32125C43394;
	Tue, 30 Jan 2024 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706634625;
	bh=og6jQJBHeHMmvk9NQZFiuw3bMyKwy04HOIksyUv5hDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOAoU27oTREcKJoZUokKd9l4sXYb/pYwbZ4/1YTK115qFzgbJylQ55n4pbUp7XYT9
	 vdmaHDKn3EYlB0FGXAaYhiFC0Kzt2uEig3IBzhcEVmOrl7qr7vgslyTXBJqOTDexAT
	 0jlVNHGkr6o1a19siVrDKDFcjGHcGIs+CyuXm6uSZsXO7GmVr2/i85cvDtwzxe4xu6
	 97dYrEAyrvPizmIs85TtGQEn/oKh2kFKH1TSw4QnuK4EgmCotTKlocmKtPQNJgDFmi
	 BAQjXot3dAvJJzPGNUjM/A566m4pe/Chcl/im1poUwww9YOhbXN/UXeuB8hbExi/X4
	 zq1UKVgcxA+BQ==
Date: Tue, 30 Jan 2024 22:40:21 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vincent Shih <vincent.sunplus@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH] phy: sunplus: Fix a memory leak in update_disc_vol()
Message-ID: <ZbktfWM3bzuRrMok@matsya>
References: <451016052782f18c8b52ed0f836d7ab5c69bac3d.1706431643.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451016052782f18c8b52ed0f836d7ab5c69bac3d.1706431643.git.christophe.jaillet@wanadoo.fr>

On 28-01-24, 09:47, Christophe JAILLET wrote:
> 'otp_v', allocated by nvmem_cell_read(), is leaking.
> It must be freed before leaving the function to avoid a leak.
> 
> Fixes: 99d9ccd97385 ("phy: usb: Add USB2.0 phy driver for Sunplus SP7021")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative and based on comparison on the usage of
> nvmem_cell_read() in other driver.
> 
> Review with care.
> ---
>  drivers/phy/sunplus/phy-sunplus-usb2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/sunplus/phy-sunplus-usb2.c b/drivers/phy/sunplus/phy-sunplus-usb2.c
> index 637a5fbae6d9..50f1f91ac052 100644
> --- a/drivers/phy/sunplus/phy-sunplus-usb2.c
> +++ b/drivers/phy/sunplus/phy-sunplus-usb2.c
> @@ -105,6 +105,8 @@ static int update_disc_vol(struct sp_usbphy *usbphy)
>  	val = (val & ~J_DISC) | set;
>  	writel(val, usbphy->phy_regs + CONFIG7);
>  
> +	kfree(otp_v);

Looking at documentation, this should be nvmem_cell_put() see:
Documentation/driver-api/nvmem.rst

What do you suggest Srini?

> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0

-- 
~Vinod

