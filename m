Return-Path: <linux-kernel+bounces-108819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2DC88106E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B38FB23B92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9AD3BBC0;
	Wed, 20 Mar 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kPEA+A2Y"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0113B293;
	Wed, 20 Mar 2024 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932869; cv=fail; b=ghFwunYS3DKTlGd5uU69oWp6KFU7Sh+HN0DtZ9dgsq3EYvdLNZG3c64/YwAaI+sQTKKPgq6A0yiGnKIQQJVqQUlHSGcEmGLfcXICw6HUedsQJ7iE+/WKDEmNdmmhatNwBwXzxxLae99InCKzkBIZwqFJVlC5mi6KxTjWHDpSWos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932869; c=relaxed/simple;
	bh=6QOCgGOrhM8DQ8mF4ZiGwcxR+h522V1sk4xnJx93urM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l4ZF9BJAd39FQsYkVOvAEShO/AFTKlfpoLVGPaMRAYK0WgS2QApTuvK1i7nq8kxzTu3uTXEWGi/reC+nqv/L6l8+HIVEVXJr2rXXfvUtIZctRP2OeHbmQlDf/LcztZ96XebGB9PVRHvj+PvWeM8LLH8hvRagEXTw7zxRh15xW2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kPEA+A2Y; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1WgXfnve26AE7PZxjWREo10TiKrnF7zFlkiA53qk8HXrAJUgiocYDpzuNurEgvqAYQoFsV4t7XslP/7STXW1vAEaXgeG5wDOFgMZmBUWHSz4/3cFki5h9yJegtk0bRZJ0MTWeGnkhj2fIK2gZNJ6H3aQ2Lgy6MWPxfjNEKAinptjr55L61BjwjJ87F87zOaK/9neQc4B234wXyhMkCLw5si3us9HfpL0l02t8LRMT4msFRmNdXbzarkX5fJANhEZ87A23Z0cljpMf8PqbqD4MXSFmPHvdwj6na9aHh7a9MawppEIcPo20igfaGpyNyrcdqO9nZbKtgTf6ftaNIqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QOCgGOrhM8DQ8mF4ZiGwcxR+h522V1sk4xnJx93urM=;
 b=JMTAYEtiW9/n/qcql4ap/auBHKdh+XkeOK4OoLqTMYgPLQepCCwOxphUCNPsANd/jfMvb/lO+VRNORfA9zN60VDbJ1xDWz5CliOmkKvnlMi226kUzGh56486wCRdB2f6Ezg0KQTFP5KDdmZMy5ZPf9hVQoldC2CvodFIyoe9octkDYOl/ExvAl3KnB8bOqIfeIZS5/vmI+YrFaTEJMN9unPfLP+XZCoPFvWfHm6dnT9x0EEOz5EtfFjMAohcg8TyH/5uxcjFYOcgrtkpu8pb1Ch/HtezSQZaoR/hssImkbly2j886BEAg/vPMCGQISEryWM+iyT6Kwt3T62+F53aow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QOCgGOrhM8DQ8mF4ZiGwcxR+h522V1sk4xnJx93urM=;
 b=kPEA+A2YhTIPc8l/cYaNgU+1k8Skq/fa2wzqzW9+N9c2FGDy+puTHQJoVRSefcaZmVHywIayAsY+ihACknKbXGoAejZBfm1GfmN0tFC2ACYJMRCY6wl4oquPmegAaO2iK0O2Fm6acVzH96cMP/l6qXy+qb8YEXuEiENooHURlow=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 20 Mar
 2024 11:07:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 20 Mar 2024
 11:07:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "brgl@bgdev.pl"
	<brgl@bgdev.pl>, "andy@kernel.org" <andy@kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Thread-Topic: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Thread-Index: AQHaepfOXR4y1taHxkika8xHrgrdvLFAbwWAgAAIxJA=
Date: Wed, 20 Mar 2024 11:07:40 +0000
Message-ID:
 <DU0PR04MB9417FEFA3DB02082D02A963F88332@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
 <CAHp75Vf1K8c+7O5Cga3t+WiiSkk-yk_gATGJrMZ8rnPPtWLkWQ@mail.gmail.com>
In-Reply-To:
 <CAHp75Vf1K8c+7O5Cga3t+WiiSkk-yk_gATGJrMZ8rnPPtWLkWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB10036:EE_
