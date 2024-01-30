Return-Path: <linux-kernel+bounces-45496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2684318C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EA61F2445C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392679DB2;
	Tue, 30 Jan 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="lT1YBQ/U"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1087EEE4;
	Tue, 30 Jan 2024 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658432; cv=none; b=tMtpNrLUIUtwrt0DCGp3MglmRA9p+XuDtGT4PWN8BF+7IVORb0ZY1gq4Pyj5zKQl1Q1wIi+p3CcaJ4Ygyba0Yey2lstNfZ3xnp0iD2s0jVS2l7L2uiS28nSNWZqCr5CCZb1jMa4/4iolYP2/eE4ic+XR1QofLmLu/pEslJj6ViA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658432; c=relaxed/simple;
	bh=TtJKe7IslZBATrq1R2hfwR9T+PMEE1xQur0Wd4Vxjso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aij52mYZ2qcqKF2L1nqhLO2hqqtxKC6O/bPPhf/PnhuVRJZZ3SBYf89EKVRyLg/NAwDgso2ebLzKEfs9iu3QJ0KIUzgICKLt1pq2nZ8I+BGrZjrvNg4E3cl7zoH2NSZC6pzEjtbM0CxY4BJS2AscCLuSkzT7aKgOH21jYYqlkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=lT1YBQ/U; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1706658418;
	bh=TtJKe7IslZBATrq1R2hfwR9T+PMEE1xQur0Wd4Vxjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lT1YBQ/UMZxqWaO2caLxmgbMU/tKeQaNZQ2Tknv2LQkv5C6lUK18YcoF6PVG7Qahj
	 rqyUBJoPnMyPyYS3sgjXCi2DoO+shUvWDlkDdfJzvp3DVHe2iUoTRjBJAyYhq/VPjn
	 Qxf3HUazGiUtniv5JkZZ1Cn1+DTdbKZnrA3b9tySJbwIvOUfITzfXRzpbagz0J2Ia0
	 hNqgMcji/X4GXOvncwj53Q1nO3V0AK2txx8NaO2z4eDAXZaai7XkJmBNn01eLHEcIG
	 erItKSyjGikq5y1zU+i1WAFdKl+9b+JMDultk7HLdjDVp5ePBBXjh0t7eGuzfEEs9j
	 fLPXYS0SonjrQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 3762E1390;
	Wed, 31 Jan 2024 00:46:58 +0100 (CET)
Date: Wed, 31 Jan 2024 00:46:58 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: memcpy: detected field-spanning write (size 101) of single field
 "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/scan.c:2251
 (size 1)
Message-ID: <dygt52o6wj4u7a2b4k7uew2g2hym7j5bxyavkafjk4vue6b2ue@tarta.nabijaczleweli.xyz>
References: <xebnh5c5rnfequ6khyhieugefrtt5mdftr6rsw522ocpg3yvln@tarta.nabijaczleweli.xyz>
 <59378600-8d36-4958-8882-fa693fcad4d6@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="beew2a2gwphvoerz"
Content-Disposition: inline
In-Reply-To: <59378600-8d36-4958-8882-fa693fcad4d6@yandex.ru>
User-Agent: NeoMutt/20231103


--beew2a2gwphvoerz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 04:55:26PM +0300, Dmitry Antipov wrote:
> On 1/26/24 22:47, Ahelenia Ziemia=C5=84ska wrote:
> > [   41.314634] memcpy: detected field-spanning write (size 101) of sing=
le field "ext_scan->tlv_buffer" at drivers/net/wireless/marvell/mwifiex/sca=
n.c:2251 (size 1)
> Short answer: if your device works as expected, most likely you can ignor=
e this.
It does.

> if you're brave
> enough, you can help the maintainers by trying this:
> --- linux-6.6.11/drivers/net/wireless/marvell/mwifiex/fw.h	2024-01-10 19:=
17:02.000000000 +0300
> +++ linux-6.6.11/drivers/net/wireless/marvell/mwifiex/fw.h	2024-01-29 14:=
21:55.574280719 +0300
> @@ -1586,7 +1586,7 @@
>=20
>  struct host_cmd_ds_802_11_scan_ext {
>  	u32   reserved;
> -	u8    tlv_buffer[1];
> +	u8    tlv_buffer[];
>  } __packed;
>=20
>  struct mwifiex_ie_types_bss_mode {

Tested-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>

That works and makes the warning go away for me on 6.6.11 =E2=80=92
now all mwifiex-related log is confined to
  mwifiex_sdio mmc2:0001:1: firmware: direct-loading firmware mrvl/sd8897_u=
apsta.bin
  mwifiex_sdio mmc2:0001:1: WLAN is not the winner! Skip FW dnld
  mwifiex_sdio mmc2:0001:1: WLAN FW is active
  mwifiex_sdio mmc2:0001:1: Bad HW revision detected, disabling deep sleep
  mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (15.68.19.p5=
4)=20
  mwifiex_sdio mmc2:0001:1: driver_version =3D mwifiex 1.0 (15.68.19.p54)=
=20
  mwifiex_sdio mmc2:0001:1: info: trying to associate to bssid de:0d:17:ad:=
84:d9
  mwifiex_sdio mmc2:0001:1: info: associated to bssid de:0d:17:ad:84:d9 suc=
cessfully
  mwifiex_sdio mmc2:0001:1: event: unknown event id: 0x79

Thanks!

--beew2a2gwphvoerz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmW5im4ACgkQvP0LAY0m
WPE2FhAAmuiZssrpyDGpJhDcFCPtMSd1BFfcAG9mw9/fEkMZYwlMqfcw5I4gV942
uLVLOaYHkbwLOXg3l2g5YatSlcHUNUL4TWB34lkMOQEeNzfYJBwItMEmRkW0XmNK
2+dh3MmzasAXhWLBeVPfRDlPAvRE0EAoCSfJZP9tRNlm0EWLkiWqdNUp+xJoKz/E
HfF5bFJWsklYFnTqLGZ6/nFGSIdQbhRcfZPzwFXx4WxiFu3RhG6qqDm2YmsFg/Td
Qst3ACHLJa4AEOksSLLBLVMAqBBOSG2jccQAo0iRkBrM1E0j1V6coaiov2fi+I0e
mCRo2nlUyfy9Bd/fIB1Rq5Ba9ihHbo/KxUtEOrWENdD4i6w0raX4520uTEYxwxBn
yRLheY3ASALDLJR7e5jT3wQhWFCJ2oVcwmocELw7MWiKphyuRpxqTHaeCqgtKdJA
ulaG1CC+dHGGRHZrJNziZvU6l1MXnS8//mXmS7eJk7mR8bgnMTGgMLtfBwK8udPM
eeTJ6dcLecxg3U5cL89N39mDJkEHwaRnWNfdNWU74uFA41IaSofDwD08NPuPgkPY
LVuAj6rHHU0qUxan9540V3Ygh4GhRIWup6bgUbPEEDvEFiFVauc7yHCjXZH7HPDy
cpX9X2PK4TPvX5H8YbyZp4PED69ovoOd3vpsC93R0Lfz/sZiI/4=
=WoY8
-----END PGP SIGNATURE-----

--beew2a2gwphvoerz--

