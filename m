Return-Path: <linux-kernel+bounces-129505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF3896BB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C891F238DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B412137C2E;
	Wed,  3 Apr 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="quyzoBZQ"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2091.outbound.protection.outlook.com [40.107.14.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACCA135405;
	Wed,  3 Apr 2024 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138971; cv=fail; b=OzZBgrGIb23ok7HPwVRsxXE1v7jxNWGl21cszU97oZHUN2NrrFeoRoVxtdR8f6UWdFXmWXtYekB8I3+1VCnmQJxLQXLixzr6icTP43gd4cOrthxBoIO0p0idoHkAIUWsbOjuIWbauL89pAL6wLYAuO1V5dfkfHZhk8AYU7PAVTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138971; c=relaxed/simple;
	bh=XDekh2kG41xuxjNpmoTZ3CUVYsXryQ7Et3UVh/ZMbjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=keucVHp2RC+7xFB6ssdaHAYX/cp2dmhj/5wf5HmmD7CP9bJ5SUQVdIRlaw2D/QRFgz7rshLTTBOxTNjrtobmj/6b9/g74AomZjgEHRllw+yAOZjbeYgyz32S16V+XwcnmUqUsXU3re8xKeALXI5qts58unm3xcK3zGWLbeiJrXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=quyzoBZQ; arc=fail smtp.client-ip=40.107.14.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PssuxUlUkp/UC1Siz78GcPwzBRVZARZ596ypxGPbxwPhYQtaH5XrFugwVnTTeBZFFbParC/HzidBEd25nArq2Cx1aXIpwz3zCduwvuPlf6xUyP3+3/8VwsfC9u7GJzA9mIoZsPCPX6UVbigclUEsj5vewYRUwWVBEnKQENjHuyF6CsLU51gBMksGicgAu2erABaRR4xuFZ4LlLO1VBgmz8rWuhHwhcxlBFhpHknzx+3RFNAfBGP0PqmLlWwsrGiTW8/hbhiVcCcPynSn43B4RtMxw6grhQyMksnPCefprd3eDPFd5kdkOd4wf/TrVLx9vRVtJWGBHb/dms5ed0Z/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDekh2kG41xuxjNpmoTZ3CUVYsXryQ7Et3UVh/ZMbjs=;
 b=dfOpJA/xwoGuCdXHLU8Yj0PuTxtJhbmcz9B8VNuuxqf/uTmjuJh4fjC+uaBrNuMIjUVCagmjgTic1HM0Rtbo6TB/z02EyqpYoE13f0WuvkZLxhZTpqe3CmwUkjoQBbWgwhWErFuQru04RWKUo9dKxe0OHSmdsTj3R9sQUWH1Yv+HqBCKL4bRL7tj6n0CwXgfYumhXt+nz/wtbQsA6N4oA1kIE3Jo76OXGH8SSavVj3u7SHr1poiEgNrgkBPJvu71XLHg5E8TGI0/j2bxqWzks1DMxWkUhxynG+wMke7T7Fu6JJyarknBAgzJupEJHbPgIZV44QguVatrreFWHQP3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDekh2kG41xuxjNpmoTZ3CUVYsXryQ7Et3UVh/ZMbjs=;
 b=quyzoBZQbwvGvZ9VFXYSW2CcG403WTfAu+Z6UlPOtTW8FXtw4raXJOX+dYZORXjQJUtEykI1NSHrYONnbL15gbAfXuF9yx0Ao+32OVhB4faH6mUW+5pgF7Sd7gWSodnRcKN7HY2PqyDC78InVp9Gx+PS1QAYswwVhKOkUwFR3Nk=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6916.eurprd04.prod.outlook.com (2603:10a6:208:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.42; Wed, 3 Apr
 2024 10:09:20 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c%2]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 10:09:19 +0000
From: Carlos Song <carlos.song@nxp.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"broonie@kernel.org" <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Bough Chen <haibo.chen@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: remove redundant spi_controller_put
 call
Thread-Topic: [PATCH] spi: spi-fsl-lpspi: remove redundant spi_controller_put
 call
Thread-Index: AQHaha7+PCGsWYvSNUOsYTcJaUJVzQ==
Date: Wed, 3 Apr 2024 10:09:19 +0000
Message-ID:
 <VI1PR04MB500523F5C08F0D7A86EF07E8E83D2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240403084029.2000544-1-carlos.song@nxp.com>
 <3edc4bb76ce0bc96f90cee789e1d0cfd979d356a.camel@siemens.com>
In-Reply-To: <3edc4bb76ce0bc96f90cee789e1d0cfd979d356a.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|AM0PR04MB6916:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UIgxYK/39SwZUnbzUeIp0fyXM9xPCW3wdUUI49pNzvXvJ3abO6VCJqwZ1tWPjE0xcV7ucG+nocHw3GBA8XM3Q1mVm9IvPdvSQgmc2VRx0+aq3h0RTKDDimHx7rJ7CORTWZsYG/xR1Hnf/QQ6oAfPfsLTAQg0Dr3g7z203TeEdVYNVxOLyOxVf4z65KaY111bNyIfS1HM5vVJHc2g6yxwCnVLvSDn3ISAVZcYlSxHndmAHKuxkaX7VZpgWYCril8LPSZ0l2OAEpKgkulde/WbRhZcYz0GtyOVXnpm9ciV4dOlDesrWnL6hsKpifgCNX8ZJ6BpO1ag/JlXjtn0bExTPakP0s4JutUom2YBrSkbs9DBzz1WIyVNq4TmHBRy4jVtHPfoAIqrUWqiN2M2byCELN/IM5VuTPXHQfvr0LPIHPDrqqzHyOJgxCzJDs5PVjSbGyJ9VaBiqW5j1QUWanSdEBTHRF22W5ZUuXAQ1bXuvfR6iWyGtYy29qtOK8HVWj1vFeQclEGNPLVXQTPNn7w04U/M4ZedfKJk88mISyLUqIFoMfadrBdeCA/0KtUGqTXD+ZP0PASz0R/XQHef7Equam2Ny34H6f3rfTU5wDOpCnw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXk3eHAxa1hNSy92b0pVTkc2ekpEVnNsZWVRKzh3NmQyN0VzWDdkYlBjTWRw?=
 =?utf-8?B?aHpHSHA1cUNNR2gwbHc4N3NVOHN2L2ZRUWhlSnVwZjFMVHB6MDFsMklLSXBK?=
 =?utf-8?B?TVF5eUh0eGF4RFUxUm00dEFUZnRaa3h0dXhEZjZPRzlPb0ZLVk1RaGZWSElo?=
 =?utf-8?B?MVpoZHRsRnVaYnJJdyt5Y2NBcGdOS2FjczkyRXU1Q2U0UzR1MGdGcEpGTnpz?=
 =?utf-8?B?QklKc3IrNGIrcGgwSlN4MUVEams2bFlyQi83S252cDNUeXJlVXR6N0ZkZmIr?=
 =?utf-8?B?SndHRWVuMDBjdWF5cm9ycmt6dm10Z3NzNXh6V2xvNDFyUWhtcFhuZHVGUzQ4?=
 =?utf-8?B?OXFORkk0b1U2SHR5QzQxZlRwUGprUEJtUjhJbVhxdUNaelEzenFFZjQ3WjJi?=
 =?utf-8?B?dGNVdmpuWW5LOS93ZG1hWVByRDJRMjVpSGIrMzI5eWxZcE83aUxlR3VDeDdi?=
 =?utf-8?B?b0xzeFNJVGNyd2VWakVaRjJxRWNlVHpOUjRRa1lKTis1ak9xbzZrZUNzWHFI?=
 =?utf-8?B?d2Q3Yy9HQ1gxcHhRS2R0TFhzcTQ3cnk5ZjRPdS9XZmd6ZFdvaWsxdkdSTWUv?=
 =?utf-8?B?cms4UTI2WkdqTmxLSlJRUjRNSWc4M0lGRG54bk94Nmt2T0ZsdEFQcXpITVk2?=
 =?utf-8?B?d0VwZ01jMWN3SXk1bEZrUUtiVHQ0elo0VmpFaUJuZERYZXRCNzFsdDhQYzJ0?=
 =?utf-8?B?eHF3UFUzRXlPdGk1VFhHYWVWRXNMWWdkRTArWFdxMzBsR0VLY1laaVNYcEdW?=
 =?utf-8?B?UDNjTm1NTXBCWDVVbWpCYTNndmZyQStIT3IyT28rWlhwdUR4bVByTUM1dVd4?=
 =?utf-8?B?a3lBM3NTem1CNWMxVmkwU05HcldBZmtWM2tTekM0cXZBZEhPODV0MitpOFFp?=
 =?utf-8?B?U2ZrYnNwbi90RTJ4ZUJRUVdCeUZ4ZUJZNUh0eVlNbkJ5WFRTYlhPSVVmV1Iv?=
 =?utf-8?B?dkxiVkc4SG1BOGU2ZTBuTFBBSlYwVDFhaml3dXZ0OE14bEI4Y0RlNVhQVEdZ?=
 =?utf-8?B?L0FpWGl6TXhQdm83NlJta20yMiswc1pvNGZ2bXVBS0oxQmxvTEJ0YnF1bGsv?=
 =?utf-8?B?WjhncXZLa01pd096Qi9rRnowSGpQbWJ0ME1ZeHdBRTgwM2dZVXZLWC9QWUlr?=
 =?utf-8?B?eUtnMjA0d3FTeUhZNVdrSkVSWEtwdUdUQVZTSTg5eFNuQmFxTWRGVVJlMTVZ?=
 =?utf-8?B?VitKNkNXa2hpOTZ3NmJDejBTU3hibS9nMWJYcC9mQkxqZmZTRXBoVFhJOWZv?=
 =?utf-8?B?OC9kQW05aXZtRjZmQ05aRGdGT2luODJJU1lNTTMzQWM1anQyQlBpTWFkNG9P?=
 =?utf-8?B?ZEpuWTY3VTVWNDFnZjVIVjRRRENlSW9GdlRhbVlyaEhRbXlXZU1sZnBRaERG?=
 =?utf-8?B?R0xhZFlRTWZZTXg3Vk9YMm9ISjlENElDbitya202MlJxcVM1dkQ2U0MrNnor?=
 =?utf-8?B?VldHbXZ2MXc5NjBOVTJ0NnNMK0FIcmVuYXF6WlVyRUx6STZtZmN3N3MxdFhX?=
 =?utf-8?B?dzVIZEZHNUxDV09aeEVIT1Vpc3VLNm5mZ2xZbWJsbW84a2VHeGMyelFLU2NF?=
 =?utf-8?B?bXNOaTVDWDltUWJpUC9INEdOOW85dXlVUVJVV3U2cHRZc3ZCK0FJVkt0a2hS?=
 =?utf-8?B?WnhMQ2F2bXRNckdHTkNidTdRSW92NG1jV3VUSmZ5dExyL1lUU1IxN21WcDRt?=
 =?utf-8?B?VmdlYndQL1dVZUZRdGpDRHZnTWxGVHp3aFQxYTFWMWpVSmVZbWNHbEdtY002?=
 =?utf-8?B?TUpkb3Z1TTJDMkZOanpsd0VBMG9BOUlzeVN4V3FtM2ZrZmw3UitLalQ5UXJ2?=
 =?utf-8?B?VmVPZEozaGdXWm1WanF6NXFaUVBMSlllS3dJMlVMQWRHdTBmbmZ5SkxRTnNI?=
 =?utf-8?B?YkthdlAxa0M2Tmdwb0N6czhXcVpkaFJyaGUrNmx1Q3ZDbE42M1VmdlZvNHUw?=
 =?utf-8?B?enFoUC9pZ05DNlp1K2U0MEloVVNMNkJLSlN6YlVLWDhpS2lWZk92cURLbnMr?=
 =?utf-8?B?TlZ2WVQya0FPRm1zbXVMb0s5Wm9QbEdONDBDbmN2Z0M4SFBFZ2lHVzlLU1ZX?=
 =?utf-8?B?UmUyUVNrcDBxSG5CV0dtR0xZNU5OZXZLOS9XUkcxckdrd3B0c3RCTzdNTDJF?=
 =?utf-8?Q?SF4s=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f78ee67-3f32-494f-03ec-08dc53c62095
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 10:09:19.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzGhiYxerMw0b/AcHfY3EBmJYAKH4KeJm95+DbbemQwnx9yX+3+RPlour8k8PtfMMxP3JTW6bZibdH1qlhSJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6916

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3ZlcmRsaW4sIEFsZXhh
bmRlciA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDMsIDIwMjQgNDo1MSBQTQ0KPiBUbzogYnJvb25pZUBrZXJuZWwub3JnOyBDYXJsb3Mg
U29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXY7IEJvdWdoIENoZW4NCj4gPGhhaWJvLmNoZW5AbnhwLmNv
bT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgt
aW14QG54cC5jb20+OyBKdW4gTGkgPGp1bi5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIXSBzcGk6IHNwaS1mc2wtbHBzcGk6IHJlbW92ZSByZWR1bmRhbnQgc3BpX2NvbnRy
b2xsZXJfcHV0DQo+IGNhbGwNCj4NCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFp
bC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0
YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1Jl
cG9ydCB0aGlzDQo+IGVtYWlsJyBidXR0b24NCj4NCj4NCj4gSGkgQ2FybG9zIQ0KPg0KPiBPbiBX
ZWQsIDIwMjQtMDQtMDMgYXQgMTY6NDAgKzA4MDAsIGNhcmxvcy5zb25nQG54cC5jb20gd3JvdGU6
DQo+ID4gZGV2bV9zcGlfYWxsb2NfY29udHJvbGxlciB3aWxsIGFsbG9jYXRlIGFuIFNQSSBjb250
cm9sbGVyIGFuZA0KPiA+IGF1dG9tYXRpY2FsbHkgcmVsZWFzZSBhIHJlZmVyZW5jZSBvbiBpdCB3
aGVuIGRldiBpcyB1bmJvdW5kIGZyb20gaXRzDQo+ID4gZHJpdmVyLiBJdCBkb2Vzbid0IG5lZWQg
dG8gY2FsbCBzcGlfY29udHJvbGxlcl9wdXQgZXhwbGljaXRseSB0byBwdXQNCj4gPiB0aGUgcmVm
ZXJlbmNlIHdoZW4gbHBzcGkgZHJpdmVyIGZhaWxlZCBpbml0aWFsaXphdGlvbi4NCj4gPg0KPiA+
IEZpeGVzOiAyYWUwYWIwMTQzZmMgKCJzcGk6IGxwc3BpOiBBdm9pZCBwb3RlbnRpYWwgdXNlLWFm
dGVyLWZyZWUgaW4NCj4gPiBwcm9iZSgpIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgU29u
ZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4NCj4gWW91IGFyZSBhYnNvbHV0ZWx5IHJpZ2h0IQ0K
PiBTb3JyeSBmb3IgdGhlIHN0dXBpZCBtaXN0YWtlIGFuZCB0aGFua3MgZm9yIHRoZSBwYXRjaCEN
Cj4NCj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KPg0KSGksIEFsZXhhbmRlcg0KDQpJdCBkb2Vzbid0IG1hdHRlcjopIQ0K
VGhhbmtzIGZvciB5b3VyIHN1Y2ggcXVpY2sgYWNrLg0KDQpCUg0KQ2FybG9zDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtbHBzcGkuYyB8IDE0ICsrKysrKy0tLS0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jIGIvZHJpdmVycy9zcGkv
c3BpLWZzbC1scHNwaS5jDQo+ID4gaW5kZXggMDc5MDM1ZGI3ZGQ4Li45MmE2NjJkMWI1NWMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQo+ID4gKysrIGIvZHJp
dmVycy9zcGkvc3BpLWZzbC1scHNwaS5jDQo+ID4gQEAgLTg1MiwzOSArODUyLDM5IEBAIHN0YXRp
YyBpbnQgZnNsX2xwc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+
ID4gICAgICAgICBmc2xfbHBzcGktPmJhc2UgPSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1h
cF9yZXNvdXJjZShwZGV2LA0KPiAwLCAmcmVzKTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIoZnNs
X2xwc3BpLT5iYXNlKSkgew0KPiA+ICAgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGZzbF9s
cHNwaS0+YmFzZSk7DQo+ID4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X2NvbnRyb2xsZXJfcHV0
Ow0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAgICAgfQ0KPiA+ICAg
ICAgICAgZnNsX2xwc3BpLT5iYXNlX3BoeXMgPSByZXMtPnN0YXJ0Ow0KPiA+DQo+ID4gICAgICAg
ICBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICAgICAgICAgaWYgKGlycSA8
IDApIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gaXJxOw0KPiA+IC0gICAgICAgICAgICAg
ICBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJl
dDsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2ly
cSgmcGRldi0+ZGV2LCBpcnEsIGZzbF9scHNwaV9pc3IsIDAsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRldl9uYW1lKCZwZGV2LT5kZXYpLCBmc2xfbHBzcGkpOw0KPiA+ICAg
ICAgICAgaWYgKHJldCkgew0KPiA+ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYs
ICJjYW4ndCBnZXQgaXJxJWQ6ICVkXG4iLCBpcnEsIHJldCk7DQo+ID4gLSAgICAgICAgICAgICAg
IGdvdG8gb3V0X2NvbnRyb2xsZXJfcHV0Ow0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0
Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBmc2xfbHBzcGktPmNsa19wZXIgPSBk
ZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInBlciIpOw0KPiA+ICAgICAgICAgaWYgKElTX0VSUihm
c2xfbHBzcGktPmNsa19wZXIpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIo
ZnNsX2xwc3BpLT5jbGtfcGVyKTsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBvdXRfY29udHJv
bGxlcl9wdXQ7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiAgICAgICAgIGZzbF9scHNwaS0+Y2xrX2lwZyA9IGRldm1fY2xrX2dldCgmcGRl
di0+ZGV2LCAiaXBnIik7DQo+ID4gICAgICAgICBpZiAoSVNfRVJSKGZzbF9scHNwaS0+Y2xrX2lw
ZykpIHsNCj4gPiAgICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihmc2xfbHBzcGktPmNsa19p
cGcpOw0KPiA+IC0gICAgICAgICAgICAgICBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAg
ICAgLyogZW5hYmxlIHRoZSBjbG9jayAqLw0KPiA+ICAgICAgICAgcmV0ID0gZnNsX2xwc3BpX2lu
aXRfcnBtKGZzbF9scHNwaSk7DQo+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+IC0gICAgICAgICAg
ICAgICBnb3RvIG91dF9jb250cm9sbGVyX3B1dDsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IHJldDsNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhmc2xfbHBz
cGktPmRldik7DQo+ID4gICAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+IEBAIC05NDUsOCArOTQ1
LDYgQEAgc3RhdGljIGludCBmc2xfbHBzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0K
PiAqcGRldikNCj4gPiAgICAgICAgIHBtX3J1bnRpbWVfZG9udF91c2VfYXV0b3N1c3BlbmQoZnNs
X2xwc3BpLT5kZXYpOw0KPiA+ICAgICAgICAgcG1fcnVudGltZV9wdXRfc3luYyhmc2xfbHBzcGkt
PmRldik7DQo+ID4gICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoZnNsX2xwc3BpLT5kZXYpOw0K
PiA+IC1vdXRfY29udHJvbGxlcl9wdXQ6DQo+ID4gLSAgICAgICBzcGlfY29udHJvbGxlcl9wdXQo
Y29udHJvbGxlcik7DQo+ID4NCj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4NCj4g
LS0NCj4gQWxleGFuZGVyIFN2ZXJkbGluDQo+IFNpZW1lbnMgQUcNCj4gaHR0cDovL3d3dy5zaWVt
Lw0KPiBlbnMuY29tJTJGJmRhdGE9MDUlN0MwMiU3Q2Nhcmxvcy5zb25nJTQwbnhwLmNvbSU3Qzcy
MGJlYWNjYzRjOTRkYw0KPiA2N2Y1YTA4ZGM1M2JiMzgzMyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2DQo+IDM4NDc3MzEwNzgxNzg2MDg4JTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpDQo+IExDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhDQo+ID0lMkJMZDVF
OXhVMDFpVkhIUXNvSk05ekRiTlNwbjQ3Y2pvTkM5eWY4cUNqakklM0QmcmVzZXJ2ZWQ9MA0K

