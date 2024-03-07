Return-Path: <linux-kernel+bounces-94893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BDC874669
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB728487A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34733D2FE;
	Thu,  7 Mar 2024 02:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUFe/ozR"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6491C3D71;
	Thu,  7 Mar 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780147; cv=fail; b=kpQoSv5me2pY9tm5qx5hrJ12PoVVuFW3bVxYMc3HS25xdIIzPevOkanVsYuW38kDvu58MCa/XvK79Aow5+HgYqLJiOzN6nzJmyPEfUjmC4e39Pln8klC1G4NFEFJzNrAIZq2YVsIrg/Qu7UK3g4SIQB6sCp8i/7HyJtxT3Chsgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780147; c=relaxed/simple;
	bh=Avw8MdXty/4Tzv38w/6wIBix6Y1Rqg9ln2iUn2LpapM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ieYptWRwe0n388hukFvPYZVF7S6bDw5fvyFn486nwSb0NHrZu0l8gKk7gcdV35rI+/9HYFDjilh67RFIYCpSRUwApJZP3elNdMwxAqOks3wwMcjOymLx8XLaGacQAJ8Jt3Q8XFBSGyQTEyRR/yFMlIJyuiAn8jjdw+SyC+AZSvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUFe/ozR; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM7o0EmS1sGKO714LJPTmsiyLz1byNe69nvCZKFyye/IzYZsMu3v1y0+kZNNiASu2D28F+LRjx5Mbi/WUH+2lQMtJWTx4E7xoLUe6WY3crs2RBRAPuHhRactPYB4VdWyroSo5WRi0d+YVDiBS+WZTrCbrSx+LCAsNr4t5hLaIBmx7XzfxzSu7KtKe9D8q54oYlhyMWLnZK8BPhmG1JLHbJCeaiq8jQO4dve3r2JP5v3W/F0EEWvdiT1+7Jw962hsI9SHqlLKKn6DCxOmqEQsVtX0F4eJW4gsn7aR3q9uQqUJJ5HI/hF8g8C8JMYaAjZwyYN1D2kfnMl4KuyoP4oK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avw8MdXty/4Tzv38w/6wIBix6Y1Rqg9ln2iUn2LpapM=;
 b=i5bBJLcmoVS3nD8mUQLf+5D11Ahl1Scp4+1kidMimp+8qW1IkkP7GrsokToa6vla7qu+2Sc3GofEuSgXVm5Q1aYg0/ScjK2LqwBXOQmO+YKz607AQ8Ok3yVu/Sm4EnmaRRC37Afp9f2X016b/YEJIepy7DS+CDoJFAqjXh+S4LgoPQb5EIEhs/OdsnRNKl9uJdM3oAqP5cOupnYsgMweFIcxeMui3VSyKr5S4pc8O3t0oZbkJs4eplAaGNVuODoLeIVzEedd9+EVw0W49+0Gnm1beyWEobsEiRJB7lmmBCX0vVCgPEfuMfP1nU/DcJ6KqGR9xiKC48cltNhKvEsvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avw8MdXty/4Tzv38w/6wIBix6Y1Rqg9ln2iUn2LpapM=;
 b=jUFe/ozRuRMbbXkBoVILOdnuEHtXnOlpPqEMCyPeCjX2XJFomB+QNWQZ4VIJlaiaAvTdP9bHaeZ6CkpudEBKqczC7TNtfNBYqcNzn/NzYAAHRtDy/I6L/Zs7tpXQg3bezvuXuTVQoCJokMO6V2dQdG+5nkV0vbHKRRPgOazabbYNZUFN/45GbZwJjBUc0BJHyWjtiwslw9J7TdQ3kA61MeBTSz38vKLNX+uDauHGICd8d67kWJBnrX8pczQ8Yv/93qGZmAsqWgvLEWPAS5Fn3ai8EJT9SnjoPmkKsyIZbbTH9VW1L6vwvQF695YkRf3liiHXIck1ilvGv8VjYKJsPw==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 02:55:42 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::fdc1:2c53:9144:4c8a]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::fdc1:2c53:9144:4c8a%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 02:55:42 +0000
From: Wayne Chang <waynec@nvidia.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jon Hunter <jonathanh@nvidia.com>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, JC Kuo <jckuo@nvidia.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic
Thread-Topic: [PATCH 2/2] usb: gadget: tegra-xudc: Fix USB3 PHY retrieval
 logic
Thread-Index: AQHabxfVBwisghs8b0C9MpnByO5bbLEptY0AgAHiJIA=
Date: Thu, 7 Mar 2024 02:55:42 +0000
Message-ID: <cc0eef54-28a4-41a8-9768-70c89c1601a9@nvidia.com>
References: <20240305161122.1254099-1-waynec@nvidia.com>
 <20240305161122.1254099-3-waynec@nvidia.com>
 <2024030542-broker-promptly-de99@gregkh>
