Return-Path: <linux-kernel+bounces-147848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6758A7A79
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3138D1F224D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7438BF3;
	Wed, 17 Apr 2024 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rseRoqw4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9B63A9;
	Wed, 17 Apr 2024 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320440; cv=none; b=P61pUn1/LIzuGf8qjYn2Bg86ieBoslWUxek+O6WnATjrOYwJnFj0z8iT0pTVkb84thQ7phii4JqY0KFwPIhKxnsWk8vLC9j0Q1TFkhLzDsPs+ZdpnZuTqBkhNxpMVF+5Tl4BiMFjPMPZgaQCw4ThcgCOI9UrLvnMs+kgZ/JPLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320440; c=relaxed/simple;
	bh=0Hg5c0S/t8RZQIbbjbz1G+f//lzhTJ+pyxHazCXMv1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5RH6uDXSyRlbGkVThVLdPAsPTL0pnNjQPFo5a+PWxcg3CYNZ/4zCOYQVkCY2+OPlGpc4NYvH2PjcDsGJAIHn8kbhVG0xUuCGux2cm2TFHYSv5a3ovQ4Apm1lrtKYzsQCrbZ0kBnc3P3Kkp+J/HtHbvHwyG8Yh4tzoTwzd5QXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rseRoqw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7FC2BD11;
	Wed, 17 Apr 2024 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320439;
	bh=0Hg5c0S/t8RZQIbbjbz1G+f//lzhTJ+pyxHazCXMv1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rseRoqw4lFdF0hhyXzvd7xrgXS6prHI7OMzmlnz4IwxZqXfNOFWg364bzbK7t0RBK
	 d0+eM2DXbEfmfryDUxqeoahYGPISMjRWv/eO3YzFxeA1JqZkRCmpleQi52sjVLBaWc
	 7NB545njetPwrYcrBE1fsrpUtAU97jCZP9Zgz45soGkGnCwk0UN9cWux2U2ZMMJ0gs
	 XxfKrn1krvGLkNhewiBMuZcMFnR99eg0QboUQj+GZ2vLqOahxpZ5EwvswEOBv/BsBd
	 kOydH/0qv4J+KqJGPlf4CF0rGFl3d19ar4HYXBhSZiPmXNSzSnZZI7SY8RmeITOAQu
	 7wtW6Sm2gKx+A==
Date: Tue, 16 Apr 2024 19:20:37 -0700
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
Subject: Re: [PATCH net-next v8 04/17] ethtool: Expand Ethernet Power
 Equipment with c33 (PoE) alongside PoDL
Message-ID: <20240416192037.50aa0136@kernel.org>
In-Reply-To: <20240414-feature_poe-v8-4-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-4-e4bf1e860da5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Apr 2024 16:21:53 +0200 Kory Maincent wrote:
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED: "The enumeration \u201cdisabled\u201d
> + *	indicates that the PSE State diagram is in the state DISABLED."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING: "The enumeration \u201csearching\u201d
> + *	indicates the PSE State diagram is in a state other than those
> + *	listed."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING: "The enumeration
> + *	\u201cdeliveringPower\u201d indicates that the PSE State diagram is in the
> + *	state POWER_ON."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_TEST: "The enumeration \u201ctest\u201d indicates that
> + *	the PSE State diagram is in the state TEST_MODE."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_FAULT: "The enumeration \u201cfault\u201d indicates that
> + *	the PSE State diagram is in the state TEST_ERROR."
> + * @ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT: "The enumeration \u201cotherFault\u201d

funny characters here: \u201c and \u201d

