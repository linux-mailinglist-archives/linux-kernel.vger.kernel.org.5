Return-Path: <linux-kernel+bounces-99431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0692878831
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4092A1F231FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEA5BAFC;
	Mon, 11 Mar 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1oFG8Kx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759F5BAD7;
	Mon, 11 Mar 2024 18:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182445; cv=none; b=BNzA943TAS0hwNGSmnKaAY3K3QQM1+ClNSxcbiIliTt2Am1CV5AMIDcSqWtEwzb402kPieyKWrVT9TekXE5Mgjst3b5q4jLZtlEvIyeo7+fmrYD5UpxfvFThBHql2tnSeGqN7Qm46RONRkIW1KlfG+0pXUxkBCbz25CbeCrCjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182445; c=relaxed/simple;
	bh=7QgKIaP0/c6SHvgH07U88g9EjC4h7z7/QxEQtSagdEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLVhLRTmZkOr2oo6oxxAr0KRZ7b3M0jgEhyz6AC8U3EpDE78dhssLkdtV3XooF6iHcXDKfrLOmr3iDA9N1hqJSdM0W7kRTDPhihZeeA8wpjbAb7UKfdLAjzeMbsaFEeQmYjP7HgFoSp0lHAvp0u3jTaQIuw6zp5ItbtI0OXBcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1oFG8Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DE4C433F1;
	Mon, 11 Mar 2024 18:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710182445;
	bh=7QgKIaP0/c6SHvgH07U88g9EjC4h7z7/QxEQtSagdEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1oFG8KxDff2oPYjT41rHf5VSCQZrmhiUs46Nx6XyMTn7TmO70UNEZ8rwtwadwh0s
	 v8ubwKGotwqP1BbwAI5ShIZR1cJwuCsypNYN+Icwsf+rrkmFmZfZlGp9+2b9fL+7iJ
	 DqTk+ROJ46nw4HjEdfaeMVY/PbHVNeored29YxZU=
Date: Mon, 11 Mar 2024 14:40:44 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Horman <horms@kernel.org>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state
 in rtl8366rb
Message-ID: <20240311-chowchow-of-premium-piety-9e4a0d@lemur>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
 <388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
 <20240310113738.GA1623@kernel.org>
 <09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
 <20240311091111.53191e08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311091111.53191e08@kernel.org>

On Mon, Mar 11, 2024 at 09:11:11AM -0700, Jakub Kicinski wrote:
> > OK, then this is v2. RFC is state of patch, not some sort of version. Or
> > just use b4 which handles this automatically...
> 
> Eh, hum. He does according to the X-Mailer header. More importantly
> I thought the RFC to PATCH transition resetting version numbering
> is how we always operated. Maybe b4 should be fixed?

There is no way to make it work reliably the way you propose, so I strongly
suggest that we do it the way b4 currently works:

- a series can start with RFC in the prefixes to indicate that it's not
  something to be considered for inclusion
- when the author feels that the series is ready for maintainers'
  consideration, they simply drop the RFC and keep the same change-id and
  versioning info; e.g. [PATCH RFC v3] -> [PATCH v4]

Resetting the versioning requires resetting the change-id of the series, or a
lot of automation breaks.

-K

