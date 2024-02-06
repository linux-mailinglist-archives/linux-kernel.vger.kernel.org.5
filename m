Return-Path: <linux-kernel+bounces-55135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19784B838
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE191C22B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D1131E56;
	Tue,  6 Feb 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="QFw7gm6n"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2097.outbound.protection.outlook.com [40.107.7.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F286111BD;
	Tue,  6 Feb 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230669; cv=fail; b=SCGAQ6cCmHvwo4/i0ugUj6FvT9qK5TY0O818/13c/7dDlCTZYazl7jzTZK3WXW5k8VcLi3YF3XuXVWXyRXwP5KLVldfBMvkPwlbfB9AqUivvMRW5RNMp8rT6B/GNDQZanJVd/iyydynHy57soKoteENeAo3inNMp94bR0E4ziJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230669; c=relaxed/simple;
	bh=mDSDypxzFB256feKX9HU6LARcVPkcS7LUFpjR74vw78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SrKONEXNCDSL6a5etXuPb/Ayu8q21Dd77TMoM3QldOumTCj0gMEaW1FLTX4cmS4Qoo+jOSAxrLMSVbSvRW8G1Pe3/6eMxNYBw2BRjBiiSkXFHVbENdnPu8oqpnsrSLkGG+B+qDwJ1kV7VPbyvZb1qZDh9GHgnx3oyf7hkNueeyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=QFw7gm6n; arc=fail smtp.client-ip=40.107.7.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJHe5clFQaLRi0Lz6ZrU2+EMFhF+K756ixohtZdNgq9EzokWMY7ZEIaIROVGRL5hElYQpFL7x0TDMp5yB0RStO+UD7q1fqC+JnojCgBcr7eisrD8aSs9FyzhgO7tYLSluPimV6dZwbDruu3dTRDN28rxNfeSX4d6oU6gfbmJFCqhkBKTtDZI5cwQFhk87H9y3b5T9BEZD8oD9qZsIqXyH5O+dY682SOPC0jCAv1SczC7RlSik4qqtPOJ6lG+1vlnzECH4yXidvfXjr6Q1QJJDGfkjjcpHXJOofJNm4zHVsm7F4FXIZnxEIsOJeFZ6cL/WaC4yAnTjNaiHrpjkkAfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDSDypxzFB256feKX9HU6LARcVPkcS7LUFpjR74vw78=;
 b=UAu5/evyKaAIDJhPDV5gezxF3PEUYIrZVdEvPZkRn3cxLPdYjwdz/gIBS1pTeqWhzYB+oH0C5izvH6ZlUdwzAJKpxt5+Q1GaNp2sSNZFuQVIL4Z2dIEkiS9rT8aWbNCtefuR7s17Up10LpwYWD92gFj5iA0UCApOaFB2uHHhlL+UhpOqc8GSVKs4CZV9P0MQgJm1YQWTdvOl6H8E3vgNchMQ8wsOEgQORAk7lAhqLFRKAu4vaLlrSR13qY231wt0BqXY4dtG9ACPrTkKIRbwQW9HRqZT1lcH9vliJyUVPaeCI9Mln0MEm5GF4nkErZbbNZkoCZOK9cauQcbijdp/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDSDypxzFB256feKX9HU6LARcVPkcS7LUFpjR74vw78=;
 b=QFw7gm6niG2u5IiWWBS2UDc7IV6kIw/0618Obni2/ClqThXA5nXbcduG/rBZt+901M/j+LiWo6v4rHzwqK0o3cRjxN3Tvmd1152ZSViPn62B/OmErjOyRfW1BrPLKbeGGf4RrYXksSC0M+/D1hYFT/XLkDxtXenE+3IImFWcTVY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 14:44:24 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 14:44:24 +0000
From: Josua Mayer <josua@solid-run.com>
To: Conor Dooley <conor@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Topic: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Index: AQHaVfJlZfbrK8KniEiJ3e3MRZt0PbD4ue+AgAAAhACABK+cAA==
Date: Tue, 6 Feb 2024 14:44:24 +0000
Message-ID: <0c784113-9288-46bd-a34e-49bf0f1651bb@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
 <20240203-prolonged-backfield-c659e0016d70@spud>
 <20240203-tummy-egomaniac-5aba55889a83@spud>
In-Reply-To: <20240203-tummy-egomaniac-5aba55889a83@spud>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB8174:EE_
x-ms-office365-filtering-correlation-id: 863f0093-df23-44d0-0446-08dc27221cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tmyfvAO+AgcBWPg/uD4+kFdWxiCHW7S5SeYJa82jBV1mgkbM91q2tn+ViivRkIBMB2oxyp3YDQzoBvM8O4BnQ5Q2JTkVyztr1mZzXxO/Z0sS64tsp33+Scvc5bqvyXJ0HF5+nqJDffMIGeVOC6WOUdS0lwooHDUMAiL5VLTvxiUa7UcxSunJC0wXaJ+fhp4jzaBkRbDW3OKypIAofnSZ3mPiPoDI6bkA7wAfpFdWccOFQO9C8NAZq5GDoH2dVDNnIe1QQhFR22Ub01WWMebdJhsTLQaTQ+Z6q47E9WpoMncbKajU7ZjHkY+NHlUy9nS4RANLMs6yrfIKtzEWmkd3J++wcHqb0J/jE3DB2cY3QY9Ep6K6usn4Fq/F7BPXXbdJIf7fjRIG0jFuKdzj/y7C4HrXuO6gXdCcsgIIbnviR/a7Sh7tUnhWnvisI3ZuXKL1iBCmSRhx3QZELFf/ERA+ZcZXxdz4WZdYxbqubogqgfWB2MMpi4YZ+x/WlXPgOeFXd/owPbRw7ChTIkJIAAACQxiwMvU/F9c5HGrIr7nmZKILGiu8y8pR32xY8F9CpdOGLp8JcgoVEaoac4BzpahuAsmE35roPPFHplCrsUd2eEJAcb+f6eBZdJrzuSk6LxdU47GxuV4JcGb1AquknT5ktw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(2906002)(83380400001)(38100700002)(122000001)(66899024)(41300700001)(26005)(38070700009)(91956017)(6916009)(54906003)(66476007)(66946007)(64756008)(66446008)(66556008)(316002)(76116006)(31696002)(7416002)(86362001)(4326008)(8676002)(8936002)(2616005)(6506007)(6512007)(71200400001)(5660300002)(966005)(6486002)(36756003)(478600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzUzWUtJYnpqRnFlNHNEUWYvalBCa1hXSXI4djM0RkpUT0pqK3hmVEhOYVBB?=
 =?utf-8?B?WlBUUlkzRENvK2FvTjVBZUVvWW1QMWJsSUhkYlZ0TW8yR1NnMDI5QXJGRGpZ?=
 =?utf-8?B?WGhlREMwSU1Rd0xTdEZ5bERrcFNXNFgrZWZvZnJmb1U5cGdqQUtuS2pVYi9n?=
 =?utf-8?B?aURVRkxzMXdyb0Y5eTU1ajFyenhHVGJJUXVoNjNHL1pwYzlOWmcrdmt4NlZI?=
 =?utf-8?B?T0ZsRW1TWUJVWnhBVy9ZeE95WlRZQlh1UTRpNVkybG1FMmIzS1hwTlNLSy9G?=
 =?utf-8?B?OHlRZXpVQ0lDdkVjL0Q1Rml0cy92Qi9KRUNVQktad0FyaEtueEJiSEZSWWFP?=
 =?utf-8?B?S1V5NmJSQy9kOHFqUmtKcFJzT29MK09PMVdNRi9lMUZHK3FqRXVvR21HNHdW?=
 =?utf-8?B?T0hqN3VXYk1VMGtJOUxaMXE3bTVUT0ROaTFFMDI0QllxS0dMU3JFNWFyQU5j?=
 =?utf-8?B?M2Qxb25wWnd2d05vZW02TlowdEFxTGtHeCs1Vnp1QXpHSEcxWVN2K0p0cHRB?=
 =?utf-8?B?ajRWVTM1UzJMRGE1ejlhdEYvbGZWZ1lmT1lKL0xEblJ5NUphYVVMMVc2d3Ry?=
 =?utf-8?B?YUtlVEpLZUJ3THI2YUJrcVd3VjVWNnd1VDh2M1B2L3BzeEtnQ0NNbVZQYmpk?=
 =?utf-8?B?QUdJUWh0aDJtNzQ2TEhqVkZlbDIvbW01WCs0Q2NVdVBnTC9aVjNqQkZvcHdI?=
 =?utf-8?B?SzlpVVh1bzZmNWt5V25IWHFxQUdwditIY2srekhIQS9lcERoMUU0OVZQTlFT?=
 =?utf-8?B?RndRa0IveW5aaE1GQUJLZ0t3dk0rL0NzRFdLa0plVW80MTBYQ1NFUWxPVDJ0?=
 =?utf-8?B?bXJYNmtlOVdxL1hjd09EYkdGRGR6WllNRTRhSHJBazVUbXMySklvL1pjT01z?=
 =?utf-8?B?YnZRZDJFNHkrUitJWEg5cys0TG5XZ1RQQXE5dEN2a1VzYlJYWVZ1dGdUY1NR?=
 =?utf-8?B?RXp2UnhzeUhOUXN0UHV2V3lVbTdjV3NpK0lleXNqeXRxbTY2bWdNR1lXc0JM?=
 =?utf-8?B?YVg4SnJ4OVFPTnZmSS9pUk1jMm8wRE8vNDhCR2VaZFZTdmZqYkVnK3RaSm54?=
 =?utf-8?B?MW9kTUtRZ05pQ3JJNnp1OXc2dUVvdHdPRnJnTXY1enpjNS8rZ1FMbkpzazZt?=
 =?utf-8?B?b21yVXBRSjF0YWV3VzdmbFQ5ckdYWnY4SW50U3lrMEdVSDE4VjVSUFJtbWhu?=
 =?utf-8?B?Z1FNOS9NcXBERHZPNjd5U1lESG81QXdXRCtBK3ZHMlFIL2hwZk1xYlFzSmpT?=
 =?utf-8?B?YUxCK1dyVmRtY0xJbkNmWmNjU21mR2FDNTFjYmlGU1k0SERIckg4aDdyK1Zl?=
 =?utf-8?B?NWh4UzV1akJMOEE3MUNjWThkZ2U2SHBYOXFpWnc3YWkrZnBScEFpSlZWTXRJ?=
 =?utf-8?B?RlRnSEVTQWNISS9YaXNlSVZWc2pLNlVEa1B6bUxpS3pwTUoyZ0hRcGNFMjhp?=
 =?utf-8?B?a0VVU1JVanFQejdCUi81bk92UUpxU045MW5yajdhWWQ1UitCQ0l5Q09ZR2Mr?=
 =?utf-8?B?SHJaMHRUS28vb2grSHViQ3RUdFB4NmM3Ly9UbUtISDVqbU9TcVRsUE9qdy9C?=
 =?utf-8?B?Zk90dDVvK09JSy9oZStDU0tkNFhRcll2ekZ2d2twdTJ4Q2xNb00zUXNmZHZM?=
 =?utf-8?B?M1hpbDFRUXVYOVdwSGp3MllGVnQvVDEwNEtzWkVJS2ZldG5EeE5DWExsNmlx?=
 =?utf-8?B?dCs5bElQaEdRSzFHeHI0UW5rQTJMTnNjK3pwb2tFa3JybC96SHRmOUhYNzQ4?=
 =?utf-8?B?SUtaMnpGNkF3enVUK25HbkNqUFBjUHRCZEZDT0hvUmxNVGg2clhlTEMxdG16?=
 =?utf-8?B?WWFDNlhsL0lJbjQ2VmJuWlZlZFdXK3hYUEZtU3Z1cDVKb1ZxRFZ6d3BJSnVO?=
 =?utf-8?B?dVR5TFQyK2tNU1l6S0ZXcFJOV2twRjJrRmxYOWRQMVh6ci9jMkVoMThDV1Zt?=
 =?utf-8?B?eCtya3VlZmpOMEZNcHc3U1ZmVGJGUTViOStBV2NySnRPZ3F0am1tRjVLY2lj?=
 =?utf-8?B?akx0YUVqQUF4NlZhVHBhYW5RaHBTUEM5YjZSU0U4SE1JWmFGMC9WNGlPc2d4?=
 =?utf-8?B?U25wbXhRaFdzNW5RQ2lMMGMyeVQ2eHZXOC94WDRoczZWQUpMSkRKSUp1N0tG?=
 =?utf-8?Q?Hp+AHQRDd7Z540f5Owcmi2bMz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C356698160807D4A9C7400413D041802@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 863f0093-df23-44d0-0446-08dc27221cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 14:44:24.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjfdXXmcDMHlbAH4PqLGWsMBqeJXsnzh/LtA8dZbSPOSqrLA9F0jXUktavI2+yhdylUf3ttEerP3QGotQPi5YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

QW0gMDMuMDIuMjQgdW0gMTY6MTAgc2NocmllYiBDb25vciBEb29sZXk6DQo+IE9uIFNhdCwgRmVi
IDAzLCAyMDI0IGF0IDAzOjA4OjU5UE0gKzAwMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEhl
eSwNCj4+DQo+PiBPbiBGcmksIEZlYiAwMiwgMjAyNCBhdCAwNToxMDo0OVBNICswMTAwLCBKb3N1
YSBNYXllciB3cm90ZToNCj4+PiBDb252ZXJ0IHRoZSBhYnJhY29uIGFieDgweCBydGMgdGV4dCBi
aW5kaW5ncyB0byBkdC1zY2hlbWEgZm9ybWF0Lg0KPj4+DQo+Pj4gSW4gYWRkaXRpb24gdG8gdGhl
IHRleHQgZGVzY3JpcHRpb24gcmVmZXJlbmNlIGdlbmVyaWMgaW50ZXJydXB0cw0KPj4+IHByb3Bl
cnRpZXMgYW5kIGFkZCBhbiBleGFtcGxlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEg
TWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4gLS0tDQo+Pj4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3J0Yy9hYnJhY29uLGFieDgweC50eHQgICAgIHwgMzEgLS0tLS0tLS0tDQo+Pj4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hYnJhY29uLGFieDgweC55YW1sICAgIHwgNzQg
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlv
bnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWJyYWNvbixhYng4MHgudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hYnJhY29uLGFieDgweC50eHQNCj4+PiBkZWxl
dGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAyNDA1ZTM1YTFiYzAuLjAwMDAwMDAwMDAw
MA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWJyYWNv
bixhYng4MHgudHh0DQo+Pj4gKysrIC9kZXYvbnVsbA0KPj4+IEBAIC0xLDMxICswLDAgQEANCj4+
PiAtQWJyYWNvbiBBQlg4MFggSTJDIHVsdHJhIGxvdyBwb3dlciBSVEMvQWxhcm0gY2hpcA0KPj4+
IC0NCj4+PiAtVGhlIEFicmFjb24gQUJYODBYIGZhbWlseSBjb25zaXN0IG9mIHRoZSBhYjA4MDEs
IGFiMDgwMywgYWIwODA0LCBhYjA4MDUsIGFiMTgwMSwNCj4+PiAtYWIxODAzLCBhYjE4MDQgYW5k
IGFiMTgwNS4gVGhlIGFiMDgwNSBpcyB0aGUgc3VwZXJzZXQgb2YgYWIwODB4IGFuZCB0aGUgYWIx
ODA1DQo+Pj4gLWlzIHRoZSBzdXBlcnNldCBvZiBhYjE4MHguDQo+Pj4gLQ0KPj4+IC1SZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KPj4+IC0NCj4+PiAtIC0gImNvbXBhdGlibGUiOiBzaG91bGQgb25lIG9m
Og0KPj4+IC0gICAgICAgICJhYnJhY29uLGFieDgweCINCj4+PiAtICAgICAgICAiYWJyYWNvbixh
YjA4MDEiDQo+Pj4gLSAgICAgICAgImFicmFjb24sYWIwODAzIg0KPj4+IC0gICAgICAgICJhYnJh
Y29uLGFiMDgwNCINCj4+PiAtICAgICAgICAiYWJyYWNvbixhYjA4MDUiDQo+Pj4gLSAgICAgICAg
ImFicmFjb24sYWIxODAxIg0KPj4+IC0gICAgICAgICJhYnJhY29uLGFiMTgwMyINCj4+PiAtICAg
ICAgICAiYWJyYWNvbixhYjE4MDQiDQo+Pj4gLSAgICAgICAgImFicmFjb24sYWIxODA1Ig0KPj4+
IC0gICAgICAgICJtaWNyb2NyeXN0YWwscnYxODA1Ig0KPj4+IC0JVXNpbmcgImFicmFjb24sYWJ4
ODB4IiB3aWxsIGVuYWJsZSBjaGlwIGF1dG9kZXRlY3Rpb24uDQo+Pj4gLSAtICJyZWciOiBJMkMg
YnVzIGFkZHJlc3Mgb2YgdGhlIGRldmljZQ0KPj4+IC0NCj4+PiAtT3B0aW9uYWwgcHJvcGVydGll
czoNCj4+PiAtDQo+Pj4gLVRoZSBhYng4MDQgYW5kIGFieDgwNSBoYXZlIGEgdHJpY2tsZSBjaGFy
Z2VyIHRoYXQgaXMgYWJsZSB0byBjaGFyZ2UgdGhlDQo+Pj4gLWNvbm5lY3RlZCBiYXR0ZXJ5IG9y
IHN1cGVyY2FwLiBCb3RoIHRoZSBmb2xsb3dpbmcgcHJvcGVydGllcyBoYXZlIHRvIGJlIGRlZmlu
ZWQNCj4+PiAtYW5kIHZhbGlkIHRvIGVuYWJsZSBjaGFyZ2luZzoNCj4+PiAtDQo+Pj4gLSAtICJh
YnJhY29uLHRjLWRpb2RlIjogc2hvdWxkIGJlICJzdGFuZGFyZCIgKDAuNlYpIG9yICJzY2hvdHRr
eSIgKDAuM1YpDQo+Pj4gLSAtICJhYnJhY29uLHRjLXJlc2lzdG9yIjogc2hvdWxkIGJlIDwwPiwg
PDM+LCA8Nj4gb3IgPDExPi4gMCBkaXNhYmxlcyB0aGUgb3V0cHV0DQo+Pj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmVzaXN0b3IsIHRoZSBvdGhlciB2YWx1ZXMgYXJlIGluIGtPaG0uDQo+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYWJy
YWNvbixhYng4MHgueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMv
YWJyYWNvbixhYng4MHgueWFtbA0KPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi40MDViMzg2YTU0YjANCj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hYnJhY29uLGFieDgweC55YW1s
DQo+Pj4gQEAgLTAsMCArMSw3NCBAQA0KPj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+PiArJVlBTUwgMS4yDQo+Pj4gKy0tLQ0K
Pj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3J0Yy9hYnJhY29uLGFieDgw
eC55YW1sIw0KPj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2NvcmUueWFtbCMNCj4+PiArDQo+Pj4gK3RpdGxlOiBBYnJhY29uIEFCWDgwWCBJMkMgdWx0cmEg
bG93IHBvd2VyIFJUQy9BbGFybSBjaGlwDQo+Pj4gKw0KPj4+ICttYWludGFpbmVyczoNCj4+PiAr
ICAtIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+PiBJZGVhbGx5IHlvdSBwdXQgc29tZW9u
ZSBoZXJlLCBub3QgdGhlIERUIGxpc3QuIFVzdWFsbHkgdGhlIG9yaWdpbmFsDQo+PiBhdXRob3Ig
aXMgYSBnb29kIGNob2ljZSwgd2hpY2ggSSB0aGluayBoYXBwZW5zIHRvIGJlIHRoZSBzdWJzeXN0
ZW0NCj4+IG1haW50YWluZXIuLi4gRmFpbGluZyB0aGF0LCB0aGUgcnRjIHN1YnN5c3RlbSBsaXN0
IGlzIGxpa2VseSBhIGJldHRlcg0KPj4gY2hvaWNlIHRoYW4gdGhlIERUIG9uZS4NCj4+DQo+Pj4g
Kw0KPj4+ICthbGxPZjoNCj4+PiArICAtICRyZWY6IHJ0Yy55YW1sIw0KPj4+ICsgIC0gJHJlZjog
L3NjaGVtYXMvaW50ZXJydXB0cy55YW1sIw0KSSB3YXMgaW50ZW50aW9uYWxseSBsb29raW5nIGZv
ciBzb21lIGZlZWRiYWNrIG9uIHRoaXMgaWRlYSwNCmZvciBzb2x2aW5nIGR0YnNfY2hlY2sgY29t
cGxhaW50cyBmb3IgYm90aCBpbnRlcnJ1cHRzIGFuZA0KaW50ZXJydXB0LXBhcmVudCBwcm9wZXJ0
aWVzOg0KDQphcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLWh1bW1pbmdib2FyZC10LmR0
YjogcnRjQDY5Og0KVW5ldmFsdWF0ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdpbnRl
cnJ1cHQtcGFyZW50JywgJ2ludGVycnVwdHMnIHdlcmUgdW5leHBlY3RlZCkNCsKgwqDCoMKgwqDC
oMKgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9ydGMvYWJy
YWNvbixhYng4MHgueWFtbCMNCg0KPiBBaGggSSBub3cgcmVhbGlzZSB3aGF0IHlvdXIgaW50ZW50
IHdhcyBoZXJlLiBBbGwgeW91IG5lZWQgdG8gZG8gaXMgYWRkDQo+IHwgaW50ZXJydXB0czoNCj4g
fCAgIG1heEl0ZW1zOiAxDQo+IHRvIHlvdXIgYmluZGluZyBhbmQgaXQgc2hvdWxkIGRvIHdoYXQg
eW91J3JlIGxvb2tpbmcgZm9yLg0KDQpZZXMsIHRoYXQgaXMgaW4gbGluZSB3aXRoIGV2ZXJ5dGhp
bmcgZWxzZS4NCg0KV2hhdCBidWdzIG1lIGlzIHdoYXQgdG8gZG8gYWJvdXQgaW50ZXJydXB0LXBh
cmVudCwNCmFuZCB3aGV0aGVyIHRvIGluY2x1ZGUgaXQgaW4gZXhhbXBsZS4NCg0K