In-Reply-To: <2024030542-broker-promptly-de99@gregkh>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_|LV2PR12MB5799:EE_
x-ms-office365-filtering-correlation-id: 4a5a5ff9-0254-424f-3026-08dc3e521418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IFvG2xf6wUbTG5FksOPitwnYPVRr6ohiKsiJOVb79mai3nR5lqoeUzgGsZKxyGtaSkLjpB2j1uPpy176UhSdW3PR10Hr6wjpQQyLFOHuneMUjGyAcPZgS/t90ljOmQlz9dlTOKlwAbEfQBTVUEHVDe4n7l1PXcra/QQQuX1G7pIFbJRJCjEFE3NS+SwE5Cswalwk2UmArWRJkvA9yy7FSmgMavMu3So9BOsMr+q41UiPLvWeJ6SSLuF4oXnfgZcmlkDCl7b4pt2Jgvmexa2cJyQ/5EQnqYQevI612QG6dwhqK8lMlgw71CwdjIA8xxOend4AX/PQwSysmo+xMd45hcRIXEOMHSvRGefbw38LoSCW6g0+9YDq5IST1ssWbLRcNprfxk5cvyx+6mv+TReRdIfNo6IDgOjfu2cMWiZYcK+UrIdjadUS/yRxqv2kR4Ij7nAx8FEYkc7i8FDZ80awscwIB9F01nSSGWe2hI6vNJdRfhh9HtEWiN6TwIoTu8RCSFiq5lmxAb6S0ut+tBlq4RJX67VhSssBHdIHsI+ZQr9H9jBEBbFyk6sUiji5syvs8iMAr6FJaCfRQfkhVd7wDs4dhU5TiRjUtyrmld+p92uA6pbyvrFH3xDWp85Q2E2/n3gWxUWDHxdafnGqjgvKk+xNbnE13KKr5e4chc35VN3c1XRlbZa3RInwxpVu8YUTnkTm//6qZzb7uNSe55CtGA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnF0dUdKRVc2ZXRNdmwyM3pTZ2ppUDJrUWpmb2FKSThsUG0vbHIzdE9pSG11?=
 =?utf-8?B?V2YxVFdobjBUVUt2amNQTGluck9vbmlzTU51b0VQZEQxZVZhRWtwMDhTRHNu?=
 =?utf-8?B?ckFra081VDJEWWU2R1F0Z1Q1cmo2MEFoczJUZElMbk1IMDNtNUtReXBuV1JD?=
 =?utf-8?B?a3BkSGFwNkZwakhtZlZsb3IvRzFKN3B2MVYvR3NUaWp5dFNkOVltVlgyVG1M?=
 =?utf-8?B?dS85bTNsYjRDK2Z3ZUlYWnRmaEV6Q1I1VkNOTHNqLzl1MTRpK01lMXJKMnps?=
 =?utf-8?B?cGs5eXBFMzY3dUpvRnJ6cWQzZHFlN01rdnFUdlBZTDdxdEFJb3Boa2gwZ2Jq?=
 =?utf-8?B?d1BEWThnY25XUWtlSCtkYW1JeDZuaDJGVy8va1ZxMndLV0VaVVVLZWowUGY5?=
 =?utf-8?B?N1VnR0NpcHJzRElaU2g4WnAvRlphVERwQlhDL2tqNVJQQ1Fqa2FjaUQvcHc1?=
 =?utf-8?B?cFZtU0o2cXNmbitiQU9oWDlpQ0h5My9rdll3QkVEZTBGMVlYOUZ6T01jeHhs?=
 =?utf-8?B?d2tiaVlWK2FhbmJXdmlQT2xnRkNGcmZoNzZ0YlE4V0hpVW5YNTJpUEFzdTJK?=
 =?utf-8?B?RzZ3bEZpa1JCQ296Y2JjaTZjVHdpUmpTMy9NR3BnQU5vQnlnbW1zQ1gyOEF2?=
 =?utf-8?B?KzNKMXQ2Q3Eyamxnc3A5aUpsM3BFczNldjRuRjhQSkNtdVpsOUJtY2lBYXgv?=
 =?utf-8?B?YWVtd3BBYTlBS3hZZjB3bVZGMzZOYlQ0QnhsbUJWZ0lWM3pWLzNKeXJJRnF2?=
 =?utf-8?B?T0VKQkJvWUJodkpLM0FNblZ2Z0V6UEhVY0R0R24wRWJHSXpveVBwcFE5Q05o?=
 =?utf-8?B?U29BMjhneWV2dU9VcWYrb3NtcDYxN2tacmRERmE0QlRoTGhwZ2FFam1TenVp?=
 =?utf-8?B?MHZ1cVhDQWlXVys1TVhxaG5sYUI1Ry9yUXB2ZzQ1b3Q0cmNIL2FsUVdtL3Q1?=
 =?utf-8?B?N09ocks2VkdNdGdSTkZOT2NSTS8yUFJwN2d3aVRXa2VsZjNxdWQ0QmZDek5j?=
 =?utf-8?B?MFlTRU00RGxYSFk0K0w4RzVFQnJ3T0V5cUJxWW1XSnh2eXJOTHo2MzRsYUhM?=
 =?utf-8?B?ZWRiZ3AwY2JuYkJqcEQ2T1FXdUg2ZFBGRnYyQkpNczVhQUEyQXBtakVsTkhy?=
 =?utf-8?B?RXFxRzhQRFZIVWI4M1gwSWZETFhhNStHMzUrMVlFSFQ2eWFPWWRhMi85dDZU?=
 =?utf-8?B?ZHF6MVZ4dDBoblV5Z1hrNER3N1V4dTFVLzFsYjBCbVozWnovekZSeTBXbzhT?=
 =?utf-8?B?STJzODllQnpCSWJ3ei9VdHlyK0NncUtTWXNzUlUrZ2QvMnp1SnlGb3lmbXQ0?=
 =?utf-8?B?alBVZENEN09VdkQ3RnZLU1R2engvWG41MDBEc0pUV2JxcDI0Tzk1bllxd0xx?=
 =?utf-8?B?d3VRTVR3SVFRaTBtaWxXWG5sY0xldkdWY2QzZXFJbldkVFJKS2Q3a3ppaDVJ?=
 =?utf-8?B?alphbHU4ZGVVcmI4UHNsYTFHWnZQcFhyRGpRbDdpbDhtZVlUdUQ1YlVIL2VH?=
 =?utf-8?B?U1E0b2dVaGQraDZldDBqLzE4OWNOMFUybktUaFAyMmtWdmJLRDFZUUVLbzdF?=
 =?utf-8?B?amZJUEhhVDBFVTg2TzJKMXFWejBwdVV1V3VTOHkvK1RNcG9jVkxUbzFoQ2xM?=
 =?utf-8?B?RE40WWt2MHJ4SzhDQXVveXJFQmdNbWpvOFkrK0xsbzJmVDMrbjlNRXFra3Zv?=
 =?utf-8?B?RGJQcUgzM0l3cGVMc21JNVlDZ2VDakJ6dzEra21DZWhRdzlWbnV2aklJVkhK?=
 =?utf-8?B?ZllGdTl1MzJXdjBIU3l1UUgyb25oTUZzejBwRzlCYVJTWTZUMHMyUnBuSXd3?=
 =?utf-8?B?Sng4V3d0S0tLTGk1bnVEVHhIUFU0ZnR2SStHUE1uZG5XVVhCdHg2L01kTEVl?=
 =?utf-8?B?TEhjdGpTZnYxRVNGUkprWm1VSndGa2EzaURpcFgwUTZCRG9SeC9rZ3Ivb3NQ?=
 =?utf-8?B?bXBOQVJwN3cyWW92SFljTXllZXN3SU84VFIxd1ZSTE1LRENMbHYySTY1NndO?=
 =?utf-8?B?M0Y0eHRIMXpYbDZJQTV6Vm9pVHZhQzh5ZkdsdW9HSFg5NzlGSWxkYXNXdG45?=
 =?utf-8?B?VzhNL0llVnZzeCtQTHdEYTdsTXUzbDFFeDJIUDNaYTY3YUw3QjhXOTJHQWxK?=
 =?utf-8?Q?1T1vHek1pFhjXHLhwo375YAeq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03EDE220984A484E8DCBD239AE0E0C2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5a5ff9-0254-424f-3026-08dc3e521418
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:55:42.4650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YblgM2L+el8UBz3tgfci91peSm3Lbfw8pZNrptMzeuzqu8q2jFiu4X0Ul2bP/Og22Px7JlmCxSAAY6pEnKtn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799

