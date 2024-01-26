Return-Path: <linux-kernel+bounces-40184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1D83DBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2530B1F252F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5271429E;
	Fri, 26 Jan 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWB2+Ym8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822177F;
	Fri, 26 Jan 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279452; cv=none; b=ftg5TTMQiHIhjpxkJcPLry+i6UBt+j1adlWu+7LD5ho/NpPgkdLKQYYgcUfI99ik+BLwINhsG3OFgXfvMd1xvajczuoX7gVd8HfOi/ZD3fsjD45cLSGL+u7+Ub4wwyB3Gxg9UwAdkFgoX1Jplrz+PWWj5qiwQn/Ten2kniLApt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279452; c=relaxed/simple;
	bh=5PTW+IqP2/VHagHq8RzcNDNtfY8AXE4R1InU9ZFsRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4yQkH5o+kBSVm8q6JNuVBel0tFUzzInpkASaqZrjgFp37PZrfH0/X15nfHC+BWyuCK1IbcS5UzAOyNt99n0Mz4oUAC+wQFSh+aWpSYYL4IOWtgpa4EXfNC96FXUjEWKD4+mkUJuq++qssBomTH/egCUvPpF4qLoeBXzwmABXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWB2+Ym8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F80C433C7;
	Fri, 26 Jan 2024 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706279452;
	bh=5PTW+IqP2/VHagHq8RzcNDNtfY8AXE4R1InU9ZFsRoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWB2+Ym84uJLouqbVirqCK9/fentoQ0ElweL6zwW5q84ZepK9XW2oSbMqyOs+c6wR
	 bbPzecqjB7lB7pB2LiY/78NJd2MSOTi57HTrxqibk6MtThVUmexxg6LVBS3eFgTzhY
	 w5wEaZbgL33rMhDbWVXD3lNUMFXNnqjKS8EoKaqiJx1Aj4wD9sPYDE54B0eLz0K5bl
	 ldC+Pv8RtPxYOiyLhCIf6WcE6lUu3uSQW2YaI1hVZmZzYlgapfAnfZp8VHAx1mjBDK
	 uN1HrFnXmWq0rg8fgEXUYtmSykuEuZcdIowGn6D5LLdTMFPhXT6RwHANmDRi1QkUsf
	 3b8pNQrkjyPtg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTNEU-000000007UG-3KiF;
	Fri, 26 Jan 2024 15:31:03 +0100
Date: Fri, 26 Jan 2024 15:31:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jikos@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <ZbPCJv7HW8OQzPMT@hovoldconsulting.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
 <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
 <20240126130232.GA5506@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126130232.GA5506@aspen.lan>

On Fri, Jan 26, 2024 at 01:02:32PM +0000, Daniel Thompson wrote:
> On Fri, Jan 26, 2024 at 09:12:37AM +0100, Johan Hovold wrote:
> > On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > > The failing read-test in __i2c_hid_core_probe() determines that there's
> > > nothing connected at the documented address of the touchscreen.
> > >
> > > Introduce the 5ms after-power and 200ms after-reset delays found in the
> > > ACPI tables. Also wire up the reset-gpio, for good measure.
> >
> > As the supplies for the touchscreen are always on (and left on by the
> > bootloader) it would seem that it is really the addition of the reset
> > gpio which makes things work here. Unless the delay is needed for some
> > other reason.
> >
> > (The power-on delay also looks a bit short compared to what is used for
> > other devices.)
> >
> > Reset support was only recently added with commit 2be404486c05 ("HID:
> > i2c-hid-of: Add reset GPIO support to i2c-hid-of") so we should not
> > backport this one before first determining that.
> 
> This comment attracted my attention so I tried booting with each of the
> three lines individually.
> 
> On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > +             reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> 
> This is not enough, on it's own, to get the touch screen running.
> 
> I guess that's not so much of a surprise since the rebind-the-driver
> from userspace trick wouldn't have been touching this reset.

Right, I realised that after hitting send.

For the record, people have successfully been using the touchpad after
forcing the driver to reprobe through sysfs:

	echo 4-0010 >/sys/bus/i2c/drivers/i2c_hid_of/bind

> > +             post-power-on-delay-ms = <5>;
> 
> This line alone is enough (in v6.7.1).

Thanks for confirming.

> > +             post-reset-deassert-delay-ms = <200>;
> 
> This line alone is also enough!

Yes, the driver honours this delay regardless of whether a reset gpio is
defined currently, so this is expected.

> In short it looks like the delays make the difference and, even a short
> delay, can fix the problem.

Right, but since the suppliers are left enabled by the bootloader (and
never disabled by the kernel), that only begs the question of why this
makes a difference.

Without the delay, the other HID devices are probing (successfully)
slightly before, but essentially in parallel with the touchscreen while
using the same resources. Is that causing trouble somehow?

Or is there a bug in the i2c controller driver affecting only this
device that can be worked around by adding a delay before the first
transfer?

Johan

