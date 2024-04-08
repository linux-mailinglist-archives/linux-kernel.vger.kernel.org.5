Return-Path: <linux-kernel+bounces-135153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DF89BBC2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6914A1C2089F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAB4EB3A;
	Mon,  8 Apr 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YeOx9XKb"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BC4E1CA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568722; cv=fail; b=iNwV6DqvegSsHZJpM18+VkLwO3CXJtMg5BkX1QN+91tBqSjzEfUkc43J6bdlW7IyRDoxRhMVRi0tcjYCT/33rowmfpkn+IGIBS91gHjuNMzBKkOCWwmGk/3BhD84Ex6nNo8fPQkIZ3cbVyqaoY10eDaQ8K7WzkUVeNehIc61Okk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568722; c=relaxed/simple;
	bh=66X7XdkhIwaU5yCXkwuMDGX0Lf84ipMsiqOHlFPwbaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qnDkgQqsd/ak0CX4qcpMO0gTs3rO1uwt0DcTtlId+sLmqsHElZHGCLCYgaemNLwMg1i+qg6rpDEe22jpIxitdQ1p/wv2BZUECU1jQ8NleauU2WR+J0pZVgaEzxlen3odiTZxTLFNSM/we3lnBjmyeKy5ZcDPMNgm+vCba/FFI4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YeOx9XKb; arc=fail smtp.client-ip=40.107.255.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2RyKWYUdSME1GrLTbhercDmdJ87z/OIxNHfU2BTG4WufpTB3xo2t4k0MWcmNsAlmsUifhTvfWoXA4QIvRFT39K/GRsZyNflCwlRuB0I7gMaC3GfQTUuyme7SyTKw/btFeubL4mc0yewNcHdlF1QxdOQ9AVZJX1lpmPAadMRdJsOMR0UmQED+slsGGfU9Ecolbr5p4CAanvQJyStP1OyghbWfKos+gP46HyErnY4+wfI5vMwkS4uLrHN0TfcgrdMvvDElG05ixYwyvDimRa9OvBADBKB5qIYclZhoDmArjgbXpja9MMY+VHTs6A6D5/hHUboLyYViLePnCzTV1ZPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66X7XdkhIwaU5yCXkwuMDGX0Lf84ipMsiqOHlFPwbaA=;
 b=ArcmXgTXHL+e5JBdw2fMK1EHJlIcTXfB0NFehcZIEqU4tspnFKSKWMOle3JUy/tJOS6eKrsJmhsqnFwdU3ePfYfA2V7+08e4wUXA+2obakKkrDTPE8gv7RA/l2gEFHmd4SmhgQ3Y534BzASsYgEFMYwtRfF0fAoqBBEbVKf/7+XXqZ2+rz8oWW8iaQzBQGBxmqdpnaqrHnLqSRc00+NlCzA7EjRrBmV3iWJwiC4i7Q4sJiWbFsfSHW3Stg9Th2lNO3A7OVmK+n7EyH7pUvw3LZjADFYswLkTamI1NfNkPygBosZyR7/jIeGG1HFjtWixNw+gdRje4ksrKfNtrLuVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66X7XdkhIwaU5yCXkwuMDGX0Lf84ipMsiqOHlFPwbaA=;
 b=YeOx9XKblRWvtpdOaerx1pqm3mb//my3KOCL0VkqM2yshnX68ebHRVbnBf6O6rcLbeoTzGbuWOE7QK3vmUtuYIXL20UgTdSgnwZfY7MO03GN2Ue2a/WhKSVTkIf4Mhr81Y5VAIdBNSsE0eJF58MmFwPqRCW5xEvVCz8eNaZi9eFq705bLN9PZqojlutjpXoaTvOYhf6K9SKyApU3PE69+kgwNnCqV8DTLOczSRBvbs30ymFFyx7xd70bWenCUMAzsvMcz4ZbLjxNRiE/k+BV0tEHR4d8BwB/BlJsNZNScxQOOAQtVfRjmL93u50jvp0SLP8KF50qXB+jPq7oAc9iRw==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by KL1PR06MB7432.apcprd06.prod.outlook.com (2603:1096:820:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 09:31:57 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::563:faf6:dfdc:3c21]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::563:faf6:dfdc:3c21%2]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 09:31:56 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, "jfalempe@redhat.com"
	<jfalempe@redhat.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "airlied@redhat.com" <airlied@redhat.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drm/ast: Fix soft lockup
Thread-Topic: [PATCH v2] drm/ast: Fix soft lockup
Thread-Index: AQHahzL63ETFg/AmsUKZKjVFn26dR7FeILQA
Date: Mon, 8 Apr 2024 09:31:55 +0000
Message-ID:
 <TYZPR06MB6568098AA65B5DEEA17CF4BCF1002@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20240403090246.1495487-1-jammy_huang@aspeedtech.com>
 <80a853ac-0756-4d27-975c-35b2532239ed@suse.de>
