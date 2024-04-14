Return-Path: <linux-kernel+bounces-144077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EE8A418F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8A1C20E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510E23763;
	Sun, 14 Apr 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="jwsMwK1Y"
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B27F6;
	Sun, 14 Apr 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087657; cv=none; b=Sga900tZvevbI3YLFGvSbe047wVHT3Cd8CoewukQi/Xada4MR5o5NfKCrseJhtnrLCJIBiKLOhlBvkUkauItybD0DCD0LmI6/JKhR4GNz4J7T/gzebKesLfWVN2KOldRKbMVyz1kNSqs246/D5NFOkTd0J/cXBWsZmScF1rhbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087657; c=relaxed/simple;
	bh=zfly3FM9Zmtz9b4Sf8VOCb65/n/CcbTfT4PPF848rF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulI3aB92R+kPKvma11FYa2p9WsQoqHUyW+hI3whhjfVJcGhZLjvbZgMpT8tqrpVJnkdEp4NTSJwq8nb94x/BSye/wUmubSFJ/p/ServOPQ36kB/PYsZkuGazLqH6gO/l6AyZ2oPqSBmurTHX/NwBXvtwP/d60N2gEG412CaWHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=jwsMwK1Y; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id 8DA7E60A5D;
	Sun, 14 Apr 2024 12:35:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id xYa6unUpCuQ0-Zp8VmDkd;
	Sun, 14 Apr 2024 12:35:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1713087300; bh=o9AJ3yP3PfZsOaTh2FRaZBCX4GvpAWuvCoCyIb5L7CA=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=jwsMwK1Ytg5s5HlEeZoOcwy6qmDPP+dDwQLXav7OgdjvQSDLSjixTtHhfslYEKT7f
	 mI8q2As0a5DARt1YI+U5V72CdQKxwnQ7IScZPjzDK8fpjOz8dA+d+0D5FrSoZSSSb6
	 OBHd2VuvkyP2lToV5Vu/4hEyGog9g4ZLq9yIKaIM=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <1133974853f647ce1e575ac064e90fa852ce535b.camel@maquefel.me>
Subject: Re: [PATCH 2/4] clk: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette
 <mturquette@baylibre.com>, Nikita Shubin via B4 Relay
 <devnull+nikita.shubin.maquefel.me@kernel.org>, Rob Herring
 <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date: Sun, 14 Apr 2024 12:35:00 +0300
In-Reply-To: <eea032865f00a0d54b99bbe66d4b6135.sboyd@kernel.org>
References: <20240408-ep93xx-clk-v1-0-1d0f4c324647@maquefel.me>
	 <20240408-ep93xx-clk-v1-2-1d0f4c324647@maquefel.me>
	 <eea032865f00a0d54b99bbe66d4b6135.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Stephen!

All notes taken in account, except:=20

On Thu, 2024-04-11 at 02:32 -0700, Stephen Boyd wrote:
> Quoting Nikita Shubin via B4 Relay (2024-04-08 01:09:54)
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D clk_hw_register_div(clk, =
"ep93xx-adc", &xtali,
>=20
> Use devm?

This clk-ep93xx internal function and it uses devm:

```
static int clk_hw_register_div(...)
..
	return devm_clk_hw_register(priv->dev, &clk->hw);
```

