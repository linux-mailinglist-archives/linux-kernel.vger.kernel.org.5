Return-Path: <linux-kernel+bounces-126281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06A48934B1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663851F24317
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088316191C;
	Sun, 31 Mar 2024 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="K93VgGGb"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FE1607BE;
	Sun, 31 Mar 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903439; cv=fail; b=agTbjG+9G0xL542tLSNEErPNx4WNx459J1+9aM8Qgh2k21g6Y7xamj0gxbGazNy+Tfwhn+SklVmmTrtnN6blaOTdTHbd5cai173gSLFMp/IhiD/QLKOrmEYUhTOIGEjRBghH/epKzg1ltfzhITsDBI0y0urHnHCSUvJQ2r/Vae0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903439; c=relaxed/simple;
	bh=2D3W7Aq8rRi3gmv+4PXRtGv6s9okVKCpNPzM2GIJhqA=;
	h=Mime-Version:Content-Type:Date:Message-ID:CC:Subject:To:From:
	 References:In-Reply-To; b=S1/t1FDNoq7hF+ifbqttGZmZR+ryAZew2p6cDGsUcAvTvCmNJpvP+BIE3VketZr6MeVFXw3Y7h1oaFRQH70fZiyi+aSbFSPFWf+HM24/XrAfkcob3SfERcec3m0NK4H5PL/GaV0ElqLSo3ZYGRjMO8bUL7A5LKBVJZrbHOMlyvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz; spf=fail smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=K93VgGGb; arc=none smtp.client-ip=195.113.20.234; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=matfyz.cz
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 2F3D1208D2;
	Sun, 31 Mar 2024 18:43:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I_XQVTJjLYFo; Sun, 31 Mar 2024 18:43:54 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5A01B2083B;
	Sun, 31 Mar 2024 18:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5A01B2083B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4DCF9800061;
	Sun, 31 Mar 2024 18:43:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:02 +0000
X-sender: <linux-kernel+bounces-125648-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoA94emlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 10765
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125648-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 28BC22087D
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791271; cv=none; b=fC4QQiana65tSuBRu9LVdQxj6FZE6ff5mOfMXWEMyuUyrL/N8U7RK4M871aXxSYEPncemGKQUJqvN/Tm+w/W5f1F/nZyveS7NYT6tS96EAPQ8RTiHYYiR4cLFeQgh30U2SiP8I0/ogh3Uynwc8rrAnT1UuWl3fz3JxKEn3Anl6s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791271; c=relaxed/simple;
	bh=2D3W7Aq8rRi3gmv+4PXRtGv6s9okVKCpNPzM2GIJhqA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=oZ2mnoqV3I/A+ghJoH6qP0Irn46wHvNbvSS/KhvRI+DZKC2LRtBP86bbofhhHGX0OS9gAOflkKKP9w2X8lRkmtEnDk1SJ/rZpCGn47IWmwkFiPGdffd9dSPROsO1/4XXRM1P7A7FqtSLdZm5rzj34rpxayo4iIHX5v7bhBgDPlI=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=K93VgGGb; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711791235; x=1713091235;
	bh=YkJ6HA2Rzwgap8CzRAVIV0XAgD0cG3+xkx0g8vSdt0Y=;
	h=Mime-Version:From;
	b=K93VgGGb/2nFZnEjPEWjtOFZjLkdRjNqs+qj0cvIh8ACa5XfYLnplq+BW+yBybZ+e
	 2gsvkxx0tZ+A8/2gYL0VpfgSPwQsE7fj2m8nxSjSXvvLkqczB/iiR/YRpbLG3isntZ
	 NqqtZjJt+rH4guTWG5Ma4VNQXFiJY+7aWakxQYS7/DuyRUw1Zg98hjFMTBnhWcbP9z
	 g/Ckj/p0F0w2SVAEfBTKxsX607AF2qYCxXQTwOlVUd+eW6M6tloL0NdruYfdpMd7Cj
	 /+WHJNMQN2qGkzrIwfwpmDnePqlBAf9zyp0Q4vqGNczUhUJSkocVDkgbHPX0iWytuS
	 MpZFthd63l3gg==
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Mar 2024 10:33:53 +0100
Message-ID: <D06ZCKKYTQM5.3OJ6HCLHW3DZ9@matfyz.cz>
CC: Markuss Broks <markuss.broks@gmail.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
	<duje.mihanovic@skole.hr>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 6.8 78/98] input/touchscreen: imagis: add
 support for IST3032C
