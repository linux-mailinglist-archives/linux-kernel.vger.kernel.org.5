Return-Path: <linux-kernel+bounces-145442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539E8A5631
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00E228378D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0357F490;
	Mon, 15 Apr 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="AMYCnavu"
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazon11022019.outbound.protection.outlook.com [52.101.154.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAB77F08;
	Mon, 15 Apr 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194339; cv=fail; b=rrZ9OMNBE7hxyllwcSxtnBL9sc0fFTIbHOWOM0+jd1Oyq2HUYtrQ9cm5n99OjeVTy5gKIMilfg+MZU9nG+sgMGtBEQHaKxPEKDDtwmWNk1iY42v4k8lppdSg+QxwZUkEmOmUT+TaFgXjayXrguwlo+Rm09/fzSnxoHwBiRTd+7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194339; c=relaxed/simple;
	bh=U6vh1pjozdz1g+1Sxol6LWoF/STCmSsE7+Xj0N6hdCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADWHlfdvy9Sb9Y/6SWVEt+LoNKhNVwJss5BZYRpFkaxsbzZsNRqIGP1yz3HhqF/WrgXgBpIhWwjqZWUuD94bCJDVnQ5zLhajBmVa5CyGIREFOc+e07Pg/41293Mg1F6ng58cLDvBd8/GNcATjRH77sNXM9rGwEY/mjyfmyn9eIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com; spf=pass smtp.mailfrom=chipsnmedia.com; dkim=pass (1024-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=AMYCnavu; arc=fail smtp.client-ip=52.101.154.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5gQf0O+ZJT0TzcXmIVUtj6Xj3DHNuSTzcFvaUJPlTe5h3LpaK8pmJHhG5WL0h0HpsK9kZrRVNFCKIsAtMHXB2HhziJR1E3R+TjwxbKK7PQpqEqi8q62rYwLQ7XWTb3gpScABbgQRLc0OzWZ3guHWGGLVf+o2dTO/4tsOxkMuIn68fzSKw2V7xPpBShY8Pi4qfiI+168QznyCWRTue/7H9s5vFmIukAAkoeJ1lgt4P3yzlYQY6caSSMem6ngd+16t5tREUaaOSusAXgR2D4g4nSKx6u0viI7Si12RCHcqOdL6bfQwPSQR4eYWAmT4JHH8D98vG6GoHn/cG0OpoNMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAbMVDKi8auMmaBauPHVgNIGRDx7UQ+h96/c2YAo4js=;
 b=XW48UYjzMeTw+8Y9cDBK0bdjiY9Cyo0436dAtDYViRfurDMQLhgWZcseD5mqT6lX3cacJvYXnzQNQ2h4+my6qx+38x56n1JWslTUEwmGgJkOLbdBoX2um2n5+bhe0LQfgsiuyn6Oktays5PwSFHsldaM8V7D+4L686kz8yjQM4Gpe+jn/6yqN6bNZi3qfCyclCld/FBbVirLzT7aJiQuQ9XxCmBxRvnE1wNnHOQKCJFzzJqKPoH0RL4ivqBNe6AtF0gIvi1t3hrdyCbsp2Ljw+Hltl0idsoYcQ7XE3KbbPdE71b0dRC0Ay5EAh2NwqLoz3T7tEntlYww14uUyagySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAbMVDKi8auMmaBauPHVgNIGRDx7UQ+h96/c2YAo4js=;
 b=AMYCnavu000HxFquIONtQ9epOOtmVthOo07fZgKESS2NGRjsK8ZgpgsWCEggdxV3xLO9RTeG9vedC+HMscq7pnUSN0cmujc4wip/YwWCPQo5uJbzQIJZS+yrqZxF3ZjHdn5R8qO0zSX795i1y1r1nxBQoT+u750dIE2nKQ8OBws=
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15::5) by
 PU4P216MB1819.KORP216.PROD.OUTLOOK.COM (2603:1096:301:109::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 15:18:53 +0000
Received: from SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b]) by SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
 ([fe80::b711:5ab1:b5a4:d01b%6]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 15:18:53 +0000
From: jackson.lee <jackson.lee@chipsnmedia.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
CC: Nas Chung <nas.chung@chipsnmedia.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Sebastian
 Fricke <sebastian.fricke@collabora.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: RE: [PATCH v3 0/5] Wave515 decoder IP support
Thread-Topic: RE: [PATCH v3 0/5] Wave515 decoder IP support
Thread-Index: AQHah3gdQC6P/IVPV0iUT4LRIjlhhbFiwQfQgAAXkACABqh70A==
Date: Mon, 15 Apr 2024 15:18:52 +0000
Message-ID:
 <SE1P216MB1303E7A1989D018A0A14FA28ED092@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
 <SE1P216MB130385EC5A67C80D9CB61522ED052@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
 <hxgmjezr77jpa4uw45w2inple7t3zkb3ol4qlpgu3p6znuiil7@24h26cqmm2vm>
In-Reply-To: <hxgmjezr77jpa4uw45w2inple7t3zkb3ol4qlpgu3p6znuiil7@24h26cqmm2vm>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE1P216MB1303:EE_|PU4P216MB1819:EE_
x-ms-office365-filtering-correlation-id: 1354cccd-174d-4de5-6f62-08dc5d5f5c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +K4sy2hcvYeGayslsc/efFKewpPc6XXERAy7jEa3xODydBNkM2DYeYFQ22mhL5EwYGmhdS4FEFTAfZWQZpiWCfCujGj7/QF1EP5b/2fb2kN+KdY6ssO1UUb+Qm8nzHNzlGJlJjidWX7yt++pp9CjdjPvXcoYp4rePctNY4uqIv9OmR2vQCDgkNUIu7ijUlVtP6iKioTleCytkmejW2Kn9yMqbJgBL7CjezovakUFB/TaaLN/dQofSPhH0vRorZSUf9omRVW19fEJC9iEnSruu9lMUvICj49Efm9GtoSzkX7uldudSy2bYO9Zqyh33r8so0y4xGcJr8Ioa+64tZn5nxYb4+kvOTsJ//RzVFE/t7lYuq2owz9gmbT9RS2LJJ2VKEv7YKAYiq0Q9i8YSchRTxADZEAqHP0zVMVlQ489ClMa8VjtD+L85z5Q3Bn5+2LI+VZIAaoiAK/r1QlVxBPHHiSSi7oNFor81mkLi/5ptV2SXGF8qDPZOR0xOpXdWlfTW3QSQdxaqXrvtSHzZPbW+kDtuG3a4ISHhlNX9FrDCmGhx1oLxknYeii8Ep63XQr2a0fzW4Szxwrwl7ujwlxZG+fRYBP8h/l7Bl4HCpNZQv82ZoRapiZEnJH0JcPpN3a2X7vIkEwJ4/JuV/0dJ7mKR768Nkt/UVCY61H4vO/JdjaYyI/Wh2uMFQKX3fCefwFZ4rsc8oQugGqShU5sDZ6gvw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1303.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ejH1dib2tV39KcX2bYSibst6//rNdbS51miJla0zjzbS7vPEmbqpc1O0rTHC?=
 =?us-ascii?Q?08RRVvdC3Ss9cNWO21czit8BtEOn6TpQR1Vj3S36a9nBhIwABp+Ecw7MSxsc?=
 =?us-ascii?Q?7wbJ6zU8ckVL893KyPe8DMOEZfzmDRLFAYwKYNEScMd5DQEwt8kc3iF7X7lv?=
 =?us-ascii?Q?5rxaV3Z2/nrQNHBSWchmsw/aOkQ1NSXBUBMqE0gMcONUgngPDERIWmiv+Xra?=
 =?us-ascii?Q?/i8bV73Eu6qNGrbspol4HBOylgzfFvfzpUu7suxUoCtbUQiqQxtzwZq6zOwO?=
 =?us-ascii?Q?QrUdsG+tBOGuhM+hooOo/Lia3NB5TLHpIKYO/cc9IijNkJGZg4DZ1b0Ahq0i?=
 =?us-ascii?Q?dcqhK5UCIk3hIFd3DCsk6sVON8xxgqXV7MAX7XZ456EDhNTy8xZAYcz8Z6n5?=
 =?us-ascii?Q?XFxvaRl5mXiDVXg0hjLutkehfkXgWle89gJzRT3VkVe0Aw7cUEpd4WLxrrdM?=
 =?us-ascii?Q?j3+F7LEKEKXbEOwp5PIML5EeEIU5tOT7HA+KhnV2tm4fiTOS3V+iNMWtw8en?=
 =?us-ascii?Q?h6a2n2XGIXC1QrvdLMAB+NB3R7jX9giSpRvK0AJdGQm+Hs0zmnkMwc7yYRol?=
 =?us-ascii?Q?T/3p5MMZcBlC6L03/ZJ5F3xYweh+FBupiHCuIs2ivNr4ZEzzb3UW0+p3kf4k?=
 =?us-ascii?Q?4MNTW0vwEGOKQF80+li+snBhvYADOtigJtohYcTF6tXwwzF5mAMlL/Dk4UWj?=
 =?us-ascii?Q?q4/Pjby9EBNNhtMe7wPV8ik2bfupL0JdwBOG+J22ENdaHuBoOx4Xcr/Ih547?=
 =?us-ascii?Q?AxKh0GIyLEKZYAf+/dsfkdTARdETZC7Qqvp/b6vfzAEOMCcicwKIyc4SIEDE?=
 =?us-ascii?Q?RjzbcvRAbPrIb97R5bN/JfTINWgjZ7WN5UQfAK2DAsuk8sgBlTjrnQBmA74I?=
 =?us-ascii?Q?GoBcJ6baAXg2yCf0C2yRNIHrrtB1JCwWrs7hps6lvZnIXeqPX/QSzmjuq4e7?=
 =?us-ascii?Q?/v8J7SUdLTjllnjDqMYrJsZ+yJbd3+f0EfNAL4CmkxEMOIdcmMsFbbGH+0VG?=
 =?us-ascii?Q?yCOGV0i2/jp/uNHR9oDVh3uOct89ivDGHuUZsJzngWi8cnY4vV56LfYZ7GTi?=
 =?us-ascii?Q?ekt5ND0igPHFsWVCfT/ZOvXeehx5LjCIewYAAdDfl45mE74c8QeesAgFLQNy?=
 =?us-ascii?Q?FXSU453ugVY0ZnraabvpgwPDV7C9cVyiG+EYsFJqHfFMFxCH60LEG5JEAKZl?=
 =?us-ascii?Q?s1XSsacmcWZwJ5YttsOTFkHtc/ml14o6tyukBqX3YXxK6bDYPvBfm2TrqaMq?=
 =?us-ascii?Q?srH4gUpzBMGIKDm2UCgAourTZbrf8GbSFlec0DDP9GoPx2rWy9Mp732Z7LEd?=
 =?us-ascii?Q?1D+9tKj/HROBOqBseV67RWQ/ENBhQC1DWGHpJu1zjyQPgCHe7CDhX8yCAoOo?=
 =?us-ascii?Q?mO5nQvmDpuUjARZ2cHH8Fi2NJWiXnYSpvmj4wR4Mz3e6NtcOfT1b0GyPgz/x?=
 =?us-ascii?Q?+jjc/0nLSP87fG9chFezFWZWMOLaKTNK6BVwRYHrccdAV98An+otEN/uhQoP?=
 =?us-ascii?Q?2Y5bnX0u5KGo0Bh0gSV0GrGw6VNBA0geA7U3OmUZtDzvDJdYqHahR5eVM9Zo?=
 =?us-ascii?Q?uRMrajyLFMybU6bWlZBdBz8XALQilXBKaH8pXZWvKkV2Zva8DLz0YIfIFiy+?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1303.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1354cccd-174d-4de5-6f62-08dc5d5f5c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 15:18:52.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwhNlpGQVr/uKfEXE9pj9KLFcyENo4HzAuCpidUwr7wRwqrBfMefGzKz+uONz/6R+6biM93t/ed1tV5wzRxX8qUrSAM60E97sVlFmEdofTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1819

Hi Ivan

> -----Original Message-----
> From: Ivan Bornyakov <brnkv.i1@gmail.com>
> Sent: Thursday, April 11, 2024 6:37 PM
> To: jackson.lee <jackson.lee@chipsnmedia.com>
> Cc: Nas Chung <nas.chung@chipsnmedia.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>; Sebastian
> Fricke <sebastian.fricke@collabora.com>; linux-media@vger.kernel.org; lin=
ux-
> kernel@vger.kernel.org
> Subject: Re: RE: [PATCH v3 0/5] Wave515 decoder IP support
>=20
> Hi
>=20
> On Thu, Apr 11, 2024 at 08:13:39AM +0000, jackson.lee wrote:
> > Hi Ivan
> >
> > Can you provide a score for testing a fluster tool so that we can verif=
y
> the change on your HW?
> >
>=20
> I did that, didn't I?
>=20
> > Thanks
> > Jackson
> >
> > > -----Original Message-----
> > > From: Ivan Bornyakov <brnkv.i1@gmail.com>
> > > Sent: Saturday, April 6, 2024 1:41 AM
> > > To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> > > <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab
> > > <mchehab@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> > > Sebastian Fricke <sebastian.fricke@collabora.com>
> > > Cc: Ivan Bornyakov <brnkv.i1@gmail.com>;
> > > linux-media@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: [PATCH v3 0/5] Wave515 decoder IP support
> > >
> > > Initial support for Wave515 multi-decoder IP among other refinements.
> > > This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded=
.
> > >
> > > fluster score for JCT-VC-HEVC_V1 testsuite with
> > > GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
> > >
>=20
> Here it is. Above is the score, below is notes about failed tests.
>=20

I didn't see that, It is enough for HEVC

> > > The issue with Main10 tests is that fluster expects decoded file to
> > > be in yuv420p10le format while this driver decodes HEVC Main10 into
> > > 8-bit yuv420p. Though result is looks alright to the naked eye,
> > > proper decoding into yuv420p10le is to be added.
> > >
> > > The rest failed fluster tests are common with Wave521.
> > >
> > > ChangeLog:
> > >   v1:
> > > https://lore.kernel.org/linux-media/20240318144225.30835-1-
> > > brnkv.i1@gmail.com/
> > >   v2:
> > > https://lore.kernel.org/linux-media/20240325064102.9278-1-
> > > brnkv.i1@gmail.com/
> > >     * drop patch "dt-bindings: media: cnm,wave521c: drop resets
> > > restriction"
> > >       The only user of Wave5 in mainline is TI K3 boards, thus there =
is
> > >       no real need to alter dt-bindings
> > >     * in patch "media: chips-media: wave5: support decoding HEVC
> > > Main10 profile"
> > >       add check for flag "support_hevc10bit_dec"
> > >     * in patch "media: chips-media: wave5: support reset lines" move
> > >       reset_control_deassert() out of else branch, add
> > >       reset_control_assert() to probe error path.
> > >     * rework patch "media: chips-media: wave5: drop "sram-size" DT pr=
op"
> > >        - don't move alloc/free form device open/close
> > >        - intead of exact configuration of reserved SRAM memory in DT =
and
> > > 	 allocating all of it, allocate all available SRAM memory up to
> > > 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
> > >     * adjust patch "media: chips-media: wave5: support Wave515 decode=
r"
> > >       according to changes in patches
> > >       "media: chips-media: wave5: support decoding HEVC Main10 profil=
e"
> and
> > >       "media: chips-media: wave5: drop "sram-size" DT prop"
> > >   v3:
> > >     * reword patch "media: chips-media: wave5: separate irq setup rou=
tine"
> > >       a bit.
> > >     * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
> > >        - move MAX_SRAM_SIZE define into match_data->sram_size
> > >        - add placeholders for validation that allocated SRAM memory i=
s
> > > 	 enough to encode/decode bitstream of given resolution before
> > > 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
> > >        - reword accordingly
> > >     * in patch "media: chips-media: wave5: support Wave515 decoder"
> > >        - add comments around SRAM memory allocation/freeing about
> > > 	 Wave515 specifics
> > >        - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
> > > 	 W5_BS_OPTION register
> > >        - add W[AVE]521_ prefix to defines, for wich there are W[AVE]5=
15_
> > > 	 alternatieves
> > >        - add semi-magic Wave515 specific formulas to estimate SRAM
> > > usage
> > >
> > > Ivan Bornyakov (5):
> > >   media: chips-media: wave5: support decoding HEVC Main10 profile
> > >   media: chips-media: wave5: support reset lines
> > >   media: chips-media: wave5: separate irq setup routine
> > >   media: chips-media: wave5: drop "sram-size" DT prop
> > >   media: chips-media: wave5: support Wave515 decoder
> > >
> > >  .../platform/chips-media/wave5/wave5-helper.c |   8 +-
> > >  .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++---=
--
> > >  .../chips-media/wave5/wave5-regdefine.h       |   5 +
> > >  .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
> > >  .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
> > >  .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
> > >  .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
> > >  .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
> > >  .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
> > >  .../media/platform/chips-media/wave5/wave5.h  |   6 +
> > >  10 files changed, 407 insertions(+), 141 deletions(-)
> > >
> > > --
> > > 2.44.0
> >

