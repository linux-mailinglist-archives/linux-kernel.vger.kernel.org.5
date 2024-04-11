Return-Path: <linux-kernel+bounces-140058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803D8A0AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DB01F21CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4413FD6E;
	Thu, 11 Apr 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="l9lcOn+V"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B12EAE5;
	Thu, 11 Apr 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823184; cv=fail; b=XrTF4Iu9aEkEsu/81a16OerVsvlQgH2eLn+6MrM9cb6/D6VoN9AUDKldGZwqbndnxGc85tJggpX/yZrNb6/AtAPagwxfNIUs7365cOGtRjTU+LhpVv/SfRfmcOyYRP+vxKvDPSYN+HjoUR08t0dGGiaM+W3oiM98a1q72Ns6kwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823184; c=relaxed/simple;
	bh=koK6a8UOYKQJ/PUsC+eUTVUeKbRyJmYEr/E6W4xIUCQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFoGgVOEhVoSv8NwDykqJLP184ot88RO6Wu/ythJRqxwIdobiWGlcjdYbJfZKEzsjTPMJDQ2MQES9pQfjeOVtvYxaRKLaCiJkBG3tanlMtpJdHL+85hIrfoIakcHpbU2BU+LmDRrvR30M6MoZYFLI4UZ3BwZNih2AGMAKdCIl8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=l9lcOn+V; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk4xo4HDhkgI74hOs1BC2KAxdz0YW2zHcuRP2FXrVNrBFw2PD7gUfZbSGVE87C7U01RGvUFMreaWhhWxWO9oZ++HoD2uAt0JS7O+MkBfmCFmQ1aiUvefzdgSSQfJ4O6BwfEQF1bR1rJ5s/rFq1WoW5mfWB43mNFwthI1gGY8YTqZPHGgqEzM031AEqa7o+SbAF7MiuZw4BOzR7z/yrqbiYiX+25TVXcBDTmWFyJcBPw9LrzbN5od0JvTAG8vGoE1o1a1g2x/n9u1DbSlH/xFVUkGm8qMRj8z2W/ydQtJrGoaBIklo1Q6ZWiOMvsKC40/oI92EKhYFv0HDFVrNSkXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koK6a8UOYKQJ/PUsC+eUTVUeKbRyJmYEr/E6W4xIUCQ=;
 b=YWxrEsF8JO6gKtH8MiJEmA/xWdAKvPo9DDRNShG2Scc45lVjzpD2VZFcag0oA2jY7MAcLSsasuBXF8XxhW+EZf9jczoXUxBvYtv1TIq8mMoBT3MZmdgViIHSwn6jCTuo2p3RrzC+yMx810Dnjg5ONeLxCBrIWTas0YlXtGS4I3gFwv/qSRwBEpbNu+8d9nJQ7OaNp+4AxBuo9FrGmW1Xg+zuivcMnccqPnscOlebcwO3o25EZN2wrEbOEbFVulJsE4g040UgSLWQi5xGZ3befC84i9m1k7CELpP6XhOP0aY5qt5z4zInBlbNgnwjKN/6MhbtoPArXpt6NotesyzKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koK6a8UOYKQJ/PUsC+eUTVUeKbRyJmYEr/E6W4xIUCQ=;
 b=l9lcOn+VIlYi7HROuw93iocyrp94ymJPyyV4NDGQed3ZxZrzXDT7SqWIUn7eOg7ON1STjyGefgpj+oSD0OFYlD0MYm5au2LzmmCtzRofeHOl/YQzbfiCTw9rCIHelSaBIx+Xw/33VKuo+ZepuDsqmozWJ1XkKHmRL/3DHxF1osVsT5cJOuD018/leWv879Qk6N9ny65mE9pF4P6fpa+NZdI8e7MUb59YkbKbYTHajGYYid7CSMM+J6wuAbPjZNJoHpkIJnn72D/IdixDknLBXHVXgf76W27nvh8oP1S9QSFEZ7quHQLFUkFXdqZwRlhRFOW5nCtiyqepARVlkpenEA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3360.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:13:00 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 08:13:00 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, John Stultz <jstultz@google.com>, Stephen Boyd
	<sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
	<rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Anna-Maria
 Gleixner <anna-maria@linutronix.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Thread-Topic: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Thread-Index: AQHai1xRYzjVdYtCeEepwMKzYWvQLLFipl4AgAADMgCAAA/YgA==
