Return-Path: <linux-kernel+bounces-117899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A348888B113
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5975429B2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E0537FF;
	Mon, 25 Mar 2024 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="aezj7dEQ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AAA4CDFB;
	Mon, 25 Mar 2024 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397550; cv=fail; b=BWnMfNEdwwTsorKwIGJ31KPHElEe3NgnQ+OMttacfsG9HPjS3xU4eGy6USvpGN42H3ci/LN+ZMEUAR6LaZB6y4aodWf3R9lDWUCdHGSpSDLrLdJs7nGsXbc9vlsLWu7KPQIcO6UsO1Ysqu4iOD89IEfoAAtg7tnwPaK1RWDtRD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397550; c=relaxed/simple;
	bh=dNAw+uQotq/hsEb43LIAfazbkpIjkmUpU2roDdz6gm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W8bxX4t+SPAq3Cs+lWGw3y3jeGyhCXoKl7ruFQ0436huQCBk/oxke+Mqdir6RylqdF4pgwBNK7WwtGfT9kISxZ/BhTF0Lvz/KR8fv1kbsjcZbrn91UgRbTyl30V8HsaeDTUPtb5ZQCNaxqIa5HS65XWNTjlq/vsbnIF5PImZsMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=aezj7dEQ; arc=fail smtp.client-ip=40.107.7.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR6CWr/ecp/79lq1hzP7+ggFOgzwVigj4c/09uFVEYs7sO/PlU5DYBPoi1Msds9jyUKjJjR285hUoTc27vD/mkQ0PziSOd5owxAKflgBRYFuKOMaeUBp6Q3BwJ1engNRM86UJf7C6gQIh9y1GApV8FUnPVmWsfoCYGZ9pnPF+p5WWIaCCxZQvZpZ7Y2d+y4wHuML1vPahMpIBA8J5ZA/ZAiKb+oThTSFCWxlHS/KiWSQYScf4r6rFwgwYdpNdFoQNZGj8IaSuUMK3lYsLduus/uTE5Z0TDm6ekdZo0W3MOtcN+87mbMCMbgk2zNS+OXMtpZ8iOVxAblEN++Q2yvP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNAw+uQotq/hsEb43LIAfazbkpIjkmUpU2roDdz6gm8=;
 b=lhNbST89suToQkON5gTQTIjkAYWXY8Gkn3sNDUwwfeaSqfwudbh6M+Qc4McgmwNYTuiZCh/a0/7ymImd3gK4s9MDTrD6UQCXEGql5JXZNWLEln6tsnOEtxQAaXNWrln7VlismISkGS5QKzQn1SC7Fy8Zqk4NlYAUsljIMoivnHvwczClhmDP3LwgWTGvA9k9pYYp1v3Ztv0o+DDdCnYuGr5VswNJp4IEJEC9YYzg9XGXR+/OhjIx+EG6ManX7JdaWDkk5C1x6/vOzY59dv5A8TSVVguuIslY/DZzFYTc+mp58qLPcPkLnS2qx/3e7lYZuv3ZbclBtrw9M/750SIT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNAw+uQotq/hsEb43LIAfazbkpIjkmUpU2roDdz6gm8=;
 b=aezj7dEQXcbr3b7wad94QNvWGe2Mo/6f77n/Vo131hb1P56H6kiEUKEZ2XCeSHFMG+8V64ONMrdkVQJ/W7Pn2xKhI+iw4vuFe5L9X9IkaedgjzG7hqDAj5Qx4zDaz9o7rhLczpw+yOzXLPuLtdKEgiozTrEQvao1BOpfQmqno3o=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB9801.eurprd04.prod.outlook.com (2603:10a6:150:115::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 20:12:23 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:12:23 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index: AQHae9lZw/gIYk6zDE+73DiBF+lb+bFDiiAAgAVVLYCAAAp+AA==
Date: Mon, 25 Mar 2024 20:12:23 +0000
Message-ID: <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
In-Reply-To: <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|GVXPR04MB9801:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 65ESF8aQAIUP9PTNUbY3+yw0qlx31Z5zxc1YLc/ucGgrX/UBltx8DyjNh8CDoiP8ih2asfniyQfCNGENBsX3mvgLe2Pd0QHRs0CwUcHT4v6MpjuDhksttv9OPRk8WRsl5f2NoJaYN6Rr3mrMDLXpDDIeetteEr7FFjYIwh+w8JPtcEIo5jzSQPZIu4NoN3aoeDlM99s90d5RFBMZ9zj2OppLYVnxoTV796mDXef6CXiePzlavZ+Y2sDo7kAp87KDrFUl4sjTg43iWhG9IcgYlbK/exfXA8xgGQ/r1oZ/ZX8C0SzDuovyHTobYbCDtuiS7XV7NNP4D5BxIFbaju5BG59vDmDhtxIaeJYqZ7XHI6KRw86sYnt+pNTPCxv5wSRZZkEiUqEnbezBLokZAq3BIlZFl5lQYzomt/Fwgx3Zt17+K3D605FDGCXdolkVcUgCZbTsIpt4uhMq0XVe8iZekqMTY2R1wzVLwTOtafVqaCAefcaABb1nxuBSruTbLiZJXI/OGo7FCOnu55g9outEtUjKW+3atZhW4LZVuKqeMlhQfDgOdsFS0Bqp6AYN87VA0HDGJbNIEzIpbYgsh37bOE6GZH5HGXU3QXu7jHQigvo/8bwztyNjsthxsAduc9tAVKckeIHww+5daHmheA4//904FGMaU6Dpgk2+LRQPFiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhsN1QramFzYWZTSDNnTTRicHQ1RmxIYndVVWZBemNSdVhnQzBORktXTE94?=
 =?utf-8?B?MEVpMkFLdWUwaEsxdVh2bnRTUW84bSsxbmQxSmkzZEFLS2tnSzlUOXIyR1k2?=
 =?utf-8?B?QUtvdlhHMW9TTmpjU0JlZmwzSTRyMFBycFdwY3ZvRkRMOEZ1SnErTVZ5YVZV?=
 =?utf-8?B?eHQ0cVplUndJMyttVkorVkZMa3UyTG4zUXUzdVRmWW9UU3BQd3JNcGYzSnJm?=
 =?utf-8?B?ekV6aVJtS3UrT2tJekpiL0ozYllvWitWcmQvY3ZNdTFmZjVaSUsvclhuc3hR?=
 =?utf-8?B?QWlLb0pIM0YzYi82TTB2bmRpaElXRlV0MUVkeUJuSm5qQ1FHRFVIQTVtdXFa?=
 =?utf-8?B?Qi9MeHlJYmtXMnpqZXdOOHYwZWR2bkNBRERuU1k1VjJkRml4OTVJdVFXSVNq?=
 =?utf-8?B?Q3N2WHJCVkxmb1ZzWXRMM25veUpZZkR0aEU3WUcySlREZ3lFYldaWFZSdzhU?=
 =?utf-8?B?bWo0OVl5ZUFzK0F6N2UzNnZXTWtIKzFmbTdNNTh5dzZ4bG12cFg0UVoxZFJp?=
 =?utf-8?B?NGgwNDZVV0pWUzFGSnFWd1FXaVdoZ0NLY3p2djFSSzBjd01CQkMyaHFTdXkv?=
 =?utf-8?B?Rndxa05JejNYZU5LVFhWL2JZaDV5UisxVDdRdnFTWlY5MFlmRnE0TnJxeU96?=
 =?utf-8?B?TWFZa1cyNlJ3UkR6bmcxUkdsd0FvNmFxc0VNMDMzWGJUbUtRK09tTVN5MTVw?=
 =?utf-8?B?bVpOM3R5TXIvRGpvM05GN1BTWGRDSVFKUnZSRmhZUVVLVU9XZFoyK0JGaVlD?=
 =?utf-8?B?ci9Mdkh4NGVrMXlkMzFQT0MrcTRLSjBjdVUwT1ZKdld2ZlVrOXdVUzhlbEUz?=
 =?utf-8?B?aVE0V0xJbzlNWVZTTEJFcXJHTHBWR0kxd2JEa1lSek14ald1RmQ0S2VDa0FV?=
 =?utf-8?B?SGUyalZtSi9OR2RTODV2WmswU0JIVyswcll3OHM1OHAvVmZLbHZ3d2phLzRN?=
 =?utf-8?B?cEgxbitnYTZKUm10d29WRHhSQndZUVpybVBoMVZ1QXBQQ0VpRUpZL1I2REJo?=
 =?utf-8?B?eGNuMnBPUFJML2RCbHJwY21pd1RGdzd4ZURjNEFlSDRSS21JcisvQnFLYkhp?=
 =?utf-8?B?QmExczd0VnFmWlc5OXkybks2SVJabWlZa0FNVDI0R2VPQmhyUzVkUng0RENQ?=
 =?utf-8?B?TDR1WjRRWVhrUFdjcFh0dGVaTEFRc24rK2RFY09yeS9ldFgwdzY1U2RabTdi?=
 =?utf-8?B?S2dqWk1Pd2M5M0toazZ2TmlnK0h5WmZZM0FFZSsweml0Z0YwYlN3MHYrVDFi?=
 =?utf-8?B?SnVoWVlKMnJ2VTBvMCtpWXEzaXFhenk2d2t2eWRKWlljU2FXSmp2c2NmRUlE?=
 =?utf-8?B?cDY5SmtWd1NkUEdmMnVjaXAvVmFDZlA0OTRTQXFOUDZpK0t3UG9jcG80dXlp?=
 =?utf-8?B?R0Z1Ulo4MEZuUVJFYzF6N0poWEYyOEN1azVpRGR2UFMvMHA2SmlFVm1iSmc1?=
 =?utf-8?B?VTVpNmVSNEJNUzhCazBxczZvd1FnRlhvc25NZWtjVnRjZ3RHbDdYT24rbGJD?=
 =?utf-8?B?ZElOT291VGhhOVNIb0c5d3RTNU1icHpWTmUzTW5DNUxWQUNYTVZEVnpadW9h?=
 =?utf-8?B?Rzl5aHZnZ0RlRCtIN0RDY2FGTTZEVkpaOHZMZHVwQy9wL2JkYmxicXgzYys4?=
 =?utf-8?B?MEVRVVNTVHBiRHk2TldRcHM4akYvMFMxZmZvN3JvWEYyTEl0enRlcWMyVEtW?=
 =?utf-8?B?YWpkUkpGdnFkK3hkMjRZZUVTaHNwR002OU40eFo1MG5VQTAwaEVRRGhjVmdK?=
 =?utf-8?B?SHZtSUt5K1pZNWFBMzBzanp0UEgvd2RZazBqZWxNdEtmaUZtL1RnbExHZEl6?=
 =?utf-8?B?cFR6ZkhMVW1kVGdiVlFidGgvdVJONFdJQVZhallGTDZWR3lvRE9TS0d6SDZO?=
 =?utf-8?B?Rk0vWTgzeDJDNmdrVExpNDlUSWpBVUVudmwvOWRWTFJhRW9XalVZazZ6TW00?=
 =?utf-8?B?TFUyYXo4dFpIeFd3V1pIME5nNW82OTlSSXdIVUZBdFduT0FDbXltcnlXc2p1?=
 =?utf-8?B?SVJiUHRlRWdVY29ub0taTHVlaEt4UVNtc0svbHZFcE1DT3VpNUI3eHBFMUla?=
 =?utf-8?B?ZDdROThUVUo1dUZ0NFpsYU1LL0x2MTdDV1hnZ3hrQ3NSMVkvS0RQdFRCTzBN?=
 =?utf-8?Q?0VbA1XSb8jmfsmPXO2uiBeAVz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A47418931F6CC4F9AE436A6E96CB33A@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c789f395-4c2e-4a4f-280e-08dc4d07e217
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:12:23.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OgC9XIfA5euQWIHjCzoMeJjOfcUtNWSSFV/N4Zzo6eUrPCxeaycu4ZCvLhoaL0fF/sggptHEXRIvx5KtxFElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9801

QW0gMjUuMDMuMjQgdW0gMjA6MzQgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
Mi8wMy8yMDI0IDExOjA4LCBKb3N1YSBNYXllciB3cm90ZToNCj4+IEFtIDIxLjAzLjI0IHVtIDIy
OjQ3IHNjaHJpZWIgSm9zdWEgTWF5ZXI6DQo+Pj4gQWRkIGJpbmRpbmdzIGZvciBTb2xpZFJ1biBD
bGVhcmZvZyBib2FyZHMsIHVzaW5nIGEgbmV3IFNvTSBiYXNlZCBvbg0KPj4+IENOOTEzMCBTb0Mu
DQo+Pj4gVGhlIGNhcnJpZXIgYm9hcmRzIGFyZSBpZGVudGljYWwgdG8gdGhlIG9sZGVyIEFybWFk
YSAzODggYmFzZWQgQ2xlYXJmb2cNCj4+PiBib2FyZHMuIEZvciBjb25zaXN0ZW5jeSB0aGUgY2Fy
cmllciBwYXJ0IG9mIGNvbXBhdGlibGUgc3RyaW5ncyBhcmUNCj4+PiBjb3BpZWQsIGluY2x1ZGlu
ZyB0aGUgZXN0YWJsaXNoZWQgIi1hMSIgc3VmZml4Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
Sm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4gLS0tDQo+Pj4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sICAgICAgICB8IDEy
ICsrKysrKysrKysrKw0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
bWFydmVsbC9hcm1hZGEtN2stOGsueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0KPj4+IGluZGV4IDE2ZDJlMTMyZDNk
MS4uMzZiZGZkMWJlZGQ5IDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0KPj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFt
bA0KPj4+IEBAIC04Miw0ICs4MiwxNiBAQCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAgICAgICAgLSBj
b25zdDogbWFydmVsbCxhcm1hZGEtYXA4MDctcXVhZA0KPj4+ICAgICAgICAgICAgLSBjb25zdDog
bWFydmVsbCxhcm1hZGEtYXA4MDcNCj4+PiAgDQo+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246DQo+
Pj4gKyAgICAgICAgICBTb2xpZFJ1biBDTjkxMzAgY2xlYXJmb2cgZmFtaWx5IHNpbmdsZS1ib2Fy
ZCBjb21wdXRlcnMNCj4+PiArICAgICAgICBpdGVtczoNCj4+PiArICAgICAgICAgIC0gZW51bToN
Cj4+PiArICAgICAgICAgICAgICAtIHNvbGlkcnVuLGNsZWFyZm9nLWJhc2UtYTENCj4+PiArICAg
ICAgICAgICAgICAtIHNvbGlkcnVuLGNsZWFyZm9nLXByby1hMQ0KPj4+ICsgICAgICAgICAgLSBj
b25zdDogc29saWRydW4sY2xlYXJmb2ctYTENCj4+PiArICAgICAgICAgIC0gY29uc3Q6IHNvbGlk
cnVuLGNuOTEzMC1zci1zb20NCj4+PiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsY245MTMw
DQo+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1xdWFkDQo+Pj4g
KyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNw0KPj4+ICsNCj4+PiAgYWRk
aXRpb25hbFByb3BlcnRpZXM6IHRydWUNCj4+IEJlZm9yZSBtZXJnaW5nIEkgd291bGQgbGlrZSBz
b21lIGZlZWRiYWNrIGFib3V0IGFkZGluZw0KPj4gYW5vdGhlciBwcm9kdWN0IGxhdGVyLCB0byBl
bnN1cmUgdGhlIGNvbXBhdGlibGVzIGFib3ZlDQo+PiBhcmUgYWRlcXVhdGU/IEluIHBhcnRpY3Vs
YXI6DQo+PiAtIHNlcXVlbmNlIG9mIHNvYywgY3AsIGNhcnJpZXIgY29tcGF0aWJsZXMNCj4+IC0g
bmFtZSBvZiBzb20gY29tcGF0aWJsZQ0KPj4NCj4+IERyYWZ0IGZvciBmdXR1cmUgYmluZGluZ3M6
DQo+PiDCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgU29s
aWRSdW4gQ045MTMwIFNvTSBiYXNlZCBzaW5nbGUtYm9hcmQgY29tcHV0ZXJzDQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgd2l0aCAxIGV4dGVybmFsIENQIG9uIHRoZSBDYXJyaWVyLg0KPj4gwqDCoMKg
wqDCoMKgwqAgaXRlbXM6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBlbnVtOg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBzb2xpZHJ1bixjbjkxMzEtc29saWR3YW4NCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGNuOTEzMQ0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIC0gY29uc3Q6IHNvbGlkcnVuLGNuOTEzMC1zci1zb20NCj4gVGhpcyBkb2VzIG5vdCBsb29r
IGNvcnJlY3QuIGNuOTEzMSBpcyBub3QgY29tcGF0aWJsZSB3aXRoIHlvdXIgc29tLg0KVGhpcyBp
cyBwYXJ0aWFsbHkgbXkgcXVlc3Rpb24uDQpJIGNvbnNpZGVyZWQgY2hhbmdpbmcgdGhlIHNvbSB0
byAiY245MTN4LXNyLXNvbSIuDQoNClRoZSBTb00gaXRzZWxmIGlzIGFsd2F5cyA5MTMwLCBpdCBj
b250YWlucyB0aGUgYmFzZSBTb0MNCndpdGggMXggQVAgYW5kIDF4IENQIGluIGEgc2luZ2xlIGNo
aXAuDQo5MTMxIGFuZCA5MTMyIDxoYXBwZW4+IG9uIHRoZSBjYXJyaWVyIGJvYXJkcy4NCg0KPg0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1hcnZlbGwsY245MTMwDQo+IFNvQ3MgYXJl
IGNvbXBhdGlibGUgb25seSBpbiBzb21lIGNhc2VzLCBlLmcuIG9uZSBpcyBhIHN1YnNldCBvZiBh
bm90aGVyDQo+IGxpa2Ugc3RyaXBwZWQgb3V0IG9mIG1vZGVtLiBBcmUgeW91IHN1cmUgdGhpcyBp
cyB5b3VyIGNhc2U/DQpUaGlzIGlzIG1vcmUgY29tcGxleCwgQ045MTMxIGFuZCBDTjkxMzIgYXJl
IG5vdCBzaW5nbGUgU29Dcy4NCkEgIjkxMzIiIGlzIGluc3RhbnRpYXRlZCBieSBjb25uZWN0aW5n
IHR3byBzb3V0aGJyaWRnZSBjaGlwcw0KdmlhIGEgTWFydmVsbCBkZWZpbmVkIGJ1cywgZWFjaCBw
cm92aWRpbmcgYWRkaXRpb25hbCBJTw0Kc3VjaCBhcyBuZXR3b3JrLCBpMmMsIGdwaW8uDQoNCk5v
dGUgdGhhdCBldmVuIHRoZSBmaXJzdCwgIjkxMzAiLCB3aGlsZSBhIHNpbmdsZSBjaGlwLCBjb250
YWlucyB0d28gZGllczoNCkFuICJBUCIgKEFwcGxpY2F0aW9uIFByb2Nlc3NvciBJIGFzc3VtZSkg
d2l0aCB2ZXJ5IGxpbWl0ZWQgSU8gKDF4c2RpbywgMXhpMmMpLA0KYW5kIGEgIkNQIiAoQ29tbXVu
aWNhdGlvbiBQcm9jZXNzb3IgSSBhc3N1bWUpIHdpdGggbG90cyBvZiBJTy4NClRoaXMgQ1AgYXMg
ZmFyIGFzIEkga25vdyB0b2RheSBpcyBpZGVudGljYWwgdG8gdGhlIHNvdXRoYnJpZGdlcw0KbWVu
dGlvbmVkIGFib3ZlLg0KDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxh
cm1hZGEtYXA4MDctcXVhZA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1hcnZlbGws
YXJtYWRhLWFwODA3DQo+IEFueXdheSwgNiBjb21wYXRpYmxlcyBpcyBiZXlvbmQgdXNlZnVsIGFt
b3VudC4gV2hhdCBhcmUgeW91IGV4cHJlc3NpbmcNCj4gaGVyZT8NCkkgY29waWVkIHRoaXMgcGFy
dCBmcm9tIHRoZSBleGFtcGxlcyBlYXJsaWVyIGluIHRoZSBmaWxlLCBzdWNoIGFzOg0KwqDCoMKg
wqDCoCAtIGRlc2NyaXB0aW9uOiBBcm1hZGEgQ045MTMyIFNvQyB3aXRoIHR3byBleHRlcm5hbCBD
UHMNCsKgwqDCoMKgwqDCoMKgIGl0ZW1zOg0KwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IG1h
cnZlbGwsY245MTMyDQrCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWFydmVsbCxjbjkxMzEN
CsKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGNuOTEzMA0KwqDCoMKgwqDCoMKg
wqDCoMKgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFwODA3LXF1YWQNCsKgwqDCoMKgwqDCoMKg
wqDCoCAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNw0KPiAgV2h5IGlzIHRoaXMgZXZlbiBh
cm1hZGEgYXA4MDc/DQpXZSBub3RpY2VkIGFwODA3ICE9IGFwODA2IChjbjkxM3ggIT0gODA0MCks
DQpiZWNhdXNlIHRoZSB0aGVybWFsIHNlbnNvciBjb2VmZmljaWVudHMgY29udmVydGluZw0KcmF3
IHZhbHVlcyB0byBjZWxzaXVzIGRpZmZlcmVkLg0K

