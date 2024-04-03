Return-Path: <linux-kernel+bounces-130465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C93D8978D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25F3B2E888
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B52155310;
	Wed,  3 Apr 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="XrFxcFF/"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD36154C05;
	Wed,  3 Apr 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169945; cv=none; b=GzIylLf6hN2EIReYKKkkCRWfTQu/CiRWIDLkk5Mo/LDBoxndhLsUqwa6ivrOTssTS+AAvldEGo7tc7F9w4AtlCI9lMnSHhoJDZqVQpJepEOOYwpkVe/2LePDR/hmREsR0dHFF8BGsx6oHNhzI4brV2N5X5Vot/svLH/FjNF93BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169945; c=relaxed/simple;
	bh=jIG+Ihd21TGNgqIjRac38c9APyWTy4/JqkNdGUVvMms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0hLqUKqWfWeY2lL/9cM1ZBRp4rWSiKINXNHKzfzGl8dmbDRdJYozFOvAtOo4eYPjN/wFq5qXFJYc2eaeTqsfulbJCnhQiaD28E29NJMBj/E+y2JAjODjAsZ3p244iPtVkDAv5QVw29H5Bsh4TZaLu1DRSEy0Pl1ojWyaj1IemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=XrFxcFF/; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4E7741C0081; Wed,  3 Apr 2024 20:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1712169942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3eYJ9OMnIMT8I0KnlqsTZt/2fy8zPffBDtryd36nvE=;
	b=XrFxcFF/+nFBev2VsBbLg2QDDEvhu0P1dpRJn44m0pQ3Y/9MCu3uKTCu3lkeqEo+I3iY8I
	x4XtoWseA/685/S9fdn80RreDJmESacPwY05Y/g1ur6GCHv16xYKV7o1zTxbgFzoryMlg8
	sLquy2qnwboUkQ5wYBsNXeEKTXjBpxk=
Date: Wed, 3 Apr 2024 20:45:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 10/25] media: i2c: imx258: Follow normal V4L2
 behaviours for clipping exposure
Message-ID: <Zg2j1XeOhFwO2Nf2@duo.ucw.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-11-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TSrHSD91eT0HPM9g"
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-11-git@luigi311.com>


--TSrHSD91eT0HPM9g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2024-04-03 09:03:39, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> V4L2 sensor drivers are expected are expected to clip the supported

Remove one copy of "are expected".

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--TSrHSD91eT0HPM9g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZg2j1QAKCRAw5/Bqldv6
8uk7AJ0Tv16PpliGIRfi6ytvhO2dBmnesACdFwrfYE17OwtQw5E1a9jc56zJgek=
=1OU8
-----END PGP SIGNATURE-----

--TSrHSD91eT0HPM9g--

