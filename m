Return-Path: <linux-kernel+bounces-96523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 498FA875D79
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6481F217E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0663612C;
	Fri,  8 Mar 2024 05:11:04 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988132EAE6;
	Fri,  8 Mar 2024 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874663; cv=none; b=evROyZ3HZgQPdl9lugrXom+sW90guUV7hDEA4szbOgv5kbC/T72dU2v5PoulsQ97t7nbuf9O8rVlGwcA6erszOGbEo2vTBocLFMd5qn+5jETTT+P8PXCSuLck08pUEYE5GyQpd1hC8kVu8emv1S4XGFhofIwXMC9UqLzuCPOjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874663; c=relaxed/simple;
	bh=7c7DCl5tHRd02QLwo//WwbvkDNPX9svF1WEwOb1bLwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHl1vgEzXWq6Yh4UR0RB8o1XtlkNPqSPwsTnAvzTDekzgeLuY1qF9nrhntajlLtS9xj7OdzF1lKZ0ofoAx72CJdEHQNjFtAbPfmNRCvqZNY3Wh/w2K2QVRa84ZjvhwHrlQ/KrbAXmLdeetCYzy3pjJ9R8iOa/5IDD1dcRo0Lho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1riSVT-0006Q4-1x;
	Fri, 08 Mar 2024 06:10:54 +0100
Date: Fri, 8 Mar 2024 05:50:49 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: James Dutton <james.dutton@gmail.com>
Cc: Rand Deeb <rand.sec96@gmail.com>, deeb.rand@confident.ru,
 jonas.gorski@gmail.com, khoroshilov@ispras.ru, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
Subject: Re: [PATCH v3] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240308055049.50a830fc@barney>
In-Reply-To: <CAAMvbhGmu5VtkA=KnxoHr=Fg_4=1yHFP_SERwKD_rxH=jpM1BA@mail.gmail.com>
References: <20240307192405.34aa9841@barney>
	<20240307211928.170877-1-rand.sec96@gmail.com>
	<20240307223849.13d5b58b@barney>
	<CAAMvbhGmu5VtkA=KnxoHr=Fg_4=1yHFP_SERwKD_rxH=jpM1BA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rhyzgt75tD3LaJRP/HlHUF7";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/Rhyzgt75tD3LaJRP/HlHUF7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Mar 2024 22:02:29 +0000
James Dutton <james.dutton@gmail.com> wrote:

> If one does a NULL check after it has been previously dereferenced,
> the compiler will totally remove the NULL check anyway,

I think the kernel uses -fno-delete-null-pointer-checks.

But anyway, this doesn't invalidate the point of having a NULL check.
The intent of the code was very clear.
So don't remove it.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/Rhyzgt75tD3LaJRP/HlHUF7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXqmSkACgkQ9TK+HZCN
iw5FQw//bOaVLWgfyhfI4G/Yl8Syd1+U+W3zc5f7fIpIbNGqn7UnWyWhgb196In1
knUBwNb5lyCmjtSBnMxl3xrm8LatJgwFnFk8sVjbljGrEpdL5pVTrABdYQA5d6br
xZOWm7vFQWTGLTNdvjmLP6CqF96yVCiFMyCtQ8xnOw0zplPFnG/kO3yz5t/hFxER
2JHGwdJMatyBXVyPjFqkKOdU0+i9heOUvvwTfcQby5kbaP8r2iPy4JEewnCQLQEV
DCvUyOE6Gv8PNDngX9EcMyxoBe7teYDxX6wWlVx9eldRVlATl0g2Qgl52PPh8hAE
dr8UetddVgX7yA2VwZT4IYfL1tu4GAd+8DjPh98r79V28DrmRcnxE+eGM0mCfTaJ
TwLDSd9UGPTe1EDBqMkNG5JtpzNHKaFAz84HOUS8bf/QlQtOBnZUo9c4IPWtWdNv
mbqAd5FgVEfjRpCSyJ8A5ty8lplQH80ORx/z8ty7Rpp2JqYq6yyrGhQkU42IEH8D
WJvwoWEh7yyluL1o1J8p0xwMI+OxTB36uCb1EkuV2jEjfBjOWhYXr7BEQtQBRBs3
6GH2UKmL5h0nVhGsKXgo0vUIPFeG+jpG1wGaSPtyUBn/xo+JU7APxpNOCob12DhH
1umDjHtUlf1K0FZ6sfDAa5FMIvCwsaKRyrxbfiqTY2+gi5Z1wAA=
=3Ich
-----END PGP SIGNATURE-----

--Sig_/Rhyzgt75tD3LaJRP/HlHUF7--