Date: Thu, 11 Apr 2024 08:13:00 +0000
Message-ID: <a434248a-1e9f-4f4f-8f90-d36d8e979f53@csgroup.eu>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
In-Reply-To: <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3360:EE_
x-ms-office365-filtering-correlation-id: c0921e86-58f8-46af-de7d-08dc59ff33cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BBPoLzeeo+SAFKYCOqeeyyJFHemfDEMu3S3W1FMsoOZBWRgw3C8BJm2YJgaD9Jj5y7RW3IWLceOfemIeKFAEGXR/Kb5GYNMj/2y5GN08/+mhUGEkOnLOGjFWnk/RRKoCi746thcLL5GprYBL/lmiVWvOio6FSn7Nz3XKexG5fI6vLeffviuitn49BLJNCKfIEv7VKYnlDjk9LjiBsgg8xOrNrmHzb9oxDMz/IK0pM423Mcib1atQLbSnR/h5Bck5JU8o3xqhcbnBbSA6wBlo+od0KCg8oLeLyCr3ZTccnKLZAy0wpVrYVYx6+YfF7RmhPmLvMrMlfY+Pob+xLaPnBcNoPdNFaGnQ3fH0lXPr/GRDuY8vwunU8Ca6xzL3GSq26cFn3xDP5Z3lVnAJJ2lPS/VcAqQmJ6j4i0Ix7FPt9g3ERfO+xZyLXGiTINtHffpvsF/ugIaN/DX+feWtN5oMER03+vGuaOlxD5dQcPY/1GYH9jEtOZBQjdDlS9HcbOWwq6STHoCdg0dsTZbH7OAaDD+pnaVTZtyJjTvMFh4ozUSofYy0PrwyxzulAv4jF9T7SbFB1CMa4SwOKgG7PqxWrl/ThztpVYDSE+OYAL1LawJDt7916RiMVzT6q78kQewDUE2ie82KVUdntZlcLA57wrXj/KBPY+kBiD6DA0DaJgo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFU5RldRU09PNUcwL0ttSno4Z0VjUFY0K29wc28vK1RKZkN0R3lnNmNFWnJw?=
 =?utf-8?B?OE0xSVRNMWQ3dE9HeGtaVWlOT09BTjZGRTM3dUtKaXlQcnpjWHF6cDZ1ekMv?=
 =?utf-8?B?dmNTQ0lCNnZpVStPWkZ2dkI4NkVoMUhJaUlRN0pkVSs5QVlIbTVhT0FqbFRt?=
 =?utf-8?B?Uk5zVUpJb2FjN1RONnJHL2NkQ0M5YU5pUER0a0s5LzlReWVvcG5PM25qbjF6?=
 =?utf-8?B?RzcweXZ6Q1hNUCtFODlPQ3RiMWJiai80RlZONFBENTdxaDZkV3VRU1BnbXE5?=
 =?utf-8?B?aGMwRnBJZlZLZXlTRXJPdkRjRlNHUGREVzhDVnZKc0FvUUFDb29SaHdwYXFm?=
 =?utf-8?B?V3dlaEJYd2hNRlZta1pEYXN0Y25IeUppVHhKNHRWMHdmd1JRNlBBSDJ2NzJm?=
 =?utf-8?B?Tk9uZFRtUUh1aUFHNFZaUTAxZmlzeTUyS3J2SHlDTmhFTHFlMmVPUmczMEZI?=
 =?utf-8?B?TXBzMDUyWXcyL0t2dktNT1lxRHRjRGdMZjEzMkpGQ2o0eDZjTUhGNGRaRllG?=
 =?utf-8?B?OFlzMVI0aDd1RlQ1K1duTC9UWTI5cmZRbGtZTC80eHp4aTc5OTZqaTk1QVZu?=
 =?utf-8?B?ZkRlb1duT1VSVVFTcnVtYUcrYVJLcisybTFoZERtRnhhdDk2UExTdDRNZUJi?=
 =?utf-8?B?UDBqNmJkaFNxY1RhbUdHV200b3VHVFFWZVRNOUVuSEVNVXBSSy85V3dpbDM3?=
 =?utf-8?B?UHEvQis5dWZjbUVRRHc3cW5ld09GZFljK0RORHhydklGc2dhSCtqbXprbWp3?=
 =?utf-8?B?Q1h5a0FRb0lVY3NzVDRNM3BCVDZqbEh5Z0RnekZRZDZ5Mnd4OTRzeThOSmtL?=
 =?utf-8?B?QllJbmdaazA0OW1mbzJEK1lLSlpMWTVNT0h2WDNleVpOQWZ0SXBQZjhGSTlY?=
 =?utf-8?B?WTFlMGs0NlJjbWE2K3ZkUzJaMVlmYTNQQUdMR1VNWHNUMllBdThGR0JxR2dm?=
 =?utf-8?B?cTZMQTNocTNReHRmV0tzcVlTUDZYVVVFejdhTEZzZlRxZjUxalhoSGF1amM1?=
 =?utf-8?B?QUl1N2pBdWp0ZWZFMVVMaER6ei9QV1FDdm9GaFBlQTdlaXhvMUU1Qm1RSjdP?=
 =?utf-8?B?YjdOeHBtdG9lWXVCU3hjZkVFb2drOUNvQlduWUlmY2NPTUc1WkVMUHVFV1F1?=
 =?utf-8?B?dXo4ZEVySGtjRW9zUytsdVFIM2pmTGRuT3BiRXB5NkQ2cUwyTmRRVHBEajFR?=
 =?utf-8?B?UEs0TU9qWkppUnhpdU1XU3IyZkhrU1gvNkQza3J2cWdBOUtmS0V4OEhhRDR1?=
 =?utf-8?B?T3lVZUtBOHF3SXVQMnloaDN3Zk5uaFNURFJ2czhLYnpQTUV3TE1sWmZFbnBq?=
 =?utf-8?B?R0ErOHQ2aXp0WTVLVHJIeXQxelltOVUwK0VSTUhRdGhVYkcyajluN0Z4TzlU?=
 =?utf-8?B?Ri9vOTZLelY1Y1NPZ2xHbjMvQ09CZVVxaEIvNFMxb1RibXBiQngwYUdqbGk1?=
 =?utf-8?B?RFpIN0luVS9rSDBxajFPRFlObEpzRThTUVVuMXIya1JSOGd1S0pkT09KQmFJ?=
 =?utf-8?B?eTNTbUZlblQ5V1BZQmcwV2pMZWlSeFEyYUNidXFmZHpVc2V0UGY3aWlBUVlH?=
 =?utf-8?B?aUMrWmtiQ0NoVmx5TVhKbFdLdzg1YXRmVTJRMlZ2Nk9zMG9SRDhsdzNJOGtx?=
 =?utf-8?B?dklkbWdqQkhrWEtSQTVvaVl6dUI0RDhXeUdhSEd3WFlERmJWVUcxSGhzWmNh?=
 =?utf-8?B?NEJLK3I3aEdxbTUrQW5iNkxDU1dpTFJ4dVVuR1l3QnpCVDBzNEZTaWRwWTNl?=
 =?utf-8?B?SmpZZEVTdkRlYkgrYmQ5NHZ0dDdRSnY0dExVeEg0aFBCaXcwb2tsc3R0Ykdx?=
 =?utf-8?B?Tmp0QkQwMjBtOE0xN2trUmgwbC9za0QraGkvUGZUb1p4Q3RMZU5MWlF0QzZq?=
 =?utf-8?B?RjdRNTF0cVByU3NaclE2UWJMZE90MUdrRVVKOVhPVTBZV2dvZ0IxRktsUTJJ?=
 =?utf-8?B?S3NKbzRUM0EvUGZlc3Q0R0ZMVlF3RzBhL08wSU1SWldtSG9maDMxcDUrQkpE?=
 =?utf-8?B?Vk9iYXUzUDMwYlQzeXBQRVBEQVNTK3pBcDBlWXlKY2hva29NQThQTy8zd3VN?=
 =?utf-8?B?dGlPVHpUdkFHZmhtMlVqWHYwWmtXaEFXR0YzS1FQUmxvN3lYMkNtS0dOcVBi?=
 =?utf-8?Q?ZsPnu4dti3CgC36kmV55rO233?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C427D870CB1A6543B3011634FFB090E5@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0921e86-58f8-46af-de7d-08dc59ff33cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 08:13:00.0255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddInuKTAlBL/9fnMRcfMpPvjkBHDY2nkmRiKkRHS1jEHqHZRW3ZA4cuyMcdhQxDyDVMMvqMg3+a14C2RSy8+ciViIoJDvpnqg8G5qT1Scbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3360

