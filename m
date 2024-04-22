Return-Path: <linux-kernel+bounces-153437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD218ACE18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E29AB23AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B414F9C6;
	Mon, 22 Apr 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iw8KWIwF"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BE3399F;
	Mon, 22 Apr 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792309; cv=none; b=aP95UZbV9VBcbm877DKjJbvCaXW9AgMoE0nrgvCqwzXp5WZF6d9M4AEtW4sGo74l8AOfYr676CG2+N/lPCMx0NAJe0DVFGy4y9fObbXngDAox1ZmDuRzf91cHtjnYmhjNn4dibTW9gQq+XxL0x+vB+hl+7Ooy7H8oFT2nPcel38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792309; c=relaxed/simple;
	bh=VWGI9GXE4lgncvIzKvofxzKz5i2T0i+YqDK2/rYg0sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6WlZg8OPsXj7+r3Kajs8ZrT4VAFECruW1HxJeTWY6pcILhKtq3YZQ4OyIX++wy0Bc7xwDpR+X9N69kWK7bhXrPqIbzwotTh3qy9tKQlEqzlLVNgzqpV7XrW2gSLmSU4j+162HIfbjFf51+p0zUR91JqsaiuDjJNmbxh/0a7M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iw8KWIwF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1KzoEvybAcB20CSkmMpu9Ekd3/KUeHN6agkm2+FPdKc=; b=iw8KWIwF0YVHdoF9CDF/grPXt0
	pZJTtK5TGtgyriFwitf+ue9HsP/WEHM1EYX5CogAV0gXvj4PEiTmyqUKlLN6IdynOmphKmrG0lE5w
	KF0tBI+Z6LUndPh86SMAKx5O9MlNhi6g8Mk1pH/tw29RDMfOojRKJ1xly1yQCSVKrj+o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytfI-00DcTf-Ag; Mon, 22 Apr 2024 15:25:00 +0200
Date: Mon, 22 Apr 2024 15:25:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fabio Estevam <festevam@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: Add support for
 model-specific pre- and post-reset handlers
Message-ID: <719d12fd-d720-40af-870a-6571be4fe06d@lunn.ch>
References: <2b924dcdf8adfe2c0b6b5998e47e836dd8f9e1b1.1713442039.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b924dcdf8adfe2c0b6b5998e47e836dd8f9e1b1.1713442039.git.matthias.schiffer@ew.tq-group.com>

On Thu, Apr 18, 2024 at 02:16:07PM +0200, Matthias Schiffer wrote:
> Instead of calling mv88e6xxx_g2_eeprom_wait() directly from
> mv88e6xxx_hardware_reset(), add configurable pre- and post-reset hard
> reset handlers. Initially, the handlers are set to
> mv88e6xxx_g2_eeprom_wait() for all families that have get/set_eeprom()
> to match the existing behavior. No functional change intended (except
> for additional error messages on failure).
> 
> Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> One other thing I noticed about the patch referenced in the Fixes tag:
> It completely removed the wait for switches without a get_eeprom() op.
> Are there any switches that do load their configuration from an EEPROM,
> but don't provide read/write access, and thus don't have
> get/set_eeprom() ops, but that still need their config load to be
> completed before/after reset?

I _think_ we implement read/write support for all devices which have
the needed registers. Given the large number of ops structures, it is
possible we are missing entries, but nobody has reported any issues.

> I've left that behavior unchanged in this series, as I currently don't
> have access to other switch manuals and no way to test their behavior.
> 
> 
>  drivers/net/dsa/mv88e6xxx/chip.c | 53 ++++++++++++++++++++++++++------
>  drivers/net/dsa/mv88e6xxx/chip.h | 13 ++++++++
>  2 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
> index c95787cb90867..8650d8646120a 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3075,25 +3075,26 @@ static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
>  static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
>  {
>  	struct gpio_desc *gpiod = chip->reset;
> +	int err;
>  
>  	/* If there is a GPIO connected to the reset pin, toggle it */
>  	if (gpiod) {
> -		/* If the switch has just been reset and not yet completed
> -		 * loading EEPROM, the reset may interrupt the I2C transaction
> -		 * mid-byte, causing the first EEPROM read after the reset
> -		 * from the wrong location resulting in the switch booting
> -		 * to wrong mode and inoperable.
> -		 */

I prefer having the comment here, where it is visible.

>  	int (*ppu_enable)(struct mv88e6xxx_chip *chip);
>  	int (*ppu_disable)(struct mv88e6xxx_chip *chip);
>  
> +	/* Additional handlers to run before and after hard reset, to make sure
> +	 * that the switch and EEPROM are in a good state.

I would keep this sentence here.

    Andrew

---
pw-bot: cr

