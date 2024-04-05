Return-Path: <linux-kernel+bounces-133170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EEA899FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4F92849AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139BB16F27E;
	Fri,  5 Apr 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hgf+kY5K"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2117.outbound.protection.outlook.com [40.107.249.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43816F0FB;
	Fri,  5 Apr 2024 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327779; cv=fail; b=DeH+NsXOCgFJFaQBfLExEdGStcLDHgQeDdrQPTowIq5UfDhIfCnc77MjhuHKPAnwUW0dNVxns9MszV5vg1wLT1u+91tQUbMFGwuqlSb9G34VwVoay2SORFtmp7Ev21nkORnC57atebTsXgxVAbHY6jhizKpU8DDXknfy+U/hJKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327779; c=relaxed/simple;
	bh=VH30VPdScY4WI97/9vYaTL4da/L8PjX3LQY/VXOKY4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ps7bxTW+fhWgpE53+CMuOzrqxJE0hNDx4IKnWkjnmRtsHg1A8KME7lFbpdQuIxvzz5xF8bhdBN5TqlS/hdynJLFsNYyGaOcpqpzr7OyiAZ3PiK03Esv+Lbbvum/Lpzhtu9/865rWz0DvpXYKcsjAiqsaS9IbcdvS52a1TkSyW6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=hgf+kY5K; arc=fail smtp.client-ip=40.107.249.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAuVigMkvqnlcr/YOLKpQjiViFO1FoYgSHmJLzMOjhRBE0lNHddgxRIg5VzRtDYXdfdg1fxzVsUxVQBoICMeQdJKu/n8jmmPYFfG9Yy+Uc9W64qJCY3fecwKqUUgB+lIF3kL233PpmDvQF4EdsdQqK7YIXOVGsPFwrspySN/bhtcHnTJMY6AEw9eyWhZocZr/yH7qN8CZYO4uBeJ5FqMiIoHvxNVJjahSaxHQs5hH9UPNUP4FNX5ZLWKxlv6XFtVOKtPYIqz6fRlKl63roSIatvHW3JL3tqkn1ztU+9+x3plbbA+Bt6h+v0p67TbxkYn8s2bCeQMfpDaGbjzs7V17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH30VPdScY4WI97/9vYaTL4da/L8PjX3LQY/VXOKY4A=;
 b=hZPi85/3lV72PL35lrE9I6vSfD/iGv2qR3tx4YD5kmaxr3bedMu83spGRoJKS3m5uJLbBRUowhlXphgOzBiHRKilBV6aMdZMDqpo2XXYCGXJxXAGAZ1RFQZy5jr9vG3yYsvBJA8rbIr5kqHFMON9keXmC4oTAxxkwtR0qyufFyLSVWA9KmjxPnXliAruU0eCBl8NRAwQ5qzgl5h+NZrJU3YumVEeUvBM/hhWjLouMFP89WFODIztKnR2Lqil9+pe+gF3bk09kjJL06YzVC6wRKKTUsevi37YOZd+aj0gk2fW0KBnqZ1eJ5bgc1vAc3+QEh4arMlQ7JZ2BclscEz2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH30VPdScY4WI97/9vYaTL4da/L8PjX3LQY/VXOKY4A=;
 b=hgf+kY5KbW01hfNbct79nWPt6J9m5KWfxOG7Rdo3e2L/EMWBrsehpK5z2guVUW+W9Trd2u9QmpFDS4gsz6otlMDCOSNDjKDYpF9d6BGvot/fvamJQwGGcNUFyM9ilQIqdC+qTbTy+Y8GXzOD7GA8Az9GWUiXW6yds/y6fY9QAoM=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Fri, 5 Apr
 2024 14:36:13 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:36:12 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Rob
 Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
Thread-Topic: [PATCH v2 3/3] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
Thread-Index: AQHahqWtYMf1T+c6hE2W7MNOxL0MWrFZQeyAgAB9/gA=
Date: Fri, 5 Apr 2024 14:36:12 +0000
Message-ID: <7a3c1222-adb2-4daf-a31d-1858eb83ac2c@solid-run.com>
References: <20240404-cn9130-som-v2-0-3af2229c7d2d@solid-run.com>
 <20240404-cn9130-som-v2-3-3af2229c7d2d@solid-run.com>
 <84bf0db5-856a-401b-8225-fd62f381beb6@linaro.org>
