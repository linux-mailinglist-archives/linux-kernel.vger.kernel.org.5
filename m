Return-Path: <linux-kernel+bounces-129354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25578968FF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137591F2603B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CDC6CDBD;
	Wed,  3 Apr 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="fcIe7SAJ"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B55FEE5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133714; cv=fail; b=MC7Uqcwy/j7zFM6zv0ibWLXmNtEppEvsD9yqX99Yd7GRXh4yX4XQXh+jRGyeuGMC/hNs8zFLdsh/EQ4ThIWA4sHX12XmL2gUFOJPtw6X4NdfYk4/c54oyfVAusghGjaQzy6YBBnn7qayoeI+FskPo7toNb90/ss58Y8zNiijSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133714; c=relaxed/simple;
	bh=R//uGGGg2zrUti1DhKTD1QcagUy4s5A5xmxzLK8A9GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NROXK4YVDDP1RxRcnZ7oxoxaOMC16K+zb/M8d4EgvWKSksnUaHjxjaRdyN0vzmGdnV2jz/jH/hmNoT4VG8RPJINZb86IAuaxiUrktvRLOmq2Gff91y3ClcQ//HZp+0aCzf7HWUMsnFtrkzEaSHjafktD7mgjxrjBUt4x0/zCpyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=fcIe7SAJ; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0dGz4I/HY0hUiRo30EYaU1oXRI+DQQPL2UDQEW32LjuUimO9RZ/EFn0a6bKcpCgFpQCqMjOGZxaPxarZ97ePHym0erPFEsbGw4KMlPISWtJPja1pH3iOAiiMe7OVoGH5JDuUDRgw3vD0XEsh2WhrZpyCMyHm3cnhTyFTwPieKVv2TPX86rqufcoIQo7tKg2SenMETpKHpCGJk/NhPgq+MMA3Lb8oIJ4s3tyFxcXQJXEROPwoTouJPTYn0rIiQa+WyukuR8jbKEHLCJCni4Bfhnx1fyOupvrqRmmAvRs6HSvTbSsS0a0pnT1BLOBKpBul9sWBhO1qyWTSDfVRPrKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R//uGGGg2zrUti1DhKTD1QcagUy4s5A5xmxzLK8A9GA=;
 b=dtkWhxrYDu/82uWAODc5e5lVEyqFuoB5JU7pf4xALTeMTTtUD2C/2mMb1mLM4u4Lp5pFs2zKdCyY/Rjtu2fVTG8nnPAMCpocLEg9VJlss+PNOI9Vg+9glF9ysB9256kj5e+iR2AQULY5bj0zxDvnb01DHvcfzmRRoXuURdJWns185exdeRy7uQz8kkLBkT8rjBaSzPeVEZrpgDxxP+NJ4mu06DFyCbrtsuXpKSlK80Q2XXi8+ttW48xwnaTVNLXHpJ56u6qoIcXQYwRpFWoURiWMuOTmZvkaLu0JQ3ebHjGthGu0XUHsuska1E/9MRsH/k5MaGFtUf9OlWK1QZb/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R//uGGGg2zrUti1DhKTD1QcagUy4s5A5xmxzLK8A9GA=;
 b=fcIe7SAJyGVcYIYhq+GC1VrRuiq+5Zi4Cs8ZAtv3qayrsV5ljQvqKmOzht/R9gSU3Ga0cFj7+8DXQ7fZWttQIZZOn4Kidp+mhFxt43OCZwoGWjE1ykAU4/uWE9L7HyEx+ECjDB3DefK8EMtipCiCDpM7igd/aFKs7sUQ9HDGiw2/+9s/yxLcHjjkMsqpAtsqUA7VxIBJwmmhMA7YigaH9qHP8E/NUQzZC/7XlxyoZyoq3KXuDZL03UvoNYB/LvQEi9/dFN+2tlm0osJsZeQLAvA9noHOQokDbjXkzroLKsgon1xZ/b+9h8/X0OnAkynjZqUH3UyTLWlWWcQsvr7oMg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1818.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:41:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:41:49 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
