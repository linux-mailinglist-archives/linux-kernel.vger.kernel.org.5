Return-Path: <linux-kernel+bounces-7396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9C81A755
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79151F233B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACC4878D;
	Wed, 20 Dec 2023 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="xbQQdgnG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542C48CC0;
	Wed, 20 Dec 2023 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SwP3b1fmjz9ssS;
	Wed, 20 Dec 2023 20:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1703101067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgxSUwGOi+ie/puV3wymSBpsL2XirYOnPiXm8jpB72I=;
	b=xbQQdgnGakr8QIqbYrhLaYBAmMjZeHqK+kgRtWIfiTEw6bI2ZeRalOrkweo9b7MqptX65d
	vIB4sGVAAw79caC0Tus+QNhPiHsM/RKd12D7HtqTwbkNUq+osNaBuIkZWFRmQnuk62b6Hv
	8wuPpg/a75LWGtHsnabNtGjgFzqnWBahaUS1qTs2kAmneFYcC7YNJblIpi0/Ek+BOHHse6
	bb7ZnfOx4X1ew9HJUvbUxRqsXSp29Z3dXNuxKhEFJ9YtSUN3NgLTdsXB8mfWfLHb3nUVFT
	ud9eAuOyF4gFtqV41ulbeS2P0PoRaVtJ0pfcw/A0HFfcQX4PiUHNK7yp0fz1IQ==
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <10386431.nUPlyArG6x@jernej-laptop> <87edfh9ud8.fsf@oltmanns.dev>
 <1845418.atdPhlSkOF@jernej-laptop>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team
 <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/panel: st7703: Drive XBD599 panel at higher
 clock rate
Date: Wed, 20 Dec 2023 19:57:06 +0100
In-reply-to: <1845418.atdPhlSkOF@jernej-laptop>
Message-ID: <875y0sacmz.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Ok, I've done more detailed testing, and it seems this patch results in
lots of dropped frames. I'm sorry for not being more thorough earlier.
I'll do some more testing without this patch and might have to either
remove it from V2 of this series.

I need to see if the same stability can be achieved when running
PLL-MIPI outside its specied range.

Best regards,
  Frank

On 2023-12-20 at 16:18:49 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> Dne sreda, 20. december 2023 ob 08:14:27 CET je Frank Oltmanns napisal(a):
>>
>> On 2023-12-19 at 18:04:29 +0100, Jernej =C5=A0krabec <jernej.skrabec@gma=
il.com> wrote:
>> > Dne ponedeljek, 18. december 2023 ob 14:35:23 CET je Frank Oltmanns na=
pisal(a):
>> >> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
>> >> Acoording to it's datasheet, the SOC requires PLL-MIPI to run at more
>> >> than 500 MHz.
>> >>
>> >> Therefore, change [hv]sync_(start|end) so that we reach a clock rate
>> >> that is high enough to drive PLL-MIPI within its limits.
>> >>
>> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> >
>> > I'm not too sure about this patch. I see that PLL_MIPI doesn't have set
>> > minimum frequency limit in clock driver. If you add it, clock framework
>> > should find rate that is high enough and divisible with target rate.
>>
>> This one is really a tough nut. Unfortunately, the PLL_MIPI clock for
>> this panel has to run exactly at 6 * panel clock. Let me start by
>> showing the relevant part of the clock tree (this is on the pinephone
>> after applying the patches):
>>     pll-video0                 393600000
>>        pll-mipi                500945454
>>           tcon0                500945454
>>              tcon-data-clock   125236363
>>
>> To elaborate, tcon-data-clock has to run at 1/4 the DSI per-lane bit
>> rate [1]. It's a fixed divisor
>>
>> The panel I'm proposing to change is defined as this:
>>
>>     static const struct st7703_panel_desc xbd599_desc =3D {
>>     	.mode =3D &xbd599_mode,
>>     	.lanes =3D 4,
>>     	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULS=
E,
>>     	.format =3D MIPI_DSI_FMT_RGB888,
>>     	.init_sequence =3D xbd599_init_sequence,
>>     };
>>
>> So, we have 24 bpp and 4 lanes. Therefore, the resulting requested
>> tcon-data-clock rate is
>>     crtc_clock * 1000 * (24 / 4) / 4
>>
>> tcon-data-clock therefore requests a parent rate of
>>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>>
>> The initial 4 is the fixed divisor between tcon0 and tcon-data-clock.
>> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>>
>> Since PLL-MIPI has to run at at least at 500MHz this forces us to have a
>> crtc_clock >=3D 83.333 MHz. The mode I'm prorposing results in a rate of
>> 83.502 MHz.
>
> This is much better explanation why this change is needed. Still, I think
> adding min and max rate to PLL_MIPI would make sense, so proper rates
> are guaranteed.
>
> Anyway, do you know where are all those old values come from? And how did
> you come up with new ones? I guess you can't just simply change timings,
> there are probably some HW limitations? Do you know if BSP kernel support
> this panel and how this situation is solved there?
>
>>
>> If we only changed the constraints on the PLL_MIPI without changing the
>> panel mode, we end up with a mismatch. This, in turn, would result in
>> dropped frames, right?
>
> From what I read, I think frame rate would be higher than 60 fps. What
> exactly would happen depends on the panel.
>
> Best regards,
> Jernej
>
>>
>> Best regards,
>>   Frank
>>
>> [1] Source:
>> https://elixir.bootlin.com/linux/v6.6.7/source/drivers/gpu/drm/sun4i/sun=
4i_tcon.c#L346
>>
>> >
>> > Best regards,
>> > Jernej
>> >
>> >> ---
>> >>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
>> >>  1 file changed, 7 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/=
gpu/drm/panel/panel-sitronix-st7703.c
>> >> index b55bafd1a8be..6886fd7f765e 100644
>> >> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>> >> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>> >> @@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 *=
ctx)
>> >>
>> >>  static const struct drm_display_mode xbd599_mode =3D {
>> >>  	.hdisplay    =3D 720,
>> >> -	.hsync_start =3D 720 + 40,
>> >> -	.hsync_end   =3D 720 + 40 + 40,
>> >> -	.htotal	     =3D 720 + 40 + 40 + 40,
>> >> +	.hsync_start =3D 720 + 65,
>> >> +	.hsync_end   =3D 720 + 65 + 65,
>> >> +	.htotal      =3D 720 + 65 + 65 + 65,
>> >>  	.vdisplay    =3D 1440,
>> >> -	.vsync_start =3D 1440 + 18,
>> >> -	.vsync_end   =3D 1440 + 18 + 10,
>> >> -	.vtotal	     =3D 1440 + 18 + 10 + 17,
>> >> -	.clock	     =3D 69000,
>> >> +	.vsync_start =3D 1440 + 30,
>> >> +	.vsync_end   =3D 1440 + 30 + 22,
>> >> +	.vtotal	     =3D 1440 + 30 + 22 + 29,
>> >> +	.clock	     =3D (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 /=
 1000,
>> >>  	.flags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>> >>  	.width_mm    =3D 68,
>> >>  	.height_mm   =3D 136,
>> >>
>> >>
>>

