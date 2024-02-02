Return-Path: <linux-kernel+bounces-49701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE76846E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47521F2B153
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827E137C41;
	Fri,  2 Feb 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=asem.it header.i=@asem.it header.b="KzwB9xIq"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CDEF508;
	Fri,  2 Feb 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871158; cv=fail; b=Q+pu1Yju+nl9hI5FuHSKHxNowmxKZw4x/KoLogcZnmwcQY3tjUr9naV15ewvts/3Mwn83indyy/CTzWpa02DI/dqFDi/OB1XjJhRbIcpsgD5rZ2DQaYiYebUa/Iuq2DiOQlPSDNxhaBkcSuVNaSCdFs/Ic6rJin+FIh4Cs8yEtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871158; c=relaxed/simple;
	bh=hFz6nkb4Sc4H5bDlodOrbTXbjuA840k/wLNGSV8EMCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c96IBbjOaHK5G3QQbbzDqKAxXomIlIgI9i0LTfWRy2PjaF+xFicN+01wLVE7xFqasrMCzTnKYiFOa8rwSZFHWtCwQBjBHuf80KulVFIrEzpt4ILoR0EQKZ3F/Z6QG7KZ8MhsB/1LB30gQ2f5vmwDM2NGSWyfIgPfOawDBEH03Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b=KzwB9xIq; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asIQyp/KXci3lyxrQB27/MOEqBMDRmtXTFE5l0PvZxikcTzRp+YfpVeTVdVlKKSUX6YLZQ/zpZk5kdaLfYfIkomKgU+itxsXfFMg5+c1BmSyM/aIFzkAhNGhsD5C/Cj2+vJoqlPEzX5If0t//HP2Mk3oB3yxgKuwxYM6IDNpFksXJI3oSAAVsDbyG63iTGByfYxzB+IfrBS30OTzks7/9YPBYFcMPNeSNa+QBDuh5FmyCfeM3G5IvWGrZwFfwsM1tucNTWSOLs137xUNTKAl+x4m180+BkWlrJMP6HuEtk0By87Cg1trN3F3oD5TC367cyo5bTAdYwutJ0zDhzV4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCPjBpPE4EcVfMwTYFY6l2PdmyqghoBqOhtsWHsePiI=;
 b=lL+L6n+4QQzfDyKUSE2tZRLQZOyFnv0AknmsNpO+UIUjRhqzK9zxdKHvgILbnt3xKj4gXuhkmLw7y8xZjNksoTFKBxttk6sI+T9Dvd1P+5CEj/x8GMdbwQclQUC4acbTy1vBQrxwxfjdfaWXI6HmTGPI/DLYYqOxqDzhMynE1Jn4/z4DWpcNRcbwLAhxXxJK14vsWS1rj1aeXCEYOwv5xqaXvApg+7/gLAWDkhGhQHdi2TMBfASRMqfDx71Sacg4wLu7mCHqxtxxiBdjx6KNWuU40T64yc/D3pbU48mB32TPl+iDNINV+zOV64i34CBeADhDx1Tz/GyrSMp5+RO53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCPjBpPE4EcVfMwTYFY6l2PdmyqghoBqOhtsWHsePiI=;
 b=KzwB9xIqTpihSMwwQMyF94ICfnxPeOwsnK2GJLtL/JoiwwsmvZGMlCH+FYIQnzEYSi1Or/s3aUnDEroBl0gO3p8fg5nWg0S1GKZTO+wDe9okHDSSyo7P0/5aE3Bw2lF8tEsBpUVxYdel+vkj/1sSXeE/4NJN7KK02ElF2hM0Jgo=
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:273::14) by AS2PR01MB10291.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:5e9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 10:52:32 +0000
Received: from DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::f272:d554:d6b7:13cd]) by DU2PR01MB8034.eurprd01.prod.exchangelabs.com
 ([fe80::f272:d554:d6b7:13cd%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 10:52:32 +0000
From: Flavio Suligoi <f.suligoi@asem.it>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: RE: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Thread-Topic: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
 platforms
Thread-Index: AQHaVSJj4ATnO/nYS0S6xCnSjXvlN7D24Lmw
Date: Fri, 2 Feb 2024 10:52:32 +0000
Message-ID:
 <DU2PR01MB80349345B0C1757C6958107FF9422@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
References: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR01MB8034:EE_|AS2PR01MB10291:EE_
x-ms-office365-filtering-correlation-id: cddaaef1-4806-4485-0075-08dc23dd0ef5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vQ/EZrqfCfoSW7UeFruqeNgsksEY1/vxFJBc7DjRa03xzJmjTwGexGhz6pbB0BQke8sW4xITAei9ZbTejF+RwtbxgnPMX91uJPGYmaN7VCEwTFiasTfa2gaONaQVaQy0WJACPfVLld45JrM5yGay1v6KvefXXk7XG8UPH7sdOaJyzYA8RoVm5LT9kI1BSkXZZ05WjpfbolpQEvhdVNonurO+d1NH0xIRRw3/zeGbgQs3Z6CEQ9rvZbLNr8CRMd7OTTB9f0tSAultWCSHpbbDL0GbNw1U/JgsRrM7WPdmxOGyKqvUIJE+nJseu1WG5wBzhT0SdAHLGlXdsbmT4Buxcq+HQFyK0ElNMx0P/hyw3GeweiaoMqQiVAjk2SuRPwBJUiloveIbT8pkoJVWE5ZKmThZGFO6/p9K5F+qUBVIHfXZU8OIM9RnOOPWbv7ImWY1U3sNAJTt2P23WxUTASas+VM3Xrur26ijeup8vOdipUS5aPGsJo/uCaXNLlP8eIcrxvXDu40V26pco7VfAdCw6rTTieECHTnXUy22TJ8pbTC97K/pkKHd0b5JeL71SJnehosoabm+VWpRfeKCLpC2KW5SHlAjarYX625l/wzyUK2JZv9S+LZ2cD8ZkBIGM8Lj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8034.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(4744005)(478600001)(8676002)(33656002)(86362001)(6506007)(71200400001)(7696005)(4326008)(66446008)(66556008)(66476007)(110136005)(76116006)(66946007)(8936002)(64756008)(54906003)(316002)(122000001)(38100700002)(41300700001)(26005)(52536014)(9686003)(38070700009)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kULOdlY9Wd1CsIA96Lhkp+6/R+JfcHUKnBXBbrnhRQE3BDxrh3HhExrG26tv?=
 =?us-ascii?Q?sl3AMpMY+fKKDGQJcnaewNI+ZF324lrDurF/PBea3OPmFnD4i+JatU65KXxE?=
 =?us-ascii?Q?AqfGNKbHdIl7mHZIqrtyEFqobn2cGx1KZBGW9wetvK1L60WYcPYXwDbzhWXS?=
 =?us-ascii?Q?moW0fBwczTY3KpR12irSusdl/Ic2RYEmK44bRpVTxGlxl14Lpzxp8t/n6bI5?=
 =?us-ascii?Q?JR6jaqFZyI+gckpPUVIkiANgIoed3ZzjtYUuOw5CgVRIHRTsjZ2l37e9Zq07?=
 =?us-ascii?Q?O3qC9DubTTUaAAsowr9m/QmEWrtddGtjEWYFOEczH9KAHa6VZbjwkh5AQrhH?=
 =?us-ascii?Q?7ijm5bStT3SxPdWEJEwvkUAnrltFCfMlfmDPVKLTMWPCxAdtoSL2Edj959gt?=
 =?us-ascii?Q?OE/qyGjE2AN8iwRjwl7U3QZZS1LOs2/apbs++2MMdoovfXlJUmmgjYYOIEAm?=
 =?us-ascii?Q?qpBPeR4ySPkkmCdi9VkMzo7gLVYEVTD/as2/3+ggFLlR7j/ze8X0LMtFSStv?=
 =?us-ascii?Q?jwF+92h0sRsj3+gxkHfpCo7D4g/cFRTuTbdidOOkM45FdZcg6J23x3SRxidW?=
 =?us-ascii?Q?zmNVotmia2wRBQb0BFbkBqGUWnCSd4URt4Jl4XxP8wzLieH5wKh5GituzNIJ?=
 =?us-ascii?Q?9u0bt3P2U6FmfCDQ/VqHfIUK3mEUD7LNYVVxPHqd7k4Eyw79bVT7cNjRpStF?=
 =?us-ascii?Q?klcBkDu/3NfR6Vqs6fNRhdIYiX4VjbIYCUGXYuxKDtCW81YxxnFrWDgMyNf2?=
 =?us-ascii?Q?PEJH2CWJGKkPuGhvDTd+8kCORXRvFdAdxcd1UtDwJl16PrKwqfSS7HjuWn8z?=
 =?us-ascii?Q?TjYXkJb0kI7ldRJpoVUCb0BvxoiCE5CYNG35PcT/ZaGHDA6nnseJ5sQYEJSw?=
 =?us-ascii?Q?4pP42xiVfZ3kXqx0JYX+6b7Jq1wUjuB4hRWEyY2GsiQpVscz6Se/yBAbaAjQ?=
 =?us-ascii?Q?rQ5dU93CRrjosA1s37RA53oX40iRZ8G2SJow41v9zycij4kPs9RFZLRRnZpn?=
 =?us-ascii?Q?mRduMu4l51qIJ1rSDTrfxuAiDyu09x7EeVmKPsGGwdokEzyBac+jIRaiyi12?=
 =?us-ascii?Q?+uuOdOlgmJbc6/+gSpha30YDKd+a3WKCSsVBKnFc/wgCrb9GNC1VO4IRyrhZ?=
 =?us-ascii?Q?ZIn7jAFLnkUuy3TqlfXWvUzlJ310GfCT2JSbAHJivwq09jshMhxIXVe13+zA?=
 =?us-ascii?Q?AKIHEDfgOWlp4DMqJz5FVtCbb5EDxtVuDjFCLlZC8ncPqNQW3vR03dnwYuLT?=
 =?us-ascii?Q?b60G9M5Fu21g55gYnkuyCSHEOkG9mbeP6SFlfQcRg7P1sDes7htRyXwiJW46?=
 =?us-ascii?Q?GGClPGXAhwyVBzqVZ4fZg+tW/jLlHFOuM+rAb+8UWPIkATTdU5PLOY9HqDhX?=
 =?us-ascii?Q?Lca8+5S39tupfQS3cS3jzt4fFN2GFxjdw+XKubaV7D6JhgPuPKm4vDbE6ceZ?=
 =?us-ascii?Q?GxmMXqu3AhfrRJp9Z9C9voijMjLuMVaXrl8L/vMLUZdgN0AlENiTjsmQuR9n?=
 =?us-ascii?Q?O81ot8jYtlz16OXMGBXABlW4RT88Pdx1R3DBPJO/cn45KOyQuqZMNkk40v0C?=
 =?us-ascii?Q?fTbcRvg61oipprW79Aw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8034.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddaaef1-4806-4485-0075-08dc23dd0ef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:52:32.5402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vidHsdALLsQwJwA9vKX+KYWSllFN8ZcdvE0K0+SUbE4FxBXVXDtb6g77LJ8BQgws+vgviqIWnMue+0HOM5oOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR01MB10291

Hi Andy,

..

> Subject: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF
> platforms
>=20
> Allow to use driver on non-OF platforms and other cleanups.
>=20
> Changelog v2:
> - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)
> - add tags (Daniel, Flavio)
> - new patch 2
>=20
> Andy Shevchenko (3):
>   backlight: mp3309c: Make use of device properties
>   backlight: mp3309c: use dev_err_probe() instead of dev_err()
>   backlight: mp3309c: Utilise temporary variable for struct device
..
I've just tested again all your three patches (using the last 8.8.0-rc1 for=
-backlight-next )  on my board and all is ok.

Thanks,
Flavio

