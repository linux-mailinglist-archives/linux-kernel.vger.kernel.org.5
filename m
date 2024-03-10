Return-Path: <linux-kernel+bounces-98199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577BA87765F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283811C20CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA4200C8;
	Sun, 10 Mar 2024 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJKSzryx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC708465;
	Sun, 10 Mar 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070664; cv=none; b=cN7sTYINoLywm0KFQFNAqOI9+0ZDhI81cLuWKJVcMnHp1pDfi5eNWAodxFNoFwR4VBn5XXdqlD2W1VhSxF2sWzfe0EAdYMuDER3Tw1a7CLf283rm+HcPpqxu+Z4SkyPyLHPf0hd05c3YzL6PQJIfboSzvj/wBKyRSQR2pSJ7Xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070664; c=relaxed/simple;
	bh=m7RZczD1dDV032y05IlmdDOzJwvwGNZyOWRvNsYwM+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONTHjPgg/acfHCess93Ovgk1NM7LU+s61Af7hd3fx9z9Q29ar0vbklJd2F/K29SxaRcAOgQ/rbSnTbCurrc3qLN6GcbWTT5WCsn9QXaVGgBzOB1UjDAvwcV7/qZ46hgMFXZ61zgQ0o4RCG3iEMB/0dvVuH9QS39ll2YKc5NPAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJKSzryx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37024C433C7;
	Sun, 10 Mar 2024 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710070663;
	bh=m7RZczD1dDV032y05IlmdDOzJwvwGNZyOWRvNsYwM+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJKSzryxcgu8cb6ktkPYMCQJoAlK7Sv2qXMupZoGls10vgj7PrUNhEChSUg2btniC
	 HN8/c5vySOXnleF8r+xzpJcmhNiBiQ73XnkUqwXRHyRcd2o4tsMKcwlqPjNo+8aJjY
	 LuydjTZenav48Yzf/Q1JE/QCf29OlXxe8NF6ELIeizL2Udoaqc6KcaVjyAYMHbLtkP
	 e4jVIQI6txHLrjYc4EBokpt92tk7L7SCfRhdQ8qJ+RdJFsfu3kSdNdWZkcpIgvneis
	 FTDrnxQDXOEH+OSEXLqB+RnvfpE38/MZ3ElyNDrS1VLWuScJ1kDCfyMDrhjfH9C+11
	 /lE7/3bg0ZeUg==
Date: Sun, 10 Mar 2024 11:37:38 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state
 in rtl8366rb
Message-ID: <20240310113738.GA1623@kernel.org>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
 <388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388b435f-13c5-446f-b265-6da98ccfd313@kernel.org>

On Sun, Mar 10, 2024 at 09:01:46AM +0100, Krzysztof Kozlowski wrote:
> On 10/03/2024 05:51, Luiz Angelo Daros de Luca wrote:
> > This switch family supports four LEDs for each of its six ports. Each
> > LED group is composed of one of these four LEDs from all six ports. LED
> > groups can be configured to display hardware information, such as link
> > activity, or manually controlled through a bitmap in registers
> > RTL8366RB_LED_0_1_CTRL_REG and RTL8366RB_LED_2_3_CTRL_REG.
> > 
> > After a reset, the default LED group configuration for groups 0 to 3
> > indicates, respectively, link activity, link at 1000M, 100M, and 10M, or
> > RTL8366RB_LED_CTRL_REG as 0x5432. These configurations are commonly used
> > for LED indications. However, the driver was replacing that
> > configuration to use manually controlled LEDs (RTL8366RB_LED_FORCE)
> > without providing a way for the OS to control them. The default
> > configuration is deemed more useful than fixed, uncontrollable turned-on
> > LEDs.
> > 
> > The driver was enabling/disabling LEDs during port_enable/disable.
> > However, these events occur when the port is administratively controlled
> > (up or down) and are not related to link presence. Additionally, when a
> > port N was disabled, the driver was turning off all LEDs for group N,
> > not only the corresponding LED for port N in any of those 4 groups. In
> > such cases, if port 0 was brought down, the LEDs for all ports in LED
> > group 0 would be turned off. As another side effect, the driver was
> > wrongly warning that port 5 didn't have an LED ("no LED for port 5").
> > Since showing the administrative state of ports is not an orthodox way
> > to use LEDs, it was not worth it to fix it and all this code was
> > dropped.
> > 
> > The code to disable LEDs was simplified only changing each LED group to
> > the RTL8366RB_LED_OFF state. Registers RTL8366RB_LED_0_1_CTRL_REG and
> > RTL8366RB_LED_2_3_CTRL_REG are only used when the corresponding LED
> > group is configured with RTL8366RB_LED_FORCE and they don't need to be
> > cleaned. The code still references an LED controlled by
> > RTL8366RB_INTERRUPT_CONTROL_REG, but as of now, no test device has
> > actually used it. Also, some magic numbers were replaced by macros.
> > 
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> This is the first version, so where did review happen?

FWIIW, I think this relates to review of an RFC of this patch-set.

https://lore.kernel.org/netdev/CACRpkda8tQ2u4+jCrpOQXbBd84oW98vmiDgU+GgdYCHuZfn49A@mail.gmail.com/

