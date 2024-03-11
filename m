Return-Path: <linux-kernel+bounces-98811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A4877FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFDA281643
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733613BBFF;
	Mon, 11 Mar 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Ywkj4rtE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99903BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159237; cv=fail; b=fl6iF6ey4VETe7YWVfh+xIEvLg5bLxl+TkqKgU8NWNG3FXN2dlP+c8FbU7H70qwYSGxKOOR09lAtIU4/UMIkPv5uxu8AVmMj07EQaUjL5jp2mTAP06ev917cxcf7TpA1aRx4dFjIjaT1y72A3oUr/UIfe00PFUgAaKHme045Y6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159237; c=relaxed/simple;
	bh=iGOafiKYYveSfTdiZ6s0y1m0n023oH4UhPxIyyKSD7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3QqX1wZtgU+bUO7RVv1m1mfmKRKSg6tdaLGuB/XYtptP74oH4pp3xiqRllW5nU1YlpD75HKZt1O4PT13KP03xPIHvwQovLEZbBASetfw6TrD0N8khePAsIJ5cgXdC2twdgZmGaZLSeukab5BxWOniUH0Lyg4I9btla1RDOLLcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Ywkj4rtE; arc=fail smtp.client-ip=40.107.215.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM01SkJQv/YZ1UgLXYrdHO2lP1Ip5/0+d3J+3ASK2yVQRZnnr+pu+VecoeKQb69MtYRMyB0rwMSYnQh35UiQmldXAejjRw6Xqss5Av23oHsOh270Qq2nz4EJDkPflqIVNbMnPuc4Vy5B7D6GDP0RHfT6yEpukmLo0RlSLui4Uf8R6CqLAauw/pEWPkYQeSIXXwUFojbjp/HEaI9JJ7byuZpL9GkuN1Kxq5jpoG7q/yeu9yV0+WXl7dW6E8JuN23q0EYdgN/Qq9m2P6jmY9t1ag7Mrtce+AMOL6tRdotRwjhtTytTDJ6hCUJZGj2/fyNqO3tyc8BQ+iy+VrFwUzWmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGOafiKYYveSfTdiZ6s0y1m0n023oH4UhPxIyyKSD7o=;
 b=CvK6qlAgSopgNRWecfPXfS2MqNDIqUuYhlTac4qKL3Y3Q8plwAnNl6UQfolDGAQm7b3YR9KUk8dDyjxpHudR9Un61waT6JVwYEYrsNBd2WZv2PKqt/6iSBIzu9sliQT8Yzy0qrAUrvaufIgbc4gPrVBRP4Wa6pOEhYXJcZZ7sYlc9Ab7dWz/vmdNVl4OhJJRQXmhDapmm5MxgN/mJTewi0pdGDyCM/Ddi//fkeExHME2Nu3rzIiioUtRVls0ysnSdNIOzRJS0qElyVQ9eulII/6T+HSFPEITJ1QUzD9kQUqoQTl4TUfQOBvXY9sy6+vTe9zWdo/35YUqWwjPQJbYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGOafiKYYveSfTdiZ6s0y1m0n023oH4UhPxIyyKSD7o=;
 b=Ywkj4rtEm4EZ49YySNvHyZfB7B3+TPMELwGCInngjuDw280aYMtt8pF46QhCidoFjmT5i6BSBhi5tWSng2TzkMvKNNRqUTDX+UsHpcQxD9YhGamC52rk/Dcbb9e3exCBiY3gSdA6gjNfketoGiqL/mHlJFVgzC8Lv/yBjtp3lRwSYAhZBvNa/fTGjWjTS2yDMXwP4yiTVWpSC/jdmuvlx4XS+dffTy2xRCAJGD09NnnQR1dCORzzze425oDiMO30rHKr0h0dYAi9kk9nW0h+QoAmONY0JV9cavFaF5wYiIBCyr8IETkrsFeBZfNKTr/v9omzhOdX1yJBkhrqAZKrgg==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by KL1PR0601MB5599.apcprd06.prod.outlook.com
 (2603:1096:820:9b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 12:13:50 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::1ecf:ff1c:bbe9:49e3%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 12:13:50 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: "james.morse@arm.com" <james.morse@arm.com>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "reinette.chatre@intel.com"
	<reinette.chatre@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Liming Wu <liming.wu@jaguar.com>
Subject:
 =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBmcy9yZXNjdHJsOiBmaXggZG9taWQgbG9z?=
 =?gb2312?Q?s_precision_issue?=
Thread-Topic:
 =?gb2312?B?tPC4tDogW1BBVENIXSBmcy9yZXNjdHJsOiBmaXggZG9taWQgbG9zcyBwcmVj?=
 =?gb2312?Q?ision_issue?=
Thread-Index: AQHac4AkEIbtytV3wE6T19k1pZ0h/bEyM+8AgAAHshCAADHDgIAAAWKA
Date: Mon, 11 Mar 2024 12:13:50 +0000
Message-ID:
 <KL1PR0601MB5773162A7800668486209FF6E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com>
 <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65>
 <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
In-Reply-To: <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|KL1PR0601MB5599:EE_
x-ms-office365-filtering-correlation-id: 3d3d0a77-36df-4d15-7e46-08dc41c4b5eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Vd/uhLcaeu+3AJNbsDqV2+wK7LPnexRygRHlRSE74VPYSH49PLLXN3CAXnIvL5seo5LIkYprU/X97XaECqOYeSlOd4AzIx5BO45zJz9/P9THVxSy9eAHbv3qAqYNlgfx7Fo2I03gIuMnDAXpWA3BfZ7wtmiG+cZSY0yqMQ5RLf6+MJ363UaEmKXPKW0enrMGEPfGrJt8udix61uner419SpCeOJ+r1QpJ8sJz4yhg+ga71KHK6JqY/xYCVU97hIL4vQiAGHw2y6nzza9hxreMOLC+1un8gYzTJr5sIdv8Z4rIChH6dxDrSLcsFGx6p7qG9CH+6pnP5wPasqk6wLHXBNOwkEk9YuVKU/OuQrxrbpQoLTsm2ls/tnwoM0yAFQr/M/01SjrEPQFqoK7LKRB8z7Km5CeLmxpP1Zy93qxRUGzo66hv8O1pSWMOe15+XUWzGdVZvIx93zBWyJ0lAM9Eq/jYor2Wvkh60IO6XOB1IKsMvpuapLlQLjUVAmnwo1bRVr2twrAorer4wEWkoEKwWQtz5bc3EJR4xEQr61dr5mKQAxhHbFhlCLCXYqUY6npLqdE5L+cHTuvJ9/F5GmKm9Ej/FPdBR5+FrutuQ63IXY0tA8CkuR1LfM/kDLO4OH2NAp/7Q326O71ZX2ZY9eTcB372BUNjrM5xUXZvHWFYBs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cWJXVlhUbW9RckNWbUFKc29rRC85WGlwdU84ZFB1WFZwMXJwL1dJOEQ5amg5?=
 =?gb2312?B?dWxjSzBLNjEzdDg1dHlrR2dKWFk5MmhoTHBsSzUwTitna012dW0yR01mYXBn?=
 =?gb2312?B?bjZ4dDE1dWdlcnhrUWt0SHhYdysvaENKUDJWTklPUUpOLzRIWFRLQ1pYdkpq?=
 =?gb2312?B?U1BqT1V3RllzQ2YzdWpiNzlsN28vNTFzMGh2RHFEdllpVEJDbFZ3c0h1eUlx?=
 =?gb2312?B?V0twMUhUTkdLTWhLVHV3c3dUbEI0bTdMQWxuVmdMS3pBTUxnZTJENFlGVjdS?=
 =?gb2312?B?QlpLMGd1VExzUXEwaWYzUDE5OHQ2MVJEcCs0UnpRb1hHUm9SdW9zTEozRjYr?=
 =?gb2312?B?ckcwSFM4TUt4TkN4TkR0UGxvTkgramNOTFFuaUsxUC8zMHpyZDNwRkM1a3Qw?=
 =?gb2312?B?UUJRcFRFYVh2QjhwNTMycXI3SXhvVlZyamZBdytoWXp4L2tFVm5Kd21ucXhp?=
 =?gb2312?B?NThPYXJSOXR3MlA1cHB6eVZ0OFVCc3RNUVZpYUhOY0hGUFMvREI1ZU53YmJN?=
 =?gb2312?B?UzM3NVZBMGNUcndONDFtdDdrNE5BbFlpWmowVUdTNVBISXdIRVhGV1o5bHhF?=
 =?gb2312?B?aEF3K3dobnpPZEFVSkd1alh0ZzJjOXVObEdCTFphcEZleU1jSUh3bnZ5SmQv?=
 =?gb2312?B?bVFZbGdPTHpydnlVVUJma2owdzd6Vkd6b1hpdUo4NDdlalVuSEY2OVdSYzln?=
 =?gb2312?B?Vkp2MjVrakVUc2RpVFozQkNiczJCTDJrZG90NDFUSE5NVmtscDZ2WGNWRmxF?=
 =?gb2312?B?SHVzTGxKWXFqamxFNm9kRDF2WFpOcGpwSXpPZGl1K3NseUtuaG5YOVpCSm9M?=
 =?gb2312?B?MlNCcmhrTms0UDdWRnBpY0RLTUpjMzFHMTBqNFBrNTFYTHl1Zi8rdWVTRzMx?=
 =?gb2312?B?K1Z1QTdNMVgyUkgxdEpuRDdNSmlsS0M1QU9FMXo3eEViVHUxQVZsUEQ1bElB?=
 =?gb2312?B?Rmc5V3JWQTlLRnkwRit6NGd0VXd5TmRSdk5KcHpQcWd2UTBFdFIxMFZ1ckEw?=
 =?gb2312?B?SlVPOVdMY1dOdzJRcTNza2tBUDlaVFV0UVBtYWlvbWliYlBuNFJTMmM3R0hX?=
 =?gb2312?B?VWxnTTcvbzRQbnVaQ2tNaElsQ3QwdUlHcm5NMXB2Rnl6T0FuR2c2YVdzVWhN?=
 =?gb2312?B?ZFNjUThPbzNMQTJ2MW5KcEFwVWpETGVuVUExbXI1dTdENlIzcjJMM3NjOS9I?=
 =?gb2312?B?TWJJTEErQllrNzY5TVYrMy9GajBBTzl0dGFSNEVNSi9KUlVPZzltYW1PQ0xm?=
 =?gb2312?B?cW81MERnakZHZGdiVlZQNTUrYnBvRFozblpXUGdacDkxNC9CRlA3MTNLNUtl?=
 =?gb2312?B?VisyaFNaQ3JTWkN2aWsxS3NIYXZrdldvV0RHZFcwR3JRU01na2dlalhwZXA2?=
 =?gb2312?B?UnlYQlhjbmJzVTZ4L3ZpMjE5akFIS1BkeDkzMVRCbHY0SlBXQTFkamMrYkI4?=
 =?gb2312?B?TDFJUzZGR0xkSUxiRmJzUzcyRnpaMDdCRFcxbzJMRHpYMzd2bUM1a0RseFhr?=
 =?gb2312?B?UmZUWVhYN3RoNFhJSkRGTjNwRHY1aDNoY3hwMjFRQmFzRGorUTdKellseGFE?=
 =?gb2312?B?UVRlRlZRaTdUU2RRa0dERER0MnhadDNQTWxaTmVzVnR4U1hTZ2lmQVZKSTBJ?=
 =?gb2312?B?UHdiZnl5QThrMk5GUzVzczRKVm1jVmtFejJkang2VkRiRzJVUDFzSld6cDRW?=
 =?gb2312?B?ZitpZnlRaUxHRzQxUXNnK1AySm9peG1YWmdQb000bzdJS1diZk96WWdIVUVM?=
 =?gb2312?B?WS9wV3dkWGt4dFova29JMGtTT0JjZmlqM3NTVGozdmVqcHdlM2YyczJ6SGpN?=
 =?gb2312?B?ZGVjZlB3WVlqTUlLSEVOWWd6djN6eit3QTFtY0poZ1ZWTGxzTXFSSTYyNUhi?=
 =?gb2312?B?K2ordkhCWUtyY1BPWFdMVDZFOUx0aHlOcHZsTDRBT0E4YjFzMVZrRkF0Y3hP?=
 =?gb2312?B?UEdjR216MGhZOE5KdUlCSUgyOXNFTnNOMmQzOVp5cEMvYStTRVZTZDJ2enRi?=
 =?gb2312?B?MnRpN3l0VXRkNWk3S3NoWjV3N3FyQm5mQ3RZd3pLSytzc21RUDJnZXV4TFV1?=
 =?gb2312?B?eW55ZmFuUFF0T3BjRHlqLzVmN2tUNnVWTjRNckF3dUZCK2Rud3VwUnd0bDVK?=
 =?gb2312?Q?Y1eVH8f8d8CfDnojzTSGR1BWz?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3d0a77-36df-4d15-7e46-08dc41c4b5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 12:13:50.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4FdpDhQPV17N8ABOd/vaTS/wXdaM8UuDV/eJtCNosQh9F1/Kco5ubTMzt14fBswsGqi5UZYQCk4TQNQ03E/3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5599

SGVsbG8sDQoJUmVwbHkgYXMgYmVsb3cuDQpCZXN0IHJlZ2FyZHMNClJleA0KDQo+IC0tLS0t08q8
/tStvP4tLS0tLQ0KPiC3orz+yMs6IE1hY2llaiBXaWVjem9yLVJldG1hbiA8bWFjaWVqLndpZWN6
b3ItcmV0bWFuQGludGVsLmNvbT4NCj4gt6LLzcqxvOQ6IDIwMjTE6jPUwjExyNUgMTk6NTANCj4g
ytW8/sjLOiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4gs63LzTogamFtZXMu
bW9yc2VAYXJtLmNvbTsgZmVuZ2h1YS55dUBpbnRlbC5jb207DQo+IHJlaW5ldHRlLmNoYXRyZUBp
bnRlbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbWluZyBXdQ0KPiA8bGlt
aW5nLnd1QGphZ3Vhci5jb20+DQo+INb3zOI6IFJlOiC08Li0OiBbUEFUQ0hdIGZzL3Jlc2N0cmw6
IGZpeCBkb21pZCBsb3NzIHByZWNpc2lvbiBpc3N1ZQ0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBE
byBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3Jt
YXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcGx5LA0KPiANCj4gT24g
MjAyNC0wMy0xMSBhdCAwOTozNzozNyArMDAwMCwgUmV4IE5pZSB3cm90ZToNCj4gPkhlbGxvLA0K
PiA+ICAgICAgIFBsZWFzZSBraW5kbHkgY2hlY2sgbXkgaW5saW5lIHJlcGx5LiBUaGFua3MuDQo+
ID5CZXN0IHJlZ2FyZHMNCj4gPlJleCBOaWUNCj4gPg0KPiA+PiA+VGhpcyB3aWxsIGNhdXNlIGJl
bG93IGlzc3VlIGlmIGNhY2hlX2lkID4gMHgzZmZmIGxpa2VzOg0KPiA+Pg0KPiA+PiBJcyB0aGVy
ZSBzb21lIHJlYXNvbiBmb3IgY2FjaGVfaWQgZXZlciBiZWluZyB0aGlzIGhpZ2g/DQo+ID4+DQo+
ID4+IEkgdGhvdWdodCB0aGUgbWF4IGZvciBjYWNoZV9pZCB3YXMgdGhlIGFtb3VudCBvZiBMMyBj
YWNoZXMgb24gYQ0KPiA+PiBzeXN0ZW0uIEFuZCBJIG9ubHkgb2JzZXJ2ZWQgaXQgZ29pbmcgdXAg
dG8gMyBvbiBzb21lIHNlcnZlcg0KPiA+PiBwbGF0Zm9ybXMuIFNvIG5vdCBuZWFybHkgaW4gdGhl
IHJhbmdlIG9mIDB4M2ZmZiBvciAxNmsuDQo+ID4+DQo+ID5JdCBpcyBleGFjdGx5IGFzIHlvdSBz
YWlkIG9uIFg4NiBwbGF0Zm9ybXMsIGJ1dCBjYWNoZV9JZCBvbiBBcm0gcGxhdGZvcm0gaXMNCj4g
ZGlmZmVyZW50Lg0KPiA+QWNjb3JkaW5nIHRvIEFDUEkgZm9yIG1wYW0sIGNhY2hlIGlkIGlzIHVz
ZWQgYXMgbG9jYXRvciBmb3IgY2FjaGUgTVNDLg0KPiBSZWZlcmVuY2UgdG8gUkRfUFBUVF9DQUNI
RV9JRCBkZWZpbml0aW9uIGZyb20gZWRrMi1wbGF0Zm9ybXM6DQo+ID4jZGVmaW5lIFJEX1BQVFRf
Q0FDSEVfSUQoUGFja2FnZUlkLCBDbHVzdGVySWQsIENvcmVJZCwgQ2FjaGVUeXBlKQ0KPiBcDQo+
ID4NCj4gKCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXA0KPiA+ICAgICAgICAgKCgoUGFja2FnZUlkKSAmIDB4RikgPDwgMjApIHwg
KCgoQ2x1c3RlcklkKSAmIDB4RkYpIDw8IDEyKSB8DQo+IFwNCj4gPiAgICAgICAgICgoKENvcmVJ
ZCkgJiAweEZGKSA8PCA0KSB8ICgoQ2FjaGVUeXBlKSAmIDB4RikNCj4gXA0KPiA+ICAgICAgICkN
Cj4gPlNvIGl0IG1heSBiZSA+IDB4M2ZmZiBvbiBBcm0gcGxhdGZvcm0uDQo+ID4NCj4gPlJlZmVy
ZW5jZSBSRF9QUFRUX0NBQ0hFX0lEIGZyb20gZWRrMi1wbGF0Zm9ybXM6DQo+ID5odHRwczovL2dp
dGh1Yi5jb20vdGlhbm9jb3JlL2VkazItcGxhdGZvcm1zL2Jsb2IvbWFzdGVyL1BsYXRmb3JtL0FS
TS9TZw0KPiA+aVBrZy9JbmNsdWRlL1NnaUFjcGlIZWFkZXIuaCNMMjAyDQo+IA0KPiBhbmQgdGhh
bmtzIGZvciBjbGVhcmluZyBpdCB1cCBmb3IgbWUhIEkgYnJvd3NlZCBzb21lIE1QQU0gcGF0Y2hl
cyBidXQgZGlkbid0DQo+IG5vdGljZSBjYWNoZV9pZCB3YXMgdXNlZCBkaWZmZXJlbnRseSBvbiBB
Uk0uDQo+IA0KWWVzLCB0aGUgbXBhbSBkcml2ZXIgZnJvbSBrZXJuZWwgdXNlIHRoZSBjYWNoZV9p
ZCBhcyBjb21wb25lbnQgaWQsIGRvbWlkIGRpcmVjdGx5IHJlcG9ydGVkIGZyb20gbXBhbSBhY3Bp
IHRhYmxlKHN0cnVjdCBhY3BpX3RhYmxlX21wYW1fbXNjX3Jlcy0+bG9jYXRvcjEpLA0Kc28gdGhl
IHVzZSBvZiBjYWNoZV9pZCBpbiBtcGFtIGRyaXZlciBpcyBOTyBkaWZmZXJlbnQsIGJ1dCB0aGUg
ZGVmaW5pdGlvbiBvZiBjYWNoZV9pZCwgb3IgaG93IHRvIGdlbmVyYXRlIGNhY2hlX2lkIGZyb20g
ZmlybXdhcmUgc2lkZShVRUZJKSBpcyBkaWZmZXJlbnQuDQoNCkkgdGFrZSAyIGNvbW1pdHMgZnJv
bSBlZGsyLXBsYXRmb3JtcyBvZiBBUk0gRlZQIGZvciB5b3VyIHJlZmVyZW5jZS4NCmh0dHBzOi8v
Z2l0LmdpdGxhYi5hcm0uY29tL2FybS1yZWZlcmVuY2Utc29sdXRpb25zL2VkazItcGxhdGZvcm1z
Ly0vY29tbWl0L2Q5ZjMyOTBiMGJhNjNkY2M0YjEyNDAxN2Y2ZGVkZTVhZmI2ODFjYmINCmh0dHBz
Oi8vZ2l0LmdpdGxhYi5hcm0uY29tL2FybS1yZWZlcmVuY2Utc29sdXRpb25zL2VkazItcGxhdGZv
cm1zLy0vY29tbWl0LzA4ZmU5MGU5MGE4NGM3YWUwNzRkZGNmY2ZhNThlNzNlYTdjMDNhNDkNCg0K
DQo+ID4NCj4gPj4gPi9zeXMvZnMvcmVzY3RybC9tb25fZ3JvdXBzL3AxL21vbl9kYXRhL21vbl9M
M18xMDQ4NTY0ICMgY2F0DQo+ID4+ID5sbGNfb2NjdXBhbmN5DQo+ID4+DQo+ID4+IEhvdyBkaWQg
eW91IGdldCB0aGlzIGZpbGUgdG8gYXBwZWFyPyBDb3VsZCB5b3UgbWF5YmUgc2hvdyBob3cgeW91
cg0KPiA+PiBtb25fZGF0YSBkaXJlY3RvcnkgbG9va3MgbGlrZT8NCj4gPj4NCj4gPkkgZm91bmQg
dGhpcyBpc3N1ZSBvbiBBcm0gRlZQIE4xIHBsYXRmb3JtIGFuZCBteSBOMiBwbGF0Zm9ybS4NCj4g
Pg0KPiA+QmVsb3cgaXMgdGhlIHN0ZXBzIG9uIEFybSBGVlAgTjE6DQo+ID5tb3VudCAtdCByZXNj
dHJsIHJlc2N0cmwgLyAvc3lzL2ZzL3Jlc2N0cmwgY2QgL3N5cy9mcy9yZXNjdHJsL21vbl9kYXRh
DQo+ID4NCj4gPi9zeXMvZnMvcmVzY3RybC9tb25fZGF0YSAjIGxzIC1sDQo+ID50b3RhbCAwDQo+
ID5kci14ci14ci14ICAgIDIgMCAgICAgICAgMCAgICAgICAgICAgICAgICAwIE1hciAxMSAwOToy
NA0KPiBtb25fTDNfMTA0ODU2NA0KPiA+DQo+ID5jZCAvc3lzL2ZzL3Jlc2N0cmwvbW9uX2RhdGEg
IyBjZCBtb25fTDNfMTA0ODU2NA0KPiA+L3N5cy9mcy9yZXNjdHJsL21vbl9kYXRhL21vbl9MM18x
MDQ4NTY0ICMgY2F0IGxsY19vY2N1cGFuY3kNCj4gPmNhdDogcmVhZCBlcnJvcjogTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeQ0KPiA+DQo+ID5Bcm0gRlZQIE1QQU06DQo+ID5odHRwczovL25lb3Zl
cnNlLXJlZmVyZW5jZS1kZXNpZ24uZG9jcy5hcm0uY29tL2VuL2xhdGVzdC9tcGFtL21wYW0tcmVz
DQo+IGMNCj4gPnRybC5odG1sI21lbW9yeS1zeXN0ZW0tcmVzb3VyY2UtcGFydGl0aW9uaW5nLWFu
ZC1tb25pdG9yaW5nLW1wYW0NCj4gPg0KPiANCj4gLS0NCj4gS2luZCByZWdhcmRzDQo+IE1hY2ll
aiBXaWVjeqiuci1SZXRtYW4NCg==

