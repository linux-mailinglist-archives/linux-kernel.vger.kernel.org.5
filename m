Return-Path: <linux-kernel+bounces-156576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE228B04C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68DEB23CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AC6158A21;
	Wed, 24 Apr 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7bkm6bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA471581EB;
	Wed, 24 Apr 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948651; cv=none; b=cDl9deSNScDwn10spnRDq43DmGwRIX9xrffnk++3TBvUfhguXoAZNCI/KbIk0RAdrULdK9m8XNRW2dAh4x4j6vCCU2vPivQlZ5o63ehJqSmswaMhWEOF66vB3Aq0MbJq+p785ZuA0nOFQ4z6w/jy9rHTApBcpw5TpTOODyyzKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948651; c=relaxed/simple;
	bh=SoCDPr8M1Fw4mP+EiUCPkaLfHhVVC2cfI+W6y4qffnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvabJxCsBllBV2FXjmmLQBga2VZXv781KGvMdn93LC8C5q3YV02m2WMxR7ftgMYtgv692eOKNQvpCgGnksA6lmvLCgKCzkmtHSNez1HqEOi0Q8992NU5Ok1m0XB9TGQyNwJrdoo37FrKHKNJMkG7hVy4HbgU4MSr7DpaDHxdv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7bkm6bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F16C32781;
	Wed, 24 Apr 2024 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713948651;
	bh=SoCDPr8M1Fw4mP+EiUCPkaLfHhVVC2cfI+W6y4qffnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7bkm6bhC8IaAkHMDShhEZjGha+KoTqWGZ9El8Be30qGpo1JnySegNBj8FAicVDI+
	 5jyQugWsInwMRMtUsW2ba1a5XJqeEC0SvVsXMSLRlJhyUP/tHG5mYPlgTI1W/a4HCw
	 mWbv2Zf90cIs7Nd4DDQo5L9d7urNboMJrCZetwN7ejf+rfHbeafJcKI/WxQYgdTUmi
	 JCY7FGsfVB5wYlOKrUFwiE//3El1Nwx86FLBMI5kl/NVVL29mOJM6KnXamqh7nn5sf
	 WmkmLrlslwAAnlYuD9rmKE8eNqSpif4DtUIVzw6tJL8f4YHeM1OykfCuDWIcc0FVem
	 5ovZULSNc1Vkw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzYL2-000000001ZJ-3WVh;
	Wed, 24 Apr 2024 10:50:49 +0200
Date: Wed, 24 Apr 2024 10:50:48 +0200
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
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] HID/arm64: dts: qcom: sc8280xp-x13s: fix touchscreen
 power on
Message-ID: <ZijH6EaqWKHWRcdK@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <CAD=FV=W2Y=Sr-=YkKb01XLQsbQJr2b981c9kcfvAc4_5E9XD7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=W2Y=Sr-=YkKb01XLQsbQJr2b981c9kcfvAc4_5E9XD7g@mail.gmail.com>

On Tue, Apr 23, 2024 at 01:36:18PM -0700, Doug Anderson wrote:
> On Tue, Apr 23, 2024 at 6:46 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > The Elan eKTH5015M touch controller on the X13s requires a 300 ms delay
> > before sending commands after having deasserted reset during power on.
> >
> > This series switches the X13s devicetree to use the Elan specific
> > binding so that the OS can determine the required power-on sequence and
> > make sure that the controller is always detected during boot. [1]
> >
> > The Elan hid-i2c driver currently asserts reset unconditionally during
> > suspend, which does not work on the X13s where the touch controller
> > supply is shared with other peripherals that may remain powered. Holding
> > the controller in reset can increase power consumption and also leaks
> > current through the reset circuitry pull ups.
> 
> Can you provide more details about which devices exactly it shares
> power with? I'm worried that you may be shooting yourself in the foot
> to avoid shooting yourself in the arm.
> 
> Specifically, if those other peripherals that may remain powered ever
> power themselves off then you'll end up back-driving the touchscreen
> through the reset line, won't you? Since reset is active low then not
> asserting reset drives the reset line high and, if you power it off,
> it can leach power backwards through the reset line. The
> "goodix,no-reset-during-suspend" property that I added earlier
> specifically worked on systems where the rail was always-on so I could
> guarantee that didn't happen.
> 
> From looking at your dts patch it looks like your power _is_ on an
> always-on rail so you should be OK, but it should be documented that
> this only works for always-on rails.
> 
> ..also, from your patch description it sounds as if (maybe?) you
> intend to eventually let the rail power off if the trackpad isn't a
> wakeup source. If you eventually plan to do that then you definitely
> need something more complex here...

No, that's the whole point: the hardware is designed so that the reset
line can be left deasserted by the CPU also when the supply is off.

The supply in this case is shared with the keyboard and touchpad, but
also some other devices which are not yet fully described. As you
rightly noted, the intention is to allow the supply to eventually be
disabled when none of these devices are enabled as wakeup sources.

I did not want to get in to too much details on exactly how this
particular reset circuit is designed, but basically you have a pull up
to an always-on 1.8 V rail on the CPU side, a FET level shifter, and a
pull up to the supply voltage on the peripheral side.

With this design, the reset line can be left deasserted by the CPU
(tri-stated or driven high), but the important part is that the reset
signal that goes into the controller will be pulled to 3.3 V only when
the supply is left on and otherwise it will be connected to ground.

> > Note that the latter also affects X13s variants where the touchscreen is
> > not populated as the driver also exits probe() with reset asserted.
> 
> I assume driving against an external pull is _probably_ not a huge
> deal (should be a pretty small amount of power), but I agree it would
> be nice to fix.
> 
> I'm a bit leery of actively driving the reset pin high (deasserting
> the reset) just to match the pull. It feels like in your case it would
> be better to make it an input w/ no pulls. It almost feels like
> something in the pinctrl system should handle this. Something where
> the pin is default "input no pull" at the board level and when the
> driver exits it should go back to the pinctrl default...

If you look at the DT patch that's essentially what I'm doing by
describing the reset pin as open-drain so that it will be configured as
an input (tristated) when reset is deasserted and only driven low when
reset is asserted.

> I guess one last thought is: what do we do if/when someone needs the
> same solution but they want multiple sources of touchscreens, assuming
> we ever get the second-sourcing problem solved well. In that case the
> different touchscreen drivers might have a different idea of how the
> GPIO should be left when the driver exits...

The second-source problem is arguable a separate one, and as we've
discussed in the past, the current approach of describing both devices
in the devicetree only works when the devices are truly compatible in
terms of external resources (supplies, gpios, pinconfig). For anything
more complex, we need a more elaborate implementation.

In this case it should not be a problem, though, as the reset circuit
should have the same properties regardless of which controller you
connect (e.g. both nodes would have the 'no-reset-on-power-off'
property).

Johan

