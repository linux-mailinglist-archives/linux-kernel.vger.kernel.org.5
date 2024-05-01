Return-Path: <linux-kernel+bounces-164965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6F8B8588
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A341D283B09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF174CDE0;
	Wed,  1 May 2024 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lILSB58B"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3354482EF
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 06:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714544534; cv=none; b=O2jcsESf7AqxjV2sevm50cJFCETwJF6WFGTNJdihfbKL/GLwaLMtExVZfJmTH118VuQUIFwJ1iPaj6wRM8yXEo2PaxHcBO8qsTeFa/w4gk5npdkEK82lPM/iyZwMx8alTGDN4n6jWi6hf9MRqiv8eFKONPbi50v7OJG4hwS8EX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714544534; c=relaxed/simple;
	bh=aZEukvDjPHUsfsMDddQjUUDFfLIVSPNH5W78XULOl1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCWlBoIJHbwUIu7HvgKSZS1L0+WyW1qxQD63ug5W6wge4XUohqLOTEVOfVdXMtgyJNWKePD6uBaCT3xW7L7iv1IXCegRd56W3RmqM8Ooz1TMokhRP5dauejNyN8G8LPzyjoxpTmRu3gfqY5+G5N+XoEM5W809piszZjAQU27yo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lILSB58B; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DCC1520018;
	Wed,  1 May 2024 14:22:03 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714544526;
	bh=aZEukvDjPHUsfsMDddQjUUDFfLIVSPNH5W78XULOl1c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lILSB58BXjGWAqdzHxIqtScR6qCeSg8PSYcSaU1oWUO9TdnLkWYMDu7nhOsXaIjw4
	 FGVe5qW+YKwQ2RvpJYU6j95dvFGbJSehVFKr5u9udwKR19EU/CQ/USueXXfpmZCgCs
	 cJ9SHU+IoMyVeyzVAs90b967bePXZvn7m+5KDsLmHkM7Cs54KhcTHhFeqE3MCPpJui
	 zVi+5QV15JUwZSSJIy9hiJIdSZKy0SF8S3FEV8sWMkKZP4csf9WooEi1yhG7bqJZEW
	 NnYp1Dgst7fc4Jg4OBE0YOtsjJYJUgg9xQTT2hUFPd67jIbIZGjow8/E7ePw1gA+J7
	 pIy7q0xTwE31g==
Message-ID: <563ad5613e9c5f0671e1f49f2d9ba71d8735799b.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR
 enabling
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Dylan Hung <dylan_hung@aspeedtech.com>, alexandre.belloni@bootlin.com, 
 joel@jms.id.au, u.kleine-koenig@pengutronix.de, gustavoars@kernel.org, 
 krzysztof.kozlowski@linaro.org, zenghuchen@google.com,
 matt@codeconstruct.com.au,  linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: BMC-SW@aspeedtech.com
Date: Wed, 01 May 2024 14:22:03 +0800
In-Reply-To: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
References: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dylan,

Just a question on a prior patch you sent:

> Disable IBI IRQ signal and status only when hot-join and SIR enabling
> of all target devices attached to the bus are disabled.
>=20
> Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")

[...]

> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1163,8 +1163,10 @@ static void dw_i3c_master_set_sir_enabled(struct d=
w_i3c_master *master,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0global =3D reg =3D=3D 0xffffffff;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg &=3D ~BIT(idx);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0global =3D reg =3D=3D 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0bool hj_rejected =3D !!(readl(master->regs + DEVICE_CTRL)=
 & DEV_CTRL_HOT_JOIN_NACK);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0reg |=3D BIT(idx);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0global =3D (reg =3D=3D 0xffffffff) && hj_rejected;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(reg, master->regs =
+ IBI_SIR_REQ_REJECT);
> =C2=A0

My interpretation of this change is that we keep the "global" IBI irq
enabled if hot-join-nack is set (ie, always, because we don't support
hot join, and configure the hardware to nack all hot join requests).

However, we never enable the hot-join NACK interrupt - IBI_QUEUE_CTRL
bit 0 is never set. So I can't see how we would ever get an interrupt
for the hot join NACK case anyway. Because of that, this patch is just
keeping the IBI threshold interrupt always enabled for no reason.

Or is something else happening here? Is there another cause for the IBI
threshold IRQs?

Cheers,


Jeremy

