Return-Path: <linux-kernel+bounces-28292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C793482FC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721F928E340
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C560C2E636;
	Tue, 16 Jan 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCEHBf1P"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597232CCDC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440032; cv=fail; b=DkUArm7Tfxilw6a1NT7J4/75X09d/8cPdg/NvWHQzzJAZaZ+ZszbDXZeVl+RORqune0YExeXNztsYqfR8tynEVW8i3X/wU68aZtQVJ7P0W061Z2RtPNnV3YAa2op0x+GXTAmutC+2tFmrIGZoTVRMrK7xA4/Tg7UWiZ85rtSehU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440032; c=relaxed/simple;
	bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=SjR/yxv/dH0R8HDMzN4CFE3/yFaDs358A1t2ijmJE6DL5Pd0lIqgIwoy+3Qd/AU9gLjGD74Nh2KAsFPcY5Gk1AfZIGckXd/Q/SartP3ra++upf4eVM+Al+k1wUz/fEwPNrv7huIHb3vVkpQfjd2SZfcnTCC+QHjYZvwqKnnNc1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCEHBf1P; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOONQ5VOJzI/ujJbYYVRnFuuZESSb+EAfL+L17kVpuU06fS1+aWbHBiOhx1OIYSfLX+G49iH9XaLVwKYK0lmWR2ezTHWdUtL/4WDZ/XtYNppPf+X9IvQo1+aZtoe+snxnKXqgAcSey+3Be/JY+ask5Zm317eB78fFvwG+Hn/TF1Ddn+clmy36yLzBDdcLu/mfFVbzSYxgWffy44jK2dubx5isVsXA9Rvxntgq5kwGVqA9QF+oWX9Qi6XqkU/eHQlwaUBk26VRJghAqDY8TXmwoqvxdx0HrLRH/g5VU0EnpgViDcY3iqo3Y9T/icCQm6jsPUIaIng5Cg45vm7Tt0Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=;
 b=TX5hHQEGwTYum7N/lkomlSdSjC5qVm9MAJlySIkA3HLzEzgYH7/HNMoDkGVhVIk6kPcWG6chl/N4WNsZQuX4xF6tI5Jwmh7tSLEwnd9x0UzOUv8FqEsxRvE6b2H6Ko7P52ypZxZ1C56tcOaCd1H1+j/5Zsirn0FWZo66AKNFojV2LHXaQbRIt7UR5TFizkadRikowXIkBZmEFKYpSjwZTaHwlXKGkgErNy8FKZb+AYj3y7JaAIIr4wMvawa7vfNTJGfnupoZ8ZgHYFXlFPnbxalX+RGDs4oevOtZxfDOk65IAhg3r4Vq3n4OqQ/X3OpJ81LIvIe4CWPAjssmCeGnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0IWKjfKD3NsSKrU/8hPuaokox8S4iB3903GphNPpoA=;
 b=YCEHBf1PRMbEsKhv5pYzyMv3P1HskezTzXd3eqFOCc3cSphVR+uw2lIApamIk/Bvh01E4d2Ux1NQkj79J/q2iVtgVG1IVjFPTgjP1W4IwZU9zqNbRemA4Vu4B/2wLBNeFOYcYqMUMh1zaQbM7uq5+ccaoPxxcu7MrVJq+n8Wewz2SqPjNIkYYD9n+ifBKZ29CQTRCpbKhauRH89BGoDxeNEz6FCSrSP5Q1CYHskxI4c/IIfGD2pOyoJRZKAd3a+lsV8uri2IBqnAGMLiTFYlTVjF8y/PeCrhDtUg9wt5hBC5lcE8Y/EGdkhsQkIc4D6XalGwCNb5RmdxACjMmYdc0Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 21:20:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 21:20:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: stuart hayes <stuart.w.hayes@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Topic: [PATCH] nvme_core: scan namespaces asynchronously
Thread-Index: AQHaPyygJ0tk7b1GZk6+BJOtRok3pLDJ3RcAgAOo4YCACRkPgIAGQveAgAAjUAA=
Date: Tue, 16 Jan 2024 21:20:28 +0000
Message-ID: <385756c5-875d-4806-bdaf-70237c158e95@nvidia.com>
References: <20240104163826.10561-1-stuart.w.hayes@gmail.com>
 <ZZbhKM0L8pFYX_zd@kbusch-mbp>
 <19075505-b1a6-48d3-9732-7277c4697cf6@nvidia.com>
 <6af7ec28-2114-47da-a5a6-b0b6357169eb@gmail.com>
 <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
