Return-Path: <linux-kernel+bounces-55180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3B84B8E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8399328D74B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD113474B;
	Tue,  6 Feb 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1qyTm/0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86013328A;
	Tue,  6 Feb 2024 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232120; cv=none; b=Suyrc69GgZ0iysh3tmdT4VUri4Fgsd4zDeurId9ugjdnU+5LmSF91zjZTwlNcRd9YPUoDTctoNWOB9lI16GA2GDgZAsc/+D9mA4xWFeUCn29Ajirvpy5FUI9Y8HE9RGsrjiDXrBY2lWDULGANscX7a5LtgNC+rTV1E+xD+OIjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232120; c=relaxed/simple;
	bh=y0RNzdVJndYWSP0vGgdOxK1NMGHChFiuRWotjCrpl0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXVLakBmOB7V2UeMyJ+UNhW+y5gEuBO8ruRI6/Oz2G9dytldbqeVEVjzqxyp9et+Zk72zJ/KbiIFWWpvyRC6izI6b1omhEApQ7YS2rutHGQ5lCHRqP/hvWXSZx++jIHW9pqazWy9i87wAl+IaKo3MaaMnn3JK9GYsXdKjWkiQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1qyTm/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A01C433C7;
	Tue,  6 Feb 2024 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707232119;
	bh=y0RNzdVJndYWSP0vGgdOxK1NMGHChFiuRWotjCrpl0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1qyTm/0U+yzlb1K9Uzww22xl2BagUxKRr4E8pXRsIdKwRSutYO3C14gDCXxpMJ/d
	 mPOgS/R5rdvmKhQPQqWgN6jB7CDkL8nbolZ2Qy/dVFSlBpc02UqkxXnh7lru3JQ6R+
	 FHexHrssJkeJ0Fd0gepitxGMeB4XtUeU2WGxGWqZ3zdiPdsxBL08iYXnB8ZViIjSxA
	 dIWYMhwbfW8ZcorLnhgSnUkLUOhsgtkMEZW26ZLWcZm+/Zd/OfuBb1lKum6H/aHwQE
	 L/6ijl3lLIUQXQtXH+qlWsgLKPeSGfGP7TDQBtNzbBsFUoIx0ta5PUN+LzABn/gHKU
	 RmXipacSQ1HGg==
Date: Tue, 6 Feb 2024 15:07:04 +0000
From: Simon Horman <horms@kernel.org>
To: Pavel Sakharov <p.sakharov@ispras.ru>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] stmmac: Fix incorrect dereference in stmmac_*_interrupt()
Message-ID: <20240206150704.GD1104779@kernel.org>
References: <20240203150323.1041736-1-p.sakharov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203150323.1041736-1-p.sakharov@ispras.ru>

On Sat, Feb 03, 2024 at 06:03:21PM +0300, Pavel Sakharov wrote:
> If 'dev' is NULL, the 'priv' variable has an incorrect address when
> dereferencing calling netdev_err().
> 
> Pass 'dev' instead of 'priv->dev" to the function.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Pavel Sakharov <p.sakharov@ispras.ru>

Thanks Pavel,

I agree with your analysis that this can result in a NULL dereference.
And that your proposed fix is good: netdev_err() can handle a NULL
dev argument.

As this seems to be a fix I suggest it should be for net.
And that it should be based on that tree and designated as such
in the subject:

Subject: [PATCH net] ...

Also if it is a fix, it should have a fixes tag.
Perhaps this one:

Fixes: 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")


I don't think there is a need to respin for the above, though please
keep this in mind when posting Networking patches in future.


Looking at the patch above, and stmmac_main.c, it seems that the following
functions also suffer from a similar problem:

static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
{
	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
	...
	dma_conf = container_of(tx_q, struct stmmac_dma_conf, tx_queue[chan]);
	priv = container_of(dma_conf, struct stmmac_priv, dma_conf);

	if (unlikely(!data)) {
		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
		...

And stmmac_msi_intr_rx(), which follows a similar pattern
to stmmac_msi_intr_tx().

I also note that in those functions "invalid dev pointer" seems misleading,
perhaps it ought to be "invalid queue" pointer.

As these problems seem to all have been introduced at the same time,
perhaps it is appropriate to fix them all in one patch?

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4727f7be4f86..5ab5148013cd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5848,7 +5848,7 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
>  	struct stmmac_priv *priv = netdev_priv(dev);
> 
>  	if (unlikely(!dev)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> +		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
>  		return IRQ_NONE;
>  	}
> 
> @@ -5868,7 +5868,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
>  	struct stmmac_priv *priv = netdev_priv(dev);
> 
>  	if (unlikely(!dev)) {
> -		netdev_err(priv->dev, "%s: invalid dev pointer\n", __func__);
> +		netdev_err(dev, "%s: invalid dev pointer\n", __func__);
>  		return IRQ_NONE;
>  	}
> 
> 

