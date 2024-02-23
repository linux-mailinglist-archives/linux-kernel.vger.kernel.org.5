Return-Path: <linux-kernel+bounces-77918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1858860C23
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E0A1F214C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07D22071;
	Fri, 23 Feb 2024 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="bYZ3AfVe"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DD18AEE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676425; cv=none; b=XBziZ3lQ0MmJjFyMotjaK0zcE8P2cwlXFWjzYjJiOUjTcWiUhbRM/PjhbnO/McOzeh+OPuSEWrI3/lXbq/3deOBR3Ze9I+n42TJc0t5Ius4HlkeviAujTpINRRdhuf5b32OC/SzgKzbYb4XvDM+RDMiQOotsZ1cy/8EMFtIkGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676425; c=relaxed/simple;
	bh=HeyPgo+8UCVKlR0pSsRdYja39it6FmxGSMN3doO156Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJpsf/O6ZzPKEjqBbBvUY2+TLzbyhNZzApt0mCi90V0UIxNIRgnVlBD9noTCR3NMolkl6UMSOmv/Fxx5dpH6c7ePXZr1X2+yJEnm7Sq+NUorLwiKLWguXDO6CjdcVc6O1rn98UVFYmTb/XRewThnfzWZLiQoZE0L7Q6wB3SNUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=bYZ3AfVe; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708676418; bh=HeyPgo+8UCVKlR0pSsRdYja39it6FmxGSMN3doO156Q=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=bYZ3AfVewfQLfkJOtr2NFwdGwxpB2Usry+rr9+yym0SxhK11qNA87fUyvvW/Crx52
	 Kt/zDGevmVTZsYo4hzZ7qmRBJZkxkUJVi9OgXjIN9kwjkoglf5CsDcyX9RI0QEB8gw
	 +BKARxyqsdHdcFNhHV6/hRwFibu1BJxygJF1xl7k=
Date: Fri, 23 Feb 2024 09:20:17 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/sun4i: Fix layer zpos change/atomic modesetting
Message-ID: <iboaf4yyieqq6yeuu2amwjnwsao3vx7fzeqldhuplx5j6z2zxf@ex57tbxhzzk6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240216190430.1374132-1-megi@xff.cz>
 <20240216190430.1374132-4-megi@xff.cz>
 <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>
 <2448947.jE0xQCEvom@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2448947.jE0xQCEvom@jernej-laptop>

On Thu, Feb 22, 2024 at 09:02:53PM +0100, Jernej Škrabec wrote:
> Dne sreda, 21. februar 2024 ob 14:45:20 CET je Maxime Ripard napisal(a):
> > Hi,
> > 
> > On Fri, Feb 16, 2024 at 08:04:26PM +0100, Ondřej Jirman wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > > 
> > > Identical configurations of planes can lead to different (and wrong)
> > > layer -> pipe routing at HW level, depending on the order of atomic
> > > plane changes.
> > > 
> > > For example:
> > > 
> > > - Layer 1 is configured to zpos 0 and thus uses pipe 0. No other layer
> > >   is enabled. This is a typical situation at boot.
> > > 
> > > - When a compositor takes over and layer 3 is enabled,
> > >   sun8i_ui_layer_enable() will get called with old_zpos=0 zpos=1, which
> > >   will lead to incorrect disabling of pipe 0 and enabling of pipe 1.
> > > 
> > > What happens is that sun8i_ui_layer_enable() function may disable
> > > blender pipes even if it is no longer assigned to its layer.
> > > 
> > > To correct this, move the routing setup out of individual plane's
> > > atomic_update into crtc's atomic_update, where it can be calculated
> > > and updated all at once.
> > > 
> > > Remove the atomic_disable callback because it is no longer needed.
> > > 
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > 
> > I don't have enough knowledge about the mixers code to comment on your
> > patch, so I'll let Jernej review it. However, this feels to me like the
> > pipe assignment is typically the sort of things that should be dealt
> > with device-wide, and in atomic_check.
> 
> In DE2 and DE3.0, you cannot move planes between mixers (crtcs), because each
> one is hardwired to specific mixer. Movable planes are the feature of DE3.3
> and one of the pain points for upstreaming the code. Anyway, this commit only
> addresses current issue of enabling and disabling planes and handling zpos.
> 
> In atomic check you can only precalculate final register values, but I don't
> see any benefit doing that. I think that this code elegantly solves current
> issue of enabling or disabling wrong plane in certain situations, so:
> 
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thanks for the review.

> Note, if there is new revision, please rewrite blender regmap_update_bits()
> to regmap_write(). Since there is HW issue with reads, I would like to
> get rid of regmap_update_bits() calls eventually.

BTW as a side note, one observation I made about a year back after some testing
with a setup like this:

- PIN photodiode in a black box directed at a display (Pinephone)
  attached to the oscilloscope
- GPIO signal routed to another input of the scope
- sun4i-drm driver modification that toggles the GPIO any number of times so
  that I can correlate brightness changes as seen by photodiode on the
  scope with the timing of what's happening in the driver

is that if you do atomic commit right after receiving the flip event there's
a high chance that what you're commiting will get displayed right away,
basically skipping the update from the previous atomic commit.

It's very easy to reproduce with a test application that flips between two
completely white and completely black framebuffers back and forth right
after flip event. What you see on the display is seemingly random blinking
pattern: https://megous.com/dl/tmp/c9a286427ce66d80.png when it should be
a peridic flipping between black and white pixels like this
https://megous.com/dl/tmp/c085a50ccd387257.png

This goes away for me when introducing a >150us delay between flip event
and next atomic commit.

I did a more complex test with a test app that switches between 4 framebuffers
of decreasing shades of gray, so that the resulting pattern of brightness should
be a stariwise stepping signal pattern on the scope, along with gpio indicating which
framebuffer just got commited (by the number of pulses 1-4). What I saw was
that normally there's a 1 frame delay between commit and the corresponding
brightness change, but often enough the brightness change is immediate.

I think the hardware indicates a flip (vsync irq) some time before it performs
the double buffered register update to shadow register for the next frame. So
sometimes the driver manages to overwrite the values stored during the previous
commit before they get flipped to shadow registers. Again, intorducing a 150us
delay between flip event and atomic commit reliably fixes this, and I see
a perfect stairwise pattern on the scope instead of occasional skipped ahead
steps.

It seems to me that those 150us are related to display timing.

Vertical blanking cycle on Pinephone lasts about 400us with 45us long vsync
pulse roughly in the middle. In my observation it seems likely that HW signals
VSYNC interrupt at the start or end of the VSYNC pulse and flips the double
buffered HW registers at the end of the blanking cycle, leaving some 150us of
time in between for a quick atomic commit to still mess up the register settings
for the upcoming scan out, before they get commited to shadow regs. I don't have
a way to observe vsync signal on a scope, because it's MIPI-DSI display to
verify this exactly.

The certain thing is that after vsync interrupt, the double buffered registers
are not switched, yet. There's still some time left before that happens.

Anyway, just something I'd thought I share that may help us understand this
HW better. :)

kind regards,
	o.

> Best regards,
> Jernej
> 
> > 
> > If I'm talking non-sense, it would be great to mention at least why that
> > can't be an option in the commit log.
> > 
> > Maxime
> > 
> 
> 
> 
> 

