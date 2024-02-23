Return-Path: <linux-kernel+bounces-77819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0C860A95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A961C236DA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6082125DD;
	Fri, 23 Feb 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpRIhenq"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C48125A7;
	Fri, 23 Feb 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668235; cv=fail; b=T80fIYf2ioo6x/JMGV/pGhDkd0W2wfs2/EQ6k7yA4QxNEub8Bswa1/epJ7j1V2TFyKvzQ64pXcmVCq/pR06XFbSeYHHVe8kAvHG8t67MpD4zpezY9EyhgtDfarifrct/c5gO5QJ7icGB5Jifjx2aElvjhMKhyd71yG4UOVnu2os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668235; c=relaxed/simple;
	bh=UmsALj6uLM9fsZ61W3fuWQCQjl/B10c+mXWYrcUaNqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q40HlICaRqvGeNh6mnCVOQ4NtlbUaF4K3DqDl0rpwdD3IM80SMvhqVcqCGWRVbCIhQ2QkAYin04FNPiuAxeCwjP4Ibfho/dpBpOck25UhaQ5yxORIJ4FyEEY5BGQ87jbCEvr0t1pk1xhi90MHM/AfIbe2amRsjgcDnHR0UzvehM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bpRIhenq; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX7dGxM+JM3jod8rJXEEmVEMGUxABSP3ePntbrOc1OisL5Teo41HqIxh3BbXy7y70IYymoElP4TPO9c6Lrfj8blB7i+bMZExg9/Hj5sDwaYp3q1B/0TyRcj69C4UUSChK2ORxFtHtMjR8Jjuz3cnDzA00fz7dp55FIJseWJPF5/+GY4iOszrsHLAxHui/RR3zusT+lKzYsRyNaFZ78doJgHyf/y2Oml8V131JAHhyO/UYEphWVXmg9EHaW0UYrc+kLQIFS1ATK6R1i/UmBFVMvi0PikyyJLo7yWXJjw4/gBAOw9CtIebmvu1JKixdgn959hhNfLbbZ1gGFHz05HpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmsALj6uLM9fsZ61W3fuWQCQjl/B10c+mXWYrcUaNqE=;
 b=aZVdGXSmtR7ZllGUMrXWdshlTN0ZL4FU/UPlKyvlh1L1w3f6Vhkgc9PJRvFdf2OS47Al/lOsygADD5c5WDLV1DVm04eAPO6CsQiwVONRQLdy2RgNvh/DhksDAuAEo45TYg330fxAoHeF/ygyD3yE5C8Qf0Tq/ukBf8MQxihVGRtq7vHhtURQmq3bBUPRYCkIHk7EQcPA6wHGOz+XcD7Lai7hECeGx8lHGpay0nABQhjFL/49pnQNl6UuKe29zYfqmQXdtCZWVfveLy7A7IMbi6y69AhgBgE+J4P+Tx1W/vVf7zIzRpHTdhq1v+wLrkogYV4Jr1Sii6vElibGqbcZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmsALj6uLM9fsZ61W3fuWQCQjl/B10c+mXWYrcUaNqE=;
 b=bpRIhenquyPlQytMxmV0VDfgLDFaKV1SA7ZhNJHO+xZQ2FXXb0VE+oJsgGOLPe3tW+aXJrZL5mD+RiDSfOncPFMzpTwN0b3rYP5kQXdnqEIvnZnxjMj35Ti/oQcWcMJ+pL2QmkTUd8Bti/U7EaRsmKqwLz3Io5uYH5GllKzBfsg=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DU2PR04MB8807.eurprd04.prod.outlook.com (2603:10a6:10:2e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 23 Feb
 2024 06:03:50 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32%7]) with mapi id 15.20.7292.033; Fri, 23 Feb 2024
 06:03:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH net-next v5 8/8] net: fec: Fixup EEE
