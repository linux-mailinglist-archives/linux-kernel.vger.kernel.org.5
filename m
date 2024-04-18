Return-Path: <linux-kernel+bounces-149667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775078A944B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EDD1F228D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065D76050;
	Thu, 18 Apr 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0og1/1b"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD952745D6;
	Thu, 18 Apr 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426073; cv=fail; b=rkJbNvNFDk+v5Pny+dzwcuusl+PiTmzgH+vJE/UdMYMDfuAaezLOG0uaT20bsILfaXq984Dnm5OVu3R6eVmXTVpF0eF4L+usZsQK4tVuEmJRRP4W1KFNBipXs7FSpypTmArU+Z6KRD6h8AN6R1xXNGLfoGYsKKCoe8q47UOkFnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426073; c=relaxed/simple;
	bh=RZ7SMAklsWRDBBxtrunnJ86mn646CQa9Kiravlw1+mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bemlr9gO1n3/9WVX2i/8QIy2gwCC6Nf31do+O2adxAYAV1x9VAaCApKkHSwJQPepBhHP+qTicVg4GcsaDkU/Rw494+7aBy+OaMKJcuky3B8vZbCzPewW+S1Iy+zkOI+8zR197IMantKQjn9KazMCqffB9PzxQwfg9v0oWB6TKy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0og1/1b; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkKjSn1x7E+ogCyCdIHyUht1zjyJlFRT5ooL/5PMiwwbk/kl7z9WPK4L+l7mHuIj8lReGYOCfe2lzJv0Vi5U/HJ++ITTVxWsUh/zJc0usoJH6tlFaL2tXISu6wLBcLDp20Yu3O4BFvL3Tbq9+kAsC+nY0olA5s/RMgsA6dy13YWub5k0SamLmMiH/vpXJAF9/e7SP37Np9yJ/BFggJKAa5L9Q7B3/o+idLXNK5efv0UJqGkmem+6RHrp0fIZoU0gO4/BrS5EITzCrHYwP/x1ww4F/ZJdO4sJv/yy0O5QVO1xwWe3uTgSLI1cEytlRgsESpetVDDshEipifdwzHjrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ7SMAklsWRDBBxtrunnJ86mn646CQa9Kiravlw1+mY=;
 b=JbsDiamUKLs4oSMQ7RSTsxljzUHLBwSvafCR3PEitlvzw+lOUx79ZAOaI3paLbQA8snspGK1PNrGjeKlHdCi1peCK+cWZF3SlCVyM791rW5/5qhVc3vK5wVceZSpC9kijG7ucpJ7YuDw70slGE82NgqklcubjW50Iyvtp6U6492VDm5/C9WmCxDurbZpwdGAvI3feInCwhCJ4yn4mV18+fPSZSu7P5cqdYEYOIZZ0o3KOXOCDBlI/E5R8Xrz73b72+ZiTXw/Ubitowyxi26xB5wT4ANYrayGchQABLgfef2pZ2fgIwA4Yz9OF6TZT35BAXJkY4IH8A/MyHNFlpf+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ7SMAklsWRDBBxtrunnJ86mn646CQa9Kiravlw1+mY=;
 b=R0og1/1b/h3ki2+HC2/o89oP4Vn3jI6JAzVmakdNoJA4fu9NPzLoEb+zaFUAeclf5m/7h/JRvWSvqRp5cACGq8rQ2cY/nodqXRgn20tWwGahUl2arsKCMwkTlVTX8zZnfkvkTIY9l/yg8lRjmwISVP7L2k2gSiRtmezOJT/KQgctRbOknDLRuL3MWTEU2aHOIscLkRSYs547aGSXIVjDJMRKGz+6WvDj8YUvig6neGFJeb3bS73HyourvO7ZAcn7dksdgEDiNuS4CqC2kQpMPBR9gcsq9OeZNG8TtHVbqPqeDdl62XEubhkp7PBEYDu3bFbAUt05p+Jo5b2jZSojXQ==
