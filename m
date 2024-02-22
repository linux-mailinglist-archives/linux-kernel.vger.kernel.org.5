Return-Path: <linux-kernel+bounces-76007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEC85F1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B392DB220B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65D17988;
	Thu, 22 Feb 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ssrbw1bR"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC3748F;
	Thu, 22 Feb 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708586187; cv=fail; b=MjHPCKLmU/U8zWKaQABEnU4y9+gTjluA+5aa1cRFpiwJOZH0fp3xxfH8iTrdLv0RGaGpZtM44WjBIEpa/J12YQWGMEPz3hWjBaFGz8bwa+HFW87fjUroZBXrTrtjYRPKN+FkVMHlw6jpOlCd316Ie6AEkXM/Uld937Z0+uqk6Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708586187; c=relaxed/simple;
	bh=kHI1xJcOy6sXKqLp3vEwZwdPZiZ7T1R7yRRqLJXu18c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eStRmykkC4As4FAA4Ba7IlMqxv8uKt2COOJdrQVA5sCiNrXejWpUUdF86TmISUVcsTAc7ZoNTG3VT/sFTJkT62RZusKORgG8k4Pk683ozyI0czE2nlvR1zrifT5iy/I1jABScDyJZg334Wpz7zRJq9nDsyav4AscXBAGrlxkdVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ssrbw1bR; arc=fail smtp.client-ip=40.107.13.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNiIy/xhhxyAmX8ny57tgDIFEN+yxbKS5W1Boq/skSc4WMYnpf/u+4mbZ1XheGdCy7yujtd6bFtX8ElnENPn1lRg1nIcA7ZJoAtzMzTamUy6/ZgSXy1gMLXxFAwhqpXysfttul8xYRbMRIGoiQsxX+Y8Jg8BlZIUVTXiJXkEswRLRVi/fegT1nbdTSAJ+hrFfCdpu3HziflS1Q9nMAG4DTNtD5oVHcTtzitOqVfKasWGL6EkEaM4G/FphccH6QSfulbU7Rp1prGi5yklNUMRyuGJ9wwJcNIMEsJwe1/H16YW2cWw2AbukTQfYsafopcbFBFH8zv+Xjr2KnUrictd2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHI1xJcOy6sXKqLp3vEwZwdPZiZ7T1R7yRRqLJXu18c=;
 b=jDgp1Bnxt8uVBxtDXcQdeTjgmTJYdONbDRjqWmpG1UnElhqviKJFCnUNL4yufhzytGfY9trWvozQnelQQPipXfLp2baTC9XTJ+5Qjrntd+eqJ9dAUWGnSWqulvZroPQdj2APK+nvRkW6aZiTiFl8BrT0k4pk+RLjSoElTX3/XmPW04ITJPxcFBANLlK1eN/kMk8qP/IUx4UD6mR8gj/qSyv00PZuSnmc0L5548a37j5ZsYFwPiaUI1Bj5WQshXraoG3CgP/lLpxo2qSWPufq76/eceBg60bkmbkvwl7xda/qcA9n5atdAuqX/2EG5K4v2BbqgKSWd7WpIeYZXYY/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHI1xJcOy6sXKqLp3vEwZwdPZiZ7T1R7yRRqLJXu18c=;
 b=ssrbw1bRQCeWHspdGv0+IzkZUhOcn0l+JTYoe/EbBjIO/lvKoaBWwMNdAHQZYJP4/NfqvcJzRPLLdFlU4txjjZLfNniOwVqr3JvaLKqrK5v2rJ/TsPbkVHT8mZmZLEJ5BqnqLbIjX5FZyUHyFDYr9H/lQdb7T5RGjHC3emctiVSjw8XfmAVGKfVXsOGRT55SxwacluG9MORxzIgMot3JQm5Iqm5aND2Qt9oIZ1X6Q7LWFUM8Fd4oWPWnEFD2cdb6S0urX98UK6COgpcrgFAdZtnfD1eJpcFNT2OGr544ndxglLgQ/SEQ2i6LTkTACfCbHaozCRmlxnBt2gLcqtP27w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB5718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 22 Feb
 2024 07:16:20 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89d3:24a6:587e:51f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89d3:24a6:587e:51f%4]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 07:16:20 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org"
	<sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Thread-Topic: [PATCH RFC] power: reset: restart-poweroff: convert to module
Thread-Index: AQHaZO3fdSvNdjfmzUuXjfeFOMKscbEVV64AgACchoA=
Date: Thu, 22 Feb 2024 07:16:20 +0000
Message-ID: <35e30e3260f6669b28dcdde6ea58f480eac3db91.camel@siemens.com>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
	 <6964c19f-6ffb-4d9a-bc02-ffaf52aa23b5@lunn.ch>
