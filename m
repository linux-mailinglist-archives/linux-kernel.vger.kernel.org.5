Return-Path: <linux-kernel+bounces-144322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C87F8A449C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853FCB2220C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8D41350D1;
	Sun, 14 Apr 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tdwmPxjh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FB29B0;
	Sun, 14 Apr 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713119807; cv=none; b=a+D+OnB2kibElUxON87LFtJnwybfizNApxBGTdwrc2y7aSBq2OHTEGccYNsJYWlUPSq/hYOQNAXzhULMIKQrjJWm0NZQh0kqDZw9fXiVg4Z8O9ifosANYT+WNVXXRmXOSouepnzPDMCdOXxmkg2ON2xoV5U0xyVCawdOG1xeuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713119807; c=relaxed/simple;
	bh=rT0Ls6DVFCzzlFPUOlmKHuVQHe6JZ+Laed7jwNJb4no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be5YJ4TohO9my088OBLgJg8iZSl4hKt9X8v+KDdUAkbMRzDedZj5vAgfr+YIucP8I0N6dBy9plx1e4YwTShSSXXWLInh2g9eM4ZCU0ubpMt7yY3USWubyQgZwQQBapDO48bQAjYD0GohM1w7Dw42OCysAxUafFoPWbdX5QIlg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tdwmPxjh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713119803;
	bh=rT0Ls6DVFCzzlFPUOlmKHuVQHe6JZ+Laed7jwNJb4no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdwmPxjhpI1tcBVd8qCh7/nSyl+LjbG52efcfiCsa05jLLrWb8WDMD0V2h7DHsRIe
	 pA2cPJr6sITGynILUsqCSlmenANEGPNeEWqRZdLBz7lFk0bhhfdyVLuhlf7yvPktTr
	 1TJXzw0OK95ShF1u5/EX0/n3NgDt9zbfIwgIe2WQ5X9XsXt/Bl8lLFOfZJG4+dG+CZ
	 2bsYl+uTLg1fa7Mm8AgERoRgtQ03Ay92Fxxsdbawh829J7IYiJBt2HOkgXmu4L80OJ
	 WjUkLix9Mn07oSVZBKel2yYT6tFyOkDWrEhee7YhffLKQEB124D6/le17MP/1fi8LN
	 2B3QSakDPslYA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1DE237814A4;
	Sun, 14 Apr 2024 18:36:43 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 31571106134A; Sun, 14 Apr 2024 20:36:41 +0200 (CEST)
Date: Sun, 14 Apr 2024 20:36:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v5 1/2] arm64: dts: rockchip: Add Hantro G1 VPU support
 for RK3588
Message-ID: <f3s63qq7h7qstu5sbjzcumafpllvineh3tlmbjy7hdj4oickla@gcqixrj623gu>
References: <20240413064608.788561-1-liujianfeng1994@gmail.com>
 <20240413064608.788561-2-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwtj3nebnsz4gzrf"
Content-Disposition: inline
In-Reply-To: <20240413064608.788561-2-liujianfeng1994@gmail.com>


--cwtj3nebnsz4gzrf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 13, 2024 at 02:46:07PM +0800, Jianfeng Liu wrote:
> Enable Hantro G1 video decoder in RK3588's devicetree.
>=20
> Tested with FFmpeg v4l2_request code taken from [1]
> with MPEG2, H.264 and VP8 samples.
>=20
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/packages/multim=
edia/ffmpeg/patches/v4l2-request/ffmpeg-001-v4l2-request.patch
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi
> index ac5bd630f..de823f461 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -1072,6 +1072,27 @@ power-domain@RK3588_PD_SDMMC {
>  		};
>  	};
> =20
> +	vpu: video-codec@fdb50000 {
> +		compatible =3D "rockchip,rk3588-vdpu121", "rockchip,rk3568-vpu";
> +		reg =3D <0x0 0xfdb50000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names =3D "vdpu";
> +		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> +		clock-names =3D "aclk", "hclk";
> +		iommus =3D <&vdpu_mmu>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +	};
> +
> +	vdpu_mmu: iommu@fdb50800 {
> +		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg =3D <0x0 0xfdb50800 0x0 0x40>;
> +		interrupts =3D <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clock-names =3D "aclk", "iface";
> +		clocks =3D <&cru ACLK_VPU>, <&cru HCLK_VPU>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
>  	av1d: video-codec@fdc70000 {
>  		compatible =3D "rockchip,rk3588-av1-vpu";
>  		reg =3D <0x0 0xfdc70000 0x0 0x800>;
> --=20
> 2.34.1
>=20
>=20

--cwtj3nebnsz4gzrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYcIjQACgkQ2O7X88g7
+pru+g//TSGr8OdwYvLGz5eiAnvv//OdV2zNbWBeVOb5TQnuvB/kxBbwspIJAY44
+Bkgz9AWLjEZuooKaIoQrgCFNJu5o4+rdTiIhKMEo9M6QSjji/jRvB0J4TIUVbUR
brTZUvJhTQJNNh81CWstGJtiYvPf57IJvojjk7VJRJFg97eTf/kZszfRArbWohhn
4Ij7oW9bR9e9fX8PIJd5zVgJD/ljHHmKU48ZkI8WMwhplYVJh84+lOaI9KbTjuN1
fqPjTNJeQm4l9VbQ1nvoe/LC9HErVoPc77obiChmO0FwCD4nAL0xMfC6m9Qweayg
7e9rG8crDGy2takHP5+vrOjLMdwucwzL2vNV8SuZbiF2NWPLDyD1TZkNKI6Tw4af
xBu4OSA/de+vulnxpfIFYx3ieasHNfgl8PTwDOtliugOf6i+aiczpblhvLsqNcyK
WtY4VUiR/B+YVNLOdsDFkDwHJ3r+YHCoke67R9MVYPZdq3JKIwxRaj2xqgHAUzBb
joaX8pRdYrrxPkIquHKPUteegweV1Fr3FiZPvelNcSB/6l90HMa+XoYM5vR3ARnx
zHpzLKJygYzlkUi4fR3y1Ad2H0FfV5MHx4TIJ+FlQuUJTuEnp30hWb7Sc/YCC0Ec
YgZGoH/r8ARl0V+Zmvi/R6bFrZmnBETRnn55EzWnOfDUy3KHcyk=
=HMGY
-----END PGP SIGNATURE-----

--cwtj3nebnsz4gzrf--