Received: from MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:41:08 +0000
Received: from MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418]) by MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::160b:3f54:2b48:3418%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 07:41:08 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [PATCH net-next v3 03/10] ethtool: Add an interface for flashing
 transceiver modules' firmware
Thread-Topic: [PATCH net-next v3 03/10] ethtool: Add an interface for flashing
 transceiver modules' firmware
Thread-Index: AQHakKTgTwG7Sp4uDkeYPMJGgulod7FtUbAAgABT+eA=
Date: Thu, 18 Apr 2024 07:41:08 +0000
Message-ID:
 <MN2PR12MB45173BA707E5B2669B3DEB52D80E2@MN2PR12MB4517.namprd12.prod.outlook.com>
References: <20240417085347.2836385-1-danieller@nvidia.com>
 <20240417085347.2836385-4-danieller@nvidia.com> <ZiCHotDYOfkPrDUt@archie.me>
In-Reply-To: <ZiCHotDYOfkPrDUt@archie.me>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4517:EE_|CY8PR12MB7414:EE_
x-ms-office365-filtering-correlation-id: 2bb92bb0-10ab-4268-a4ef-08dc5f7ae982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5+JjJWzOpj2IAAOa64Wb0AznGEpqU2npE4z01Z9+EOzeFpAG/L9RMZ4eoyX0W2cffn/NxsdWKJlbFwlqA0x/D7vIA0OhakCzrSnE54JdrJB8jB1wa5DCrFf+1ki0WYBMkonECR4oGqHnac0wQesFh2dvUfG5X2P1YQxqCQr5v4mkPLF93kpZNijJ05Vdc8RSTLYZXttQRWtNmX6eQDXCLFWTVyaEznFBmGxKoW8Mi9JUWzIYZ5dGhxlePDmJ8H1M6oBMctzmsv169IguzDhlITXOr/jJk4mwuY6DmqOtmPXaLVFZQA3qRNuc5kkAUekOAslOce/Dg1qeIbY0kWawNbUiZnwEDm2UPOc4WYIizvk1Q8FtqDsBl0g0oUnCt4+iL0rg4UDw6mOrdXTSOlQxV2uPMCfqhgE7feIjVJsY2t8dhjKQd/nP7eGBdjhPKasQvZlZDCliaLaglypUOuaGTwmDYrxCCD0gtN57oZX7nwNlR4X5/1r/Y7tjMDb1bPZ73yF0nSTtoPqjq9J7Zuw0TM7pnqFVv2/dGBvvGmn74pfgbAF+SYAotmDfvyu/8+7Jyv0HXxXebcMWiVBaUICu+jmzJRRdb7b+DqHmCIxE5nDoTe8FsdUrfPR2GN+sDe/Yq2tJKugv+AFwhtGSQw+Oty7vz1Wrp7/DYNzCSmKTyQUByMcQGpRUlD8nRdmarrdUo3o1GGQCLZ4bK/CJ+iPeKa+DyStVqyuSu9kUXOejG98=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NytGVTVQb1RVUkFOQk8vRVBjWXFYYStBalNzR1RxS1drNE44VGppcS9MVE93?=
 =?utf-8?B?YVV5Q1FveTV4WHhrTnc0MWs1R2dCa0RPY0ZYeXprYXEvdmFwODJuOHEzYjVT?=
 =?utf-8?B?QjgrZ1F5NDJWZENYaUMydFBBLzkzb3Q0MFVSbTR3U0ZaTm1aOVE2V29iT0xW?=
 =?utf-8?B?ajJOcHFaUmJuK3pNMnUweCtZYjA3aVZlNDdhV3RDZkhBTkJHMEdOVlhjMEd1?=
 =?utf-8?B?RXV6NEt1eUZja2g3ZEVZVnFDQlBqOTlFdklXVmtVZkdsUjF0MmxleVIvb2tX?=
 =?utf-8?B?R2xLZ1ArbHJYZUs3UUxzajNpUlB2ZVpvMXZ4SmEzdzVyVUxWN2Vhc2pFT1FZ?=
 =?utf-8?B?Tm9KNGpJbHdVbEZjM1dOektOcmtPdWx4RU9vbXNxc2tlU2FiSW9xalBKTGN1?=
 =?utf-8?B?eHlCdFF2eDRkQnZGU2M2eVJhM3E2M2NMQ2FtcWozRlF5ZmRLTkt5QWNWbzhI?=
 =?utf-8?B?Y2pHRVhjamFLa3lFUER1MGQ0b0VQbVAvSWVwa1F6K0M3emFFQUpyVUpzU1cw?=
 =?utf-8?B?TXd2YVhCa2VOUFBGUGVLb3o0YXZqOEhIcEpMY3lBQXNaeC9kaXlxK0Y0T0po?=
 =?utf-8?B?RkI3ZVJ5TlNVK0lHem1WOHVUdm9WaWdoYnduTkxRcTdBVllTczVhMTIzTFF4?=
 =?utf-8?B?eklYT2pRd3NVTm81UVp4aXhJRkZjQ3h3T2h3L2FvRXFFazREM0Z1NnIrUnhj?=
 =?utf-8?B?cUxFczBtSmZibnVESlhrRWFPM25oNlp6SlkrcUdsR3VFNDhRNEd0WmJBdno1?=
 =?utf-8?B?TnQ4Qjd4RXVYT2V3RG9PTCtXQzBiYzQzQytKa3pacjgzM3BvTUgxdkdYelUr?=
 =?utf-8?B?enZtUjF1NUp3TEhOeUkweTNyUGxrWVB5VFlYY0JDMElEN09kMFBaYlRmaUdz?=
 =?utf-8?B?UEp5SS96N3RieVNDc1FaR3k4ZGlWY1NDVnZid0NDYU1Db2FheXRXNzRVdW5a?=
 =?utf-8?B?Mk9hNW83L1VvUGF3TzNaUUVFc1pibzR3NEVaZWRXL01JdzB3S1lpMWpvakRy?=
 =?utf-8?B?alZxOFFxWFg3ZkhuTFVwYzV4ZFBiVSs1Z2pTTWtzaFBjZUxNRSsvUklUUXBw?=
 =?utf-8?B?Q1RTUlFKWURlV2lUVGFmQXRaSXZHR0NnS1ZpSm5HMnBxRVBZQzgvWGszUVFm?=
 =?utf-8?B?UnJzNWNEMXd3dmVoZmdBd1V4QUtCSVdWS2o1QUt5anZxSVNxYWRxeWtMZkhs?=
 =?utf-8?B?ZVZKWFJwcjAzWWRNY3NaWjdlMmZXYU5FSkN0Mzd5MlFzcjZDdHBNZUpaWlRr?=
 =?utf-8?B?NkErWFQvZld5WU1GVjNPQzNjdUw5UFhObTYza0VBaStxWitDdzZodHhSQ09Z?=
 =?utf-8?B?eEpCVmw3aUd2T2xuM0gxbGkvRE9PeVlxcUpML2NWbFNMWFEzUmpXc0lqWjg1?=
 =?utf-8?B?bk4vWUJwdHdPbGFGK1NNd0ErVFlmT2liRko2VEZyQ1dYcmlMMjhJUlhuWGRO?=
 =?utf-8?B?a1FrN0VCTmRJVVNoVmR3am9kUDlvUnNFMWFPd2NCcDg4MFZWa1JmU0JPTDYv?=
 =?utf-8?B?RjlveGtKUXhBK0Jxc3MrNVhqV214QzdXSHlFRFgwMWlPZEYrem5xMzNTVGtQ?=
 =?utf-8?B?cTlRWTlzU1l1czgzU3RZSFl6QXhWV3J1Y0ZnK3llRXBMc3FBUTAxeGZQQlBF?=
 =?utf-8?B?cjUvRU9MMjhXVnVSREE1ZEJHL1hWOXVGc0xkczhLV1lzQXA3Znk5b0dZeUxO?=
 =?utf-8?B?QXlQVFFpcHh4VVdEcHE2aUdvOHRBeHBsdFZ6dUs3WTRHV3Y2WHpvVHd3SzJ4?=
 =?utf-8?B?MksvSDMwbkU2S2d1ekpwc2tMWU43Ylh4cGV6enI3a1VwRHZ1TDU0dTA0OU1N?=
 =?utf-8?B?UkJPeE42S3puajZZRjg1eDF1TE5aVkFWUTBwZ3lGUit2K201UG1FZVdxaXZO?=
 =?utf-8?B?dlFLNE4vTyt6SGl1VmdRSzVMdzRmaVk3TWRzcUczY0N0aVZmYk0xb2JKaHM0?=
 =?utf-8?B?TlR2NFArTjBIMUNGenJ4K2p1bURYKzM5eHFjaVFrWENSZEJxbzRZUWJ0TXhq?=
 =?utf-8?B?dElLdytYWTdRSG5vMDM2eUVobGxNVWtIbUhaK3RVRk9xWGI4OW54TFd1UW9p?=
 =?utf-8?B?K3MyUS9mNEFJYWl6M2lZUHg5N0ZxaWc5VEk5TllrWmRka1B2Sjdta3FvdVF3?=
 =?utf-8?Q?oCmS8Nz/qzCgjU47tAiz/xlji?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb92bb0-10ab-4268-a4ef-08dc5f7ae982
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 07:41:08.7387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylkngADu2XScRw9D2Ca0fMJw/0TL0EfviMM5mrSf7lrshPbl73F1uEYEmWhEJ5o8QKkGdfpi4qEVWWIH/15Reg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYWdhcyBTYW5qYXlhIDxiYWdh
c2RvdG1lQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIDE4IEFwcmlsIDIwMjQgNTozOA0K
PiBUbzogRGFuaWVsbGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT47IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5j
b207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGNvcmJldEBsd24ubmV0
OyBsaW51eEBhcm1saW51eC5vcmcudWs7DQo+IHNkZkBnb29nbGUuY29tOyBrb3J5Lm1haW5jZW50
QGJvb3RsaW4uY29tOw0KPiBtYXhpbWUuY2hldmFsbGllckBib290bGluLmNvbTsgdmxhZGltaXIu
b2x0ZWFuQG54cC5jb207DQo+IHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb207IGFobWVkLnph
a2lAaW50ZWwuY29tOw0KPiByaWNoYXJkY29jaHJhbkBnbWFpbC5jb207IHNoYXlhZ3JAYW1hem9u
LmNvbTsNCj4gcGF1bC5ncmVlbndhbHRAaW50ZWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBsaW51
eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsg
bWx4c3cgPG1seHN3QG52aWRpYS5jb20+OyBQZXRyIE1hY2hhdGENCj4gPHBldHJtQG52aWRpYS5j
b20+OyBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIG5ldC1uZXh0IHYzIDAzLzEwXSBldGh0b29sOiBBZGQgYW4gaW50ZXJmYWNlIGZvciBmbGFz
aGluZw0KPiB0cmFuc2NlaXZlciBtb2R1bGVzJyBmaXJtd2FyZQ0KPiANCj4gT24gV2VkLCBBcHIg
MTcsIDIwMjQgYXQgMTE6NTM6NDBBTSArMDMwMCwgRGFuaWVsbGUgUmF0c29uIHdyb3RlOg0KPiA+
ICtNT0RVTEVfRldfRkxBU0hfQUNUDQo+ID4gKz09PT09PT09PT09PT09PT09PT0NCj4gPiArDQo+
ID4gK0ZsYXNoZXMgdHJhbnNjZWl2ZXIgbW9kdWxlIGZpcm13YXJlLg0KPiA+ICsNCj4gPiArUmVx
dWVzdCBjb250ZW50czoNCj4gPiArDQo+ID4gKyAgPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09ICA9PT09PT0NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4g
KyAgYGBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0hFQURFUmBgICAgICBuZXN0ZWQgIHJlcXVl
c3QgaGVhZGVyDQo+ID4gKyAgYGBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0ZJTEVfTkFNRWBg
ICBzdHJpbmcgIGZpcm13YXJlIGltYWdlDQo+IGZpbGUgbmFtZQ0KPiA+ICsgIGBgRVRIVE9PTF9B
X01PRFVMRV9GV19GTEFTSF9QQVNTV09SRGBgICAgdTMyICAgICB0cmFuc2NlaXZlcg0KPiBtb2R1
bGUgcGFzc3dvcmQNCj4gPiArICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0gID09PT09PQ0KPiA+ICsgPT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+
ICtUaGUgZmlybXdhcmUgdXBkYXRlIHByb2Nlc3MgaXMgY29tcG9zZWQgZnJvbSB0aHJlZSBsb2dp
Y2FsIHN0ZXBzOg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICIuLi4gY29uc2lzdHMgb2Yg
Li4uIg0KPiA+ICsNCj4gPiArMS4gRG93bmxvYWRpbmcgYSBmaXJtd2FyZSBpbWFnZSB0byB0aGUg
dHJhbnNjZWl2ZXIgbW9kdWxlIGFuZCB2YWxpZGF0aW5nDQo+IGl0Lg0KPiA+ICsyLiBSdW5uaW5n
IHRoZSBmaXJtd2FyZSBpbWFnZS4NCj4gPiArMy4gQ29tbWl0dGluZyB0aGUgZmlybXdhcmUgaW1h
Z2Ugc28gdGhhdCBpdCBpcyBydW4gdXBvbiByZXNldC4NCj4gPiArDQo+ID4gK1doZW4gZmxhc2gg
Y29tbWFuZCBpcyBnaXZlbiwgdGhvc2UgdGhyZWUgc3RlcHMgYXJlIHRha2VuIGluIHRoYXQgb3Jk
ZXIuDQo+ID4gKw0KPiA+ICtUaGUgYGBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0ZJTEVfTkFN
RWBgIGF0dHJpYnV0ZSBlbmNvZGVzDQo+IHRoZQ0KPiA+ICtmaXJtd2FyZSBpbWFnZSBmaWxlIG5h
bWUuIFRoZSBmaXJtd2FyZSBpbWFnZSBpcyBkb3dubG9hZGVkIHRvIHRoZQ0KPiA+ICt0cmFuc2Nl
aXZlciBtb2R1bGUsIHZhbGlkYXRlZCwgcnVuIGFuZCBjb21taXR0ZWQuDQo+ID4gKw0KPiA+ICtU
aGUgb3B0aW9uYWwgYGBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX1BBU1NXT1JEYGAgYXR0cmli
dXRlDQo+IGVuY29kZXMNCj4gPiArYSBwYXNzd29yZCB0aGF0IG1pZ2h0IGJlIHJlcXVpcmVkIGFz
IHBhcnQgb2YgdGhlIHRyYW5zY2VpdmVyIG1vZHVsZQ0KPiA+ICtmaXJtd2FyZSB1cGRhdGUgcHJv
Y2Vzcy4NCj4gPiArDQo+ID4gK1RoZSBmaXJtd2FyZSB1cGRhdGUgcHJvY2VzcyBjYW4gdGFrZSBz
ZXZlcmFsIG1pbnV0ZXMgdG8gY29tcGxldGUuDQo+ID4gK1RoZXJlZm9yZSwgZHVyaW5nIHRoZSB1
cGRhdGUgcHJvY2VzcyBub3RpZmljYXRpb25zIGFyZSBlbWl0dGVkIGZyb20NCj4gPiArdGhlIGtl
cm5lbCB0byB1c2VyIHNwYWNlIHVwZGF0aW5nIGl0IGFib3V0IHRoZSBzdGF0dXMgYW5kIHByb2dy
ZXNzLg0KPiA+ICsNCj4gPiArTm90aWZpY2F0aW9uIGNvbnRlbnRzOg0KPiA+ICsNCj4gPiArICst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiArIHwgYGBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNI
X0hFQURFUmBgICAgICAgICAgICAgICB8IG5lc3RlZCB8IHJlcGx5DQo+IGhlYWRlciAgIHwNCj4g
PiArICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
LS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiArIHwgYGBFVEhUT09MX0FfTU9EVUxFX0ZX
X0ZMQVNIX1NUQVRVU2BgICAgICAgICAgICAgICB8IHUzMiAgICB8IHN0YXR1cw0KPiB8DQo+ID4g
KyArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0t
LS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyB8IGBgRVRIVE9PTF9BX01PRFVMRV9GV19G
TEFTSF9TVEFUVVNfTVNHYGAgICAgICAgICAgfCBzdHJpbmcgfCBzdGF0dXMNCj4gbWVzc2FnZSB8
DQo+ID4gKyArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyB8IGBgRVRIVE9PTF9BX01PRFVM
RV9GV19GTEFTSF9ET05FYGAgICAgICAgICAgICAgICAgfCB1NjQgICAgfCBwcm9ncmVzcw0KPiB8
DQo+ID4gKyArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKyB8IGBgRVRIVE9PTF9BX01PRFVM
RV9GV19GTEFTSF9UT1RBTGBgICAgICAgICAgICAgICAgfCB1NjQgICAgfCB0b3RhbCAgICAgICAg
ICB8DQo+ID4gKyArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gKw0KPiA+ICtUaGUgYGBFVEhU
T09MX0FfTU9EVUxFX0ZXX0ZMQVNIX1NUQVRVU2BgIGF0dHJpYnV0ZSBlbmNvZGVzIHRoZQ0KPiA+
ICtjdXJyZW50IHN0YXR1cyBvZiB0aGUgZmlybXdhcmUgdXBkYXRlIHByb2Nlc3MuIFBvc3NpYmxl
IHZhbHVlcyBhcmU6DQo+ID4gKw0KPiA+ICsuLiBrZXJuZWwtZG9jOjogaW5jbHVkZS91YXBpL2xp
bnV4L2V0aHRvb2wuaA0KPiA+ICsgICAgOmlkZW50aWZpZXJzOiBldGh0b29sX21vZHVsZV9md19m
bGFzaF9zdGF0dXMNCj4gPiArDQo+ID4gK1RoZSBgYEVUSFRPT0xfQV9NT0RVTEVfRldfRkxBU0hf
U1RBVFVTX01TR2BgIGF0dHJpYnV0ZSBlbmNvZGVzDQo+IGENCj4gPiArc3RhdHVzIG1lc3NhZ2Ug
c3RyaW5nLg0KPiA+ICsNCj4gPiArVGhlIGBgRVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9ET05F
YGAgYW5kDQo+ID4gK2BgRVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9UT1RBTGBgDQo+ID4gK2F0
dHJpYnV0ZXMgZW5jb2RlIHRoZSBjb21wbGV0ZWQgYW5kIHRvdGFsIGFtb3VudCBvZiB3b3JrLCBy
ZXNwZWN0aXZlbHkuDQo+ID4gKw0KPiANCj4gVGhlIHJlc3Qgb2YgZG9jIExHVE0uDQo+IA0KPiBU
aGFua3MuDQo+IA0KDQpIaSwNCg0KU2luY2UgaXQgaXMgdGhlIG9ubHkgY29tbWVudCwgY2FuIGkg
bWF5YmUgc2VuZCBhIGZpeCBmb3IgdGhhdCBsYXRlciBpZiBuZWVkZWQsIGFuZCBsZXQgdGhpcyBh
cHBseT8NCg0KVGhhbmtzLA0KRGFuaWVsbGUNCg0KPiAtLQ0KPiBBbiBvbGQgbWFuIGRvbGwuLi4g
anVzdCB3aGF0IEkgYWx3YXlzIHdhbnRlZCEgLSBDbGFyYQ0K

