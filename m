Return-Path: <linux-kernel+bounces-147851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E48A7A80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D1F1C20C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562F6FC5;
	Wed, 17 Apr 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5vzLal0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D544685;
	Wed, 17 Apr 2024 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320585; cv=none; b=WHLk5h+jwT0oH8eIo5bTuFioohG7bRGIocc5XKLKD98HUas6ZfAbnW2z9SjmOGfIAczY1ldIXTj+b2xqMDdHbaUgZs7MPLi8/J5/Wa9xwFxNdfVyv01Q0WGw6S+unuiZ8LCRfLoaMSUkVwcUowR+aFDUJRQgh2Xzv8qaLoltbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320585; c=relaxed/simple;
	bh=46aRmITiOUVBynMBETaAGe/3vLl0jA+4t6Miv67/OSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJWZKKEYoiScu/PTqjs9x4LsGXmowoM9vhbBMxPdq0rasjo4hsWxJliyfRuT8jWcFrxxIKuiPiykiYoTRCMhWskYLBwJ63BRIj/Y/gCpmQLgwFydsbM87Td5adVqMhnM3BB9apIXC3XNhL6EZyrFhAe12ZFWGeMpE1mMxe9Wrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5vzLal0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0098C113CE;
	Wed, 17 Apr 2024 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320585;
	bh=46aRmITiOUVBynMBETaAGe/3vLl0jA+4t6Miv67/OSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5vzLal0dkLpUT57JnJ1eUDaPSfH7ufjYabxE47W5BNOqCYEC9JIxVZdl0aDEUXS4
	 C9hvvN6Uk2H1I/Yf5zaAfmUaM/1kjWlRpnOcsH4l6/pZfpW/TyJf/s7acQgwxOe/3x
	 FxLq9flUjWO4S/UMdeuZ3g6JwtjDH/M7HBvYR5EImzIr0MmG7AlOkpZaXncOkzblX+
	 VUxCVLyYK17U7uIryJ5YpctQwBs4IR8oXmZL+yrqKPEGlXAI1WTT6oQkfX7zlx1UOs
	 l6aJG6Te0XojLRV+2BaxP5ygkPxQ2cQbrktJED2ptOZfq4lm/OrfMYfAVpRHMheaej
	 efQrPfWN/1pEA==
Date: Tue, 16 Apr 2024 19:23:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 06/17] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <20240416192302.72b37f09@kernel.org>
In-Reply-To: <20240414-feature_poe-v8-6-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-6-e4bf1e860da5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 16:21:55 +0200 Kory Maincent wrote:
> +	    !(pse_has_podl(phydev->psec))) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
> +				    "setting PoDL PSE admin control not supported");
> +		return -EOPNOTSUPP;
> +	}
> +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
> +	    !(pse_has_c33(phydev->psec))) {

nit: unnecessary parenthesis around the function call

