Return-Path: <linux-kernel+bounces-53880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7882684A795
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067311F28C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D9127B40;
	Mon,  5 Feb 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgDhUO0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D987482FE;
	Mon,  5 Feb 2024 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163197; cv=none; b=hPT9CRb+GUyi3I0a4VEOLoyWYE4eGeqFs/H+p1uE99UEjLNtxtIwotruwe2P92VzfjJM6NXEpw55brSdHDrf+8eHLRGMtez31QRbhuAzFYXxUlmkgoC+aD6PnQ45NQfn0D8yPCnOhAH1956pzL7Az+gl0gHrqdvaRsREQ6MP0co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163197; c=relaxed/simple;
	bh=rAvvqDnfZeAp295dKfcQtZOZPde72TlT5r3yx2DZBF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXssXza0lyt4sUi6m5d6mBrTy9BRdWCDmicO5JznnQDEYTDfcgj4MI20xtvojW6E4x1+hX9OAfG9N4KfSna85CffkLL3F5uKIY9g6Q9+qDOwfwgJKV3q3j4lgI/BR427XvLSc0GBc4A5Hux37BshOSOnOdI9l4Sd6atrCqhwvlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgDhUO0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B74C433F1;
	Mon,  5 Feb 2024 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163197;
	bh=rAvvqDnfZeAp295dKfcQtZOZPde72TlT5r3yx2DZBF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EgDhUO0C4lOhCJkeOA7I6SmBbl4eCzlG1gviuIUcejV/W1MYgpgf2RBb572z0+hzj
	 TWq69eDLPurUWHZTlkfBHRu3wWaKr13LlUr9rgd/j4CiTEgfP5wYltEclz8IFA+qUB
	 nMvEQ2JmAP+2y5o4xWxEgEr06KIutrd+Oy2qM1QIzst4/ni1Et0Jgk31pWyeE0PoWL
	 i4L3ElpOwI8fjurwbRFXKVGMWS04LZ38simXTnPhV1S/SUaB8Y6ICOlPxZRfI3zTyF
	 0VsZHsN/91OJQuHgwoetepAfujLll9X4yVVOQ0oaZit158gmB/qJuiaNPh12iy/GF+
	 MuxRaOkTVYGqQ==
Date: Mon, 5 Feb 2024 11:59:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
 alexander.duyck@gmail.com, Wei Wang <weiwan@google.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240205115955.5cde5a13@kernel.org>
In-Reply-To: <20240205185130.GB10463@fastly.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
	<CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
	<5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
	<20240202032806.GA8708@fastly.com>
	<f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
	<20240202102239.274ca9bb@kernel.org>
	<20240202193332.GA8932@fastly.com>
	<20240202115828.6fd125bf@kernel.org>
	<20240202202344.GA9283@fastly.com>
	<20240202171539.7347cb01@kernel.org>
	<20240205185130.GB10463@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 10:51:30 -0800 Joe Damato wrote:
> > We reused the gro_flush_timeout as an existing "user doesn't care if
> > packets get delayed by this much in worst case" value. If you set
> > SO_PREFER_BUSY_POLL the next time you busy pool the NAPI will be marked 
> > as "already scheduled" and a timer is set (to gro_flush_timeout).
> > If NIC IRQ fires before gro_flush_timeout it gets ignored, because NAPI
> > is already marked as scheduled.
> > If you busy poll again the timer gets postponed for another
> > gro_flush_timeout nsec.
> > If timer fires we go back to normal NAPI processing.  
> 
> Ah, I see. From my reading of the code in busy_poll_stop (which could be
> wrong), defer_hard_irqs_count must also be non-zero to postpone the timer.
> 
> Is that right?
> 
> If so, I think the tricky thing with this is that these settings are
> system-wide, so they'd affect non-busy poll apps, too.
> 
> I think in the ideal case being able to set these on a per-NAPI basis would
> be very helpful. Maybe something for me to try working on next.

If wonder if it'd be good enough to do:

	min(defer_hard_irqs_count, 1)

there. If caller asked to prefer busy poll they clearly want to poll.
An explicit per-NAPI API works too, but it's a bit more work.
If I was doing the work I'd try min(..., 1) with the workload.
If there's value in having the full config - go for it.