In-Reply-To: <54b5e83b-4b08-4c5e-afec-1c672561fa81@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8963:EE_
x-ms-office365-filtering-correlation-id: 7407e677-c493-41d8-372d-08dc16d8f68b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IawNFuWVdrUDKyakE0ypf4YeKN2YBLeXRji1zISA/rhLYNY/cZXtV49tttFZhYU1iCdx/FptownhmKBGMRLjcioZrsoXoi5HSrTU5gw/hKRy5lkHnGs3PdacWQH2seJZQnsXgKqaEAeqwNPRjqkkXrNJVvwzjbWJrb+s43ojJEo2PX/WLjFi9bB+Ms4ihWuWbc12920t4z670IY+Cd+by1V3Y5dvxdmxKI3dANoci3RNJpwbSyW2POULgkfqekkGmstF1anLWY0DbNlQG+PCa296b6vO6zfyImf2lDphgKCHb+iJukpJRiJoYCGXM/GqI8dHPYbUSDanEO2M0vo3aeppwmZrOWVFkQDUElvDYKn21FxxOxUKF8VhBGfrxuQF+QfkpSeBhLn5MZzqb0+LLfSUmnk8rIUOuQU2kBBRil3w3PnXhLtNKdPG8GeM45seKSKyGQuaAE02ImI80gZWt7PmA+dLOu59y0KiNvTQLEjFwvfK/wk50iiRzkzWGyfPn6+PN9TQ/RComG7LKBtd1fydyqrAdgKdeReaXO8+ok43XdDyjE3V6J/xPDQymDyF/dXqAHoyqVb3wmjz2SUpBLJGXNP4BLXrDWk0G+S+e3H7RnbHcRLosALvISOQod4fGKPHi4SpfoW0rj3qeI/ZMfSwzt9+UGDs4EgY4Vd45wTOj9XX/8LYnO8tkELIsVfB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(64756008)(66556008)(26005)(2616005)(76116006)(66446008)(66946007)(316002)(66476007)(91956017)(71200400001)(54906003)(4326008)(6916009)(8676002)(6506007)(8936002)(6486002)(6512007)(478600001)(31686004)(4744005)(2906002)(5660300002)(38100700002)(122000001)(31696002)(86362001)(41300700001)(38070700009)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDJXOTREN0Zoa1hnYjg1bEhFMlNRakRqNlFLT2RnMVFGMU9oRHJlZCtZdDk1?=
 =?utf-8?B?WHFMTHF1ZFdGdVVxRUk2aEZJSnN3Qm95cjFzNzhSVmpKRWo0bmtyMEV3WVNs?=
 =?utf-8?B?SHVaaVJQa014azdGMWdRRzRZa2M2VW5UWDhJV1Z6NjM1V09rT3F5dTVsMmRJ?=
 =?utf-8?B?andnd0lTdnBTTm1tVm90cDVtVUp0VWExU3pYTEQxUFFPMWh3Mkh4ak9ub2l4?=
 =?utf-8?B?aFRicmpBVmZySUxZUmVZZGU4NUMxeHFCM2FKcVRqcXF1RkNNdlF2UnJuakIr?=
 =?utf-8?B?SFQ5dTVNMUZNU2xsSGQwUktiRy8rN1J6SFFpNGQ0WVBmTFN6bnN6WSt1UUhO?=
 =?utf-8?B?TGpWTG95L1hXZ0gvS3NMT25vM1VheDBNcXlobm5HV1I3MXhMYlhENE83YmFn?=
 =?utf-8?B?VFAyR256VWo1YnRORE83ZHBqU2VGL2R0TVdySzIxK2gvRmNoZGtMdlQ5RERw?=
 =?utf-8?B?c05lWFp2ZzFJNVZrckJBa1gxK3NtZUhHK1dKNmt3dnpVRFJ4c3pZRmYwNkYx?=
 =?utf-8?B?SU8rUlptd3p5UGxrNHBabnl1UHpqcjZsL1FLdW1QQUVBbkxvenNEYXdPeXpZ?=
 =?utf-8?B?THpSczRvQ21lUHFNQm5NQ1dHdERUbGhUR0RObEE3S2M1Mkxjc1hFU25JYUdH?=
 =?utf-8?B?aTNJT3hnSUVWZGUvakwzYjEyekFXRXpUbHRrYXpXRnUydUZoOGlVQXB2RTBm?=
 =?utf-8?B?cXEwaXF5UjRkeTU3Y1JNY2FZeTBxZTNvajVYVS9vamNBemJTQ1NwNGpRckk4?=
 =?utf-8?B?OUdWc1VrUGl1NWRzVE45S1JTZEpkQ2ZCaFlLMkI5ZCtNMFJ4alptRFNxWkNl?=
 =?utf-8?B?TjYxNTVrSUFhZ1JXU1I4MmxmWG11Rnd3a2tYQ2pEb0U0RTZOUFNNOGR3ZDQ3?=
 =?utf-8?B?ZDFkdUdEM2doWGRtSk9uaEd1OUFKak12ZDRJclZMZU1pUkk4V1JTUG1uYS9a?=
 =?utf-8?B?blVlb05ORG1yLzNvTy8vNEJhWlFiN0tRaTF0YW02bDRpTC93TGtzeTNFMUU5?=
 =?utf-8?B?S0xNRlJLZ0hDTDJVN3BBNmFQTE9mOHZXbDBJQTZjc3JNVTBZakRlZnNld1Q2?=
 =?utf-8?B?OXMzNVN0RVZrWldGV0d0Vm95ZUUrSDIwL3N1NXhQci9MTDdscUU5UmpHSFk3?=
 =?utf-8?B?ODkzcnExRXRId0FMMDRSNjhTbm5laS9HNFMvSXdHRXlzcm1Xa0FMelRIUFo5?=
 =?utf-8?B?WEhib3JSZWxubzkydjBMM3JFa2J0dSt1dVhMNjNETVRmKy8wSHVIdDZoK0JL?=
 =?utf-8?B?SU5yS3JtSXEycldEcEt5SVR3bGJUUWs0L2ZsZkozZ05rQVRVVER3ejdpWlJU?=
 =?utf-8?B?QmdabUhHWXVubEFYc2JabXhFcitpNEFJcndnWVVaVE5PRENGVG84SU44L0Zl?=
 =?utf-8?B?MkpPVEU1NjN3SkdNT29qbzZJSWpsWExMN2loNzFubVpCdllpYkkva0FSVDFF?=
 =?utf-8?B?NzZ6cjFXaFhzREZvcXFydzlMY2M3TThodzVYdkRjcW5xSEpGQ2FidURzeVBK?=
 =?utf-8?B?VzdRYUV4T3hXWXNLdyswTHhQdngxaEYzekZ2RXo5S1ZyWHUrQUJqblZIaEZ1?=
 =?utf-8?B?Q3A3Q1hNMUJiOUVjR3l6N1VHSm8rWUF3Slo3bUxpRHJLYkNZRUo1eWpRdEg5?=
 =?utf-8?B?dlVwR2N3L1BKbU9RYnlGNERuNkZlMGVnRElqK1ZNSGNXUEV1eXpiL1ExU1lN?=
 =?utf-8?B?dHgyN2lnQ1Z3eDFUN2ZnUU1WZDZxSndFaVBLcXhGVTJyRS9aelBIZS9ST3BB?=
 =?utf-8?B?eHB6bHVuNHI4WWNGelNqUWlwVWp0TzNuNkdsNUZ5UTNIUXVxSk5UTHlLa3Q2?=
 =?utf-8?B?Wk9WZkRWRU1wckpEWFI5azVuNDJPN3Y0M3NCZjhJRE1mTEM0Qnh6cmpmc0s2?=
 =?utf-8?B?RDg1dnM5L212TTBLSE9VYmlXUlRtQjQzOXJOb2FEbXpWUTI3dXMzTkFrTGpa?=
 =?utf-8?B?UEEzSmFBVWRuMlNHaXF3RXNYRS85Uy9TVmVWcmhWUmljOUxUYUEzVXY0RjBx?=
 =?utf-8?B?SU1pU25Ed0lzVU0vUVFiRXRKQzVnMkRNSHY4RXJ3cDhNOTRMcEl5bE1PVms0?=
 =?utf-8?B?cTVWc0Q4QUQ4MjZkV1dlZUtXUm5VcjhsYlNNaDBacnNzTXNURExUdTNvSWI1?=
 =?utf-8?Q?+7QaFwALu7EJCRv7QburIRLdw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA12912B8A2D904C909984B88DF8583F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7407e677-c493-41d8-372d-08dc16d8f68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 21:20:28.4433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDqE1wHTMlMHoP83+zg1p4LlJTytWIaKG9FfUq0+Z7jbJehcxg2Xv5tlxDZbz41I1CDhlAOI/E8CX2hZqjzVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