In-Reply-To: <84bf0db5-856a-401b-8225-fd62f381beb6@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI1PR04MB7053:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bh0Ao4bxGZ78BS0wGiOABn1SO2u/g4LIUOfp/weLmW6TA74wSncXRLA111FT7jLG0tr9YBl8NqYL2OTLu08AsFV4n20IJO8TNd3mudsrjsWxEW52ZqAs4Em1EPOyQFk9OKF+NGy27OtcJ6q5Ma7N5VXxtf07dRcIXgJr6qcf8xjGVjTrhTbkAAJkDdoPsR7jcSQuE0xMLyMNp7GvPxZ9alWY/MXg0u/TztPSTzWoK1EeOkU+E3dFrlz/u0ELLTTImx6CSo78FeGrNlrHlG09VUhIOl+mV4OhffDraIJPm7qm58I4SkgHDGmg+ZE2xWhgXR1+VZhUCcXHCAmkfpy7HSmLP/c9Qb5N6hQ4Mxxcv/ewv7lfgghdfdCgO+7U4WqM2wQ5NX+/uvcyJN4xk2CgwBoHPvJssRLvmHX8nW8RjSmWc0RxfzWaHKhZt4cOh9ABpPaw1Iz5kt6TtV9Umcmz+x4gV5d39nodlIqHQ/6WwVCEfrlRkFzQTiOg4kx/ZJvs1dugRKODjoRYwA9dXhGoaXph5z8xl0l1Wr+W/vjITPKNKjy5aq5k5VLpMM7mWt3Tn/MJ6DEVvBCZPCSehODHFGfZ3jsQqisvFIJIcyP6SiHNS8aJqLDvKZ8+YtlYR30d86EQvcT98NGG9DvEIph8W8bFqDKHxFaA4bYRtSvDcwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXBFYzk0ZnJsL3FXbzdjd3kyZGUyc1BDZm9POWY0elpVR211Q25xUEhZMG9a?=
 =?utf-8?B?SnlDUStXa2h5dUIxeWVMbDFsRUc4SDZNcVR4M2Joakh4OHQ4Q28wUytTZy9I?=
 =?utf-8?B?RzZrMGlxKzZQazVnUW9WOHQxSEorcUtYODBRRHovSDUvVWFmRkJ6Vk1vR0Ir?=
 =?utf-8?B?NHNYUTYvT2pkQmVFSUFYYzlPQTc1a2FXRG00QTlVRlk3U0RobFhDQmg1Z3NO?=
 =?utf-8?B?YzRudDZRZlBNQjZSbVA5NzVjaDZKeGpnZTczUVNCV3pkT01DV01yY1ZVemhP?=
 =?utf-8?B?T0F4MExqUkduSE5ndmhQUjJNc2RIaDRUdUtaVXpCUDVqRFJldE9HWVpDSU1i?=
 =?utf-8?B?TU1oTCs1ZHIyTFB0aXFyTUl5alpraTNZSFpoWG9GYmJNTEVBMTY0RGhKRU81?=
 =?utf-8?B?SGlUSTFZQ1NVUWlYTXVCeXRwaGdlOUgva3Q4Uzh2RDlpWGtrT3dFd1UxbFJh?=
 =?utf-8?B?dUwrVTlZaTkvMGRoaWVwb01JV2h4eEJVS3REZC9OZGdwdklVVFAzcldlSjU2?=
 =?utf-8?B?YS8zbFE1a1haTzV5aUtTaVk1K3g5NG9nbDUxRjllV1pIOHpnb1RlV2d5dWxC?=
 =?utf-8?B?MkFNbXp6WWtMUWczYTM2QUVuZkdNTHhrU3E5eWFHVU1QQ01KVStaam1BRkx1?=
 =?utf-8?B?dDlDK3J3Y3YrL0s1Sk1pVGxBWjk4ZTMvTFVQU2puQVZlQWIwQ3NsdjQwZHo1?=
 =?utf-8?B?eFhpWElmNlRDR015WlRhMzgySFltOEdOZUdGa0JPUEl6Y2M0bEtrYU5EZ0t4?=
 =?utf-8?B?OHM4Ui81ZXVaMU5odTZnSHh0NjZvdHAyT2J5Qkt5MWRENmlsVjZLWk91WUgz?=
 =?utf-8?B?Nmo3N3RQQy9vZ1RIZk1zN2VPL1BUUW5rQ2NxbXVKOExJd0d3dnZTUW5Yc01h?=
 =?utf-8?B?QkM3VW9LUnRvV2liNUJWV0tabFRKWTlwaTAvN3E2VWt4L3RpazJyVG00OWs2?=
 =?utf-8?B?TXRaTEozWkpNL2oyUnI4UjdYbnA3VXlmOWJnZk1PbzdnUkllNCtkVGJOK1li?=
 =?utf-8?B?K2pLcTdnR2dsdjhqUGhMTU5FdEtVZlIyenZ6bGFzQ0IrMk5HVThLcWp2Wkdi?=
 =?utf-8?B?eWhxSjFJbGZjVDlxUU5WV0FwbFAybk51L0h5TWN3Rk5paUsxLzZMT1U2YitH?=
 =?utf-8?B?dTErcFRlNVVBaXNmY0EzNTdNWkYzU2psSkV0RklwWUVZUmRBNytVSkhaeWw1?=
 =?utf-8?B?LzkzWVdXaTlkRTVvT2pZd2tEeGlGOCtDakpCM0pZMzM2REQyWFM1bjQ4cXJS?=
 =?utf-8?B?cGV0ckFyUnJ3OFZEbE9MbGV4T3BXb2toR0RlcXVvYTFiK0RzdE1JUldhbEgx?=
 =?utf-8?B?T3pzeVkrcHVlNWlmREprK2pROGhRdmVMNWl2RHNQSERyc21IQmVwVmhNQVhW?=
 =?utf-8?B?Wm00a1BzWDhobVlSVVRjQ0VyOEJYTnRQN2tBcnZWbEZzNUwrMEdiZTJnak9m?=
 =?utf-8?B?MUJudCt1VXVHVlVVYUpiVWRSNVRNL3VTZzJ6Q0Y5VkJNVStRaW1heXZFKzNp?=
 =?utf-8?B?SXppTXVwZlVUQzJEQWNGMURNWld0T2czQXFXNGFNQnlOQlltZzQ0UHBQUWUy?=
 =?utf-8?B?Y1owTTBVY010UDl4NU13VFlXTDljNFNTdlp5UmQ5OWFucHV4bUFIY3NyMUZ4?=
 =?utf-8?B?R0lKVmVLajFCY3dCa3dEODZlbUcwa01kZlNuT1p6WWNYSjFlWHJMdzlQLy95?=
 =?utf-8?B?MDU0UTVSamVOaVhOZjZjem55RVRHMHZENzlVNU5XT2hDZlI5T0QyS0EwOVMv?=
 =?utf-8?B?TXJ1OFIrSDNsZ3M0cHh5VUVWb1V5L0Q4TmtJWE5QT1Nvb1hXTlovWnd0Tm1R?=
 =?utf-8?B?NjZ3TnhmYnFnODJkOGN6UUdpam8yUytZcWZxNFZpNHl3L2pEdTl1a1N0VXBO?=
 =?utf-8?B?VUR3T0s0bU41RXBpR05sMjRtRXVHSmd1TlExSnlxWVl0MjczZmV0S0NDeU9h?=
 =?utf-8?B?dVFlbWNnY3ZRczhVWG8xMGxjd2ltWUFOYno3SXFjblVZY0EwSWV1UWdjenZU?=
 =?utf-8?B?U05KanEvN3lRL1NoV0Z5UklUd0srcUZJTWx4V0gyVm9xTkpmM0JLbHNWcWZv?=
 =?utf-8?B?Y25wMVpCSUpuNThVcDBrNXNzai95OENtRmgvcTNqbDEzS2JkaDRqMWZkaXp0?=
 =?utf-8?Q?JD50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BB2F8A620BC5B43A868FBA810D07D60@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 177fa6b9-ac74-4d39-697e-08dc557dbe23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 14:36:12.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6r5ycPyLPvBkOiOdJs6A/j8tdJBiKBTW7ZnAXua0b2ya+Pzylv1BnyveIgMeZQxSiLMeiX0Pf5yRmGHPz8M+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

