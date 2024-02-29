Return-Path: <linux-kernel+bounces-87304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEB86D278
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023D51C2299B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCA5134401;
	Thu, 29 Feb 2024 18:40:33 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A160629;
	Thu, 29 Feb 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232033; cv=none; b=lxUzGeLqQUIySs6IDnd4EChgPCKbZ2ViOsS93dVX1Snvu7rtYmzHtmkAyJHPXzY5872noTTccxmxADWZulnZLvRaR108R7/AhNzg439tjjUcRvPCx8ZbdJ5AJ0yfnwyK29cvg8JukIX1JedC7dFuLGLCn4JGgjOQgOgSm588M0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232033; c=relaxed/simple;
	bh=UW+TdciKB5gSR3r9g/ate3m4F5PvqE5YslCXW8lrDB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzqqzIREYIgV9z4AqVXaG2RJsHcYtT3gbQCNcFLXCU6L9V4OZScUr82D8CYpn8YqvbZcfPcUEAGjH0X6RmQ0mkKLwZxQjkQOG3IE1URZGTK+EbvxXnnQXVbQDUvgz1nbdgitJBXY0Gn6tzi9urdGJQu9EmSGmOT9AGBi3Nnsnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rfkqo-000F5s-3B;
	Thu, 29 Feb 2024 19:09:46 +0100
Date: Thu, 29 Feb 2024 19:08:54 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 deeb.rand@confident.ru, lvc-project@linuxtesting.org,
 voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] ssb: Fix potential NULL pointer dereference in
 ssb_device_uevent
Message-ID: <20240229190854.3717772c@barney>
In-Reply-To: <20240229093756.129324-1-rand.sec96@gmail.com>
References: <20240229093756.129324-1-rand.sec96@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ob.XXZ=76OiP5u+w1/NKFuc";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/ob.XXZ=76OiP5u+w1/NKFuc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 12:37:56 +0300
Rand Deeb <rand.sec96@gmail.com> wrote:

>  static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env =
*env)
>  {
> -	struct ssb_device *ssb_dev =3D dev_to_ssb_dev(dev);
> +	struct ssb_device *ssb_dev;
> =20
>  	if (!dev)
>  		return -ENODEV;
> =20
> +	ssb_dev =3D dev_to_ssb_dev(dev);
> +
>  	return add_uevent_var(env,
>  			     "MODALIAS=3Dssb:v%04Xid%04Xrev%02X",
>  			     ssb_dev->id.vendor, ssb_dev->id.coreid,

Good catch.
Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/ob.XXZ=76OiP5u+w1/NKFuc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXgyDcACgkQ9TK+HZCN
iw6qKg//T18rCQhWWnilcYj4srdCKlazbrCftkkAQSu680rHZXaMTlgLWeNKxBve
TUf2P0v7S2d6BDpoNiyixNkYiJX0VyhXPQRUvmqFMhP+cy9zuWMrvLLBxgGRzuh/
XeKw9Gnwhp+KQNsuE9MlH1JC8T+tVQxvpBvyxNdHGL3UWi9+xRgNnRtRkc2nWTBO
7x4hMpYNmE+NbyIwoj4ps2+wruvzTvAQnaMNtwcyImBKd/J7fE7FPRVqP57+xR+C
bftMfFV4xn7rArpU+Pg+8wEryOUIhPJ9ZmO/CLejkjaE2qoy7PP4sZbdcCSeMxak
w10uZ1x7veeNspxNEMSKTjuvRcKJgg0x2eFKFhLbTnJg9D60yeDVTK+9S/QVHpXa
frndJ8VCxjMq2+bY2sdglOZelAtAh9PQzLgma3HlRvwe6zprWZdmexih06oFV+kW
4vQNus9qhZxCl7Wpxap/OlFwdgINqU/J6VDAsnt0wyMd1kdGXJaZDXeKAfY/a6B8
eM//hyWbJ+axLvtJxbnZOCUffy64yqGLJMYUQi9dfAriyDtIozRP7vGsqEDlhVTP
xz4PlzWuoEyzCAF9DBQ3hYxihCgGuOE9bGXg8dG0MPTw8V1XjigKdqPJyWETi43o
PJGNkPWysXXCE03+KAmvpz3VNYGBFRy7+YiRUC6bImGqMaszisM=
=8bGs
-----END PGP SIGNATURE-----

--Sig_/ob.XXZ=76OiP5u+w1/NKFuc--

