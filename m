Return-Path: <linux-kernel+bounces-79505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5286235C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8161F24085
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793B24C9F;
	Sat, 24 Feb 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="TGXTKPCZ"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2103.outbound.protection.outlook.com [40.107.12.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6213FE7;
	Sat, 24 Feb 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708760646; cv=fail; b=O9XBZ2+XnUeuGgO8JSXsCKxyvi68glWjBcH6rrKoQKwDwGI1Ri17CJQA9aQAhqrmU2w7vo2aa0nuEfzx1JEBbuGsJX/Vfbm66Q2T+A0lE9bNcT9jZCQ91+Vb2Cd2dYbM6hoX9kdTzc0mjWGB5xf2b4IR311GG1QcXrsVEwZcsIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708760646; c=relaxed/simple;
	bh=2SN+p175pIt0pzVbczWYjnPEVsJ0SnbYd1DNsGK8H8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RCTf/dPDHPRUy6DmMwe399bqjjRgT3jo7O01nUlKnMpsA1SSr+iIIne3SQtV/V2fu1MxwyAjzN6CYTPmvVG0Lq/T1UE9p5mtLrlue3wcj6yRRi2z26dWL4lMJdzLDSD6KlIwnU0tkLpM4jq+wSuCvmZj7Fse120pHzCCBMpwRIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=TGXTKPCZ; arc=fail smtp.client-ip=40.107.12.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4KauaEPS7VTX6MSvqn0wLV9gblHu7r3Z12YLOJX5ihXMgpPQbSs4rfoR0vyKH+GAGBVyDNVO/Cyv4Tz3t1LImmqikRyskmJ8kSQGMWIXjukOoVC53vbRrnY0bQ4UBKBVXGxOUdLYX8gd+uOATFRH6nGgeXej2NzXQcEY0R+Kg7MuaLJB4svT2K1Uwvb08uSR5S7bamlfywbZvmufP8N9pvYEFUrUahj0neik+hnmKmFEITngWo1O81Ssn0PHLv+8Uc/5w2CcoruizYBEYpxvgxHyzQVIcfRylEJ2K6G6q2nizyw5o496QYMIvZJjn5duk13smLsTnCurMR6XOD1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SN+p175pIt0pzVbczWYjnPEVsJ0SnbYd1DNsGK8H8s=;
 b=WtiMWYuCCJHEEIfvztBDr4ep2bUxlI++7Td94+Ye5yYx3nVxuLTZM4s4wkiV58cSQw9aeKn6HsWJ2/8wLi3dkRjhAmxE1JJYNJx7ZBvIPRr09cGt6ArVH5wdVsrvL3CKpBhF+L0WF2uTgEnIFSJeKsW2xvr3VVNXScPIJgbi1lVlFzmJX2+2lbeH1A6ygN4Ac3cAoTzlaL1gbavQ7LaJlPkZ/uOIOdavft6HQ3/0FHFsF7Vc9IEhsJM0qVnSWdhGnClQL/MNHVjMkmBzPh5u8GGGb7GBi9jqGP9n4F4QCNbetLCY3SBivJeGZqrG7lMoDgWO3W/qdL0qClI1xz5XXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SN+p175pIt0pzVbczWYjnPEVsJ0SnbYd1DNsGK8H8s=;
 b=TGXTKPCZS9U+2iy/UGsUvgzhakVfsIcTHJ0mQHWcL9PdKzEVPRHy6YePOhTLakozb4HqB+wmF0GHwYnnjgqEulbkKVxY9hMcAvH3XuMboY+OtyrMZwed0TB4OTv4Dhe/MLXEh1elMCCeeMm480z9mM9PiUXdVVtUrk7idae3jKL+1ptEL3y+o3568JwxZORhF4YqBPTlZowqvmaUQEg1qAXNb8akKsReK99if+mN8eiE0fUKsXmf3ruyxVV4jwrU3AJlMrhgtlf/xFix6VB/ZZ2OBtZCi9l+eXpMhEkX2JWTljN/ww+LMzLiRR3sLtIpjI/R494JRsJ627tjXXbEbA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3396.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Sat, 24 Feb
 2024 07:44:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 07:44:01 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Charlie Jenkins
	<charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, Erhard Furtner
	<erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Topic: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Index: AQHaZkTy9Xv+fOXXx0O2ApyFNqZzw7EZHeyA
Date: Sat, 24 Feb 2024 07:44:01 +0000
Message-ID: <c434b94a-2072-4b74-a222-0906579a351e@csgroup.eu>
References:
 <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
In-Reply-To:
 <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3396:EE_
x-ms-office365-filtering-correlation-id: 49cf95da-ae71-4616-8800-08dc350c5e40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dl7Ca/N6K3K/fCrVJUViPmFxqRtFsDeOQVADh7VLccJVB6gsv+MVJN/XpAoazyYZFk7TIbJIDQ4T7RX0X/WGXeFrFhjgbnEc2h/v5xHQhpNbDJ1rxWIC7oiXdlL47mPj92Cey1hdsHO830LHDPPFH8IkYRZ3zPmT6ryUn/40WrWY7naPGOtEoGlCHXaT9Qe59uL0zuAqMM0f0te+sYWhIiqyCuDHVnXa6cv4+wzuim3nE7SrCC5ixDtrB3gzxZV5Hv7aAG9t3yMtX5cEiaeiwfsYXdo7jBWBzTnkQVpRwZaaOLTgG5Zl614RzMiglXMYI6HlhnD9jq4SKN3NyJKfnKaBrXbUi8M2DK5wP67iDFk4cogh/S9tVqQu4ox/TtQTlKdDZ0OoqSrTREmSxdqAfZNmP6ACiFX5yeIRWnQmZLgviXief2outM2a1U/vNVFrR0ESdMV5taTR5PNHcH44lgz6h+4wBoE+bPbDOUXGqlG1+Os17YyFGbXnRYpqOELlv0IK/TQJe2ksHq0OsbrSk5rQPQOmSkP8By799+IuAs0QH7qaEueCgUEpm/FUisdodo4VnCQ9TMT/JFxP0onQ4gyA9hOpQSMBNJR5oY4DlrEfwdP1zHdYQy6X+JDafxdE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXFIZU81c0FrdXpVQW5pRElZbVA4WG01dGJVWVJLTVEvWDVJMldxaXYzWHls?=
 =?utf-8?B?Z3ZSdlNXVWs3SGlXV1krMjRTekpmZjVqNDY4aDhYV0tzYVEyL3FSeldTMk1s?=
 =?utf-8?B?L2U2OG1ibkp6NEFzWllmd2c3SWZxNVE4S0ZkZUYxRWw4R0U1WTlwcUQxSC9y?=
 =?utf-8?B?T1ZkNHpoaENqMGNqbXl4T2laYXd5Q2VVUjlZbWVqLzhOTVVIbWdTMUhzOVcz?=
 =?utf-8?B?V09Od2ZOYVZyWnNabUE2QlU2MkJjV1M4eEVDQTQ3WGxPUi8zUEQ5M0dkZ0hK?=
 =?utf-8?B?NHovdjZtcnBQZWZJQnQ4V3dzOC8rd1ZwcEtrOUt0TDYvbGZ6aGxITkN0OXJx?=
 =?utf-8?B?cXBjODZoY3FCR3pDdm44V2huM0xSRHMwMmU3ZUNJL3Nwb0tpOWs5M01MWFBM?=
 =?utf-8?B?ZE9qcG53cnJzRk8rUUJqVEFRMUNuNk9KSFYwOXNuMzJoL1orb2U1L2dNMW1x?=
 =?utf-8?B?cGlRUVl0ZTFhRkJXUlc0clVYUW50MEJBN1FBbG02eVVSc29GczhWZDBLbFZp?=
 =?utf-8?B?clJFT2s3SHdiOHh2RnU0S1p1Nks5Nm0yalVQK3paSU9ydXYwcU1xTkZuUFpD?=
 =?utf-8?B?TzR5MWVXRVI5V213Y2RMdmlHcm85OUNzQWJ0b3lWRGFiWnZLU01DN2VxL3pM?=
 =?utf-8?B?NEVEeVVhNTl4RkZISTZhMk4wK0pBR3FUSDBUUFBpQjl3QmlwSm11Yk9HY2hH?=
 =?utf-8?B?ZDJTNDl3T2toR1RTNHB3WTRzcTZxNkhzdWY5akdIMk90ZUUyQVloYU9XUmtP?=
 =?utf-8?B?QVFTL3dqTUlmU3pvVHFwSUVyMGNhRjJvNWtMMW1nS3VZTEEwTlhXS1JubnZs?=
 =?utf-8?B?RkRkOHhHTW5kRFRMNDRXUWwwTEpseEhVRUdLaUZyY1NFTjZPSWFuOGRBNEhC?=
 =?utf-8?B?d1hCVjRUdlhHTVVYbkhqT25sZmdwRURsNlA2ZjRyaGcvSUZxTFZMRWpZRU8v?=
 =?utf-8?B?R0JHM0lCdCtSc2Qxd04zVi9NcTJWb084ZjUrWThHYnI4ZHFJMWdPN0xGZHhx?=
 =?utf-8?B?THI5OVJtU0liLzFPNStpR2tFRURLV0hZeXJxbCt3RU9idTAyZkltM3l6RHZR?=
 =?utf-8?B?aTQvTW1TaEpjNTBzZWF2ZnZUMVlJRGZ4dTV5WjBwc3lTVUcxTGtyK0c1YTVE?=
 =?utf-8?B?ZGNWRjRkdjhYLzF6SEpRZk5MNDh0ZFBHWlhOcHBiOEdCYjFIZmt4R3FPbUJz?=
 =?utf-8?B?blkyVUJYa2ptUFhXYnZ1a3AxM0wvUkZPWFk4aHFFVTkycmNMVnhGOXp0NEZo?=
 =?utf-8?B?RzJ3dE9iM2FoV3EyVFZTSnpwd1VpbDZwd3NPWlRGZXUvdnBDWFNIdHQyTDNV?=
 =?utf-8?B?VjA5TUpOSzRxQm15SWQvMWdPVlRvSUtlYmh2TE1nTVBubk9JbDVmRXgzRTJG?=
 =?utf-8?B?eHExOEY0VnpqWTUwdVJCVXAwQTNtd1VUNXRWMlFvWCtsTVVZSll0YnNKazl3?=
 =?utf-8?B?bGZPRzd3NkJoRmpqS0g5cGlmTFIxajd4SG1BaExBRDMvWHN3VXZVTjl4Y0lM?=
 =?utf-8?B?T1Z1c3JaQlZQUUdCWUdBWTB1SGFrcjU3NXRBd09FbjIrMk40Tlo5Ym1DUVhZ?=
 =?utf-8?B?dVJkKy9DR2k3Z1B6VHFTZmJBWTI0aDlvMjFsd011T2gzUldrajFtZEVrVmZa?=
 =?utf-8?B?L0lDUFZZUitIUDhxUTlLNlBMVG9PaHNOdytnNGo3UlBYNFZPOUh3dkdQc0p1?=
 =?utf-8?B?RFlrODlwQVVMRG9hMVYwNU1iMEZuZjNOWTE5bERqekszVXZHdDFqWDdQSW15?=
 =?utf-8?B?RVZxK1ZMRFR0UHJmMGdndzM1ZU43QXArSEZEeW1xUFRuUC9ucmpaTGFtSUlF?=
 =?utf-8?B?MkFNTTVDUFlRaTQvYXY5NHNtTUtkYWgvcVgrZ2ZLdW1RTmFLdTRQYmt6UzRa?=
 =?utf-8?B?bFdITHRhbTZFZHZxTnRvZTF5anNZaERxWXFLYzNLM3N0VkdPRld1UzBDQUZC?=
 =?utf-8?B?U2xZZTdab2UxOFkxR1hrL0k1RUREZExQZWxreGFqNVo4YkU2SGFYTlVyYXd1?=
 =?utf-8?B?b25LNDV1U2tYb1p0Ymo5YWlleGI1QlVicFpjdU84VkQxblVqZVdreTJJeVNv?=
 =?utf-8?B?TUJyRVJKMyt1dCszYUtKVlpwaVNvTXUydlNLVE5Cdi9lQ2RaT0tQelRQSDBu?=
 =?utf-8?B?clZLNnd1c1loNWhDZWprYVVMbCttQmVhQk96YzdlWGRTR2lBV1BqWU50VjdP?=
 =?utf-8?B?WklTRHNwaGVFUk05TVh3QmwzYkE3UEZEN1l2NEtVaVE2NjlpRklhMEROam1Y?=
 =?utf-8?B?VmREZ2hCa0Z3RzIyMTh3V043bUdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52453859F06FFF4DAB4DA95F133744A1@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cf95da-ae71-4616-8800-08dc350c5e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 07:44:01.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGjBolzljbmGJMHDhMRIZ6tI10yiaWAmcv5DRHRGZGcYo+n0FMl5XiOjrRThnH0H4mMe5YWMj7JbAZhtFltcf+fqo6TrZr758C5fyO0V/Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3396

SGksDQoNCkxlIDIzLzAyLzIwMjQgw6AgMTE6NDEsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTC
oDoNCj4gQ29tbWl0IGIzODQ2MGJjNDYzYyAoImt1bml0OiBGaXggY2hlY2tzdW0gdGVzdHMgb24g
YmlnIGVuZGlhbiBDUFVzIikNCj4gZml4ZWQgZW5kaWFubmVzcyBpc3N1ZXMgd2l0aCBrdW5pdCBj
aGVja3N1bSB0ZXN0cywgYnV0IHRoZW4NCj4gY29tbWl0IDZmNGM0NWNiY2IwMCAoImt1bml0OiBB
ZGQgdGVzdHMgZm9yIGNzdW1faXB2Nl9tYWdpYyBhbmQNCj4gaXBfZmFzdF9jc3VtIikgaW50cm9k
dWNlZCBuZXcgaXNzdWVzIG9uIGJpZyBlbmRpYW4gQ1BVcy4gVGhvc2UgaXNzdWVzDQo+IGFyZSBv
bmNlIGFnYWluIHJlZmxlY3RlZCBieSB0aGUgd2FybmluZ3MgcmVwb3J0ZWQgYnkgc3BhcnNlLg0K
PiANCj4gU28sIGZpeCB0aGVtIHdpdGggdGhlIHNhbWUgYXBwcm9hY2gsIHBlcmZvcm0gcHJvcGVy
IGNvbnZlcnNpb24gaW4NCj4gb3JkZXIgdG8gc3VwcG9ydCBib3RoIGxpdHRsZSBhbmQgYmlnIGVu
ZGlhbiBDUFVzLiBPbmNlIHRoZSBjb252ZXJzaW9ucw0KPiBhcmUgcHJvcGVybHkgZG9uZSBhbmQg
dGhlIHJpZ2h0IHR5cGVzIHVzZWQsIHRoZSBzcGFyc2Ugd2FybmluZ3MgYXJlDQo+IGNsZWFyZWQg
YXMgd2VsbC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBFcmhhcmQgRnVydG5lciA8ZXJoYXJkX2ZAbWFp
bGJveC5vcmc+DQo+IEZpeGVzOiA2ZjRjNDVjYmNiMDAgKCJrdW5pdDogQWRkIHRlc3RzIGZvciBj
c3VtX2lwdjZfbWFnaWMgYW5kIGlwX2Zhc3RfY3N1bSIpDQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCg0KbmV0ZGV2IGNoZWNr
cGF0Y2ggY29tcGxhaW5zIGFib3V0ICIxIGJsYW1lZCBhdXRob3JzIG5vdCBDQ2VkOiANCnBhbG1l
ckByaXZvc2luYy5jb207IDEgbWFpbnRhaW5lcnMgbm90IENDZWQ6IHBhbG1lckByaXZvc2luYy5j
b20gIg0KDQpQYWxtZXIgd2FzIGNvcGllZCBidXQgYXMgUGFsbWVyIERhYmJlbHQgPHBhbG1lckBk
YWJiZWx0LmNvbT4uIEhvcGUgaXQgaXMgDQpub3QgYSBzaG93IHN0b3BwZXIuDQoNCkNocmlzdG9w
aGUNCg0KPiAtLS0NCj4gICBsaWIvY2hlY2tzdW1fa3VuaXQuYyB8IDE3ICsrKysrKysrKy0tLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9saWIvY2hlY2tzdW1fa3VuaXQuYyBiL2xpYi9jaGVja3N1bV9r
dW5pdC5jDQo+IGluZGV4IDIyNWJiNzcwMTQ2MC4uYmY3MDg1MDAzNWM3IDEwMDY0NA0KPiAtLS0g
YS9saWIvY2hlY2tzdW1fa3VuaXQuYw0KPiArKysgYi9saWIvY2hlY2tzdW1fa3VuaXQuYw0KPiBA
QCAtMjE1LDcgKzIxNSw3IEBAIHN0YXRpYyBjb25zdCB1MzIgaW5pdF9zdW1zX25vX292ZXJmbG93
W10gPSB7DQo+ICAgCTB4ZmZmZjAwMDAsIDB4ZmZmZmZmZmIsDQo+ICAgfTsNCj4gICANCj4gLXN0
YXRpYyBjb25zdCBfX3N1bTE2IGV4cGVjdGVkX2NzdW1faXB2Nl9tYWdpY1tdID0gew0KPiArc3Rh
dGljIGNvbnN0IHUxNiBleHBlY3RlZF9jc3VtX2lwdjZfbWFnaWNbXSA9IHsNCj4gICAJMHgxOGQ0
LCAweDMwODUsIDB4MmU0YiwgMHhkOWY0LCAweGJkYzgsIDB4NzhmLAkweDEwMzQsIDB4ODQyMiwg
MHg2ZmMwLA0KPiAgIAkweGQyZjYsIDB4YmViNSwgMHg5ZDMsCTB4N2UyYSwgMHgzMTJlLCAweDc3
OGUsIDB4YzFiYiwgMHg3Y2YyLCAweDlkMWUsDQo+ICAgCTB4Y2EyMSwgMHhmM2ZmLCAweDc1Njks
IDB4YjAyZSwgMHhjYTg2LCAweDdlNzYsIDB4NDUzOSwgMHg0NWUzLCAweGYyOGQsDQo+IEBAIC0y
NDEsNyArMjQxLDcgQEAgc3RhdGljIGNvbnN0IF9fc3VtMTYgZXhwZWN0ZWRfY3N1bV9pcHY2X21h
Z2ljW10gPSB7DQo+ICAgCTB4Mzg0NSwgMHgxMDE0DQo+ICAgfTsNCj4gICANCj4gLXN0YXRpYyBj
b25zdCBfX3N1bTE2IGV4cGVjdGVkX2Zhc3RfY3N1bVtdID0gew0KPiArc3RhdGljIGNvbnN0IHUx
NiBleHBlY3RlZF9mYXN0X2NzdW1bXSA9IHsNCj4gICAJMHhkYTgzLCAweDQ1ZGEsIDB4NGY0Niwg
MHg0ZTRmLCAweDM0ZSwJMHhlOTAyLCAweGE1ZTksIDB4ODdhNSwgMHg3MTg3LA0KPiAgIAkweDU2
NzEsIDB4ZjU1NiwgMHg2ZGY1LCAweDgxNmQsIDB4OGY4MSwgMHhiYjhmLCAweGZiYmEsIDB4NWFm
YiwgMHhiZTVhLA0KPiAgIAkweGVkYmUsIDB4YWJlZSwgMHg2YWFjLCAweGU2YiwJMHhlYTBkLCAw
eDY3ZWEsIDB4N2U2OCwgMHg4YTdlLCAweDZmOGEsDQo+IEBAIC01NzcsNyArNTc3LDggQEAgc3Rh
dGljIHZvaWQgdGVzdF9jc3VtX25vX2NhcnJ5X2lucHV0cyhzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+
ICAgDQo+ICAgc3RhdGljIHZvaWQgdGVzdF9pcF9mYXN0X2NzdW0oc3RydWN0IGt1bml0ICp0ZXN0
KQ0KPiAgIHsNCj4gLQlfX3N1bTE2IGNzdW1fcmVzdWx0LCBleHBlY3RlZDsNCj4gKwlfX3N1bTE2
IGNzdW1fcmVzdWx0Ow0KPiArCXUxNiBleHBlY3RlZDsNCj4gICANCj4gICAJZm9yIChpbnQgbGVu
ID0gSVB2NF9NSU5fV09SRFM7IGxlbiA8IElQdjRfTUFYX1dPUkRTOyBsZW4rKykgew0KPiAgIAkJ
Zm9yIChpbnQgaW5kZXggPSAwOyBpbmRleCA8IE5VTV9JUF9GQVNUX0NTVU1fVEVTVFM7IGluZGV4
KyspIHsNCj4gQEAgLTU4Niw3ICs1ODcsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2lwX2Zhc3RfY3N1
bShzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+ICAgCQkJCWV4cGVjdGVkX2Zhc3RfY3N1bVsobGVuIC0g
SVB2NF9NSU5fV09SRFMpICoNCj4gICAJCQkJCQkgICBOVU1fSVBfRkFTVF9DU1VNX1RFU1RTICsN
Cj4gICAJCQkJCQkgICBpbmRleF07DQo+IC0JCQlDSEVDS19FUShleHBlY3RlZCwgY3N1bV9yZXN1
bHQpOw0KPiArCQkJQ0hFQ0tfRVEodG9fc3VtMTYoZXhwZWN0ZWQpLCBjc3VtX3Jlc3VsdCk7DQo+
ICAgCQl9DQo+ICAgCX0NCj4gICB9DQo+IEBAIC01OTgsNyArNTk5LDcgQEAgc3RhdGljIHZvaWQg
dGVzdF9jc3VtX2lwdjZfbWFnaWMoc3RydWN0IGt1bml0ICp0ZXN0KQ0KPiAgIAljb25zdCBzdHJ1
Y3QgaW42X2FkZHIgKmRhZGRyOw0KPiAgIAl1bnNpZ25lZCBpbnQgbGVuOw0KPiAgIAl1bnNpZ25l
ZCBjaGFyIHByb3RvOw0KPiAtCXVuc2lnbmVkIGludCBjc3VtOw0KPiArCV9fd3N1bSBjc3VtOw0K
PiAgIA0KPiAgIAljb25zdCBpbnQgZGFkZHJfb2Zmc2V0ID0gc2l6ZW9mKHN0cnVjdCBpbjZfYWRk
cik7DQo+ICAgCWNvbnN0IGludCBsZW5fb2Zmc2V0ID0gc2l6ZW9mKHN0cnVjdCBpbjZfYWRkcikg
KyBzaXplb2Yoc3RydWN0IGluNl9hZGRyKTsNCj4gQEAgLTYxMSwxMCArNjEyLDEwIEBAIHN0YXRp
YyB2b2lkIHRlc3RfY3N1bV9pcHY2X21hZ2ljKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4gICAJCXNh
ZGRyID0gKGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqKShyYW5kb21fYnVmICsgaSk7DQo+ICAgCQlk
YWRkciA9IChjb25zdCBzdHJ1Y3QgaW42X2FkZHIgKikocmFuZG9tX2J1ZiArIGkgKw0KPiAgIAkJ
CQkJCSAgZGFkZHJfb2Zmc2V0KTsNCj4gLQkJbGVuID0gKih1bnNpZ25lZCBpbnQgKikocmFuZG9t
X2J1ZiArIGkgKyBsZW5fb2Zmc2V0KTsNCj4gKwkJbGVuID0gbGUzMl90b19jcHUoKihfX2xlMzIg
KikocmFuZG9tX2J1ZiArIGkgKyBsZW5fb2Zmc2V0KSk7DQo+ICAgCQlwcm90byA9ICoocmFuZG9t
X2J1ZiArIGkgKyBwcm90b19vZmZzZXQpOw0KPiAtCQljc3VtID0gKih1bnNpZ25lZCBpbnQgKiko
cmFuZG9tX2J1ZiArIGkgKyBjc3VtX29mZnNldCk7DQo+IC0JCUNIRUNLX0VRKGV4cGVjdGVkX2Nz
dW1faXB2Nl9tYWdpY1tpXSwNCj4gKwkJY3N1bSA9ICooX193c3VtICopKHJhbmRvbV9idWYgKyBp
ICsgY3N1bV9vZmZzZXQpOw0KPiArCQlDSEVDS19FUSh0b19zdW0xNihleHBlY3RlZF9jc3VtX2lw
djZfbWFnaWNbaV0pLA0KPiAgIAkJCSBjc3VtX2lwdjZfbWFnaWMoc2FkZHIsIGRhZGRyLCBsZW4s
IHByb3RvLCBjc3VtKSk7DQo+ICAgCX0NCj4gICAjZW5kaWYgLyogIUNPTkZJR19ORVQgKi8NCg==