Thread-Topic: [PATCH net-next v5 8/8] net: fec: Fixup EEE
Thread-Index: AQHaZI4yJcwEtFsABkuvq0DBicOuHrEXcvdQ
Date: Fri, 23 Feb 2024 06:03:50 +0000
Message-ID:
 <AM5PR04MB313971CA6B3C5C9963FDDA5E88552@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-9-o.rempel@pengutronix.de>
In-Reply-To: <20240221062107.778661-9-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|DU2PR04MB8807:EE_
x-ms-office365-filtering-correlation-id: 469537d3-43de-4b35-76bb-08dc343534ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nee/oWeLASxV/PGfaRqhM99v8mOav9AMOyJpHXdIA9xOoDep1fa2JMke1FoM71uUCs5ndhDurELCSQXrw42e91FEPxuE9KG0YPrHPgSH+rIURZSeKb8FHCboPdq22nEyfzxEL+HzaXljj6Rq4bNXeOd75nTKm7Xev1RaDQrvSHWxLzEFg6lk3hoCd0F5Z8ZI/LEOB/HjBP7m794om75Ac/nX1Mxj1y+pFhPuA0WKNH9XtKcp259BnhnlJC/1pchQ0i65r+N4pzmyI+gWJavgRHCtDiAYed7G4vTTyYJBgP5+S4UVa0wTXq1B46XLMQrVK1Bb6zej1Jxqf5WyLvkyTQL8z36LbZtkZrU7L329KllIeZIBSvQxlUTnvPu5MCc/CbpOHAknj8S2joYZeVgxfoiUMnQkjRm6aszL0PpFR1Cd6+KAHPzZGju4yr5brL8MKLrcUrZSign9fgFRWcBjaBHzapmPMZTtMXXdDQ4VFGiJIbHhNN0tMP46a/N19EIj9I2PEDOuXo9FbgtOLJy8d1cFiVwIHUYdcfzw76000PWFCuzRkY++V7u1LxaRC3qpwxO8IJqkR5t1rh9gkdv3Hq3kY7Lp0NczBQ3HAfGFidViIoKTbvapyljHI1nFQxWr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dDdRSGUwR3ovbzlOVU8weXg5Z2trakZLWFhacFd0dmdMdnJYOFh2Vlc4TXIw?=
 =?gb2312?B?djRuK0piMHZMUmFFVXJ6K01qV1NsVzEvMTJSSExmZEpHS3ZjaCtUVWY1Q0Uv?=
 =?gb2312?B?cHlxSlJObjZsMEwrb01uQzdDL1QrSm03U3lEQ1hEajhiYkhSUklrdS8rRHlL?=
 =?gb2312?B?QlVKSmtZRWZHMVU1S2NzNEpHL0ZGWWlVUElmVDAyQ1I0UDNPeDA0MW85bHpP?=
 =?gb2312?B?QmsxVXNOSlR0a2RnNlhJWXdPcDM3OVdCaGlCK2V0WERMUG51NldJanVocXcw?=
 =?gb2312?B?cnVVRzhLclJVOFY2QVpNbUhxa0pGYklZc0UzaXBSRlZpSUtoRC95ZWJlWU5H?=
 =?gb2312?B?NHR0b2pROGM0TzRBRjNDWmd6Uk5QNWlNTitFQW9sWXo3Ry9YbGFLcWcrM1Ra?=
 =?gb2312?B?blNqRkNCK2daTGlpVTNDTXBpTSs2b1JlZm9sL3J1d2NmTWhsT0RCTkdSRFF0?=
 =?gb2312?B?SU43QzR6My9KdlFMaTVuTTRab25uNFhUdjc1OXY3SHVhRGlOTkRtaFE5WENY?=
 =?gb2312?B?WGJHWDVFNHBaV1VmR2svSktzNklnb1g2cFQrd0wxSXIxRUJXUmZHMlpIRXFS?=
 =?gb2312?B?WUFmbHRPL0hzYVcvSWtOVHVlNXVpb3pNN1Z3TjlQQ0Y0NEw4NG9GZitZRTVm?=
 =?gb2312?B?NnZ3VjIrZXZuanhtRFRJTG9PSjF0L2JIZG80Z0FPS01HOXMxYkF0blNkTThw?=
 =?gb2312?B?dWZHbEF6Y2xKT0JLQlpBV1IyTUFud09kY0ZNc1d4M2lYejlrREIwYzlZK1pV?=
 =?gb2312?B?bDA3d1JhdkRRYzFMTXZtUjhSdmhhR0ZLK29VNS9FUjdWY1JBdlQzaGROZ3Nh?=
 =?gb2312?B?Q0lsRFNlSXkrTmV5U1hndFJBWWt2Wkpha0VxM2xOK29kMkoyLzlsNmswTlhT?=
 =?gb2312?B?VEk5Qk8zTUpsdGVOZVdZRldaYzYwRU9YOEpZY0xxTzcyR2JDWjhzeXFrVDBo?=
 =?gb2312?B?OGtjbmliVnROMkdQWVphQ0VOUzh2dGpURnhhK2x4VWh1RHI5Z2NjRDRXQmcx?=
 =?gb2312?B?bkRnMlBheUk1YVVxU3VSUnVheUJ6Nm12N0dZWDFzdTh6V3VDNUFEZ0JxTytl?=
 =?gb2312?B?VWhPaHhpa3FKMmZJVXVZeDIzWjF4cFNxUTN3VG4yTGt6SkNqa0xyUGwway9O?=
 =?gb2312?B?Ty9yNnoxTWd4V3lGMi8xcUVFM0ZieUlQRUdyOHdLNXpsLytyTisxOWJPVm0r?=
 =?gb2312?B?THVkaWpXbG83R09aSEVsc2VKUTJ1ckZGOVdwVE90QzIxWk9oWmQxZ29YQWRh?=
 =?gb2312?B?UkVESjhuK0Nzb0ViWFA5Ym9uNDdIQW8xRk1GUDlMWGZuZEtxTVFZWTFWQ1Z5?=
 =?gb2312?B?NDgvYStrYzVQZS9LSnJ5RWNDdUF6S2JleHVCRm80cTZNQ2lqdTY3eGI4aERR?=
 =?gb2312?B?bU1HYkJyN0FobFFnTmlZT0h5Y3Z5S2xBWWMzVjcwSjUycTUzUUlvT3paMlNi?=
 =?gb2312?B?TUdOYmpRUGp0a2JCaDdYWHcycEtKS211c3VvNmFhQTAxK1NxU3JNYnpldk5B?=
 =?gb2312?B?UkpGZ3ZlTWpxQ1lEbGI1UzhpOVgwOGQybWpReDRNMmdFZXI1Yk9zQ3E4NmdL?=
 =?gb2312?B?d0pwSXRWdGlSbG1IMHdyWEpnRmtrUUdqUUJZdS9pY0o2U1lyZDRjQ0R3NFgv?=
 =?gb2312?B?NnRrdUNqZ3V2TFhDcFBHNHA1UUN3alEvK0p4TjFyT2ttaEtSa1RnS3F5NmhT?=
 =?gb2312?B?K0pwMmtxNkxyZ1VndE54NDBRTGo5bVo5OVFnTk1XQjB4SmVlYmUzb3hVdHFB?=
 =?gb2312?B?REEwM2dCTkRmcXhuVk4xS3M5SHYxSE1abGVrRmtzcnBJNlQvTUxyQ3UvUGRZ?=
 =?gb2312?B?blFlVFVUMzRIdHozdDh5WXpRMVVmeTI0cHVpWFEyOC95a3pKVUVLeWZuMDR4?=
 =?gb2312?B?dVlQcFR6MTlPaTlaOXNibnZHWFhUUTFkbWtoTWsyOVNaZVp2ZjAwbWpyazQy?=
 =?gb2312?B?c1FsSDBZMTlHODc5ZERBWXk0WkZoYkJuM0RIOTladkd4L1pJVUM2cjR4bTRX?=
 =?gb2312?B?V0RaMnAvcTgyTGpUQmwxVmJNOGFQUXZaNGFFSWRIdlEyRFhkSTBBeWxISDVD?=
 =?gb2312?B?VW5jdHd4WVVYYS85VENQQVhNUEFZTG1GUHVzbm9Wb3pWV0hIVXMxZFBja0lk?=
 =?gb2312?Q?CzaI=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469537d3-43de-4b35-76bb-08dc343534ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 06:03:50.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8TeHVzs0H65x1klEtSkhcqbiOELukCYd4eZzvNih8qbBzyQReS/UhIRWcMYSZxjvteNVeKi3WnpIsOQxls0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8807

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGVrc2lqIFJlbXBlbCA8by5y
ZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTE6jLUwjIxyNUgMTQ6MjENCj4gVG86
IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsNCj4gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47DQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0
LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD47DQo+IEhlaW5lciBLYWxsd2VpdCA8
aGthbGx3ZWl0MUBnbWFpbC5jb20+OyBSdXNzZWxsIEtpbmcNCj4gPGxpbnV4QGFybWxpbnV4Lm9y
Zy51az4NCj4gQ2M6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT47IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgU2hlbndlaSBXYW5nDQo+IDxzaGVud2VpLndhbmdAbnhwLmNv
bT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNvbT47DQo+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQtbmV4dCB2NSA4LzhdIG5l
dDogZmVjOiBGaXh1cCBFRUUNCj4gDQo+IEZyb206IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5j
aD4NCj4gDQo+IFRoZSBlbmFibGluZy9kaXNhYmxpbmcgb2YgRUVFIGluIHRoZSBNQUMgc2hvdWxk
IGhhcHBlbiBhcyBhIHJlc3VsdCBvZiBhdXRvDQo+IG5lZ290aWF0aW9uLiBTbyBtb3ZlIHRoZSBl
bmFibGUvZGlzYWJsZSBpbnRvDQo+IGZlY19lbmV0X2FkanVzdF9saW5rKCkgd2hpY2ggZ2V0cyBj
YWxsZWQgYnkgcGh5bGliIHdoZW4gdGhlcmUgaXMgYSBjaGFuZ2UgaW4NCj4gbGluayBzdGF0dXMu
DQo+IA0KPiBmZWNfZW5ldF9zZXRfZWVlKCkgbm93IGp1c3Qgc3RvcmVzIGF3YXkgdGhlIExQSSB0
aW1lciB2YWx1ZS4NCj4gRXZlcnl0aGluZyBlbHNlIGlzIHBhc3NlZCB0byBwaHlsaWIsIHNvIGl0
IGNhbiBjb3JyZWN0bHkgc2V0dXAgdGhlIFBIWS4NCj4gDQo+IGZlY19lbmV0X2dldF9lZWUoKSBy
ZWxpZXMgb24gcGh5bGliIGRvaW5nIG1vc3Qgb2YgdGhlIHdvcmssIHRoZSBNQUMgZHJpdmVyDQo+
IGp1c3QgYWRkcyB0aGUgTFBJIHRpbWVyIHZhbHVlLg0KPiANCj4gQ2FsbCBwaHlfc3VwcG9ydF9l
ZWUoKSBpZiB0aGUgcXVpcmsgaXMgcHJlc2VudCB0byBpbmRpY2F0ZSB0aGUgTUFDIGFjdHVhbGx5
DQo+IHN1cHBvcnRzIEVFRS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBMdW5uIDxhbmRy
ZXdAbHVubi5jaD4NCj4gVGVzdGVkLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0
cm9uaXguZGU+IChPbiBpTVg4TVAgZGViaXgpDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVt
cGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+IHYyOiBPbmx5IGNhbGwgZmVj
X2VuZXRfZWVlX21vZGVfc2V0IGZvciB0aG9zZSB0aGF0IHN1cHBvcnQgRUVFDQo+IHY3OiB1cGRh
dGUgYWdhaW5zdCBrZXJuZWwgdjYuOC1yYzQNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYyB8IDIzICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IGluZGV4IGEyYzc4
NjU1MDM0Mi4uZDc2OTNmZGY2NDBkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZmVjX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVl
c2NhbGUvZmVjX21haW4uYw0KPiBAQCAtMjAzMywxMyArMjAzMyw4IEBAIHN0YXRpYyBpbnQgZmVj
X2VuZXRfZWVlX21vZGVfc2V0KHN0cnVjdA0KPiBuZXRfZGV2aWNlICpuZGV2LCBib29sIGVuYWJs
ZSkNCj4gIAlzdHJ1Y3QgZmVjX2VuZXRfcHJpdmF0ZSAqZmVwID0gbmV0ZGV2X3ByaXYobmRldik7
DQo+ICAJc3RydWN0IGV0aHRvb2xfa2VlZSAqcCA9ICZmZXAtPmVlZTsNCj4gIAl1bnNpZ25lZCBp
bnQgc2xlZXBfY3ljbGUsIHdha2VfY3ljbGU7DQo+IC0JaW50IHJldCA9IDA7DQo+IA0KPiAgCWlm
IChlbmFibGUpIHsNCj4gLQkJcmV0ID0gcGh5X2luaXRfZWVlKG5kZXYtPnBoeWRldiwgZmFsc2Up
Ow0KPiAtCQlpZiAocmV0KQ0KPiAtCQkJcmV0dXJuIHJldDsNCj4gLQ0KPiAgCQlzbGVlcF9jeWNs
ZSA9IGZlY19lbmV0X3VzX3RvX3R4X2N5Y2xlKG5kZXYsIHAtPnR4X2xwaV90aW1lcik7DQo+ICAJ
CXdha2VfY3ljbGUgPSBzbGVlcF9jeWNsZTsNCj4gIAl9IGVsc2Ugew0KPiBAQCAtMjA0Nyw4ICsy
MDQyLDYgQEAgc3RhdGljIGludCBmZWNfZW5ldF9lZWVfbW9kZV9zZXQoc3RydWN0DQo+IG5ldF9k
ZXZpY2UgKm5kZXYsIGJvb2wgZW5hYmxlKQ0KPiAgCQl3YWtlX2N5Y2xlID0gMDsNCj4gIAl9DQo+
IA0KPiAtCXAtPnR4X2xwaV9lbmFibGVkID0gZW5hYmxlOw0KPiAtDQo+ICAJd3JpdGVsKHNsZWVw
X2N5Y2xlLCBmZXAtPmh3cCArIEZFQ19MUElfU0xFRVApOw0KPiAgCXdyaXRlbCh3YWtlX2N5Y2xl
LCBmZXAtPmh3cCArIEZFQ19MUElfV0FLRSk7DQo+IA0KPiBAQCAtMjA5NCw2ICsyMDg3LDggQEAg
c3RhdGljIHZvaWQgZmVjX2VuZXRfYWRqdXN0X2xpbmsoc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5k
ZXYpDQo+ICAJCQluZXRpZl90eF91bmxvY2tfYmgobmRldik7DQo+ICAJCQluYXBpX2VuYWJsZSgm
ZmVwLT5uYXBpKTsNCj4gIAkJfQ0KPiArCQlpZiAoZmVwLT5xdWlya3MgJiBGRUNfUVVJUktfSEFT
X0VFRSkNCj4gKwkJCWZlY19lbmV0X2VlZV9tb2RlX3NldChuZGV2LCBwaHlfZGV2LT5lbmFibGVf
dHhfbHBpKTsNCj4gIAl9IGVsc2Ugew0KPiAgCQlpZiAoZmVwLT5saW5rKSB7DQo+ICAJCQluZXRp
Zl9zdG9wX3F1ZXVlKG5kZXYpOw0KPiBAQCAtMjQ1Myw2ICsyNDQ4LDkgQEAgc3RhdGljIGludCBm
ZWNfZW5ldF9taWlfcHJvYmUoc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5kZXYpDQo+ICAJZWxzZQ0K
PiAgCQlwaHlfc2V0X21heF9zcGVlZChwaHlfZGV2LCAxMDApOw0KPiANCj4gKwlpZiAoZmVwLT5x
dWlya3MgJiBGRUNfUVVJUktfSEFTX0VFRSkNCj4gKwkJcGh5X3N1cHBvcnRfZWVlKHBoeV9kZXYp
Ow0KPiArDQo+ICAJZmVwLT5saW5rID0gMDsNCj4gIAlmZXAtPmZ1bGxfZHVwbGV4ID0gMDsNCj4g
DQo+IEBAIC0zMTcyLDcgKzMxNzAsNiBAQCBmZWNfZW5ldF9nZXRfZWVlKHN0cnVjdCBuZXRfZGV2
aWNlICpuZGV2LCBzdHJ1Y3QNCj4gZXRodG9vbF9rZWVlICplZGF0YSkNCj4gIAkJcmV0dXJuIC1F
TkVURE9XTjsNCj4gDQo+ICAJZWRhdGEtPnR4X2xwaV90aW1lciA9IHAtPnR4X2xwaV90aW1lcjsN
Cj4gLQllZGF0YS0+dHhfbHBpX2VuYWJsZWQgPSBwLT50eF9scGlfZW5hYmxlZDsNCj4gDQo+ICAJ
cmV0dXJuIHBoeV9ldGh0b29sX2dldF9lZWUobmRldi0+cGh5ZGV2LCBlZGF0YSk7ICB9IEBAIC0z
MTgyLDcNCj4gKzMxNzksNiBAQCBmZWNfZW5ldF9zZXRfZWVlKHN0cnVjdCBuZXRfZGV2aWNlICpu
ZGV2LCBzdHJ1Y3QgZXRodG9vbF9rZWVlDQo+ICplZGF0YSkgIHsNCj4gIAlzdHJ1Y3QgZmVjX2Vu
ZXRfcHJpdmF0ZSAqZmVwID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ICAJc3RydWN0IGV0aHRvb2xf
a2VlZSAqcCA9ICZmZXAtPmVlZTsNCj4gLQlpbnQgcmV0ID0gMDsNCj4gDQo+ICAJaWYgKCEoZmVw
LT5xdWlya3MgJiBGRUNfUVVJUktfSEFTX0VFRSkpDQo+ICAJCXJldHVybiAtRU9QTk9UU1VQUDsN
Cj4gQEAgLTMxOTIsMTUgKzMxODgsNiBAQCBmZWNfZW5ldF9zZXRfZWVlKHN0cnVjdCBuZXRfZGV2
aWNlICpuZGV2LCBzdHJ1Y3QNCj4gZXRodG9vbF9rZWVlICplZGF0YSkNCj4gDQo+ICAJcC0+dHhf
bHBpX3RpbWVyID0gZWRhdGEtPnR4X2xwaV90aW1lcjsNCj4gDQo+IC0JaWYgKCFlZGF0YS0+ZWVl
X2VuYWJsZWQgfHwgIWVkYXRhLT50eF9scGlfZW5hYmxlZCB8fA0KPiAtCSAgICAhZWRhdGEtPnR4
X2xwaV90aW1lcikNCj4gLQkJcmV0ID0gZmVjX2VuZXRfZWVlX21vZGVfc2V0KG5kZXYsIGZhbHNl
KTsNCj4gLQllbHNlDQo+IC0JCXJldCA9IGZlY19lbmV0X2VlZV9tb2RlX3NldChuZGV2LCB0cnVl
KTsNCj4gLQ0KPiAtCWlmIChyZXQpDQo+IC0JCXJldHVybiByZXQ7DQo+IC0NCj4gIAlyZXR1cm4g
cGh5X2V0aHRvb2xfc2V0X2VlZShuZGV2LT5waHlkZXYsIGVkYXRhKTsgIH0NCj4gDQo+IC0tDQo+
IDIuMzkuMg0KDQpSZXZpZXdlZC1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQoNCg==

