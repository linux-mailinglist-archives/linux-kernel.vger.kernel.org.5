Return-Path: <linux-kernel+bounces-70139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4E8593E1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D312B21584
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0147139B;
	Sun, 18 Feb 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKWBP4uI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE5A34;
	Sun, 18 Feb 2024 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708220302; cv=fail; b=sBQLxVSGK218a/pJv4dzkE6Jsu5IvyIKG5akf+nuZ4U51YUVFKHwM6X20reZib75lE0tJdMavdzgDLed7qU1hvmFwGU+E4VcMN46O7orqhAqMK1aQzqeJAZCctGWBvAtnWNbkuC7bVS/J08zTDEmGZJrzfo6kpRTdycmkWvL/8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708220302; c=relaxed/simple;
	bh=EvCcElWbJxp2F5i+95mD5U14E3+/IxRKQdumddNKV2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CRI+4aQ/k4OES8pB+9ejq70s/wozorDECxmGUdyk0SjYNKRw20PB5yY8PMyxBt5Kz+irsxeXROeqlqTGWZ0GdM6Oq6ouAUcSdP/jHeuApWQIAP9nYxHGojMfhyyM+OE6jbXGcD/Fl/26HE5hSt8cr34+IOZmzd6AUebipUFeWGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NKWBP4uI; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB2BYnkwtQH19jP02NRLfpXNQvVXidVxuSOYN19asRNCGKUkm+CZkdjvHZx97Y82l8VGwyeOjFfpnnggRDP6+4+7Sk4buc5deBf9MzyzaydTmQNueWtX6wLACmiv7xdNSZo7m9OSSA9vsbzwhhBQyPI1xznB9adm69krTVVl4pbinC5KXwJDaWEGH2RGYIN8p5FtAP4T0A9H/aRK074V3B3auGjeKJMzvYzf/cBzu4xNwOCFCC+SAEXxZT+HFJlavQgU5MU0AaJ+hniSeTV/4OAgSJf2SlJUyU9wSj7ORlNAb/PR+plbNYbEtZHHcCtmOQvwKFc1HOXPr79e0iBk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvCcElWbJxp2F5i+95mD5U14E3+/IxRKQdumddNKV2Q=;
 b=ZQXwlNhi0li1ngTryYEnPXUi0ejQ0upnsD97i8w3Z8mnOWdAmcDEA8FGnOTSd1aZxqrDcotH9iQMKkPN7AEE27fFVFaIYnuXqq3C+BNtwzVhWtyxj1/jTSbs0JStkxUCgMJFLBQRu8veYdKQJXWY8Nn06xqJG3xpF021kE+I81SYgBY96jryaHnr6lzGKXo6s/D3Im8YRimq2R2wF4PuNpEB6b/AUfM75P3OramJ3/CSAUEkHWo9aolz8xSMe4z/x4DhwlDUQSWpVipm+oxccjumASoqxd6s8sV6PdeWIlPq8LpC+6YrrczG5/yWqPaScomWq7f+1JuQIbXVaBn4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvCcElWbJxp2F5i+95mD5U14E3+/IxRKQdumddNKV2Q=;
 b=NKWBP4uIVXRoXNJPAAJtclNmEATSbpgx0TPZjGOd7nzC/szPAV0ZblQyOwOiwe6uHwCgtKvcpw896hHm296n5RUm7d3NGAUaZmMDPni2ENgGkr4DXSqZxVZ26kNZwwGBjgxODPSzLQ5Lspai3mMoHpz8VxSiWW8iAB7EOdd+sr0=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 01:38:18 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::d487:212c:8d0e:727]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::d487:212c:8d0e:727%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 01:38:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaVJw3fd3lG9k4w0GdiaKSDUAWyLEPbOxA
Date: Sun, 18 Feb 2024 01:38:17 +0000
Message-ID:
 <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
