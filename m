Return-Path: <linux-kernel+bounces-147999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CA8A7C68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC69E1F24436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2765BA8;
	Wed, 17 Apr 2024 06:38:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003771E481;
	Wed, 17 Apr 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335914; cv=none; b=liREv+EzzSqyqm4M/UfCsm9VJAuzFDiInD7fMbs6+pZ1IkvXIF+8lrCNQEBLbRu8mbXtED4yN/zdVYGCGCbR3VyDfrpUnNOzOEPNEqayzqkhyCmvicWSth2Pkjk/HXzuVEiJIH3Nq44z3K0ZviBljwPwufRzCwREQrTcFChjkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335914; c=relaxed/simple;
	bh=EcOvw8+bLjtsHGYZAabB3AX78BMDNvnnVdl7iKbcCx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5MFEiyYGObYDbbCWhpLEG51NmqD9Dx9dcqXCqcJLh0yxIKnvRURzUBWn54vn/Ds56ur5xbCHNW5Kt2TF5Sop3TpWUV+B63GD4SJGT5do7cYvPtqidrDXeZ75tL52lnNt+eK5bsYZKP1BcqcKi3F+UGmAIh/IICBr5Hg1d8wEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676EC339;
	Tue, 16 Apr 2024 23:38:58 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703923F738;
	Tue, 16 Apr 2024 23:38:28 -0700 (PDT)
Date: Wed, 17 Apr 2024 07:38:25 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v10 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <Zh9uYdxgJCVSufAE@pluto>
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com>
 <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c652af8-151e-4d8b-9587-8eae1254a4fe@moroto.mountain>

On Tue, Apr 16, 2024 at 09:20:11PM +0300, Dan Carpenter wrote:
> I'm trying to re-base AKASHI Takahiro's gpio driver on top of your scmi
> pinctrl driver.
> https://lore.kernel.org/all/20231005025843.508689-1-takahiro.akashi@linaro.org/
> I need to do something like this below to save the gpio information.
> 
> So now, great, I have the information but I'm not sure how to export it
> from the scmi pinctrl driver to the gpio driver...  (This is a probably
> a stupid question but I am real newbie with regards to gpio).
> 

Hi Dan,

I dont think it is a stupid question, I'll try to answer your questions
as much as possible, regarding the SCMI side, since I am definitely not so
much familiar with the GPIO/Pinctrl subsystem either.

First of all, to put things in perspective, drivers/firmware/arm_scmi/pinctrl.c
is just the SCMI protocol layer, which as part of the core SCMI driver is in
charge of implementing the specific protocol (i.e. building and sending
appropriate messages via the SCMI core) and which, in turn, exposes a set of
protocol-specific operations in scmi_protocol.h.

On top of this there are the SCMI drivers (like drivers/pinctrl/pinctrl-scmi.c)
that, on one side, plug into the SCMI stack, and as such can use the specific
protocol_ops, and on the other side register into some custom existing Linux
susbsystem like Pinctrl, so that it can relay generic Pinctrl related requests,
via the above SCMI pinctrl_ops, to the platform SCMI fw (finally translated into
SCMI messages at the protocol layer...)

In all of this, note that the various protocol_ops in scmi_protocol.h are NOT
exported symbols (would have been dozens): that is the reason why a driver
willing to use an SCMI protocol via its specific ops, has to be, first, an SCMI
driver so that can grab the related protocol_ops and an handle to the SCMI
instance, during its probe phase.

NOW, as far as I can remember (and have understood) AKASHI gpio-pinctrl driver
was INSTEAD meant to be a generic GPIO driver on top of Pinctrl subsystem,
so something that could work on top of any pinctrl controller, NOT necessarily
an SCMI one, so, as a consequence it is NOT an SCMI driver and it cannot access
directly any of the pinctrl_ops (existing or future), BUT it will have, instead,
to be based on the Pinctrl subsystem API to achieve its functionalities in a generic
manner.

So at the end, AFAICU:

- you collect any additional gpio info you need (and can get from the spec) at
  the SCMI Pinctrl protocol layer in drivers/firmware/arm_scmi/pinctrl.c (as you
  are doing)

- you expose such info via pinctrl_ops: in these regards many OTHER
  protocols usually exposes some .get_info() ops to get a generic info
  descriptor including all info about a specific resource, BUT this is not
  the case for pinctrl_ops, which just exposes a few custom ops to get
  only the bits that are strictly needed (like resource names via
  .name_get()). Here is up to you which kind of interface to expose really,
  depending on the SCMI Pinctrl driver usage pattern. (is_gpio() ?
  .get_gpios() ? just a new out-param in an existing ops ?)

- in the SCMI pinctrl-scmi driver you can finally make use of your new
  protocol_ops to provide to the Pinctrl subsystem the funcs needed by
  the Pinctrl API calls as issued by the gpio-pinctrl driver....and in these
  regards I really dont know what are the missing bits...I suppose something
  that has to work as the SCMI backend for the pinctrl_gpio_* calls inside
  gpio-pinctrl.

> The other thing is that the SCMI spec says:
> 
>     4.11.2.7
>     PINCTRL_SETTINGS_GET
> 
>     This command can be used by an agent to get the pin or group
>     configuration, and the function selected to be enabled. It can also
>     be used to read the value of a pin when it is set to GPIO mode.
> 
> What does that mean?  Is that right, or is it something left over from a
> previous revision of the spec.
> 

My guess is that, this is a (certainly obscure) way for the spec to
express the fact that using this message you can get the pin/group
selected funcs AND pin/group configs, configs, that, include the settings
for any OEM Config type as specified in SCMI spec Table 24, which, in
turn, contains Input-mode/Output-mode/Output-value types that I suppose
pertain to the GPIO world.

As a consequence, I guess you neeed somehow to connect the above
pinctrl_gpio_set/get_config and pinctrl_gpio_get_direction into the
pinctrl_ops .setting_get_one() and .settings_conf() by using the proper
GPIO-related OEM types, not sure of the details (as said I am ignorant)
BUT it could be that this is already handled somehow by the current
pinctrl-scmi driver if the GPIO ranges are handled correctly throughout
all the chain of susbsystem involved... (looking at the internals of
 https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/core.c#L912)
..but I really not familiar on how GPIO ranges are supposed to work so
it is better that now I shut up :D

..apologies for the long email, especially if I said something already obvious.

Thanks,
Cristian

