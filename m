Return-Path: <linux-kernel+bounces-137904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B1189E93F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36A01C230E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D3168DC;
	Wed, 10 Apr 2024 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="fiD1xHns"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB966101CF;
	Wed, 10 Apr 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724877; cv=fail; b=NwQrohbnk6fukinpw45PoPElr1eLASk27bvWhso6efcZ8EW6Vrstf79MelpnrbDqxP+edxpKGdsARMJRu/gGs9Qld1lvlwRmnnEKK+R6escZMyy0CV/G6ndn3N2TAwvhmvKqEVcQwguWxaC0fjpBi+tIZsI3tO70D4dmy9KX4Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724877; c=relaxed/simple;
	bh=yAecOh7cN5NBus7bfQbmaoBmFSBW049aAnd763+cMQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iswubu9HKtpXn7fEcb2mZN6CSN9G+fLOs+u6DhL2t+H8cRZAkkbCKKkNbB05LkMauSlMfYT4YNeXsY0Gwq/LpTFcNY9HkZLtKfdQVH7ezP0KBh53apXliVkPJtNBfGjFcAZT0ghbX7cAWHxR4T03BmZRZSQrlTVz9nMh8h6UD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=fiD1xHns; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm4jeEhnwkSR2c4ZEFFQXM/M7tEkrnogkCttf4Rf5nmkciuKGc/rQY631e3RynZD+ooMonOmP3aswf1SRDu1lAj1+SHPgYtvuaVZzWvqoSkyKCDFgd6F0E+LGATT4uW84/fKN9rSYYFXlbIJ3AT1nrXFZthu+a8++bJ+1m1juzMUUH2vt0xxZKhSHi35HnP4gDGgeZIVo+FDEpd3JH3HtQXNmlMCWeXBWmZKplevkktBEj+g9LGKNYYEUaSRYW+Bdb52vx1T5S+5YPOwOd9IgHxR/fbxvej6XppU+S8h54yaOO3xKlJ/XAKt2TngUfSklCsCV5LvDOUiD1yhRS9s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAecOh7cN5NBus7bfQbmaoBmFSBW049aAnd763+cMQk=;
 b=Dw5oMqMNVKDvzA+UqJrXVzxjxqs9/msPCimwmHP7GoREbPz/AajL40byhdFYi5bMPy2MAD7lEhMRmg+MjuG7eQnwc3/9c7UOntcCXKVVBjnatjGOaoJbIE8AKjWKnB7SWO5jLcaDNSaGBE36XE+a+OUQ7s9cM1bz5WvJeThrOhEFN9M+YpikE5A1hjZJntKYB711rh0cYT8HikJA9ERPwt7AqUJtRjcoMJGR8aCGS+IteQfiYqgxEom4ykg5wmdRcSVRBFAimnarDFhPrVkx+RFbhuaGsjABZumq3y2S284LGsgzCmjlANxMyNYM+OvnwfEkZfKfju7/4DU+Kk3iIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAecOh7cN5NBus7bfQbmaoBmFSBW049aAnd763+cMQk=;
 b=fiD1xHnstdMVoJMyhnG/kjFG3YWi2BtOgCNpApOatVBnH3E9kE3sD45MnymD3WF04fkkrfM4CbHKb/3wUv3N22HXmDc2CqYhSAogi3nAOO5b1wKPyvvK+UXjev+8h8e2nK2ONKPlJesVi4XnuORbHBsD/lbpZ0jIXaKEjPTHtZ1CJjE9U7/ywVwnI1uqcKY7V4qxB8bg9y8uo3GljWcyHGJF2QQS1Xb7A9vklmIOLB97KPYrDx8XrA3r2tiA7g6q99wq7nIsfn/22yfWixk07VAJGXhgnQ3baLM/RVHB3MDfCjm5WtOCeudTyIffxyz9mNYYAf2OW3zyJSNampa+Sg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3084.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 04:54:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 04:54:31 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Qiang Zhao <qiang.zhao@nxp.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Steffen
 Trumtrar <s.trumtrar@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Roy Pledge <roy.pledge@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Scott Wood <oss@buserror.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sean Anderson
	<sean.anderson@seco.com>
