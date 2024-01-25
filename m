Return-Path: <linux-kernel+bounces-39312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD083CE9E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A4AB22C27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E313A26D;
	Thu, 25 Jan 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CgHX+kYN"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2085.outbound.protection.outlook.com [40.107.9.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FF5B1E8;
	Thu, 25 Jan 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218173; cv=fail; b=RXK5eIvDc4jsNwxg1aXnHe+ms81TLtGFgIhUrIRVhTgbs7OdQavxtG0O36D8sEiLOvWNCJr44UMSl0sJ3VF4Zyf6gjsHkHxU7Zyal1a+QI0ave772GFGAgKIZqnLNGSdfS5UFnaR4bgSnOKgpIUTlKsHhD9wvBFD6R7/0uYbqns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218173; c=relaxed/simple;
	bh=XXPk8IhJcL70qrnUX3KfO+K3yxqsxYa8OKHoknbxraE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E93Nibj11QWR9XTgg4ZClaoyGd4Iz01pRaZ6/Tls3beGH1yOeT1HlfFaqrgYeLyh5YnsrBc4gJX9ntykv3PrZx6OSpteQufiOXDF5Gq1eHs3Q8MV8nQyDSge6tNpZ4gPmtml2+B244UbaAZT5CETTZl03ya964trzWGhPONj8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CgHX+kYN; arc=fail smtp.client-ip=40.107.9.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTmdPBLyzVfsLJkUeQVwEaIPcVBNQNAYYZePX1flMY08OAmTW8sUEge/H+OUyV+5Z9j2w6xoy4AssyF7G7c4+JW93OQTjpZaELgfjCqy/oJZ6sVcYaDhfjuJLoXnU7add6lZn6EuOi1fZdL6XaDfe8pZ5KWFyeZMDtDFsKzgcOAkKvVWbUa8DnXYmmYfa5DCjMSK6UXHlPgsjPyVO8Eotml/pURSUllh7d92OGGytbflDBTJb6fR1uIMi643ZE2hlG00L2ba6Jt8tTrqVQZ5FxhtH/jzQAP4Ptntp5zTetYLns8epQ0vQo44qRityE41HySYsv5a90PfqpYUGd48yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXPk8IhJcL70qrnUX3KfO+K3yxqsxYa8OKHoknbxraE=;
 b=AYh+IvJmSGvYmeioKdt1c9t+7Qcuo+Pwi1GeNtIA2KRlJaAIlYeL0I6YyyhKT9Shr5iHhJtPlZrraBBIcsDsGggnQhSoFv5IXbfzd14lAlMVQ739e2lk+fgzXTDcC8ZVV1PKw7ElvT44uKogGVIk8xLp4O//2iXZz/SbJzjmZ8zoN5lEomDw01aOD+8aNILfo76XKy5+3nB5Bam5yqNbHp+Vv2Y2+53tNPh3Bcc2TT2mHPprNySnPxCMd6mGMmijger3I/qxPsOIacYdupCsUfuUeiGk/pILMhLuIioe/WQvzleiJjfeAMXF/n33ciEIfbUB5OIIDJmRqNVGFvypnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXPk8IhJcL70qrnUX3KfO+K3yxqsxYa8OKHoknbxraE=;
 b=CgHX+kYN3HzQpBGSPHA4yeMxLViYonU8b6ff/asoCUOzbrbsZsRKNTipKfbT/WhzkGgpiFk/JWIRsRR0Q5vYllVM8f2yFIk/vzHoan8trBIQCbT1BFLB7KPCftDqW3lXKwsUG1tgdUUs0m6pe312/dPFNBDS9dVrq4yABX9t22iZQeioBYXpt0y1dNK4OWHazx2655ydiJ8nA+uttnnXonnOOVqjXfcbbqlO3EQBPDLRfVdxx4/nRgBI87lZTukxi9F5Tzk1Jfbm/mQMJCBA2DNWQIEgwFXkhY/nunlGwjbk4xvQNKgCsraSvsd+gl4QR0enebsDdaI1+g+0fjFPiA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2308.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 21:29:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 21:29:28 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: David Hildenbrand <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Ryan
 Roberts <ryan.roberts@arm.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dinh Nguyen
	<dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N.
 Rao" <naveen.n.rao@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 08/15] mm/pgtable: make pte_next_pfn() independent of
 set_ptes()
