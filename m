Return-Path: <linux-kernel+bounces-144837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A518A4B84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823EE1C208D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923783FBB0;
	Mon, 15 Apr 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTO9CrGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45603F9EC;
	Mon, 15 Apr 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173566; cv=none; b=erlYRSmYPg/YwFaBVZoSLc8H9Mgm7CdmwG5UZBoXwKWBcxFNCFSeor4HPYMBGxqg82w/8aYP593ebkZ5vziz9EQhuHFgG4Jr87JKpxaPkl8sX1wzbG0UpdRD9Y6SHMkkVdjQZkFxSaUap/3Kvqz7QXzTQfv2XGfNVwb+yKjIui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173566; c=relaxed/simple;
	bh=hrn2Cpax6bG0+tBLHhsKA6HphenkfmI0P4jCJ4Nb38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij+cZKUP4/tHwMtr4idJ0MMR93gosnI2Ye13YditzxejCiaDPv2mfOWJQ93rVJQALyAiQC4FOL5/+imkKoRuHX/Sd5MoPmhrARlZhihSjz08sAwQjDhCBJHmXaJbDCXkfGLi52+2WvraMAzOpwc6TvVmjkYzwNrduKXjaXMbetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTO9CrGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E561C113CC;
	Mon, 15 Apr 2024 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173565;
	bh=hrn2Cpax6bG0+tBLHhsKA6HphenkfmI0P4jCJ4Nb38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTO9CrGXjb2iRtX3VcwAqY0jWcf+Q8kFyy3K/cU6keDvqq2q+zQRd87m/PumOKSlT
	 UBLIOMUwLtEuWI2s8KAcwm2cTc+LjwASPSsQbFDJYsNPwSCmCcHS+aqKQ6khKnprMX
	 ynRp1SbmFTCpiRd2rbugH650wz7eqpi9X1RXpPZqEOYV8SE7fIxGeiNiHIJh4Uddmf
	 m0pnLX8zhUU7G6253EQRUFvvD/4yyIEj25K+QzyOl/QmVhaDXVX7ZQU63mE0NJYkCD
	 9n3g/uT4urnwhy5dPdmLylCaigrWWuJdsMKRI+nxWRi4Fd9zzdt/CWSDzewI8UC7yG
	 1W6arDroYB4Dg==
Date: Mon, 15 Apr 2024 11:32:42 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Shawn Sung <shawn.sung@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v5 1/9] drm/mediatek/uapi: Add
 DRM_MTK_GEM_CREATE_ENCRYPTED flag
Message-ID: <20240415-ultramarine-oxpecker-of-completion-8a2298@houat>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
 <20240403102701.369-2-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="hhxojz7wd43elnlw"
Content-Disposition: inline
In-Reply-To: <20240403102701.369-2-shawn.sung@mediatek.com>


--hhxojz7wd43elnlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 03, 2024 at 06:26:53PM +0800, Shawn Sung wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>=20
> Add DRM_MTK_GEM_CREATE_ENCRYPTED flag to allow user to allocate
> a secure buffer to support secure video path feature.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  include/uapi/drm/mediatek_drm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/uapi/drm/mediatek_drm.h b/include/uapi/drm/mediatek_=
drm.h
> index b0dea00bacbc4..e9125de3a24ad 100644
> --- a/include/uapi/drm/mediatek_drm.h
> +++ b/include/uapi/drm/mediatek_drm.h
> @@ -54,6 +54,7 @@ struct drm_mtk_gem_map_off {
> =20
>  #define DRM_MTK_GEM_CREATE		0x00
>  #define DRM_MTK_GEM_MAP_OFFSET		0x01
> +#define DRM_MTK_GEM_CREATE_ENCRYPTED	0x02
> =20
>  #define DRM_IOCTL_MTK_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + \
>  		DRM_MTK_GEM_CREATE, struct drm_mtk_gem_create)

That flag doesn't exist in drm-misc-next, which tree is this based on?

Maxime

--hhxojz7wd43elnlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZhz0MwAKCRAnX84Zoj2+
dn3gAYDXi9cjUdHf2aEBheomLq/GUTf8sVV73EPWmCbpiNi2jzl0oe8c+ikVUjWX
5TiuHpwBgPVRTxUq5IhrqZvI3ysT+Lm44XxAlrk1rkAg3qZzilUjJKsvuAHAp7Qa
7fpwnKIfLg==
=wTVi
-----END PGP SIGNATURE-----

--hhxojz7wd43elnlw--

