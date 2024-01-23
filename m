Return-Path: <linux-kernel+bounces-35317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DF838F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ABC28DA64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BEE5FDB4;
	Tue, 23 Jan 2024 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ItfW6MYr"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7C5FDA5;
	Tue, 23 Jan 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015297; cv=fail; b=a/6VoTZ+Cc4x1nsnk9fx5Si6UfMA/cQ2uOEcfhAJ4jiUNCu96OR/vjKoutp+8n/fUIJOs8m3oPiI+x6gbBW7y6S/GINnmRoZUc+u3XyZMMcCjVA1a4Nmi2+ZXwaL1IQajQ2ctpTCKqKV7SqUXGDOVN383EU9+jS9zxYRTj5Lrio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015297; c=relaxed/simple;
	bh=z/aBn5ysllnGVxSV7iDO+h7yh0fOrrICSm8wwje8gsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LspuZcYWSWfGRcAALoylriTsmsTAlUeCX9BmWKUEwOFHeNeNbnnJg6yCnHwCSQwBhkhcqHSxpToj6xUFQzGMXB3oJ0PQyHipaS9QPbJG2evTVPjlkSGmB2FDFblaotIrstELjAQxxuWc/XJ2F5wOTulcIdB7DZ8eN3l+0QX3fjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ItfW6MYr; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bF5M5GeJ715N9sLtnNI5VOMJk5YvMn0UR2ckG5hHV8RMfmPN8Ej2UoZixbG9cNmeUcp0UPAwqqbdHWmlAqYQsLJnxLYD2Cx0IW4E802CyOSoKGEMbInL5DcZJVZfhdiXgZMO6sQ7a4mRn0oJg7Xh29jVV2/fKAYL4SRM1xr7LKivJajhy0BmhyI9sprpbTAEPAZjUwpxpqP/ufCA29yfe+1vi3VDqQnDfFitItQurslN3Qlte4RCuxUPaXqvYLp3p5h4DMRGygQ7i4vYUvULftibSX8xw24jcU+S93BSgzXvkn6zTds3rW+SCRTYkWXf+jlR+Iq1edX9fwKud864lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/aBn5ysllnGVxSV7iDO+h7yh0fOrrICSm8wwje8gsc=;
 b=nFlWkt35y8U06fI/xsIhQFFqBd0EcdSI64A343FWqkKrVfvhjhshipa1/oMBN+1kvoOuOMomTT7HGO7hX59h7YN1hbhDR5DuecahDJW2hDgX+lEAFG/KJmB8gDOdlAKSaXMTig/NTqiAsAbxoN5zeIfUeCcIegkLijCNdARKTIXPK7rurQv4zR0sIWj/Gx4I2u3PGyrSIvCZo80lpqegzGSqU/tVAKBQZUjkEjimKQrg3VPQDdnkphAgzfhh2GFQAlP/nUQyZApVaqIcB+Krv8xfRzQ+VQ1aG78CI1BQu5qyuJYjGfsqq5pAe17aJVriTwDf8SZcwYwDSGno/IX1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/aBn5ysllnGVxSV7iDO+h7yh0fOrrICSm8wwje8gsc=;
 b=ItfW6MYrxkGNaEKfO6CvYkq0+lyaBqpBwHpSuYO/QyIjuSXZqW1L2dH084XhQFJJZ1nqGNytlbPSLHXppsB8CCKSQodW+Yuw8UbklrEeb9GY2VgSmAHNPchOlxq55ibKV37kJThwBS69sVEVMb8txZg1Gde+A/d6QtyWWWY6ZT8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7059.eurprd04.prod.outlook.com (2603:10a6:208:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 13:08:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 13:08:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Topic: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Index: AQHaTF7dbf3fZzQpTkKKhWtWHavxlrDlm5UAgAHFORA=
Date: Tue, 23 Jan 2024 13:08:11 +0000
Message-ID:
 <DU0PR04MB9417A8F4230D2C7C76D1550988742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121114623.1418597-1-peng.fan@oss.nxp.com>
 <273a80a7-2a60-4490-9c3c-c33dc14be9e7@linaro.org>
In-Reply-To: <273a80a7-2a60-4490-9c3c-c33dc14be9e7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7059:EE_
x-ms-office365-filtering-correlation-id: 49697bb9-2e5b-4eeb-041e-08dc1c145a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4S5Uj0xQe44T9LnM2N7uJ3BgMIVkcETp6EPz+7QgiBnGkBwnCNSQoKdj+qVsZiioDkcq1UojVkAa6RnNEfKcP3Uns/toQ5HU8dZrvKndzx7Jhd8c8iTJdUB4zLQ3y5ro+U7kjehe4uz5DSYmlsdLh3dnfvX925seVp7ShKg3g52jywVCwQ6e+glDDgk3bnGFiMlVtS2xxQwmEF2lbRJlx5CJta+Vght0Lv06T8F/JjWMTBx9I/TxiII2c6q1vZBKtZo9T+FgbtTfL9FuVJYk8VpgjBq5y7J5cYR5Qp6WbqvrUOB5ELE/FZWYxKFV36/LeqyZIWiYk9Hd6pH8bxoww6bt9waAKbBUjIFpdXsXi8i/nfpm9pg0irjj8ORYQAyfuSJGtnxePoDdpkRZZoCyVhVKDrp5/Rsm3HPYM5FkJZv81Muve9i9ElQHohMb43HzeO9c3oyZEefzhxfsw/2l0vX9M58JLYe6U6/ikP7KvFqM9AFM8xu6RQM6/QW7uyF8ahvnvHJaWPi7/QDL//gyVknJByzfZT7ZDXcxSIg/kHXWpzhXEFmfudL9CJEfadkzQ9Svpe/754R5b4ebK6UE5MwnkggpE3zfsTwA8LPlb3e9gxehtR6EYFH3JzZPv0R24pODQBmb/idIi61rb4UZZQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(55016003)(44832011)(8936002)(52536014)(8676002)(122000001)(4326008)(83380400001)(38070700009)(6506007)(7696005)(921011)(2906002)(9686003)(41300700001)(4744005)(7416002)(26005)(38100700002)(53546011)(5660300002)(86362001)(71200400001)(33656002)(110136005)(478600001)(54906003)(64756008)(66446008)(66556008)(76116006)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWR0V3UxUFZrOWdzNmF2bUxEWjM0aVluQlkzcXNJa2NKb0RyWE9GajZBOEVp?=
 =?utf-8?B?ckhucXJZbDVzdTM3QWZKKzZyZWFtRngyUGFOYTJEaDVOclpMMktWZjZjRlIy?=
 =?utf-8?B?ODFzSXoxZDhoa205Zy9mL1pIN0h5VGVvMG1CUjJkOUxpdTh5Q25TTjZzRWt2?=
 =?utf-8?B?NEZNaG12ZllVZk5razZ5UUNGYmhWNTAzbHpMSFZ6OVMvbkhmOUJtcENTQ0po?=
 =?utf-8?B?UDRCU2lGWFBzMzdCS3Flc1ZFUmIzWGF1ZXZDb295Wko1cVViSDd2VTU1M1gz?=
 =?utf-8?B?RmJ0MlFzRGU2MU5YV0FxQ2kyY3V1MjJFcmo0Y0F3eVNOWHFITmVjRFdjUTlF?=
 =?utf-8?B?Uld5SmdBTEJHcG1kYkZUY21kV1lxSFcvZkN2cnNQVnRzMGM1R0cwaTNBR1Z3?=
 =?utf-8?B?OHJIT0hHTUhFM1pGVkhiV3lzU3RhRlpYbnlvS3orNC95eEEraWIvZUk1MlQw?=
 =?utf-8?B?YS9RaTZjbVN6NEdLZlFBZk1oems2eW9ZVnZiSGVuT0h3UjZ1SiswYmdhUWcy?=
 =?utf-8?B?NUpKYmo1dWFJU1hMU25BNzY3RUJoSUV6NVFYb01rVThkRm9jaGFQTERBcm5Y?=
 =?utf-8?B?UmlCTFhDZjlpSW8xZTJRNFROcTdRT2lxL3JJcVZXeGdmcmZuTlIzd2g1R2ZN?=
 =?utf-8?B?NTJvTGFFRlJ5UWpVdklnOW5mN2gzTFd5Qk1HYTB6UGVlN09ua0crTDB6MW1R?=
 =?utf-8?B?RStHQ29ESktCRUVyRDVjODJpT2JldVEybW5tZ0ErMUxXTGZ6dVp0UytJNmdF?=
 =?utf-8?B?c2RCdjkrZEJ4OE1YUHdmWktqaVB4UGVEZUxtQW1JdE5nOWxzdDVaLzRHUEd6?=
 =?utf-8?B?MXhPMmZMNzJsZmpRMzgyTUVCVjVmN0daU2ZhL0NnVUVhVXJRbk90aTVCcjJz?=
 =?utf-8?B?ODdGUExWeFhIQXFRSE55UGJDTEYzbm41T2hJSllTOS83MTBydkhCYm5nQTZy?=
 =?utf-8?B?Q0lxNnB4TE10YWZ6aTBQeHAwMnM5Rkt5aDZHVyttVjZBZEM1WkwrWTBOSWlk?=
 =?utf-8?B?SzVia2NOdUIySmZFZmpQODgyU2lHRDFTZVBCZlVtMlR2TEV0cTNoMjNHeit6?=
 =?utf-8?B?eGw2dzhuTmYzZzFTeG1YcElINThmV3UwaHdRcWdFdXFaQnBmRWJsdHRwMTR6?=
 =?utf-8?B?bTB3WWZuK2ZDRXdZTTdVRzJ3VUcwRzIvc2R6VXZ4TEFHQnZ1b3Q3K0UwdHBw?=
 =?utf-8?B?bmNoV29IYmlYc2xNMzMwUThBczREU1NWaXlqdlMwM1B4M3VJQThZckNyNDFy?=
 =?utf-8?B?Z2hyMWw4c0w3K0JuSWNWeDZaWURBL2htRktsVGtUS0VZOWFyRHdOeStSRUNY?=
 =?utf-8?B?TVRXQkZBT1MydGFCRERHQXJXVlIyeTdPckFnVWg3ZmovWDg2SHlpcVNjZGJa?=
 =?utf-8?B?QW5JNHFpQTZQalh2NVFJcWRsWVE5NmhVN3dlZkNsMXJDOEJGc09kQ3dKdWZr?=
 =?utf-8?B?THdraVBDUm5jL0xIdFo3NnJNVU14WkVzbkJBNUxHbWR1OGM0UUE0WU9vUjdw?=
 =?utf-8?B?b3RBN2pDaW5NK2N5WnpMNlJRQVA4OWNNbGNkUkRySHViTWYxK2tLN2xSMFRZ?=
 =?utf-8?B?VUxCWUxjalBGZlBiejU2dUIrbmpTbkFHbElDU2pGN01WSjNzVlNaMGdEUDFt?=
 =?utf-8?B?bEg2ZmFsZm56eHQ5WG9iQUlrZG9hcFQvK0xBWEdhYVkrbjJYUjV0WFVKQXBW?=
 =?utf-8?B?WkhNSTR0Ty9zbmFBM0hsUjVZcGwwaHU5dEJrYjlRRzB4Vi9GZnN1VzB5OHcr?=
 =?utf-8?B?N1c2N014MEd1cVZYOG82ZFZaTEFobFlOdWZNS1VmaHBaMmVZZTBpM0tNUXhJ?=
 =?utf-8?B?dCtEQWk1MjFZRWJzRGZwUC9oS3JZWUNtcHlaU0YzYjExR3puVDN4Z3I0M2tS?=
 =?utf-8?B?eVFVNEc1ZGhtUk0yRzZ6RUJtWWxZQ0RFSG1ESlAwYnFGOEVXSHBGcmw5ZWpD?=
 =?utf-8?B?S2tqclUySmFKTVUxcjZYRzc5N29jNnFoRGVkTHdsaHhYZFluZ0hhUnh4QzRS?=
 =?utf-8?B?dUZqaS9CK3FxamxycDNIZTNBcXEveStJQklYOFhBN1h6cGpLbDNZdVhGMzEx?=
 =?utf-8?B?ZG5WSUMwU01mUjZaVXNjL2JEYzBDQTBWMnB1Vm1NVGx4R0hTUTRVemdlVHlD?=
 =?utf-8?Q?ZE6I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49697bb9-2e5b-4eeb-041e-08dc1c145a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 13:08:11.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0I9ZOCsoqLG0Dbe4QJOUJ3h4CKYjXXgnrz5TGETqqYLaPpE+M9mH+oM5eB2IC3bRrwnI5giaBeBBxgfXuhEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7059

SGkgQ29ub3IsIEtyenlzenRvZg0KDQpJIHJlcGxpZWQgeW91IGJvdGggaGVyZS4NCg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogY2xvY2s6IHN1cHBvcnQgTlhQIGkuTVg5NQ0K
PiANCj4gT24gMjEvMDEvMjAyNCAxMjo0NiwgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4gRnJv
bTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgaS5NWDk1IGNsb2Nr
IGR0LWJpbmRpbmcgaGVhZGVyIGZpbGUNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gVGhpcyBzaG91bGQgYmUgc3F1YXNoZWQgd2l0aCBy
ZXNwZWN0aXZlIGJpbmRpbmcgcGF0Y2guDQoNCmkuTVg5NSB1c2UgU0NNSSBmaXJtd2FyZSwgdGhl
IFNDUCBwcm9jZXNzb3IgaGFuZGxlcw0KY2xvY2svcG93ZXIvcGlubXV4L3Jlc2V0L3BlcmZvcm1h
bmNlIGFuZCBldGMuDQoNCkkganVzdCBhZGQgdGhlIGluZGV4IHRoYXQgU0NNSSBleHBvcnRzLCBh
bmQgTGludXgvVUJvb3QNCndpbGwgdXNlIHRoZSBpbmRleCBhbmQgZ28gdGhyb3VnaCBTQ01JIHRv
IGRvIHJlYWwgSFcNCmNvbmZpZ3VyYXRpb24uDQoNCkluIHN1Y2ggY2FzZSwgc2hvdWxkIEkgc3Rp
bGwgYWRkIEhXIGluZm9ybWF0aW9uIGluDQphIHlhbWwgYmluZGluZyBkb2M/IEkgYW0gbm90IHN1
cmUgd2hhdCBzaG91bGQgYmUgYWRkZWQNCmlmIHllcy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiAN
Cj4gPiArDQo+ID4gKyNkZWZpbmUgSU1YOTVfQ0NNX05VTV9DTEtfU1JDICAgICAgICAgICAgICAg
NDENCj4gDQo+IERyb3AuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