In-Reply-To: <6964c19f-6ffb-4d9a-bc02-ffaf52aa23b5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB5718:EE_
x-ms-office365-filtering-correlation-id: 30624b71-6a18-47a1-28a4-08dc33762b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UDfaq2h0Mc7WrSuB3wWdKSxZko09vf+KMRo2vamgLeybaffmON6VLz5KSG+O5kmHwfKV8T5IOc3hGVu6rQYxvjM6IXdlavB/UJF/cTDvrce9w13vtAblCpyQVhQLZiuwEJ41qtFYShnPHgmGYsCFag1qXIgeI8EjiSrQkAPFu751HRUX1G7n1aEfPXanX+78vfdXlw10zAHurVnfIMjb+4/8pxnfM1ritpKezmO+zqn8bURGeqTZFrRDlGpcSlf29wexOVxYp8XlgRayefMp6I4FG6Rej5OE2S3fO7HmrtAC1d7GoGTZegIsAMQNy3Pil9L705AnjjFhaVez4yIVo7vAOjtTM3vYclUE+zlLEgmsCOL1y5XPWobYDChXhi+z0Zv6sJmQN8pibHU7yXM/Dn8LznodXmDCQuneiNmZPw2tpAz6DnCGaoNjvqBk7bhvzvWziYVlkMKaq7w1U8S4cqY85vfnjBqQr6rZyMnL9zS3oGguHVfpsfinBVWsoGcdfeQhaZ/qjBWBz9g049gGJM771xYb/MGUH9ZeYijWc+KKLiyk5dHtf96dWs8dfvBUweRhFudEujlbv037wy3zLkS0C7UohxFgc2m7XTENGWQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWh3TDlvb1pPMW9OSkdEM21wWWhNUytqK2pxQzNwSmErZkZ1bC9hdXgrTElH?=
 =?utf-8?B?UEZrSUgxZmdxN1RCaXJqcU0wQUEvN2gyU1Q5VmkwMWhPZkYxaUpXUUZvSUIy?=
 =?utf-8?B?QmoxTXQxNkVnTGdZL0xBektoL3NwaFZVUW5UM2c5QnI4M3g4RHVKVTBiMWNp?=
 =?utf-8?B?cTVzbFpFbll1UnBnNjUvWTRmaVdPSjBlQ2RFei94ZmtPdTBrN0FTVGg5NGV5?=
 =?utf-8?B?eUFWRCsxRGR3aExRY1ZabjNWTGdVL05qS0NaNjJ0RkhQemF0VDNBVjVTNzFW?=
 =?utf-8?B?QmxUcUpCTkREblp6REtCb010a1FRN3B2M3FyRnlZTUdPVU9mR0dJNm9WMWc4?=
 =?utf-8?B?U3ppTHQ4STVtUU55ZWtONWV0RTdHblprRERKK1BpemE5V05SRFlVcUNwaVNZ?=
 =?utf-8?B?L3JTMkpmYW9BZjAyeHNPWU1yTTBMRUhLZWt5SUlWczQxOG9uaHRadnBUVUd5?=
 =?utf-8?B?ZW9lak9KNEgrclM5ZENaSHlBcW1sSUplaDlPbjk0TnBVc1RZWFhRZDZlT0ZT?=
 =?utf-8?B?L2lWdklXZUFFVjdnZk1uM2FyNVluM2FVdUZGaEZydk8ydEIrQUZSVmkzZ1lV?=
 =?utf-8?B?Rk5WUE8zcGtVN3VLeEdIMmYwZmU3eEh6dDQ3ajNYaUV2bU0xdTNGcXhFNFJa?=
 =?utf-8?B?cHJZYWsvRXk0TVhkSThOZDZ0Y3RhUytpVlZ0NFdZWkF2M05BYnVKNFFRVE1k?=
 =?utf-8?B?ZXRXRzg3c2RaTHl1VTZESjBRbTk2bVI5Z2RESmtJdHFybk5tc0U5T0EyVmpG?=
 =?utf-8?B?YlE3ZWlhRldIRm5TQlV4TTd5c283SXRQVWxpZnIvaGM5TEp2TDhIT1BmUkl5?=
 =?utf-8?B?REl2MkdQOHBXY09vMEFZdWJFeURrM084bmt0V1lHejF4WXJwM0QrZ3pEcy9R?=
 =?utf-8?B?QWFHNEJUN29IK2gvQ2FYQU1MR3U4TExxRUtqYWtVZ2JZaXJ5eDlrVzNEVVN5?=
 =?utf-8?B?VmVtUThISlVoZForZnJML0FVQktNQVhCZTNxdllCVEY0RHJTVnlrL3ZWY0FZ?=
 =?utf-8?B?ZFQycXpFaUp2L3pZZnZPMTBwRmVJdWVsVUh6L2tEYkxiejBDWWJuaEZwc1J2?=
 =?utf-8?B?eXlBZG01anZJUjAvL21lSFZFL3pFdW5lN0lBeVJrR3JqVjNoWGRhVUVvYVZ0?=
 =?utf-8?B?dkNIbzk1emtRTDhiRGJJRFBjZ0kwKytUTmhZOUY1QnREU1RwME1VTlZKZDlo?=
 =?utf-8?B?blpzdnNTNjF5cGRwbGFDa0ZXNUJmZVN1emZzaGVBbldTZ1N5VVRRaGl1V2sz?=
 =?utf-8?B?TC8rSnp5VElMeTQyK0hlRWVacDhzZHluOUplSGZJZkNmaWVvUmJIaVhNVTdI?=
 =?utf-8?B?MEtESytGTkNCWWpzT1A5Qm91M2o4NHRIb2pTbWZJOU95anoxeFNZQXpTSjJv?=
 =?utf-8?B?K1NBTG1BMytURkE0dStEVGVJWmt4VkZ2blpVMHdIVkgwd0NTTDRiMkltZGpN?=
 =?utf-8?B?OUJtbmhFbks4RCt3OTZyVVNsTmNoSnZPSkV0U253M0lGK1hUWEtzbVpoY3cx?=
 =?utf-8?B?aUlvWnRRVkdCVzI1SUZEVFpqUUZnVU42VE4zMlNpaFRTa1N2WjRaL1NZQVBR?=
 =?utf-8?B?N0wraXJOZ0RPOTJZQ215Tk5wb1pZdDZFRyt6U3FuVThQRDdTNkY5dS9lcGFz?=
 =?utf-8?B?MENQeWEveDNkT0x1WFkzQUVoQjJnQ1pnZlRtM3lEQWtiK2NPaGhNZEVhWmFv?=
 =?utf-8?B?VFJJc1FvQ2NtczNIaGRFQkUrSUhDQUdidllyd1U5bHRLVzhnWkoxQnVlVEsv?=
 =?utf-8?B?WXZrODNHZHRnQ1Flek9rS0o3bFRMNmhsWEFqU0NmVnRWQlg0ZnByU3Bib1Bm?=
 =?utf-8?B?MzQ5NTdzRmN2NEdvUmRDN3EyN1JYa0diVUZBT2FYWXJCcW1EK1JQU1V0Vm1z?=
 =?utf-8?B?OCtqc2EyajFDbjI2ZmxBRG9ZOEZoMjl0N0RzcHArU2tvT2dwS0pzVlZBNEJJ?=
 =?utf-8?B?MVNBNnFObExoMXYwSlZ4c0RyYm5tdm1WOHBLSHhpRkFwRlkxZU9HMXc4c3Nr?=
 =?utf-8?B?OEt1cXFZQ0xyakswWUt5RjJCYjRUV1VuTW9GM3k2YVh2UnIrWlp2a3BUREdR?=
 =?utf-8?B?REk2ZTkwSWZjMnlYb3pxYlJxTllHdTNCS1FkWGN2REw4V0pqeU55V0w1US9X?=
 =?utf-8?B?ZDFtRkZTRWtrUjVNeDUySEZyOXBLYXVJTmUvaUVGZWhZRk1qR2pZVUp6cXMr?=
 =?utf-8?Q?5vD1utDZff0gO27rFo6t3O0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09DC6181FFFCC94EBC90FC024C6376BC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30624b71-6a18-47a1-28a4-08dc33762b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:16:20.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjZ5ace5ohv8isIByyrlXHktgp9zyhoQtKnph3eM9kQ4RdokyQADBKvrN9h5MEMPXYOMxlKKfQOW0DJwFFtR0pwJz8rqslId4ozU6MejZhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5718

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDIyOjU2ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiBAQCAtNDcsMTUgKzQ1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb2Zf
cmVzdGFydF9wb3dlcm9mZl9tYXRjaFtdID0gew0KPiA+IMKgIH07DQo+ID4gwqAgTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgb2ZfcmVzdGFydF9wb3dlcm9mZl9tYXRjaCk7DQo+ID4gwqAgDQo+ID4g
LXN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHJlc3RhcnRfcG93ZXJvZmZfZHJpdmVyID0g
ew0KPiA+IC3CoMKgwqDCoMKgwqDCoC5wcm9iZSA9IHJlc3RhcnRfcG93ZXJvZmZfcHJvYmUsDQo+
ID4gLcKgwqDCoMKgwqDCoMKgLnJlbW92ZSA9IHJlc3RhcnRfcG93ZXJvZmZfcmVtb3ZlLA0KPiA+
IC3CoMKgwqDCoMKgwqDCoC5kcml2ZXIgPSB7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5uYW1lID0gInBvd2Vyb2ZmLXJlc3RhcnQiLA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAub2ZfbWF0Y2hfdGFibGUgPSBvZl9yZXN0YXJ0X3Bvd2Vyb2ZmX21hdGNo
LA0KPiA+IC3CoMKgwqDCoMKgwqDCoH0sDQo+ID4gLX07DQo+IA0KPiBvZl9yZXN0YXJ0X3Bvd2Vy
b2ZmX21hdGNoIG5vdyBzZWVtcyB0byBiZSBkaXNjb25uZWN0ZWQgZnJvbSB0aGUNCj4gZHJpdmVy
Lg0KPiANCj4ga2lya3dvb2QtbGlua3N0YXRpb24uZHRzaTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY29tcGF0aWJsZSA9ICJyZXN0YXJ0LXBvd2Vyb2ZmIjsNCj4ga2lya3dvb2QtbHN4bC5k
dHNpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29tcGF0aWJsZSA9ICJyZXN0YXJ0LXBvd2Vy
b2ZmIjsNCj4gb3Jpb241eC1saW5rc3RhdGlvbi5kdHNpOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGNvbXBhdGlibGUgPSAicmVzdGFydC1wb3dlcm9mZiI7DQo+IG9yaW9uNXgtbHN3c2ds
LmR0czrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVzdGFydC1wb3dl
cm9mZiI7DQo+IA0KPiBIb3cgZG8gdGhlc2UgZGV2aWNlcyBnZXQgdGhpcyBkcml2ZXIgbG9hZGVk
Pw0KPiANCj4gVGhpcyBhcHBlYXJzIHRvIGJlIGFub3RoZXIgcmVhc29uIHRvIE5BQ0sgaXQuDQoN
ClRoYXQncyB3aHkgTU9EVUxFX0RFVklDRV9UQUJMRSgpIHdhcyBwcmVzZXJ2ZWQgZm9yIGJhY2t3
YXJkcyBjb21wYXRpYmlsaXR5LA0KYmVjYXVzZSAqbG9hZGluZyogaGFwcGVucyB2aWEgTU9EVUxF
X0RFVklDRV9UQUJMRSgpLiBCdXQgSSBkaWRuJ3QgcmVhbGl6ZQ0KaXQgd2FzIG5ldmVyIGJ1aWxk
YWJsZSBhcyBtb2R1bGUgYXMgU2ViYXN0aWFuIHBvaW50ZWQgb3V0LCBiZWNhdXNlIG9mDQptYWNo
aW5lX3Jlc3RhcnQoKS4NCg0KRm9yIHlvdXIgdXNlIGNhc2UgaXQgd291bGQgY29udGludWUgdG8g
d29yayBhcyBiZWZvcmUgSSBiZWxpZXZlLCBqdXN0DQp0aGUgY2FsbGJhY2sgd291bGQgYmUgaW5z
dGFsbGVkIGJlY2F1c2Ugb2YgdGhlIGZhY3QgdGhlIGNvZGUNCndhcyBjb21waWxlZC1pbiwgbm90
IGJlY2F1c2UgdGhlcmUgd2FzIGEgZmFrZSBwbGF0Zm9ybSBkZXZpY2UuDQoNCkkgYWxzbyBkaWRu
J3QgdW5kZXJzdGFuZCB3aGF0IGlzIHNvIHNwZWNpYWwgYWJvdXQgYm9vdGxvYWRlciBzdXBwb3J0
DQpmb3IgdGhpcyBmdW5jdGlvbmFsaXR5IGlmIG5vIGRhdGEgaXMgcGFzc2VkIHRvIHRoZSBib290
bG9hZGVyLg0KQWZ0ZXIgQVJNLXNwZWNpZmljcyB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBjb2RlIHF1
aXRlIHNvbWUgdGltZSBhZ28NCmFueSBwbGF0Zm9ybSBjb3VsZCByZS11c2UgdGhlIGNvZGUgZm9y
IHRoZSBkZXBsb3ltZW50cyB3aGljaCBtZWFudA0KdG8gYmUgImFsd2F5cyBvbiIuDQoNCkJ1dCBJ
ZiB0aGUgcmVzaXN0YW5jZSBpcyBzbyBzZXJpb3VzLCBzbyBiZSBpdC4NCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

