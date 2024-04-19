Return-Path: <linux-kernel+bounces-151110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DE8AA937
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0DD1F21BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC947F6C;
	Fri, 19 Apr 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="b86tHLWj"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2074.outbound.protection.outlook.com [40.92.73.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313013EA68;
	Fri, 19 Apr 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511861; cv=fail; b=DUJ7zRhTCVpep0CGFCzf3w5M4zkFUlFYAHhBMcW8xSryUj5a5F3NkkHthLrlv2Gj4+00WuRGDfOdTnIfrouftKu9uVFbyp5qHu0oTJYfKvitrO+O0Z6ddp5aKpq7JIaKl/aFIgP9U9aTdRixwBgdQDDBOSeOlx9gIVBC7S6XZHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511861; c=relaxed/simple;
	bh=DSb9ntBSXR/qhX2KpyB+jd678GHd59I20cXtfUP7xRw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CQNCvtNmwLwpcnEX0xL9+mXCcn5Ij4p7SReQV3aYdo/CFNjuhpUpKGkBrBkidlxb/By2JuaPEr3NzydaIZ+2t3ThMHkpJip3tjC6O6Pgi+bHq5IW5EVVWxgeFlx3bTZPo2HeLeTOULyoMpLnFUVLxcaboGyIZL2llIEEGrxI2ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=b86tHLWj; arc=fail smtp.client-ip=40.92.73.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIpLFVlFVPB9yJ0jmGvetx0C02+p0v+0FHb1+KDDh4qNckR1bt9ryCkH9GEDmpjbK/fwqljy5s1u2EbbF4wfJxrPefCaK9x1x/oEOTwCPRxjSzTRkCKog048jEM3VRO80B0+V2AMhCuffBiBTdEvIVCsVwxWUcD6y9qj+bm8VsFFXieVJ4J4LAUYHMwv7Jo8aHtLFahUFUVTJgbV2kuyrs3LOinTY8e0AQNhUEY2sb6UGSfFB/domWDge0ElzRI6ZjLS4wTKcThrnNNglHKfTpT5UFxPAN9jiWkgEqaLhjkJQEfY1KCyGalrwEN7abaIf36m5PGfXJAIohie4W/v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ColtRm0WwPJhSjy8qJwx4v9yKzCuLUZ/PyKxhCl784=;
 b=I4vv7keuL7CIl6EU0xcuUWgZMxrF+hlPouWeckKfFuxbdlnuQWEclUlu5ftJHh/2NY1Xzu6x9cXbrOTJ4BlT6mK95F8g9IpUuKZfFcRQG+JRDiBqwR/9Uplh6jv0uVZUwt0irCg8ldGLcU6wx/Y9AiRtTl2nGlFUqvH5Y1lsBneVXlRfTssdqEHUDSQ15g1XRATiROqZi6L8+cDrlD5tJhbZsxERNXw9LFwbY2yODWGA3qLq5M/U5B4mXXU9MspjRH8AUpgL0X7R5jw6022VA1eKYDc0VO+Xo8c+6/uakS2FNslfsw03UY0jyTsv2DdMPGNKme8pibAZjwgDbx1mFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ColtRm0WwPJhSjy8qJwx4v9yKzCuLUZ/PyKxhCl784=;
 b=b86tHLWjXBliaYCMa3yXIttQRqzoJRTFgTNLVL6Piz28UcV7UNGrbQAJ3/XxL4R2sG2ho7mvMznBz2srHPk4b8jKirQu45X09Pnrka7/XJ8NTDk6j1pkEkThetzKNwrkBa1aitj79I7uTa8AQOeoQzhZrlIu3YrPlHmX/Eg88D6bgSwBF7mcWDFAPaMheTiF1HS0h+MWMPUWav8/mzSz7d4Ipqsu/JLU52jOe/Yn8h5Hy3x6z6+md1oGXNqtHzFmKCcbsWe3ZyEhP8WUIuYUt5PjhickgtKjkflnJYmavu3umux5FE6MbTr/IjddoiiJwxNaJEKf8/pciTVAPvmVNA==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by PA2PR09MB7348.eurprd09.prod.outlook.com (2603:10a6:102:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Fri, 19 Apr
 2024 07:30:56 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%7]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 07:30:56 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>, "mgreer@animalcreek.com"
	<mgreer@animalcreek.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 rx-gain-reduction option
Thread-Topic: [PATCH 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 rx-gain-reduction option
Thread-Index: AQHakEwHBYi4skvpo0K1SXdVsQmKiLFscReAgALmTgA=
Date: Fri, 19 Apr 2024 07:30:56 +0000
Message-ID: <acf1679f-4ee8-4b87-a793-0160affc4b64@live.nl>
References: <cover.1713305374.git.paul_geurts@live.nl>
 <AM0PR09MB267553535F7A85EA639D739C95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <150d467e-3ea6-40fb-8ddf-21d678b150d1@kernel.org>
In-Reply-To: <150d467e-3ea6-40fb-8ddf-21d678b150d1@kernel.org>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-imapappendstamp: AM0PR09MB4274.eurprd09.prod.outlook.com
 (15.20.7495.000)
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [01Dwau3YQaWIGTHqRyN89BtVJ6vKc6V8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR09MB2675:EE_|PA2PR09MB7348:EE_
x-ms-office365-filtering-correlation-id: 91cbe567-b362-4891-0463-08dc6042a6db
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0K/3peregY4YEdQdNe9ngoOBu+7+eAzYPvmDJA3i2QzUioBb0Wwxy89xthRoqLlKRaC2Zwz9+0yDLNagi7D+8o/3FLWRABk7A9bCMCFXKoHoaMtywTsgu6o0XSvLNeMQ52WAcIfIbClR9kHWeXo+vpTceyFtwJUV8wQslTxBV7l9emSIEliwLwefwvujFsMvFvYne5JG92bwDQ1zQLheI5S4pHfyXTsDsyXo8o5wSvnIye+e2Y4fgNaSkHKIxSf1Be/3jODMU96IG7b5287BzaEdwKjUZIqto6003JAHlo7PmJeOdY0olbEA4owig1qhGX6ITD3apVSHs+XkTEY08GZx3YGDbfQ46/0qk4mzo19p6hCpMtAR0rz/8XmTAKD6QPDJxaH5g5brVbSSiYILDhKfhFmeN+in0nmVWUGSAZ9TQZu0oWa9UmOtYYdrFQ2xyNKnbIrwupc2GB0jkOyPy/IQtxGUp0HlC5QKldyzXiJKbBZU5KuE1ATKFxrm2cSVAQqV9UT+vMw5MUPle2GqmwppCcLOP6yRTKUtnftNPaRVb9rRWNKLA5vLAgsH0WO0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+LlyY4gUffArP6P0FyYmsxqX4azd/Ums0aw7cKoFXk0CsMSrDY9vU4Qr0U?=
 =?iso-8859-1?Q?GCuj3DL2dSShK0XTxKzGeeJz+vGIH+Zb7QlaDqvMqaKe5Z6aIX2FKl4g62?=
 =?iso-8859-1?Q?+pynkhy1FsGDzV6bFz6vmdzgryti4Gdzfh9tiEuHz7MIegONUoA3lj+Nis?=
 =?iso-8859-1?Q?6riUtaMS2xlRH/BQnE8b2CoRuHbNW0bcYQ64jGi+3hRQHSQHNltJTLEULP?=
 =?iso-8859-1?Q?0t01/NqYYoEyaTwvz4FPzMjHTqIyH+K78ORRsg1pnSmtK+bTnyGgOpzWYj?=
 =?iso-8859-1?Q?UuUmkEG8VQWC5xgKXCqMvDOVy3DJBrxkZVDG7or6pJs3Bk5ynEjw7dX76e?=
 =?iso-8859-1?Q?/dyqLzlFURuoKeGcs7jxoKJbmgpD2oY1Pu3PcYsZ0WaryokDCGYGay29XR?=
 =?iso-8859-1?Q?fbodg8xaJGaFRlZW5Z4uLqTzetiMB1AYA7kduHXfTj1zyKVK/6UoRBxe5c?=
 =?iso-8859-1?Q?i3TjlA3SB6lR1d+XXQN1x9S/YuQ5ostcjF1RqyM9xCubG0pnzA6BOC++aZ?=
 =?iso-8859-1?Q?ZGhbyiH6LK06+XPSKiyXbfLRzxuaKz/nPjnMUBLooWkcfFPj1aP/5oFO4m?=
 =?iso-8859-1?Q?OFBIqHeUeY8981TNN4k6UMrDIBpOWfIhbCJZ0ztxsSoNibqUdbC1V4Bttu?=
 =?iso-8859-1?Q?QmFMbz5tX7jFpvdk6/O+4+qMWvmYZBI6oW7YnMMtoAkAmbza012BxAYm1a?=
 =?iso-8859-1?Q?mqElTbWRq84d0zwb6G3S4YcUgUZ0VT0ZKMQ2+SBgYiaa5bukEenIEkPBR2?=
 =?iso-8859-1?Q?pnUlb1BWe1dw9WzweFhqlDJE2A/oxo1wC6HEX3B66hX9HDm028JXxX0Yaf?=
 =?iso-8859-1?Q?BF6kRBzBji3S0KT+coGwXhdV08s2whsClryR9hw8u7Kz9US8/MNuCwP6hr?=
 =?iso-8859-1?Q?idj0afXBEsmqpDU9nM+AmqabaS39ws814hnS0K31FTR0/UoWoFIM8LTeDa?=
 =?iso-8859-1?Q?ZAUP/VwYqqTVbGOQrAcP0fjrJoFiJaAETX0K80HH8655ifLz4ss0npCTlT?=
 =?iso-8859-1?Q?LknQef892qB1EcqnH/o/zETfZEmLGAHsrH3zuiXMxF8QsHmHjis+2PX6x5?=
 =?iso-8859-1?Q?ljpSYaGi29rfM3KZyUKgKx3miMg4zJt00TPfmC2kn67W3ZLDn93aF83lJ+?=
 =?iso-8859-1?Q?1pipNdRE8oAMzdEGC7Dnz13BOvDracOytQRU5W3zaRd4Q8iwn2h00zQZIP?=
 =?iso-8859-1?Q?MXEeWlX2yQZLz7R/mK9ik5sVYfocxJ4eoGR5YLJvxdZZQ5eBNXwCiJA4t2?=
 =?iso-8859-1?Q?ti1rAz+4sPjARfjKw1Dw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID:
 <4C962CEB9739EC4B8D4647A1CF8EB094@sct-15-20-4755-11-msonline-outlook-64da6.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cbe567-b362-4891-0463-08dc6042a6db
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 07:30:56.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7348

On 17-04-2024 15:12, Krzysztof Kozlowski wrote:=0A=
> On 17/04/2024 00:18, Paul Geurts wrote:=0A=
>> Add option to reduce the RX antenna gain to be able to reduce the=0A=
>> sensitivity.=0A=
>>=0A=
>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>=0A=
>> ---=0A=
>>  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 6 ++++++=
=0A=
>>  1 file changed, 6 insertions(+)=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml =
b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml=0A=
>> index d0332eb76ad2..bbd045f6cf04 100644=0A=
>> --- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml=0A=
>> +++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml=0A=
>> @@ -55,6 +55,11 @@ properties:=0A=
>>      description: |=0A=
>>        Regulator for supply voltage to VIN pin=0A=
>>  =0A=
>> +  rx-gain-reduction:=0A=
> Missing vendor prefix.=0A=
>=0A=
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0A=
>> +    description: |=0A=
> Do not need '|' unless you need to preserve formatting.=0A=
>=0A=
>> +      Specify a RX gain reduction to reduce antenna sensitivity.=0A=
> Reduction by what? What are the units?=0A=
=0A=
Yes, this is a bit unclear indeed. Will clarify this.=0A=
=0A=
>=0A=
>=0A=
> Best regards,=0A=
> Krzysztof=0A=
=0A=
Thanks!=0A=
=0A=
br,=0A=
=0A=
Paul=0A=
=0A=