x-ms-office365-filtering-correlation-id: 084f13f7-400f-434b-3cc3-08dc48cdf59d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3JzHxDhWhtbG9up/78JOe6srvQ6I3aH/UpZUoghi6y1COfDVgumcj9c4y0iYBSX4KJebEFweeG7ryuLJbjsFmhCImY8R6QJbbYoTCAigT20YzFy/nerytwhAwFPXtwfpZ4kSU+2ff63kefq7DRCfBuU1XQr9OkorD2iDK84ZyVl6+lHC709Fy9B5z3eKlRoC/p/qxPuwNl7QVCGszfHw5TCt6L3MIgr0WRW/1jynvMSDPMkGg4kNEGEz1I6anzJwOO6v03pOOKzSPmOrJ4YAKElG66I464JKGDbC7OztqZTrSsUnI7fAkc9Z0WqpDf/p11+YZ9ou7znu4Q2XHG9sLteQTbzqcMNNdLE1YGTdqcubAQHrsUrkK0h8QD6cifT3GdCONcOoTzDDCAMy6WM6FEehxGjXDtn5P+pfgh+t/Z3tUTASicEXBuPHuw/TyDEMJajgP2KF13QhPqndbvJZ0xYmYUHxzj9M2X7URZnIh8MiOR8Bb67b2t6WtXplskUJPli0RcNoZcUjqQbZZDDaR04Vs1PbL9+GN4vMxft118KiQYNaiHjDJFYsexEmoVjsBtAag0wUUmD2rY2fi/on+iMF/HWaBWYraqOK91FNXiQW96dR9kOcZ7altkEerlMfop08CRzyyVs8CaXvyJ1L9CfxkZSF75TDFSKX9i4evLNfzdwki/Zc3kamsN3ElzJmse5ewm6YAMAtQT5XW+YfWmrkR2LdK3IQQY8s7FvcKys=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejl3TWsyNkpkeHdyWDhoNHQyT3FVUzRvSzd1c1NRMEtNSkZjVis5WDFzYnZK?=
 =?utf-8?B?TDNyR3UwaWpqd21zR1dQTlRXMStuckx2TGxoNXJBQy9ITitnNzEzRGo0OXdO?=
 =?utf-8?B?VEtVUWhMdXYybFBqM242NGRQOUZQSWFFai95WEc3emg1NTd2aVhNTmRNTWdx?=
 =?utf-8?B?ZTM2emNUaEZXcmd4VzB3bXBzN0FJNjRTYjlSTFZybU5LSmlNTEdGU0hyaUtU?=
 =?utf-8?B?U2ZBWUpvWkNnTkxQeGZJT0VWUVM2WG1FWlV2OXh5ZHlXazdQNVI3c0lHUmVJ?=
 =?utf-8?B?MmFPUDBWSmIxSU9KUU8vRTM0aytKeEY2V0VVdGNtOW1panJmMDdsSTZqNHhP?=
 =?utf-8?B?V0crcWVUWFJsS0pwNzlJYUloWnRNUkR1bzg4N0pibCtnMlZOWWRUMXhROG1i?=
 =?utf-8?B?dE1LMDc0WjViWklBdllOZ1JZZFN1c08yd3VDVnpTVWJicFpURUdxZ1VhcWRN?=
 =?utf-8?B?Z3cwdVYwbmkyUDkvM1JoSW4vNEtic2Eycnp4cTVBS3pyNXdrN09tUWtvRnpt?=
 =?utf-8?B?aWJhdW1HL3VTN0hteTVYZjg0b0RuVDFpcjB3ZWxMV1hGRG5DWjJ5akQyaWFi?=
 =?utf-8?B?RXAvQ3hadjIyTDNOUGNpT0ZKWFNNOHVPT2JLNXNPb00wSlJzV3V1dUliRndL?=
 =?utf-8?B?N0NFejF6ZDRhVVFoUXF4SlpNcStqVzJmdC9DdzlZU1M5enZ1dWxCTy9ueEJt?=
 =?utf-8?B?QVduTVVlUmdNVG02elVIVzFvbGNhV3pxTW01em4vK2RWQ0ZsQndLMTBCb2l3?=
 =?utf-8?B?UE5OR0ZZWWE1ZWdRRVEvK3FjbTNXU3VROEtFRWdodG82VVMxSGNMVC9PN2lh?=
 =?utf-8?B?bnpnYUVsQWZDWWEwUDFQZGFuYThROE1FN0FET3pvWGxTSG1heENNekZvaEo4?=
 =?utf-8?B?RXRjaDVTWEgwdWxBUGtjLy9sZU1OMTFMaTRaeUdwVG5NSDdCeHJZMFc5R3BO?=
 =?utf-8?B?SndtM0ZPeXd3L3QvODVPRmJ1TWZVc2RMZG5MYm1ld3VGR2xOOU0xc05tSlh5?=
 =?utf-8?B?WU1SYWhudW1BUEpQaC9URiszY2duQi9HYVZSbFpVYjF4T25TMENGRmtaaWtB?=
 =?utf-8?B?U0w2SXhPTHVsNGFJSnlUbmsyTmlSVkdiWjZFYU5GdWJESlZpK0liZEw3Rk5W?=
 =?utf-8?B?SDlac3JEMHQ2T3ZaOUFlMzB6YTFXUGhocS81c09FM3BMS3RmZnBZZUVPZVp1?=
 =?utf-8?B?WUNDa0x3MldwaUhKNTljSEhjV29vdFhjMEhLQkhKcTM4OUFFUG5vNUU1MlVq?=
 =?utf-8?B?eXhMZm4rdUR6bmJTOXlFZVRrb0Q1M2lYNUdQVTQ5K2h4emJrSEw0Y3UvdWNW?=
 =?utf-8?B?bnlIZHY2N0YyRXlNZnJJNWhRb29nSlE5MlFUVU9EZGdFaE1takVyc0RmdldZ?=
 =?utf-8?B?djlVSW91K3Z5U01KRGdqcVpwMXFzOUVsL1Q3VkQ4MHpoQlpVM0Z2RWkydmZj?=
 =?utf-8?B?dkVUVGtnSHdrdjcvSis3MERuUFRxSU1ZcGtPYzJIZWZGOTZxWEdBeFcrbEVK?=
 =?utf-8?B?OFlLZXBZcGFYOWplOEE2bDFZNURGR0lxdHE5aHRoN0FOMGo5OGo5TG81S3pP?=
 =?utf-8?B?M2l1YzVTSzBscTNXdzRrYy9aWkVjalhZdENqWCtIbG02M2h6aXUrakZBd1dz?=
 =?utf-8?B?MW45V1g3cmRxYVV2Q3NlS2xYVis3bFNmbXI5elJ6ZENXUC9XdHRlb2E4dm9B?=
 =?utf-8?B?WVZKVEFtbzVSOURBbEtONmRCVXEyL3plQ0Q5WTVRU2RERGdQczgrNEU2VWgw?=
 =?utf-8?B?bHZiRno5RXFMK1N0ekcxbmVEaVNteHZXWjNvYXVONXhtbDJ4QncyV1hYdElL?=
 =?utf-8?B?WnovbkY5UnloQ0VjYU5zTXZibmIzVE5QT055TTV3YmhxRVArTGtQcHlmaFVz?=
 =?utf-8?B?U3p0Q0FOK2hGMHpPTytlYW4rTzlQeXdxa29pS2dpUllUM0hjN05uOTBCb24v?=
 =?utf-8?B?NEFkU0hxdURDUDFvczcrWkJHSHlTdk1yWWloZXNQMXg2Q2ZIQnExMXVCd2gy?=
 =?utf-8?B?VG5iSmIxQWttbWM5Y0dieE5lK2NEYjRjWEpPZm9lRUwySHZxNTJJMDFNNHlS?=
 =?utf-8?B?NnJ2dHJYTkEzdTFjdUJDbmdFcnFDQy85M1F2WFVzRWZvcmRCVldnQTB5V3lK?=
 =?utf-8?Q?ZOu8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 084f13f7-400f-434b-3cc3-08dc48cdf59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 11:07:40.5635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abzLPBVyHno6WNRE5NCv8/PTG8ne5kAACN9ly4PxLWBAdoDLzwdPQ6In7iSJ1uYkQL5qVISM4DszBkILtDPu4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBncGlvbGliOiB1c2UgZGV2X2VycigpIHdoZW4gZ3Bp
