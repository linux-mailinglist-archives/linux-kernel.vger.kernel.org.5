Return-Path: <linux-kernel+bounces-167411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49098BA932
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC428167C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121D414D29C;
	Fri,  3 May 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip/ZiwKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586E14A097;
	Fri,  3 May 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726065; cv=none; b=N5jgty+mNjeUvJq1vhWZ5ZSWR9nebFKROTfeUMSw7SzmZzZlblWL5jmV8vdCOx5OZUKkmC5XwQZpOvp2xMpQCr5hhXsUeryvie7SIedarPlCHlW9cuIuEKh72ALu5cASsfL9y76N6w/gGf3HYym88nah5DssjJZZIhcmOC03yGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726065; c=relaxed/simple;
	bh=A2/ehrj8UnAnTNHhbcvlCxq/D5HtiADTdCZbBYLQsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifXK3PfPDDe+kKGaWvGfJB71KU7Zzk5+sKroNAcIDmJ5AefL8vbOUFgjVigtcGhJ5iJAMFgojHz6y+/RLtBnTEtt6aKgcHSWakZIq4ZAOul1WQ8gyBUnx/EirgjZLXjjF3L/W3JYxlePNzZgq3EHwFFXWtwXqT+UHV0yL3biU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip/ZiwKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE4C116B1;
	Fri,  3 May 2024 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714726064;
	bh=A2/ehrj8UnAnTNHhbcvlCxq/D5HtiADTdCZbBYLQsgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip/ZiwKhJ6wXvXlo0UOeeiCuXrUSRp6xsDaa6aHWSvseLuwBF/xIJjdTACNZSEhv7
	 SHg8OUk0nWy58is+iuh8p5n7I76iZQtWq1QpnPPqijEGIpqxmJzvQ1Fnzm66ocKPTG
	 IanqU1ZbV4ufF+LAAj5LCn/C2kJx4cXVqrlvpc1wTG1DqFL1rJid6DyRl0zfP9PdxV
	 vXZHmToHlwLMWgsZXMx2xKdqhGrzyslX3MImeIU9ZR6dnip8MYun/i+eRfD/73otQm
	 d1IL9YK2tVuiYnKTFbh/vXyl3cVDWYllWL6lY90DpQy9+PZ2UlSW07lEZWxxq8avqP
	 Fvb1rjxu6obUA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s2oa0-000000004pD-3b9A;
	Fri, 03 May 2024 10:47:45 +0200
Date: Fri, 3 May 2024 10:47:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: HID: i2c-hid: elan: add
 'no-reset-on-power-off' property
Message-ID: <ZjSksM07OlgpE3yO@hovoldconsulting.com>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org>
 <CACRpkdYXfZwBdLSTTPbruD9qynOPuQBOZjCwA_6eE+1MUBCkgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYXfZwBdLSTTPbruD9qynOPuQBOZjCwA_6eE+1MUBCkgA@mail.gmail.com>

On Fri, May 03, 2024 at 09:40:43AM +0200, Linus Walleij wrote:

> On Tue, Apr 23, 2024 at 3:46 PM Johan Hovold <johan+linaro@kernel.org> wrote:
> 
> > When the power supply is shared with other peripherals the reset line
> > can be wired in such a way that it can remain deasserted regardless of
> > whether the supply is on or not.
> >
> > This is important as it can be used to avoid holding the controller in
> > reset for extended periods of time when it remains powered, something
> > which can lead to increased power consumption. Leaving reset deasserted
> > also avoids leaking current through the reset circuitry pull-up
> > resistors.
> 
> So the reset line in this case is a GPIO as seen from the context above.
> 
> To me that means that the line should have the GPIO_OPEN_DRAIN flag
> set in the device tree node for reset-gpios. As it has pull-up resistors,
> setting the line to high impedance takes the device out of reset, and
> thus it is effectively open drain.

If you look at the devicetree patch later in the series this is exactly
what is done.
 
> > Add a new 'no-reset-on-power-off' devicetree property which can be used
> > by the OS to determine when reset needs to be asserted on power down.
> 
> If the above holds true, the driver can then just check for the open drain flag
> in the reset-gpios phandle, and if that is set, conclude that it should not
> actively drive the line low in the poweroff state.

That is an alternative I considered but rejected as just knowing that
the gpio is open-drain is not necessarily sufficient, for example, if
the reset line is pulled to always-on rail while power to the device can
be cut.

Perhaps no one would ever construct hardware like that, but it does not
seem like the hardware property I'm trying to encode necessarily follows
from having an open-drain reset line.

And then the OS should probably not make assumptions like that either,
especially since getting it wrong can potentially lead to damaged
hardware.

Johan

