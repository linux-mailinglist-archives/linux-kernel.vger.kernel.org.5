Return-Path: <linux-kernel+bounces-1131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C7814AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFBA282989
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65986347D1;
	Fri, 15 Dec 2023 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MeAeZ9JA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98381A596;
	Fri, 15 Dec 2023 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC8744000D;
	Fri, 15 Dec 2023 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702651646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1J0bCvDA9ePbUryRQa9+lEgPlGKphXrC4KMBwQZyN8=;
	b=MeAeZ9JAg5jaFL3PtM0rjGTUefHj3GhrVMudoTlujQ/QjM6++3s8AQF1qYkZsFc0gXU1xO
	z+DrFsBFOHON9PGyi0vp7p4o+TPeHsPokNSZ+8B6p/zAt65/p+91nuA8HcJqJf27FsNolZ
	ZTR0iwK4tVgOEkitzo5rHp1U/b7JYkNtfb6/n8iXcK6yV2y/iuJrTi6XSVQj8FKrURFkBO
	uw5IoJN8yeHJYt/04gPDIgpkzN14z36b4Hpeuzn1PZjjNKqZHjYkK6bBwPxw+lFx0m1hVs
	vYiq8jHfCzDwFFZXKFSZXwAiQ40TXHr8qXjn4Ns184DhbgauyHcHNxABuc4Cvw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc: Sjoerd Simons <sjoerd@collabora.com>, kernel@collabora.com, Andrew Lunn
 <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Moxtet bus fixes
In-Reply-To: <20231208161724.5f4f626a@dellmb>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
 <87fs0ceoif.fsf@BL-laptop> <20231208161724.5f4f626a@dellmb>
Date: Fri, 15 Dec 2023 15:47:25 +0100
Message-ID: <87fs03cyki.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Marek Beh=C3=BAn <kabel@kernel.org> writes:

> On Fri, 08 Dec 2023 15:51:20 +0100
> Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>
>> Hello Marek and Sjoerd,
>>=20
>> > It seems the moxtet bus support was broken since 21aad8ba615e ("arm64:
>> > dts: armada-3720-turris-mox: Add missing interrupt for RTC") for two
>> > reasons:
>> > * The moxtet irq isn't marked as shared so the driver fails to load if
>> >   the rtc driver gets set up first.
>> > * The dts change didn't set the IRQ type, so in case the rtc driver got
>> >   probed first irq setup ended up wrong (rising instead of falling edg=
e).
>> >
>> > On top of that the moxtet module isn't auto-loading due to a missing s=
pi
>> > table
>> >
>> > Changes in v2:
>> > - Add cover letter
>> > - Add patch to set the irq type
>> >
>> > Sjoerd Simons (3):
>> >   bus: moxtet: Mark the irq as shared
>> >   bus: moxtet: Add spi device table
>> >   arm64: dts: armada-3720-turris-mox: set irq type for RTC=20=20
>>=20
>> I only received the previous patch in my inbox, I plan to apply it. But
>> what about the 2 other patches ? Marek will you do a pull request with
>> these 2 patches or do you expect that I take them also ?
>>=20
>> Regards,
>>=20
>> Gregory
>
> Gregory, as of yet I've never done a pull request. If you are willing
> to take all 3 patches now, please do. In the future I would like to

OK I applied them on mvebu/driver.

> start doing it for Turris stuff, if you are OK with it.

No pb, just tell me when you are going to doing it.

Gregory

>
> Marek

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

