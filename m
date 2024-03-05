Return-Path: <linux-kernel+bounces-91787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46318716A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C52F281517
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528F7E564;
	Tue,  5 Mar 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ei/synmt"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8A17C7F;
	Tue,  5 Mar 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623124; cv=fail; b=d+XCLuvr/m5WCRbokQr/AU7eTUgKH6aNtzbVcyQjiB3xxBWOyyeUsK0qscLp20OctxGQqfoQoMn7zaGRMZ0Mkm4XGcNRNbNowGA74J6OMD3/K0d2XFEkFLJpEGWTYUif+qnM+wMNPQDO7NNtj45cjGquemPMuLxXAqtjqkAbLTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623124; c=relaxed/simple;
	bh=FD0qCHaQk1e1Q7H+c3IhKhMJNMLoF8d7IZ6o73H8J4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e2B1QAxbYEtE7B4spEzIB/zsWYka7FI7BxUr2Iw0g1S2CHH24EGET1HH1zslRq0qeCJ0XgeJheoqxInIV27z88ZlrVDJXUvAsAKYQkQIBMz9v2YAT22HUXr1TtXEzDYRP1mfcHNxy420kQeejni+ZCwqnhdAgB65BHcbGSTPArc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ei/synmt; arc=fail smtp.client-ip=40.107.15.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgcYZkINIAK8pI/dzUnXCQfInSS+BqOr1bfnA9upmnI5LpCpqNR6/c8T2/zrZk4ztIqPRap0vzEV+OEfQupe8DRoFA+5ia3XU5RBVp20UuKPp0L0rzFp8WbM7w0fR87oM4CrKMEZCzwk03L5krDbA1TCpXQvA/KJWoexQ4wHGzE+QvSb2urdv1Iu4ntcTrbS39dA0XWpK53WZ8+KzhSG17UWwmQ7Yy3xtVdHxfQQKM7SDYM3Fl7btKOiD9CqXHs5v5UtvbqDuoJw+QMLFfSj7xsFMpQ2bkIN6D1EKWVe2Gg066t6JAKg95cs5jEd7ph8zZ6/3n5RJibDFR7KgLugfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD0qCHaQk1e1Q7H+c3IhKhMJNMLoF8d7IZ6o73H8J4g=;
 b=kZ13i2tQmE0Jmc0rTrxdfZ2D8jdTfAlk4o9q/42oea8fMh0cCY2gDosCZvbpRPffPi6pEtGl7w3tDEHmO0trZBm9mXPgjhN0LFLsuS9b5LVpfQ58IE93RCCyEW1EnxEBHwh2OPF6DmbKpN/GQKUYisvJEOYOVNGB386clDEDeCIvu4T4/Iw5xMSZ6lrCX+TsfsOSBGytrp2Z/a6fwLvRcOr5g2/qHs+8eXj6b67wocpmjNYmxDOVSC/16RK3jBWofX/mOcKs2MOWN046ZmcOnPu7tf04qmb2YWcJqSYN05pxM13p2g0BRwdvQSv+VqA9la7elSp3PqPxiXed+6GKVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD0qCHaQk1e1Q7H+c3IhKhMJNMLoF8d7IZ6o73H8J4g=;
 b=Ei/synmtJIylgLgn3u9Fr/KKzeHPWjcVZPofpTQZ8wKr1lXqKGo05RcWjSZP32xEjgvWihXFEh3VHB41q/pzh6rERvzS4Lj8FvAAleQv87HN3qhm05Oz05X1MD3qh0kHku6QeNjwE9yhGpj3qHWqVdpkBcS8Xts78gGz15FU7MA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9885.eurprd04.prod.outlook.com (2603:10a6:102:391::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 07:18:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 07:18:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Topic: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Index: AQHaahlgOv6evYTjhE2qVPUINi25/rEnr0QAgADi1dCAADM3AIAAAIZg
Date: Tue, 5 Mar 2024 07:18:38 +0000
Message-ID:
 <DU0PR04MB9417551618EB1C723EF3FA9088222@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
 <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
 <20240304143916.GA181628-robh@kernel.org>
 <DU0PR04MB941740A36E953A0E1AD690EC88222@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <58cdfa7c-5483-4193-a5de-bb5fa72de637@linaro.org>
In-Reply-To: <58cdfa7c-5483-4193-a5de-bb5fa72de637@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9885:EE_
x-ms-office365-filtering-correlation-id: 372b906e-d242-44d1-0a0f-08dc3ce47ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 B5ba2efTvYtPKme0NgZo3wk89JRwLl3Fynzf3gZMxcKMfz9WVGzelhhljrXV+QMJFqrajSL6Y+IuiS6hP+z8qTM/79WAr2/B+dTMVL5gPot7ptkztyuzpQ/8GKOv66xWQEeu634aeCCFse9UwD7eUvG8uCnDtiAO4CN7X1CSioCeibawt7UtmJLA1FQof/nS4Mz3Qhg0NsMk8F8EwCRmO65nGXwz0Ci0CCsYmoFDyTSWUeH/M+lTxTGx8Fy7+8u/d1cjzw0Mh3X9ZYqYSNaeK+hS82LtF8Ld6k1J0FGYQIeD6HEE9usXoFw0biNwM2uTSbIcp2cb/rU5q+KGiijcvqSDsqs4wRp/hQ/dQD3hihBvFDqnjQoow7QnrZ/OObKl2IdW7RXXK1IziU+9sNHr9qXkQj0SjmA1Gw5uLtgpl5vV3AK2cRf5CPishNBqLZBp2CdSW3TmJgC54ErIeOKrVZT1OvKM/AQJtfYbNUqeaoDctWpGz6h/wEFC+VcuVOH2gTBTkAlKxXHYRDE8+g81HsFdG1iCGYOtLyNGn55NPse1gNisI060Lreh72g9vR01i8me64YdkieRDljp81SIYmLjF7vmSuLH/rsIm1omZU0lUaia562GSG1OCQYzN/Dp26RWeO2qqIPQhe2GFyjy022969XBbeYEoEojSlSIvvc+jFrNc/YP2lVca7u8IvLthK3d4aL/BYAYxEXUdOgYPIRXg1FSKwJmjkDYx8DI/WY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkNTR09UdEljeTlUcTBXaUU1UEZmUDRsaitPNzZMV1FycllFN3pCYmhPL3ZW?=
 =?utf-8?B?d3JXR1RmUHkzRkVxN1NYSDNrNnVoQnVzVWQrSHdMZUszTjgzbXFCVXpVREJM?=
 =?utf-8?B?b3B4OFJ5R0VXOU1RRzNOZ2N4TExzcVNuWkMvejM3Z1pxL09lanI3VWFxcEFa?=
 =?utf-8?B?Ni8zSW03ci91TmZBeEZyRDlNUitNY2c2UndPazFJUU5xUE5zYjBEWW9zU0pB?=
 =?utf-8?B?OGhRaUd3bko3YkR3andtb1FXTUxiUElNVUNXeU5ybnFYNC9vdnVjQlRGREEw?=
 =?utf-8?B?aEsyYjFqanZzMDYxaEtZcTVTdTZFbGhCbkhFVHAxNCsxZFQ3eGRtYlFBMGZF?=
 =?utf-8?B?MWFiSlJpRmhWWWJZWiswWmFIMVYzY0dsaUFUMWFUMzNnMDJCMWFlbVZkNmhj?=
 =?utf-8?B?OXJhY3NsZGFsempUNmwvckdZZ0lLUVNwV2NGcEs2VlhuMFRiRmZPOUdNSHl2?=
 =?utf-8?B?dzFxMU0yajlENVJjem1MSDVLRUFzVGV6MlczaTVTWW9xK01WVEROeFFwYk5r?=
 =?utf-8?B?UmduTnhKc0o4blFFM3hZWGJEQ0pvMldnbnZXNE1sME14NkpRMkVzRkpIT2RL?=
 =?utf-8?B?SVJnL2VXTUpsUXZvSUxLV2VjWE9rdWFNNmRiR3NSc0lpbFZUalNCUjBqYThl?=
 =?utf-8?B?aWU2Q1BkbE9yam1ISzFRMysrdGZQZXI5YUUrc1VGUituRTlaejlaWU5peFN0?=
 =?utf-8?B?czAzVXlxZXRuT2tNWG1tLzBhV0V2UmpSNVhQVVR1VC90bVFEOGpyK040VlNx?=
 =?utf-8?B?RXdkMGw4Vm9Wa09BVkl4amkramF2NmYwa0M0ZkQycEE3clhpWHdrcStBcjJX?=
 =?utf-8?B?d1dPckJCWnlJZ3ByMTAwd1kwZDNMQm9OemZzL2J0dElOcGFvOXY0UHYxbndV?=
 =?utf-8?B?V1lGTVNDSnU4SmttaUd5djBhL0JZVEdDNFNFNGVCR0hrclltWGRCY0hzQy9L?=
 =?utf-8?B?czRCLytuZ25aMHE3bXpodjZ2eDlhZnpHOFBQWXpZQU90QitYSEhUTkphTWlr?=
 =?utf-8?B?TFlWUDRqZmJHUDBJREhBWVN3NVNGVGRSbzhhZFl5ZXBRVi9sZ0tZckxjVkVs?=
 =?utf-8?B?Ulc2MFJFMXZ0elhaQWl6MDZRZHRPMGovZXJYZUk1ZGxsQmtYY3lNTmdZWkg3?=
 =?utf-8?B?RlZkRlpZWktpb1VUN2xmdG93VThSTlhVSlc0MkplYVBBZ1krZUYwWmhaTHpp?=
 =?utf-8?B?aEF5WmZETDV6SDh1M3FQRHVBRHRkYzMxQjdOYmx4Z002WmtWbTdtcDNCMXR4?=
 =?utf-8?B?TmoxTVlhYnlKU0cxc1ljRjcvdm1zdG4wKzk3R2YyeVRXQlREdXkxdUpWdito?=
 =?utf-8?B?RkkrNitVdnlaMmdVcm5QNklsWDlTNXU1MklMK1pBUnJhOThBREpDa29oNmFE?=
 =?utf-8?B?eGhWd1BYMVlWd3BoWkpiODRCbjB4QndIZTY4QjlHNy9jOVdPU1JYWHlzSmkz?=
 =?utf-8?B?ei9oVy9Vb2JwZ1Vuclk4ZERCWE1nOWtsWmRDZ09ncU1iUnIzM1A3RHRkeWhY?=
 =?utf-8?B?NXVsUFA2VUxRZnhKdFpVbDM5bVRwRG5TS2NXTFR1ZEpvS3ZJOWxMYjhjZUdn?=
 =?utf-8?B?Q00yeWxSQUkrbDNEdy9xNGRkNVUzWjNObWFUeG80RmN6cGxSem4rc0QxWmhi?=
 =?utf-8?B?MWROYW5VbHRNa3N2ejU0Tm9ONDZjdktYUXR6Z3YxQTcrc0tWbDBIcjZQV0Za?=
 =?utf-8?B?VTM2NU9PSFlwTStlSGlQc2ZGTmVVZ0Z6RzltQ3FGdVFISDBwY2g5UmxrSjJE?=
 =?utf-8?B?czBWNm9ZM0JBRG1BdkdqU3Z6OGg5TmtkRElQQTVGclJUVDRLWHgwcXo4dEJK?=
 =?utf-8?B?UnEvN3hkODlabzlTRDF4N215LzM3NGpwTkZHWWw1NURlNWRDUWtmTlhLb2k5?=
 =?utf-8?B?U3QvcDVpbzMrNzRnTlgvQ1dWWFlCU2YycnRGeE8yMmJNY1Z1Qk9FZDJ1Wk12?=
 =?utf-8?B?bWpsQzhhS2E5a0VxZ0w1S2dHcmQwM3lEbXhpd1BGUUxqbDQyZTdjbFF3MitV?=
 =?utf-8?B?YVl6YnpBeFFKdTc1SHVJbDhYZXVMVUU1SzRVZHNJZmQ2Vll5MVk5MkNDNmRs?=
 =?utf-8?B?b2Q1dU9pWHBHakJyRzJ4S0Yvd1I0dW51NHZveldKKzBTZEhyS2NYMlZTYlRX?=
 =?utf-8?Q?322o=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372b906e-d242-44d1-0a0f-08dc3ce47ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 07:18:38.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ki1s0Do2C7C+4wbUJhELNpN/IBcNgTKseL0H3+hY7Tmlmh94vLEUGyu7SdeJSZ43eqR/VIdbPYI/cRmmtF903w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9885

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZGdzOiBjbG9jazogc3VwcG9y
dCBOWFAgaS5NWDk1IEJMSyBDVEwNCj4gbW9kdWxlDQo+IA0KPiBPbiAwNS8wMy8yMDI0IDA1OjEz
LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4+ICsNCj4gPj4+ICtleGFtcGxlczoNCj4gPj4+ICsgICMg
Q2xvY2sgQ29udHJvbCBNb2R1bGUgbm9kZToNCj4gPj4+ICsgIC0gfA0KPiA+Pj4gKyAgICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbnhwLGlteDk1LWNsb2NrLmg+DQo+ID4+PiArDQo+ID4+
PiArICAgIHN5c2NvbkA0YzQxMDAwMCB7DQo+ID4+DQo+ID4+IGNsb2NrLWNvbnRyb2xsZXJALi4u
DQo+ID4NCj4gPiBCdXQgdGhpcyBpcyBhIHN5c2NvbiwgdXNpbmcgY2xvY2stY29udHJvbGxlciB3
aWxsIHRyaWdnZXIgZHQgY2hlY2sNCj4gPiB3YXJuaW5nLg0KPiANCj4gV2hpY2ggd2FybmluZz8N
Cg0KSSBqdXN0IHJlY2FsbGVkIHRoYXQgbm9kZSB3aXRoIHN5c2NvbiBpbiBjb21wYXRpYmxlIHN0
cmluZyBuZWVkcw0KaGFzIHN5c2NvbiBhcyBub2RlLCBJIG1heWJlIHdyb25nLg0KDQo+IA0KPiA+
Pg0KPiA+PiBBcyB0aGF0IGlzIHRoZSBtYWluIGZlYXR1cmUvZnVuY3Rpb24uDQo+ID4+DQo+ID4+
PiArICAgICAgY29tcGF0aWJsZSA9ICJueHAsaW14OTUtdnB1bWl4LWNzciIsICJzeXNjb24iOw0K
PiA+Pj4gKyAgICAgIHJlZyA9IDwweDRjNDEwMDAwIDB4MTAwMDA+Ow0KPiA+Pj4gKyAgICAgICNj
bG9jay1jZWxscyA9IDwxPjsNCj4gPj4NCj4gPj4gUGxlYXNlIG1ha2UgdGhlIGV4YW1wbGUgYXMg
ZnVsbCBhcyBwb3NzaWJsZS4gRm9yIGV4YW1wbGUsIGFkZA0KPiA+PiBtdXgtY29udHJvbGxlciBu
b2RlLiBEbyBzb21lIG9mIHRoZSBibG9ja3Mgbm90IGhhdmUgbXV4IGN0cmw/DQo+ID4NCj4gPiBZ
ZXMuIFRoZSBibGsgY3RybCBpcyBub3QganVzdCBmb3IgY2xvY2ssIHNvbWUgcmVnaXN0ZXJzIGhh
cyBtdXggY3RybCwNCj4gPiBzdWNoIGFzIFBpeGVsX2xpbmtfc2VsLg0KPiANCj4gVGhlbiBtdXgt
Y29udHJvbGxlciBzaG91bGQgbm90IGJlIGFsbG93ZWQgZm9yIHRoZW0uDQoNCllvdSBtZWFuIEkg
c2hvdWxkIG5vdCBhZGQgbXV4LWNvbnRyb2xsZXIgdW5kZXIgdGhlIGJsayBjdHJsIG5vZGU/DQoN
CldlIGhhdmUgc3VjaCBhIG5vZGUgaW4gZG93bnN0cmVhbSB0cmVlLCBpZiBtdXgtY29udHJvbGxl
ciBpcw0Kbm90IGFsbG93ZWQsIHdvdWxkIHlvdSBwbGVhc2Ugc3VnZ2VzdCBvdGhlciBhcHByb2Fj
aGVzPw0KICAgICAgICAgICAgICAgIGRpc3BsYXlfbWFzdGVyX2Nzcjogc3lzY29uQDRhZDEwMDAw
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAg
ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OTUtZGlzcGxheS1tYXN0ZXIt
Y3NyIiwgInN5c2NvbiI7ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAg
ICAgICAgcmVnID0gPDB4MCAweDRhZDEwMDAwIDB4MCAweDEwMDAwPjsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgI2Nsb2Nr
LWNlbGxzID0gPDE+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgY2xvY2tzID0gPCZzY21pX2Ns
ayBJTVg5NV9DTEtfQ0FNQVBCPjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KICAgICAgICAgICAgICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmc2NtaV9kZXZwZCBJ
TVg5NV9QRF9DQU1FUkE+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAg
ICAgbXV4OiBtdXgtY29udHJvbGxlciB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gIm1taW8tbXV4IjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjbXV4LWNvbnRyb2wt
Y2VsbHMgPSA8MT47ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXgtcmVnLW1hc2tzID0gPDB4NCAweDAw
MDAwMDAxPjsgLyogUGl4ZWxfbGlua19zZWwgKi8gICAgICAgICAgICAgIA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpZGxlLXN0YXRlcyA9IDwwPjsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAg
fTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgIH07DQoNClRoYW5rcywNClBlbmcu
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

