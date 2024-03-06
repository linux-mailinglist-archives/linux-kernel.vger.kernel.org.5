Return-Path: <linux-kernel+bounces-93279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F62872D65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E481B22A4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1312E7C;
	Wed,  6 Mar 2024 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaoY3I0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74038DDA8;
	Wed,  6 Mar 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694899; cv=none; b=GTdCdQ78im61o1qT5KtcY/A3OKI2vaUEYEj6Niw4IZP2bhkiAA6MACTsa3HBVxRd3UTYc6vVFjjQvzrr5Cc2PYZpvxARQh7MthjWhNTXGpUSfrL1amqAMaW5KHaM7G2Q5PspP6kAHdr3hTaEJddjOE+rBexqvogQohK1zd1u8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694899; c=relaxed/simple;
	bh=ADX2aLUl83Ht7eqwNw1wCGw/JUzgdAjweDaoeaKB7Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6KjvLSCealSrrewMZkbFORl7JfX2oCH/e5QsacHKLJnaV9ayQYrixX/eKHK+CTqb44tM0+m9hgah01MZv8QX0RF/7A1gxbdGOZa33P82wRWqhHbTYQOFKUImOE7ssi7rBBOBbKagzoGyy/pUp54d4BWid0y+7nYX6myVvPYaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaoY3I0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8626AC433C7;
	Wed,  6 Mar 2024 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694899;
	bh=ADX2aLUl83Ht7eqwNw1wCGw/JUzgdAjweDaoeaKB7Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HaoY3I0S1NwcF2DBr3I9Cxc1FOlamxDp+JDDN8xxcm2o/mDu3zGWJinEZpq/kYoSu
	 x5uXks4LYHCZBbNvMnvTBXpvdPAW5dLYSdQBEhsJ5Fsv7HB3yLOI0zrVS7JqqqKRjM
	 ZXsoAEEPumhDKeMBs9i4vF0Cc3+yBcKYbaDea5kFLAAvK6D35rpzzQruUce1cKe47c
	 DgMeNdh7CA/70d2o2ic7Ql5d9Q5rnfv20qyuGXY4RC3iGuKBwBj19FzwBh7pVl3Jpn
	 ZcL+kl63zKt+3PinT/A9PCulnEqB9xXjnrLopTxUVT7xB0OeJxCAtN4twaoGGHuCwY
	 4cyeFCzYLo/+A==
Date: Tue, 5 Mar 2024 19:14:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, Arun Ramadoss <arun.ramadoss@microchip.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: make sure drive
 strength configuration is not lost by soft reset
Message-ID: <20240305191457.37419bd4@kernel.org>
In-Reply-To: <20240305064802.2478971-1-o.rempel@pengutronix.de>
References: <20240305064802.2478971-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Mar 2024 07:48:02 +0100 Oleksij Rempel wrote:
> This driver has two separate reset sequence in different places:
> - gpio/HW reset on start of ksz_switch_register()
> - SW reset on start of ksz_setup()
> 
> The second one will overwrite drive strength configuration made in the
> ksz_switch_register().
> 
> To fix it, move ksz_parse_drive_strength() from ksz_switch_register() to
> ksz_setup().
> 
> Fixes: d67d7247f641 ("net: dsa: microchip: Add drive strength configuration")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Hm, this is much larger than I anticipated, and also doesn't apply,
so there will be conflict with -next. Andrew, should we go back to
the v1?

