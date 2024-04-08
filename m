Return-Path: <linux-kernel+bounces-136017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A289CEF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EC01F24EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21C1146A74;
	Mon,  8 Apr 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rEg31R6z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2063.outbound.protection.outlook.com [40.92.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DD171B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619090; cv=fail; b=GPeBvEfpvMuRVUYn0yyMl8Hlqm/o9Qvj3oX5WkLaQDAGkJzXA5wfJ3VR8F705+39F19YvER0Pa5tGomSWczY+MCjrMqXETWrIzMAObYdbgs5N0RsrBRg4YFW3+PnjtKXO1wqc5BPFBfOuOmOUxCwD0BbT02AIDcmJRM4QjcbtCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619090; c=relaxed/simple;
	bh=aNX9JzDS9So9WdNi9syb1lblhkdsDclCh+CbGIwDY2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1mTvN4hHRwoBZ73kD7FnA62lz9oNxK7yk/CFriTTAU/53H/Ddv8du5/8o9C1wHDCel012nVhXUtSVHTqH1/Ic4zujX4PqhlJnxmRX1CwrvjopGuMrOW0XaXyTwi3OVCohVmYM2q9FyI1n1Y74q5nzuX8028Hb6vaB6dZib7esA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rEg31R6z; arc=fail smtp.client-ip=40.92.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRw83FI433W1JuqnARcgFuiONxJXLMSLMfqywQoxeYr1m+nrwTLxy1PB6GCMgVL/w+pSab4piCKPPtl3cCzCTDJus5HqiCRCe7dacz5m5Xidjy6OuxeJhqSnm+s6OQ1vdDJxgm7Zjuw7yHiARTz7epuVOVIkV33wTb4n4MUzx8i3R1ELPuFrbmCRxextPJiozf4LbbCTjX6uf0tNLCIALvnCBzFXSSrXXPtR0d303sOnHkdxWsFLgJt8pehuVfB8MhHgTk2CrBkj9HlmajMQMGdJ5bmLUlmOpw/b8ERZRXk++Q/V0sM47xSyQivmya9pfvVR6s5D0oKDCApFNCmD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNX9JzDS9So9WdNi9syb1lblhkdsDclCh+CbGIwDY2I=;
 b=OlFA/su4BtR9CefB1ajPMDx2qSE/chw8/zwOpi3EMG1bbtKUyforwawA3CvXP0J6yGbp//a2kMOncGlr/jwieWKKpCdmN8mQ4NZtN7wLNrcTS69Pf9ZRx5IEhcbqgjBKl/m31N6/8nLU+Veadz6JnaKmAyBY+ARLMJA3/Ttsp3zyXlKp0biYJixyTiiQ8dB62ZGvMOYK6NFcsqd2rDqa/IiYKBZiO/NWQCaI3RlG6KQqBV6EPv+6yORHELMd0NEL0x4paNGq7JS9xq4U90S0+YDVBLRfGNwUEKT1lEm1S2STd0iK4WCReym4I5XKirBRsGGJxmKD2CrPPxqp7TRYpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNX9JzDS9So9WdNi9syb1lblhkdsDclCh+CbGIwDY2I=;
 b=rEg31R6zIKmH874wpEYA3tv7G9csN5vuOIC4MpZJpaE/kOjHmrc+0c4SkePEO8pTdXGgGWHXZMaIeVA2dm18X6zQIZqm/OBDHIDhnf2V8vxlrckOYDjLUIcUEJ1mjcSC92T/mm0KqUeACdstUjB7BNHzpZqlgC/VL2Fp07kYGsa7iHmyJOwW3Njdd7biOB4v/2ix9xq2R7IruPjkAFRYlp7bEuMxY3bu4n1/ji9gDfqTr7hjROfJrgD6ZaHhoPl7Jx+P1raqUKXoZhXjiPT4PFMNxh9ZjWZQf1pY30kiwUPeRK6Za+MVoWNPRrrs4kmFKKT1L9plPJET38VWbpygmw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7473.namprd02.prod.outlook.com (2603:10b6:303:65::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 23:31:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 23:31:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dave Hansen <dave.hansen@intel.com>, Sean Christopherson
	<seanjc@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>
CC: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Topic: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Index:
 AQHafh5br9v5ziibjkOOzawG3mO/srFH4YWAgBB5xoCAAAgygIAACzgAgAAB4kCAAAl8gIAGoO0g
Date: Mon, 8 Apr 2024 23:31:25 +0000
Message-ID:
 <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com>
 <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
 <Zg7jLn-lV55Yh6mH@google.com>
 <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com>
In-Reply-To: <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/KANODJJTq8a0NhTihdqRUOp5QJLpsE2]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7473:EE_
x-ms-office365-filtering-correlation-id: 631d123d-f684-4df6-40c6-08dc582401cd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nIFjiN5+n2cdQ/53t8WFjkKIjPNcf4nDVv3w+GfFxNcGr1khaD6pETFqktwhTXw061Y7bWypbOgaq9tiSbLJukY6KRQrEvzdVDBm6vIGBmIxrfpocKPjvPwgtI61I7iVAw4LsC8CQ0LSRQOx4ty8b+n43NqxYA+5SD0lAyWreVSJ9s6zDDaA34F0XgHln8hKrTrl+Zo0rjn98uJtw/mPESzZLJMxiP6g89xmbVf0WayX8UR89wkAspn1hoV3jN6nygTOuvhsaeoYwfV0hisFQQAagKz8y+QfKrsFlt3aIsX9w1dp3LLP3MpM/VRYbu/gReSAzH87KytVWPmYAlungZNoI/BcYsYwZlV5xlIwpOjX1v2/CAoHvpdVvWHDSQs59+z1/4xNWmLggLH7hiwWLgij7Ma2MXnhUdqtDRT4LeoM0/87EfFC7TI7l8M/a5+9UdQ9xqQrUk6E+YHMtJ6VOcGBRro8Y95sFOjXS+uX7NPeuS6iihuBQCPvVOE1P0wD+HS+e9CKXh3aPBu6XC7Miuyl9S0Z0QMq9K0X1VJspuW72R15ChKfv79IdhZKmOe7
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFNSY1BUVEp5ZWVPOVV3d0xISVRiMThVRjJYbm9JTTJubk5DWTd0L21XZXI5?=
 =?utf-8?B?MTBBajRKa212MXRQLzdtVEM2Z29Ka3R1c1dNeng1c2R4OHNWOHNLcmRwTkRX?=
 =?utf-8?B?djdNa0dZdC84MDlPTEVaQWhRWWFqb0RrekcweWhmYkh2ZFpaTG9pUmhaVENZ?=
 =?utf-8?B?cis4WVNiV1gyVkJvcytDSzRBY3JUSGMyRkxuRkdMeXlpLzRzTFN5Yi9YNE9V?=
 =?utf-8?B?OVRsUEJ1Y3ZybVhySHFYcHJLOGVrdEUrME1hTngwT1UyeDdvdG9EZG11UkJn?=
 =?utf-8?B?RXladWNjS2lPc1Vwd0QyWG4zU0hmR2FyR1NDL2VwVFhVVmY5WEg5SktaMDBP?=
 =?utf-8?B?Vk13SWxyeUo3M09ocHhpMEl0OTJxUlJObjIzR0taVExWNlNabjdZUDdlR2pa?=
 =?utf-8?B?b0tYdEgvMVFNallUajdqNGgydi82UGdWeEtOT3RBMGRnNFBUNjZNV3VFbVpw?=
 =?utf-8?B?Z1FJMmhWdEdqblM4d1pLRXZmNU03WkpNNW11OHN6M0FXbllNK0dUQ0lUdGNy?=
 =?utf-8?B?bTg1NDNCMUxGRVdkSGJQU3pvcjllWit4Q3dHYjZKZThCQTJFSTltaEJ3WVo5?=
 =?utf-8?B?S0srUVhHTVJ0cUZqNGo2NUxhSHl2YXFXSlAyTll5bWxFQkZVaHkzNVY0UFhQ?=
 =?utf-8?B?VXVPNHNZNTlCRnUzSmFvY2NMS09SYURGdkVNemIvTkJERGJEd3d1Z3dyY0dv?=
 =?utf-8?B?a3dGcWJFMDcxYm5JN0J2dXpvei9FYURvOTVaZVhociszZWtOUFdUSU04VXkv?=
 =?utf-8?B?SUhPdWoyOEpXaGJOZHZpdjBWMHdxYTVCNGZ6SWJsT20weDYzWnc4OUhCVGlq?=
 =?utf-8?B?bFBreGlmVHp0dVZEWmwydjNUN3FLTkNoRW0rc2htR25EcFlFUGJoby9uakZX?=
 =?utf-8?B?Vm96WFJzVXlrWUlhQkhwOFFucG5RSTdQaTNvd3NxYVhrcTU2RldwSzU3S1Mx?=
 =?utf-8?B?T3BiOFg4WXV0Y25MVDlnQ3VmMysvZmIxU3ViNkwrWkNZZ1JuMGRNL3FjbklX?=
 =?utf-8?B?aVVrYW9VM1IzRm83bG5HME9SYlUwNjFNdFoyb2FkVGlkRUp2cUJDVWRnT1pq?=
 =?utf-8?B?UWtqam9MdmNQQjhIYnlmOFgzNDVoMUJnSGNlL0UyS2Y5aXRYWWZXeHhHZWcy?=
 =?utf-8?B?alRnK1NJV0k4N2RHQkRpR2NsdUl0N0RXL2FuUjkrREFud0VqN1I5ekl6RHhC?=
 =?utf-8?B?ZUNGN2s1bW1QRmZTRXIzZy9JbE4vM3JiYnU1a2JIQXVBRXZITmp4QXRIVHRC?=
 =?utf-8?B?YnNwTDZCUklxY0FOUXMyOElYZEs0THdvbW5YN2pyTkdsZjRjM0ZzSEh2STZD?=
 =?utf-8?B?ajZSZ3hjRFF5bmJDV0dLRW9JUFRxS1dPQ0RKMVhHZFJNMklmSSt6T2d4aGVT?=
 =?utf-8?B?VXlSTS9mVldTdVA1V1Nmd21pRFRtMHZVM3BsUzY2YytqWXE4ZktXWExINVI0?=
 =?utf-8?B?SkZBWmlIMDdrdjFxVE5OWUpjNjRFZTdhMTBqU1YvVDdFRUo0YVFrSUFTTmVa?=
 =?utf-8?B?ZExuZVdsSHcweUVjVjNhRklIRjhJMUdFUUVpdkRORlllYUtibFJnRHpMc3JU?=
 =?utf-8?B?NVkzTDl3aE1QMGtNYktYMkc0MDdIMzk1MFZvdE8vWmN5Z3BQUk82aU8yUVdT?=
 =?utf-8?B?WnVvOW5wcTdyMThkdnRoWkpqWVpTb0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 631d123d-f684-4df6-40c6-08dc582401cd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 23:31:25.1669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7473

RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gU2VudDogVGh1cnNkYXks
IEFwcmlsIDQsIDIwMjQgMTE6MDkgQU0NCj4gDQo+IE9uIDQvNC8yNCAxMDo0OCwgTWljaGFlbCBL
ZWxsZXkgd3JvdGU6DQo+ID4gSSBhZ3JlZSBvbmUgY291bGQgYXJndWUgdGhhdCBpdCBpcyBhIGh5
cGVydmlzb3IgYnVnIHRvIHByZXNlbnQgUENJRCB0byB0aGUgZ3Vlc3QNCj4gPiBpbiB0aGlzIHNp
dHVhdGlvbi4gSXQncyBhIGxvdCBjbGVhbmVyIHRvIG5vdCBoYXZlIGEgZ3Vlc3QgYmUgY2hlY2tp
bmcgRk1TIGFuZA0KPiA+IG1pY3JvY29kZSB2ZXJzaW9ucy4gQnV0IHdoZXRoZXIgdGhhdCdzIHBy
YWN0aWNhbCBpbiB0aGUgcmVhbCB3b3JsZCwgYXQgbGVhc3QNCj4gPiBmb3IgSHlwZXItViwgSSBk
b24ndCBrbm93LiBXaGF0J3MgdGhlIHJlYWwgaW1wYWN0IG9mIHJ1bm5pbmcgd2l0aCBQQ0lEIHdo
aWxlDQo+ID4gdGhlIGZsYXcgaXMgc3RpbGwgcHJlc2VudD8gSSBkb27igJl0IGtub3cgdGhlIGhp
c3RvcnkgaGVyZSAuLi4NCj4gDQo+IFRoZXJlJ3MgYSBjaGFuY2UgdGhhdCBJTlZMUEcgd2lsbCBh
cHBlYXIgaW5lZmZlY3RpdmUuDQo+IA0KPiBUaGUgYmFkIHNlcXVlbmNlIHdvdWxkIGdvIHNvbWV0
aGluZyBsaWtlIHRoaXM6IFRoZSBrZXJuZWwgZG9lcyB0aGUNCj4gSU5WTFBHIG9uIGEgZ2xvYmFs
IG1hcHBpbmcuICBMYXRlciwgd2hlbiBzd2l0Y2hpbmcgUENJRHMsIHRoZSBUTEIgZW50cnkNCj4g
bXlzdGVyaW91c2x5IHJlYXBwZWFycy4gIE5vIFBDSURzIHN3aXRjaGluZyBtZWFucyBubyBteXN0
ZXJpb3VzDQo+IHJlYXBwZWFyYW5jZS4NCg0KWGkgUnVveWFvJ3MgcGF0Y2ggaWRlbnRpZmllcyB0
aGVzZSBlcnJhdGE6ICBSUEwwNDIgYW5kIEFETDA2My4gIEluIHRoZSBsaW5rcw0KdG8gdGhlIGRv
Y3VtZW50cyBYaSBwcm92aWRlZCwgYm90aCBvZiB0aGVzZSBlcnJhdGEgaGF2ZSB0aGUgZm9sbG93
aW5nDQpzdGF0ZW1lbnQgaW4gdGhlIEVycmF0YSBEZXRhaWxzIHNlY3Rpb246DQoNCiAgICBUaGlz
IGVycmF0dW0gZG9lcyBub3QgYXBwbHkgaW4gVk1YIG5vbi1yb290IG9wZXJhdGlvbi4gIEl0IGFw
cGxpZXMgb25seQ0KICAgIHdoZW4gUENJRHMgYXJlIGVuYWJsZWQgYW5kIGVpdGhlciBpbiBWTVgg
cm9vdCBvcGVyYXRpb24gb3Igb3V0c2lkZQ0KICAgIFZNWCBvcGVyYXRpb24uDQoNCkkgZG9uJ3Qg
aGF2ZSBkZWVwIGV4cGVydGlzZSBvbiB0aGUgdGVybWlub2xvZ3kgaGVyZSwgYnV0IHRoaXMgc291
bmRzDQpsaWtlIGl0IGlzIHNheWluZyB0aGUgZXJyYXR1bSBkb2VzbuKAmXQgYXBwbHkgaW4gYSBn
dWVzdCBWTS4gIE9yIGFtIEkNCm1pc3VuZGVyc3RhbmRpbmc/DQoNCk1pY2hhZWwNCg0KDQoNCg0K

