Return-Path: <linux-kernel+bounces-127232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1D894864
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AC21C217F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD1A4A39;
	Tue,  2 Apr 2024 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SE8bk2wY"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2027.outbound.protection.outlook.com [40.92.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD3ECF;
	Tue,  2 Apr 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017005; cv=fail; b=prJlGbeNkgmha94hyWD3d74hJ4pW7LkhYVrOaCUWx83jT7KMZVxilkDEqW5Rbl1dmpU02yWVghpNtCZORrK0xPgmkBGDOQJqeF+iKv6z4nCxR9PFX6u3wpm5Kaw/mGNyO5/Oll62NUhWnRgzLOkdX1STCd8rjGtxMm9JcHfT4VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017005; c=relaxed/simple;
	bh=8ZJ8lWf7jqpzPE6qXFB/HIPAQ9SYPt5CRoDWzMy6vnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHD+BGa13HrdZ+LTuR1mWe57B4qXH/Y+/fnHDkw7FFAwb6J4gVALPbJ1ig9wOD4NxPRU3ckDMZi1VXfPWBJrPRT+7Wr7NYtC4Cni6HRAOwyzERcWACxyI79UIx8j0IkEnljYdsWSD5ZSHn4KmHhRDHm41xFukL15d0O0XpoMU54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SE8bk2wY; arc=fail smtp.client-ip=40.92.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8vBQYi7H0OtgjDm758I2LrFi7Kp6st1/gy/1IIIoSV8ek+poIaXOhqq+h9lpdiZc8OdepRTVRFaer++Pd2iPKlOKRuw5oiDZR4xroclq4PVbk2YlIXCLhbdMUtJJWKA/B24kiSlssCRAWqm6nsjtLnAru7oqM3TYpGXk4LhajYn2KgFvSsDrjVFd9YPEn7O++gqT6l0xYBt4jWEBMH7/+u0Any9UHGrBwoaATC6IYu79wITcI7EWh0UerJ9Cx/q8Etg9CCFnNvbY8cUm77tBXIs/jz5Wj3rdcSn28L/ZrWzPaPuTKNf4+BGRvPmyycUFhKtqWQVLGcmvNtU+hTjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A83jCcDTOz7RcFC2rjzFKHWyaeOfpoTtymk6eVRBxk=;
 b=XVXmQdGkQAryfCfb+ouoe03iJ6FZZ/ufoyAbLcCDZbCzfx8IJmhwM4BgERnnC6M0of6LQwUEk1liPXMSePzjig9TpDgxQ1dV8HhVkRj0SGPZi1vq47ZKBHjlhGUzogTnyDIVBpY7Pm8XD/h3FJF15VfYfAPbmSQwUgo7iEU2p96FCoYWUGwyKnikNXXCSH8lLAMhopve49X+blwhRxIv1UeejfpvMxy0gUr6i53ywsdAfScPyQL0urWvMnwjkeSiP2ZUQPZz0nMXMIIG62rk0aoa8e1g3HFj7uaqHAt1LYvUyKHS+WwNcbwYtWv7JbVpikniG0Of8tHzfP8Mcati5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A83jCcDTOz7RcFC2rjzFKHWyaeOfpoTtymk6eVRBxk=;
 b=SE8bk2wY1BoPk/fYpTXZY3IGxn6u5hft901bG9EIUIPy47uxCwl69HiIUhtbtBWdJV0baPr0145v03JFIfosiedKrUho7SI/4hneAWzv9x/u4N2FwvCpNEsfJX5ql0WvWtxtTmCaYGOUUE5KBaWn6qAynRs9E/91joA2OaRUqVzPztkmRN1imyCQwisT31fJBUyxZVJuaiFeepE04ki+SF+GGYQ6ua27IDfJ/Fb1O7VSFZI6QVlw6jGTWX2jNWZfaxOuB7wW7O5y7AfCzcHBCiqyvptGQF3Vx1tfhtxEdT2L6K/M6IRzp6ILoiqaNreFBEj66jQHyx1AZkHRwYQ2tw==
