Return-Path: <linux-kernel+bounces-156760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5CB8B07CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3881F286EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDED159914;
	Wed, 24 Apr 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN2VIcZa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262591598EA;
	Wed, 24 Apr 2024 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956201; cv=none; b=qodBm91Tfr3qZWEehP+Lwooe5U+mNZT9cmKsB1ui/f2HOMeAuU9r0iZXRijUBY0aCenBuZBQ4q7CLCDM4I93xS/gWR+AJlc0MCpQtQDS2JnvhbO2VfQqKlwD15llqhLLZLeABOFLZ3wgaZgYnpnPso8VEuVE5Vwjl3O5bVR9BK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956201; c=relaxed/simple;
	bh=VlCUYJjJMdo3gKgoD+v70kTIJeDoxTMF1EJ27Rbviz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXJYjmpCRCWuapQPbFCS8XBFQZLjZHVwt0PUJYou5TWSDa/ivow5pGpjHpe4PP/Sf+c82Qx9KI33d7nzsnsaseOBS+pajFxjvV1fH3Sf36URQnqSMxtlXcnWxw6FhrPQeP14un6IP4lTZOMP6eCYOOzBIrITjsN4AD1YzqkBnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN2VIcZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3999C113CE;
	Wed, 24 Apr 2024 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713956201;
	bh=VlCUYJjJMdo3gKgoD+v70kTIJeDoxTMF1EJ27Rbviz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PN2VIcZaLKC7POnmPWKv/9Dg7rlkUALbhBAqV6Ud2rVxTNG4y7aqR2/9zw6l90Wzd
	 B7y4YYxIjtEQD8LEHVSRwpQG6pCLsX2F2PVFa2RD4OkwUT/0zpeJqdfNk2LzjgQLSO
	 C5/RXeNSdIvYyps+F/5mhZs2fnYKV6QidjRJKq/gkXP/9Sdu2qYBAc0jSJ7fgQt2O0
	 xKMN4AEx7gLlg3wdzVNhLYhfSIDR7+eNBVZ3EhoXdKjg99jaiAMHxml14Be7P73I/m
	 ZBt7bJtlDUaN29PFj+UhAI5vDel/ufQDjXvddyuPmynMrYpCo4mQOgjzITp9Vav2Sd
	 rmt5enLCOR0WA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzaIp-0000000035o-3MJZ;
	Wed, 24 Apr 2024 12:56:39 +0200
Date: Wed, 24 Apr 2024 12:56:39 +0200
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
Message-ID: <ZijlZw6zm4R9ULBU@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-5-johan+linaro@kernel.org>
 <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XP8aCjwE3LfgMy4oBL4xftFg5NkgUFso__54zNp_ZWiA@mail.gmail.com>

On Tue, Apr 23, 2024 at 01:37:14PM -0700, Doug Anderson wrote:
> On Tue, Apr 23, 2024 at 6:46 AM Johan Hovold <johan+linaro@kernel.org> wrote:

> > @@ -87,12 +104,14 @@ static int i2c_hid_of_elan_probe(struct i2c_client *client)
> >         ihid_elan->ops.power_up = elan_i2c_hid_power_up;
> >         ihid_elan->ops.power_down = elan_i2c_hid_power_down;
> >
> > -       /* Start out with reset asserted */
> > -       ihid_elan->reset_gpio =
> > -               devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> > +       ihid_elan->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +                                                       GPIOD_ASIS);
> 
> I'm not a huge fan of this part of the change. It feels like the GPIO
> state should be initialized by the probe function. Right before we
> call i2c_hid_core_probe() we should be in the state of "powered off"
> and the reset line should be in a consistent state. If
> "no_reset_on_power_off" then it should be de-asserted. Else it should
> be asserted.

First, the reset gpio will be set before probe() returns, just not
immediately when it is requested.

[ Sure, your panel follower implementation may defer the actual probe of
the touchscreen even further but I think that's a design flaw in the
current implementation. ]

Second, the device is not necessarily in the "powered off" state as the
driver leaves the power supplies in whatever state that the boot
firmware left them in.

Not immediately asserting reset and instead leaving it in the state that
the boot firmware left it in is also no different from what happens when
a probe function bails out before requesting the reset line.

> I think GPIOD_ASIS doesn't actually do anything useful for you, right?
> i2c_hid_core_probe() will power on and the first thing that'll happen
> there is that the reset line will be unconditionally asserted.

It avoids asserting reset before we need to and thus also avoid the need
to deassert it on early probe failures (e.g. if one of the regulator
lookups fails).

We also don't need to worry about timing requirements, which can all be
handled in one place (i.e. in the power up and power down callbacks).
 
> Having this as "GPIOD_ASIS" makes it feel like the kernel is somehow
> able to maintain continuity of this GPIO line from the BIOS state to
> the kernel, but I don't think it can. I've looked at the "GPIOD_ASIS"
> property before because I've always wanted the ability to have GPIOs
> that could more seamlessly transition their firmware state to their
> kernel state. I don't think the API actually allows it. The fact that
> GPIO regulators don't support this seamless transition (even though it
> would be an obvious feature to add) supports my theory that the API
> doesn't currently allow it. It may be possible to make something work
> on some implementations but I think it's not guaranteed.
> 
> Specifically, the docs say:
> 
> * GPIOD_ASIS or 0 to not initialize the GPIO at all. The direction must be set
>   later with one of the dedicated functions.
> 
> So that means that you can't read the pin without making it an input
> (which might change the state if it was previously driving a value)
> and you can't write the pin without making it an output and choosing a
> value to set it to. Basically grabbing a pin with "asis" doesn't allow
> you to do anything with it--it just claims it and doesn't let anyone
> else have it.

These properties may prevent it from being used by the regulator
framework, but GPIOD_ASIS works well in the case of a reset gpio where
we simply leave it in whatever state the firmware left it in if probe
fails before we get to powering on the device.

Johan