In-Reply-To: <80a853ac-0756-4d27-975c-35b2532239ed@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|KL1PR06MB7432:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H/EV82dHWuPr+esAED1stw1QcrGUkR92N8n5O+I2lgXAA1MqCqhrVRICOkSl9aTYJNJ/Gyv9yz8U4oaJ8L74GLk+EocmPgIT8GIwMX8+tyfrWqJqrMtAIMsPhm8rtEoeguGM9S6rt4ilOFcMt8sATAZy6ABfB82GdLITeyhhMJpC7HhWiLTqkcoaHCgEj0Fy+IGEaWDAm/x6Bov5Hyzif6Ggl9UhtwB1uvmUqFLhMw2UAVm+va+bF0kwQv7aeBW5nlnX4nAo2WB4WAFYLn5VuMuFtrXBjtlKunKBTdoJ27My2FKNCQHU0Dc49+tqVsDeeMZQTsGsLR64x/xdFVpuvIPKbFPIIYBjTSQiq1wiaSTaR+He6Zt46tdythRL5nRN2O1lN0UibMyGkoQ5dtlQs3BsBJdsagpSMKRnMqGrsUrllq0mFL/XKOLlHmdBq7k2Is8gy8aQGkLw3MZgc5gxNucFQGRS2YRvuwfZEAtmwjw2tKOXv5hL9ksqNKUPL9wx6joqUa41yFBVD0+vAUzIs27huWxbhlUqB0Njodaxengoxj90DtzvbOgtJEa+f+devbsomYPZ3OxHJorfLYXT1y1mEWvJKGNyWkxqjhe1COgzBTChOt58Q4mmMmPrYl1FJ2exldo26SnqTU+nK4Wo9FAvfWz4NBZtDC7UtsyuEHk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1BsWVRVYlBxZUdPYSt4T2pxWHgvQVVmUmpkUjVMNXV3c2EvRXdhN3pSRUEy?=
 =?utf-8?B?UFIwa1hkZTE3NjM0a0RIekd0TWluUU82eDdLQXpxdXJVWElNMU5OZGt5OTR0?=
 =?utf-8?B?WlFMc3NtYURINEIvb3pzT2dxTFFtWGJoeCt3eFU2S0tmcUpRY0w4L25RaTVF?=
 =?utf-8?B?WEdEZ09DTWJYUDdTSHJCQlJqclV2TVl4UlAvOTlVVE5Ebm5yU1ZOWUJWYTZ4?=
 =?utf-8?B?M0EzU1BsdWVTUVh1WFVoZk9nczZHVjdBSDJLeTRWeFBZa3BQMWFuaFlCMkwr?=
 =?utf-8?B?end0VnZET3FhOE1sU0gzZGdselA3NTZyM2V3UGROd29FeVhaVkd1am42K3Fa?=
 =?utf-8?B?UG9USlJBb213bFRDYy9SVXVMUlhGalJRbE16QmppTERneFVuR2FFeWxabm1v?=
 =?utf-8?B?dm1jSlgwcmtYd1Q2STNhNzdMZkdCcEgwcCs3dEg4cE5wUnVjWkhTSHZyL1pu?=
 =?utf-8?B?T0swazZLaERuRkZBQ0VwZlo4RGV6SGxCOXRLT0kreDBsVnhnUmhvckk0RWpX?=
 =?utf-8?B?VUczRmNqZDNwc2NKR0UvRUdteXUyQVAzMlJjcXFEb1BQbTRzNks0RmFqdUtX?=
 =?utf-8?B?amkvN2tNTGwwelVoUnBRMWttQ0RWa2F2UVhKNHlmREVJc3gyOW1hZFF0Q1hF?=
 =?utf-8?B?NHZEeTdzYkQyZTdUSk9xZ0hVTDVudW8zUVRHS0M5bFkrWlRuWkxvYS82anNC?=
 =?utf-8?B?ZTRRWVBCMHdKeEh4V0RVSTJYS3ZsdzE4bFhsU1VNaU84cGlUWjRnVXhMTGJh?=
 =?utf-8?B?cER2VFFxdjY5aW5jNnR2STZIZHVqZXlleDVaTkFuU3FoM0RkeVQ5VWRkRDU5?=
 =?utf-8?B?WSs3ZUk3YURoc2tGTnZIeEM5eHVuTFhXM1FyU09nOWx1a0RrVGF2N0NBcWZu?=
 =?utf-8?B?RVJiSHFnWXkvV0l4U2ZXQXZpenpSQUIwUEZ1UVNDejlIYTdXUjhPOENKZmtH?=
 =?utf-8?B?Rk9rVzM5R01sZ2FFT1A4SVdIUlFZL3FHZ25mTllMbkE2akh3TUcvNmwxQ0l4?=
 =?utf-8?B?Wm5yNWVZalowRTZDNDdFU1owWDE4eWdnN3phTkJreEd1dWRiT1FKQjNaVTRE?=
 =?utf-8?B?WStWN29zWGVNeTJIZVl5UFc2MjRUK3kxZStmcXpsWXNJcktqSmhuYUIrNGF6?=
 =?utf-8?B?MjlEcDdtWENoMHZ6WHlySkpVSkZSQmdaVTJXcFYySWliRHFpTUhaY1lrMHFj?=
 =?utf-8?B?cG00RDBwc0k1bU5GQWo1VWJJSldHcjlNRmdEdUwrenc3VzMwc29KNmk4c0U5?=
 =?utf-8?B?OUlNeEppdHBSOFRpZklYbzZtUmJZOFk3WmxCWDJlZ2VhdVZXY2x5cG1wWFlW?=
 =?utf-8?B?MWNIaTI0Q3M4OVVaVUs3Z1lXWmpibHpLQTBIS2FFaVpqRjQzRnFIWEJIbWVP?=
 =?utf-8?B?ekF5WU5aTzhNcHNyZkNWY2UvdzJFQlJha2c1a0J3T2NaMVFTZlZKT2FyZXdq?=
 =?utf-8?B?NE9TeUN2SmQ4a1BScnB1K3lTQVRVUEhmWkNSZDBtZkR6ZS80ZlFqMktiVVVW?=
 =?utf-8?B?UDBnTnJjSzZjYjNZc1hHRlYvYlNUcnl5SlRheDA2OG1vN1dzQ1M5czFSK2V0?=
 =?utf-8?B?RDBvek5wRHkzcjNWdTI0T2NnY2xlb00vcUVEY09FVFJzbmUzbmJUZ28rckkx?=
 =?utf-8?B?SjVxZi8zaE80cmZTMFg0VUdvNHNxMVVsRmRtNlRHcHJwMTdmZW1aem9pOFRL?=
 =?utf-8?B?dUkxVGNqbGwzVG45aWVIZktmL3VzMm9DUk9hM21oOEhpejdLLzBDRHp1WEdX?=
 =?utf-8?B?SXduQXp6aXMxVHJOdXkyUUZOQ05RMW45ZU5YejZnYjBOa21EVHFhUC9xTWEz?=
 =?utf-8?B?Zk9IRG9SQ29MQkFOcmZXNjZ4eXRENFJRS3ZwNjRMRjFoaWR2ajVCbnFrbXQ4?=
 =?utf-8?B?OS9TeFhXUjkrZkVkWmxTSitJM2s2RTRvejEyK3E1V2xlcm1NMlJMQURQY1k4?=
 =?utf-8?B?YXdVUTJURU5ybk5EZWJkSDNEUCttaStFOUlSZVczK2FaNkUyNVdmMTdSZTBZ?=
 =?utf-8?B?Ty83WlBjRUx3SzhHYzFjOHVyTDZXekJaUGFFNWgzRDExdGR5a0xWYlpIS3pW?=
 =?utf-8?B?SFlqNEMwQzAyV2pLemg0QVl6TlQyaHhJYU5ubjNyYThFOGJXeURpRG15RW9a?=
 =?utf-8?B?dy9tVlpDSnRMcFhMN1RZZlJRQVpKTHpPeklKQWlKZDZrVUhvVGRtYzY5MlJT?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55365ce2-7b07-49ae-de81-08dc57aebb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 09:31:56.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yry3l0wKNbEdCxRGnI+XRBdWlCAjRXP9xKKi8l55hEiXWeFGjCKZR6IlZ3mlodX2usjpatZLUcIcJqPZhFf0etIJedvsFb2tKd0GXuaG9JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7432

