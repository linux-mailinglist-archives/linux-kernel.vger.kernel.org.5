Return-Path: <linux-kernel+bounces-122925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78888FF93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00624B21F05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4297F476;
	Thu, 28 Mar 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="F/9ks4Tk"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020003.outbound.protection.outlook.com [52.101.167.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5C5F87C;
	Thu, 28 Mar 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630259; cv=fail; b=uiarhWRXL9gwXXlBx/l88ZwDygbGbmyDtFcgNS2UTDKmYVBUFQMqQgz2xVP22zuzrnnyTX8CUjUvrqZzKxIw11ZBWiMLp77Pig+y03Fh/6b5D46nL84Rmj1XQ7o/WlJHePfusGZXf5t98WJwxVy4vUF0q5SOvKlam9cee+349lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630259; c=relaxed/simple;
	bh=mcELksiNTmJF9U49TTniMSP8yQtszQs3+7Cywoceq4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbvdscismKvCE6uJXqi0bcEp8HZ0sTpSzK5IvP6H5ADblZVthA5Oiu4FjI/5g0tgG6CZSwO1pmXVnXz3ROOg7QNQz6OuVVC8H6cst725ZURHbSRTNjwVL6JJjeLkGp5eDIDPStmrecz1+codBjSPg7YPbV4UMj7wvHaW9sgbCJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=F/9ks4Tk; arc=fail smtp.client-ip=52.101.167.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVBblMn34fYUkC8SIU3uI6Fr0fe0TNvYsZZExyVzOBb1KY7NIg6ngDe01wzokW9MusWt3+6G4nsHm5u1/K0arQi1Grh6ZthB4Nk00Cq9UWmI264zJiPr+VOlDlqdc4+6f3X49uXYXrLW0ww2Ye83l+jhZUF64QHVnpUaA9BAlL0HgKnKbisQE5C1B0tj/+AKVXV3sjE13TX3gDxN/sElkaF+No3c8fgRq9ZgU4Fzk1z6oi19kI5U87A097zbU+f1oVC/9OYzggBOLRHbqJimx5akNUVvPtYg+M8RdzgF6Sv90A3AZKsa983ULI1emfFeOsIC3ZC0JILEPHpaBZieng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcELksiNTmJF9U49TTniMSP8yQtszQs3+7Cywoceq4Q=;
 b=oZnZSVNKtYEQLbaLYr5Ir+8vAdyfULxNQPKHKRSKvSfxdYEAaWLw8R+FcoK/hl/GNq8qxXRaSJ3fqof4ihJJZQcMd865TEVOtAhSEB9cJTtpIe7i+7mEhYAzXzR/EDx4srtn8DlmaxdH2ld67Y5yIlqwu6dnJaKuHR1lCZQaGthfbt4ot4M1VuHK2UGBG8JC6IZFxm06DzAHjXMEUZB01EprfvCfWK0phdD5LUNXFH1QilyDHBRVu10BUkd2sRBkV5UWGCY/9E9ea94MfvglH88vs+GOHXAO93KbNd1wzKF1guTPw3avUXjxn5jxBdnF/nQu5ksj2fYDBFt46sVwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcELksiNTmJF9U49TTniMSP8yQtszQs3+7Cywoceq4Q=;
 b=F/9ks4Tk3gTRDydAdfW+3oC5D8G4pKwaTY7ZFugr0kVsbOxcItfLtz5kB1vjAFrPi/Y9d7rafeeQOiqgL/VNXRTeHDkq2Rd9GpVTRxgX+8FwbJWia/yzyLpmQJjsT9Ipu9z/DCv7auer55CfzBugTcO3QneASFND1uiv7DWLkYvcm5TCZKAFcIVfbMqPW7hIqQnO1V+6HdpmTS3QUc+ro88hrDx2XTtBoxL/DFIKx4N80jhkKaXT5fM1uyR4vjg2kJd0X2XS7T6104vI2+AHczqu9TMRbOfmPLUoSt8iSxpsVLbc4nmvfyuwei47i/ysPXYUPSaSJ4v92rwpdYbqhA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2571.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 12:50:54 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7409.038; Thu, 28 Mar 2024
 12:50:54 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jarkko Sakkinen <jarkko@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luis
 Chamberlain <mcgrof@kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "Naveen N . Rao"
	<naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Thread-Topic: [PATCH v7 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Thread-Index: AQHaf4RCkQCyd7P0cUC2CDp5+q6YwLFNHhqA
Date: Thu, 28 Mar 2024 12:50:54 +0000
Message-ID: <e4c3933c-884d-476b-976b-ccaa86e66ddc@csgroup.eu>
References: <20240326134616.7691-1-jarkko@kernel.org>
 <20240326134616.7691-2-jarkko@kernel.org>
In-Reply-To: <20240326134616.7691-2-jarkko@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2571:EE_
x-ms-office365-filtering-correlation-id: 2a2f60b5-f371-4b5a-0865-08dc4f25b491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 upzO7OPPpkGjxrmRhuzPaEF+ONUy6FHLc3r9jR50WSQL8+thGKHRYHtOUG1/ZyswwVt3SGYUdyErJ85ZUosPSF3/09yg9RBbvq2KGVBrZyAkod2gv7W9gmVL8us0QbyX0VivMm5D2+rjWNz1kXFBLu29+jpP/hZAWqRFYn3TLCfxMeNiGZslGHxHmu5Zv7H4av9uQ1uNS3NDmYNlGspD6LHaGU/bENEJnH0zHtUDgMIVdmJTKl3lEabWA5ZJih+7aK26sQC5L01mYEa2LzoA9GPwEGZIbFx3RxGFj6G1ZcII2F8VkAAKTPv9xoi61XxMWKpVxHVD8utFhBAhNHJA+8Ly7Fo7PZEV0OYuIhI4e0XGnOk67iOK7EJLsCrrGVkkY/hN3O0zEpVDQaK2xfFon9z8T44vWDiiOocto8lg83AsIGmuw7i58qEKahXGL6ohilFdV8plwUhc9Wh63F+/K9iXlY8LrQ1g1Ay6nX6SDTEj56Hfsgb67IkU8rw66+r+JX5SISfPimB9+WIup10BCauRqk+Kw73awrO+pgcPcBY+mVR7wIvSBOPsoFuwlCRsyM680tscfzJHJIN4JwzXzoBln2uVqVUjB/tRQUVWCw4a+a/e8sD3/R9H5DbQjTqD28jXCRwDfkZKCx2Of19+yU0YvR+RLUshh3WyXlQAveg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGpnNldJeEN3RlpNdHBlaEwxVGVMZlUwK2NnMitlS1Rqc0wwSE1CUzlBMUM1?=
 =?utf-8?B?ZjZ5Nk5nYi9CWTgyQzl3RTZDdHVpbk9SR2FtZmZneDFueENGUXJWS2NzMmww?=
 =?utf-8?B?OUdlQ0tieTBkcEtZdml1Qmt6YXErOFIzL0hMRU94QXRFcUlyTEdkMWI4eEpm?=
 =?utf-8?B?ejFGd2NWMURWeW5aY21kenpDbHBoWlEzUGVneVYrQmtxNHlpUVZXMTFnVExH?=
 =?utf-8?B?ZFdvU1BrcDVXWDVDNXpxOUNVd3lKb1MydHBweDlUSy9SSUFmZHMxdDNyUHg1?=
 =?utf-8?B?VllpMEN4U2tIWHE3cUNCVEV4Q25tUEhRN0tTZGRkVlJOaWZJc0JoaEdYQytl?=
 =?utf-8?B?VEtqV2hzMmxZejdyUHhjTGl5Z1pUT2t2bzV6eTJpTy9ZaTExSkt0eGllUjhi?=
 =?utf-8?B?RzVWM0oxZXRKWTV1c2RpQVJUL2xza3hQQlh0SWtqZ2JTRktqWEI5Ykg2Lytv?=
 =?utf-8?B?SnoxeVpkSGFjWUJXZVpmaXlCbHhvVys1bUdzVnYzZ3lhOVNpU3ZRZnVFVGd6?=
 =?utf-8?B?Y2VBT1Qyb1RlRDd4KzFrbzhUUjF0OHFlazZWc201TU9CeEE4d1pNNjRQTitF?=
 =?utf-8?B?WmM1OGFtWS9iV0tuc2hCR1Q1WUhTc0xYNmtNT0hmbTVuZERoZ0FLOHdXQmZ1?=
 =?utf-8?B?SitFSTdVaWZBZlVHZjZpOFZrbjgxUnJaOEsvWVhLMUFqZG1DTEVaRmhoTms3?=
 =?utf-8?B?TXdlMnJ0SUhCNnBZMDdQdE1uYzNqWXBYRWdTSG5zZDR1L0YwRmM5dmFRTC9l?=
 =?utf-8?B?NDB2YW84aFZPT0VzdCtRYmJ6Z1A5VzFsVEUyczlFMklQbktIUG5MZHRIZWl0?=
 =?utf-8?B?b3lPTHczMlgxcHdGOTJ0SWloTjY4djFVODQ3Y0ZwbGFNbUI2YTFhN1FxZmxZ?=
 =?utf-8?B?SjBQZXB2anNDWDhKRjloRjkrOTdUdFdDMDRMMjJIOHE3ZldZUUJ0MFJzTGky?=
 =?utf-8?B?aER4dU5xMEJDRmZ1N241SWdaM2Q5RElzTC9qRkt2d0lVa0FjbXlrN3IxMnlU?=
 =?utf-8?B?aWJORnRDZHMyV3NPTjR4SVpYWWR2UUNVVG9kUzQ3eERmaWd3RW9FUlRZb29Q?=
 =?utf-8?B?MU5RYUx6WGlUM3RYcHBYcHVrSlBrcXVmRkJxN1hXSkMveHovc0NRbG1rVEhD?=
 =?utf-8?B?cjA1NmpkV2MwbkhheTVlYXZJL3VKT1V5NzM2bDJwL3NGNmhsTFVhN083YlVx?=
 =?utf-8?B?dnJmbGt2eVpsVFg4SjZaM3IyY0JrZXhGSjdTM3EveE8vTXk2YUNuRW9MVlhT?=
 =?utf-8?B?dDZtUGdHNnBITlRsNGhDSTVtK1NGeC8waElIcFV6ckZyNnpCT0pLVEZlSEp1?=
 =?utf-8?B?NHJUK1NCLys1K3doVWJ5ak1GTGtucWpRbXFETlNabDMyQkpXWDdJbTZ5eHRo?=
 =?utf-8?B?MCtWZEJvbnF3M1E3VW0xb0tISTZMTnE1Q25xRUluNzRhZ3orN2xXQXgrZHBj?=
 =?utf-8?B?RitSSVFCSjBzVGVzazBBVDZVZm9KTDRNWXF2VE85eDFacW1FaC9yN1VXZmNL?=
 =?utf-8?B?WXl1ME5oTXRMMGcvK1dVOHEzTUZnZmFvWHlmWnZWNnVCN0RQRkE2QVJ1aFBM?=
 =?utf-8?B?M1RhOXl5Y3NvNWdaNVFxUFhWK1I3TGFTVWszQ0pvZDdEM0NIbTkwbUdlcjlv?=
 =?utf-8?B?a1RlM0t2ZDYzcGxmTDJOU0pSYVo3djJKeG04enlucCt2Tm9CYkhJYUdRL1pD?=
 =?utf-8?B?TGxtMklqWTNPSTBsUkFOeHloQTlNN1lyaXZxK2NZMjZFUE0ySyszVHhzb0ht?=
 =?utf-8?B?ZnBaRzVSTmlSRjFWVTRLdTRkaTd3MUF4STVoT25wTnRrUVFvWEo4ekNNMzNr?=
 =?utf-8?B?SDBGZTlFQldtajNGWFRuUkUyaHcwVUNpV0x5SlpjRkZjU0xid28rWGR0Z0Z2?=
 =?utf-8?B?bWU1ZXlBY0Rvd1BNSWlQUGY0UTNzN24vTDkvTUN6cDlUV3B0TU1zeEdpeng0?=
 =?utf-8?B?YkVSVHFJUUpORS9oK0hGcC9CdW9SNFhSMlN3ZXR2dDNxT3hKeVJXUzNodGJx?=
 =?utf-8?B?NW4veUJ4U0poMzIxck15OWpXbFpTakNWc29VOFNOOWxrYW9aQ2NmSzg1YzRZ?=
 =?utf-8?B?ZWNxTFRQY0J1eDNWUVdoQ0VLTXhUbjhJYWIxVVN0VHBISlNGSlEyMzRTbldZ?=
 =?utf-8?B?VHdLd1BVenRFOWlUYkNpSGtUcjZZdEptYi8rbWVLQzBBK3ZvM09xTXZEWkp2?=
 =?utf-8?B?WUN3Tk45cTVHMzZBNElpR05NSytSNW4yb0kveGk2YThnT3k2TUNHN0VESUJF?=
 =?utf-8?B?R2dUZTRVbzJUOVBxWVR5NlBmSllBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66FCE73D0F1C7245A7628AAB9B644D4D@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2f60b5-f371-4b5a-0865-08dc4f25b491
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:50:54.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R68qNDDXjbZ3vLd2jc8NupFLv6MahmMeAXKeOxv2onBrnE+EVvJKRS9IQeUsnXBEanRvBRDnMTJ/nnOxuV2XYe9hhR1pOtb8rhgJNqZeJ/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2571

DQoNCkxlIDI2LzAzLzIwMjQgw6AgMTQ6NDYsIEphcmtrbyBTYWtraW5lbiBhIMOpY3JpdMKgOg0K
PiBUYWNpbmcgd2l0aCBrcHJvYmVzIHdoaWxlIHJ1bm5pbmcgYSBtb25vbGl0aGljIGtlcm5lbCBp
cyBjdXJyZW50bHkNCj4gaW1wb3NzaWJsZSBkdWUgdGhlIGtlcm5lbCBtb2R1bGUgYWxsb2NhdG9y
IGRlcGVuZGVuY3kuDQo+IA0KPiBBZGRyZXNzIHRoZSBpc3N1ZSBieSBpbXBsZW1lbnRpbmcgdGV4
dG1lbSBBUEkgZm9yIFJJU0MtVi4NCj4gDQo+IExpbms6IGh0dHBzOi8vd3d3LnNvY2h1Yi5maSAj
IGZvciBwb3dlciBvbiB0ZXN0aW5nIG5ldyBTb0MncyB3aXRoIGEgbWluaW1hbCBzdGFjaw0KPiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MDgwMDAwMTQuMzA1NDMzMy0x
LWphcmtrb0Bwcm9maWFuLmNvbS8gIyBjb250aW51YXRpb24NCj4gU2lnbmVkLW9mZi1ieTogSmFy
a2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCj4gLS0tDQo+IHY1LXY3Og0KPiAtIE5v
IGNoYW5nZXMuDQo+IHY0Og0KPiAtIEluY2x1ZGUgbGludXgvZXhlY21lbS5oLg0KPiB2MzoNCj4g
LSBBcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgcGFydHMgaGF2ZSBiZWVuIHNwbGl0IHRvIHNlcGFy
YXRlIHBhdGNoZXMuDQo+IC0gRG8gbm90IGNoYW5nZSBhcmNoL3Jpc2N2L2tlcm5lbC9tb2R1bGUu
YyBhcyBpdCBpcyBvdXQgb2Ygc2NvcGUgZm9yDQo+ICAgIHRoaXMgcGF0Y2ggc2V0IG5vdy4NCj4g
djI6DQo+IC0gQmV0dGVyIGxhdGUgdGhhbiBuZXZlciByaWdodD8gOi0pDQo+IC0gRm9jdXMgb25s
eSB0byBSSVNDLVYgZm9yIG5vdyB0byBtYWtlIHRoZSBwYXRjaCBtb3JlIGRpZ2VzdGFibGUuIFRo
aXMNCj4gICAgaXMgdGhlIGFyY2ggd2hlcmUgSSB1c2UgdGhlIHBhdGNoIG9uIGEgZGFpbHkgYmFz
aXMgdG8gaGVscCB3aXRoIFFBLg0KPiAtIEludHJvZHVjZSBIQVZFX0tQUk9CRVNfQUxMT0MgZmxh
ZyB0byBoZWxwIHdpdGggbW9yZSBncmFkdWFsIG1pZ3JhdGlvbi4NCj4gLS0tDQo+ICAgYXJjaC9y
aXNjdi9LY29uZmlnICAgICAgICAgIHwgIDEgKw0KPiAgIGFyY2gvcmlzY3Yva2VybmVsL01ha2Vm
aWxlICB8ICAzICsrKw0KPiAgIGFyY2gvcmlzY3Yva2VybmVsL2V4ZWNtZW0uYyB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykN
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvZXhlY21lbS5jDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnIGIvYXJjaC9yaXNjdi9LY29uZmlnDQo+
IGluZGV4IGUzMTQyY2U1MzFhMC4uNDk5NTEyZmIxN2ZmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jp
c2N2L0tjb25maWcNCj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnDQo+IEBAIC0xMzIsNiArMTMy
LDcgQEAgY29uZmlnIFJJU0NWDQo+ICAgCXNlbGVjdCBIQVZFX0tQUk9CRVMgaWYgIVhJUF9LRVJO
RUwNCj4gICAJc2VsZWN0IEhBVkVfS1BST0JFU19PTl9GVFJBQ0UgaWYgIVhJUF9LRVJORUwNCj4g
ICAJc2VsZWN0IEhBVkVfS1JFVFBST0JFUyBpZiAhWElQX0tFUk5FTA0KPiArCXNlbGVjdCBIQVZF
X0FMTE9DX0VYRUNNRU0gaWYgIVhJUF9LRVJORUwNCj4gICAJIyBodHRwczovL2dpdGh1Yi5jb20v
Q2xhbmdCdWlsdExpbnV4L2xpbnV4L2lzc3Vlcy8xODgxDQo+ICAgCXNlbGVjdCBIQVZFX0xEX0RF
QURfQ09ERV9EQVRBX0VMSU1JTkFUSU9OIGlmICFMRF9JU19MTEQNCj4gICAJc2VsZWN0IEhBVkVf
TU9WRV9QTUQNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlIGIvYXJj
aC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUNCj4gaW5kZXggNjA0ZDZiZjdlNDc2Li4zMzc3OTdmMTBk
M2UgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQo+ICsrKyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL01ha2VmaWxlDQo+IEBAIC03Myw2ICs3Myw5IEBAIG9iai0kKENPTkZJ
R19TTVApCQkrPSBjcHVfb3BzLm8NCj4gICANCj4gICBvYmotJChDT05GSUdfUklTQ1ZfQk9PVF9T
UElOV0FJVCkgKz0gY3B1X29wc19zcGlud2FpdC5vDQo+ICAgb2JqLSQoQ09ORklHX01PRFVMRVMp
CQkrPSBtb2R1bGUubw0KPiAraWZlcSAoJChDT05GSUdfQUxMT0NfRVhFQ01FTSkseSkNCj4gK29i
ai15CQkJCSs9IGV4ZWNtZW0ubw0KDQpXaHkgbm90IGp1c3QgOg0KDQpvYmotJChDT05GSUdfQUxM
T0NfRVhFQ01FTSkJCSs9IGV4ZWNtZW0ubw0KDQo+ICtlbmRpZg0KPiAgIG9iai0kKENPTkZJR19N
T0RVTEVfU0VDVElPTlMpCSs9IG1vZHVsZS1zZWN0aW9ucy5vDQo+ICAgDQo+ICAgb2JqLSQoQ09O
RklHX0NQVV9QTSkJCSs9IHN1c3BlbmRfZW50cnkubyBzdXNwZW5kLm8NCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3Yva2VybmVsL2V4ZWNtZW0uYyBiL2FyY2gvcmlzY3Yva2VybmVsL2V4ZWNtZW0u
Yw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNlNTI1MjJl
YWQzMg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2V4ZWNtZW0u
Yw0KPiBAQCAtMCwwICsxLDIyIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcg0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvbW0uaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9leGVjbWVtLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPg0KPiArI2lu
Y2x1ZGUgPGFzbS9zZWN0aW9ucy5oPg0KPiArDQo+ICt2b2lkICphbGxvY19leGVjbWVtKHVuc2ln
bmVkIGxvbmcgc2l6ZSwgZ2ZwX3QgLyogZ2ZwICovKQ0KPiArew0KPiArCXJldHVybiBfX3ZtYWxs
b2Nfbm9kZV9yYW5nZShzaXplLCAxLCBNT0RVTEVTX1ZBRERSLA0KPiArCQkJCSAgICBNT0RVTEVT
X0VORCwgR0ZQX0tFUk5FTCwNCg0KV2h5IG5vdCB1c2UgZ2ZwIGFyZ3VtZW50ID8NCg0KPiArCQkJ
CSAgICBQQUdFX0tFUk5FTCwgMCwgTlVNQV9OT19OT0RFLA0KPiArCQkJCSAgICBfX2J1aWx0aW5f
cmV0dXJuX2FkZHJlc3MoMCkpOw0KPiArfQ0KPiArDQo+ICt2b2lkIGZyZWVfZXhlY21lbSh2b2lk
ICpyZWdpb24pDQo+ICt7DQo+ICsJaWYgKGluX2ludGVycnVwdCgpKQ0KPiArCQlwcl93YXJuKCJJ
biBpbnRlcnJ1cHQgY29udGV4dDogdm1hbGxvYyBtYXkgbm90IHdvcmsuXG4iKTsNCg0KRG8geW91
IGV4cGVjdCB0aGF0IHRvIGhhcHBlbiA/IG1vZHVsZV9tZW1mcmVlKCkgaGFzIGEgV0FSTl9PTigp
IG1lYW5pbmcgDQp0aGlzIHNob3VsZCBuZXZlciBoYXBwZW4gYW5kIGlmIGl0IHJlYWxseSBkb2Vz
IGl0IGlzIG5vdCBqdXN0IGEgcG9vciANCmRtZXNnIHdhcm5pbmcuDQoNCj4gKw0KPiArCXZmcmVl
KHJlZ2lvbik7DQo+ICt9DQo=

