Return-Path: <linux-kernel+bounces-40343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C1A83DECD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A941F1C21B89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ECC1DDC9;
	Fri, 26 Jan 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pROfp1SL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FD1B954;
	Fri, 26 Jan 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286859; cv=none; b=elaw3NDgt9ci/tCM8fWgxNWB3LNIxUQUKoT2qzu9q9c9SmsJNmnKGo7+wQkNCU7bvDOiZK1dDf2/xlhmsIAnhJaHhTmz8JSl3oMl5Q/kFAX/dGmuYL77F5BM6Xar+GQO4gbPGERgK9rCMzrEzx4r6igUE2tc93Jif6H+r0u6bOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286859; c=relaxed/simple;
	bh=8LEy4G6CqWr+CSK268QbkSrRkLiJ54WoUVg17J6xvQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hevurgdeiOd06BJHB4vNkkXJul2jXWCyyAs+I+k+eQ7sxDZI/HahYvJ1du9cdjQez10STP7Vp+6kv1b4S1Cx45yAGNlFgTVrBse4hRr23XqjWf4FHsrCZ+56FXt/juIg2zBrnDmXcEcYx1HafZIvsTKpcdCGDCYFubnwEY9p6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pROfp1SL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E2DC433F1;
	Fri, 26 Jan 2024 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706286858;
	bh=8LEy4G6CqWr+CSK268QbkSrRkLiJ54WoUVg17J6xvQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pROfp1SLgWTIjpkOMYgvKqg+F5zndUaLFuJUt2jWtMc0cOC37SXfg0Koez7yXa8aJ
	 Yb6+04O2SlhwCtHZZ8gYMzWuFDbxgju0rl6ki6JGcyPBsJuBB86XXh+6jzrj7Kt0NR
	 m+TE/R7Nfgh7qGeBtIHlB7usMeyE6z5ddQS1jK5mSjACBTO0ki30FSvx43sEvDwgyj
	 cOvLjv2QRn5/omFtsICWDEJ9ijMzqaBrWTyDWQAFxsxkRRCc7emtjrJEkoIgDxpWzy
	 krmoB1dAMnW78gTqsToozjUXJZAh3kClYYTOtpstjB9krYAmp3DEzApKreUSxqvR2u
	 vfaN95UG8Raaw==
Date: Fri, 26 Jan 2024 16:34:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <20240126-starch-puma-49c7dc3e2da8@spud>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
 <ZbFiQmD1VRVzFSa+@lizhi-Precision-Tower-5810>
 <20240125-appear-unclog-7da879f946e8@spud>
 <ZbMvsQpBtX88+muU@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8/kXroQjWzGHZPqs"
Content-Disposition: inline
In-Reply-To: <ZbMvsQpBtX88+muU@lizhi-Precision-Tower-5810>


--8/kXroQjWzGHZPqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:06:09PM -0500, Frank Li wrote:

> > > > On another note, I like it when the property name explains why you =
would
> > > > add it, rather than the thing it is trying to solve.
> > > > Named after the disease, rather than the symptoms, if you get me. I
> > > > tried to come up with a name here, but could not really suggest
> > > > something good. If you can think of something, that'd be good, but =
don't
> > > > stress it.
> > >=20
> > > snps,host-vbus-glitches change to snps,host-vbus-glitches-quirk.
> >=20
> > I don't think adding "quirk" moves the needle.
>=20
> I think "quirk" is reasonable because it is workaround.

Workaround is what the software will do. In the binding we just describe
what the problem is.

--8/kXroQjWzGHZPqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPfBQAKCRB4tDGHoIJi
0mBXAQD45CC2nv7KtLh6RjMARCAWlJkP0kVmV/E5HGTKIgKViAEA9FBorkCrPPXN
Q6HIpRR8RC39OqVDO9Z8Bs0BE8YqPAE=
=CLn9
-----END PGP SIGNATURE-----

--8/kXroQjWzGHZPqs--

