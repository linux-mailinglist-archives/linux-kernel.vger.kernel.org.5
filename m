Return-Path: <linux-kernel+bounces-107516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9829A87FD88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B511F2371B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4807F7D3;
	Tue, 19 Mar 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="bNUlBAik"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CBC7F498
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851242; cv=fail; b=qAah60O6kY2DavgJMeJ6Q/Z+7BELcaGY+9D8l2tfbFUmgwmsiX6nRYhuU6J22P1mMaGDHL9KCpjMvAnVJREI9AoWdS0Q0hUlU1YTWFP7Nu64c/MZ4yYfugwp9k+9AZU8iot1l/QF2I3+01v1thA9D2PrXkEfyHemV1X1B9KbZws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851242; c=relaxed/simple;
	bh=B+s/Fp+dpWdvq6EydJqLtLQpGg7AAjutEzlFjcUHdjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bb9I+Uf3lxE3jzikUHoFVSDK+8qJJJ86cnMPhtd/Jk7CCVqWo6po4oYBISQyA+g3i1qrnr/ipCZ1NMLH7LIwwPl+b13nJiA5QXX0P+DQYH58epGwtwi4iL+S3kqiqwbJis2vPGVdbvRJucyfy7zCR7MpiGLHC+u090dhl3IL6+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=bNUlBAik; arc=fail smtp.client-ip=40.107.117.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTqj8jUScciS2HZ+FgXNLHdLdymnzem2rhiwnNkwrZ5F4YO/Cnmt5HXYD/SoMvFeIjna8znApmCJEQ6Jyo7xtBsuYaw8CoLTPAcygyD5idViBWKPhq+rD8VosZtLGdyyqnPlqj02ZVhifY9FAl8Nx1YfAhWcqcVJdDL/rmM0jXzZUo6LkAZ0zAymCZ1pSxI+N1qU8TNMK7ZDIdrcbEEPTFEspTLaj3+WhYuHHAsnE0ipq83t7dBlIofmlUr5fhHF5xhvsVSPpYYblzwCKPnJF5lNfdYD4GLNISMJA7tRJGCiu87NkIQWSWi2W7Cdv1WlKZFdSSfDGBMaSfcmFCf3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+s/Fp+dpWdvq6EydJqLtLQpGg7AAjutEzlFjcUHdjY=;
 b=QmBBQS7SDNA4b7t4cvmlRpPhQUIEZkt0bumhlP0kLkS5gdIC0LQi50KxvIR5ezAgPyBqOEpSgf2SpEyrSaDQS5ugJZqKwl8IJPfiDCERcddth5LE/nRvYmudCkvo3u32H0dgJBKxYSsRCrucZUyb/XPhg5e7HCWAugrCEmGf8P5G4HVUnH88bxZ22oO6x3JHrtOMu5tKmwPaqTfutEVYQGs9JaS3oziHl0Yywne8C85+HC0aNIeZvezsqrAzE97f+Fnd6+jyV+8Vv96TtQ01KK0BKgsGJGPj9pJqexT5Wv2xNJtm7e9xw6vpgcgqsJWSlk+z8Q4LTPaent5iXWRKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+s/Fp+dpWdvq6EydJqLtLQpGg7AAjutEzlFjcUHdjY=;
 b=bNUlBAikpao6NB3GqteeikbG0m5D2PLyYqUPbdCjVLKvOKlY4qaQo4U0wuOfmVlPZtfAN6Jdhu8fIDkWtx+B7rPKKmxQdVPxngaQx9qh34x4GuQNpFQiV7uxLFrqXsYP80yiA7zjlXlKhDSfDKphyUYGQDw74dmLbyobPz2zeOc=
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com (2603:1096:101:194::8)
 by KL1PR02MB7855.apcprd02.prod.outlook.com (2603:1096:820:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 12:27:17 +0000
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::bc02:302a:a551:9b07]) by SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::bc02:302a:a551:9b07%5]) with mapi id 15.20.7386.023; Tue, 19 Mar 2024
 12:27:17 +0000
