Return-Path: <linux-kernel+bounces-132559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16389969D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A091C20B3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970F481B5;
	Fri,  5 Apr 2024 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eagfUzh0"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0C487A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302481; cv=none; b=QjYK+sCBVW2z7I6QZR6+I5nDmActxcsTxwLvaIa6hljyOXb7MpWD0bujH7Ig8mu6+xoowmU/OWZn50AJP90z/AgTnWxlUaqvgWW+vNjixI5g58/Q+2wHyvhOvMmcRHpuZDgupJS3bHKrP7eOESaKXY/U3gyb+qYpEcTXs6789jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302481; c=relaxed/simple;
	bh=7M3cQvDCPQ15Ipq1SLSpKCIO0TLQHtQq5IMbzaCBwik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwQhCMd9TM3NT8//iE0onutSy3uoKfNo5hidqNtY7cEoV8jl2jQEp/cb046MDvkEWKYAt2Mi69Y+j5yD607hsySYmNB5+FH9chxwHetSeVbaY4A/qWN+E3HMt9KqO7LrLWVlznSUvu+0GVvjqmegnpAlXq2pJq2s7u5fAZ90TF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eagfUzh0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=7M3c
	QvDCPQ15Ipq1SLSpKCIO0TLQHtQq5IMbzaCBwik=; b=eagfUzh0uDDxDrhpbBwG
	OmiYf5gcuYT3JRsumYOKuFO9554K66T+KvlonARVbDuzqSWPI3Qh40UNqkkOTxfV
	NVhnEpDDXt/dilJjZWoBO9KbXEWrGwg9mtVP+gLp109lfI2Vh19uDLj4jAwgYSD8
	O+iIi41BbOlQGW+HGkVsyZuuizFlLCBCqJkn3beYQbiid18qjYQUzFOt1m7I3ggS
	Bawi99MwbGkqY8DCraWHHI+NSvtomJZDneGVN/USVNi3V6qlB95/ycliz8LaEoSi
	NMsmd0nwuE/VSz22c3cm9LrotstS7ZgaPC3B1sXYaS5vzNmR2YEXNv6c/AV86tkA
	tg==
Received: (qmail 4020841 invoked from network); 5 Apr 2024 09:27:56 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Apr 2024 09:27:56 +0200
X-UD-Smtp-Session: l3s3148p1@dqX+ZFQVXL8gAwDPXwEGAANOsN0UmmrN
Date: Fri, 5 Apr 2024 09:27:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: renesas,cmt: Add R-Car V4M support
Message-ID: <btlrc2vhov7ly7zpyf5zcxqja4xwucs3z3ipjscfaesohbaqyp@kckmgpqo4dc7>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvt3z7g2yxj454zw"
Content-Disposition: inline
In-Reply-To: <3e8a7a93261d8ad264dec2fa2784fe1bbfc4a23c.1712068536.git.geert+renesas@glider.be>


--uvt3z7g2yxj454zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 04:36:05PM +0200, Geert Uytterhoeven wrote:
> Document support for the Compare Match Timer Type0 (CMT0) and Type1
> (CMT1) in the Renesas R-Car V4M (R8A779H0) SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--uvt3z7g2yxj454zw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYPp/gACgkQFA3kzBSg
KbZfXA/9FpBbMM/HxAeSBJY01GFV6/OTJ1SznEGG5u/3PXZaWiji0dIgcndJH41C
aAVxRTByKSWuWYRKrVpZLT3Ij3tdz3k5sIOssqwxhSkG6sMPYaJpDLYgMs4gv80q
peo1X4tmtuxyVFhL0HuK+jVUFdLV4EZMZQcC0817boAsr+yxNIx3noVp4fJyHx6v
Af+vltXzKLzLHFbm31PHOu0FrhI3Bnqglr7Xp22br/OYX9bJyXRijr71Z02JA2U9
PLGz+XyF6vogEuxBzLfhO2w5qc4JKd6hW9R2lVlBpTbSYLHd9miX+6v08SDxjgh4
Opb7r4hb7Z3NnUOtHYlyBmNU1j4ilp7C5LkLNrfk/8zTXAEN8cfmS5ILirFq44/j
R6HtMzpRWPzwc17hDNYS6DFUmJy3AONHtYmmb8ZrhO+ITv4tcp12IhO+p+IWuCKY
25vf0tbLSzgHFgbpnGV46v+/+BiIHpsEsCgw5l4TPEP94lFDbBBuIwSEkb28081L
oD9qypdxjlodwJle+iMx14YHjb8kbximy5robGKszycVdtTcv29X6FdE6d+ekV0+
aDfP39ask7euSrUWFlhlKz8tM7mEseP7THo/1+BRiOrHnkngESG8FlvUciAVsZrz
1T8f+VQyA4Z5KppGZBBU57OdPxStfu4CwM6ToxYFQ/TST/1SNQc=
=bpbZ
-----END PGP SIGNATURE-----

--uvt3z7g2yxj454zw--

