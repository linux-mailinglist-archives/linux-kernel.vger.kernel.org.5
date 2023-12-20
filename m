Return-Path: <linux-kernel+bounces-7179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3F81A2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D82283EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44145405C6;
	Wed, 20 Dec 2023 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrK7lUB6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNDnwMaH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C841209;
	Wed, 20 Dec 2023 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703086248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9iFr028EREK1oaBQImA/7q99uMdsBIIPfU7RbvNNbE=;
	b=rrK7lUB6LfzX/nEgjwgcK2JdTZ32TGxNl2drPcA9iydRGnQv3PDhTYD98rNyOgv7Jn+zE8
	ChdR4MB4G01OyRzty+EYtxMJi1c4kaVZ7lCgneGBxtklbBb4MSyO671M4QRImsIs//jICL
	ERy71snMyJYfFw4kV3X/C7fZatz4sshVLNy9lRVPM2stENbgN62/PywOTAgPN8vl86eIzx
	gIxk02cLEFR4zIDROQe9nPX4sZw13XUWYba2o/PzOByEkbdIHAWRtNUOTSwmpyGXkrfib7
	+m3xy+Tl2GQef32dGnl1P1kxG6nvdtP9Kz4EtA3KxN+qSLVo+K/KDu68x59j1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703086248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9iFr028EREK1oaBQImA/7q99uMdsBIIPfU7RbvNNbE=;
	b=mNDnwMaH4Ca+ysH52LHOg7vmMV5zixgWy1X+kbodEWC0i11zR6uGmMobQG0PqynxQLxXtc
	fDgBEBOiAMsVJrDQ==
To: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>, Marc
 Zyngier
 <maz@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel test
 robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: RE: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
In-Reply-To: <d9556a14e8d64f83b89a2d1d231003f4@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com> <87cyvgsocp.ffs@tglx>
 <d9556a14e8d64f83b89a2d1d231003f4@realtek.com>
Date: Wed, 20 Dec 2023 16:30:48 +0100
Message-ID: <87sf3wlwlz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19 2023 at 03:15, James Tai [=E6=88=B4=E5=BF=97=E5=B3=B0] wrote:
>>On Wed, Nov 29 2023 at 13:43, James Tai wrote:
>>> +static inline void realtek_intc_clear_ints_bit(struct
>>> +realtek_intc_data *data, int bit) {
>>> +     writel(BIT(bit) & ~1, data->base + data->info->isr_offset);
>>
>>That '& ~1' solves what aside of preventing bit 0 from being written?
>>
> The ISR register uses bit 0 to clear or set ISR status.
> Write 0 to clear bits and write 1 to set bits.
> Therefore, to clear the interrupt status, bit 0 should consistently be
> set to '0'.

And how does BIT(bit) with 1 <=3D bit <=3D 31 end up having bit 0 set?

Also a comment explaining the reasoning here would be helpful.


