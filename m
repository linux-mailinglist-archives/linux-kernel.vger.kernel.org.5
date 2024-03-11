Return-Path: <linux-kernel+bounces-98841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49A878023
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9674A1C21698
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20243C08F;
	Mon, 11 Mar 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="VgqSjHMr"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2E1364;
	Mon, 11 Mar 2024 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161294; cv=none; b=ARaHpFv5Uv2plXOJJMtDH6HbTHgoIrYmURM0JJgdQl2cs+77lgD1ubYN1ac+Xr1YE7V3uiqvivPGgxV2fJL9Il3mtnVRfOvbphcTuNEIEPvZvwISJk8yLILgPDePICcKOx2atqAZmv0cIgcSiYdU8EuOPRJOQzhpbKzCLO0CsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161294; c=relaxed/simple;
	bh=U57Hk+dBS1y30YHhm431gGyozho2mBlgztMRDZ59myc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahSR6Pwi5dcDlLd1DhmGRMVX1HnHZuLuhbRbURA4u0Daf0H2iUH6QjH5QhEW/6OkfS47f3s6f2tDO7effr9gksILfWrFhrTS4c2Wg0lJ/xzKCwZVetFSL+oT3r3t6Y8FkXJchaLFASi2fnoZZlPwcuxHw8tlXxf4Neim6Oqt8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=VgqSjHMr; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=heusel.eu;
	s=s1-ionos; t=1710161263; x=1710766063; i=christian@heusel.eu;
	bh=U57Hk+dBS1y30YHhm431gGyozho2mBlgztMRDZ59myc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=VgqSjHMr+haZtw0jZRKEgE/69AQYEB9jpDiIXVkbcWi8K5Z5DxDtBpZQAz/lY4VE
	 SDn46RZmzuisUyQX/p0pTlIRw+ejEWZlaZ3BmwJH8eIFUaz6uryXxGoF6An9Qq21e
	 iIwfiHOj20UKM/LbGZxYHsYeVDnx1xnOyb93ks42NhYr04aGGkc8PTUk6uRGJ6sIO
	 fJNlBeiziDUquPL27eOCqbf50m0Wjt6W5CYhYw56Gp42x2JSAJtl2aWgUQhHpVdsh
	 Vxfryyh07ImWnrPG1RRZ0IMvHFCMCkCrUD9+CN4McpxcNN7nc2jdDaJUFIrhepefI
	 VKPWjr1PLab+C1k9KQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([84.170.90.173]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N63mC-1qlzzr0JFA-016QKL; Mon, 11 Mar 2024 13:47:43 +0100
Date: Mon, 11 Mar 2024 13:47:40 +0100
From: Christian Heusel <christian@heusel.eu>
To: David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] jffs2: print symbolic error name instead of error code
Message-ID: <b4oa6jak7f4hiaqcqpmasclaylqdhdzgne75a6nol6z33d4o7z@3soexkn4smz4>
References: <20240211003907.167891-1-christian@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u36om64zlux4crqa"
Content-Disposition: inline
In-Reply-To: <20240211003907.167891-1-christian@heusel.eu>
X-Provags-ID: V03:K1:cCA2v6Yl7qVfchXCjmjHzHof0YuIyG8VnO4ZV42PYUgerHlw0Df
 C6Hi5BO1rlTOIcq4jNJVRXDdBBW1GWR6+Vb/6LiRQ9HMo32hbEiwuusAKfD25W4D9g3LtDj
 CiWY56wH80/xA3fgHUBh/xh6FBgfHSlTu0xi9S2dDYOnH4PFTbQ2/j0b0F8jaG5EhLP2CNc
 Pvye80JhDGlrJLs2SL1ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TOIz44WZJa0=;MyS8RxB+EdiCl7XJkSIX7TNN68R
 QR0+dCPy7Ia6LsNvV4aH8k8eImoWzIgIkgkLxtx1w1aNxkX2AMEw3y4AnTdYij7QaSEmmyywq
 C5AA7lQJz/H4Vi4TTuXXpe5wAororgN+gXaDULqCOSaxnj3lAEKzG5H4ZhYklAKwGY6bthTpU
 aHuBDO6wf56WnGtyjKLaeljkfUuSGQdnJf8A5OuexRyNkc66/pnjSLcJnaw0ldGz9ARbxbKp3
 D09DfMkwtVFXAFlftCPqkMxNfgBCsaoAwmLod4w6CFtKJo/EOHl6WUlEHRVmbNUgouxDKLGZv
 wDNDv1fkG8lUqR+GFRXjpzeJVwOPEXHKWW6fmbKgfZNOQFoGrc8m4ImN6VuEbKfm8zFNPKQf9
 YHt5ABl9GSZ7PxbCWrne6PLC9XdD5HHQ1tYPXAOUOGA94+ko4x4XBcnhNu7GHPaLKMwnCuqUM
 b+TAc4cKUN58gCkKwfAIFd0/Kl848UphxeepAog3UAgmfboa/SRvYxiFUfVsh4z65QjgNUi/V
 Uvc5XtMhXKtV+U8etV59FhcdclLYAUpDAQPYuE9bGN8Lh4b7RZniCWt32NM0Cgr5HG4HFLZ0b
 2KNJLNES/R29kw2kNm9u35/lMU2vbVUld3JoiFC/7nQ0CCCsITvGeDqexBC4AfMH5TcTaDncI
 FxODoaTTpU5fZMvSIxTkAf8IdrR6bfrhCnu4l/MpT3FdGKGowcuDyKE+3mFZZjLaAknXpjwTo
 W/Pj4vQLFRT32dJNqIjkKQYFPMgfIco42ZQzWOsJt2JrVG3KsbGzIM=


