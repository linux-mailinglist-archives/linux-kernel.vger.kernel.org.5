Return-Path: <linux-kernel+bounces-140026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28C8A0A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E3C2839CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A42914036E;
	Thu, 11 Apr 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SePzh25c"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9213E8B3;
	Thu, 11 Apr 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821863; cv=none; b=q6ohG3p/1HXxZEmcuX82DShpWNVz92AOMz3r8jaTNpjtr+a25Mvrui0F/G3lFk45aKTl9KU7AnHZrHMOz7wDISHq7lgngy/vVHoGpVg/8rCucYBon2ZbOREr8na1Dwsupa1w1QNvQBr8XMu5safvTMAFGbvIDXL1k8v+vPL4S34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821863; c=relaxed/simple;
	bh=ZsULZLEgGVKMZPgs6UyDGKb1w/4DNfFJZe2EIhoDmXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVYABDl4eN4/1DXKOBqRYVy0hWhQu1SW+RkhMXQuiqtoEXXfzcaVfKrRsoGrhUt1ORADRDJEFq6gNeUbH8XoHzmUWN/IfDSdXtueOoZcX7Rc4Y9Csk1Rt4dIrCH6H3HAnmE4LEKlVFguWB+aGCWpfYLmi//NVv9D3cMDAEL/u+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=SePzh25c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712821857;
	bh=ZsULZLEgGVKMZPgs6UyDGKb1w/4DNfFJZe2EIhoDmXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SePzh25c5fl5Kft4nT0FiQ5YDVtvVSvV7El9m1omlZPz06Sb75Hc/TrBQ7WykD+lx
	 tA6Ub9JsUxd2RWdE4+vmdFrNcH9k+T2yDtwMyzUdPjcyKW0qryO2lMAKsNYTXxFgcq
	 vjaqB/hbyWmCA+FJb6EzIp8IHTsrgw5HsbN6GBeIABsTQmaRgwaQjPQQGYBAdZp5yh
	 +9v5RA94JgkvISNIAbLm+byHFka1GrsqP9ntCmR+k5jAVuom8ckkfDiu/iRjYZdfrW
	 cg+ng16KWp30olpIYj3g5iZayAho4Lo8nCTqIJ1Rif77/GKljQk6UO3tyebjTu4e+j
	 kNXYlIeaaZg5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFX1r6452z4wc5;
	Thu, 11 Apr 2024 17:50:56 +1000 (AEST)
Date: Thu, 11 Apr 2024 17:50:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20240411175046.689f91eb@canb.auug.org.au>
In-Reply-To: <CANn89i+fZdLA_54GwsoY+UV+C=0KP-S6pF4hWmOQ8ajBKUC54Q@mail.gmail.com>
References: <20240409114028.76ede66a@canb.auug.org.au>
	<CANn89iJyXNKycL1kd_KP8NH-qU7siv8BGW5PGLexjmqaXXGciA@mail.gmail.com>
	<20240411113835.713ccf11@canb.auug.org.au>
	<CANn89i+fZdLA_54GwsoY+UV+C=0KP-S6pF4hWmOQ8ajBKUC54Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o8cLahbTJCLLG8oEx=k=9tv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/o8cLahbTJCLLG8oEx=k=9tv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Thu, 11 Apr 2024 07:33:55 +0200 Eric Dumazet <edumazet@google.com> wrote:
>
> Do you have the fix in your tree ?
>=20
> 9b9fd45869e744bea7d32a94793736e3d9fd7d26 tcp: tweak
> tcp_sock_write_txrx size assertion

That commit has just turned up in the net-next tree after I merged it
today, so this should be fixed tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/o8cLahbTJCLLG8oEx=k=9tv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXllYACgkQAVBC80lX
0GwvFQgAoAaxNXlmyxleST/qMihIMvIUUd8QA4wh1iQmWfon/A9j7dQIN5tjDCwt
hRMLhpPFU+5wJugLNk7OToH7WVYkSA1fda+kdCt72Fm+0KnC0hs8pdaDEgAW9uct
Bm4uJh78MfoBOc8W0qBOSiEpXWx8sOytSJcbs/zSP4Z1GsSqIQ2r7Op8ZmGpKWpv
0WimsL8C7BViC8UlAsBpaBHehKkqHtRYDPp0PKPtQ3zoMCORzUchq5ALFk8Nv7Jy
Xw7uNFDtFcaZJaJUjHsrOyKXz681fQsTimbZ8MBfuuvpqKZClsZboo2qBRrTM60Y
VuVBogCy1KimkhKY8lqgCcmCsFzj+w==
=kven
-----END PGP SIGNATURE-----

--Sig_/o8cLahbTJCLLG8oEx=k=9tv--

