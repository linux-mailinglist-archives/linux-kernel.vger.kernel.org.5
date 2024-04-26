Return-Path: <linux-kernel+bounces-159786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2922D8B33F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48732844BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23113F420;
	Fri, 26 Apr 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUqfNMNx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F6E282EA;
	Fri, 26 Apr 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123777; cv=none; b=NZw9opJd2mLUZvFn+99J+qEYd6cgaDBMiSbJUbEbSuW/UeLShLl2SZHK7R8DpC5WbGJxtoGAARA0Mqz76kfr5bZjxdO39o7R26de9D574Crcy34yYpyLXmCSLswMmDzFc8LHAwRwo8xknkQs0OTK07rH1odcnrC2YVAq7m/gzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123777; c=relaxed/simple;
	bh=G92cwOhiPQS7Q5kYfxITNoEUqeEw92zFYUHW/hjpagc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L38RMI+afYhO4VFneyqOYXFUvRpVL+rtcYZal1mCAqUGd/MUoN1BV7zfWqyjuTtezYNYV42tHsPmmFCvKDEHC3NefepgXjA4igvWjYvVqMIEMiNV1GzyouhKIqULfgHFAaXCJOFkM9LNhLJADsTz3nPQedtcRw13FFCxBNwAMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUqfNMNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEFFC113CD;
	Fri, 26 Apr 2024 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714123776;
	bh=G92cwOhiPQS7Q5kYfxITNoEUqeEw92zFYUHW/hjpagc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUqfNMNx7JSRrAXJvJBDJUeXLvPKDz8+GVpkqVRdxY8z9KaXmz7RK1sJrVTaBoWPN
	 G6/3K2PysJY3ClJtgvNibwmWEkunQAum87+eIuagiO5CUZrF5DDT9cKB+RY2FwW4Cv
	 f8BPBuSBFlgwSuXLihSNJVed/2hojzyyvxBz418X2mShdemMwpFL+fcSyy8UbqiDHA
	 Bg021h3Yb4LJFb+V5xR1wuk+M9V+r1MkPtCjw6shabcUp2tbVUFpgB0ZudWKRC9Uwz
	 rAOlGqCTRMC6PdBN8+WLgGbOhUZkwGXQomf510wCITZF+dUK9fU6KfynyNlUKkRmzC
	 dOnPOFUhtjE+g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s0Htg-000000001bi-4A4q;
	Fri, 26 Apr 2024 11:29:37 +0200
Date: Fri, 26 Apr 2024 11:29:36 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/6] HID: i2c-hid: elan: fix reset suspend current leakage
Message-ID: <Zit0ADAycyHp67Ax@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-5-johan+linaro@kernel.org>
 <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
 <ZijlZw6zm4R9ULBU@hovoldconsulting.com>
 <CAD=FV=Vxgu==8Cv3sDydFpEdd6ws2stkZvxvajE1OAFm2BgmXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vxgu==8Cv3sDydFpEdd6ws2stkZvxvajE1OAFm2BgmXw@mail.gmail.com>

On Wed, Apr 24, 2024 at 09:24:33AM -0700, Doug Anderson wrote:
> On Wed, Apr 24, 2024 at 3:56 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Apr 23, 2024 at 01:37:14PM -0700, Doug Anderson wrote:
> > > On Tue, Apr 23, 2024 at 6:46 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > > > @@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
> > > >         ihid_elan->ops.power_up = elan_i2c_hid_power_up;
> > > >         ihid_elan->ops.power_down = elan_i2c_hid_power_down;
> > > >
> > > > -       /* Start out with reset asserted */
> > > > -       ihid_elan->reset_gpio =
> > > > -               devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> > > > +       ihid_elan->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > > > +                                                       GPIOD_ASIS);
> > >
> > > I'm not a huge fan of this part of the change. It feels like the GPIO
> > > state should be initialized by the probe function. Right before we
> > > call i2c_hid_core_probe() we should be in the state of "powered off"
> > > and the reset line should be in a consistent state. If
> > > "no_reset_on_power_off" then it should be de-asserted. Else it should
> > > be asserted.

> > Second, the device is not necessarily in the "powered off" state
> 
> Logically, the driver treats it as being in "powered off" state,
> though. That's why the i2c-hid core makes the call to power it on. IMO
> we should strive to make it more of a consistent state, not less of
> one.

That's not really true. The device is often in an undefined power state
and we try to make sure that the hand over is as smooth as possible to
avoid resetting displays and similar unnecessarily.

The power-on sequence is what brings the device into a defined power
state.

> > as the
> > driver leaves the power supplies in whatever state that the boot
> > firmware left them in.
> 
> I guess it depends on the regulator. ;-) For GPIO-regulators they
> aren't in whatever state the boot firmware left them in. For non-GPIO
> regulators we (usually) do preserve the state that the boot firmware
> left them in.

Even for GPIO regulators we have the "regulator-boot-on" devicetree
property which is supposed to be set if the boot firmware has left a
regulator on so that the regulator initialisation can preserve the
state.

> > Not immediately asserting reset and instead leaving it in the state that
> > the boot firmware left it in is also no different from what happens when
> > a probe function bails out before requesting the reset line.
> >
> > > I think GPIOD_ASIS doesn't actually do anything useful for you, right?
> > > i2c_hid_core_probe() will power on and the first thing that'll happen
> > > there is that the reset line will be unconditionally asserted.
> >
> > It avoids asserting reset before we need to and thus also avoid the need
> > to deassert it on early probe failures (e.g. if one of the regulator
> > lookups fails).
> 
> I guess so, though I'm of the opinion that we should be robust against
> the state that firmware left things in. The firmware's job is to boot
> the kernel and make sure that the system is running in a safe/reliable
> way, not to optimize the power consumption of the board.

Agreed.

> If the
> firmware left the line configured as "output low" then you'd let that
> stand. If it's important for the line to be left in a certain state,
> isn't it better to make that explicit?

As I pointed out above we already do this for any error paths before
requesting the reset line. And I also don't think we need to worry too
much about power consumption in case of errors.

But there is one case I had not considered before, and that is your gpio
regulator example but where the boot-on flag does not match the actual
regulator state.

If the supply is on and reset deasserted, but the regulator-boot-on
flag is not set, then we want to make sure that reset is asserted before
disabling the supply when requesting the regulator.

> Also note: if we really end up keeping GPIOD_ASIS, which I'm still not
> convinced is the right move, the docs seem to imply that you need to
> explicitly set a direction before using it. Your current patch doesn't
> do that.

You're right. It will work in my case because of the gpiolib open-drain
implementation, but not generally.

I'll add back the reset during early probe and add error handling for
deasserting reset on machines like the X13s. On these, the touchscreen
may now be reset a couple of times in case of probe deferrals, but
device links should generally prevent that.

Johan

