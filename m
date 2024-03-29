Return-Path: <linux-kernel+bounces-125387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269489253D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FD0285A44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E213C3C2;
	Fri, 29 Mar 2024 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EmOUQJ2L"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574CB13B7B2;
	Fri, 29 Mar 2024 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743799; cv=fail; b=q3+k1foNrTTfkfQaLK2E+ow3mGJnnyebWtUHpnvHFuFvnFpQlh16eemz/molaRmB3QpUPbK8LBLlIKqIsv8jiXpu/Mk0wuwrbIoFVkx+IwuOAsz0R1y8SR/5FEluXJcfsOp4K85G4ExiFAVKiH7ZyJPmeymmQqMRu1ULgvhePeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743799; c=relaxed/simple;
	bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACE5xPzTJ/cJOgyyCMF8AjARNl03J8kPt2WIrCoNV/vTuWcWBAhgQCfdp/iZJ0BIRsa57dHJa5gaAO/xuyNUU7g3wX3HUDMBGoCaigBITE5JSg+AdiSC72sT+a1HFwiiDyvXSIsBxAOSSCO8ZISr4slle+jMhokfYXo/uZw4z7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EmOUQJ2L; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDisl1mKZ3Mu5gRqY+6UjTQOkgbP1LT5X9Wp9iaPFEYvuJAZGuLNoCvSDemaHUhaEK0x1Sm8Ww/QDg2eKsrEKg1F7Uq4waZ+IkThFKATlJ9qrn51OdmFH+/YUpBxQxFKQktiyL52NeYUuq6yhggagLMbPSuMnMUHr6+wQ4E/8eqzDgViytm7sYiecmNi6h6lTqx2RNZNJjKmpkuCho1yc7JDgqnw2r7Zcg60iSK6ET8WbfjyJFd113Bg5osLUHaayiFU/oiJj+FQA7MdrZpOMk6e0y9DDKSHEjx/Ma1WEUBd8J8+wYR2RP/8ldzoEx+QzsoAKiIR4oVjGRg2ymu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
 b=oPVMLrCvSUloN2V5IqwoTCHEFLYoEt9j+ZLlEobsRxxVSjgVVbcgysUeEWaWw1pumJNEKg6WkJ++KmWyaddzqMbhb7XEftKtlWwErsRaRW2MNJ7rtGRs9wspVNJWVFgUabNGOXIDDpCIW8b/3Fi+vPHb2mR15hhI8huD1rBRUepM+cxiyTsyBLmBdYdSt6OGsCslny05UPDjMhhdOvQwLoutGiSMwWkwR72GcrRST4Jcr5mPyDGw3m6iCd6f85R+ZZDkLceitgzs8gnjoly/2IailEyb76Vgv01f6SjeiQJ9t49SjajPE/yHOb1V61btyeC3XbTKfxwOFxB8fg2rNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ1sQiUme+Q3Cz7+Rqll4KOhJx3agthzwxEEFJ/fcrw=;
 b=EmOUQJ2LSvE9cyht6q2leDYgv+rBvND7LfYCCjSKEGrWE16uyMMToC1rJLucEHy3nvB7FP532P/WYudETqOdgJaomCuDuEUUZRIskykan935Mnu/fu2nQ3da9DBgI04q+3Z82SRjfFlmmDc2Ksj4MgcaRULNGRoabQm9/6D+sak=
Received: from CY5PR21MB3759.namprd21.prod.outlook.com (2603:10b6:930:c::10)
 by DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.17; Fri, 29 Mar
 2024 20:23:15 +0000
Received: from CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135]) by CY5PR21MB3759.namprd21.prod.outlook.com
 ([fe80::1c76:5d37:cef1:f135%5]) with mapi id 15.20.7452.001; Fri, 29 Mar 2024
 20:23:15 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "zhangpeng362@huawei.com"
	<zhangpeng362@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Topic: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
Thread-Index: AQHaghHPup60+Vul2EyICRlEmMkd0LFPJ6Jg
Date: Fri, 29 Mar 2024 20:23:15 +0000
Message-ID:
 <CY5PR21MB3759BEE344CCD8F20FBB4E4CBF3A2@CY5PR21MB3759.namprd21.prod.outlook.com>
References: <20240329192809.17318-1-decui@microsoft.com>
 <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
