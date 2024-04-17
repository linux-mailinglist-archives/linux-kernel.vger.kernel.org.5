Return-Path: <linux-kernel+bounces-147997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3578A7C63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3561C21FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF00657DE;
	Wed, 17 Apr 2024 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g07ltgwt"
Received: from sonic310-19.consmr.mail.sg3.yahoo.com (sonic310-19.consmr.mail.sg3.yahoo.com [106.10.244.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08204206F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335781; cv=none; b=pu9tiul/TquJtbAo1IpB0mgyFznex4w6rMrjrHO+aBV47bufBMdA2kbVzGlFF0f71WgQQoVjbQUKt/ClFLV52Ew3WrhlVj5Hxe0jXjPGu1O4PDObo7BF8MGcqEjebgJrkK69Ci1QtAIlb0JYVF8tUBJdBBq0uja+MWGFxfzu62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335781; c=relaxed/simple;
	bh=e+8yz+cH0odraTNrpZVGJcJZ6vJWpbykhuVVTXpnOt0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MOZCpm/xmBSEgzAC2B/LrE2DGGsnD2O/dLhmoET05q9jmoD6OOrPwZw1jxDw/KPFHSvcSlLPgumSghSvlR0uNpuKn/1uSaNe4weIowcHS1PDlgCRu6UlwTuF/vSO5rkuRzSoOyZ9cRKO06sNVaDTpiyedSQ3FHo5jJwYaOJ4Kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=g07ltgwt; arc=none smtp.client-ip=106.10.244.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713335776; bh=e+8yz+cH0odraTNrpZVGJcJZ6vJWpbykhuVVTXpnOt0=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=g07ltgwtwZg44OE+g9bXdenFYFmB5DUc0y3tFNu7u+1qgKp7VtsFIHrfxmZQX0m7V5x+GpdIooMcNsntTQj9Qxwh76tSh6MlMYqJ93CvY/is7Z+LoA+IAIAx+QjB+qt6iSLBCJbJVmXwChAo26Tycg/LuGQALksNV0Z/SnGuFgWCVkIz4LrRlFIasdFKkf5hYkOBiM2kphh0s92MZ3wDTM3T1RnVKn8kj+J3J5RAatcJHk/q1drXjx1feBnuN3zw5UkpZ3HcVahYlt0RnxdZMbP7s9qk6WXFzLpOOQJA0EbcpdXSZMWX+TogY/1N6WNrXrAmWsOIVv2c1D+JkcTMdg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713335776; bh=Pol6CELU5q7pB7yfGI9+2kTDT/r3Y+FoPPEvmVL9s6r=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=arjKP9R3cYoiy6AsG392M9ghM5qf8mVNZX0sadASz0HPeCgbXtGL/NOaoh5LOR8dZ/9Sbx9H+B1GHDTAkcXGdCD+DTTUH6Avg6o5KhZDULSAmKT4Xncs1QOkQJlg0B4Kdi3wiRGO3xdFVkngvgRRGwGHbXnruZ+W980nDN5juI54+iSMvxiibIh9XJ5V7fGZHMWiJDGLc7s2MQYlIgAJGDrkCG5ch1kwC5UedTgRyKSxeafptfz6Qc9KKlUTCU622hlEvhkmkYDj04ZQ7XrnVeUTNuHsv4+W21qG06PnVjXn/X5ezYsAXjcyh7jw2FDcitmwB/HpOJDv9I33hyjf8g==
X-YMail-OSG: rz2N48UVM1lGiUVVbPfBnjhtLnn00ubyhJ0gXPgxUKbBk4Y3gZmALalyH0vDPnj
 MkrttPcarY.IEPXkFlG4iedu3l_Hr89oQoF8bDXWe5szGnWE1Ua.r3fyiL7mBQCWLEZbrBO8UUG5
 AWBFs8TfcTXeKaqlsyVFoaa1FVBJ.gisDBksdSeOVC7hIud4ChpJRL3Y7P41wRhX_p7CQt6hHiZI
 .dXvKDY4GmQHZIjFProPEs745ouvQnDowJ5FXIGtXyc6eMRRmrs3kXQQR5umMjjqEuEBQzZ45mWC
 wRodV6lNLGGNd3pepgPzy2B9r3bsiG7kmWPXcjjAl38hPv7vEMtICPz_XKVvcMQJkwfRxkh52lYs
 0VHXAfmDaNkfYb4ghb5sK3_I5wHhMTsuqhEqasbFOqvACXo8jY1Qiw2X_ZR___ip3diM.g8qV9op
 n4f4WE6iuLfyNe0e7ojz_asNZbeQzq1ONBFlatljJy3LnAEG1fNCwNdRBGMyo8KaKFym5ye0ZOm0
 zP4C0w8bqCZGdfobdB9AXit3xk2yc4YZ6NBXWNUjZqA1.yC5gWKkpZHjS2hHiN868pnbuHXcgkpI
 hUtgx4afrm0q53kC.fGBlM74Ew3zC0upgTpGUj_Ig16rtml5P98pnvAUSeZYDz6tlmcGW9u8qMu_
 giP1uk0lA3e0xoREcVNDVkkcvup3OHsfpqfILG6qUi8v0EAILzMOxn6hfUG_gMDAa5sKct33AZot
 erL2H.wJneSaBr8fbccTcc4jp8AQcRKZo7wTUmLcM7RedCoavlHipSrpVJCy8y5PHLWjjFVIdVkm
 gTRseOJruB_EbgWnFNUPKZZ6gdQPC6dWFO3UOH0m0_Om2Hlh.uWxVJMXn3uj0MDIcRoE25vzTB7w
 RoIT5XY07yQW2Uu9H8vJTbhKlvKqi9oLRXDSOwLzJhyZErPtrdD2PRcARu5vN1Wy5T3lFhQIoC52
 N1sh5s0k0fuXXmeGswwZF3PBFvmUKHQE5Hnr4b6bVLRoA01zVqeCZrJ8ZqRcLAPfKM4zFrmjh_C4
 I4NUyLYN.2Ma.ck2ZPv9DQmrbhbVpnl3L64iiHoGP0KsyQcs_47yXIFMVSyv1P91RI0LrzSpizOi
 g5ngf8GSjdRG6YdI2wa6extC1jxVr0ZxeyG0Xmwo9N6qhSTGeun77PyZGFonuG9wSdzoa_Uo.LUn
 28Dp9BhOV84_F2.TZtC22ObBPZGrZnrkhVIVnAgSmNnK90k.BFyr9BTc5hJrYTwIyycCOSy4B2Tg
 GALGpW5hebIfnhQKtKWgHromTxd0b6O13L8BMz.pEK3LA39uGMjFdzQBnBdc44farLjTrBokUNMb
 WzL9cAgbwb2z1L02V8WuTyq.SP1gnvQSz7fDlOaq1gUgpvYVdtpyxbUHO.fb7u.SJdosvIGH6PvT
 tTfy6aPPMP3JramXb2Tvk_wYDcsXsvb1ifyEhOMMyRJOVA_Psxs8tYnk6_HpPX91wz.qRZKDaltX
 HSSR3YNX15PA2sB3ApWS4.nPXyppKHWOobESPYtonGH.JgW43NnijezHd4_Zt9HpjLeIVo4unboW
 qCUm3PrekXWgoDXl3zo.fBornJhp6pS2R9.8U89Q0je9kW0ofpu0UvU9ZyNfCmIWS0bcSIsAJBMy
 .92mhJmhXmq4fuFGNEL2IhJ2ytI9ik5N7KW7IUBZWulGWTMBLyy6wVkax0tQAbJWdJlThtykret.
 ZJB9ZqGLludX6bL2gD2uCJw.nITMisl6mD3C9RTr_Ro4erMoRIgLKLmRFejX3SQbgnqR3TMIjW3W
 qe4SCDRzzh.FCgv_btTLCZckOtjelBDkN7vMBFXfQp8jidWu97t3dcR.M4IA4zgdCyNzbiOin6MU
 fFZz2zlnNscXBonZupfgDj_WHNdHuPIkOKNrXvKFAYlfhPiN77m.vT15xIvq.OUn5CR0CyouXIHF
 bSM2f9Z0Hhq6I7Ot1In.C0K2ztOAj0n9tWlEs.JMYBE_1.bdJ149.q4PcS17SzZJr71RIiyuNssB
 3IPoYXBJ_04R8_7N4G6YghndQUEJraLRr0X0FXPb8p_5BRhWv2ksBsYVo0gEAxi5_P.5VhhBILqk
 eepE65P0YqXKLoEvOJUrcoJE2C894UeExF2EUIg9FEjBc6QVqhBqA1TkGQwk7wuM1gDIl6Bf3Lfq
 pG11fZjoBPo5dAsq8tgwifIftw1yDILgEBbe.kqWr1O8VL3rgCRr6CZqib_cBAIXXJSPywSOjpVn
 BAy2356W4iuZx.7TdIe2D9EgCSAbAlJcjBL8Y57XJKNoKcwoQjrGq_NplYPQCgCWNmFhaew--
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 27321455-38ec-41a8-be97-de9b176a6a4c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Wed, 17 Apr 2024 06:36:16 +0000
Date: Wed, 17 Apr 2024 06:36:10 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: Joe Perches <joe@perches.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Andy Whitcroft <apw@canonical.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <776311640.119588.1713335770163@mail.yahoo.com>
In-Reply-To: <a582c379f1bc2bc0d16b46ece9211bac40b4b7cf.camel@perches.com>
References: <20240330033858.3272184-1-ppandit@redhat.com> <1568855168.5949322.1713251087824@mail.yahoo.com> <2024041627-overgrown-ripping-2348@gregkh> <edf23b1b-303a-46eb-b455-8c766c84ddf1@moroto.mountain> <a582c379f1bc2bc0d16b46ece9211bac40b4b7cf.camel@perches.com>
Subject: Re: [PATCH] checkpatch: error if file terminates without a new-line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22256 YMailNorrin

On Tuesday, 16 April, 2024 at 03:25:18 pm IST, Joe Perches wrote:=C2=A0
>There's an existing check for this. Fix that instead.
>
># check for adding lines without a newline.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ($line =3D~ /^\+/ && defined $lines[$linenr=
]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&& $lines[$linenr] =3D~ /^\\ No =
newline >at end of file/) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN("MISSING_EOF_NEWLINE",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"add=
ing a line without newline at end of file\n" . $herecurr) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$fix) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fix_delete_line($f=
ixlinenr+1, "No newline at end of file");


Okay, will check; Thank you.
---
=C2=A0 -Prasad

