Return-Path: <linux-kernel+bounces-133997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D892489ABDD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40112B215D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132A3BBF1;
	Sat,  6 Apr 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jweD7ZXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7C2943F;
	Sat,  6 Apr 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419441; cv=none; b=Alz76nlO3r5h7Iu/j/VZB+Bt34CSuCfsi9cFjbsOagWHSbVi8rt4dWdTSxSPrhpxn3l5EXVwbv+Ci2zsfXAFm8fv46Jm3WN1T3xI9rjfbPtPhjXkW8p3z47vwg5DwETGWJW+trRRTU2e/4+kIp3/GvEpEmc79MBmkdsJRFM4ZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419441; c=relaxed/simple;
	bh=2INVDo7T/+YeVJ1P5sAhixC0o7iVfIgS+M5BX7Wim/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arudpzQiPedH/RB088PwAD/MlIChp9pYdvjILAISEPXuKkhNhFDA3A/n55/edimHYwx/FhVdsCyv8yQNLuZPbCU3kGLs5GHkq/n6eM2pJrNdLQ992gMqDLqTpXA2p4frzNFN4MQSv0f5MonxqN7k1Nf2lKBPYKfIMo2NqciojQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jweD7ZXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129E2C433C7;
	Sat,  6 Apr 2024 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712419440;
	bh=2INVDo7T/+YeVJ1P5sAhixC0o7iVfIgS+M5BX7Wim/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jweD7ZXv2QxoMo4HV+/UBhjNMw4XKjD1qbw3n6VTeM2TZJWO3iRUpAlnlGy9GwktG
	 UNZ2HvkIgrKuumLMPr66XuG7TtI72lngK+A+xfyEo4GkAwS3YsMFfPMEZ7Zfk67mE9
	 epOC2cWFtpSmW0aaoCu9n+kDpyCRprxEgFkKggm2TL3T48lo+HvsoIksV51F8iK5S8
	 EAMLv7MZrtQteBDkvKfcML6h7XuHBGzSBjd2f8tVK58B1cipo/du4L1JrnnE99raQZ
	 zXB0VxWJFarVjwfCeiFuQMdS5XW4vuWstyuxfvCtTWBsyerBZ4q7KxE8eI49uQPtd4
	 VL8jMqM/CHDsg==
Date: Sat, 6 Apr 2024 17:03:54 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching
 aggregator
Message-ID: <20240406160354.GW26556@kernel.org>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404114908.134034-1-tbogendoerfer@suse.de>

On Thu, Apr 04, 2024 at 01:49:08PM +0200, Thomas Bogendoerfer wrote:
> If selection logic decides to switch to a new aggregator it disables
> all ports of the old aggregator, but doesn't enable ports on
> the new aggregator. These ports will eventually be enabled when
> the next LACPDU is received, which might take some time and without an
> active port transmitted frames are dropped. Avoid this by enabling
> already collected ports of the new aggregator immediately.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Hi Thomas,

I will leave the technical review to Jay and others.  But as a fix, I think
this patch warrants a Fixes tag. It should be sufficient to respond to this
email thread with an appropriate tag.

> ---
>  drivers/net/bonding/bond_3ad.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..529e2a7c51e2 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1876,6 +1876,13 @@ static void ad_agg_selection_logic(struct aggregator *agg,
>  				__disable_port(port);
>  			}
>  		}
> +
> +		/* enable ports on new active aggregator */
> +		for (port = best->lag_ports; port;
> +			port = port->next_port_in_aggregator) {
> +			__enable_port(port);
> +		}
> +
>  		/* Slave array needs update. */
>  		*update_slave_arr = true;
>  	}
> -- 
> 2.35.3
> 
> 