Received: from MN0PR20MB4717.namprd20.prod.outlook.com (2603:10b6:208:3cf::20)
 by IA2PR20MB7306.namprd20.prod.outlook.com (2603:10b6:208:4ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 00:16:40 +0000
Received: from MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b]) by MN0PR20MB4717.namprd20.prod.outlook.com
 ([fe80::e0a3:f058:e169:988b%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 00:16:40 +0000
From: Mac Xu <mac.xxn@outlook.com>
To: Joe Perches <joe@perches.com>, Barry Song <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>
CC: "apw@canonical.com" <apw@canonical.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
	"chris@zankel.net" <chris@zankel.net>, "corbet@lwn.net" <corbet@lwn.net>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"v-songbaohua@oppo.com" <v-songbaohua@oppo.com>, Max Filippov
	<jcmvbkbc@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Charlemagne
 Lasse <charlemagnelasse@gmail.com>
Subject: Re: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Topic: [PATCH v5 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
Thread-Index: AQHag9MBE6nuZEX6x0OitxYUtdLwcLFSs1aAgAFq0i4=
Date: Tue, 2 Apr 2024 00:16:40 +0000
Message-ID:
 <MN0PR20MB471708D419907FFAF1DB0FC2F33E2@MN0PR20MB4717.namprd20.prod.outlook.com>
References: <20240401012120.6052-1-21cnbao@gmail.com>
	 <20240401012120.6052-3-21cnbao@gmail.com>
 <f5bb12d8602a03d28b2a8aeaffd8f74f001d692d.camel@perches.com>
In-Reply-To: <f5bb12d8602a03d28b2a8aeaffd8f74f001d692d.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [saOEMdzaOk+YeW9/4eIevOlz48ViBAki]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR20MB4717:EE_|IA2PR20MB7306:EE_
x-ms-office365-filtering-correlation-id: 8086c10e-b3fa-4803-ab03-08dc52aa2b7e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rdmdNOe1lHD/rrdkBO0POP/FTLC6k9NlCWpyd9UtzUGZrB/Km7ZdiWpcLIlYa5rUANZHhPAdAXQkKGp3KHO0pLJH/YwWa6G+wHMgiR7jWDMe5mpMOVSC6KbQOYAT7790Aa20G6qUyQ0U4HbRsMAko+hBB8haywq8JVwzzDbxmRP+yjwP5KHzjrT9DQGz1bERVyZgUpg5U48/VynqSRfLeyn+kZdclvi5OyMMy+JLvAvZK6FjjRNBIF5acz9ndUvrOIic1QsGTHm6bDePHTo1qEM7tkLKsId4JNRob4oU/hgHfUPOdm8xoNLF/N9xkcaGAiC8Au4FHQMxtXQU6AvrF2kf2jPGfTf+hIEAxylVSTNo77J3vHjymA1MGY8eVFaSGN2qwhe7olLa+CXHagM9zjhss4WDaIbR7Do1EabC4ovpi+3BlvefJWNK+EvaBXnHJRZv+5I25qtNpTPtwemdkOVJ4GUuZmKnM2FUxgZLh9JQyIUjnlhieJJpvYI1h3YxVg250vf47yLE/1J/2O4IKzOa2BgEQHxdeBkIgrBKNjAPWmtXEUsHK4xE8dX9GxTw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ELFjiU7yG8nCgBSjzE+OJcc+sz67YIUCpza2ywMPo37hX5OS36OEs3HG+w?=
 =?iso-8859-1?Q?hJXtZE6FLq827FndQfQi1QWj55WOuDUFaENGk9pDOlXZPg8KivL8pdSdfI?=
 =?iso-8859-1?Q?oU4F4bVe/ooPFbu/GTtUkZGTxrEFTf+D8wjnPi4mqzwWfeCZMguHQEETVl?=
 =?iso-8859-1?Q?cGXNqxjs+lzyHtfoXxOctYbEnSnHBzN5JeQOBtYnst7vn5EBRDYSqgtQFT?=
 =?iso-8859-1?Q?K4YtUUj8o/EwwT8pX6frk5QFOKcddocU6z28VfbPV4C2uba6YU6noNicHk?=
 =?iso-8859-1?Q?VosJlgCWYNBi4yZyhj9ax2W7PCCpiUBjSz9GzGYrgqBvtM9cCGiS2SPYLm?=
 =?iso-8859-1?Q?xpbLxvhJsI/Je0Fw32HLHqbceTHgXCZO2F3t4ELQg/GKYFFxdMyXi9Jo/6?=
 =?iso-8859-1?Q?64Pp9ZxfWy/w2lXnXUtuhYsSqi+bBhW7yclStBxwsILfDx43IKJH0dqyOo?=
 =?iso-8859-1?Q?0yF9PmjsZ9S0XDGye3lgFmqYFfBYpqpQ5+8xfptK12neLXQsweDJMMUSR+?=
 =?iso-8859-1?Q?+3vP6A71rJt7YFu595kBS4N+3DatC1Ows/4L7h7vU5DyeKPBFyCzn9F5FL?=
 =?iso-8859-1?Q?ei2qZpfmVKfZb6IJnogauDDDMLJaDzgOkHaBTIg1zBDbg5kw8IQD2GtC6P?=
 =?iso-8859-1?Q?jpJ1pTIsVX9109QHtg+HQeE7GisylAaZhjuStmy2k2zXSbR2xpotB68iTb?=
 =?iso-8859-1?Q?XGaua9YVkx9TwN0uL+l1Zen8ZvIF3ZC0s7AWhglmxQCPxGlKCA9BmkEWzZ?=
 =?iso-8859-1?Q?w5YGXO3TXLB9e4MIIPkIXVBvllHQdrGNw1xkMRYSnDbFqxH39PSpbZfuLr?=
 =?iso-8859-1?Q?aKnGOmKU/NJWM1Ebru7s/9F0RlXBoW152ye6MQQoiaTidrZ0MOlmt35kcf?=
 =?iso-8859-1?Q?kmR95h9a5SFL9g9kpa5r7sXaR4f56gJ9iubWtcaMBVPOV6jKiaHf+hHL0B?=
 =?iso-8859-1?Q?k8EfLW/MwhcONVBwYCvjHDXk0siTGB0ZPXt29TiczsM4nYZoBxBHPqakdE?=
 =?iso-8859-1?Q?UpGbX1Vfjkq8hE/KVzAvgT+nXV4iINnO/0TMZmP7l6OHHvSb4BS5yAzpxP?=
 =?iso-8859-1?Q?yfpDSpZlHGSi4O+SiLZdIAP4cia0Ft1U1TcIDc4JEkg+phjQQFg8MmZORG?=
 =?iso-8859-1?Q?Tv4AkS1bCywDLrWa5WInGbttq93i5DhziDsmZkG3Nd8qC8HzyXgN+2j77d?=
 =?iso-8859-1?Q?H2W/3FwyRbNzMLAaiAL6/D/k9XM/EhS/P6Hstmt3SARr9zRXJLQYx8VXPT?=
 =?iso-8859-1?Q?plbx8IXOzibSkDgV7tsQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR20MB4717.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8086c10e-b3fa-4803-ab03-08dc52aa2b7e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 00:16:40.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR20MB7306

=0A=
> On Mon, 2024-04-01 at 14:21 +1300, Barry Song wrote:=0A=
> > From: Xining Xu <mac.xxn@outlook.com>=0A=
> >=0A=
> > If function-like macros do not utilize a parameter, it might result in =
a=0A=
> > build warning.  In our coding style guidelines, we advocate for utilizi=
ng=0A=
> > static inline functions to replace such macros.  This patch verifies=0A=
> > compliance with the new rule.=0A=
> >=0A=
> > For a macro such as the one below,=0A=
> >=0A=
> >  #define test(a) do { } while (0)=0A=
> >=0A=
> > The test result is as follows.=0A=
> >=0A=
> >  ERROR: Parameter 'a' is not used in function-like macro, please use st=
atic=0A=
> >  inline instead=0A=
> >  #21: FILE: mm/init-mm.c:20:=0A=
> >  +#define test(a) do { } while (0)=0A=
> =0A=
> This is no longer true.=0A=
> Please update the ERROR->WARN and message as below=0A=
> =0A=
> Ideally, this would have an update to=0A=
> Documentation/dev-tools/checkpatch.rst=0A=
> =0A=
> to describe the new --verbose message type=0A=
=0A=
Hi Joe,=0A=
=0A=
Thank you for the comments, here's the code:=0A=
=0A=
+# check if this is an unused argument=0A=
+if ($define_stmt !~ /\b$arg\b/) {=0A=
+	WARN("MACRO_ARG_UNUSED",=0A=
+		"Argument '$arg' is not used in function-like macro\n" . "$herectx");=0A=
+}=0A=
=0A=
and here's the document for it which is inserted into the "Macros, Attribut=
es and=0A=
Symbols" section of checkpatch.rst starting from line 909:=0A=
+=0A=
+  **MACRO_ARG_UNUSED**=0A=
+    If function-like macros do not utilize a parameter, it might result=0A=
+    in a build warning. We advocate for utilizing static inline functions=
=0A=
+    to replace such macros.=0A=
+    For example, for a macro as below::=0A=
+=0A=
+      #define test(a) do { } while (0)=0A=
+=0A=
+    there would be a warning as below::=0A=
+=0A=
+      WARNING: Parameter 'a' is not used in function-like macro, please us=
e=0A=
+      static inline instead.=0A=
=0A=
Please let me know if the document needs further re-wording to make it help=
ful enough=0A=
to the readers.=0A=
=0A=
Thanks,=0A=
Xining=0A=

