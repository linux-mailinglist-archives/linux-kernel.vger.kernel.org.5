Return-Path: <linux-kernel+bounces-99440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB0878861
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103FFB236CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526E359B59;
	Mon, 11 Mar 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntJveKEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562556751;
	Mon, 11 Mar 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183150; cv=none; b=QX6AbxZIVBZ27vu9A8iXttmBcTcJRiWjOi5tI/B5yQvQWRzNrqvyC3ohaleaZ37kOktqxjcJI+9kF57lstbmigc7HbgLxHSGiIuINwxIpPfL2ptmIVqsEL90dknhAf4E24oG/KMZ7ZWim5OBwjgXGcwOv4dverrlvcjnLokHHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183150; c=relaxed/simple;
	bh=8yNZVZwg88lIDwJTE7gfFU15qUPpE2qDq9xtN5uq0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNJ0nQZ1jb3+1pHehq1WZ/43hQpzgE17pjkki8s0oyYqWONxxL77gn1vA5Y+JSi+KK/NDvaBsuG4d2fVRGmsaRafPvVz4huWEEIDjJXwwbek0Bttu8HcFCFhFpXiEPtRAVc8Fk9LE+CMVqGZwl7gPooTnIKcUqOc9Ujn3pPdYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntJveKEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96607C433F1;
	Mon, 11 Mar 2024 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710183150;
	bh=8yNZVZwg88lIDwJTE7gfFU15qUPpE2qDq9xtN5uq0HE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntJveKEoblrZJlInb3jlKdZ58Pa87F1a9pgyCst25tblq2sAxeYLDUbnv6bBbrizx
	 amagySKMWlmrkgJOUmUeLB85J15EhIVkVVZoNhRUGKR2oTuQ4ZgYl3Vdb5Uts+uNUS
	 d6hrW2bV5K2kSJtYUrUBPihL2DSuyDun+/RH0QrEiNxKAlbrGQb8EM577ivqjQh7Xa
	 wVt8qfHVsjHdDyF9Zo+bzrODh7xBpxWXbTvoIxcrMzUtAGAinHyIKzKywdPgYTtUXQ
	 /oIt58Q+0l4vLM+8+J+u+UV8Usfw99w81JVSI2R2nwoytOUS8nna+m8VM4MAt3SRQ7
	 RWv2gK7d/NXHA==
Date: Mon, 11 Mar 2024 11:52:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Horman <horms@kernel.org>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, Alvin =?UTF-8?B?xaBpcHJhZ2E=?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state
 in rtl8366rb
Message-ID: <20240311115228.5ad9db52@kernel.org>
In-Reply-To: <20240311-chowchow-of-premium-piety-9e4a0d@lemur>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
	<20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
	<388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
	<20240310113738.GA1623@kernel.org>
	<09793a72-bfe5-4cb5-a6da-ffee565e6956@kernel.org>
	<20240311091111.53191e08@kernel.org>
	<20240311-chowchow-of-premium-piety-9e4a0d@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 14:40:44 -0400 Konstantin Ryabitsev wrote:
> On Mon, Mar 11, 2024 at 09:11:11AM -0700, Jakub Kicinski wrote:
> > > OK, then this is v2. RFC is state of patch, not some sort of version. Or
> > > just use b4 which handles this automatically...  
> > 
> > Eh, hum. He does according to the X-Mailer header. More importantly
> > I thought the RFC to PATCH transition resetting version numbering
> > is how we always operated. Maybe b4 should be fixed?  
> 
> There is no way to make it work reliably the way you propose,

Could you describe what the problem is?
Cover letter + date seems like fairly strong signal to me.

> so I strongly suggest that we do it the way b4 currently works:
> 
> - a series can start with RFC in the prefixes to indicate that it's not
>   something to be considered for inclusion
> - when the author feels that the series is ready for maintainers'
>   consideration, they simply drop the RFC and keep the same change-id and
>   versioning info; e.g. [PATCH RFC v3] -> [PATCH v4]

It's not a pain point for networking.

While I have you - it'd be great if the patchwork bot did not
repeatedly set patches to Superseded. Sometimes we want to keep and
apply non-latest version, because the latest version was posted based
on non-expert review, or we changed our mind.

> Resetting the versioning requires resetting the change-id of the series, or a
> lot of automation breaks.

What is "change-id of the series"?

