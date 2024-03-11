Return-Path: <linux-kernel+bounces-99449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427B878885
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D19B21B33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167455E43;
	Mon, 11 Mar 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dgiHBU0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585640847;
	Mon, 11 Mar 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184294; cv=none; b=FpulqPHFyMzaAE6zzmpPRJUiccGce6jlei7IlrFNJ5lkCCAQk5I8iPw2BwhPwfBW37w5UcpvHwSzO+hU+q5l03AY0PjTpUSGI1DPEPfg7ovusURr01JOzKgdQuHbNtQgJfKUhl1X8g5pQ29X5PZDduMUcVNvWB4cT55q2ldhRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184294; c=relaxed/simple;
	bh=PUTxgOD0c6Psk4GX8+bMAve3zPoeWoP2pyJrAksPe14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqoNmmhQnN8H9yDmXFxr3HwjfxqaXVFTgBQQKxgqo+mUy+w6Ptl4Ep5OZ4PdAnBJ5pc8XEXKpUi7djEdWsQLJiYzdH5/ap1iGVY2xL/Xi93viWYUp0wWPATsW8w8TQZam07zmZH0HarE3hyAa3k6JMcsvJR+f1zuiTlWjHGy6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dgiHBU0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3636BC43394;
	Mon, 11 Mar 2024 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710184294;
	bh=PUTxgOD0c6Psk4GX8+bMAve3zPoeWoP2pyJrAksPe14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgiHBU0VWdrXQGIB3NNNirpld5UNZ00GXraSDkMT07VGJoI03hDJPLAvG+NKTFrRP
	 WREXYGtzi74TSsH/7ZF1lQF95JpD/r/QmN2N07NKVBWpM4ldlnBm9J0Lk9NLD32sMm
	 upWrXGk8CDGdt9WZnqo5x1llPMqfG9Wq3Q5zbgd0=
Date: Mon, 11 Mar 2024 15:11:33 -0400
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
Message-ID: <20240311-flying-impossible-earthworm-51b889@lemur>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
 <388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
 <20240310113738.GA1623@kernel.org>
 <09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
 <20240311091111.53191e08@kernel.org>
 <20240311-chowchow-of-premium-piety-9e4a0d@lemur>
 <20240311115228.5ad9db52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311115228.5ad9db52@kernel.org>

On Mon, Mar 11, 2024 at 11:52:28AM -0700, Jakub Kicinski wrote:
> > > Eh, hum. He does according to the X-Mailer header. More importantly
> > > I thought the RFC to PATCH transition resetting version numbering
> > > is how we always operated. Maybe b4 should be fixed?  
> > 
> > There is no way to make it work reliably the way you propose,
> 
> Could you describe what the problem is?
> Cover letter + date seems like fairly strong signal to me.

The problem is tracking the series all the way from its inception to its final
inclusion into the tree. Links to previous versions of the series are
sometimes included in the cover letter, but they are free-form and we can't
reliably parse them.

Specifically, we need to be able to *reliably* retrieve any previous/new
versions of the same series:

- to allow running range-diff between vN-1 and vN
- to allow checking if there is a newer version of the series available
- to allow specifying series dependencies (this series depends on series X
  version Y or newer)

If dropping the RFC prefix resets the version count, then the above breaks
unless we also use a different change-id, and if we do that, then we lose
change history.

> > so I strongly suggest that we do it the way b4 currently works:
> > 
> > - a series can start with RFC in the prefixes to indicate that it's not
> >   something to be considered for inclusion
> > - when the author feels that the series is ready for maintainers'
> >   consideration, they simply drop the RFC and keep the same change-id and
> >   versioning info; e.g. [PATCH RFC v3] -> [PATCH v4]
> 
> It's not a pain point for networking.
> 
> While I have you - it'd be great if the patchwork bot did not
> repeatedly set patches to Superseded. Sometimes we want to keep and
> apply non-latest version, because the latest version was posted based
> on non-expert review, or we changed our mind.

That's a request to helpdesk. :)

> > Resetting the versioning requires resetting the change-id of the series, or a
> > lot of automation breaks.
> 
> What is "change-id of the series"?

It's the line that says "change-id: " at the bottom of the cover letter and
doesn't change between v1..vN of the series. This is how we know it's the same
series and are able to retrieve the entire series history without guesswork.

-K

