Return-Path: <linux-kernel+bounces-77266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F418860317
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94664B35459
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680C54918;
	Thu, 22 Feb 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RgBGhbB7"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E714B823;
	Thu, 22 Feb 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630470; cv=none; b=fgyhVHYQ+nGGjS5drGvTNLPiA9IQ5IQRvp2bpqAg5uzBRkvfdfCHDyp0cC2SQChyzZhO3QnFslVMhKGk0G/LeAhCwFlIJ2NafRW4GClnoh9MbrOXh2cp0xEiUou42nAi6s28UCnDVJ3/B7xB/dTE+/vW3tcdNPtiChtQGJhxDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630470; c=relaxed/simple;
	bh=PTipSeKqlNAu30qb955PR0nKMfxLG0Kc7Ysdd8vFej0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmSSLPYmWt9HOSmwU1YWN3gjczULtix2hMzmWWql74wJT8fuQp6WhUKFz84Obmfhq+SkmBp44DLYxVkCrMYdyMHrmw4LnFPuS8G44+pO+i9rNFY26YkcPb/cIn2yVSjh3ZQ1l/jpseDFF1AwYx23teJ6tis8IpA+qEkrcChzavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RgBGhbB7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=39Kd0ofy/fqsimQpjegVGcEoG7ezFZOXM7r9f4e+voY=; b=RgBGhbB7+fm9zit83qCVkNxMYq
	dYZFHE49nHIwjpfdsME6RqYBhDgfZuZW58bcuYIbZeXHxP+ZZoO8M67AG6/UajFoz56UYSEucC47c
	3CaegnvmHTdCwwUxeUbwcylX+deZ1hkENmDDdqBcBIzQpDBtPZUQfN2eBlwnr2VVOD+U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdEq1-008TXr-HC; Thu, 22 Feb 2024 20:34:33 +0100
Date: Thu, 22 Feb 2024 20:34:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Message-ID: <024fd8e1-8d1c-4073-99ff-ae8c5d123baa@lunn.ch>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
 <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222153848.2374782-4-vineeth.karumanchi@amd.com>

On Thu, Feb 22, 2024 at 09:08:47PM +0530, Vineeth Karumanchi wrote:
> - Enable WOL for ZynqMP devices.
> - Enable queue disable and WOL for Versal devices.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 62d796ef4035..55d8c1f3ee80 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4903,7 +4903,7 @@ static const struct macb_config np4_config = {
>  
>  static const struct macb_config zynqmp_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
> -		MACB_CAPS_JUMBO |
> +		MACB_CAPS_JUMBO | MACB_CAPS_WOL |
>  		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
> @@ -4954,7 +4954,9 @@ static const struct macb_config sama7g5_emac_config = {
>  
>  static const struct macb_config versal_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
> -		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
> +		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
> +		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_NEED_TSUCLK |
> +		MACB_CAPS_WOL,

So WoL is a proprietary extension only available in AMD versions of
the MACB?

    Andrew