CC: Arnd Bergmann <arnd@arndb.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Noah Goldstein <goldstein.w.n@gmail.com>, Charlie Jenkins
	<charlie@rivosinc.com>
Subject: Re: [PATCH 18/34] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Thread-Topic: [PATCH 18/34] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Thread-Index: AQHahZ5g28C+LJsTYku4NOBSr1WvGrFWOkqA
Date: Wed, 3 Apr 2024 08:41:49 +0000
Message-ID: <66a1d5f1-d9b2-402c-826d-955370288037@csgroup.eu>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-19-arnd@kernel.org>
In-Reply-To: <20240403080702.3509288-19-arnd@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1818:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 802VhHvRxK+NZiuckAMPR3q1KMMzcaO9yPbm/0kNvsg3Cnalk77Llpng555+C8Nm8ZacXZFuafK6+2QCcj20t0c/xLGxxJKs+fOhcmoN6ppdQF9RnWiWzzqoz2Nv282/ngl6jbtipqH8r3M3leRdwALudrZXKTg3+CYp2zY7mNLFhwSbvcY6KPEXLhFhaTfypBjIyqrRMaGEC8oAGfPJsTvm2dm0WjEcng0bl19hYVTT7cv7Q05QAkK/nVbzmpMHNGxb1zDdO13mAkwHU/gF3UNeY6yxfA5hKHZgS7ijmlLdE1KRapJPBLaZWXTTk4IUD36B7VwoJzpg7PFoHUmTSoLUmvh+oZfZpj70c0qm4jys/6mpw6bTQASTEEo9sE3V21D3AQu/bW4Ao7r/EmPeRHxi5lcslATtJ90nXHWIfw8yhiP540gqKjFHchCXmdFTuj320lUZ8CgaOB5kQucXM6A2D+B3ljgPXFLj3c3DjKyYy1rX3l8ZvFVAsrPjIfnzZsthXPs2rZG3n4sr7yl7DhdZdMTYXXeNa/gJUztartL6zp0Neo2pV6rCgwS7Uw3CTUgkiRZDXC3XKYi46kgN7g128KsS5kvWRVEQIOdUVA4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkJwNmNjbjk3Y1VmZTZtUHFzM0h4eHNtVTVlUktGK0UvUTBiOTB4eGUwaVRq?=
 =?utf-8?B?SWRpMEUyenAyN0lzSnhVUDE1VHo3NFJoRU5SeU5MbUhUWUNtbHRXbC84VTVr?=
 =?utf-8?B?T3JrTWFheFlJYTNjTUNTczh2N2M5d1YyTTM5T0VDSm0yUTA4ckFRQkM3ZitS?=
 =?utf-8?B?bUwvR1FiVDBadzlhUWxKWGtLTVRRWWhXdUxKUVlKMWY1TzlDNFNmdG1BbmlT?=
 =?utf-8?B?TXlQNkpZbmJNSWhNb1F0blp5cFJCQnVPakx4VXNHWHBablhSZnpsN29jUnFC?=
 =?utf-8?B?cUg4V0c4RWhFY2wwTnJzSElLYW51NWxqSWpwdmExQ3Fod2NGTDlMc0szUG9M?=
 =?utf-8?B?M1U1YjRkT2xybkt3RlBXZXVhUmhiMjh4Y1Nuclc4TnhVbllUK29RWmNORUll?=
 =?utf-8?B?Z3IzZjRtc2MzZEFJRVd3UlQxekJuV2JMSlkrQm5Tblk3Zmc4M0FvUmY5eFhv?=
 =?utf-8?B?WWdWTHVNN09jY1pxd1FyZU1JZER6L1RWVytiemwrVVI5bllBWE1pQWNPYUVv?=
 =?utf-8?B?aFc5QXBvMnVwY0FTc1daVnBYQWcramhYbjVDRGYrVVFlazQxd2FRMGQ3QU5v?=
 =?utf-8?B?cjVwMmlOOGNqUUtueTZtSWxWYkRiWDNxM2RLV3FSR29PWGE1TUFjMUczQUdt?=
 =?utf-8?B?bUtoaE5nSjdtcHBBRVZJWWc4K3NadnhiZzBMZDBKbDRYZjVLNG1KNVlrZlBT?=
 =?utf-8?B?RmFxMjRzRzVSRW9yUGRwajNxZm41QVRVL0JoWktkTUtmNHBFWlpydzV6cldv?=
 =?utf-8?B?b09DNzhyREVZNE5wMDN6bXR5U2M5enZBOE5rUHl0S2ZNMkw2THRYUXN0QWJE?=
 =?utf-8?B?cjVQdXdOYk45S3NCTXNMWHM0dVFsK1hvV2greGthbnkxRHZzaVRnRHJRbjZi?=
 =?utf-8?B?ZTdtcnU2N2k0VWxTWE9qdHVleWs1c3loRFFFUmVYWi84UXFDcGQzbndicEdN?=
 =?utf-8?B?WUhwSTEySXlBMytVN1RaUVo1RitZam0xdGhWSmNVMG84d0UzUHhSY0s0NE92?=
 =?utf-8?B?cVovSm9vSHBsMGNtcXM2L3pTQkhsS25NVURxNjh1M2ExMmdzOVlvZnp2MkNM?=
 =?utf-8?B?cm1GVGY1SzZKUnZQaW15dXFrOU9Sd2QxN2EvOUljYWZnQjdsUWRXamc5YXE0?=
 =?utf-8?B?Y0liQ1VoNC9lRGlZOHJlU0JCbkFkWmRyMXUzUTFPeUJYUEJHTGdBZXhpdUZ2?=
 =?utf-8?B?ZjdPcVFvTEo3S0VCd2dzdUNFRTJqSVNnTjVxU0ZHUGNQU2NNenRXWmdHRDgw?=
 =?utf-8?B?RTJrMmhUWXRVRWpvZHlFdTVNbmw3MFpNaGY3bzVBY3ZqM2RjVjQvTHp0L2xm?=
 =?utf-8?B?OFZuamt0TUROajFGZk1oZ0RJNU9LTFFQYnpRVS82eGJlYnE0RGoxcTVOK09L?=
 =?utf-8?B?bDRVY01rMk4xeUQ0WkFiaW5uYW4wSkx4MHprcnAwL0FPemtFaVl3MWQzc3A5?=
 =?utf-8?B?WXBzK1dkQTl6Z1NlWHkwVGZxYmZuYXdHM09maFhCOGQreFJJcHBEeEVpd0Rm?=
 =?utf-8?B?RW9ONTRxNTN5WDlGSFpyYUtMNEpBUGJITEtzUjRBWk5VWmNNd290NjUvN3B3?=
 =?utf-8?B?b2Z5RlM1VDVTSWs4alNHcGs1MnJlM3lLQVBOa1k2ZE1wVG9ESTRycytVTktX?=
 =?utf-8?B?bmFid2RnZWR1WklqMGRXS3pjbWQrWEluUldVcnViaExIclhReFp0Q3lSTFRP?=
 =?utf-8?B?Vm50c2VQT2JWV2JZUXkzVUdMdzhxZzFwT2k2QkYxZEp4TmxYRVdHNDNuTEdL?=
 =?utf-8?B?eENnNnVXK2RzdlpiL3ZFOGVjU3RoVHNjc2t0UUxGRnNsSHlRcmpMUDBnTjlv?=
 =?utf-8?B?aXJnVVovaVdlQWhBWjVLcjdjZVl2Zk9aWHk1bmhCRXlhbnhWVlFEUzg2VENq?=
 =?utf-8?B?SVBYQkVSb0hHdDlNYkxTdVJlaXZrNmFTeU5BNHl1L1Vrc3NqY2R6aW1PS1RY?=
 =?utf-8?B?ZksvTk9HaWk0Z09BUmJSbk9qaHZKYUJUMVVBVmh4R0VuQks3eDlIa0ppUVk5?=
 =?utf-8?B?U2FrWU5uTmZVcFg3bnpRYk84VFdZRWN5cnJHWnpLSnRQdmlEeThPZW5WZlBJ?=
 =?utf-8?B?U005YVpadkg5U0NTcXU1cFg5TTdoV3pKS296QTg4WWtXMnE0bnNTaVVVL3pM?=
 =?utf-8?Q?xKr+7JQXA0qbSA1b+LdTOh9zM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F4E887CA353C94BABE597941C7A8E08@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2afe80-9efa-4836-442c-08dc53b9e73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 08:41:49.3004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JropDYaAnDUgsKCmxLA2MvOVA3sLcGpksXTyE6mygUk/zsr1icsYgR3NHSnETiOLRfYz1ADlxmRe6v4NEpNgbvgXBJx0xXzNm0gJmxmvCAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1818

