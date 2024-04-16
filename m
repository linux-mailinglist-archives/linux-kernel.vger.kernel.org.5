Return-Path: <linux-kernel+bounces-147490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92198A7529
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CBB1C2236F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBFD13956C;
	Tue, 16 Apr 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="TzWJ9WvD"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3680384E19;
	Tue, 16 Apr 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297472; cv=none; b=dG5zSk8JmiWv7EnAcoU++ktKmshAAnFNWZJAzifInEx+xsKQKnyOCUJrUvN4Ez8u3G0pmfCmCM4T5MEOo6ZQfbnfiwVzHS0tZ28wWzL79zRheg5+smUwQSFv4yOg9BHvPoon/BrOKoYNn1fMrd60paQJCfUQnpDcKcneE+2uIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297472; c=relaxed/simple;
	bh=E3iHWY3fRtLtKMI/pOvZuNhGML/VFF/zGrDAS5v84M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHuzC6rykjK4L4yKyH7dvV/Eh6yAhNig+8CywX1G1cNOT8PNO2zw+ZLkXwxHB6TDBJgdr5/nzk592w3lyz4t1UyH+Ymbb9GSnPrlBufJftHF2AKqCbro7NVU6FKejXDmc/v1zXswBUKjy2VFb6TusDeoY97vvvM9ERgSyDamGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=TzWJ9WvD; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1713297449; x=1713902249; i=christian@heusel.eu;
	bh=Eig0w71Tg2jh/AEC6QQiXVodCzOhteJsKfH40lzr940=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TzWJ9WvD7uk18bqTvCAMB9uzSh1JD7UsGRnKFv984H5yjiAZZfFYA3ECZedhcppu
	 9Q3vEPD2aM0ijEUSnlHppS+e++DWLhTy7J2EcrZTEgOP9MmIhyT8NRZdQFy7jFRVt
	 IlBIi/i2YEVlX8d+2l8uSJ1R6bEZwwLTKJtbCshSsim8tQfSvt0zKCVh0Yxoy0bbS
	 Q1OEdeCiS8xSujts+sLqSd2QqHRytuelxGpvN8wnsUqNMGB07fnJ3njB+W1KU4qFA
	 xttYuaAOo90m3suXRjWztxfuVQ17cmdpkcjQ6A8S5zb+/hMAF/84Sp7p8TXHoZcn7
	 7AetV9rz01gu3nEqrA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MeDYt-1sUVvK2P4x-00bO0G; Tue, 16
 Apr 2024 21:57:29 +0200
Date: Tue, 16 Apr 2024 21:57:27 +0200
From: Christian Heusel <christian@heusel.eu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Runge <dave@sleepmap.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
	Mark W <instruform@gmail.com>, regressions@lists.linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <itirowiwjrrpechdhyio2hz3czshs65yt6gwohcpjwohp4qs7z@hy2ebt5ie5aq>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <20240416121804.a46c4174f6cec30ab51f18e5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="spwgmais55ecsdks"