b2RfY29uZmlndXJlX2ZsYWdzDQo+IGZhaWxlZA0KPiANCj4gT24gV2VkLCBNYXIgMjAsIDIwMjQg
YXQgOToyNeKAr0FNIFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+
IFdoZW4gZ3Bpby1yYW5nZXMgcHJvcGVydHkgd2FzIG1pc3NlZCB0byBiZSBhZGRlZCBpbiB0aGUg
Z3BpbyBub2RlLA0KPiA+IHVzaW5nIGRldl9lcnIoKSB0byBzaG93IGFuIGVycm9yIG1lc3NhZ2Ug
d2lsbCBoZWxwaW5nIHRvIGxvY2F0ZSBpc3N1ZXMNCj4gPiBlYXNpZXIuDQo+IA0KPiBJJ20gbm90
IGNvbnZpbmNlZCwgc28gbm90IG15IGNhbGwgdG8gYXBwcm92ZSAvIHJlamVjdCwgYnV0IHNlZSBh
IHJlbWFyayBiZWxvdy4NCg0KWW91IG1lYW4gZGV2X2VyciBub3QgaGVscCBvciBlbHNlPw0KDQo+
IA0KPiAuLi4NCj4gDQo+ID4gICAgICAgICByZXQgPSBncGlvZF9jb25maWd1cmVfZmxhZ3MoZGVz
YywgY29uX2lkLCBsb29rdXBmbGFncywgZmxhZ3MpOw0KPiA+ICAgICAgICAgaWYgKHJldCA8IDAp
IHsNCj4gPiAtICAgICAgICAgICAgICAgZGV2X2RiZyhjb25zdW1lciwgInNldHVwIG9mIEdQSU8g
JXMgZmFpbGVkXG4iLCBjb25faWQpOw0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGNvbnN1
bWVyLCAic2V0dXAgb2YgR1BJTyAlcyBmYWlsZWQ6ICVkXG4iLA0KPiA+ICsgY29uX2lkLCByZXQp
Ow0KPiA+ICAgICAgICAgICAgICAgICBncGlvZF9wdXQoZGVzYyk7DQo+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiBFUlJfUFRSKHJldCk7DQo+IA0KPiBXaGlsZSBhdCBpdCwgY2FuIHlvdSBtb3Zl
IGl0IHRvIGJlIGFmdGVyIHRoZSBncGlvZF9wdXQoKT8NCg0KRG9lcyBpdCBtYXR0ZXI/DQoNClRo
YW5rcywNClBlbmcuDQoNCj4gDQo+ID4gICAgICAgICB9DQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3Qg
UmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=

