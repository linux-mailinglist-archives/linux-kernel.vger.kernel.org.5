Return-Path: <linux-kernel+bounces-144160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593E8A428F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABF01F2128A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F93EA97;
	Sun, 14 Apr 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="D6bZHN46"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2110.outbound.protection.outlook.com [40.107.105.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BA55C2E;
	Sun, 14 Apr 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100741; cv=fail; b=YxEDGV/rdqA95FdIOP9+Nvexw5chzaG/WU528LvyDM9KBfz1Zg5NEUl15w16C/LhR27J7jtmb9cpjbB6RdPGEqVMiMBn1Gikz2NMbjGsHK9Ww8cH9e/RJ9chPU9pM6KhXIo4gyfywvgwnG2IgWS3r0zxVMtPpUnXdQ2dzNAIfHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100741; c=relaxed/simple;
	bh=Y03DKvhdMltidGar/C2r5DidZcMEZVa2hk4VoG9fIV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+r1BJ4C26EPfl/9w0rO8VymF4JFtMe+ur15A9f1cTYje8l87ic+GbF1e3TJIpxp1aFttLOQeyCI6juXyAuxajoQOuvioVgOP1VaEqvVGGGfp7m+Lxy5CMNaeLRjoUJdrfn109QyaesYli+C0Kp5TjsgpZQ5OUgohFBX6wAhVLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=D6bZHN46; arc=fail smtp.client-ip=40.107.105.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbcVWdvLUAwyw8PDz8fzfnfd4Pmf9mAr4Jmokpv0AUjC9nvEA/C5CE0UIo0FaGk/PQ/WRP81loDqs0gA18henF74t8MIshCa2SxNNKZsXYaKtZPZ0/vprHFRf12fb4F2Scf1me1n8oOEkQ5eCCYMGmOkRpsyY4E0ZcCVvbRTUn8FWnFfdhcmA/WGdzHGL5jkD5Qw3lAhqCpZ+IgHUfCBGRTgK21FBYXwX8tRRC0s0blgMlF9KeQcZNu/vrA6ozSIL6Muafj+BcN2PI+/H9YpsqbPMUuHxmg1SjBZAtkaZig4mUtzbORoLe4FNU2/1mkq6Gv/oeBY1NncNQnXk8e3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y03DKvhdMltidGar/C2r5DidZcMEZVa2hk4VoG9fIV4=;
 b=A4remmAwFZiKF4VqUBIXgeI6dDX5xVzrnEcSKWK+gFsX6Vzmng9/PbwnZMfNi5KNuuWNw+vsDDAxbSK+I+k/X0EcfW4WXq3Fvxpsi3kOoTV+kHQ5bZDTIEiiAPGl6GvbAtlSKfl7lV4vgvtB6XZMR7LeDXImLcf4CiAHdrLxklCn6nAAHzhjvnnPbbkoHEpNFj4/CJ9GLmyU0wK/LYLTx48zVaqANF/Xx2eheKpxL0AoNXGT3d1QKYe9yZ/zMvDcAHuuz77oY3ShGa3UGiirBUMWEaop6aMw81ruhvyRmSDzaomcUVMp5wL4ETHUU0W37Km8NJLFQ2j8cSq2UVi12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y03DKvhdMltidGar/C2r5DidZcMEZVa2hk4VoG9fIV4=;
 b=D6bZHN46wqUGOoGUjik0ot+R9icHDJ2wvRJUZN4YqU2Zol0rLClmP1rmixhpqxBV+cPYJOZFfO+r/OoKGi5JvlFNALX4N3wV3Yn3myO+XNLEAOtJB5X75Z1OnGNqqLByn2Js2HYQ8w/gzolDKSFQd8MzQFwIworKUF5VSODmQng=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sun, 14 Apr
 2024 13:18:57 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 13:18:56 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHajmt4w4zwT8gI9EGUFXDjzCdkprFnv8QA
Date: Sun, 14 Apr 2024 13:18:56 +0000
Message-ID: <3958052d-fc09-4c4c-a9e3-4923871cff44@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM0PR04MB6897:EE_
x-ms-office365-filtering-correlation-id: 3575e0e0-ecbb-4d17-3fbb-08dc5c857084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 889nVa1RWFSncAq2diz3ZRjXmnud6PIENCwp/rNnK/uQ35laxeox7NxVVpRvKE97EnDgPB2XVE6fJ5+qnaUlteqtyF0Q/inK39n0kER07Pz2obS1Rs+zL1AXbzPWDJflLv7QuX2ORZC7HMH+x+aDHEnpEgLAnbBo9FGzPJkDa4rfmQlGFQTneZxYrkUhpKZSEb3Rof0at3XhAO1aYU7N4N6eJPrLeBEQo/6AbaYAnVM7AWm1nfPDnATZargMj0vixNEmNC3Av5HD3ImIcFKOzNdgMjPi1qCjZdFQ5uq2EMvH/Itu4T6rqbTKgP4qFwcdKZbckMpkpnTrN457c3/tDgZL8kOrFcePOVrvAxFu8p4a/qgPW3JJGFJaqcCEkkLS1sM53Dy+fbRlrGrqI8C4VwYlwbVxVAMU3dLa6DIT6YA/vnvN1mkKi+lXChbddmMZKgTjCYS1dZ3XwDRYHHDc9MhN6Wihdm9Z5U2vXHyH527mGq7EXQxmGTpBVlJ/xSB4AYD0ASgRo9hTTOJpPkdgklLMYmxMDKx2+mhztvcaHkSw2caH0Mof9W7NImQ3FZ92Ow13Sh2Kbxx2QFF46Nn9spG4J2pDInyZSMgW9YwVipq4tm3JVGmyXYIpCTxMXc9dCcaexwUJVZcErOEZlmZT8v2rSGRKW1Jifl1MGX7mBukWzfRaSl9PQX3HmQR5J61s2OKA91QT5IMiBL8crO5DQQtlculCN/xvdCj8MDF43OQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkQ1ZE9FNG56bnZSRmt4djF5b0lGTmtyaEloUkpLUkIrbFF3bDc3Z1Q4RENT?=
 =?utf-8?B?MWxscmNoeWtTNU5YVHZ5dkRNWExSejdmZjFTRWhYSHNpeGxoVEVxbDREWnVm?=
 =?utf-8?B?K3hnMnN5UEJ4ZFYxWmpVcVozbnRiUmpqdVRSYUFJNWxkZGlueEdMMld3Y0xV?=
 =?utf-8?B?TFduR2pNMHhTVTNhUjdLY1RvOWVXV2NkRFVYZUJXeTRvWWQ0UkxtSXJramNt?=
 =?utf-8?B?YTZZdW96enV0eEFFS2RLMU4wTlMrem4zdXcxM0FrMFlsb0M1bkEzdUV3dFlV?=
 =?utf-8?B?Y3hpNFd2N3lnNFhha3VoOUo3UG5tWmZBcmpBaUhnUHhWYk02NUtjZEdDTk42?=
 =?utf-8?B?UldwcjJ4dGgraG91OUt6R3pOSzVkb0pVaTZhcFY4NlpVZjJiREY3NFJ5c2VX?=
 =?utf-8?B?TDlpTGFpamx6SzlJWjA4M3F4NEdXVDNlOU8vOVU1bGhXTUFoT0VocVNUU0t3?=
 =?utf-8?B?d25jamN6c0YzQWMwdU5wcExFMXY3c1ZYZ3ZSQ08vU25lN0pweWxxZ1ZjY05W?=
 =?utf-8?B?bEx2QStSdmhHSkRURjlVQW5mOEtHMkNMRTFsNG92OWNBNVFFSUZXTm41KzVl?=
 =?utf-8?B?bXh2ZXlIUDRrTmN6WXI4MkYwSzY4amR6eEd4Sk8rVG9KV3BmSCtXOWZtcnFX?=
 =?utf-8?B?Mjk4SWhscnhHcW4zNk1MaGpSdWEweEhuVlVOZVNzRGo1VlNSM2Zham4vTncy?=
 =?utf-8?B?YWdiWTQrdmtRZFRTbDdwU2R5MUFHaDhSS2Zvd3lidGUvMjZuQ0RocCtadlVp?=
 =?utf-8?B?eXo3NnlRTEMrM3FYQWJ5YzVPTExQdEdoMFdIaG50T3BYTkVtYjZwa2pEMC9a?=
 =?utf-8?B?U09hTlZuNVl1dHBPeXVWSFRHQ3hiOWs3UWxFeE8vcGdpbnVnOXc4eUk1dWJn?=
 =?utf-8?B?NlZsWm5qK3dTWFdOZThrRWlIY2xBM21Oanh2V2UvdWF5V1lNNmZZYzk1TW9J?=
 =?utf-8?B?VHE2UjNFK0F1NzBkRHRTYldpamx2RFE0YjJ6NUhhZms1dTBuUzdJRE1pNm4x?=
 =?utf-8?B?NjhxeWN3ZlhhSURSK0crdWNlT2NRK0xuUlVPY3pFcUQ0T3BCRVRYOVIzNlUw?=
 =?utf-8?B?Z2dpK1NzbXlMb2xoY05vT3Y3bnRDb3o5dGFHRU5lSEZ3bk0yV29MaVhGM2NL?=
 =?utf-8?B?WVoxYS85SGpteXVaT1BCbkY2eDJ3czQwNlEyWGRGM0lzc1hRWEpuY3U1T1Vp?=
 =?utf-8?B?L2l2dkFRcTJ0QjVobjh0alovWkV3c3g0RTdyRlNxdE8yZ3Z5T0RSN3hhak83?=
 =?utf-8?B?RGprQlFsMm1tVTdzWFNLdXFGNzMxSHVacjMrZU50dHY1UWdXRGNRTTFzZExv?=
 =?utf-8?B?eVZMRVN1SjUxRmhVbVJxaitCdzV3Mkt0VGVvRERhZjJiTWRzUUdFaDhISWJo?=
 =?utf-8?B?MmlDQU5XTjVPNVRFUWdQdHNCTTRvVy9ER1k4R0RqZm5Pa3VheXIzazFGcFY3?=
 =?utf-8?B?T3RyM0ROMnRva0VWS3czb00yN0JWRFZFOXVxZC9FZGlDUmY4UEg2NnBRTjly?=
 =?utf-8?B?ZXpCQzlVZGtyZDFtUWMycnBRY2hYRUtCTUdNYjN5T3NFeU1TWlpXYWZ5KzVW?=
 =?utf-8?B?S2M4VWxwbEI1eHkzdUJUMFNsOFUxaGdySkYwRzlCNnBKbmF6bmRPNkQxVTc1?=
 =?utf-8?B?Z1NQbXZ6Qm5ielQ3MXFMQ2RsRVhkc2xIVGh4Sk5HZ3VENW9vY2hhcWtadk9C?=
 =?utf-8?B?Q0hPUGtPR1hmYS8yUno0VFhoSlVNS0FadEhWemtkVDlXbWZvR2RCV0t4N01P?=
 =?utf-8?B?bFVCaXprWURrZzlqaEJ4UEd3NGxmWGRXblRhWnJDOW9wbVp2b0txNFVaU3JZ?=
 =?utf-8?B?VEJrK0hCd2NTMnFxTU50aDNBdnVsWUU5c3FaNlFwSEh6c3g5YmV1Ui9pTnU1?=
 =?utf-8?B?a211OHladWR1b3ErekZpcGh1cm9ZM3VlSVUzaHBkeHBrUTZydDZpMjhKYVNu?=
 =?utf-8?B?UnBqZFZNWkFvbEFzVHpFTzNFa2x6dTloYi90Qnc3b2MyMk5WK0pxTHJJOHVG?=
 =?utf-8?B?OTBEUGNwanhxd1Jld1dzbXR5ZFJHU25JQ0Y3VVhSSGRTdzFKbG5XVFpLSXdl?=
 =?utf-8?B?cmlld05ETnJ4b1JQYXVnLzh6MlpoMHZ2RXl5OHhjZEoxdEg2RjBHblhVK3I5?=
 =?utf-8?Q?2ESc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42AA7F2EC301F84EAE9F1A1C8124B0F1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3575e0e0-ecbb-4d17-3fbb-08dc5c857084
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 13:18:56.7679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F7CUpUd44VXPbr5G+SEmAqtSj9MXBPa8xKxi6pJGDOUNo12z09HOyeKFT8qitm+oTFYJIwzmpuFM1jHgf7A+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897

QW0gMTQuMDQuMjQgdW0gMTQ6NTggc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMxIFNvbGlkV0FOLCBiYXNlZCBvbiBDTjkxMzAgU29N
DQo+IHdpdGggYW4gZXh0cmEgY29tbXVuaWNhdGlvbiAgcHJvY2Vzc29yIG9uIHRoZSBjYXJyaWVy
IGJvYXJkLg0KPg0KPiBUaGlzIGJvYXJkIGRpZmZlcmVudGlhdGVzIGl0c2VsZiBmcm9tIENOOTEz
MCBDbGVhcmZvZyBieSBwcm92aWRpbmcNCj4gYWRkaXRpb25hbCBTb0MgbmF0aXZlIG5ldHdvcmsg
aW50ZXJmYWNlcyBhbmQgcGNpIGJ1c2VzOg0KPiAyeCAxMEdicHMgU0ZQKw0KPiA0eCAxR2JwcyBS
SjQ1DQo+IDF4IG1pbmlQQ0ktRQ0KPiAxeCBtLjIgYi1rZXkgd2l0aCBzYXRhLCB1c2ItMi4wIGFu
ZCB1c2ItMy4wDQo+IDF4IG0uMiBtLWtleSB3aXRoIHBjaWUgYW5kIHVzYi0yLjANCj4gMXggbS4y
IGIta2V5IHdpdGggcGNpZSwgdXNiLTIuMCwgdXNiLTMuMCBhbmQgMnggc2ltIHNsb3RzDQo+IDF4
IG1wY2llIHdpdGggcGNpZSBvbmx5DQo+IDJ4IHR5cGUtYSB1c2ItMi4wLzMuMA0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMxLWNmLXNvbGlkd2FuLmR0cyB8
IDY1MyArKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjU0IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9N
YWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZQ0KPiBpbmRleCAw
MTlmMjI1MWQ2OTYuLjE2ZjlkNzE1NmQ5ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9NYWtlZmlsZQ0KPiBAQCAtMzAsMyArMzAsNCBAQCBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkg
Kz0gYWM1eC1yZC1jYXJyaWVyLWNuOTEzMS5kdGINCj4gIGR0Yi0kKENPTkZJR19BUkNIX01WRUJV
KSArPSBhYzUtOThkeDM1eHgtcmQuZHRiDQo+ICBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0g
Y245MTMwLWNmLWJhc2UuZHRiDQo+ICBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0gY245MTMw
LWNmLXByby5kdGINCj4gK2R0Yi0kKENPTkZJR19BUkNIX01WRUJVKSArPSBjbjkxMzEtY2Ytc29s
aWR3YW4uZHRiDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245
MTMxLWNmLXNvbGlkd2FuLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzEt
Y2Ytc29saWR3YW4uZHRzDQpjdXQNCj4gKwlsZWRzIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJncGlv
LWxlZHMiOw0KPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiArCQlwaW5jdHJsLTAg
PSA8JmNwMF9sZWRfcGlucyAmY3AxX2xlZF9waW5zPjsNCj4gKw0KPiArCQkvKiBmb3Igc2ZwLTEg
KEo0MikgKi8NCj4gKwkJbGVkLXNmcDEtYWN0aXZpdHkgew0KPiArCQkJbGFiZWwgPSAic2ZwMSI7
DQo+ICsJCQlncGlvcyA9IDwmY3AwX2dwaW8xIDcgR1BJT19BQ1RJVkVfSElHSD47DQo+ICsJCQlj
b2xvciA9IDxMRURfQ09MT1JfSURfR1JFRU4+Ow0KPiArCQl9Ow0KPiArDQo+ICsJCS8qIGZvciBz
ZnAtMSAoSjQyKSAqLw0KPiArCQlsZWQtc2ZwMS1saW5rIHsNCj4gKwkJCWxhYmVsID0gInNmcDEi
Ow0KPiArCQkJZ3Bpb3MgPSA8JmNwMF9ncGlvMSA0IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCQkJ
Y29sb3IgPSA8TEVEX0NPTE9SX0lEX1lFTExPVz47DQo+ICsJCX07DQo+ICsNCj4gKwkJLyogKEoy
OCkgKi8NCj4gKwkJbGVkLXNmcDAtYWN0aXZpdHkgew0KPiArCQkJbGFiZWwgPSAic2ZwMCI7DQo+
ICsJCQlncGlvcyA9IDwmY3AxX2dwaW8yIDIyIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArCQkJY29s
b3IgPSA8TEVEX0NPTE9SX0lEX0dSRUVOPjsNCj4gKwkJfTsNCj4gKw0KPiArCQkvKiAoSjI4KSAq
Lw0KPiArCQlsZWQtc2ZwMC1saW5rIHsNCj4gKwkJCWxhYmVsID0gInNmcDAiOw0KPiArCQkJZ3Bp
b3MgPSA8JmNwMV9ncGlvMiAyMyBHUElPX0FDVElWRV9ISUdIPjsNCj4gKwkJCWNvbG9yID0gPExF
RF9DT0xPUl9JRF9ZRUxMT1c+Ow0KPiArCQl9Ow0KPiArCX07DQo+ICsNCkhlcmUgSSBhbSB1bmNl
cnRhaW4gd2hhdCB0byBwdXQgaW4gdGhlIGxhYmVsLg0KRWFjaCBTRlAgaGFzIGEgc2luZ2xlIGR1
YWwtY29sb3IgKDMgdGVybWluYWxzKSBMRUQsDQp3aXRoIG9uZSBncGlvIGNvbnRyb2xsaW5nIGVh
Y2ggY29sb3VyLg0KDQpDb2xvdXJzIGFyZSBzaW1pbGFyIHRvIFJKNDUgY29ubmVjdG9ycyAoeWVs
bG93LCBncmVlbiksDQphbmQgYXJlIGludGVuZGVkIGZvciB0aGUgc2FtZSBwdXJwb3NlOiBsaW5r
LCBhY3Rpdml0eS4NCg0K