To: Sasha Levin <sashal@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-78-sashal@kernel.org>
In-Reply-To: <20240329123919.3087149-78-sashal@kernel.org>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Sasha,

Sasha Levin, 2024-03-29T08:37:49-04:00:
> From: Karel Balej <balejk@matfyz.cz>
>
> [ Upstream commit 90cb57a6c5717b83a110c0da720a03ee32ed255e ]
>
> IST3032C is a touchscreen chip used for instance in the
> samsung,coreprimevelte smartphone, with which this was tested. Add the
> chip specific information to the driver.
>
> Reviewed-by: Markuss Broks <markuss.broks@gmail.com>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> Link: https://lore.kernel.org/r/20240301164659.13240-6-karelb@gimli.ms.mf=
f.cuni.cz
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/touchscreen/imagis.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscre=
en/imagis.c
> index 9af8a6332ae67..e1fafa561ee38 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -11,6 +11,8 @@
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> =20
> +#define IST3032C_WHOAMI			0x32c
> +
>  #define IST3038B_REG_STATUS		0x20
>  #define IST3038B_REG_CHIPID		0x30
>  #define IST3038B_WHOAMI			0x30380b
> @@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
> =20
>  static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_re=
sume);
> =20
> +static const struct imagis_properties imagis_3032c_data =3D {
> +	.interrupt_msg_cmd =3D IST3038C_REG_INTR_MESSAGE,
> +	.touch_coord_cmd =3D IST3038C_REG_TOUCH_COORD,
> +	.whoami_cmd =3D IST3038C_REG_CHIPID,
> +	.whoami_val =3D IST3032C_WHOAMI,
> +};
> +
>  static const struct imagis_properties imagis_3038b_data =3D {
>  	.interrupt_msg_cmd =3D IST3038B_REG_STATUS,
>  	.touch_coord_cmd =3D IST3038B_REG_STATUS,
> @@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_da=
ta =3D {
> =20
>  #ifdef CONFIG_OF
>  static const struct of_device_id imagis_of_match[] =3D {
> +	{ .compatible =3D "imagis,ist3032c", .data =3D &imagis_3032c_data },
>  	{ .compatible =3D "imagis,ist3038b", .data =3D &imagis_3038b_data },
>  	{ .compatible =3D "imagis,ist3038c", .data =3D &imagis_3038c_data },
>  	{ },
> --=20
> 2.43.0

sorry if I'm missing something, but I don't see why this should be
backported: it doesn't fix anything, it's just adding support for new
hardware.

I can see that adding a device ID is permitted for -stable [1], but I
thought it still has to bear some signs of a fix, such as maybe here
[2].

Furthermore, you are also proposing to backport Duje's touch keys
support [3] which I think is unarguably a new feature and not a fix at
all. Of all the Imagis patches, only the touch area correction [4] seems
to make sense for backporting.

Could you please explain?

[1] https://docs.kernel.org/next/process/stable-kernel-rules.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/commit/?=
id=3Dd40e9edcf3eb925c259df9f9dd7319a4fcbc675b
[3] https://lore.kernel.org/stable/20240329123919.3087149-88-sashal@kernel.=
org/
[4] https://lore.kernel.org/stable/20240329123919.3087149-76-sashal@kernel.=
org/

Thank you, best regards,
K. B.


