Return-Path: <linux-kernel+bounces-106534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C087F004
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B4B22CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536445675D;
	Mon, 18 Mar 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoRAe/t5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FD381C8;
	Mon, 18 Mar 2024 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788138; cv=none; b=PGgVF+nCqpeQaX1kyg+suAn5tALq8sehGslZCGWHsyR8TbVpLQy2Ky5QS8kUb4ZREBmWet+Cydwbsszg1HdxDk3pIgnYdLPYh2p9+BWATD8pLBIjJz+oFTXf86DjfsyWNLmZdywYDbqZMyRArjWqzZd01JgionvAw7hysc9BuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788138; c=relaxed/simple;
	bh=I81m1u3/gCGGvR+mJK7Lbsg9hTItXoG0ObMM/YWSWRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMXiXp8c9VNNHWFGddQcTb6aR6VDMcIdEY2piJG4dMFD9EQMqioSyK3Gt3ztEI+/oJwPJWANj7R/bP/qClyx2tcf47pQg3QGaeMAeQRC5xosb1PG2ErCNUAafflk4to+x79m5hu/R6uEX3YDvqm1eEAt+QqxDSDxW3VzlaTTcp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoRAe/t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88CEC43390;
	Mon, 18 Mar 2024 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710788137;
	bh=I81m1u3/gCGGvR+mJK7Lbsg9hTItXoG0ObMM/YWSWRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GoRAe/t5gnCYRr4W2+XxQic8Y6xH09gwfXPD5Ta4nNmIMvaDKSWQOqbHa8/Tq6bQu
	 694lYsH9NoB9QPxSl8bNuUi0DUIr67W8GxGvn/zZ4J0vVgPM4mIptyEjWcqUQp0iG/
	 DzzRMwvPwXEn11MZ7EmGkDE33RmJ8ajp03tiCvto=
Date: Mon, 18 Mar 2024 19:55:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alex Elder <elder@ieee.org>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Ayush Singh <ayushdevel1325@gmail.com>,
	Vaishnav M A <vaishnav@beagleboard.org>, devicetree@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, lorforlinux@beagleboard.org,
	greybus-dev@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Elder <elder@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Johan Hovold <johan@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh@kernel.org>,
	Robert Nelson <robertcnelson@beagleboard.org>,
	Tero Kristo <kristo@kernel.org>, Vaishnav M A <vaishnav.a@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Message-ID: <2024031818-lizard-actress-2279@gregkh>
References: <20240317193714.403132-5-ayushdevel1325@gmail.com>
 <4fe6f68a-786c-4e3d-b97d-847d6965d1d3@web.de>
 <3eb9d5c2-149c-460c-9684-3fdaf946c400@ieee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eb9d5c2-149c-460c-9684-3fdaf946c400@ieee.org>

On Mon, Mar 18, 2024 at 01:41:38PM -0500, Alex Elder wrote:
> On 3/18/24 12:58 PM, Markus Elfring wrote:
> > …
> > > +++ b/drivers/misc/mikrobus/mikrobus_core.c
> > …
> > > +static int mikrobus_pinctrl_setup(struct mikrobus_port *port,
> > > +				  struct addon_board_info *board)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!board || board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
> > > +		ret = mikrobus_pinctrl_select(port, "pwm_default");
> > > +	else
> > > +		ret = mikrobus_pinctrl_select(port, "pwm_gpio");
> > …
> > 
> > How do you think about to avoid the specification of a bit of duplicate source code here
> > by using conditional operator expressions?
> > 
> > 	ret = mikrobus_pinctrl_select(port,
> > 				      ((!board ||
> > 					board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
> > 				      ? "pwm_default"
> > 				      : "pwm_gpio"));
> 
> No.
> 
> It's a complex enough bit of logic without trying to bury
> it inside the parameters passed to the function.

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