SGkgR3JlZywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiAzLzYvMjQgMDY6MTAsIEdy
ZWcgS0ggd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+DQo+DQo+IE9uIFdlZCwgTWFyIDA2LCAyMDI0IGF0IDEyOjExOjIy
QU0gKzA4MDAsIFdheW5lIENoYW5nIHdyb3RlOg0KPj4gVGhpcyBjb21taXQgcmVzb2x2ZXMgYW4g
aXNzdWUgaW4gdGhlIHRlZ3JhLXh1ZGMgVVNCIGdhZGdldCBkcml2ZXIgdGhhdA0KPj4gaW5jb3Jy
ZWN0bHkgZmV0Y2hlZCBVU0IzIFBIWSBpbnN0YW5jZXMuIFRoZSBwcm9ibGVtIHN0ZW1tZWQgZnJv
bSB0aGUNCj4+IGFzc3VtcHRpb24gb2YgYSBvbmUtdG8tb25lIGNvcnJlc3BvbmRlbmNlIGJldHdl
ZW4gVVNCMiBhbmQgVVNCMyBQSFkNCj4+IG5hbWVzIGFuZCB0aGVpciBhc3NvY2lhdGlvbiB3aXRo
IHBoeXNpY2FsIFVTQiBwb3J0cyBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+Pg0KPj4gUHJldmlvdXNs
eSwgdGhlIGRyaXZlciBhc3NvY2lhdGVkIFVTQjMgUEhZIG5hbWVzIGRpcmVjdGx5IHdpdGggdGhl
IFVTQjMNCj4+IGluc3RhbmNlIG51bWJlciwgbGVhZGluZyB0byBtaXNtYXRjaGVzIHdoZW4gbWFw
cGluZyB0aGUgcGh5c2ljYWwgVVNCDQo+PiBwb3J0cy4gRm9yIGluc3RhbmNlLCBpZiB1c2luZyBV
U0IzLTEgUEhZLCB0aGUgZHJpdmVyIGV4cGVjdCB0aGUNCj4+IGNvcnJlc3BvbmRpbmcgUEhZIG5h
bWUgYXMgJ3VzYjMtMScuIEhvd2V2ZXIsIHRoZSBwaHlzaWNhbCBVU0IgcG9ydHMgaW4NCj4+IHRo
ZSBkZXZpY2UgdHJlZSB3ZXJlIGRlc2lnbmF0ZWQgYXMgVVNCMi0wIGFuZCBVU0IzLTAgYXMgd2Ug
b25seSBoYXZlDQo+PiBvbmUgZGV2aWNlIGNvbnRyb2xsZXIsIGNhdXNpbmcgYSBtaXNhbGlnbm1l
bnQuDQo+Pg0KPj4gVGhpcyBjb21taXQgcmVjdGlmaWVzIHRoZSBpc3N1ZSBieSBhZGp1c3Rpbmcg
dGhlIFBIWSBuYW1pbmcgbG9naWMuDQo+PiBOb3csIHRoZSBkcml2ZXIgY29ycmVjdGx5IGNvcnJl
bGF0ZXMgdGhlIFVTQjIgYW5kIFVTQjMgUEhZIGluc3RhbmNlcywNCj4+IGFsbG93aW5nIHRoZSBV
U0IyLTAgYW5kIFVTQjMtMSBQSFlzIHRvIGZvcm0gYSBwaHlzaWNhbCBVU0IgcG9ydCBwYWlyDQo+
PiB3aGlsZSBhY2N1cmF0ZWx5IHJlZmxlY3RpbmcgdGhlaXIgY29uZmlndXJhdGlvbiBpbiB0aGUg
ZGV2aWNlIHRyZWUgYnkNCj4+IG5hbWluZyB0aGVtIFVTQjItMCBhbmQgVVNCMy0wLCByZXNwZWN0
aXZlbHkuDQo+Pg0KPj4gVGhlIGNoYW5nZSBlbnN1cmVzIHRoYXQgdGhlIFBIWSBhbmQgUEhZIG5h
bWVzIGFsaWduIGFwcHJvcHJpYXRlbHksDQo+PiByZXNvbHZpbmcgdGhlIG1pc21hdGNoIGJldHdl
ZW4gcGh5c2ljYWwgVVNCIHBvcnRzIGFuZCB0aGVpciBhc3NvY2lhdGVkDQo+PiBuYW1lcyBpbiB0
aGUgZGV2aWNlIHRyZWUuDQo+Pg0KPj4gRml4ZXM6IGI0ZTE5OTMxYzk4YSAoInVzYjogZ2FkZ2V0
OiB0ZWdyYS14dWRjOiBTdXBwb3J0IG11bHRpcGxlIGRldmljZSBtb2RlcyIpDQo+PiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBZb3UgbWFyayBwYXRjaCAyLzIgZm9yIHN0YWJsZSwgYnV0
IG5vdCBwYXRjaCAxLzI/ICBUaGF0J3Mgbm90IGdvaW5nIHRvDQo+IHdvcmsgd2VsbCwgaXMgaXQ/
ICA6KA0KDQpZZXMsIHNvcnJ5IGFib3V0IHRoYXQuIEknbGwgdXBkYXRlIGluIHRoZSBuZXh0IHBh
dGNoc2V0Lg0KDQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBrLWgNCj4NCnRoYW5rcywNCg0KV2F5bmUu
DQoNCg==