Subject: Re: [RESEND PATCH net v4 1/2] soc: fsl: qbman: Always disable
 interrupts when taking cgr_lock
Thread-Topic: [RESEND PATCH net v4 1/2] soc: fsl: qbman: Always disable
 interrupts when taking cgr_lock
Thread-Index: AQHaYCubjcVZXHC2JE29sDLam0ymSLER0LwAgE91RAA=
Date: Wed, 10 Apr 2024 04:54:31 +0000
Message-ID: <e0e1518c-9319-4af9-9b7d-3eb985f2e6da@csgroup.eu>
References: <20240215162327.3663092-1-sean.anderson@seco.com>
 <20240219153016.ntltc76bphwrv6hn@skbuf>
In-Reply-To: <20240219153016.ntltc76bphwrv6hn@skbuf>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3084:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vPwPWAmRc1qMg301xViaqi/y8SuzRm+O9+zwCnmuhmhMBCktza2WfqDbKtnPnSRHGLi1DwpSz7F9rOuvhORK90XVSF1FrAAL1iCUYedrwlixJ7f4Dgr4pl4crXlyuQonuP2cpF22IKtMZS1deRXkl5WgLAFQu/4FczJdRvPzLyJC+veXll9PIZb2uE0JzzGaTlACQbAp069VjkK8ZENg6xNmViKrsvVnbF1JT8Pe0Z2aS7QEx4WdX02XppfbTGpxfKlEOgumUasLJezIzU5ymxy/HlVkkfX9DhmOtMFA5JSHrgUwt2VarN27vQdWJmNZHswJrPkKNyl8PMP9xwaWN+VU3DYjWZTKW/vXTeylDHMOz5EBzrTH+/J21zLlemTxdj2KpE8X+IH6wgqwshh7Idu5JX68AVWE/wN5yyDEpQ0Pd2Twu70Zo3HsQBk8Bmq5G9qHG5/Zds0ZVqHAeAPEYDtAK8Fgxl2BvHqGGjYw5abYxXwUXFWEZoFIFjcas02RupQbWyA+ke2D4KgGQGfHQC8o4S+cpNDYuA5VR8bxAIXOME4byFhS8SlN3DwtIsCE+lEu6BCVibm7maZKFWB/OQ4fu5rbL7lh47MuDoaqQ6RH4YOJfZaHmSZF9MfFgDpMcD6UdB7yhe5kJ8t/cgihqkq7ClGyRLAr0yoMUua9YVc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnMrN1YvSkFiMTI5KzJzemMwY2Y4SFRGNmZWUHY3RWJXSHlMa0lrTUUvb3Vh?=
 =?utf-8?B?b2J4NUNjODBIUzRFQTFhRVJ1eVdpa0UvNlJpbGNRMklNdGN3U0FUS2Z2ck1K?=
 =?utf-8?B?NVd4dFBxdEpyKzl0bVlQRU5qZEtwMXJmRy9CSW92eFVCTWxBUW1waHhZMjB6?=
 =?utf-8?B?b0x0OW1wTlFqQVNZMElnTVFXREE2U1F4L2xTejZ1OTAvaTRxak4zN1NDY1pj?=
 =?utf-8?B?ODl6WEtLN3NvQk55Z2FQTytGSUZuZnRUVmEwSkhVNTB6alAzQWw1VGI0b2lH?=
 =?utf-8?B?ait4c0FxZ1dYaVc2M1ZjYVZna1Y4N2Y0NHdzUnN0UGF1VWhvb2ZHNkRIanFX?=
 =?utf-8?B?bU5kVkVXMnQvTkFxdW9ZWjdtWjNBR3Rpc1ZyckczZEtPdDc2MHNUOFlvc3R1?=
 =?utf-8?B?ck9kR3FGZ1lCeXpKdFRYNmFueTZRUGV3eEVzbmdrMkJQZ1Z5ZjhPVVJnTktp?=
 =?utf-8?B?dklOTGVzK2ZLVy9xNHpFdzNtaWpmVmp5cUUyWGhab2p0U3Q1ZUppcFMvUURN?=
 =?utf-8?B?QWJCQlJWd3I3T1dueXhNcnZicWhiQlY0UnNOdU8vSmZHY1JJOThQRVNBMmgz?=
 =?utf-8?B?UlhjM1BHd0RCWDZOSUJURVl2UDhDT0UwVGJ0SU9xMXczRTI3dW1JNFBXZmcr?=
 =?utf-8?B?dklTbWxoZlJZa3dQZVp4U1JNRUMvOTM5WXA2S041RVpVRTgySjl1YTNoeDcv?=
 =?utf-8?B?S2xXdExZMTBBNUlZVDFWcWhoaEpIVG9mRXNDTzdxY2J3ZkhOQk45RmcxMlZH?=
 =?utf-8?B?c3RLN0l4aC9nR2pSRWtucTNaOVkzdWlDWld1bEJqL1hISGpoMFhPcENpOGJp?=
 =?utf-8?B?OUw0a2dzTVFJRHZYbnEyNksxZEQxR0hKM3dLTHJmMFNGbFJjeW1pTnU2LzNl?=
 =?utf-8?B?QWZTY3FrekJHZGNTS3V1Z2ZWY1JGSHlSK3ZPSVNucU9wbmk4L1ZhMnFKZkgy?=
 =?utf-8?B?UzVoM1hDQS9ONHE1ZXhSNzMxYm8rSG9qZlQ5M042Rng3UDlLZGZ2cnczZzR4?=
 =?utf-8?B?eXpQU2srMTAvR2l0dVRhanZWVHpmR0x4QmlnRVVqNVJ1SmpUeVN4WTQ5THNW?=
 =?utf-8?B?NjJWNUxnRStsUjhQZllKTUpwek1ESmd3cHlSVnRuTC9FRE5KMnhUQmdzc0h5?=
 =?utf-8?B?UW4wVW5xemdQTzZPL21OUk0vRnRRT3RUdFBvaHQxNFdJRitFTldwaXk4anE1?=
 =?utf-8?B?Tk05Y3Y4ZlZqM2RHY3liNFpGVWloOEdwZXhEUWVNVlpQYXlHV2o4WkdQL1Bt?=
 =?utf-8?B?dG5GUVk2ellVZVJOZnpmejV2YWUwc2JSSDJMWXBZck1aTDZoSjRIOUdCLzFY?=
 =?utf-8?B?cWFyeHJhcTc5Tk5NVE53R1NvV0FDUnArVUV3aFhIRHk5VllkWkd0SEJINXRW?=
 =?utf-8?B?SWszUTJJQzFmcVdlcVdKV1JmVVFQamgxNkRhRWcrRVZWWFNZbGJlTmNOVzFa?=
 =?utf-8?B?MEhGL0VycDF2ZFUvamxyN2RPRlJIOXJVV0FBaUdwR3YwZEJybmQ1blpyRVBp?=
 =?utf-8?B?K3Ira2tvZllzM014ZlZlUTZhcXJnTjRlcWtxVXVSVzlmeDVONE5SVlQrcFdu?=
 =?utf-8?B?d3d1aVc5ZVRxUS9HNWhwT0N4b2MyS015Zi9EaDBVd0NibmNpRDBBZjYrSXF3?=
 =?utf-8?B?WmpDbkI5Tk95SEQ2VDl1YzlMdUdNK0tGZTU1MzBORmVUVWd2Vi9mb2dOVmlL?=
 =?utf-8?B?VDMvaWEzN2xUNWlWMkExVENSZXcyVDc1MDY1cEthNHhRNFE3cnhadzRqMGIx?=
 =?utf-8?B?UXJ5S1FwYnMwc1l2VERhQVRubGZUdHRmRGxlMHQ1eWNCd1V1OFpqdGN1UmpN?=
 =?utf-8?B?VFZRREVwQlNqNzNBYWg1eHo3Tm1EVGJqKzhPRXBGaEVjd1ZzNVNyL0krSGYw?=
 =?utf-8?B?eVVXbnEwRFdvUEdPc2xnZ1BMMThPSGtoYTA4bWY2eHphYXN5NnYybnF3cThr?=
 =?utf-8?B?YmlzRG5CSjBnM3VlWEUxa3d5c3g0cjgvS0FJRWRWaGNYWm91K0ZLcklvMFVz?=
 =?utf-8?B?ZWJESmg5MjFLamxtYzRzaC9zNm8wbDJIR2x6cWhMVXpudkpqbkNNelZyeVMz?=
 =?utf-8?B?OUNBbE8vVUpsd3hiL0xSV2puRDVaajFTK2Ftd1NSOFR6SGRBTnF3aTJxOGth?=
 =?utf-8?B?MFo3MHBjMkZrdkxIZytZMnZIRXlCeDJnc01KTkwwZko0cFBGMXJjVGxDMkd1?=
 =?utf-8?Q?RlbzGgKNECsD686Mz+2uu2pbmSqZW7SQvGtey23sUl5P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33E73981F15FC04FAA6DF934700D8EDD@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e560a9a3-e5c7-4f3f-378a-08dc591a4f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 04:54:31.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjvXYKqWDLbCkeuj9VLOrxZaLM1npr72+Y1ojzeXN9LWPclSmEABO5fe8hKNW1obk5KcsUZC+PH175HRtzXhPNPcXICwJ3z0OHmHXJ94W9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3084