In-Reply-To: <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f62ef308-7ef8-4c3c-bba0-bb7106167ec4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-29T20:15:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3759:EE_|DM6PR21MB1514:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 czTUrw8iTH9j7FN+BqI/hqTuIkeoAkCRZxpC21oNetgeSwVvlS/lnf8LOmda1fUowBylxSObXoyVT9qAdnSdQnU963RGMclyYaTb2UnvvLUFvneriPXCwQJHUZ1Y+x0RKFBcL5wDryviBEVIUZNyDBzwbROlnrjKANVKUFbOetCNzIYso0V344zex6LsvujpYunxNK6W2od59ELvYi7LesVbm+Q1l4SMsdP2L+cib6chyTBXkQblyPBQ/VZ3zKPckyFYTsGv+H0TjYaEp7aZa8gaopi8lf0KYTzUBIrbPd89SN5NxAB6PVlcqIhzzWzOelYX9+XLviu2NLtRoulf9TcZl3oolhYJ3isYhAzmF2trwWAEHe+tNaot/e5k3wN5YpzcuYbPq8Ijs+bKbdLSYCLdjqA48y3/5GiAfI4oibQqrtjWqGN2fIE3m3fS9sOcIbvTgQMLQj+Jvurj9d+j0cUCgDkEXlrQ2r33S1r6Jvu2GvZpPl04CniCNsSNhL0Si5vAk+fy84PtYJQB0VgZ5Bk5KKtP5AO0U/s2lShowsmXQLf5diYbpio7EIJHyFBucvbJk0N+qYbZb4Rgz/XFQTfwhxz0QZ7mie8ffCQkmQGTFKHZB8pQIny0PiRgWGSIw/cUvmkdJ60alT2HyVlpqLZEOKd3yYbhLRWmILaEONE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3759.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU9abGF5bnYrVkNUWHNpdDVNOXNEWE8veDZjUHFmWHRsRzQyeHI3QUoxcDlP?=
 =?utf-8?B?bkgvWTNIUmNsMWlNd0V2dWhMUExiT1RRSzNmMHRpaURyNzBNZWZZdmV0UDV3?=
 =?utf-8?B?aFNWbzhucEJ5bnYwMWYwWXVwNXpNc25jOUtyRmN2cnIxWGJzZm9Qd3dHMDlG?=
 =?utf-8?B?UFRnczc2TnVCRUk0ckU0dmdNcWh4REdiREVscEV0NVN4ZjRDMEE0Vkhjcldj?=
 =?utf-8?B?NU1zS1UwNllHTWZFNFRHRUJYTmlSWlc0SFd2UjR5R3FCUHdlRHhnbUZsdHhV?=
 =?utf-8?B?RTNRYzlzTElOV1RBQUwwaWRxdTRWdmxLbzBJSGtNZUxaMVUreVFKYkl1RUhn?=
 =?utf-8?B?MUxkSHVwY1JhRkFPci9KOUZLSFlSTDF5Y042ZGwzSzNXYUxsbXJlMWZBY3Fo?=
 =?utf-8?B?ZUF0TXo5ZVVTaXV4aGV6ZFdtYmZwOW1ONGg4dmYzM3JKQVNjN0ptdmxvSDhI?=
 =?utf-8?B?b2ZuemhRZkhhUGxteHpRcnVUbFhaMWhTdlBIdkZsei91eHl5NXBvN1lkR0xr?=
 =?utf-8?B?TnJVcnVndWJ4QU5mWVRTSW9GV05wbXNYaXlpNjdxQnZ3NWtobENMdElrZFpU?=
 =?utf-8?B?akZhVnlyME1mQjF2bk9EbU5xYTc3SFFqM3FHOEdremxrS1Bvam13VkNnbVoy?=
 =?utf-8?B?TEVGcFdmZXhteGxwcnd5OEZwMkxUN3VleUNWUE5uN2loZ1dpYVJ6ZXRXbmlj?=
 =?utf-8?B?NDdLNHVBTi9leWxWVjRhYmZ2YjhsK0tXb1hETVNzaXJ5WlRSclpIVzRSdjNV?=
 =?utf-8?B?Mk40c1hZRXBkK1NiUUVLaTZsU1o1Y1ZlZU5wZndva1djK3VpdzdLTTVFQUVL?=
 =?utf-8?B?azU1WURYbWdBd3lOYTE5a2dIQWMyeVB5TG9ibFl4N1hNaGRRVlo2UWNOYTJF?=
 =?utf-8?B?bGdTaUE4TTdETlQ1M2M1WHBHTGlCQklqMk4rcm9oZnJnT2pVNmdGOEpPdWxw?=
 =?utf-8?B?NVh0RUJ2UHdhZFpTdVJEa3pUUjdrZkJ3eDdvdjhmUlJMT3UwSXBZU1FacFFC?=
 =?utf-8?B?TU4zVm1ZVHdiTDJuTHZHUWpsOWdxLzNKTVhpeE1kRDBvd003U0ROZTFoN2lT?=
 =?utf-8?B?eEk2bktxc2RHL3Y4OG1WTFV5VEdwOVdjZDNwQXhFVEZMNHFXOGhwUnJDVlgz?=
 =?utf-8?B?UVBQT081Q1FiUEJNL29CUTNvR1JOMFdDSEVMUVB0cEZNQ1d2OGdUUUxncEhy?=
 =?utf-8?B?eGEvQ1dTdUVPN093ZFYvbm9QVGJ3b3YwOVc1Vi9wOUNyNTJuM1Q0QmtVUTg1?=
 =?utf-8?B?ZC9JWkhjb1RVSU1jd2IxV0t3WVVZRDA4YnJXbytaZ0RDYmowMzk5c1IvVThv?=
 =?utf-8?B?RnZURHpNZmxpQUZJRHdDUWhOd01nUUxDTU5aeXN6b01CMXR1SmQwcW53dDk3?=
 =?utf-8?B?TWxoRnIweTdZWlIyczFNVW1pNnFjYzczVGZuSmEyWkdweFpLQnFWVW41eTRP?=
 =?utf-8?B?VWNxOS92enpsMEcxRm1LYktsa2lQUEx3Znhjd0Ric3JVSnNpSCtGSDYyMjdZ?=
 =?utf-8?B?OGl5eFFOcGFPMFdLMTFzSy9hQTRud3JISWsyYUhSZiswamFMdWxPOWxrZjJY?=
 =?utf-8?B?NlpjWG9lenVsMmJNZkRLRkY0V2hSck4zVndha2ZuVld3RDd5M1QwemxjSVNj?=
 =?utf-8?B?MlVKRXlJV09rMXZSMVMrVThKRm5weTRuY0o5ZHdQWGV3ZEVIQk9kNnFIbHNW?=
 =?utf-8?B?NmN6ZVM0U0tFM1lkM3ZCY0xXU3VUV2VJdXhvdGFMYmpzSkpyNkZWb3pVQlFP?=
 =?utf-8?B?WjZJTTBKQ0JUV2lSMzNjYXpFVzN6Uk5Db21wQmY2amJvSUdPUFRKTHVLUDBP?=
 =?utf-8?B?WEczdjZiWkFncFM2QVBGNmFTSXE2b3MwYXByYTUvS0prb040NVBFeDJuNTl3?=
 =?utf-8?B?YXVWOW5qdy9IMUtvRURyWVFqOXpndmxVb2lNeWJ2Tmx2emZzUFlpbStobEhs?=
 =?utf-8?B?TXNucjgzVHFtSjdVZnZ2SzdrUVZlMURlb0U3V3RwV3FTOWV2REZ0ajQ1RXdW?=
 =?utf-8?B?Z0VCWHNiblkwdXZzczdPWlNEM29nTEFoNGRoUWYzb2ZJc0dDZWlGS1lqaHJH?=
 =?utf-8?B?U1FRc2x6b1JUdnM3RTJqY3FvTnZreG51TFBQN3FTZXRObEhucFRMVEJGb2FV?=
 =?utf-8?B?cU8xeEM2K2tLdXo2TXdFazg0VURwcDZNV0tyZS81ZHJqYlhmZlNRb1R2TFFk?=
 =?utf-8?Q?XSELpFaHrPcrzqDWI4NWb+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3759.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972c378e-daae-4e52-85cd-08dc502e106b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 20:23:15.3950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: be4q1gsVtgAQPBkLEO0LGfx97QKMgPwPDqCRJ69251AOWQffj9YAQG+zfB3NBsCZ1z/JVn1Rwdun2TYMdP1tEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1514