--u36om64zlux4crqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/02/11 01:39AM, Christian Heusel wrote:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
>=20
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mo=
untain/
>=20
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
>  fs/jffs2/background.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
> index 6da92ecaf66d..bb0ee1a59e71 100644
> --- a/fs/jffs2/background.c
> +++ b/fs/jffs2/background.c
> @@ -44,8 +44,8 @@ int jffs2_start_garbage_collect_thread(struct jffs2_sb_=
info *c)
>=20
>  	tsk =3D kthread_run(jffs2_garbage_collect_thread, c, "jffs2_gcd_mtd%d",=
 c->mtd->index);
>  	if (IS_ERR(tsk)) {
> -		pr_warn("fork failed for JFFS2 garbage collect thread: %ld\n",
> -			-PTR_ERR(tsk));
> +		pr_warn("fork failed for JFFS2 garbage collect thread: %pe\n",
> +			tsk);
>  		complete(&c->gc_thread_exit);
>  		ret =3D PTR_ERR(tsk);
>  	} else {
> --
> 2.43.1

Friendly ping on the above patch, since it's now a month after sending
it :)

Cheers,
chris

--u36om64zlux4crqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmXu/WwACgkQwEfU8yi1
JYWNaBAA3O92OboqsUyaSWRqJ+1aXC2lC2cHWCQnaLE8/tlW8wIlA6FPrZKkO6h3
TxxzZo8TPzpZgaUzkOlZps5CjOYQNzx1axbm2WXkrj44oHbmavq+Zj7ehSjdvwMW
P5foTpyJJt6mwBgaKv8I3WIR8utjV8AyMLsjPtSayYcvBtsmZxJyPcY38On7JuSH
mNegCXTkBorj2R3Rzm8ijWCIA39Bc5HCpdk03cx8T2+2+3BcTZ9HH8nFA+qIXd5H
wTN+iQjdxHE/+yMqaExoRFWM5C4lLk5ub38j2d2VzBY6sIfDBzGmwRcfmapofAsG
tj1NyYCB2Oe1dA2cr5BZ7CrIh5CTHRPSgOMSkJIItet0jmTrtyndfocmsSEzsKoM
A/QC0bGK8M/7APTBjY5YY6FFBpZlIWkfCP2cdk/EmYuPLhU+UuJHdl9difcIClik
nmdptzAGu4uBsHqDQShnTxPUkaGi4geeY5QM2ylxtYIsd0aH198GDF6BO26UPRmg
c8r0RcqTJ19Jeyb87waHKDqejKlkMFm1/tM5LU9U0aGr43TmFJ6Xky5YJ7hOp5Gr
ZAU7gUXUwXmB0qs96+Hl6lU4PISIkb8FPmqYLRf57mxMhSyRuz7k1fyYlstzfGCB
vwIkWhSLK+/ZYmSsyumqyhCOxdtT+QWpMJfA68OQcvlv7cRqUqk=
=EQU3
-----END PGP SIGNATURE-----

--u36om64zlux4crqa--

