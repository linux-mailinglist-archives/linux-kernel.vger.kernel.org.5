Return-Path: <linux-kernel+bounces-106492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71987EF6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F15B212F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8DD55E5D;
	Mon, 18 Mar 2024 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wd5cAvKj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A35579C;
	Mon, 18 Mar 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784919; cv=none; b=ujVyYaQ9AUfty8NITqwFZmyplOOH4bkKiGbDVfWZebs6SG702JktYvN5OwhkUjYNqhKyVuyIukIH53qaoNk/veFGZTAfxfrIpNFoP6KhY9GBrfEHV7h+7zmS/16YFuDiWRqovjeNkhX+H0KSo9svS3OpIf+5ZMCr/D9UXOzTsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784919; c=relaxed/simple;
	bh=AsJtNv/pnLcwK3yuhNmyxuo7mviUdItkUTqHK8N+CpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IebbgLZEG8kwlPimusIdCtpyNP/tChx7tQMYpyEA3R/HhFb/+wwbTCYOT8MIOnUGeCAOqQR2kKJCvHtWYdpYu3B7tr/qt0Li/F7t/AGu2i1+pGHMWr22zL6b4Rt3P0gj0FZE9gMnov4OJJTOWq0snIvxUFjJHOpr95yFpRwz9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wd5cAvKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2300C433C7;
	Mon, 18 Mar 2024 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710784919;
	bh=AsJtNv/pnLcwK3yuhNmyxuo7mviUdItkUTqHK8N+CpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wd5cAvKjs7+lgaCUrGw2bcXhS7NFH+TKpo4w2yEqrMXiJCg2xRhMXdZHeZBiuUaoP
	 ZKgj3eAgJWlHNSHBp/Jv0CUkUQL8QpA2oBMzeJ8B7hvq/eUqV5iHrvzt8mZy2a9MDh
	 RDvQTm01LvqUPb7PSe/Se5zM1KYYN5M1piVKDeLY=
Date: Mon, 18 Mar 2024 14:01:58 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?B?UmVuw6k=?= van Dorst <opensource@vdorst.com>, 
	Russell King <linux@armlinux.org.uk>, SkyLake Huang <SkyLake.Huang@mediatek.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <20240318-quizzical-raven-of-plenty-ef21f5@lemur>
References: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
 <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
 <ea889226-3649-4f74-8c38-67c459e4ea4d@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea889226-3649-4f74-8c38-67c459e4ea4d@arinc9.com>

On Mon, Mar 18, 2024 at 05:03:29PM +0300, Arınç ÜNAL wrote:
> > We've received your patch series 4 times and this was the same thing with your previous b4 submission, can you find out what happened? Thanks.
> 
> It looks like my branch name was too long again. b4 0.13.0 cannot handle
> branch names that are too long. I'll keep it shorter for future
> submissions. It'd be great if Konstantin could provide a specific limit.

It's not really b4, it's the web endpoint and the version of python it's
running. I hope to fix it soon by applying the same workarounds as we ended up
doing for b4 itself.

-K