Thread-Topic: [PATCH v2 08/15] mm/pgtable: make pte_next_pfn() independent of
 set_ptes()
Thread-Index: AQHaT8VgySxvUt6KCEiNhWlHBfX7NrDrC5kA
Date: Thu, 25 Jan 2024 21:29:27 +0000
Message-ID: <661876d8-cbf2-4540-96d5-c522b285a2a0@csgroup.eu>
References: <20240125193227.444072-1-david@redhat.com>
 <20240125193227.444072-9-david@redhat.com>
In-Reply-To: <20240125193227.444072-9-david@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2308:EE_
x-ms-office365-filtering-correlation-id: 733121eb-a69a-4660-6588-08dc1decb5d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A+3adguQEOtrU+DvkMHBTugNMn/kQ4ix0i3Xuec5HOvPGEvNRw6zE1iQ6ebbLuVElqSUbAEcIqKdcjaPCeg9RWmcfaq5edCImxokZbmETUR2FtbvaoGLUgmbgHwewjg0EfSnXpLyhEBJDJ6+hv9Eq5CL/9HoTMUjcXVKEtS6nUQSMX1jR3lUwhdmtGNLqUMAu0tOHaIdGs3VHFQ2+m32T1wdahe/5Ej/JRNvFIaUk0/VeZS8V0w+nEW4nn4DlmJTp9J6AXggSJkiPxU6+gDOaU8kaGnhNYCTTYu8U/D7k4z06F207O+SAhQhKFZDIE8ZkWe+zFTrZ19rrAutSref15/eq9kj2ACwZ2olV2oHQicerL9c0rteDaxW94Hh8gY7RqrVIwEqgGxFRELk0vn3Gf262SNXA+COM2Ep9JCkBSr8TEJqIVf8+TQei5T9Jk+tc1hKqzMLk+dVVtOMdTa75i4Fbupx+ahTMXCZi7JkJyYmeQEifzIjB8Td+oiYeKxTqRLujmEpoe7FqTvZ7HxeChKD9Mf+8JxG/OaHLZSJ4/SuEnMB9PMpy2Qhr7Ftqhlbn/GN/OYYsAlolVKutTjfi8ipcLjfjpSeIRvP8f246b/+xPtrmfA2DlCNKUy29FI7rVkX1k2vhEHvljAHJkUXusjOlf9rgiB/FT7E4Hi6g0/EerGY/jBBWNsQuhQ147fu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(91956017)(31696002)(64756008)(86362001)(122000001)(6486002)(66946007)(478600001)(66446008)(71200400001)(76116006)(54906003)(66476007)(66556008)(316002)(110136005)(38100700002)(2616005)(6512007)(6506007)(26005)(8936002)(8676002)(4326008)(44832011)(83380400001)(66574015)(7416002)(41300700001)(2906002)(36756003)(31686004)(38070700009)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tm45bEJpQUdyYmZ2bjU1bFlBVmpIZ2R5VEdDV0ZGT2NWTS9ZdjRWdXZXQ0hu?=
 =?utf-8?B?TEN2U1RtK3N5Ynk2cW9TdzFrclgvQ0lkWUhRaHNpUUlkdGltdnA1WDJCM3R1?=
 =?utf-8?B?NGtKUzR0clFEVzlUOVVqUURaeFczN0VvWWNTT09Md0NRRnZpUzNCdittMTlU?=
 =?utf-8?B?T2gwRHhUSFR0Q2Fpc0sxMng3QnFBVllSQlAvWmhRdVd1VlFkVUtZZ0JKYmU1?=
 =?utf-8?B?Uk9mWXBvNXh3WkNOWHg5UWVoREY2WkpEaFJEMEM1dzNWdkJ2VjB4YzdWb0dG?=
 =?utf-8?B?d0FGeVI2Wm9vSEVwQytGdjZvNmFHTWJkNG0wMUpLck8za1pNWjFvWk5NcGYr?=
 =?utf-8?B?OVZ2cE9nZmd2aExBVFVBSjVQbVhoUG1nWTRpMURoV1k4dloyV3krYlUvd0c5?=
 =?utf-8?B?N05jMDFvbGZrT0RUdUNUcHlMc1doWVh6ZmRwblVqcnBNNmJjczA4a2xlOEN3?=
 =?utf-8?B?ZDhHV3QvSjdtRkkwYXdZQ1E2NmFRcTBRRnYxQU9OOE5Udkwyc2tFLzR4aXlo?=
 =?utf-8?B?L1JFT0NnOGNucjhYN2grVVFIa3NHSzFpMEJ2Sk9neHpuUUlDTGpLMUlqTjRz?=
 =?utf-8?B?RHVEMlVLb0wxVWRzWnZHOWlxOGJZenF1RjFiTUdLaDQ1d0F3THE5OXgwMjF4?=
 =?utf-8?B?RDUwSkVnNXR0Z0J6K1EyN0VhRi9Wd25oUjFZaEVHQURsNmxKM1dkTmEyeG4y?=
 =?utf-8?B?TDhuUC95dWxUM2FrdFl5V3ViY2RuWkxzK0VQUE4wWmZTazc0QzR0RUJqd01N?=
 =?utf-8?B?QXhaTHdBUGpjc2YvNzhORjZxeXp4enpzb3pMVjBLbUhIc0tqTlE2SW9LaXF1?=
 =?utf-8?B?THRzV3NVclUxajBNa0J2V3lzcUJMeWRwemNvNWZiRGk2MXdKVUltVVdVTmk3?=
 =?utf-8?B?SHUxYmU5QWhzNW9PQkdGUUZNbmFpZSs1L2NURHl1S1ZML0R6YjBwd3BhVzM5?=
 =?utf-8?B?cUZCaGwzRGtsdDF1QXlzajdSa05jelAvaEdiZWNldWxWWkxROWhNSWl0Kzcv?=
 =?utf-8?B?Mm90cndPbWpPeDBuNGZZVGlNV01Ldy9TUC85cmVFaC9tbzBVdkZQcEgrOWIv?=
 =?utf-8?B?TWQ3blllMzB5eGJmVG1vYko1dnJ2QjYreGM4aUdzWlNGV3pHN1RONG1RNElG?=
 =?utf-8?B?ZGdHakpvODkyajVUUGxZSUVGNGM4S1pGL0grYmRpY2tHZXp6RGJPYk1uV0J5?=
 =?utf-8?B?T3p5UjNWbHRLbFpKVmduVjhIWGVYNEZINVhDOFBWdEtMYUxiclBoTXJrRkpt?=
 =?utf-8?B?NHkvRVFjUmIzWUgyZEZMNnREMFk5SlYyb0p1QXFCajBXYjFVODV6KzlIRXVF?=
 =?utf-8?B?dFNvQm92TlpsdTJVSGV3NkRodEExdTBPQ0g5bVNvbzMyM2c4UnBuR2d4Qkxt?=
 =?utf-8?B?Q0hjQXUxSWVDdUlHN1pDd0lCejNob21ZL1VxRmQzT2F6YWNkUGVNQ2NNcHBX?=
 =?utf-8?B?NWgrRzFoMVlEcG13TU9nbzhDVDRBWjZzL3BVOUJlTWJWdS82UmlSWXk0VzJn?=
 =?utf-8?B?WDVNTlRLd3orM20rWDlqTGIrc3BxUnQwNVNPazRQTk5LWkxGNlZLb2xEOE5N?=
 =?utf-8?B?UHRhb2ZFTEN6VDRTcVpxRk1XdWdNNWsyRjdnSFJHUlpaeG1ZMlJkM21IQXhy?=
 =?utf-8?B?RE8yQ01mMnMxM0ovd0ZpZVVSOFlIb2RwTGcvQ0NWeWp0K3dFOUZPQ3dJcDJl?=
 =?utf-8?B?MTlHVHh3d1FvUCt1UndUU0J5OERKSHBxVmZpTGpxakR0T3dGWk1uNmpqVURy?=
 =?utf-8?B?QXRydkhzeGV3SWI5YU9GRTRQL2o1YzNkRnFlMng4YjhCK2pqc0FTK0crdGRJ?=
 =?utf-8?B?WEhRWGc4elZpV1k5cVJmNlJIY1hBYjJXaVB1Yld0ZkdrMmhpdmVVbW9sMUY2?=
 =?utf-8?B?UXNvbWljcDBwUTN1bmRTb2o1Zm85cFR2OEtTbHFBQ09kZHZxVW40ZDcwY1Av?=
 =?utf-8?B?bGNqVmhnUDJEREFQN0lUTlFTbTVrUkhTdUVreG1ISXRGN3VpcittVDJNb3dP?=
 =?utf-8?B?b0JYUm0wQzhWZjlPZTdldC9IemRSSmtUeWc0YVAxckwvV3Y4U2tHcVo4WkNT?=
 =?utf-8?B?NFJ0Z3I3eTFUQTZMejVVclFoK0VmZ3dFWUVHWFM4Y29VWEJOWHp5L0gyL3Za?=
 =?utf-8?B?QlhCMzAyNk5GclFlWkRzZ3dvNjBHOHk1bkZxZVB3bkFBWGV5Y1UxYmJwNURp?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <629A15BC207A0446B8FEDCDF0DF82E3F@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 733121eb-a69a-4660-6588-08dc1decb5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 21:29:27.9363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF09p8j+ws1ZJXz7vE6EjQf7u6aYp9b2r1ZKutdSH7k9HxgIZQl9Zm2h6X+jfAjF9V5aQY/iqGqoEfyygCwULG+tkuiBvQV5CO6b5wtGTk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2308

