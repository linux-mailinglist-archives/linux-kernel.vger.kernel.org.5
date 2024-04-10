Return-Path: <linux-kernel+bounces-137858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FA89E856
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8371F22D82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4989ABA31;
	Wed, 10 Apr 2024 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vNCm80i2"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2087.outbound.protection.outlook.com [40.92.107.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABAB8F5B;
	Wed, 10 Apr 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712717915; cv=fail; b=vAMr4wg75LIYCf4+A+nVEam5PVGdNyKLWZGuizY7qsoQxmZzdAaJLnsGqT73rcmJ7QvNz2lxh8lKozLR7xUwCNF0cGCJtm6nF0EV5W+t33/M+PPc+smWPgdZb+tpYs6pW5N9cbp1A4JKDMGBR3euqLnuyOTSNG72mmP+5CLX0Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712717915; c=relaxed/simple;
	bh=jop9AnWvdNBVv6XHUAbpGojmK/krpf7Lx8GSHfleF3s=;
	h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:MIME-Version; b=N7lwTS5WjSE65jdz5tyOAtAR1k4jLN21rAzYRydlIDT6WFMpQIDRZ2Du3D3RJr/aNWE7ti2bydpzVghYbvAjLTBB7d/RM/MDqMZhZkOQeGPNUyk1j3GhcYO2Fc80rlaSTFeIdJG5JPNXzpUcF3A5C1HvYQ2TOTDyOTGdsGvYpHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vNCm80i2; arc=fail smtp.client-ip=40.92.107.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUhcAgxJitoungRaheNhh2rwHgcVhsXiy9MR4RXxtkixM4xgWdGhHr3eJFv6VF85TULlRvg1fkxBZ/DL5cLN4FxPMWbZGdJpgHkgYmmDfMrsP9mosXrcfmkXifrKPRrE3yjCQf38FrYnfgAqrAS7z0+JyQyjo2KbqzOyWoHcdFbDWvAQWWplkt+4SEB8qM9Gg+f5qBdsnXKrsCzmQPbJhLe89Rh+r08x3aldk756wmlX8PNb9/c1zrstd3I+pCaAWhSWIBqHMH9J8i+3g+Pain2VGmemuJnNLbblHwk+mokHDonnvR2ZItHLApLhr17O7F2KNev6IN9QJtmZQGbqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLcEVO3Qq+HxeZpFbYPFQ7WzTDutopYJ404gisM3dmo=;
 b=iRDSbe3BcPK6qic2H4fMvPLhWzYSkE32AqKRcHWOiGGaJAugVqahvqS+5CCJborRFuK0W8bI8Y82hi4VETMWyHYmNEA1nuwJaOstvpxsIi2iHqnmiVPN6FOj4MvR3CQy2mVp7IW7Nd8faKmGqH4O62k3te9opc9nQ0irSxXQTMm9GaNM/KoN4+yjtyoWSlTrVE3My0L0TtS5XFYQLSULfCsHCOoP+NOe08DKnE/+OQ55A4ZCUuzzvkrMH4WRvrc7uqCDBJ8gpYoMeCQttGWYO2Gz/NrbCs2ZqEe4B7bvmTGowdKhOfDJrEXN27Ru52nj53DZPekapnNB3H75m2t6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLcEVO3Qq+HxeZpFbYPFQ7WzTDutopYJ404gisM3dmo=;
 b=vNCm80i2o8wR7m9BuGzFjnxmlbfU0iSMQMj0ntXZA4cM4NBEYXHX1TqRMcSWqFI28NbyyDLtuMxkO/jbxDq54WtRx/exQRz1F3k8tNdEYAPoS/MFT4p/rhfHTZVK8yVymYshFzc4WJrJ6aj5wPPBRuY38uR3SCXOMFmN9ih/lWQsvELHWjCMPMw8FiN9mT79Vhq/uKw+h4i+DaZiU9ITrr568V0adOZ5P22/NS+rhubGaLTxVljaaNn0uq/p+10Cnp0dRDec2xF570z+kccIZDAYtRVmtYgjWMwEQ2GmaAAicBByNue5W6OxL3NawGCXaDC1yjoBi4Uf0lFUcnGAWg==
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com (2603:1096:400:31e::8)
 by SEZPR06MB6301.apcprd06.prod.outlook.com (2603:1096:101:10e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 02:58:28 +0000
Received: from TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf]) by TY0PR06MB5611.apcprd06.prod.outlook.com
 ([fe80::d57a:9f0e:1ee7:85bf%5]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 02:58:28 +0000
X-Forwarded-Encrypted: i=1; AJvYcCUC8lDJy7EEVIAFj3HnUHeotACOv6wCye5NQRKgmXWlDnr2so7qXKblbAeCKZNjI0Sn1L1byIBKOeEAD4Ch5kMDE5SDgKIQde1EZEbpsouGmY5TJP9iqO+e+DvjZswVY+GNzU7X+uGr96UMfDZRKaogl56Ug8TbxFQf+CBvOQaorbmecJIl
X-Gm-Message-State: AOJu0Yw40s4+f/oZuqs2oblLoDz9gmQ+iCAXDYne8tOCP8zd12mtWEhi
	obq0MTs5Dt7jw2kFEEoZb0IT1R8D0nVS9+pXcQiEFjCJypz08rgK7eVa2zpqFp1+f1kvN82J8Ve
	VJFT2fOuv0kBOfSLOivliDTBMCkk=
X-Google-Smtp-Source: AGHT+IG/Q2D7QbviB9KwdUoHxNQEDFvihTlXLJPnUmkhrMWg/uz2JzVdDWcEyAfVI1tyBOnqELLzGgMbDBQG/rYLQYc=
X-Received: by 2002:a5d:69d0:0:b0:343:44db:6153 with SMTP id
 s16-20020a5d69d0000000b0034344db6153mr1235747wrw.42.1712717905181; Tue, 09
 Apr 2024 19:58:25 -0700 (PDT)
References: <TY0PR06MB561132DF147C037093A1B94D9E3E2@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <nycvar.YFH.7.76.2404031347540.20263@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2404031347540.20263@cbobk.fhfr.pm>
From: Allen Lin <allencl_lin@hotmail.com>
Date: Wed, 10 Apr 2024 10:58:13 +0800
X-Gmail-Original-Message-ID: <CAEr79DW+v2L0vB6tb9umTYX+bZpzUePDKnh_gApcTYLvdqk1Ng@mail.gmail.com>
Message-ID:
 <TY0PR06MB5611D1BC58464EEE3AF612DE9E062@TY0PR06MB5611.apcprd06.prod.outlook.com>
Subject: Re: [PATCH v2 0/4] HID: Add support for Himax HX83102j touchscreen
To: Jiri Kosina <jikos@kernel.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
	benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-TMN: [lA8/y629mBq0NmcshUBefq8l4nKPtX/K]
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To TY0PR06MB5611.apcprd06.prod.outlook.com
 (2603:1096:400:31e::8)
X-Microsoft-Original-Message-ID:
 <CAEr79DW+v2L0vB6tb9umTYX+bZpzUePDKnh_gApcTYLvdqk1Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5611:EE_|SEZPR06MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4c1162-3d3b-4191-e0a0-08dc590a191e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T+uqz+gP9DALFO4E77S63kFX+cQ0vWCHsqe3O3uNtRuG927qbW9E4s9GVjyykNpbenXhzdNAzkNGx5V17MWJuuQeqw65ANDhXM4kvnOCk5EQtgUtluxwoABmVGVbb7cmgkJcnYiAckyiLz9m5EMkKHDIrTejAaGWfGcd+ciKd7L9d6e37fK6RAAwtLSuPlVGvhu3loMmTuofJUKssUDRTO77eAaHVGLQbJyxnhPiTI/1LXBZUpFf6dtawNTr1JM1eZ/BVk+WW5m3+oHYXlJGf50HDvUYQyBUrbFv7ujH9+OVmy8w7Qq9SvOvhbaen17DfQCBfitXsVLlV6cwBmAPKVrs61RtCABW7DzqJJQ2aOzglFsSpfuxGn+dPvbh1LX5rXWpttkFlkAYJRKMS/ET9Ch/f8c6UXjhTIoBBm8udgYVenJ1DNl3UvHqiX+SngRqsU7qp41aZ1Zrul5/iajukUiPFaOhkpS2i/HqLoe82l8Njk/iUNj4VbySMl0wufwy5xgDQqxbrTrA4ukhiki+yFFqF5zJPLrKathhfD9LU/VM1ze1fzhlbuxKz/7MOWtC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzBoYjF4WnFXeWRJQlF2dTlFOFFUZjdPWE84YUg5UlpHY1hHUnlGQUxTaXpp?=
 =?utf-8?B?K3lQYTN2ZkU2bWREY0FNNk5TSmlDNGtaS0QrV05OVU02amptZUFudTh5RmFK?=
 =?utf-8?B?aXh4T0Y1ZnlDeUlsdjVsMWJLSmxBUU0wMGxiSUFkbSs0LzRmaHVIVU41R1V3?=
 =?utf-8?B?cDR3eUpXNEZkT05ZcWZjR2doTmlySnFVR2VxU2FkdWt4YWkrWVZsTmFXZ0dj?=
 =?utf-8?B?MkxRdzUrem9Wb1BlSUt3ZGdrUkJXLzU5WHo1N3gvcnlwUFRCNnZzTjdlWmUy?=
 =?utf-8?B?ZWNacjFMRFMyaEo4UXhsSmhvTndtY3g4VHNKNWxGNjV4QWFsMndQckwxT1JP?=
 =?utf-8?B?RkRSSlpxMHJhSVFObFMyeFNOMFIzY0VEQ1B1ZkFteUUvWjl2QzZhYlRlNzRn?=
 =?utf-8?B?ay9mdVhlUXJrZDAvd1FZZUptQkc0SDZvdnF3MUhUT0poRWppaWtsc2lpa2lM?=
 =?utf-8?B?aHg3dy9za21tOCtwdU9JakVJTTFZWE5vN0FZSEdjdCtGVHRjeDI0U1N4STZh?=
 =?utf-8?B?MjlMdmpBZ080M2NQZGY4T2g5U3B1cm9QS1NLSlhjQ1Y5QUdZdHpPeTZqYXN0?=
 =?utf-8?B?U3hMMzREdW8yK1ZlWDZvK0ZRMGxPTFNxVHFFM3h1RHBkUHl4ckUvMzBweGM1?=
 =?utf-8?B?Q1d4QUFkTUl3TjdsOTB5clRwOUdwSGdYTnNlZ3NEdjdzOHluRmd5L0xmMDls?=
 =?utf-8?B?RmRsWEZCNjByS1dnK2RvdmpyZ1FhM3MwYytkeTNKOFh1clBwNGtZR3BlQTVv?=
 =?utf-8?B?RUM4MWMvbzhhN29pbVJiQzhMWVdpdXFaN0xaY0JEMGxyMWQ2Y3UyclppNUIr?=
 =?utf-8?B?WkJMTlcvY3lVUDNrUldZWTZCSlp4Ulk2Mk90NGpwdUY2YkY3QlRZMy9HK2FS?=
 =?utf-8?B?Z2R1SjBrWVVodk1nZ1F2SEt6SUp6VWsybjFnREpURXY4UFI3a21Pc3l1c1Nl?=
 =?utf-8?B?ZUZxQmUvSzFOeGl0RFlXNGJ4L0l6YVlpckRUWmJkdW80Z0xvNkhHbjVXTWdu?=
 =?utf-8?B?K2lLRUc0QXIzOU5XcWVKYk94S1N2UmVSK3BITHF4THJmNU5xWXhnRkxXQjBn?=
 =?utf-8?B?T0pGMDBaOGdjNTZXeU9QSGVSTjVRL1E3Mm15aU5hMW9rZjZjK090dU9MWWVj?=
 =?utf-8?B?elhGUDlVd2xJc2dobVB3T3dod2xxSk12Rm51b3NtN2wyekl1V2I2YzA5Zysw?=
 =?utf-8?B?NUZDV3YzQzk0YXVoR0EyQldSYVlaREdHS2Fwejh1QjdlYm5CSjlPNk15eDZl?=
 =?utf-8?B?MjdaUFl3ajBaVE8rYXZ4NEJ0M1Q0ajVGS1h0UjlvcVZRVks0aGtGSEZkTzhw?=
 =?utf-8?B?c0ptT0tTd3JzMVZmS0pKVDdoZ0k3Vy9BV1Zld3JKRytUOWZJZXZXU3lYTTVJ?=
 =?utf-8?B?Y2ZpaVpidUplSjhmUGtsK2pUWjZlWWFyQ2ZxdTVhSWZud3REbGwxODdrWVJJ?=
 =?utf-8?B?R3pTMmJyUWxueVlLOGlVUE1YNVZETWtlemluNkh4d3QwQVRscngzZ0NFTHpB?=
 =?utf-8?B?S2tYMjdDemFCdlRKMXQ2SjFrdDNUdzhMdDFKV01jZWxWTVRlRkcwTGlKNGFr?=
 =?utf-8?B?T2hIVTVlRWxOb2NRR2tla2hXeUdYWDEyaldRdkNoMTdEYlNPTDlRZko0V0Rt?=
 =?utf-8?B?VklRMXdndTFrRllSZ1ZVTG9OeUdhekVTSW9IVGMrc2h4LzA3ZXBoN2xzUGYz?=
 =?utf-8?Q?hPADOImNZJBQzAulsHke?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4c1162-3d3b-4191-e0a0-08dc590a191e
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5611.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 02:58:28.8460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6301

Jiri Kosina <jikos@kernel.org> =E6=96=BC 2024=E5=B9=B44=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 2 Apr 2024, Allen_Lin wrote:
>
> > Hi,
> > This driver implements for Himax HID touchscreen HX83102j.
> >
> > Using SPI interface to receive/send HID packets.
> >
> > Changes in v2 :
> > -Added power description in YAML document.
> > -Added ddreset-gpios property in YAML document.
> > -Added firmware-name property in YAML document.
> > -Modified the description of pid.
> > -Modified the example.
> >
> > Allen_Lin (4):
> >   dt-bindings: input: Add Himax HX83102J touchscreen
> >   HID: Add Himax HX83102J touchscreen driver
> >   HID: Add DRM panel follower function
> >   HID: Load firmware directly from file to IC
> >
> >  .../input/touchscreen/himax,hx83102j.yaml     |  100 +
> >  MAINTAINERS                                   |    7 +
> >  drivers/hid/Kconfig                           |    7 +
> >  drivers/hid/Makefile                          |    2 +
> >  drivers/hid/hid-himax-83102j.c                | 3071 +++++++++++++++++
> >  drivers/hid/hid-himax-83102j.h                |  460 +++
>
> My only nit here -- could we please call the driver just hid-himax, to
> follow the pattern we generally use in this subsystem (drivers named afte=
r
> vendors).
>

83102j is our IC name, we add it to our driver name to distinguish
different ICs,
Can we just reserve this in driver name?

Thanks
Allen

> Please add Ack from Rob, rename the driver, resend, and I'll apply it.
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

