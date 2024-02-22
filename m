Return-Path: <linux-kernel+bounces-77017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632E86001D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322D128D0F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53D15697E;
	Thu, 22 Feb 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZzVGYOK7"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B30154BE3;
	Thu, 22 Feb 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624365; cv=none; b=eIBUQEdbWxs7dOpR/pjMxc2r7Wx6j4sbiPDnCioybjB9u+DuTbKiteKi1RiQgYQs79LeBpT8nkjrzVsLsdb1kPu8jdT5iX+1wO3uWTtsUmLuJrkXx9lUv3RFHqUkkJ5ZF2u8d5yRIgCMs1Ie0eFVPer9Faac25KCGLdMei0f3/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624365; c=relaxed/simple;
	bh=NaTf6aZ2x1S1ath2Dexnlx72zrc073aoKOZ2c8EsLK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM0sTT/xU99ahJjerlcyJTjzjCklEANK6QsspCEw0a6i9euuvRzH7WG9MQDfBcIN1+/F+fETI6ypTYSTT/bMApQgET/gNmYgdzweMorzZKTARYO+49IDaLrwKHHL7yvKZ67m9myCX295YAcSaRLJZU+RT5Eg3ZkZcCIbfPXP5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZzVGYOK7; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4D55D1C0080; Thu, 22 Feb 2024 18:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1708624361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgaZB3SZMoEm9PLi7mMzZRU1B6wqFrPod6EkwKRjRo4=;
	b=ZzVGYOK7E/NNZ7Y0k17U6riqoM67HDxzV6hUt95CBUqilcDuL8/LIdy0M3gvhhO2kGe8Bl
	YT/zJJ0l9B2K87MNHPT2zkbavTw5pVb71w4Ri5CX3CUYflVZZzDgXIrNfoe6zFeqCLVqNo
	w7wZNZ9nYdDmnQmv3llexMrpOtxwMSw=
Date: Thu, 22 Feb 2024 18:52:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Gregor Riepl <onitake@gmail.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Lee Jones <lee@kernel.org>, jikos@kernel.org,
	linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: Future handling of complex RGB devices on Linux v2
Message-ID: <ZdeJ6OV6iXTLSfzt@duo.ucw.cz>
References: <9851a06d-956e-4b57-be63-e10ff1fce8b4@tuxedocomputers.com>
 <1bc6d6f0-a13d-4148-80cb-9c13dec7ed32@redhat.com>
 <b70b2ea8-abfd-4d41-b336-3e34e5bdb8c6@tuxedocomputers.com>
 <477d30ee-247e-47e6-bc74-515fd87fdc13@redhat.com>
 <e21a7d87-3059-4a51-af04-1062dac977d2@tuxedocomputers.com>
 <247b5dcd-fda8-45a7-9896-eabc46568281@tuxedocomputers.com>
 <ZdZ2kMASawJ9wdZj@duo.ucw.cz>
 <b6d79727-ae94-44b1-aa88-069416435c14@redhat.com>
 <a21f6c49-2c05-4496-965c-a7524ed38634@gmail.com>
 <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cyyKuWjF0GZgvTwP"
Content-Disposition: inline
In-Reply-To: <825129ea-d389-4c6c-8a23-39f05572e4b4@redhat.com>


--cyyKuWjF0GZgvTwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> For all these reasons the display analogy really is a bit fit for these k=
eyboards
> we tried to come up with a universal coordinate system for these at the b=
eginning
> of the thread and we failed ...

I quite liked the coordinate system proposal. I can propose this:

Vendor maps the keyboard lights to a grid. That would be something
16x8 for thinkpad X220. Then we provide functionality to query "is a
working pixel there" and "what kind of key is at this pixel" -- I
guess we can use input keycodes for that. Multiple pixels can map to
one keycode.

(And then we make best effort to map normal keyboards into similar
grids).

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--cyyKuWjF0GZgvTwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdeJ6AAKCRAw5/Bqldv6
8swPAJ0eTXg7THv3YqztC+ECLpHU9tSEOQCghojVjFEBaej133t9yKUV1+jTrdE=
=g5GA
-----END PGP SIGNATURE-----

--cyyKuWjF0GZgvTwP--