DQoNCkxlIDExLzA0LzIwMjQgw6AgMDk6MTYsIEFkcmlhbiBIdW50ZXIgYSDDqWNyaXTCoDoNCj4g
T24gMTEvMDQvMjQgMTA6MDQsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+PiBPbiBXZWQsIEFwciAx
MCwgMjAyNCwgYXQgMTc6MzIsIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+Pj4gQlVHKCkgZG9lcyBu
b3QgcmV0dXJuLCBhbmQgYXJjaCBpbXBsZW1lbnRhdGlvbnMgb2YgQlVHKCkgdXNlIHVucmVhY2hh
YmxlKCkNCj4+PiBvciBvdGhlciBub24tcmV0dXJuaW5nIGNvZGUuIEhvd2V2ZXIgd2l0aCAhQ09O
RklHX0JVRywgdGhlIGRlZmF1bHQNCj4+PiBpbXBsZW1lbnRhdGlvbiBpcyBvZnRlbiB1c2VkIGlu
c3RlYWQsIGFuZCB0aGF0IGRvZXMgbm90IGRvIHRoYXQuIHg4NiBhbHdheXMNCj4+PiB1c2VzIGl0
cyBvd24gaW1wbGVtZW50YXRpb24sIGJ1dCBwb3dlcnBjIHdpdGggIUNPTkZJR19CVUcgZ2l2ZXMg
YSBidWlsZA0KPj4+IGVycm9yOg0KPj4+DQo+Pj4gICAga2VybmVsL3RpbWUvdGltZWtlZXBpbmcu
YzogSW4gZnVuY3Rpb24g4oCYdGltZWtlZXBpbmdfZGVidWdfZ2V0X25z4oCZOg0KPj4+ICAgIGtl
cm5lbC90aW1lL3RpbWVrZWVwaW5nLmM6Mjg2OjE6IGVycm9yOiBubyByZXR1cm4gc3RhdGVtZW50
IGluIGZ1bmN0aW9uDQo+Pj4gICAgcmV0dXJuaW5nIG5vbi12b2lkIFstV2Vycm9yPXJldHVybi10
eXBlXQ0KPj4+DQo+Pj4gQWRkIHVucmVhY2hhYmxlKCkgdG8gZGVmYXVsdCAhQ09ORklHX0JVRyBC
VUcoKSBpbXBsZW1lbnRhdGlvbi4NCj4+DQo+PiBJJ20gYSBiaXQgd29ycmllZCBhYm91dCB0aGlz
IHBhdGNoLCBzaW5jZSB3ZSBoYXZlIGhhZCBwcm9ibGVtcw0KPj4gd2l0aCB1bnJlYWNoYWJsZSgp
IGluc2lkZSBvZiBCVUcoKSBpbiB0aGUgcGFzdCwgYW5kIGFzIGZhciBhcyBJDQo+PiBjYW4gcmVt
ZW1iZXIsIHRoZSBjdXJyZW50IHZlcnNpb24gd2FzIHRoZSBvbmx5IG9uZSB0aGF0DQo+PiBhY3R1
YWxseSBkaWQgdGhlIHJpZ2h0IHRoaW5nIG9uIGFsbCBjb21waWxlcnMuDQo+Pg0KPj4gT25lIHBy
b2JsZW0gd2l0aCBhbiB1bnJlYWNoYWJsZSgpIGFubm90YXRpb24gaGVyZSBpcyB0aGF0IGlmDQo+
PiBhIGNvbXBpbGVyIG1pc2FuYWx5c2VzIHRoZSBlbmRsZXNzIGxvb3AsIGl0IGNhbiBkZWNpZGUg
dG8NCj4+IHRocm93IG91dCB0aGUgZW50aXJlIGNvZGUgcGF0aCBsZWFkaW5nIHVwIHRvIGl0IGFu
ZCBqdXN0DQo+PiBydW4gaW50byB1bmRlZmluZWQgYmVoYXZpb3IgaW5zdGVhZCBvZiBwcmludGlu
ZyBhIEJVRygpDQo+PiBtZXNzYWdlLg0KPj4NCj4+IERvIHlvdSBrbm93IHdoaWNoIGNvbXBpbGVy
IHZlcnNpb24gc2hvdyB0aGUgd2FybmluZyBhYm92ZT8NCj4gDQo+IE9yaWdpbmFsIHJlcG9ydCBo
YXMgYSBsaXN0DQo+IA0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBK0c5Zll2amRa
Q1c9N1pHeFM2QV8zYnlzalE1NllGN1MtK1BOTFFfOGE0REtoMUJoZ0BtYWlsLmdtYWlsLmNvbS8N
Cj4gDQoNCkxvb2tpbmcgYXQgdGhlIHJlcG9ydCwgSSB0aGluayB0aGUgY29ycmVjdCBmaXggc2hv
dWxkIGJlIHRvIHVzZSANCkJVSUxEX0JVRygpIGluc3RlYWQgb2YgQlVHKCkNCg==

