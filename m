Return-Path: <linux-kernel+bounces-166721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE88B9E89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633291C236E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27A15E5D4;
	Thu,  2 May 2024 16:26:43 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6861553BB
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667202; cv=none; b=LquU/ZivsyF0WBRBetTU1xLQkDLTNX5fHeShfRCfMyjc/vc+xZAXNf+OB05P8y1ieOf8C2AfX38dk1Zksz3ElCvc+MIITY1gXlmGZGqV0jy4b0njv3RMoA6XC8UaFnX0oar+qtK41Z02pZNBLZadZeh/iLocYDElsCcARpFs8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667202; c=relaxed/simple;
	bh=U3YldxXJcGf7WG0ecgFb0yY6/sPYuvXH992nRZL34Aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=oPlz9sfr/fb7Orlw0H9WPKqHkWZSzh2W1mfyYoGVGoOmCQYtBibpn12x2OupPfuO6pDZhx5dJ9Ad5tykFTFFN/i/NgXHYljhHjoALfEC0/HFnWMK/1z6/ilFB9O8PWxpTTzIW6aRk8ORlFT6XTiBW2Jmh+H1zQEhkOcVMyEPXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-319-8JfQbD0yNe2epfzRFaAXmw-1; Thu, 02 May 2024 17:26:28 +0100
X-MC-Unique: 8JfQbD0yNe2epfzRFaAXmw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 2 May
 2024 17:25:58 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 2 May 2024 17:25:58 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jules Irenge' <jbi.octave@gmail.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Topic: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Thread-Index: AQHamYq9w5OrjuroEEyWIm0jPSXs6bGEJ7/A
Date: Thu, 2 May 2024 16:25:58 +0000
Message-ID: <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
References: <Zi57-TMgU19puaQM@octinomon.home>
In-Reply-To: <Zi57-TMgU19puaQM@octinomon.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jules Irenge <jbi.octave@gmail.com>
> Sent: 28 April 2024 17:40
>=20
> do_div() truncates a u64 divisor to 32 bit.
> This can lead to non-zero being truncated to zero for division.
>=20
> Fix coccinelle warning
> WARNING: do_div() does a 64-by-32 division, please consider using div64_u=
64 instead
>=20
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  arch/x86/events/amd/power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
> index 37d5b380516e..ff003c1a645b 100644
> --- a/arch/x86/events/amd/power.c
> +++ b/arch/x86/events/amd/power.c
> @@ -64,7 +64,7 @@ static void event_update(struct perf_event *event)
>  =09delta *=3D cpu_pwr_sample_ratio * 1000;
>  =09tdelta =3D new_ptsc - prev_ptsc;
>=20
> -=09do_div(delta, tdelta);
> +=09div64_u64(delta, tdelta);

Nak - you've not tested it.

=09David

>  =09local64_add(delta, &event->count);
>  }
>=20
> --
> 2.43.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