From: =?utf-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
To: Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nathan@kernel.org" <nathan@kernel.org>, "ndesaulniers@google.com"
	<ndesaulniers@google.com>, "trix@redhat.com" <trix@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "surenb@google.com" <surenb@google.com>,
	"zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>, "yuzhao@google.com"
	<yuzhao@google.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Thread-Topic: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Thread-Index: AQHadrFVJJtVzEecOUS87iMUQEAAwLE+yQmAgAAlWQCAABXJAA==
Date: Tue, 19 Mar 2024 12:27:16 +0000
Message-ID: <fdc90410-5698-4cda-a7c2-952480c7e7e6@oppo.com>
References: <20240314141516.31747-1-liuhailong@oppo.com>
 <20240315081803.2223-1-liuhailong@oppo.com> <ZflTCY-Oaxm0U70u@tiehlicka>
 <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7164:EE_|KL1PR02MB7855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SVaS7Xld2WB5i+oRiz8hprj36vAsA4L+Zg7UFo1kaNAYMQe8kxQFcN0fUhY62ke9yaoVORdxIddT9sZZFAzV1kv5n0wj7DG1k9BIAmPuX4qtg7PscIQPSKG/M/Er2P8RnbiY3wvLqRVEhjdFox4JY+z3GD989GNwvzKgDHWtirmKCDCe6rvh2jUnbbdiMz6lueJO4Z0hUjrMMJ8cvMvNo6wdM3rcF+0XL/7pbKuyoabbHq4Ua6sJpq7DCWdctyFoC3X5aNwmmH447LJQABM7b9BxKOoI8BHPpBg5uVwXJtJiXQfKhxjq+KxwFrbEKHqhoCVlBDuXo2v2jFQjcj9/p1SwMHrMdDskeh9k+cmsidfW1+9D1QVv72Xm/O9KeJOuuJPmg85DMPgkgKlrsyOb23N+iyybVyQCQhLlbWOl0e/ZV0sRaQcknlKXlAR5DJJIGFQCNDY/cvsEuKueT8jtb1ZI05fYm7ktvriq4FAbYvKc7uNcxGKZDMoMnkq0ovquO4uYx+uvw+6PYMqZs3cii3JoMrN56w90ZOx05XETx/sSycbWBmH5BCuJPjZaj9IE/T7LfOngVZSsJMRBAe8cCvycpcX58Q390+oVpaUxSvY1gKoUNqxT/akExgf8mLWy+cLHvVTb8edWVrDXo1WAqoHwk1HjSoGAMB4EyxzK488=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7164.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3hRckV2WGMwelp0MWYwRDY2bmpjWEdna1IvZUlJS09DcDhwY0Iwa1R4ZUdt?=
 =?utf-8?B?Q0F4UXJPM2pHMzdwckw5a2w2OFpLTFpnRjlMTERUZ2I1ZnNoREdNdDNRdlhv?=
 =?utf-8?B?TXNKOGFHRUordGc4UkgyR21nWFl2UThzMGhpL2U5N0l0dWxuOFFObU5YYzBU?=
 =?utf-8?B?NXYvOWgzUlJGdGNuL3dweGVMZTJQaHI0V05MWW1sY2Z5SWtkZm9BUVUxa3FD?=
 =?utf-8?B?QTZVYWs2RmtLdXB5WHljenNQZTBZYWhpaGtyZTJDd29GbjdQQ1FWUFVJL0VJ?=
 =?utf-8?B?YWQvSVBVcDg3SnM0b0NiQ2k1c1c1Rk9MZmlDOElFTmdjRjlzeGtjLzF4TElQ?=
 =?utf-8?B?UW10V0VJdkYxWUdyQjZDL3NBOXVWUGlQbDlpZkkwejlTQm43VWl4TVBGSjlK?=
 =?utf-8?B?QkVFb1RTQXE4ZitQenFMeDIydzdQYjZSWEs3SWlHRmd1YkZsYXlXVUJqVUlh?=
 =?utf-8?B?dVpUR2xvNmxmSUQ4NFIxM01HQnFJY1FsRytVaG1MSHZSNVpEMm8yNzNUNkFU?=
 =?utf-8?B?TDFVdjYrMExxOG9mblM4VlZlMklnMzZzN1JIRHVNYzRiVzhXeVJOR3c4WEgz?=
 =?utf-8?B?TjFVditLNEwzU3k5L3NMUXdoVWdQVWFGSzZVSVB2YnR1bjZoWWplVy9GVFJW?=
 =?utf-8?B?VHNNR25rTWc0TVNPby9hU3BxWmU4WmRIbklwVnVXeE1VMmdYdjJwQVlkWXN1?=
 =?utf-8?B?ckx5VzA5MmtKZGlPZHM1UzViRDdyQk41U0ZoTllkUWk5QVNNWThjY1Z0Z1R0?=
 =?utf-8?B?NSsrTE9pNlAyeWprTWk2a0NiWENyVnFLZEdlb1dsam1iYkVmcks0SVBKR0Vp?=
 =?utf-8?B?RFBLb3ZmM2RJekRwS29kSUFxcW9rRWZsVVZpekV2ZjdGWlNISmgxL1BGSFdF?=
 =?utf-8?B?M1grNFIreGVJZnRtVG9YVDlySlRNaURiNElGUjc5S213bm56a1A4OEtCdjha?=
 =?utf-8?B?V0NoVnhPYUhQUFVEWTZ0MmNBK0FyTmhQMmJ2SVpiMTRoOW1QN00vYmN3V1p6?=
 =?utf-8?B?QUE5NTU0NHRncWlFTi9rL3VVLzVPejBiQWkxQmdaQUp4VU5BUUJHTjhrU0RS?=
 =?utf-8?B?TE9lZy9yV3JyNHU3QVJmcGxERHRCNnVEYzlGNy9hWmRrd1JscmlqbERZYmN6?=
 =?utf-8?B?ZkFFTENMYmU5UjFnVkNHckpPUXg4UkJzZHhZV3dyNFFYSnhOQit3RzExVGZF?=
 =?utf-8?B?dE9qQmU5SFI1Vkt4RFA1REc1R0hoN2RSNHk1cHBBbCtTNTczSHBhY3VtWTds?=
 =?utf-8?B?dzNWWWNXOHFRTjNuVnd0R083NkdibUhqL0RiQUJuM0JIbGpVWUNFbEZHU2Rt?=
 =?utf-8?B?WEluTjJrSHVTQ2RMYTJ3VGhuREkzdEp4NHpkWXZRVDBnUVA0RktrVXdPVldP?=
 =?utf-8?B?Y1Q3NndMRFF3R0RpVGxqTzFwZ0o4NndCSmlTSjdSTXcxNmorYXVOSlh3ZVUy?=
 =?utf-8?B?dGF2TWNGbHZoRnNpZW9jTWU3aXFoM2d6N045SUQ5U3BNQWRlZlllUHp1aElL?=
 =?utf-8?B?REorWWhFN1NrdEJMRHRXMC81Z3I1WmIzVGRoQ2FBYlZsdjNadlVWaW1VRExV?=
 =?utf-8?B?Uy9Pa3Avb3MwNTNZKytiaExvSkhsNjZyQmRRczNyTVJpeHdTcTNyLzFmQWUy?=
 =?utf-8?B?aUt5ODNjQzFCWjhnVVhtSHkyQ2VRODVKNzJRYXJDbGlZUC91Vmw2Y0ZSUW5a?=
 =?utf-8?B?dk1HQnVsZTRLYTUxWkk2eUd2RUhaWEVzRXJ4b1hmUkNiaGMxRS85My9Eb1lo?=
 =?utf-8?B?K2dFdnhxbnVlYjhDUWsraUhrcnZuVEV0WGxESnVZNElpcXhNNG9xbUVody9u?=
 =?utf-8?B?TWpNYXBIdTR1ZmxsZXJjNlc2MnFlNW8wS1BCaUJsWlc5c0ZJNTRoVWg1SGpV?=
 =?utf-8?B?ckpuSkVyTXRpRllQbnJHSlBFS1dhTW9keEZMQmVjSHV5ZjJLZ2FGYU9Gd3JX?=
 =?utf-8?B?R0pSNmtlNmgvZDU1RWVvOWZndUQwa1QyakRLMFUxcENVeUI0bWpFSTk5N2dQ?=
 =?utf-8?B?UUFYSGhmRHJVN2pDd1hXRjRHVFkxUDFucUdNOXZLaW5iUkVoa1FabkpnYW9m?=
 =?utf-8?B?T2VnSXg5cHZ6NU5pOG13SWpoT29rS25JQTVmRXNES1ZLVm5jR29GdWJCU3JR?=
 =?utf-8?Q?Qz6y/qV2HLbvHc4FhWU0T48OD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD297940E5F5C45A2F8CA4947E7F8F6@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7164.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97cdd93-0715-45c5-b552-08dc480fea2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 12:27:17.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qV8+co4/qWWxBf9a77iORDCEkSObMRTqp7zkgFwNqcfVIlWUcb3xnL/xh/iwkBMl1Y78Ca4cSzZ64YNuabwpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7855