SGkgVmxhZGltaXIsDQoNCkxlIDE5LzAyLzIwMjQgw6AgMTY6MzAsIFZsYWRpbWlyIE9sdGVhbiBh
IMOpY3JpdMKgOg0KPiBIaSBTZWFuLA0KPiANCj4gT24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMTE6
MjM6MjZBTSAtMDUwMCwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IHNtcF9jYWxsX2Z1bmN0aW9u
X3NpbmdsZSBkaXNhYmxlcyBJUlFzIHdoZW4gZXhlY3V0aW5nIHRoZSBjYWxsYmFjay4gVG8NCj4+
IHByZXZlbnQgZGVhZGxvY2tzLCB3ZSBtdXN0IGRpc2FibGUgSVJRcyB3aGVuIHRha2luZyBjZ3Jf
bG9jayBlbHNld2hlcmUuDQo+PiBUaGlzIGlzIGFscmVhZHkgZG9uZSBieSBxbWFuX3VwZGF0ZV9j
Z3IgYW5kIHFtYW5fZGVsZXRlX2NncjsgZml4IHRoZQ0KPj4gb3RoZXIgbG9ja2Vycy4NCj4+DQo+
PiBGaXhlczogOTZmNDEzZjQ3Njc3ICgic29jL2ZzbC9xYm1hbjogZml4IGlzc3VlIGluIHFtYW5f
ZGVsZXRlX2Nncl9zYWZlKCkiKQ0KPj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNp
Z25lZC1vZmYtYnk6IFNlYW4gQW5kZXJzb24gPHNlYW4uYW5kZXJzb25Ac2Vjby5jb20+DQo+PiBS
ZXZpZXdlZC1ieTogQ2FtZWxpYSBHcm96YSA8Y2FtZWxpYS5ncm96YUBueHAuY29tPg0KPj4gVGVz
dGVkLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPj4gLS0t
DQo+PiBJIGdvdCBubyByZXNwb25zZSB0aGUgZmlyc3QgdGltZSBJIHNlbnQgdGhpcywgc28gSSBh
bSByZXNlbmRpbmcgdG8gbmV0Lg0KPj4gVGhpcyBpc3N1ZSB3YXMgaW50cm9kdWNlZCBpbiBhIHNl
cmllcyB3aGljaCB3ZW50IHRocm91Z2ggbmV0LCBzbyBJIGhvcGUNCj4+IGl0IG1ha2VzIHNlbnNl
IHRvIHRha2UgaXQgdmlhIG5ldC4NCj4+DQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYXJtLWtlcm5lbC8yMDI0MDEwODE2MTkwNC4yODY1MDkzLTEtc2Vhbi5hbmRlcnNvbkBz
ZWNvLmNvbS8NCj4+DQo+PiAobm8gY2hhbmdlcyBzaW5jZSB2MykNCj4+DQo+PiBDaGFuZ2VzIGlu
IHYzOg0KPj4gLSBDaGFuZ2UgYmxhbWVkIGNvbW1pdCB0byBzb21ldGhpbmcgbW9yZSBhcHByb3By
aWF0ZQ0KPj4NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIEZpeCBvbmUgYWRkaXRpb25hbCBjYWxs
IHRvIHNwaW5fdW5sb2NrDQo+IA0KPiBMZW8gTGkgKExpIFlhbmcpIGlzIG5vIGxvbmdlciB3aXRo
IE5YUC4gVW50aWwgd2UgZmlndXJlIG91dCB3aXRoaW4gTlhQDQo+IGhvdyB0byBjb250aW51ZSB3
aXRoIHRoZSBtYWludGFpbmVyc2hpcCBvZiBkcml2ZXJzL3NvYy9mc2wvLCB5ZXMsIHBsZWFzZQ0K
PiBjb250aW51ZSB0byBzdWJtaXQgdGhpcyBzZXJpZXMgdG8gJ25ldCcuIEkgd291bGQgYWxzbyBs
aWtlIHRvIHBvaW50DQo+IG91dCB0byBBcm5kIHRoYXQgdGhpcyBpcyB0aGUgY2FzZS4NCj4gDQo+
IEFybmQsIGEgbGFyZ2UgcG9ydGlvbiBvZiBkcml2ZXJzL3NvYy9mc2wvIGlzIG5ldHdvcmtpbmct
cmVsYXRlZA0KPiAoZHBpbywgcWJtYW4pLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIHRyYW5zZmVy
IHRoZSBtYWludGFpbmVyc2hpcA0KPiBvZiB0aGVzZSB1bmRlciB0aGUgcmVzcGVjdGl2ZSBuZXR3
b3JraW5nIGRyaXZlcnMsIHRvIHNpbXBsaWZ5IHRoZQ0KPiBwcm9jZWR1cmVzPw0KDQpJIHNlZSBG
UkVFU0NBTEUgUVVJQ0MgRU5HSU5FIExJQlJBUlkgKGRyaXZlcnMvc29jL2ZzbC9xZS8pIGlzIG1h
aW50YWluZWQgDQpieSBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+IGJ1dCBJIGNhbid0
IGZpbmQgYW55IG1haWwgZnJvbSBoaW0gaW4gDQp0aGUgcGFzdCA0IHllYXJzIGluIGxpbnV4cHBj
LWRldiBsaXN0LCBhbmQgZXZlcnl0aW1lIEkgd2FudGVkIHRvIHN1Ym1pdCANCnNvbWV0aGluZyBJ
IG9ubHkgZ290IHJlc3BvbnNlcyBmcm9tIExlbyBMeS4NCg0KVGhlIGxhc3QgY29tbWl0IGhlIHJl
dmlld2VkIGlzIDY2MWVhMjVlNTMxOSAoInNvYzogZnNsOiBxZTogUmVwbGFjZSANCm9uZS1lbGVt
ZW50IGFycmF5IGFuZCB1c2Ugc3RydWN0X3NpemUoKSBoZWxwZXIiKSwgaXQgd2FzIGluIE1heSAy
MDIwLg0KDQpJcyBoZSBzdGlsbCB3b3JraW5nIGF0IE5YUCBhbmQgYWN0aXZlbHkgbWFpbnRhaW5p
bmcgdGhhdCBsaWJyYXJ5ID8gDQpLZWVwaW5nIHRoaXMgcGFydCBtYWludGFpbmVkIGlzIHZpdGFs
IGZvciBtZSBhcyB0aGlzIFNPQyBpcyBlbWJlZGRlZCBpbiANCnRoZSB0d28gcG93ZXJwYyBwbGF0
Zm9ybSBJIG1haW50YWluICg4eHggYW5kIDgzeHgpLg0KDQpJZiBRaWFuZyBaaGFvIGlzIG5vdCBh
YmxlIHRvIGFjdGl2YWx5IG1haW50YWluIHRoYXQgU09DIGFueW1vcmUsIEkgDQp2b2xvbnRlZXIg
dG8gbWFpbnRhaW4gaXQuDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0K

