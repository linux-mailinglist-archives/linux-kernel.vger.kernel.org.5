Return-Path: <linux-kernel+bounces-123295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE9F890637
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C91C305F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ECE12F391;
	Thu, 28 Mar 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBgiB3V1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFA3BBEF;
	Thu, 28 Mar 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644274; cv=none; b=p5tiNUyLWiCfZVoE7MzyzEm3PjA62kDL1DoLaXefY/huCU1EO1gRbucK+hCaFpmch4Z+yYqqachvAwZkf4uRArgHmSeeBi89Zg/VYc2enft/oqnYSe9g0mafnhH4MlNmRIZnktMfXDn/kjD6oCzEyQCvMzlbLyu4JYVOoZxJaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644274; c=relaxed/simple;
	bh=VTys3YpvicCW7hzI150+v9+jo5zNzxdDN4MVR7jcuPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj+XEgkVOsJI8f3ji6Ver0vCgUjpFkQ8QiGXUe6qyhs8ftBeOLZaV/IP+KEzvUhZNTAU8bZ0Z2aXKsgH3ukY1U3beokS8Gm0KpGZrwV7w9tEN39riMc0j/ClIYFzO24SBc++30CzvDIq45uHPrsKZYqqkQpKR/W5qP17AKEG2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KBgiB3V1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A1C433F1;
	Thu, 28 Mar 2024 16:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711644273;
	bh=VTys3YpvicCW7hzI150+v9+jo5zNzxdDN4MVR7jcuPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBgiB3V1j9rN1RR05OFTvoN7/73Wg2r8aV4sIl2jbQrjFN15IVV5zffH0hXavzegq
	 czSRjnPDWpThJoeaFkzlfbJnMtiHsV+0IjQ0f9mQBHarKdGLTvoPOYHQV1VuxXajov
	 YRsvddH/bbe9YxTKUg1Dq0MINGU3I5tpIaQzh6e4=
Date: Thu, 28 Mar 2024 17:44:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
Message-ID: <2024032824-rasping-zone-7564@gregkh>
References: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>

On Thu, Mar 28, 2024 at 05:25:20PM +0100, Javier Carrasco wrote:
> The ISRs of the tps25750 and tps6598x do not handle generated events
> properly under all circumstances.
> 
> The tps6598x ISR does not read all bits of the INT_EVENTX registers,
> leaving events signaled with bits above 64 unattended. Moreover, these
> events are not cleared, leaving the interrupt enabled.
> 
> The tps25750 reads all bits of the INT_EVENT1 register, but the event
> checking is not right because the same event is checked in two different
> regions of the same register by means of an OR operation.
> 
> This series aims to fix both issues by reading all bits of the
> INT_EVENTX registers, and limiting the event checking to the region
> where the supported events are defined (currently they are limited to
> the first 64 bits of the registers, as the are defined as BIT_ULL()).
> 
> If the need for events above the first 64 bits of the INT_EVENTX
> registers arises, a different mechanism might be required. But for the
> current needs, all definitions can be left as they are.
> 
> Note: resend to add 'stable' mailing list (fixes in the series).


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

