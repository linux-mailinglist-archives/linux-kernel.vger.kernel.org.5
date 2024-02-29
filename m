Return-Path: <linux-kernel+bounces-86115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE20686BFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB4C1F2557D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A263771E;
	Thu, 29 Feb 2024 04:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkCTU11G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAB38385;
	Thu, 29 Feb 2024 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179820; cv=none; b=SVZrOW6xBIIgYQNQZqzF77rvh8yjVJdNRIrxyPMycvuBZ3JyLMSQv8hJH0MhbEvs649oSbYxpic6kbJVzubvlXOYe1NMBRA770RyFtzkqMNtczBE5FWpojf6SPlbFwsUM5QxDeSn34/48AnGYcjA24Zh9Mm2ZkeC0r7LjTM83Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179820; c=relaxed/simple;
	bh=eQGuHFwtGTQX/vIrD/iiv1/d/CfAuqoBasEuijoLEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHzPh6aaaoXcDALUvORsr3KLtRtYDm7bftqR6tLDN86lzI6Skb6raR+q72/Vwh/JH7Ab3qqLY35MPo/6jojtMlR8QyeXvaZVMZ/lT7S5C2XJi/yHI3FPxlysNpS89eMnyU+6WMEAT0Bx0FaY+tUjJvE/15HAzBhGT667+2C6rxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkCTU11G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD4FC43390;
	Thu, 29 Feb 2024 04:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709179820;
	bh=eQGuHFwtGTQX/vIrD/iiv1/d/CfAuqoBasEuijoLEMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AkCTU11Gz4tLXz/bdTfSfZ8NFh82lRrxMjRlADT3ZvAAAKElhKp9LDdPuPsf+kQVV
	 Y30nvfIL7hKmzmIKGk2TcU7CgZ3t0CRarEKrwDBTe9MhdQrTiEYPQpKIRo7gZxH7IS
	 YnUKYMe9ZlLa8xLAZRsBLwB3D9W3RUIoneaScZo/dRd6ZpKwTTgW4rtIHkESzuU5Vf
	 NSXbhsbX2WZwLcd4u4MTG14uQow7/qGEovif5kopN5/tOd4mUBi6NIj/RrcLGONcZb
	 GVExNTaKxIcgp004Js+OBiCdL3bSo876UBVFisEcM/x+clSIj5jqk7XdiobtNc54cs
	 WbaqY9fHNIwZQ==
Date: Wed, 28 Feb 2024 20:10:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v9 08/13] netlink: specs: add ethnl PHY_GET
 command set
Message-ID: <20240228201018.44b7f97e@kernel.org>
In-Reply-To: <20240228114728.51861-9-maxime.chevallier@bootlin.com>
References: <20240228114728.51861-1-maxime.chevallier@bootlin.com>
	<20240228114728.51861-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 12:47:22 +0100 Maxime Chevallier wrote:
> +        reply:
> +          attributes:
> +            - header
> +            - index
> +            - drvname
> +            - name
> +            - upstream-type
> +            - upstream-phy-index

doesn't exist: s/phy-//

FWIW

  make -j $(nproc) -C tools/net/ynl/

should build reliably, again.

> +            - upstream-sfp-name
> +            - downstream-sfp-name
> +            - id
-- 
pw-bot: cr

