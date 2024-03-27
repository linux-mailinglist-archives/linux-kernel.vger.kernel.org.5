Return-Path: <linux-kernel+bounces-121306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8C788E547
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D13D1C2C722
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306D14AD0C;
	Wed, 27 Mar 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EJMw9/TA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2414A62F;
	Wed, 27 Mar 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543498; cv=none; b=jIk6siq8qoD5jwOybKj/m6knrcxrqGyxH1DO0+9T8D4T0ovoUCW5ygAMQMLGBgP0YpsWa/8gBDPI/HD952lXEn3fCoSRP8XWqdnFNY7shxIvtXvFlhusEMEWN6kt3ad9NNKdABG3bI2a0jXcC9fkj69ycbTiv/N3qc237Nk7Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543498; c=relaxed/simple;
	bh=KVlZQj8XUXytiuallTU5/HL5sY9jCIpvzzH0zeKt83Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3ORjcVRuV72E0gSBpwxkeSoN0l42OVebeTF8HwTkjlL2OknkVwBNvftBLxo0NqzQ+14MGhP0D1SaQKhKh2b+MHLaf4oPqNJpj+hwv+eCe/2NWXBH81MVjzL2I5BKlCfczisQPwxDzfrEjWU1Ab+a+wNwFovgpkXl/r3onZemnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EJMw9/TA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3Z065/I/LAJeMMl4zDwMUynhzEkIt59RXYcO6jgtIMk=; b=EJMw9/TA1wYV7JIcoHAuzkCiJ2
	HufeCrgBWSCHMToIRIQ37ReXIp7lpICMVVy7ZEYrTS+D4LsBDCQjhiv7jfXQxvfq346cl4JAit+WN
	n8OPb5GUx+wTpsdo30Zi82UdILDJnZ+a0TvxhBRx/5EqUisrL5fXRVfHquK6V6VylDVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rpSe7-00BOLU-GL; Wed, 27 Mar 2024 13:44:47 +0100
Date: Wed, 27 Mar 2024 13:44:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix usable ports on 88e6020
Message-ID: <b5abcd09-8dda-4a9a-b6b2-47c9a50faccf@lunn.ch>
References: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326123655.40666-1-matthias.schiffer@ew.tq-group.com>

On Tue, Mar 26, 2024 at 01:36:54PM +0100, Matthias Schiffer wrote:
> From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> 
> The switch has 4 ports with 2 internal PHYs, but ports are numbered up
> to 6, with ports 0, 1, 5 and 6 being usable.
> 
> Fixes: 71d94a432a15 ("net: dsa: mv88e6xxx: add support for MV88E6020 switch")
> Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> I was unfortunately too busy to notice the issue when the patch this
> Fixes was resubmitted in my name. It would have been better to change
> my From into a Based-on-patch-by or similar when modifying it - and the
> final version obviously wasn't even tested on an 88E6020...
> 
> Best regards,
> Matthias
> 
> 
>  drivers/net/dsa/mv88e6xxx/chip.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index 9ed1821184ece..c95787cb90867 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -5503,8 +5503,12 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
>  		.family = MV88E6XXX_FAMILY_6250,
>  		.name = "Marvell 88E6020",
>  		.num_databases = 64,
> -		.num_ports = 4,
> +		/* Ports 2-4 are not routed to pins
> +		 * => usable ports 0, 1, 5, 6
> +		 */
> +		.num_ports = 7,
>  		.num_internal_phys = 2,
> +		.invalid_port_mask = BIT(2) | BIT(3) | BIT(4),

This patch does what the commit message suggests. So

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It would however be nice to fully understand how it currently works
for the deployed use case, just to ensure we are not missing
something.

    Andrew

