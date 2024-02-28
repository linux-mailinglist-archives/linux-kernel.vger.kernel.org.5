Return-Path: <linux-kernel+bounces-84291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7B86A49D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFA91C2421F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA31852;
	Wed, 28 Feb 2024 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFoUvcEc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EF5234;
	Wed, 28 Feb 2024 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081821; cv=none; b=Fbvk4wt7HeazdlO54Iu9F9iHvM5j0llppk7l74kdZ1KDhwtPA9+KKVH7V1E4G5+PsdJjsuYxJWK0m38i07/PhD8GXSjSuXjQ6z6OSEDFe/XMzWrK796wWB4snNl2v15NfSw5XbDWbWH7uKSM/fBiubOhSIJr5t4WCx/BJpoGOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081821; c=relaxed/simple;
	bh=vXGBstZys8+dQN0682kXjLXWYlSTcwStbsHQDVnLeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3HmGcCdTRDoKiboRlmux8B5V0FF6os5ZNo73ngjzsQtkYyfoDj9e0G5Bs8xxjJfz2quF9BeBYDO8fTdsfG/kBeDaHOrhVH3nU2pqumIykbbrR45a8m5tIZAT7yeVw4DCvYsC7fI6mTtjssOoicSNk/R0uAIjiym31a98V39lpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFoUvcEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E95BC433C7;
	Wed, 28 Feb 2024 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709081821;
	bh=vXGBstZys8+dQN0682kXjLXWYlSTcwStbsHQDVnLeqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFoUvcEcDyjUSkBPl6KI/gV6IOsYctdxyEf0buR6PAe3u4USI73uUYS9pRyTCnrU4
	 LE53l59ASDrMCJZrUXu0dAOFgig4Pdn2iZmxkn2r/9Qi6LMAzENLCt0/cDZRHlLV4+
	 Zxm9NPSmg7ZQFXsLt29I5H0SG6T+0lmYKBRKdaa7cYB2Tx8x+5ehr3MpWgIHePYIPU
	 tGL/0h0yF3ODPWa5owrYMOm/TT9/rFnuWDrKaHMuQIACar03/LCSJ1+WwC6Ct14OQz
	 uAIYgaxOxvsfgLxSavuxRt5P2eEminhOoBrkQAoWQHO8FVG+FU9vHM0Y6jz6TldFOH
	 2UaV3086LTG2Q==
Date: Tue, 27 Feb 2024 16:56:59 -0800
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
 <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240227165659.76a971aa@kernel.org>
In-Reply-To: <20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 15:42:55 +0100 Kory Maincent wrote:
> +	psec->ps = devm_regulator_get_exclusive(dev,
> +						rdev_get_name(pcdev->pi[index].rdev));
> +	if (IS_ERR(psec->ps)) {
> +		kfree(psec);
> +		return ERR_CAST(psec->ps);

coccinelle says: ERROR: reference preceded by free on line 458
-- 
pw-bot: cr