In-Reply-To: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9416:EE_|AS4PR04MB9715:EE_
x-ms-office365-filtering-correlation-id: a5d8faba-ce2b-44fc-4e95-08dc30224845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +LiF0L4r6S2ALhZRPKKQkLLePmrhvFpqrKThgDfQ+h0gkKIL2Cvpe48BSPEvV1Oi3LE307bh3Hseazn37ujMe5SbZ49ir1B5VwCXM8/vyMFwN+S1ZTofeEgdkEvMUhSPlafAeGSGtbYtcj8VXjTaIbjs5FBeptKJ1LGtzpBjjBpmzGJl9wer6Jd6tvhMDippnJw5XZ2fYvL/sDMz2beCsDkI3BQV7fOiwhSYqgbxKlsXijCGaoH7fGPdMw9WcxYymtcraVHvxyByP8RDnt+TLZw9VSI6Ibrei/oJeEnH6uoTKo//wC/4Hc3/Ivcpu5WWwIP1Da00I6TkZtrSkJn/nSNSOo5oGyucLP1bC2Amw4UX/BNgm3ogllM79a0rf85AL+cxrNH/PPWoctVi4aMFV2Nk1mVxpfyEyfJ/l0ki1iRleXKeu0jbrjeln+RVCQQbH9b/IHu92eDnd0eQ6fhu4s4YH1w9X1rKn2WK6aQBMGpDWnIXesjs5nKhTeLQOta+xGPEi9J0TWmuQ5JTvT7tNCmfuNdwNwoQRcCCYrjZ/Tzct4lAgihgSRA03z94eGh0CvDRYIjY+NNASPVHiM4rrviPZ9CAoQVggBKDc0obiaiZnwpLVi1Zct3fRAumzS9a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66446008)(921011)(64756008)(83380400001)(26005)(66946007)(41300700001)(316002)(8936002)(54906003)(8676002)(66476007)(52536014)(110136005)(66556008)(76116006)(4326008)(478600001)(6636002)(966005)(6506007)(7696005)(71200400001)(9686003)(33656002)(38100700002)(122000001)(86362001)(38070700009)(15650500001)(5660300002)(7416002)(55016003)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWZISVN0K3E4T0VKWk1lK216Z1g5QjVzdUVNdVhvM1loTlBlV3dVNnBUYXlz?=
 =?utf-8?B?MjZoN2cxN1RlUzh6WExPSGdPcVJpM3VWaG9QUis5UkxOQnFCWXd0RXdtL1Br?=
 =?utf-8?B?NEJVRUpQdkE5YzltRnVaZHZaUExkTEhDV1RUaFdsNTJBT3RVTmltc1NvekU2?=
 =?utf-8?B?MzBWQTJIeGZTdkJSSFlJeVlpSmFqTVNiNUY2SVE0Sk54K3ZHdTYydldVR3JB?=
 =?utf-8?B?cDM4UWJTUnJFQ0wxQTh3YnNpdzdabElTRjFWQzk0VzFqcHcySVJOSVRDOEJx?=
 =?utf-8?B?TCttTnJoeTlKMjRHK056eThyZHdIRHJWYUU2UTh1WkxDOE5OZ25uV3hoZDBY?=
 =?utf-8?B?RFMyV0tnLzRZUkdxZXIyZjM5bXJ4Sng5Ymw5VnRQTUtWT1FqVUQ5TFVYSWxz?=
 =?utf-8?B?L0wxMnhkQWVtYTlDYzQwcllidDhTbkRZOGdkTHp6U0tkb0pycGVkZkR6YmJo?=
 =?utf-8?B?azlyMEVlVDBzbHlRZmQ5UzlUaGNWb2g5ZytXQzZ4OEszMXpjS3pZUVdibEJD?=
 =?utf-8?B?czIrNE5mc0hjNkg0WEQ1OUlVZkQ2QXhSZitMNUIyMjlyb1Z5YmJIY2J6T0hS?=
 =?utf-8?B?VlVNYXB5SmhDU2U2c2NMQ3lKdDZJT2RCRU05bHVqUGdPM1JqdWFWOWpDckZI?=
 =?utf-8?B?dFpCTWdVc3BMcWcyK1ppamllQ2dwZXEvaFd1TU8weWs3UWl3c1NIVFFkQUM3?=
 =?utf-8?B?akZncnR6c3MrekVmVHRaSDhIWVhmU00zTk9yV2s3cEs3c3RLME5wMHFCbXRB?=
 =?utf-8?B?WU5IQktDSEN4NUFHdDNIZXY0aW9wTFR1b3BkV25UQ2s4eC8va3ROYStFamR6?=
 =?utf-8?B?eDNObGx1ckoyVGdINktWU0ZuQnVtVWlqMEhJL2FwZ1FFS05mVUVEamVjSVBF?=
 =?utf-8?B?SS9BRFZVRGN4dy9XSkpRNE1iUC9JVkZOL1dURXk5NCtRcWxtaWV0RzczOXl0?=
 =?utf-8?B?ekxYbkQ3UnRPQnpGdHRJTkM5TythVUdkRkdxMUYxaWJaQ3JWZUh2c3RRd0pp?=
 =?utf-8?B?N1lKRlA3ZUNTZXdaRUI2R0dkUXhTYW5CM2lvQnVNOU9zK0gxM2Q0VFNpaHlT?=
 =?utf-8?B?WkM2cVBySi8wYkZIN2hmL2FPSjU4dCtJYmc2WEVuMUpDY2o0dE9ROGV2b3JC?=
 =?utf-8?B?WHh0MXpmaVp2RHdYbEFKUEhQUXhEM1ZkMG5KTWlPWktWVTk0VGJjdkdBWlVa?=
 =?utf-8?B?N1d6TVA5Zk5ORUZYeDVoSHhoR0x3a3Q1ZDRsdDZwN1JYSlY5aE1aRUNHVmNZ?=
 =?utf-8?B?ZVZibzJjTmNjK1Nzam5RSERIY2tlOWF4V2d4UjZMbFVPMkxwaGFSRi9URHhO?=
 =?utf-8?B?bGZsWnJpaEtMMW85dHBmVDRxYkE4RWhLeWY1cktRVjkyenZpVzZWTTVtODdq?=
 =?utf-8?B?OFFUUnVFaVBrZGJqTExtL0NkMU83YVFoOXFlR3hsdks0Nks5dGsvQWdVTXJl?=
 =?utf-8?B?cWpPTlpPbWpyd2VzQ1d4YkVjdDZRekNvQWQwRklqQTJLVU1YMC96WWVYWTV2?=
 =?utf-8?B?L1J4bFI4cDJLTGVBb0VJYVhXSjIwcmRjNEJWbFM3ME9YSVJWdlZ3U1ppNGFz?=
 =?utf-8?B?Tk11ejJ2MzdDbUFtMXNjZUZuWmlnVlNBT0txOTg3TXRwSHRzTkRRaTJWZVQ2?=
 =?utf-8?B?ZnpscHZwRHhZb1VPUDVxSXIwV21DOEI3N01RUEwxWHJ5YUkxZlJRRjdtM1Fs?=
 =?utf-8?B?WVVQR0hCd0F2RjdEem5QdTBSRVRRbHEzMEVxdXpvc3c3c1lsazFhR0RZa1JZ?=
 =?utf-8?B?Rkt3SXY1bjR2c0RnQm5LNDdwVFF4Qi9LTXFGSi96bkJ4anFHZ3I0VUFYZEcv?=
 =?utf-8?B?Y0I1Wlo1dmw3Q2FsVmNicW9oaHo0SzcwZzZ3L2dPc1pzL2hObG43VHJXVnNS?=
 =?utf-8?B?bVkvcEVWOUI3empCUjQwVS9Pa2Nsak5SNkpwa3R4dWR6b1JiaTl3S0toOXQ3?=
 =?utf-8?B?KytoM29VN3JNb2huN2NnTjB1MGxzN08wQmhhVEZuY0pDeWFLTlRKNXRJMk1l?=
 =?utf-8?B?R0JMd0NGOFF2d0xSeDVIK25KeDVveFNLTzZLTzA0aWQ1Zlp3QUh1aWFJb0xD?=
 =?utf-8?B?N3YybE90aUFYT0cyaE82MTlheFRtT1VZQUlPaEtmWis4cFB4ZnZtYUt1QU9E?=
 =?utf-8?Q?Bhxw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d8faba-ce2b-44fc-4e95-08dc30224845
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 01:38:17.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8omFP0qoLpuk+OAS5xCtLRnfdwBxrAyzFIOB4Yp10gahiw+hpY/yVbd0GDqXuEuSsVGsw86x8fwygakIG2/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715