Content-Disposition: inline
In-Reply-To: <20240416121804.a46c4174f6cec30ab51f18e5@linux-foundation.org>
X-Provags-ID: V03:K1:VVNgfLCOO5Io105TxXnz7lw0tRYCRwFN0OllGFLpujKGjs8SlXc
 rGNZLRKb5sOWas5qlY05y9gNMecsR08+8EvVr8Y83oGaWmWfFdnJA9zg7RrX6ENZTTjUBq4
 HjBURswxpXpjZsH8o4R8vMILQCJsEjeSQlJeSNUrhI5F/Uceg4UF2HYbV3xoV1GTi+CcCbH
 IeRXLxKyZ4WN7VXOrlVVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nQpl5GbXnRA=;ac2yIz8qu7+et/kUR7dF5BxvO+C
 ThCcUubLt+on/h7DGWuDKYrliAElyhgEHX8dTMOj71UfHzN1QXnBZTBIxXprifmsRqY9rFljg
 IvVnRcudze9sSVvhM3NpfsUZvTj0CoIMa3Rmii5Fo8KJsPwHEPk2BbCIDA1Yuudw8q/bvWe5E
 iUSatww3TvnTGmvJEXfB6ESLRZTyl9t5GulrxqiJzKaQdTqIgjlF6yuAnuJNjAidDHtSl6Me/
 4/9V46tv+EgMz7LJbFcgNCnF4u1WLPIOQXuA1IAACs3HrSbBUNDENvr/PxA5CWs58jZjs1l8d
 HI+YiLAd4RzOyBZpFyi/pxpFXcFTXjlEYFVm/yxtodRXQlJ+LyvzfPxarHDWHJ+PU2kzRzRAk
 chsOZG5J6IOMhSzGBybLZr5r3XRmMZsf2byE8mTOCeUoQwmJhhz65q/VdPRiMoJBjlPLCTqdk
 INjHA3MxbGevtIe+8pahffaPfwbAs/nuqP+xA14o81FO75XNAaRMirijzK+WHxDLd8gJfQoiX
 1VO343F3O4c8xwkm2KLPRh4qRzq8dIepo1G5oHoLhQt9v60X8z+ohdVNY0apL81SIuT2bYuKY
 X8z07uHoElAWbDRSgkj0gZ+UghwEoYlo3PN2QfYVAmr7NpGNkXH31LlpRbnbXwG9RtAwZnSqc
 tX/CFtDHBlAfG8/f64RP5Vr0GVhyPr7WPnLBTBbhWoILQDxNzzAkRbhLOAzakNF86Lxqkg2TV
 pUnuN5oDyosaMprmCQbqgtYUkIK3pgna3v7ymLTNtewS9OMPaDmhzE=


--spwgmais55ecsdks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/04/16 12:18PM, Andrew Morton wrote:
> On Tue, 16 Apr 2024 14:19:24 +0200 Christian Heusel <christian@heusel.eu> wrote:
> > [  218.738568] CPU: 0 PID: 167 Comm: guestfsd Not tainted 6.7.0-rc4-1-mainline-00158-gb5ba474f3f51 #1 bf39861cf50acae7a79c534e25532f28afe4e593^M
>
> (cc more zswap people)
>
> Fairly old kernel.  We might have fixed it since then, but it would be
> good to know what fixed this, for backporting reasons.

Hey Andrew,

I guess you must have missed the end of my previous mail, I have
verified that the bug is still present with with the latest mainline
release and bisected the issue down to a few commits. The trace I was
posting above was just a random one from during the bisection.

Sorry if my formatting was a bit confusing .. :)

Cheers,
Christian

--spwgmais55ecsdks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmYe2CcACgkQwEfU8yi1
JYWu3g//XBsQJ0tXtI2lOeJhl6ka7DEcTV0Q0rACj5w3aKaxsHnaVmKAY353ERdS
+FONEiz0KWk3UP9ie7+EsGVVcW6go1r8Wion4azXWTjp3SMMrlDg6+KqjJfjkvlZ
1BDy9+iPfbT5pZfLlW4rVYOTBcYdweA577NHzkBdI2t16FAJwCAlzHuV0vRkG/HZ
Aq9X9HSizAYNdgc0NUPHcsXtxB45JZh9yFyo6eFO3qJyMik9HkK3JogqGMdSHw2R
Z3liihM0eWpqCqkDrOJhg6OV68OD1KcYNhF/lKpBNboNjO2LNxQtkQisK+n1mdnt
aXRXuuxhiThv2KWlSxnDDgNFPurCVil5mRVpEiOzoHrPNnB4lgoBYV8RR018kVol
BVWFvnfR/mNN43XhgG82TOfdXMRg8xUWjvLC8ca8QrawtHwvNInCiB3C4Uey3VoU
k0ZD+O8/wvNS1Y/Eomj0R3VcNKBghZJMRcvjgtwT5/rJC3GYeEc4djurEm0T9fnv
rAvIQvyJgP0aGDl/SKxBHt8aVp07E9rSsxoebg7sIfVyGh515ja9hov/hhFIUwdc
dAO/0LEM1BPXOLgHhY0XCcnJYR32HdFMubFWD97q5z5pacA7vRoLUhgbHTdYXiHW
drxDaLwfRoegeFIGMhVOQx/44zIQ8vKiXCPthiKiV5zrv/WYprU=
=K6Xl
-----END PGP SIGNATURE-----

--spwgmais55ecsdks--

