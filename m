Return-Path: <linux-kernel+bounces-96012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5A87560B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7772830F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648221332AA;
	Thu,  7 Mar 2024 18:24:44 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE562130ADF;
	Thu,  7 Mar 2024 18:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835884; cv=none; b=LqyBvsGm9fwvVDOk5EF39eRCNsBei5r8n/l6uQct+hyJjhyTJACVnC8WJuC9xkSPsXZIlRJnJc3NOC6dZbIF8AKbW+oZ0kAWu1tHM1Jumgl5qwN/cRrZdEAIFFcsqBGQdYxhZ9F9DkusGhJt7TEcjDYBLRta8TDiLE2l3UD0CDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835884; c=relaxed/simple;
	bh=bmMfawzjcrQ9urG/fPu4rua8NJxWPKOC1ywnVzCVBZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYmsDdbxE8XEJxuuqXTRk3oKxHyl60KPkxPaCC2oYO6/C4jAlcqpNG8Tl11zxeaz7XH8+bbPz3x5ITUXc3Iel+WIjUaECJz8++foXGlB3R0EpdT6givIdbi5T93zL4QKqahNIbaIGmLqailncdmN1VXo49SXzrdaAwTNR53bUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1riIPl-000qCZ-2r;
	Thu, 07 Mar 2024 19:24:20 +0100
Date: Thu, 7 Mar 2024 19:24:05 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: jonas.gorski@gmail.com, deeb.rand@confident.ru, khoroshilov@ispras.ru,
 kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240307192405.34aa9841@barney>
In-Reply-To: <20240307134142.169523-1-rand.sec96@gmail.com>
References: <CAOiHx==HHd3Nu=p5192=tOP-kAzJZUg2iRO2j8UCtcpfGT13nw@mail.gmail.com>
 <20240307134142.169523-1-rand.sec96@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EICs9rZNMSRHQGfY17PNDw/";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/EICs9rZNMSRHQGfY17PNDw/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  7 Mar 2024 16:41:42 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:

> Given that null is improbable in this context due to the calls being made=
=20
> through uevent, we should eliminate the redundant condition. In light of=
=20
> this, would you recommend sending a new version (v4)

No.

We should _not_ eliminate NULL checks in this code.
Ever.
There is only one reason to eliminate NULL checks:
In extremely performance critical code, if it improves performance
significantly and it is clearly documented that the pointer can never be NU=
LL.

This is not that case here. This is not critical code.

Having NULL checks is defensive programming.
Removing NULL checks is a hazard.
Not having these checks is a big part of why security sucks in today's soft=
ware.

V3 shall be applied, because it fixes a clear bug. Whether this bug can act=
ually
be triggered or not in today's kernel doesn't matter.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/EICs9rZNMSRHQGfY17PNDw/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXqBkUACgkQ9TK+HZCN
iw7FrQ/+LHJe8g6BkVKrdLKc/L7rLp0XojDoW643xNMWUXyFLCQ8WnsmkFrr2Co0
re2MKcdhCNfJPxj4A2ZMEr9ASFjll6jvqHGotdgsUHFQ0YPa+4ZLXdKNKaPgDlYp
CoBs5sMNRGPtMFlh1g1U4R92cAMoSEvuj+nXEx8j+MA3dHT3fy6aPXAofVwOlwOr
t9iqAeNMsR+kSf4LLKNnv3r5WmXbuWC3bMe72ESpCtExuvUkQ0RXuBBdInPXPSYC
+yu5uITrNjxMzyydYo6Kkr0pksO8yrNjLQaCbIhl1xKz/KO92ye7QivRxlGqyOQZ
mRE/RVthmZR1/l2HpVFgkvAlFYIEiWfLU2MJhgPaAWfPNP5gAaxrw3At0nkhx3Tf
8C8asZeKWds4eMu901VOzEO2jqDiAtjSMEhr+i4fP912DhP03HdXXYhI1Stl4wOu
yx7dwOkuR19IwlGVSQ1cqKkI0a85i2oY5R7Jtub1Tujm1w23KCde/GlPIB41sepe
2N/7xOaNrJZGuKnuUgeazcdLhOhenO6SUwnC1BZYkTEtxekEGxDMby6GBqnWdwdN
H2RNnbwq5BfP3V4N6+gVSOk6Td1hFMubD6rUozgvEz/xaMYMo6GF/T/WxhTpjMQ/
/uuwUDh9HHe/pgcnbyeUYllyKDaW6xAE8CwVpq8WGQurQ3I9+I8=
=ZdG7
-----END PGP SIGNATURE-----

--Sig_/EICs9rZNMSRHQGfY17PNDw/--