T24gMjAyNC8zLzE5IDE5OjA5LCBCYXJyeSBTb25nIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAxOSwg
MjAyNCBhdCA0OjU24oCvUE0gTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+IHdyb3RlOg0K
Pj4NCj4+IE9uIEZyaSAxNS0wMy0yNCAxNjoxODowMywgbGl1aGFpbG9uZ0BvcHBvLmNvbSB3cm90
ZToNCj4+PiBGcm9tOiAiSGFpbG9uZy5MaXUiIDxsaXVoYWlsb25nQG9wcG8uY29tPg0KPj4+DQo+
Pj4gVGhpcyByZXZlcnRzDQo+Pj4gY29tbWl0IGI3MTA4ZDY2MzE4YSAoIk11bHRpLWdlbiBMUlU6
IHNraXAgQ01BIHBhZ2VzIHdoZW4gdGhleSBhcmUgbm90IGVsaWdpYmxlIikNCj4+PiBjb21taXQg
NWRhMjI2ZGJmY2UzICgibW06IHNraXAgQ01BIHBhZ2VzIHdoZW4gdGhleSBhcmUgbm90IGF2YWls
YWJsZSIpDQo+Pj4NCj4+PiBza2lwX2NtYSBtYXkgY2F1c2Ugc3lzdGVtIG5vdCByZXNwb25kaW5n
LiBpZiBjbWEgcGFnZXMgaXMgbGFyZ2UgaW4gbHJ1X2xpc3QNCj4+PiBhbmQgc3lzdGVtIGlzIGlu
IGxvd21lbW9yeSwgbWFueSB0YXNrcyB3b3VsZCBkaXJlY3QgcmVjbGFpbSBhbmQgd2FzdGUNCj4+
PiBjcHUgdGltZSB0byBpc29sYXRlX2xydV9wYWdlcyBhbmQgcmV0dXJuLg0KPj4+DQo+Pj4gVGVz
dCB0aGlzIHBhdGNoIG9uIGFuZHJvaWQtNS4xNSA4RyBkZXZpY2UNCj4+PiByZXByb2R1Y2VyOg0K
Pj4+IC0gY21hX2RlY2xhcmVfY29udGlndW91cyAzRyBwYWdlcw0KPj4+IC0gc2V0IC9wcm9jL3N5
cy92bS9zd2FwcGluZXNzIDAgdG8gZW5hYmxlIGRpcmVjdF9yZWNsYWltIHJlY2xhaW0gZmlsZQ0K
Pj4+ICAgb25seS4NCj4+PiAtIHJ1biBhIG1lbWxlYWsgcHJvY2VzcyBpbiB1c2Vyc3BhY2UNCj4+
DQo+PiBEb2VzIHRoaXMgcmVwcmVzZW50IGEgc2FuZSBjb25maWd1cmF0aW9uPyBDTUEgbWVtb3J5
IGlzIHVudXNhYmxlIGZvcg0KPj4ga2VybmVsIGFsbG9jYXRpb25zIGFuZCBtZW1sZWFrIHByb2Nl
c3MgaXMgYWxzbyBoYXJkIHRvIHJlY2xhaW0gZHVlIHRvDQo+PiBzd2FwIHN1cHByZXNzaW9uLiBJ
c24ndCBzdWNoIGEgc3lzdGVtIGRvb21lZCB0byBzdHJ1Z2dsZSB0byByZWNsYWltIGFueQ0KPj4g
bWVtb3J5PyANClllcywgQWxsIHByb2Nlc3NlcyBpbiB0aGUgc3lzdGVtIGFyZSBhbHNvIGhhcmQg
dG8gcmVjbGFpbS4gYW5kIGFsbCBwcm9jZXNzZXMNCmVudGVyIGRpcmVjdCByZWNsYWltLiB3aXRo
IHRoaXMgcGF0Y2gsIG11Y2ggb2YgcHJvY2VzcyB3aGljaCBzaG91bGQgc2tpcF9jbWENCndvdWxk
IHJldHJ5LCBzY2FuLCBza2lwcGVkIGluIHRoZSBwcm9jZXNzIG9mIGlzb2xzYXRlX2xydV9wYWdl
cy4gYW5kIHN5c3RlbSANCnByb2Nlc3Mgd2lsbCBoYXZlIGhpZ2ggcHJpb3JpdHksIHNvbWUgbm9y
bWFsIHByb2Nlc3NlcyAobGlrZSBrc3dhcGQpIGFyZSANCnByZWVtcHRlZC4gDQoNCg0KQnR3LiBo
b3cgZG9lcyB0aGUgc2FtZSBzZXR1cCBiZWhhdmUgd2l0aCB0aGUgcmVndWxhciBMUlUNCj4+IGlt
cGxlbWVudGF0aW9uPyBNeSBndWVzcyB3b3VsZCBiZSB0aGF0IGl0IHdvdWxkIHN0cnVnZ2xlIGFz
IHdlbGwuDQo+IA0KPiBJIGFzc3VtZSB0aGUgcmVndWxhciBMUlUgaW1wbGVtZW50YXRpb24geW91
IGFyZSB0YWxraW5nIGFib3V0IGlzIHRoZSBMUlUNCj4gd2l0aG91dCBza2lwX2NtYSgpPw0KPiAN
Cj4gSSByZW1lbWJlciBIYWlsb25nIG1lbnRpb25lZCBzb21ldGhpbmcgbGlrZSAiIGl0IGFsc28g
dHJpZ2dlciBtZW1vcnkgcHNpDQo+IGV2ZW50IHRvIGFsbG93IGFkbWluIGRvIHNvbWV0aGluZyB0
byByZWxlYXNlIG1lbW9yeSIgYW5kICIgd2l0aG91dA0KPiBwYXRjaCB0aGUgZGV2aWNlcyB3b3Vs
ZCBraWxsIGNhbWVyYSBwcm9jZXNzIi4gIFNvIGl0IHNlZW1zIHRoZSBkaWZmZXJlbmNlDQo+IGlz
IGlmIGEga2lsbGluZyB3aWxsIG9jY3VyLg0KPiANCj4gSGFpbG9uZywgd291bGQgeW91IGxpa2Ug
dG8gcHJvdmlkZSBtb3JlIGRldGFpbD8NCg0KcHNpX2V2ZW50IHRyaWdnZXJlZCBhZnRlciBwc2lf
bWVtc3RhbGxfbGVhdmUuIG11Y2ggc3lzdGVtIHByb2Nlc3NlcyANCnBlcmZvcm1fcmVjbGFpbSBz
Y2FuIGFuZCBza2lwcGVkIGFuZCBsZWF2ZSB3aXRob3V0IHJlY2xhaW0gYW55IHBhZ2VzLiANCnRo
ZSBwcm9jZXNzIGlzIGZhc3QsIHNvIGxta2QgKHVzZXJzcGFjZSBsb3dtZW1vcnkga2lsbGVyKSBj
b3VsZCBub3Qgd29yaw0KYXMgYmVmb3JlLg0KDQo+IA0KPj4gLS0NCj4+IE1pY2hhbCBIb2Nrbw0K
Pj4gU1VTRSBMYWJzDQo+Pg0KDQo=

