Return-Path: <linux-kernel+bounces-96018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E16875625
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1DC287BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD2B133408;
	Thu,  7 Mar 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5fZIcz0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92F12F5B4;
	Thu,  7 Mar 2024 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836403; cv=fail; b=njziwSeq24s27Vk2r63adzue0zDKzIwBISqyCg6vKo8UzN/dqtNQpsT4YZjfgEgU/w7wnjOoLYEn3mqR4DVcaIY0XWnMssUVEN55LYEd8Te8vCNjzawSX6mPqMyvSResagtZLzRO3aNJbEgVXqcRkJg0y10uyaxmLhuABLTlhn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836403; c=relaxed/simple;
	bh=RSQk/bcUebF8pqSeFvcaFRr8hFnmGCWKhOv9VYfmYx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jbap+ZIvK9YNWfavTp4hsa/X51v75OE/S8PxgfI54Dp2R8h1ndjoF8oAGgR3MyEW3YBlF8EX26wO8ZTWEzCqlZrYdZOBrXnxUSUT3evoW9WXvKDbRPdLWY0nt8srl507ligY+oJleGzqKyjQc3A+cebFB1QmBBkDRUMdMRTUHsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k5fZIcz0; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QInVZ/n8SzjU22y3rndpzZaK5EHvLYux99icP61QStKrCW8rRft17hIWXLZm/I0XlSFUIBz/M5G2A3i1S2aLpvCg+JZAJwcWUILSdRko6LQS1YQU7/B+nMk+dvFe0BshQpc8s8A3tF8yN2DpwsWlC0HFZucKr1zQLdh2CHmlqVDFqtMzhOGQMdYVI3ftIV6un8tIB6nK/xMBeVyUGN8MN9a7Ln3rRzAQgVg/97RUhyianvNmzxLScp0OhKvHND1wLXcXonSCRn5WS2sx/nR9P+CzxG2E+83H0IHQf0Y/SNHuWaRdSiTjTzgjxf0IAap6genrZCcUMCQ3Bp4N7Y4NUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSQk/bcUebF8pqSeFvcaFRr8hFnmGCWKhOv9VYfmYx8=;
 b=aVLQhBVWWw1/B20H8zupjWaWv0zzUjqwTdDKTjPTZCptqwdGA69KXjMcl5PUHN8MhL69KRd4SlsnAiXMi7U9bz0Bc8dxUjXCRryvhGwpLYCsQjS8FTGz8TtjwwffVboGJxxnjlbF1BQmEOpfd5GREodfdYJreWerENCjSgTQrmaLCEj+d9r25v5ZtKdWoBoom/2U4SSQkbXpcQ+E2P9Nju3q2tCRFqsRfL2HtfVGDZdYNW3x3SXZHn7VMxVrKiZotyMvEWBwfCiwFtPGVTRi2PD90+qMwAvWNcLh7qLzfZm6taLQYTZ710tlBDZmvG/KbLq4Swby1qiAM/ww6iKc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSQk/bcUebF8pqSeFvcaFRr8hFnmGCWKhOv9VYfmYx8=;
 b=k5fZIcz0nMnCS0hnCSg68Yj8/y6koUSH6p+S6MtPObDI2HFysXJm12tVIuzY7dk7oQF1kvKGs5LmBAi7KrSDzPx3Mkj4ZKKDpOONCji6t/ZqrYWcjwkyoVl4n8iLbvgxzQMVohL0qWInkcplLc4rpWAuSAro/LItzxe0wvzZkV77bD6I725hEMc5heHN9GWDWsqZLZDaUnNYrqCi+GyzukOOXuUxoa+l/eOvTjuutkagzCakyi8ik2Fw0xTqnqwW548kCTuGDpWDhS9a60+gBYoNB0oQl+8i0l+zf6b59IUupDXNGRH69xnvBRnOUHibxai5S2tSFsN8QIgfaB28/A==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB7234.namprd12.prod.outlook.com (2603:10b6:510:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 18:33:17 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 18:33:17 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dsahern@kernel.org" <dsahern@kernel.org>, Gal
 Pressman <gal@nvidia.com>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "almasrymina@google.com" <almasrymina@google.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, "ian.kumlien@gmail.com"
	<ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: esp: fix bad handling of pages from page_pool
Thread-Topic: [PATCH net] net: esp: fix bad handling of pages from page_pool
Thread-Index: AQHacHht/vRCI7rVQUmXvWn+jBntgrEsj1sAgAALigA=
Date: Thu, 7 Mar 2024 18:33:17 +0000
Message-ID: <a6f13f7cee46482bfcf6f889719f2007836c33f6.camel@nvidia.com>
References: <20240307101548.815189-1-dtatulea@nvidia.com>
	 <20240307095158.099d25ed@kernel.org>
In-Reply-To: <20240307095158.099d25ed@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB7234:EE_
x-ms-office365-filtering-correlation-id: 089d46b0-655c-4581-3af5-08dc3ed50e8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j9YIy9BfOHC9o737jnHoUKwPI1yegg9J5T0CAmdQHCb+Wx245IzAsh0hkJX3LSViFa0DFF5p4LhtUcEVNzH2RXJ4ARpaPN6jloWT1ImpuyGwhgrYSNwh3tzhEa90lss+cCrsiql31WYDUFBfS4CeXA0V1omm4h/+JWpTPqc1Bgknxkr5vKpRkUrM0zJLGtOsQ74mQJMuJB1UfrWSJ7vNLod0JgFikDjk5cFyu7pZT6rtuTWZoGluTRXf7SK2pa4smtZb3z5osicFjA/e7ZU5fZfZUvBTqCmwbO1IbzN5d5BDbrvV3kpqlrocY4R/U9D3leeQqwIop3rkXoZN9HWLveA0FlBeoEH1jbUHgLEodXU6eEnZukHxpsAFPIOIxPXYTUtEx/oAi33aE87gFEyNcGwp+TXJ7tbl1u3uyXNq6Z5EePOu9Icg/K/IluagLy/TtUGaSH0RZsv1g1PPAfIUI02SIbiyeZ7SfGDPzH5uVQjYgHsLohFMjtcTS8IILKlWSnvUvSjvsnyiYSDnqArNGffLm0Ddgl49F5umt3Qj83gugH4/vezCF0pDeX+raA1kou5QRD+dQDddK30wVzlv02FQVM2Ulml+xsoYOFduu9bp/l+3dODMYllttCqWm0IQZrE4c8Ar0bnLr4pGV3VHBQ9fdH3Bcr3zSyDj4dMSUlU4etAOE+J7nifWTIMkOLV/j9IADOAghYSVpZNjynJhXDBZTTrVKg3stiTJ0WcOKag=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlpEVzZacFZrcHZPTlFncWxmMzduTlkwbEc5TFNISWZxVkNXRDduaUdwdURP?=
 =?utf-8?B?dll6RXlnUmo0RHpSaWRQUXpWREM2K1VOWEFPNmRsMjdQbWtCMEZMNzFiVm1o?=
 =?utf-8?B?L05Ndy85dzQ5blowTTFKampFa1dHUXIwZjArdzJKWmRBTkJlWHlxZmo2RXU1?=
 =?utf-8?B?djZ3dXJGcWxHaGVIdHlUa0ZhM0pkRXZBY3I1OHlRRmF0RVZXQXM5OG5PU25M?=
 =?utf-8?B?aklrSzVPV1crZVJtdEpqNFY4S1J1QmlkZnVyRWJydU9naFNad2NjaFFGRkp6?=
 =?utf-8?B?RFRFNjlxUWVMayt6ZE9pTktBakZ2V2ozZXprQjJMUzN1bGRKSkxMczU3ZGVn?=
 =?utf-8?B?dE1kNWtvbFRseS9nOVdaVjA4aWJraUpTaEU3MjN3YTNNNTFsdXgzUS9LZnVq?=
 =?utf-8?B?WHl4dHY1MWNvSzV1Q0s5NGpSVVBMVmordHdLaUwzMFNNSHRjZFpMRE03dWNr?=
 =?utf-8?B?dFRZcndYSjkxTCtFUUpPeUpzWUxMWmJzSytQclhxbDRZMmFDQ1l0NFJaVHNW?=
 =?utf-8?B?L0QzMitxSkpmMmQrYnhjSnpsUGpocFVaOFdJN1cxNnBlK0RhM3RCUUZKNkhl?=
 =?utf-8?B?dEY2TjE0Uy9pSS9jSTNOMENIQmJJWDdFVDVqWHdHVlV0OFg4MENYQjM1dDhu?=
 =?utf-8?B?RjFUTEg1cmVHcmgydDlVMGNpV2xSUkh1NjE3TGZacmZOZzJxQ0t3NFBGei9F?=
 =?utf-8?B?M29LZ1hjNVR2NXNtREtBeHVWSzZXTGRjOFhCblplS3V0N1hlSzZOaWlRR0pB?=
 =?utf-8?B?UTFjTURONjA3bDBkbzFCd1JmaUNoRTdid3VsUVJDcjJ4U1FQbTRqa1pSTjdo?=
 =?utf-8?B?QVhhR0NDTUhFYkd3dTZTbzlrT0cxRUpJV2xRN0hBbFp3WVd0UCtFVlU5TG1L?=
 =?utf-8?B?M2RaY2VvQWFzSkJqaWN4NmtGNnZYNFp6UXRRZ2dUOTRaRCtiTjBxQ29wc0RY?=
 =?utf-8?B?OTJLRGdkOG9BRXdvR3BVekZNNEphamZPNFlSaFNzS2IzZ3FxOXBERktYNjlB?=
 =?utf-8?B?dDRKL2VQcllSTlRBeDdkUVNBS2EwRFQ3SElsNHJKM215cWFFNWhzV0RxcEFP?=
 =?utf-8?B?ZUd4REVKN1NoQThpUVRKUG95WHA4OGVJbjVqdTZLeFR3eU5ubzluUTZMY202?=
 =?utf-8?B?S2E3MGdvZmVGcU9yRGJxaHFQcUVnL2REL0hhaksxY3RRVWFSdU82VFR3dHRr?=
 =?utf-8?B?NHgzeU83N3VKbE1sY1k3SHNreHdjMXRjWjFscTgwSENiSUNiR3ZYNjdVcktX?=
 =?utf-8?B?ZThYYVNiQTJvNU9jSG1QN1owYnVoMlArSk1pK2lwS1FhbTY5SGxMaisxY2RE?=
 =?utf-8?B?ZUlKd3A0V0RSWnRJalVzWDdUcnI3eU95TWdDalM5S3o5ZVlTSVFIbXhmbVps?=
 =?utf-8?B?eVlvTnZkSWlDUHU5bjQ0Z2NvZUMwZ1ZYTVdubWs2WWdWNE5jMXkrSmk1M0t3?=
 =?utf-8?B?bFdlb1pvclBhZ0xPTURBS0pVd1lBN0pyZjlzdkZQTFUxMXl1eTIySHFncVln?=
 =?utf-8?B?SG42WjdNK2JVc0pxaDBEUDd2RFNLM2ZXVjM3SUZ0M2tDNUdKM3k3bkZqRUVQ?=
 =?utf-8?B?SVp3ZUtIUEh0U3NhSXhXTDR5WStKNk1EQWxIcEJZaitVRS9SZlVxc0lwOGVY?=
 =?utf-8?B?N3lPNnVtcmVyaWZMTmZSZklhWTFOMUJyeWo4QmlZTVV2dU4vNDhVRTVDN1kv?=
 =?utf-8?B?MnNxYUxuTzdWYnJVdkQ5bFR5S1RMOFEzSmtKSWQwQ0VudlRTMW1sR0ZIVldR?=
 =?utf-8?B?TndEd05NU0s5Mm9iaXdIcmduK2RQYmJLVHN5cDg3Q2Jnam9QQnU1QmpucmY1?=
 =?utf-8?B?M2xaZG9WZkNlQXd5dzVDcmpkSkFpL1o1QU9SMDk0cEhMdGVTQ053RTc2SnlO?=
 =?utf-8?B?aWFNaWl4R1RQVW1uYXAyY2FoYkF4SFNJWlJXQTFjVG5sbWlkTDMvdjNSRXRB?=
 =?utf-8?B?RkhJLzZhU2drQkNIaFpUb01wckFaM0tmNlpKbzBzVjl6MURhU1AyQ2M1amN4?=
 =?utf-8?B?WDEwM3IwNHhHbTdXaUdiZEtqb29kemxRUEo1NFpXREdsT00wcGlFYUhTYTVh?=
 =?utf-8?B?WWlORDZwNlhUbERTOHNHYjFQV01yQzdVNHNEbmJtT2U4am5nTWE1SWhLS0FM?=
 =?utf-8?B?T1pxd3NKTFVqb0xPdm5uNzM2dGFxbFVsVkI2Yys5TmFrUTJ5T2VXb0Fia1RU?=
 =?utf-8?Q?ukR8IlpLYaSE53d0BVykoVh0GlR6v3A4bk8vDtTL/iy2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7758394FB4F4584E82B418265B48FF86@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089d46b0-655c-4581-3af5-08dc3ed50e8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 18:33:17.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zxaPoxXUmx7394BWP0W+cuBU7HKqyBKHZx9ntVh4m5zRVfKJd25fk8ZfRXrHK4D8IPiON/gt10LDYRbpBilRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7234

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDA5OjUxIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gTEdUTSwgdGhhbmtzISBNaW5vciBuaXQgcGlja3MgZm9yIHRoZSB0YWdzLCBvdGhlcmlzZToN
Cj4gDQo+IFJldmlld2VkLWJ5OiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPiAN
ClRoYW5rcyENCg0KPiBPbiBUaHUsIDcgTWFyIDIwMjQgMTI6MTU6NDcgKzAyMDAgRHJhZ29zIFRh
dHVsZWEgd3JvdGU6DQo+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+DQo+IA0KPiBHZW5lcmFsIGd1aWRhbmNlIGlzIHRvIG9yZGVyIHRhZyBjaHJv
bm9sb2dpY2FsbHksIHNvOg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gRml4
ZXM6IChzcGVha2luZyBvZiB3aGljaCwgeW91IG5lZWQgdG8gYWRkIGl0LCBwcmVzdW1hYmx5IHBv
aW50IGl0IGF0DQo+ICAgICAgICAgdGhlIGNvbW1pdCB3aGVyZSBza2ItPnBwX3JlY3ljbGUgd2Fz
IGFkZGVkKQ0KPiBSZXBvcnRlZC1ieToNCj4gTGluayAvIENsb3NlczoNCj4geW91ciBzaWduLW9m
Zg0KPiBSZXZpZXcgdGFncw0KPiANCj4gPiBSZXBvcnRlZC1ieTogQW5hdG9saSBOLkNoZWNoZWxu
aWNraXkgPEFuYXRvbGkuQ2hlY2hlbG5pY2tpeUBtLmludGVycGlwZS5iaXo+DQo+ID4gVGVzdGVk
LWJ5OiBBbmF0b2xpIE4uQ2hlY2hlbG5pY2tpeSA8QW5hdG9saS5DaGVjaGVsbmlja2l5QG0uaW50
ZXJwaXBlLmJpej4NCj4gDQo+IFlvdSBjYW4gY29tYmluZSBpdCBhcyBSZXBvcnRlZC1hbmQtdGVz
dGVkLWJ5Og0KPiB1cCB0byB5b3UNCj4gDQo+ID4gUmVwb3J0ZWQtYnk6IElhbiBLdW1saWVuIDxp
YW4ua3VtbGllbkBnbWFpbC5jb20+DQo+ID4gQ2xvc2VzOiBodHRwczogLy9sb3JlLmtlcm5lbC5v
cmcvbmV0ZGV2L0NBQTg1c1p2dkh0cnBUUVJxZGFPeDZnZDU1elBBVnNxTVlrX0x3aDRNZDVrblRx
N0F5QUBtYWlsLmdtYWlsLmNvbQ0KPiANCj4gQSBzcGFjZSBzbmVha2VkIGludG8gdGhlIGxpbmsu
DQo+IA0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gUmV2aWV3ZWQtYnk6IE1p
bmEgQWxtYXNyeSA8YWxtYXNyeW1pbmFAZ29vZ2xlLmNvbT4NCj4gPiBDaGFuZ2UtSWQ6IEkzZDI3
NDRlMWFiYjMzYTY5NGE4ZjQ5ZTA3ZjkxMzcyNGEwZjg4NzFhDQo+IA0KPiBDaGFuZ2UtSWQncyBn
b3R0YSBnby4NCkZpeGVkIHRhZ3MgaW4gdjIuIFRoYW5rcyBmb3IgZXhwbGFpbmluZyB0aGUgdGFn
IG9yZGVyLiBJdCB3YXMgbmV2ZXIgcmVhbGx5IGNsZWFyDQp0byBtZS4NCg0KVGhhbmtzLA0KRHJh
Z29zDQo=