SGkgS3J6eXN6dG9mLA0KDQpBbSAwNS4wNC4yNCB1bSAwOTowNSBzY2hyaWViIEtyenlzenRvZiBL
b3psb3dza2k6DQo+IE9uIDA0LzA0LzIwMjQgMTc6MzUsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4g
QWRkIGRlc2NyaXB0aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMwIFNvTSwgYW5kIENsZWFyZm9n
IEJhc2UgLyBQcm8NCj4+IHJlZmVyZW5jZSBib2FyZHMuDQo+Pg0KPj4gVGhlIFNvTSBoYXMgYmVl
biBkZXNpZ25lZCBhcyBhIHBpbi1jb21wYXRpYmxlIHJlcGxhY2VtZW50IGZvciB0aGUgb2xkZXIN
Cj4+IEFybWFkYSAzODggYmFzZWQgU29NLiBUaGVyZWZvcmUgaXQgc3VwcG9ydHMgdGhlIHNhbWUg
Ym9hcmRzIGFuZCBhDQo+PiBzaW1pbGFyIGZlYXR1cmUgc2V0Lg0KPj4NCj4+IE1vc3Qgbm90YWJs
ZSB1cGdyYWRlczoNCj4+IC0gNHggQ29ydGV4LUE3Mg0KPj4gLSAxMEdicHMgU0ZQDQo+PiAtIEJv
dGggZU1NQyBhbmQgU0Qgc3VwcG9ydGVkIGF0IHRoZSBzYW1lIHRpbWUNCj4+DQo+PiBUaGUgZGV2
ZWxvcGVyIGZpcnN0IHN1cHBvcnRpbmcgdGhpcyBwcm9kdWN0IGF0IFNvbGlkUnVuIGRlY2lkZWQg
dG8gdXNlDQo+PiBkaWZmZXJlbnQgZmlsZW5hbWVzIGZvciB0aGUgRFRCczogQXJtYWRhIDM4OCB1
c2VzIHRoZSBmdWxsDQo+PiAiY2xlYXJmb2ciIHN0cmluZyB3aGlsZSBjbjkxMzAgdXNlcyB0aGUg
YWJicmV2aWF0aW9uICJjZiIuDQo+PiBUaGlzIG5hbWUgaXMgYWxyZWFkeSBoYXJkLWNvZGVkIGlu
IHByZS1pbnN0YWxsZWQgdmVuZG9yIHUtYm9vdCBhbmQgY2FuDQo+PiBub3QgYmUgY2hhbmdlZCBl
YXNpbHkuDQo+Pg0KPj4gTk9USUNFIElOIENBU0UgQU5ZQk9EWSBXQU5UUyBUTyBTRUxGLVVQR1JB
REU6DQo+PiBDTjkxMzAgU29NIGhhcyBhIGRpZmZlcmVudCBmb290cHJpbnQgZnJvbSBBcm1hZGEg
Mzg4IFNvTS4NCj4+IENvbXBvbmVudHMgb24gdGhlIGNhcnJpZXIgYm9hcmQgYmVsb3cgdGhlIFNv
TSBtYXkgY29sbGlkZSBjYXVzaW5nDQo+PiBkYW1hZ2UsIHN1Y2ggYXMgb24gQ2xlYXJmb2cgQmFz
ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNv
bT4NCj4+IC0tLQ0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KDQpUaGFua3MhDQoNCk1lYW53aGlsZSBJIGZvdW5kIHR3
byBpbnN0YW5jZXMgb2Ygc3RhdHVzLXByb3BlcnR5IGluIHdyb25nIHBsYWNlLA0KYW5kIGFsc28g
c29tZSBzbWFsbCBjaGFuZ2VzIEkgcHJlZmVyIHRvIG1ha2UgZm9yIHYzDQooZGlzY292ZXJlZMKg
IHdoaWxlIHdvcmtpbmcgb24gY245MTMxIGJvYXJkKS4NCg0KRG8geW91IHByZWZlciBpbiB0aGlz
IGNhc2UgdG8gZHJvcCB5b3VyIHJldmlldyB0YWcsDQpvciBhbHRlcm5hdGl2ZWx5IHRvIGtlZXAg
aXQsIGJ1dCBhZGQgc2VwYXJhdGUgcGF0Y2ggaW4gdjM/DQoNCg==

