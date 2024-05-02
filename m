Return-Path: <linux-kernel+bounces-166288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5008B9896
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F6C1F218F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496258AA5;
	Thu,  2 May 2024 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1r9EM3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951C5731F;
	Thu,  2 May 2024 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644699; cv=none; b=fZotwVxUM14nenC4npaDHbaZpcAfkflRhEMjQBK7IuTzTwkWHEtXckSWNcCRQVtnynpntb/tgnHdVVuvIA9aZjCDObRQe379tWAncBevXuiSnxykrGn5QgxT0B2ifdri3bjfJxxMpzV8SIyN6K2weqneCZ4C3rY6KqbYLT9FWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644699; c=relaxed/simple;
	bh=dAcIeF1zYIZcs4LzSltVRWcQ+tLrYYFfHlx+Gup6U8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCU+rOKc0kNK8RVP3uVspFiYk6JzWpZMdGkOwr9lllCzE5q4nK+9aESxFtSqguFUsmLsILwFs1vPR/J2+YZMqP0OdVTHvASlydD7dOeLcMdHztbDPHvH16irIoJZFnmguMdKT5NGTj20dYT52UYtVFmU5LF+7fNgI+nXGz2D0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1r9EM3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3900C113CC;
	Thu,  2 May 2024 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644698;
	bh=dAcIeF1zYIZcs4LzSltVRWcQ+tLrYYFfHlx+Gup6U8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o1r9EM3JPsKjyByhcMt6caBtUltI5yojwaPHE60fGGGJlColapnsDivyytTt578jL
	 Gbq+hu/T0O3txaCK1yZh0p9YgnsFLnEpdPq9ynYCUGSR6s0n/gn4ah5JWNkiN3CkFl
	 dFMRrgNkL9IEdBNjLpAW6z17jxi8+Wjl0vk6MU2KySe3Y+s+OIc2MupivjTJ5pSQFG
	 f452+RlewfVoxXQ2diP3N3c8JeI8n6j4fvWCM7kcM68MwKDANeHg3HJeWv9xkCFKmt
	 M8cCyhtT9vn1COElNWP9oc85JRhHUK4/DI1NrQbH/tUQvUrXcbDO9iaA03xwLsLpVx
	 4+6cpzZF3kV8w==
Date: Thu, 2 May 2024 11:11:30 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>, linux-media@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2 1/5] media: bcm2835-unicam: Fix build with !PM
Message-ID: <20240502111130.769402fa@sal.lan>
In-Reply-To: <20240501-fix-ipu6-v2-1-a5629a37a0fb@chromium.org>
References: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
	<20240501-fix-ipu6-v2-1-a5629a37a0fb@chromium.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 01 May 2024 13:08:09 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> The driver can only match the device vide the DT table, so the table
> should always be used, of_match_ptr does not make sense here.
>=20
> Fixes:
> drivers/media/platform/broadcom/bcm2835-unicam.c:2724:34: warning: =E2=80=
=98unicam_of_match=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]

Be careful here: Fixes: <patch> is a tag used by stable people to
identify if a patch needs to be backported. Using a Fixes: may cause
such scripts to break.

(it caused a problem on my apply patch script, as it does reorder
fixes tag).

No need to resend it, as I can fix it when applying, but next time
please use something like:

	It fixes this warning:
	drivers/media/platform/broadcom/bcm2835-unicam.c:2724:34: warning: =E2=80=
=98unicam_of_match=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]

(or some other similar word that won't be using a defined meta tag
with a different meaning).

Regards,
Mauro

>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/platform/broadcom/bcm2835-unicam.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/m=
edia/platform/broadcom/bcm2835-unicam.c
> index bd2bbb53070e..c590e26fe2cf 100644
> --- a/drivers/media/platform/broadcom/bcm2835-unicam.c
> +++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
> @@ -2733,7 +2733,7 @@ static struct platform_driver unicam_driver =3D {
>  	.driver =3D {
>  		.name	=3D UNICAM_MODULE_NAME,
>  		.pm	=3D pm_ptr(&unicam_pm_ops),
> -		.of_match_table =3D of_match_ptr(unicam_of_match),
> +		.of_match_table =3D unicam_of_match,
>  	},
>  };
> =20
>=20

