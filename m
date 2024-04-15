Return-Path: <linux-kernel+bounces-145224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99678A5113
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C42B234C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B022812C47B;
	Mon, 15 Apr 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uG90ffqy"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2412BF38;
	Mon, 15 Apr 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186478; cv=none; b=p8yhS8C9zIjgvW4WGUz4wB/q46QWJQFs430g0F/WozSg21UZS6RX9fxp/7op8Jf1VXvFlrSfbSEoZ8iDC0+nl/RMmCVd6nsOb5LR/Z0Gne8HtKpIMQuHFwa14Fg/cZ3aNqaBZmZXXpJI5U20E/EwPdWTsfranCrwQCqBXweqLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186478; c=relaxed/simple;
	bh=sLmgag4Ktuf2ouZPmlzSHrzVjlVxXMA7N+Uq41q0BzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnUVrwz/yTF9s6wkdOHUhW2onv1IkbBlu9zHqEWW0UBLXYzOtEiyAyZGVKaeakXpxZCXnyijNUSZOT3xIyX4d2/o+0Y9m/01PKD+TVAs3kUwUESqLg1YN1R+vgXHiUo14aiHuMubyPlPhltWU9XmTnLjWkCPaKd2KtX+IFClWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uG90ffqy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 61D6C88158;
	Mon, 15 Apr 2024 15:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713186471;
	bh=EZgCe8MC6ounYgKhKrs9TKuCFJBcKGHgVbUqPP0dKLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uG90ffqykF9WqGbnq6FlQvywALad7kxsgS2ERfVKe11Fl54AgfevRZoYyUNJAjLA7
	 PCeE2qbJ6ymz5LwazuqMHpM6FNxHJcc+MJKLkA8xd64zo0jx6w3VjCfd/RtpWgcPnJ
	 kDfBJCdp6QpsHlFKRL/jreaJkutZGiVoqZbkS/MWVigjiCVn+a+dhC8OfCWWgRFRNr
	 hqp6aB1GnrZFZbyEoBOXD7rpwAhUp16zqTAv+RqnBLsVMM789mJYyOmHTBkL3eBLsk
	 e4S7NnN7+fy+rOuBaz+wXuSydCYBgpBxW6V516YYbZimkAnShKAzomBysW7tYXJG9k
	 onAIlgMgB7Pmg==
Date: Mon, 15 Apr 2024 15:07:44 +0200
From: Lukasz Majewski <lukma@denx.de>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v5 0/4] net: hsr: Add support for HSR-SAN
 (RedBOX)
Message-ID: <20240415150744.5992b27e@wsk>
In-Reply-To: <20240415124928.1263240-1-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8g.6qsssst/iy6d4SlJ5m5h";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/8g.6qsssst/iy6d4SlJ5m5h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> This patch set provides v5 of HSR-SAN (RedBOX) as well as
> hsr_redbox.sh test script.
>=20
> Applied on top of:
> Branch: net-next/main
> SHA1: 50aee97d1511
>=20

Please be informed that without this patch series, with the current
net-next (with above credentials), the hsr_ping.sh test fails, as nodes
are not merged, so duplicate HSR frames are not filtered).

I'm going to investigate this issue now.

> Runs inside: Buildroot (2024.02.1+):
> SHA1: b31443e09cb7bb67b97ae6fb7614fe3a22889d50
>=20
> Lukasz Majewski (4):
>   net: hsr: Provide RedBox support (HSR-SAN)
>   test: hsr: Move common code to hsr_common.sh file
>   test: hsr: Extract version agnostic information from ping command
>     output
>   test: hsr: Add test for HSR RedBOX (HSR-SAN) mode of operation
>=20
>  include/uapi/linux/if_link.h                  |  1 +
>  net/hsr/hsr_device.c                          | 36 ++++++-
>  net/hsr/hsr_device.h                          |  4 +-
>  net/hsr/hsr_forward.c                         | 85 ++++++++++++++--
>  net/hsr/hsr_framereg.c                        | 52 ++++++++++
>  net/hsr/hsr_framereg.h                        |  6 ++
>  net/hsr/hsr_main.h                            |  7 ++
>  net/hsr/hsr_netlink.c                         | 30 +++++-
>  net/hsr/hsr_slave.c                           |  1 +
>  tools/testing/selftests/net/hsr/hsr_common.sh | 97
> +++++++++++++++++++ tools/testing/selftests/net/hsr/hsr_ping.sh   |
> 93 +----------------- tools/testing/selftests/net/hsr/hsr_redbox.sh |
> 97 +++++++++++++++++++ 12 files changed, 403 insertions(+), 106
> deletions(-) create mode 100644
> tools/testing/selftests/net/hsr/hsr_common.sh create mode 100755
> tools/testing/selftests/net/hsr/hsr_redbox.sh
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8g.6qsssst/iy6d4SlJ5m5h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYdJqAACgkQAR8vZIA0
zr2J5QgAo2/LHZUNbBwSVHZargWXl0pSmEZgIcHDlE+AHT4x4zrERGmEBYNfq8Ue
O6CbnloM2VEEswtUbcKJTrXDjHaBYM1ezgwfjyafhgndvhDK0QdahT7oie0S3XXX
znq6E/8CoMLpWuwOhcUo6v81V3+Lvnk1h7PD3I4MdSJ5bfu4tUwl0RIWQ4neqj6T
HziXcTXV7On3jxDY+0bgO5WUr/ogWSfIaMXC9aSjfY0nU4aA5LEtfZa7BxhfiVLu
wYA8IWnlBf8GQY81Y5wLtoZHBTXplDDcTbzt4gtpwlEuU7b4WQkrenal/kADXQH/
w8Lcjlnpu0/XSWBfvnKKHQIHlTvNjw==
=ZX/5
-----END PGP SIGNATURE-----

--Sig_/8g.6qsssst/iy6d4SlJ5m5h--

