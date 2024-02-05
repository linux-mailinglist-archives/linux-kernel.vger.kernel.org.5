Return-Path: <linux-kernel+bounces-53913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CAA84A7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219A11F2236A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747D133421;
	Mon,  5 Feb 2024 20:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+cADej9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CB133417;
	Mon,  5 Feb 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164663; cv=none; b=B+FBr1eO0P6zoVsgEyVulE8slIg5uiuiROJHvtQ1gs3eJsBINFudN+SDL4UF8g4oKtcVw5iQyy0J8OSQR7tlsG7tJtWGBOnT89nScPyAUvH/fZdkn/LmY2+Ldbsez3n03TblNA8pEgq+kdoO/JJvMMysie5DEuyv1QRP9hTJqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164663; c=relaxed/simple;
	bh=pjvr/I7dTXNHnTgva7B7XrxHkICB2a+rNEz5glnuyBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l96LK029F6Ro5PCpcLLtpv3yKhEIQRfCuffC3nMkINOmD0ptJ1PGWNsCdR3Sj3JZj74a199ANf0pECfKTYjIsdXNutCLbFhJCH72HoJadjiaBgtTXIURYIr6HqeLaHRCiAEZR/RpSPSugHU4UKs4tIhxeSLHy+dQe6XsPSblQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+cADej9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B1CC433F1;
	Mon,  5 Feb 2024 20:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707164662;
	bh=pjvr/I7dTXNHnTgva7B7XrxHkICB2a+rNEz5glnuyBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+cADej9tPj1U7p85slFv3035ULoHWZfHOsJjMLO63vRBly9U8yjv0Mu+Y0EBl3GJ
	 4wiVYwtX3vP41zR9xEa71opi5LhWWML01SCwQtTZQjrMXHeJwFywI8OBAeRh8Ae2Eo
	 khFRJobmKQMaqSbAhU2iJU8+7G9heW7XO94GjaIo=
Date: Mon, 5 Feb 2024 15:24:19 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Frank Wunderlich <frank-w@public-files.de>, Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, tools@kernel.org
Subject: Re: [PATCH net RFC] net: dsa: mt7530: fix link-local frames that
 ingress vlan filtering ports
Message-ID: <20240205-silky-sensible-puffin-8e23ee@lemur>
References: <65bbf40d.170a0220.a87f4.becdSMTPIN_ADDED_BROKEN@mx.google.com>
 <20240201225943.abphuuavp7bkbrt6@skbuf>
 <1f0e67ba-edd7-4998-bc20-1de86bd53a68@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f0e67ba-edd7-4998-bc20-1de86bd53a68@arinc9.com>

On Fri, Feb 02, 2024 at 12:11:37PM +0300, Arınç ÜNAL wrote:
> There're no brackets enclosing the Message-Id. That must be why Gmail
> modified it with the SMTPIN_ADDED_BROKEN disclaimer added for you. I can't
> come up with a theory as to why you've received it thrice though.
> 
> Konstantin, could you take a look at what happened here?

Oh, yay, another python email module bug. *sigh* It's not supposed to break
items enclosed in brackets.

I'll see if I can work around it on the submission side of things, but for now
the silly workaround is not to create branch names that are too long (which
results in message-ids that are very long).

-K