SGkgVGhvbWFzLA0KDQpUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpKYW1teSBIdWFuZw0KDQo+IA0K
PiBIaSwNCj4gDQo+IEkndmUgYWRkZWQgYSBGaXhlcyB0YWcgYW5kIHB1c2hlZCB0byBwYXRjaCBp
bnRvIGRybS1taXNjLWZpeGVzLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFRob21hcw0KPiANCj4g
QW0gMDMuMDQuMjQgdW0gMTE6MDIgc2NocmllYiBKYW1teSBIdWFuZzoNCj4gPiBUaGVyZSBpcyBh
IHdoaWxlLWxvb3AgaW4gYXN0X2RwX3NldF9vbl9vZmYoKSB0aGF0IGNvdWxkIGxlYWQgdG8NCj4g
PiBpbmZpbml0ZS1sb29wLiBUaGlzIGlzIGJlY2F1c2UgdGhlIHJlZ2lzdGVyLCBWR0FDUkktRHgs
IGNoZWNrZWQgaW4NCj4gPiB0aGlzIEFQSSBpcyBhIHNjcmF0Y2ggcmVnaXN0ZXIgYWN0dWFsbHkg
Y29udHJvbGxlZCBieSBhIE1DVSwgbmFtZWQNCj4gPiBEUE1DVSwgaW4gQk1DLg0KPiA+DQo+ID4g
VGhlc2Ugc2NyYXRjaCByZWdpc3RlcnMgYXJlIHByb3RlY3RlZCBieSBzY3UtbG9jay4gSWYgc3Vj
LWxvY2sgaXMgbm90DQo+ID4gb2ZmLCBEUE1DVSBjYW4gbm90IHVwZGF0ZSB0aGVzZSByZWdpc3Rl
cnMgYW5kIHRoZW4gaG9zdCB3aWxsIGhhdmUgc29mdA0KPiA+IGxvY2t1cCBkdWUgdG8gbmV2ZXIg
dXBkYXRlZCBzdGF0dXMuDQo+ID4NCj4gPiBEUE1DVSBpcyB1c2VkIHRvIGNvbnRyb2wgRFAgYW5k
IHJlbGF0aXZlIHJlZ2lzdGVycyB0byBoYW5kc2hha2Ugd2l0aA0KPiA+IGhvc3QncyBWR0EgZHJp
dmVyLiBFdmVuIHRoZSBtb3N0IHRpbWUtY29uc3VtaW5nIHRhc2ssIERQJ3MgbGluaw0KPiA+IHRy
YWluaW5nLCBpcyBsZXNzIHRoYW4gMTAwbXMuIDIwMG1zIHNob3VsZCBiZSBlbm91Z2guDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1teSBIdWFuZyA8amFtbXlfaHVhbmdAYXNwZWVkdGVjaC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvY2VseW4gRmFsZW1wZSA8amZhbGVtcGVAcmVkaGF0LmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hc3QvYXN0X2RwLmMgfCAzICsrKw0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hc3QvYXN0X2RwLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
c3QvYXN0X2RwLmMgaW5kZXggZWJiNmQ4ZWJkNDRlLi4xZTkyNTk0MTY5ODAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FzdC9hc3RfZHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hc3QvYXN0X2RwLmMNCj4gPiBAQCAtMTgwLDYgKzE4MCw3IEBAIHZvaWQgYXN0X2RwX3Nl
dF9vbl9vZmYoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9vbA0KPiBvbikNCj4gPiAgIHsNCj4g
PiAgIAlzdHJ1Y3QgYXN0X2RldmljZSAqYXN0ID0gdG9fYXN0X2RldmljZShkZXYpOw0KPiA+ICAg
CXU4IHZpZGVvX29uX29mZiA9IG9uOw0KPiA+ICsJdTMyIGkgPSAwOw0KPiA+DQo+ID4gICAJLy8g
VmlkZW8gT24vT2ZmDQo+ID4gICAJYXN0X3NldF9pbmRleF9yZWdfbWFzayhhc3QsIEFTVF9JT19W
R0FDUkksIDB4RTMsICh1OCkNCj4gPiB+QVNUX0RQX1ZJREVPX0VOQUJMRSwgb24pOyBAQCAtMTky
LDYgKzE5Myw4IEBAIHZvaWQNCj4gYXN0X2RwX3NldF9vbl9vZmYoc3RydWN0IGRybV9kZXZpY2Ug
KmRldiwgYm9vbCBvbikNCj4gPiAgIAkJCQkJCUFTVERQX01JUlJPUl9WSURFT19FTkFCTEUpICE9
DQo+IHZpZGVvX29uX29mZikgew0KPiA+ICAgCQkJLy8gd2FpdCAxIG1zDQo+ID4gICAJCQltZGVs
YXkoMSk7DQo+ID4gKwkJCWlmICgrK2kgPiAyMDApDQo+ID4gKwkJCQlicmVhazsNCj4gPiAgIAkJ
fQ0KPiA+ICAgCX0NCj4gPiAgIH0NCj4gPg0KPiA+IGJhc2UtY29tbWl0OiBiMDU0Njc3NmFkM2Yz
MzJlMjE1Y2ViYzBiMDYzYmE0MzUxOTcxY2NhDQo+IA0KPiAtLQ0KPiAtLQ0KPiBUaG9tYXMgWmlt
bWVybWFubg0KPiBHcmFwaGljcyBEcml2ZXIgRGV2ZWxvcGVyDQo+IFNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSA0KPiBGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYxIE51ZXJuYmVy
ZywgR2VybWFueQ0KPiBHRjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFs
ZCwgQm91ZGllbiBNb2VybWFuIEhSQg0KPiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0KDQo=

