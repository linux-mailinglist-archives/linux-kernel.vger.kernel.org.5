Return-Path: <linux-kernel+bounces-138030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA5B89EB48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE901F24F57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398C273FE;
	Wed, 10 Apr 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZBbzpYOT"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2112.outbound.protection.outlook.com [40.107.7.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FE8C15;
	Wed, 10 Apr 2024 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731945; cv=fail; b=qxbU9mT/zKEvpkaliPBQXRcv1yLB/sfzvyA5jrQmFmBeTHpME41yyIyUu8HIw/bbyOq7csB3neCebTlaROpOBlpi4ynpUmLJEDoxhn4dhUm7ZfZ3plMR9fi8TzqCqIjxDhXSv6nxzM7mrt1rxFsWBYDp/0VA0tEhxNBDVhxlTok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731945; c=relaxed/simple;
	bh=AK+TzEDEIBFwhL83u+iOwQ0VeMdwXiQNOgSpGTUuqQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tsEuhx7zUnV4AOCILlM16yPWNC2EzkeOpJeWj5kCNB0Kjm1b+J0oDAMucSbWgZ0R+EPEQlpL/nctFN1FXVUdwLmDfyBsrBeUbZwb24xEz2YXnZ4lXYOdeH2wr1KrAM3NfnluSs1r9odG8pKSzHYrsj48NHXf3CtR1TPm1a3nlHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZBbzpYOT; arc=fail smtp.client-ip=40.107.7.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aweMKN62WZrjuB1iTH6r+IUPlU+hVhjGlwHOinAarVJUopOd+OHATSkCpW0X2HthuGEYqn6WtaGJCNAX/3Vop/fawYzfz33k8hMPN5RbGgO369nSACBWE3MphSpGtHM5rqCvU1x61kBZv6YTBuL+qc4swzMyVVMfMBQ2YhoFCKwqr0knh0Gw2AkyleDirAmi1WhGuDO7hJ0jgjOvmfgLEaQtrYzEP4J5WqIBfYGsMyv1HGU/cH+oTlyrrngHtSE4lrzcz0fkp/i7rmy1nk/zxJkax7cTxul5ZhiCI+L5Jm3g8/4j334Rn4cC0jPqDEQ0IkK4bcoiIfxK1NZ+FT12PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK+TzEDEIBFwhL83u+iOwQ0VeMdwXiQNOgSpGTUuqQw=;
 b=J2atTYnzfPy+1OI0GiH/4x7gMI1CaArgsVNnbfGzPhQl0LqbllzHPaLQmEKJ/ADqqPtv143xN4zGv/2X6dvWOvILd3Gc3YprRyN1MkuO+s+Z6yVvWWYuZPbihO5MnSz3M8TwWBrugKhHZcjLr24JEEY+fkkm5U6y5XG79boLMLmbwKeOBLQebEM4UImebj3AOJ/v3xGPQak6Rjj+LWa26NrL2+nRkNfDRdRhiwItbJeEBV1I8dJUv1YHDm3ypkS+xo6UwNO2BQF9beq+PRBXUiel6lU/aOhLcrbLdDI96xNGQA4bk0M8OWeSpfjKfGAPSJk0iY+tcJmlTCx/+74STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK+TzEDEIBFwhL83u+iOwQ0VeMdwXiQNOgSpGTUuqQw=;
 b=ZBbzpYOTGbnOyMyzZG5y77D8EGsU28OBtuc9vWsNPpLAAe3GyEqUrKMWKmC/EbRCcyC1O2MIOBcptqx/Urg5LlbiklOIUEsIIaGnmI/rmIGhighjpbfzVBSNJrAIcyf7Vm++l+PNnX8PtF8FKiEUAKAV6Q6aWJzLFGj0qIjz8/4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB7691.eurprd04.prod.outlook.com (2603:10a6:10:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 10 Apr
 2024 06:52:18 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:52:18 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jacky Bai
	<ping.bai@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v2 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHaivavbImduAOglEq4m5zqJBxnf7FhDFYAgAAEYkA=
Date: Wed, 10 Apr 2024 06:52:18 +0000
Message-ID:
 <AS4PR04MB9386744FFC9DDAB42405847DE1062@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240410033256.1341662-1-joy.zou@nxp.com>
 <20240410033256.1341662-2-joy.zou@nxp.com>
 <d53ab0fd-cd12-48ec-9a80-6ae17690b726@linaro.org>
In-Reply-To: <d53ab0fd-cd12-48ec-9a80-6ae17690b726@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|DBBPR04MB7691:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ppEpxyzrx9FMwFT5nH2j82ff/Ndd5UNhP8rbNLHlpFUeVc38NwAVx3Q5KsLT947Tg3nj119POlCl1GC9gi/lF9rakatpsu2slVDRNlt/qi0MI2qm8SfECDgm/GwnrX0ACeN7Ykzpqp8j84A6+2oSmMqfyfnrRh3CNIYFjT19PbChIDWHUHXCsRtprkonHNoUM0dP8cHjQbSvsBtQQ15HbwzTCOFBR0N8uGBMka2HmgHBf7eRE1HMvEiJsioWjJ8l6lvTNdqB7p5ZXr+AR6lOYjwKLjsBM2M+zdlk5xhpNeKrmAgIrZ7/f7gAQd5WTLUMUtoNq9KUCeK+keyWagUoSZlG9t1thoSXdt7zAixTX4hICDrPr6+pxSSf3Ke32cDIubTNh57ZhcLhkJ5nOH5v+kMuwVkHL4zuGG2olujw77/5wEaGketrU7B/8jhk9Eq8nsd5LVPCeF2fEcV55KC3ldJIBQjmPwTihhX2p+lItj2rA/B/0Wm5PPBRD/iCk+2DO/YSwRUZfkmO6E6Rjnq6hX4umliz/pe8NDbHCGujZf4glr3rRw4zgXFb0IC84FqgL3U+520RtmKSjIa3vqfSZT2NhbAXF+b1a9vIUc2sl1Sa/x5dccN/dUs5wDmsCegV2pLrqV8AvHdkpNPw+nJAQigoG6MU8nmpIWUyXZYzLW0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RUhSMTdkelIxTjduUGNibFY5NjVqS3ZkUlp2bWpVdlVWZzdKcFplaVROOWNM?=
 =?utf-8?B?bHZQR1duUzhkSkw5RElyWk9tT3A5U1JsU0RBV3g1ZmVLY1hUbFFScnlRenhI?=
 =?utf-8?B?dnJwRmdqVjdKbmRrY2hYcnVRY2NSa3JlVHgzdWV4SlA1QWpPSDN4UUs4NkNO?=
 =?utf-8?B?ZFdMYitZamdsUFhzbnhkNVdjcG1obHAvdUUyUThQYkpCdlhRUmM3WU1QTStS?=
 =?utf-8?B?Qlg2Qi9yR0F4S1RnNkt4R3dXVGZQOVBGVEYzamMvOW45Y2swSEUxOFFhRVM4?=
 =?utf-8?B?bzlVM0pmWDZ2M0N0MHhYZWxLOUVYSFU0bTkzK01GZmFKL2VXejk4R3RYc0gz?=
 =?utf-8?B?NlFFTkVhQlZGZ3JaTUY0U1A3RDhFaisyUXVtZ3hpU1BmVkFKMUM4eExnNDBu?=
 =?utf-8?B?TnU4ZmpCSVBFT29zTVVhMFJoUFF5UEZZeng3Mmt2alA4T0pyRFlnWjRGWE1C?=
 =?utf-8?B?RFFleUdJdFE1b1RmMDN6NXJOcE1MbWpkWGZxbk9aWHpYYldtdkJyUk8rUkZl?=
 =?utf-8?B?SjA5KytRMG5zT1ZaYWJ2VFl2d0ZFdVRMLzhGTGlUanNrdkljQUtVa01FeGVQ?=
 =?utf-8?B?RHpJekVsK25IVmwrTGVqT1ZXUm0zUzdDS28xQ0xwZkpsUFlMZEFNeU9lWWR3?=
 =?utf-8?B?RFlrU3NBTWNZaXZheS9TRkdHdmQyNnhLRTR0a1BxOVJKUWdUMDAvVUNjS1ZD?=
 =?utf-8?B?ZlpHbE0rUkhuMTBHWUNnM1lOUk1MczdydUJaVk5hRXRXeENuK1JiOEw2cHda?=
 =?utf-8?B?VGpZdVVRSko4Qlhmd0NBc2wyMklEaGExUmo2ZmRSUCtVWWw5L2hJbGVjMVBv?=
 =?utf-8?B?NUkvQmtnVGdjMDhocFVscndBbEt4cmZ3UlRsZmZvaUxnKzNZU2hlRzJIV2ND?=
 =?utf-8?B?MHVBbDRveWxYTWpyRkEzWit3OW1QVnBYclJmdktFODBCWUtmNExRckEzQzgw?=
 =?utf-8?B?NUZ0VXBmakgvZlRsekJLbHNodVpsUjJhcTk3d2t2TlRENWMwU1M0cnhXdGdZ?=
 =?utf-8?B?U2FwaFV6SWZvNE11bDltTENjTlRDNENjeGRVc0hHNEJHU09Ga3BVVWlDdmVQ?=
 =?utf-8?B?NEUxaE0walhtSWs4cnRVdjZBUnA3enUyNzhhdlNyalJ4bkFmNVVuRVRkRE9R?=
 =?utf-8?B?cEIzQys2MXZXNlVuRms4Z0l5dlo2QVZYcDNpNVNUQW5HdlBuY3pGMXlsZHNB?=
 =?utf-8?B?bWgvaHBJRTVMU3JFRkhnUWNPeVRpSnN3TDB2ME5rOGRGSHdmR2F1V2E5bi9w?=
 =?utf-8?B?SktBQ2k0MXRwWWV6T2tsYURnSXZlWlJoQjRZWXh1OFpPTjRMRmpaa28yUWtx?=
 =?utf-8?B?TW1KcVVrQWJWRlkvQW83MHFlSE1zK2xRMVk5TDhTS0t3anB6ekJ5blBORzlS?=
 =?utf-8?B?bmJ6Mm8yNGlMdlpKK1FEWWQzOVZHdGpnL21OZmNnS0xUbkp4djQzNDJ5U2FS?=
 =?utf-8?B?TFhHQjN4UGhjalhRRDVlTkx2M1NoNmRwcnNHdEFSb0xtMlNvamU2T25IMEhw?=
 =?utf-8?B?SGtDcytEVGxmcUVISkJZUzUzTVB3c1FoR2tuRkc1WHFYbnZNWUJ0aC96cUdY?=
 =?utf-8?B?eXZMR1N4dUdOSTJkdVZnVFFEenlqUnh3aUNUd0kzMWRrbjlxQnNYK3E0SDFV?=
 =?utf-8?B?QjZXYXo0UUtML3pBaG0rYXl0dExaMHhFOVR2aVpWYXc1Y2hYb0o0Q21DSFlJ?=
 =?utf-8?B?azYxVWJqbW1wSWRzdGVkcTNWQ3o0RTNjcFc3UGIwbEI2bGh4TVo0Wk5vSU11?=
 =?utf-8?B?UlJKVW5OTjZCQzZjMWRMZGdnWTZJQ2l1L1h3QitTVjVBWXI3d3dPbzdsbHNk?=
 =?utf-8?B?UXgwUnVlNW1BR1cxOFRUalQzcVhDMDYrSDFrSmViWWc4S0Q2cmtveGpiSXhy?=
 =?utf-8?B?YlNMTFpGUXB3c3JncW1iMTdXTkhPZFk5L3pIQmt1LzQ2WE1MUS9VMmF2L1g4?=
 =?utf-8?B?RklNRnBQTUdUNGFwSThPMFd4dE95cks1VjkySU9CdmVwTUVXdnpoLzdQY2gw?=
 =?utf-8?B?K3VlZkhBdXFtUEVyMzVIU0ZqVGsyQUgwNGZhOHpkc3BzK3dNWmRwaFIzSjJT?=
 =?utf-8?B?K0xsd1ZZWE5ydnllZDBLUEJoRVl3VzR0WVV1bHdKN3QzYXVCc2FUSGFjTDRL?=
 =?utf-8?Q?os0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847d15a8-19d7-4515-a9c9-08dc592ac3c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:52:18.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppO8o6MzIU1C42ttIVjwshCK4t+wGY//bW0qje3HWPhr03Zk2gUvci6u5zxdRg5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7691

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNOW5tDTmnIgx
MOaXpSAxNDozNA0KPiBUbzogSm95IFpvdSA8am95LnpvdUBueHAuY29tPjsgSmFja3kgQmFpIDxw
aW5nLmJhaUBueHAuY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGtlcm5lbEBwZW5ndXRyb25peC5k
ZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29t
PjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyIDEvMV0gYXJtNjQ6IGR0czog
aW14OTMtMTF4MTEtZXZrOiBhZGQgcnRjDQo+IFBDRjIxMzEgc3VwcG9ydA0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5k
dHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRz
DQo+ID4gaW5kZXggMDdlODVhMzBhMjVmLi5lNjY3MjNlZDI1YzIgMTAwNjQ0DQo+ID4gLS0tIGEv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMNCj4g
PiBAQCAtMjgxLDYgKzI4MSwyMyBAQCBsZG81OiBMRE81IHsNCj4gPiAgICAgICB9Ow0KPiA+ICB9
Ow0KPiA+DQo+ID4gKyZscGkyYzMgew0KPiA+ICsgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiA+ICsgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgIGNsb2NrLWZyZXF1ZW5jeSA9
IDw0MDAwMDA+Ow0KPiA+ICsgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7
DQo+ID4gKyAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2xwaTJjMz47DQo+ID4gKyAgICAgcGlu
Y3RybC0xID0gPCZwaW5jdHJsX2xwaTJjMz47DQo+ID4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0K
PiA+ICsNCj4gPiArICAgICBwY2YyMTMxOiBydGNANTMgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm54cCxwY2YyMTMxIjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgcmVnID0gPDB4NTM+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZwY2FsNjUyND47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMg
PSA8MSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+Ow0KPiANCj4gRml4IGluZGVudGF0aW9uLg0KVGhh
bmtzIGZvciB5b3VyIGNvbW1lbnQuDQpZZWFoLCB3aWxsIGZpeCBpdC4NCkJSDQpKb3kgWm91DQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

