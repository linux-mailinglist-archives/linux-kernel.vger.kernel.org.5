Return-Path: <linux-kernel+bounces-69943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44305859097
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0109F282EB0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFCC7C6F6;
	Sat, 17 Feb 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vrU7z599"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401E7C6D5;
	Sat, 17 Feb 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708184561; cv=none; b=iIyPp8kMOOBgTV63eO1JkiRiQXDa0YN39JkNoaBx45OIf1ckhmm+mOkqXKZlEOiem9whgw2EeLANwUbMtpzuclarV3Vh0CbppFPTpFiKkJaUY9EzN66fdiXDANzyaNLWlru6oToh6b+1axI433NeeTrnPow4exeS0WoakZjCdk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708184561; c=relaxed/simple;
	bh=ChToIvP8lVT0GtyxDw2yhEJ2NTIdng8y9ELThsMetr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhCLcNVXbaoH/wll3nnffH1n8EPH+2TFaviVYphO93nEVIY44vdc+C0zzeCkrBoedteCn3GOc+r7KpCKmgDsMAVG0wail7rOzhkfyaayrtPAkSg15toa8BM3KVAA4UNsyyaqZccUc7lZ+Q5q6E2VGeThv6Cv+NcrJk/4XRiKudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vrU7z599; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hyTsVZvPOhq79PS84Thyf/yoHFQO7m0i8y9DG0PSI5A=; b=vrU7z599BWlAkeDTdgyyKpXP67
	nT8ayE66/TNIPNHA8wAzS3p5JtjmKE6Q7RkssnMcZnX03PKWZADdX0R0TUbuWECa4FZipDOwZYtPG
	mIht76gwd9FOoQCUxCkuAPI3/YOVX2YiMtGnutwusbLEM258WET++ekmvatW/IWGQ/Sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbMps-0084H5-7o; Sat, 17 Feb 2024 16:42:40 +0100
Date: Sat, 17 Feb 2024 16:42:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ciprian Regus <ciprian.regus@analog.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dell Jin <dell.jin.code@outlook.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Yang Yingliang <yangyingliang@huawei.com>, netdev@vger.kernel.org
Subject: Re: [net-next] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE
 poll interval
Message-ID: <b3c8d287-3715-4c03-be3e-e94253f6d2ac@lunn.ch>
References: <20240216103636.1231815-1-ciprian.regus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216103636.1231815-1-ciprian.regus@analog.com>

On Fri, Feb 16, 2024 at 12:36:32PM +0200, Ciprian Regus wrote:
> In order to do a clause 22 access to the PHY registers of the ADIN1110,
> we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
> then poll the MDIO_TRDONE bit (for a 1) in the same register. The
> device will set this bit to 1 once the internal MDIO transaction is
> done. In practice, this bit takes ~50 - 60 us to be set.
> 
> The first attempt to poll the bit is right after the ADIN1110_MDIOACC
> register is written, so it will always be read as 0. The next check will
> only be done after 10 ms, which will result in the MDIO transactions
> taking a long time to complete. Reduce this polling interval to 100 us.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  drivers/net/ethernet/adi/adin1110.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
> index d7c274af6d4d..6fca19e6ae67 100644
> --- a/drivers/net/ethernet/adi/adin1110.c
> +++ b/drivers/net/ethernet/adi/adin1110.c
> @@ -467,3 +467,3 @@ static int adin1110_mdio_read(struct mii_bus *bus, int phy_id, int reg)
>  	ret = readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
> -				 (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
> +				 (val & ADIN1110_MDIO_TRDONE), 100, 30000);
>  	if (ret < 0)
> @@ -498,3 +498,3 @@ static int adin1110_mdio_write(struct mii_bus *bus, int phy_id,
>  	return readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
> -				  (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
> +				  (val & ADIN1110_MDIO_TRDONE), 100, 30000);

The kernel can have trouble sleeping for such short times. It might
make sense to swap to the _atomic version which spins rather than
sleeps. If you are just reading a few PHY registers every so often, it
might not be worth it. But if you have an Ethernet switch and need to
access a lot of registers, it could make it a bit faster.

       Andrew