DQo+IEkgaGF2ZSBudW1iZXJzIGZvciB0aGUgbmFtZXNwYWNlIHNjYW4gdGltZSBpbXByb3ZlbWVu
dC7CoCBCZWxvdyBpcyB0aGUgDQo+IGFtb3VudCBvZiB0aW1lIGl0IHRvb2sgZm9yDQo+IGFsbCBv
ZiB0aGUgbmFtZXNwYWNlcyB0byBzaG93IHVwIHdoZW4gY29ubmVjdGluZyB0byBhIGNvbnRyb2xs
ZXIgd2l0aCANCj4gMTAwMiBuYW1lc3BhY2VzOg0KPg0KPiBuZXR3b3JrIGxhdGVuY3nCoMKgIHRp
bWUgd2l0aG91dCBwYXRjaMKgwqDCoCB0aW1lIHdpdGggcGF0Y2gNCj4gwqAgMMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNnPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAxcw0KPiDCoDUwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDIxMHPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTBzDQo+IDEwMMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0MTdzwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDE4cw0KPg0KPiBJJ2xsIHByZXBhcmUgYSB2MiwgcmVtb3Zpbmcg
dGhlIG1vZHVsZSBwYXJhbWV0ZXIgYW5kIGluY2x1ZGluZyB0aGlzIGRhdGEuDQo+DQoNCmludGVy
ZXN0aW5nISBwbGVhc2UgaW5jbHVkZSB0aGlzIGRhdGEgZWl0aGVyIGluIHRoZSBjb3Zlci1sZXR0
ZXIgb3IgaW4gdGhlDQpjb21taXQgbG9nIGZvciB2MiAuLg0KDQotY2sNCg0KDQo=