DQoNCkxlIDI1LzAxLzIwMjQgw6AgMjA6MzIsIERhdmlkIEhpbGRlbmJyYW5kIGEgw6ljcml0wqA6
DQo+IExldCdzIHByb3ZpZGUgcHRlX25leHRfcGZuKCksIGluZGVwZW5kZW50bHkgb2Ygc2V0X3B0
ZXMoKS4gVGhpcyBhbGxvd3MgZm9yDQo+IHVzaW5nIHRoZSBnZW5lcmljIHB0ZV9uZXh0X3Bmbigp
IHZlcnNpb24gaW4gc29tZSBhcmNoLXNwZWNpZmljIHNldF9wdGVzKCkNCj4gaW1wbGVtZW50YXRp
b25zLCBhbmQgcHJlcGFyZXMgZm9yIHJldXNpbmcgcHRlX25leHRfcGZuKCkgaW4gb3RoZXIgY29u
dGV4dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRo
YXQuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJv
eUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvcGd0YWJsZS5oIHwgMiAr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9w
Z3RhYmxlLmgNCj4gaW5kZXggZjZkMGUzNTEzOTQ4YS4uMzUxY2Q5ZGM3MTk0ZiAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9wZ3RhYmxlLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9wZ3Rh
YmxlLmgNCj4gQEAgLTIxMiw3ICsyMTIsNiBAQCBzdGF0aWMgaW5saW5lIGludCBwbWRfZGlydHko
cG1kX3QgcG1kKQ0KPiAgICNkZWZpbmUgYXJjaF9mbHVzaF9sYXp5X21tdV9tb2RlKCkJZG8ge30g
d2hpbGUgKDApDQo+ICAgI2VuZGlmDQo+ICAgDQo+IC0jaWZuZGVmIHNldF9wdGVzDQo+ICAgDQo+
ICAgI2lmbmRlZiBwdGVfbmV4dF9wZm4NCj4gICBzdGF0aWMgaW5saW5lIHB0ZV90IHB0ZV9uZXh0
X3BmbihwdGVfdCBwdGUpDQo+IEBAIC0yMjEsNiArMjIwLDcgQEAgc3RhdGljIGlubGluZSBwdGVf
dCBwdGVfbmV4dF9wZm4ocHRlX3QgcHRlKQ0KPiAgIH0NCj4gICAjZW5kaWYNCj4gICANCj4gKyNp
Zm5kZWYgc2V0X3B0ZXMNCj4gICAvKioNCj4gICAgKiBzZXRfcHRlcyAtIE1hcCBjb25zZWN1dGl2
ZSBwYWdlcyB0byBhIGNvbnRpZ3VvdXMgcmFuZ2Ugb2YgYWRkcmVzc2VzLg0KPiAgICAqIEBtbTog
QWRkcmVzcyBzcGFjZSB0byBtYXAgdGhlIHBhZ2VzIGludG8uDQo=