DQoNCkxlIDAzLzA0LzIwMjQgw6AgMTA6MDYsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFdoZW4gQ09ORklHX05F
VCBpcyBkaXNhYmxlZCwgYW4gZXh0cmEgd2FybmluZyBzaG93cyB1cCBmb3IgdGhpcw0KPiB1bnVz
ZWQgdmFyaWFibGU6DQo+IA0KPiBsaWIvY2hlY2tzdW1fa3VuaXQuYzoyMTg6MTg6IGVycm9yOiAn
ZXhwZWN0ZWRfY3N1bV9pcHY2X21hZ2ljJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11
bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiANCj4gSGlkZSBpdCB1bmRlciB0aGUgc2FtZSAjaWZk
ZWYgYXMgdGhlIHJlZmVyZW5jZSB0byBpdC4NCj4gDQo+IEZpeGVzOiBmMjRhNzAxMDZkYzEgKCJs
aWI6IGNoZWNrc3VtOiBGaXggYnVpbGQgd2l0aCBDT05GSUdfTkVUPW4iKQ0KDQpJIHRoaW5rIHRo
YXQgY29tbWl0IGludHJvZHVjZWQgdW5qdXN0aWZpZWQgI2lmZGVmIGluIGEgQyBmaWxlLg0KDQpS
ZWZlciANCmh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwj
Y29uZGl0aW9uYWwtY29tcGlsYXRpb24NCg0KVGhlIGZpeCBzaG91bGQgYmU6DQoNCmRpZmYgLS1n
aXQgYS9saWIvY2hlY2tzdW1fa3VuaXQuYyBiL2xpYi9jaGVja3N1bV9rdW5pdC5jDQppbmRleCBi
ZjcwODUwMDM1YzcuLjEzNTQ5NTNjODk0MiAxMDA2NDQNCi0tLSBhL2xpYi9jaGVja3N1bV9rdW5p
dC5jDQorKysgYi9saWIvY2hlY2tzdW1fa3VuaXQuYw0KQEAgLTU5NCw3ICs1OTQsNiBAQCBzdGF0
aWMgdm9pZCB0ZXN0X2lwX2Zhc3RfY3N1bShzdHJ1Y3Qga3VuaXQgKnRlc3QpDQoNCiAgc3RhdGlj
IHZvaWQgdGVzdF9jc3VtX2lwdjZfbWFnaWMoc3RydWN0IGt1bml0ICp0ZXN0KQ0KICB7DQotI2lm
IGRlZmluZWQoQ09ORklHX05FVCkNCiAgCWNvbnN0IHN0cnVjdCBpbjZfYWRkciAqc2FkZHI7DQog
IAljb25zdCBzdHJ1Y3QgaW42X2FkZHIgKmRhZGRyOw0KICAJdW5zaWduZWQgaW50IGxlbjsNCkBA
IC02MDgsNiArNjA3LDkgQEAgc3RhdGljIHZvaWQgdGVzdF9jc3VtX2lwdjZfbWFnaWMoc3RydWN0
IGt1bml0ICp0ZXN0KQ0KICAJY29uc3QgaW50IGNzdW1fb2Zmc2V0ID0gc2l6ZW9mKHN0cnVjdCBp
bjZfYWRkcikgKyBzaXplb2Yoc3RydWN0IA0KaW42X2FkZHIpICsNCiAgCQkJICAgIHNpemVvZihp
bnQpICsgc2l6ZW9mKGNoYXIpOw0KDQorCWlmICghSVNfRU5BQkxFRChDT05GSUdfTkVUKSkNCisJ
CXJldHVybjsNCisNCiAgCWZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0lQdjZfVEVTVFM7IGkrKykg
ew0KICAJCXNhZGRyID0gKGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqKShyYW5kb21fYnVmICsgaSk7
DQogIAkJZGFkZHIgPSAoY29uc3Qgc3RydWN0IGluNl9hZGRyICopKHJhbmRvbV9idWYgKyBpICsN
CkBAIC02MTgsNyArNjIwLDYgQEAgc3RhdGljIHZvaWQgdGVzdF9jc3VtX2lwdjZfbWFnaWMoc3Ry
dWN0IGt1bml0ICp0ZXN0KQ0KICAJCUNIRUNLX0VRKHRvX3N1bTE2KGV4cGVjdGVkX2NzdW1faXB2
Nl9tYWdpY1tpXSksDQogIAkJCSBjc3VtX2lwdjZfbWFnaWMoc2FkZHIsIGRhZGRyLCBsZW4sIHBy
b3RvLCBjc3VtKSk7DQogIAl9DQotI2VuZGlmIC8qICFDT05GSUdfTkVUICovDQogIH0NCg0KICBz
dGF0aWMgc3RydWN0IGt1bml0X2Nhc2UgX19yZWZkYXRhIGNoZWNrc3VtX3Rlc3RfY2FzZXNbXSA9
IHsNCg0KDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+
IC0tLQ0KPiAgIGxpYi9jaGVja3N1bV9rdW5pdC5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvY2hlY2tzdW1fa3VuaXQu
YyBiL2xpYi9jaGVja3N1bV9rdW5pdC5jDQo+IGluZGV4IGJmNzA4NTAwMzVjNy4uODBkZDFlMWI3
MWJhIDEwMDY0NA0KPiAtLS0gYS9saWIvY2hlY2tzdW1fa3VuaXQuYw0KPiArKysgYi9saWIvY2hl
Y2tzdW1fa3VuaXQuYw0KPiBAQCAtMjE1LDYgKzIxNSw3IEBAIHN0YXRpYyBjb25zdCB1MzIgaW5p
dF9zdW1zX25vX292ZXJmbG93W10gPSB7DQo+ICAgCTB4ZmZmZjAwMDAsIDB4ZmZmZmZmZmIsDQo+
ICAgfTsNCj4gICANCj4gKyNpZmRlZiBDT05GSUdfTkVUDQo+ICAgc3RhdGljIGNvbnN0IHUxNiBl
eHBlY3RlZF9jc3VtX2lwdjZfbWFnaWNbXSA9IHsNCj4gICAJMHgxOGQ0LCAweDMwODUsIDB4MmU0
YiwgMHhkOWY0LCAweGJkYzgsIDB4NzhmLAkweDEwMzQsIDB4ODQyMiwgMHg2ZmMwLA0KPiAgIAkw
eGQyZjYsIDB4YmViNSwgMHg5ZDMsCTB4N2UyYSwgMHgzMTJlLCAweDc3OGUsIDB4YzFiYiwgMHg3
Y2YyLCAweDlkMWUsDQo+IEBAIC0yNDAsNiArMjQxLDcgQEAgc3RhdGljIGNvbnN0IHUxNiBleHBl
Y3RlZF9jc3VtX2lwdjZfbWFnaWNbXSA9IHsNCj4gICAJMHg5OWFhLCAweGIwNmIsIDB4ZWUxOSwg
MHhjYzJjLCAweGYzNGMsIDB4N2M0OSwgMHhkYWMzLCAweGE3MWUsIDB4Yzk4OCwNCj4gICAJMHgz
ODQ1LCAweDEwMTQNCj4gICB9Ow0KPiArI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHUx
NiBleHBlY3RlZF9mYXN0X2NzdW1bXSA9IHsNCj4gICAJMHhkYTgzLCAweDQ1ZGEsIDB4NGY0Niwg
MHg0ZTRmLCAweDM0ZSwJMHhlOTAyLCAweGE1ZTksIDB4ODdhNSwgMHg3MTg3LA0K

