Return-Path: <linux-kernel+bounces-102105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800287AE72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1D0B24330
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042095C8EC;
	Wed, 13 Mar 2024 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="QH13WtVu"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A355C5F4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348669; cv=fail; b=EtWL0LZtfUvQceUoMdsQOFM06uoJp1zdnf1NXekz3rv1nx+F63Ks0/OPPA+4aeo8sknZJuhe5fzGV524aC3qHv5aKnIHR8CfAM/vJlrY3kEwPPRMaAzNNj706x5oslm8MYyaz2VOnGtMqzAEoIAL0fO/G8O7NhOFZP1A2ps8cL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348669; c=relaxed/simple;
	bh=dc+4jZk9Uk9Jt4zzklHMNEGJ0mAYjsDRRFi10DF/g74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upnNd1oP6cqzBvD/1sBGptC32mgKej2tWs4WA39zFQrzFS7U/oT7rM0YWepLse8O6qx85T8fFQtNv+K29fuy9+DnICQXXgXCwNxcJHQzsDnKaGEeUh+C5noT+fD//Xv/Xsma5TNjag8kS08Ypw1h98f9McuEg7KJKARhX8xfA38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=QH13WtVu; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWZ/riiHky3G0XFzE77fjKZeiqsxc+SA420z/IYIovogqbdzR6NLilhg0IO9ctQaqJIfoU41UNsxMP6FgeS5pz2h+wNTfrxzPkAO6MH1GzcuA7ses3SeevXz81BC02C2KD+UOykY8PPDk9tBmnmRrmMHXh51FKUPoiYbnHQUOtnTGtMzQR7Nbsr/zychn6oy0E+/zJRxzWtksfTt+GMlnTzllg9UqBuYCwUs8eXw2Qjlj8Kdf8sqpAwVS3oeMvP0BMeQYzyPfFBqItYxBJ1NFXaFVAEzf7vmTz8MtEAi7361pitN3fwELNq/tIQquOwjU9PzwUB3m2yj4ZKpwrNgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc+4jZk9Uk9Jt4zzklHMNEGJ0mAYjsDRRFi10DF/g74=;
 b=R2dAecL1cEFastAlL3uBjM+XvyvqBs/3s6xNCA2AmcPHW6nKFYn98nIrQC8r5g2l60rtQBlhxBTVvsY1UAzjSc0QQrRV9OEuFwuXaCcE3WvTdGPrK9mLLWOUUsYLXRSzjg0Ivt3mQBCHBJhOkE/SvGZGlumOChPjZI+8XQ0IU6k19ywhBvOokKU/BRflTVheFquUJgSV8Oken90/rNBIMCa2lvGceYup72MySx71lknIIrDdzD+M1zqbE8RArPBsvQbBk1UoQa5SR84ROvS6PSUym0GuVaTkok3FYyk3S79SOaTyztTHuCXuRAeANLwMUACfzw5MBPnAytaNnEcjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc+4jZk9Uk9Jt4zzklHMNEGJ0mAYjsDRRFi10DF/g74=;
 b=QH13WtVuj3jzzsrskNjZCRujm1ux4a2N9ZenKyCHg94cKzW0n8m+jiYSMPWdaITqNJC4tUI3qRNRJQQTGY1GMyxfEuyiJtStmR5PhTrLvPVEo5Ebm079vD1iVNjPtDL0cksClbQhKKLoZt6Kq9MiFEw7CvFJVVE37CpFykSMplulXJ4gFLT07wY2K7dzbQuPR4Xsz5kdxHh9kvBqCQ/gI61syM3e47rA5IsBNsjQyx9JyGvaLbnV8GQEziyhzwrEgY5pTl2JpbFHKHLoMhFUCpEdq/yx1TeLs7gcvnfLJlu2bQ6GHljD+3OwFT5z7PoKQh8WIbrTM2N90WoVV/xjXQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1610.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 16:51:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:51:04 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Topic: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Index: AQHadMy2AcD12Qgk5E+xVTk36tMlvLE1YVaAgABi34CAAB92gA==
Date: Wed, 13 Mar 2024 16:51:04 +0000
Message-ID: <d69aef55-9a5e-4965-a660-66cb2ee3d9c5@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-10-rick.p.edgecombe@intel.com>
 <615a783a-0912-4539-94bd-f1e09535bf38@csgroup.eu>
 <6457f3a65ebb25811ce57be9f8da39fe475496fa.camel@intel.com>