SGkgSmFzc2kNCg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjYgMC80XSBtYWlsYm94OiBpbXg6IHN1cHBv
cnQgaS5NWDk1IEVMRS9WMlggTVUNCj4gDQo+IC0gQWRkIGR0LWJpbmRpbmdzDQo+IC0gaS5NWDk1
IEVMRS9WMlggdXNlIHNhbWUgcmVnaXN0ZXIgbGF5b3V0IGFzIGkuTVg4VUxQIFM0IE1VLCBidXQN
Cj4gICB0aGUgVFIvUlIgbnVtIGlzIGRpZmZlcmVudC4gVG8gbWFrZSBjb2RlIHJldXNhYmxlIGFu
ZCBub3QgYWRkIHRvbyBtdWNoDQo+ICAgbWFjcm9zLCBhZGQgcnVudGltZSBkZXRlY3QgbnVtYmVy
IG9mIFRSIGFuZCBSUiBieSByZWFkaW5nIFBBUl9PRkYNCj4gICByZWdpc3RlcnMuDQo+IC0gQWRk
IGkuTVg5NSBFTEUvVjJYIE1VIGVudHJ5IGluIGRyaXZlcg0KDQpQaW5nLi4NCg0KVGhhbmtzLA0K
UGVuZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY2Og0KPiAtIERyb3Agbm9kZSBsYWJlbHMgYW5kIGFkZCBD
b25vcidzIFItYg0KPiAtIExpbmsgdG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NDAxMjYtaW14LW1haWxib3gtdjUtMC0NCj4gN2ZmM2EzZDUzNTI5QG54cC5jb20NCj4gDQo+IENo
YW5nZXMgaW4gdjU6DQo+IC0gUGVyIENvbm9yLCBhZGQgcmVzdHJpY3Rpb24gdG8gc3JhbSBwcm9w
ZXJ0eS4NCj4gLSBTaW5jZSBpLk1YOTUgTVUgaGFzIFNSQU0sIHdlIG1heSBub3Qgc2VlIGl0IGlz
IGNvbXBhdGlibGUgd2l0aCBpLk1YOFVMUA0KPiBNVSwgc28gZHJvcCB0aGUgZmFsbGJhY2sgY29t
cGF0aWJsZQ0KPiAtIEFkZCBSLWIgZm9yIHBhdGNoIDImMw0KPiAtIExpbmsgdG8gdjQ6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjUtaW14LW1haWxib3gtdjQtMC0NCj4gODAwYmU1
MzgzYzIwQG54cC5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gQWRkcmVzcyBkdC1iaW5k
aW5nIGNvbW1lbnRzIGluIFYyIGZyb20gS3J6eXN6dG9mDQo+IC0gTGluayB0byB2MzogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDEyMy1pbXgtbWFpbGJveC12My0wLQ0KPiBlZDkzMjk0
NWUwYmZAbnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBGb2xsb3dpbmcgZHRzIGNv
ZGluZyBzdHlsZSBQZXIgS3J6eXN6dG9mDQo+IC0gQWRkIHJldHVybiB0eXBlIGZvciBpbml0IGZ1
bmN0aW9uLCBwYXRjaCAyIGlzIG5ldw0KPiAtIENoZWNrIHJldHVybiB2YWx1ZSB3aGVuIHRyL3Jy
IGlzIGxhcmdlciB0aGFuIDQgYW5kIHJldHVybiBlcnJvci4NCj4gLSBMaW5rIHRvIHYyOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTIyLWlteC1tYWlsYm94LXYyLTAtDQo+IDdiM2M4
MDMzM2I5MkBueHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFN1cHBvcnQgc3JhbSBw
cm9wZXJ0eSBhbmQgYWRkIGV4YW1wbGUNCj4gLSBQb3B1bGF0ZSB0aGUgc3JhbSBub2RlIGluIGRy
aXZlcg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjIt
aW14LW1haWxib3gtdjEtMC0NCj4gODE0MTNmNjU1MjEwQG54cC5jb20NCj4gDQo+IC0tLQ0KPiBQ
ZW5nIEZhbiAoNCk6DQo+ICAgICAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBmc2wsbXU6IGFkZCBp
Lk1YOTUgR2VuZXJpYy9FTEUvVjJYIE1VIGNvbXBhdGlibGUNCj4gICAgICAgbWFpbGJveDogaW14
OiBzdXBwb3J0IHJldHVybiB2YWx1ZSBvZiBpbml0DQo+ICAgICAgIG1haWxib3g6IGlteDogZ2V0
IFJSL1RSIHJlZ2lzdGVycyBudW0gZnJvbSBQYXJhbWV0ZXIgcmVnaXN0ZXINCj4gICAgICAgbWFp
bGJveDogaW14OiBzdXBwb3J0IGkuTVg5NSBFTEUvVjJYIE1VDQo+IA0KPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWFpbGJveC9mc2wsbXUueWFtbCAgICAgICAgfCA1OCArKysrKysrKysrKysr
LQ0KPiAgZHJpdmVycy9tYWlsYm94L2lteC1tYWlsYm94LmMgICAgICAgICAgICAgICAgICAgICAg
fCA4OCArKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNl
cnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBhZDVjNjBk
NjYwMTZlNTQ0YzUxZWQ5ODYzNWE3NDA3M2Y3NjFmNDVkDQo+IGNoYW5nZS1pZDogMjAyNDAxMjIt
aW14LW1haWxib3gtMjQzMDIxZDEyMDMwDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=