PiBGcm9tOiBFYXN3YXIgSGFyaWhhcmFuIDxlYWhhcmloYUBsaW51eC5taWNyb3NvZnQuY29tPg0K
PiBTZW50OiBGcmlkYXksIE1hcmNoIDI5LCAyMDI0IDEyOjQ3IFBNDQo+IFsuLi5dDQo+IFNvcnJ5
LCBJJ20gbWlzc2luZyBhIHdoeSBpbiB0aGlzIGNvbW1pdCBtZXNzYWdlLiBDYW4geW91IHNheSB3
aGF0IGhhcHBlbnMNCj4gaWYgdGhlIHRvdGFsX3VzZWQgYW5kIHVzZWRfaGl3YXRlciBJUyBibGlu
ZGx5IHNldCB0byAwPyBJcyB0aGUgb25seSBlZmZlY3QNCj4gdGhlIGNoYW5nZSAgaW4gdGhlIHJl
YWRvdXQgb2YgdGhlIHN3aW90bGIgZGVidWdmcyBmaWxlcz8NCj4gDQo+IFRoYW5rcywNCj4gRWFz
d2FyDQoNClJpZ2h0LCB3aGVuIHRoZSBzeXN0ZW0gaXMgbm90IGRvaW5nIGFueSBJL08sIHRoZSBy
ZWFkb3V0IG1heSANCnJldHVybiBhIGh1Z2UgbnVtYmVyIHdoaWxlIGl0IHNob3VsZCByZXR1cm4g
MC4gVGhpcyBpcyB0aGUgb25seSBlZmZlY3QuDQoNClRoYW5rcywNCkRleHVhbg0K