In-Reply-To: <6457f3a65ebb25811ce57be9f8da39fe475496fa.camel@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1610:EE_
x-ms-office365-filtering-correlation-id: ecfd203d-3e58-4479-010b-08dc437dc567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QSNLLhbyKtSZQvqOzkpw5d5b0H8OqdrWobfcCARogwvr5ELxmoBFZW995TWSc/b6VtVkqCYWn812j7O8ZfLglj47YT1XVDAw9roxtnQuAKauejjItuZ7AmXH4JO0q/b9lEog5v13epMw3tyqFDNlTu07AL9nf2+ZKp9YnTZFCAYjS35daWW7dwBhW+t05t2gjX4Otx2wt4oTk+w9hvMgvoIxD8+aZBWGc25DVq64F2LoOzgxLOqy5drYXko4cub1766YTc6KGvkrlQfGfHzmLc8U0+ZQL4MzSclrD8y9UOdr5z3HIyWU6eOV1GJ8z7dQQ/YaI2yec51eOm1BvqYJ+EDqDC9eq3goeEj8YiloKvGLDbXMaheT39lYXEG5s4oOaSUiEcISGm7Ct0CJB07nMYgwrmes9WdXQXuzukeYf+lLAqxNJvcGgsVAmLXcR+nV2js7XkePyDdEFgIju6vqabzXVoKgGsubw8cqppPN0U0/FZTEAzaK8Lc0oDuamkFV7WD6UjZKhMpS+jlNJW2SeZueCLHAT6w2tOrNn6LpJGewiH8IzWBhaDrBLyAkgBTETUppvQ++1qC9BQRN7PRatR1gtP4tc6k20WwH1c1qbmSMDcN4ChRzd7OoqD9Eku0FLBp7VSPXJcwNcq3v+OB6eUg5JlhG2KaceR2YW2HbmRRmfch1xg63jcCQMy4Jll4RyEwdMZdldAIcX5S9/JIshEZ4zBWYfVIeNBZegkBb5uU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzQ3R3ZQc280Mnp6MmpiTkRaTk5nRkdGRDZJK2x0NjZpUlkxOU1EblorMFJF?=
 =?utf-8?B?dk9YUFNjYS9GeVc1dUhGMUFaVVQyU3I2bFJPL3p3YXdub21IUlROazduRU9i?=
 =?utf-8?B?cHJDeGdGYm5wTU44b2w2T2cvQ056Vm5FSHdDOVJCQWxXOFNBbUorQUR4YTBs?=
 =?utf-8?B?SllLMkVvWUcyOFRKTzBkZ2tqdWNYT2NERjRYaTVBL2xKalVUa2g2V0dQckFL?=
 =?utf-8?B?cUJlT1JnTHpDdmp3cGt1UXJmSGEzUS84bTVqUFZzbDRMS0hMN0JmQjFSRjUy?=
 =?utf-8?B?VkVycmEvd0JmM0Fva0E0Rmp6YUJTVUJOcW1rdkQrc3ptWVpIZHdqK2szVURr?=
 =?utf-8?B?bUJTUnQ1TENra0VaMFBCQlVTRFg5dXVORktISUhCM0dIblJidllJckJZaGNn?=
 =?utf-8?B?RktpWk1VY3lrSmh0S1NjdzdENkdmV2FUNHpDYVgwVFgxTWJlVm5adXg3ZmFV?=
 =?utf-8?B?b1ZkakNBdDY4R2V3OUtkSW83K2loYWgyL1FHZDd2eTNLWGtRQ1pucUlpaElO?=
 =?utf-8?B?Ti84ODdEeHZSamZlRW84aGlObVNraFZoYWlaaGxqMDVoOFIvcU1vUVdCWTJP?=
 =?utf-8?B?djVib3R4cE1oQWRlR3VUL1c1cGZkLzYzNUExcWs5bWdrd3JDaGgzMHBRdTVp?=
 =?utf-8?B?dUlMcGorVHlzUjVFUjBWV1F1aXdIMmgwMFI1Yk5rOTBGcWUxby9ta1hvTHFo?=
 =?utf-8?B?U29QTURMcVcvZFZUZ1BTNDBCcVVvZVRKKzFkTWJUTWJXcGxKakthblZDTEJQ?=
 =?utf-8?B?SGNKSDVsaEh4MzFpcWV6U2t6RmREaWJtS3NnNktrbk9uRkRHc21VY21CUmp5?=
 =?utf-8?B?TEdXa0NMcEVSQ3R1YTVWeTNzTGNQVDhWWjZvTG5UVVZhcEl5K2N4WkpYQ1Zx?=
 =?utf-8?B?R0VkM2NUK0ZQdUdwVW9CRGJQK3lYRWIrZjN6czBwbmZta0tuRmh4RjVseG5h?=
 =?utf-8?B?ckZvZ2xFc3pKOFFqb1VHbmE2WVRtWGtHLzlTV1U4anpzeHFuV2w3dnVWRXpX?=
 =?utf-8?B?OXJGQVlVKzkzenBScURzanQ4UEZPK0ZzdXdEZG5UajdyZFZ6RG9JUVhudktW?=
 =?utf-8?B?MHB1WFRLU1pCb3lQRVVnb25pak5uSDZqVmNhR0tlRmp4UVZSWTJLdExkd2RE?=
 =?utf-8?B?ZUpxZjlITzZZWXAxd3ZhRFR2bjFTdEhhUXlXSG1sWEJSQ1B3S3p5OS95bnB2?=
 =?utf-8?B?TjA4UDhCTzRNQ2FzUkJJZGptdzdUanRmNEVFYnBJdjNtSGJEVXlBWWRFczBm?=
 =?utf-8?B?K1lIaFVGRkJrTnA3amwvR05IUkFrdTFobEFDWis3OWthRGQwVlo4THlVcWd4?=
 =?utf-8?B?bzZkcFJpYVN0dGtTQmpwcW5NdVd0SlhINTZFVDFWZE5rcGRDTjdqVkFxQ3hD?=
 =?utf-8?B?cnhhNHFlRDAxM01May9JMDUvTW5NdGZsOVdNWjZ0V09SUGM4N2xXTjYrZVQr?=
 =?utf-8?B?RWRaKzhjSHpseS9LL0x1L2I2TmNLWkN4NThZQjAyVVJhbnpwWWhwcHUwdEJt?=
 =?utf-8?B?SVNwc1laZEI1YXd4VVRiRXAzSUJiekRJU0hGanRySUVHUXRpYkp4MFRTN2hr?=
 =?utf-8?B?UEpBbVhuaGZLTUprTGI5RmxBQzdjRS9QSnNNakVlY1o0Wjh1b053a0J5MGRq?=
 =?utf-8?B?OEdDR3FXck9pK0sydnErenBlQXdzOTlOS2k1NjhBS1B3YnRDOHRYOGFUM1Z5?=
 =?utf-8?B?TnJSOHYwdElpUTRJcmFYNXZmQ0xmMXpYbVV1RFlaZkIwSmZ5TE9GdDFiU1V0?=
 =?utf-8?B?U1U1MGxrcm42VmVVWlNHalE2bGVrYXRwN3RBamxQcllidkx4bXRwWHpBcElO?=
 =?utf-8?B?aXVWajlJNGpmTHlodU9tMGpEem1VdHY5eFRLS3hhRTRxa2ZUaWZpNnhzNlNZ?=
 =?utf-8?B?cVNyRGk4RFBOZlhqaWdIR3piYXI2emh3VytFNXF2QUp3em9xYnV2S3h1L0Zv?=
 =?utf-8?B?TmZIMkxYNVJkSkR3SVlwakdHK0RQck5sWERJaFQ0Z0xiYXV6djkrcXV5SEdJ?=
 =?utf-8?B?NlgxQ1FrL1lrMzh6Tm41amhMdmE5WnpVNlEzTytqb1Z5NmI4ZFFONjVERUt6?=
 =?utf-8?B?UGFkTTEyRkRCcVRGcXh2WWpEZmdFOFZ4VTdWVVBObTQ2bmdsL2p4TjUzVmVo?=
 =?utf-8?B?cSt1TzhRSUJ3b3hSYi8rVjBIVE80TGEwT2RnVUNEN0V4WG5hOVlFdklkWlFH?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4EF80ADEAD5F74BB1C9BF391C65994F@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfd203d-3e58-4479-010b-08dc437dc567
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:51:04.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVdbuW9wFQfjcIRzCFgZd36WDkS1UbDl0XcU7tRfVhjMNFFqNI6hK49TusY2Wb5f4vYpzGi6nUy5jSThtdt0ZnYQIs9K5e/5cDKKTWv/PU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1610

DQoNCkxlIDEzLzAzLzIwMjQgw6AgMTU6NTgsIEVkZ2Vjb21iZSwgUmljayBQIGEgw6ljcml0wqA6
DQo+IE9uIFdlZCwgMjAyNC0wMy0xMyBhdCAwOTowNCArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+DQo+PiBPbmx5IGEgc3RhcnRfZ2FwIGlzIG5lZWRlZCA/IE5vIG5lZWQgb2YgYW4g
ZW5kX2dhcCA/DQo+IA0KPiBZZWEsIHNoYWRvdyBzdGFja3Mgb25seSBoYXZlIGEgc3RhcnQgZ2Fw
LiBJZiBhbnkgZW5kIGdhcCBpcyBuZWVkZWQsIGl0DQo+IHdpbGwgYmUgbXVjaCBlYXNpZXIgdG8g
YWRkIGFmdGVyIGFsbCBvZiB0aGlzLg0KDQpPaw0KDQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhl
IExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQo=

