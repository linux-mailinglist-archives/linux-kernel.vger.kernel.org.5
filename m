Return-Path: <linux-kernel+bounces-106954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868F87F5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A010E282E72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C437BAFE;
	Tue, 19 Mar 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nINow7JQ"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1D77BAE1;
	Tue, 19 Mar 2024 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710817522; cv=fail; b=P9eXjniLXDelTi4CI+bg8FrGi+AwltAhAmkOP6JQ5nmQJJO5//jbvBGHvdXTuqHxz35je6/royGiDhAuxrfFMGnYVfDCfc5rLVUDuQtvNP7z9gEVNCL1KqRRq2hEYeCyTd+PariM4ChQf0/IGM/JeRyo4ddiX1D//Jadl97ZJz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710817522; c=relaxed/simple;
	bh=8bmUnDaaBQzu2jnCP1FyyGwo+KzZh8frC+6H7IOlSlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTs7Y8Ray0cqwoPPR5n0GppU1VWVHvJ63WGEffKQcydRn5a1rITnEqhykVSK1vLuDb0xwZnnyIqXpk44UZ6GPi3jtAhEE8PvKW9sarpwBV+xNh9HdR0XXtOK2dsLYYWQBboMpZiKBeTY9Duz+gyrJBju+VmVsd2rye1dqmdKWEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nINow7JQ; arc=fail smtp.client-ip=40.107.244.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfMd12A//50zxM0RbDFutqxOzbJrf6JWY8Z3SYayJsDMnBzKgHsXjtf01hK8PkLXPwdekznX782pPlQpVdYwfgVI+ifio0Ik+0o+Akng1SHTFctb/7ZABR7+tFeq48c0aW+kG5xp5KvG1LhEofObeAi7O/lf/M9x7jsT8W9AHBJGvSvY//KwkPib6NFBLhAgOfEJX7tO367vDnPFY6epWM2RXe9RYfEKZ/mDTl+cUOCxYLqOddlxO4f89pP6nUP/LuORqF1/EVcTbkq01IKGCm/j/tzWp5DTo3XgrEv8P/VZ3oyuqyibbxksftoU+k8dW7WFn/Ji24el7p09bAbrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bmUnDaaBQzu2jnCP1FyyGwo+KzZh8frC+6H7IOlSlI=;
 b=PtM5l3vNbWzlCpQnw1Jl0+2wlh8HB9NWaC1W6m/4ULWRkKSbwa3ePQU8nQSt4ZKmqCjisiVgiLvfWzPAQkYo3Z2WIWOiAg70bwW8sh5eyCve5UAwrZNoWFRdNfxwalN1G4JCffuPG3/RQVJIUOrMPHtooYmWxcEtGRwk+G5BinUno3rYzet4p04lXNBks6LaVlaWFLc77yU3F6jzj5jgkhFTk76s24RlAZixQfqaUEFEDCcYx8vwfH5LPrACFn7QWpxGgPWYqQTGSZqvP/Av9EBcGY67M4+m7tgwSF4sdvdVqhAr1E6gHqIeyrcrT7qgKMrhchszOQDsrrjrrg81qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bmUnDaaBQzu2jnCP1FyyGwo+KzZh8frC+6H7IOlSlI=;
 b=nINow7JQY+lu7/tdDxAWFt+ZBqPdopShUw6dGY7/JQ5em7nIxsMpZ1fmc3WApDxfqhyrDVj3A4OUPKDFPzF8N/LP0oCNOhobOHg2VO40oULCE16DTsqkdMJrA67LE7O/oqU0uGirYA5nScQtUb0FvJFGvKzuR5OuXLicBjS+bE9PHcxoiyKAMfcMFbXH7tJvV0UrWY26I2buQYn1I6thFwdFozehkwzGPKo6jLjByDScT7LcqjZwHehDNBTWtAZgvNPxtTgqIQh4moiGHTENwrr8PCH7GQ2T67Zk/hzaDlT7VcMo7Gflq5akXa0eK/9LDsjF88ikkYTxyoPJSNjLjA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 03:05:15 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:05:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Li zeming <zeming@nfschina.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?UmU6IFtQQVRDSF0gYmxrLXpvbmVkOiBSZW1vdmUgdW5uZWNlc3Nhcnkg4oCY?=
 =?utf-8?B?MOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
Thread-Topic:
 =?utf-8?B?W1BBVENIXSBibGstem9uZWQ6IFJlbW92ZSB1bm5lY2Vzc2FyeSDigJgw4oCZ?=
 =?utf-8?Q?_values_from_ret?=
Thread-Index: AQHaeN/U+XjnkT54ukqyCV2Ouczhs7E+YseA
Date: Tue, 19 Mar 2024 03:05:15 +0000
Message-ID: <60f05d60-162c-46fc-a589-d0e794a27d52@nvidia.com>
References: <20240318025525.16439-1-zeming@nfschina.com>
In-Reply-To: <20240318025525.16439-1-zeming@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9251:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 05QAN9761T2wJsb4F5QbRlG4+qrXJOdtpnSW/P7s/goadrJDpzbG+fCilj2nLdpTNT8Xyk3+mZeJ8aGPHwuLVy8fovlezp3mehLZaiSPEW8lvvwf2PM51T82G43QS6IMmvvd8WsZS4hbzDdRojuE9aGeDu7y6a2SJ35ROAP0cAUUJ0CDoW/cSUXVBFrqa9J8O2wxC31m42toDdCIs7VJlsQAmyxj1kZvMCxmg846giGNIZh+HoXb88c4Cr+IvpFohh/bohKBUbsD9fu2mQ03vVs17msPfTOk53TXyoMin56ClxmYaIt6DvqgoO8zlVeyDbhEf/3kLU1FrsgD1jOHxrYpRRb/SXqntA6MDzCTBQu+E644kdB/hd6Liyzqxk4BusDFgVMs4JiPuq/gMzuNKnsbfq9gIDwqf21+sSId3flNyJs5mIIH/0uYP+xS0c2alfQh3a0zyk/A9KKn8GOx+ZbOLe3lgUAexL0BkqEXThwWnScHexDO31AZpl1L69nxtMrPdQ8skzZMWYMTs3VlPlOULFd3YJLKNClC4REO+2+OGEzZ3Hfsdge58uzNw7REsh0W3Q4/TOnnCvJmidG6/K6OuT5t73IAdQIv4L6Z8ZVgmaIBDtiezyJ6ywCqx4XtGsvWlwLCnWopdwpY7OjdNDD03w8lUKElLr5TuYpvpdk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2kvRElQUmEybjFzZ0U3K0xuMG82VWlOUmk4ekt3ZHdPNGhqVjlkaFpTKzYy?=
 =?utf-8?B?RGFvWlRDK044VnVjNEVHUW5LUUNpTGo5VEkyVUJvc1oxQW9KMnhwRUhlRjJY?=
 =?utf-8?B?V3NmU21LZnFzQm9SQTBaWndqN004K2w3dUMraXNIYnlNUlF6dnQ3d3FHNlAr?=
 =?utf-8?B?QVkwc2cxd3p1R0FUVzdORFlRbFdwTXJEd0w0cGVYUlliTzg1Qlk2UDB6YkNE?=
 =?utf-8?B?YUJQc1dBcGY2YkVHSS9rdGxOb3kzR3lSNFhUcVVHMUNRMjhadHVSaENwRmw1?=
 =?utf-8?B?eHd4c1krc1AweGptbjNNNVMwL0VwVnVwd1FUM05Sb3BpRXd1KzIyZ282T0VU?=
 =?utf-8?B?SkVZWW10Q0RFK3pmZk8za3ptcWRIOURyQ3Zzd3RGR2lzQzEyamtWcGRWbStI?=
 =?utf-8?B?YlhIY0EwWXJBQ21sbURJQXVISjFhb2lmOG42Z3lhbDc1a3d6TC9YNExJWStk?=
 =?utf-8?B?djdDQWhDVUNjdk1QTGNKT29YaWZjRzNKTW5DOS8yMXVmNEgrbHZ6dkVoU1Zv?=
 =?utf-8?B?WVR5dVJ3dmxoUG9paWt2YzVtTFpKMUgyeENYTlRZdVdZcTJqcGtqMU45MlJu?=
 =?utf-8?B?bTV4aUp3MW92c2NiVG10TFYrTjJjeVVuZTNCeUwzbllJNTFQVUJQeWxqVWNP?=
 =?utf-8?B?V0lVN0swOFcyaCt1endISU11QTRZSlVNUlFXTFZDS1AwLy9uZHc4bmI5Q0Jx?=
 =?utf-8?B?dFd1RCtrNlpmTFBVcFdjVlVycmRPNWhkZ2NtdTZ0V0FhYlcxUmx5d2oxNDlD?=
 =?utf-8?B?VnB5b2hWcmZjRVhFT21NanIvb0dnTkNGczBBZURLSkRLU1N1Mnp1aVhtRldI?=
 =?utf-8?B?QmhkM3BENlFkK3QyeXRwTVhmMWpzSGw0TGxPOCttTTRuQ0RndVYrZXRtVkYx?=
 =?utf-8?B?NDlnODBhRzlzdEx2dVdHNGovRE9SV2NtNitLbjJMenlodGtXQkhzMVR4aDVW?=
 =?utf-8?B?Q0syQVNJSlhFUnBDV2paSTJQZ1RsMiswYzcwZ1laYTBUSXVRaDV3WjhFUnY1?=
 =?utf-8?B?MzZlaTdIL0hxV1lmVDQzaHhPK0lKM1hyZ0tseE1ZR0oydmdmUXBxNDd1R0Yx?=
 =?utf-8?B?NGNIN1MraS9Eb3pZTFkxaVc5MjVxZmplOVYzQ3o0eWQ5OC9ma2RmUk9WWmIv?=
 =?utf-8?B?MDVzZVg4YStPeUhpK1FZUjYvZ0FyMk1WbW5kRDdIMkdlenVabExGWkRhQ1NF?=
 =?utf-8?B?amJJQXBzWm12N0RCVC9FQWVEL2xNZXY1V085RGhweGpuNE5taThBeUwwL3VL?=
 =?utf-8?B?WmxvNXRwYnFHNEFYSWszVUlVQmcrSG1CekFlaFZNeE9WdWs2aVV1eGxRUjRq?=
 =?utf-8?B?M2hKNGFIbmpZcUhmTkFrQjlNNndDeHY0d1F1NVB6YXRvc3lKeGFqWVpzYXB5?=
 =?utf-8?B?NVpvTk9OYnFYZW9reW5iNXdPU2JIZ0FCMlZNUmJlbTA2Ynl3WGZDZUR6ZkxZ?=
 =?utf-8?B?MmtFMFI0V0poSld2NnVMTmFUK21qRGhtcnNxcW5SM3l1eWx2bjN5WER6TUx1?=
 =?utf-8?B?K0ZzWFlQUEdNZWIzR0xpSjczdldOME5Uc3dCN1AyTUMzMTlZWVNQdXJMdmJG?=
 =?utf-8?B?NSt5bkIxR3g5ekpkQzJZM0xpblJPYngyaSs5TXRmQXlPaWhBOGhkbXBwOGNI?=
 =?utf-8?B?VWJXRTdXd0lvWDYrQnlLd3c5UWlMbGZFZEVxY1JmT1FHZHVWUTlKemJCVTlk?=
 =?utf-8?B?VE1qWjlIeTNTaW8zZ2ZQK1NVM0lhOHAzQW5USVlMNldkMHBFVEw0dFRHYzl6?=
 =?utf-8?B?cmZxeWdBWUpVMVBFV25VUjA0ZzlocHFkMWFETTZ2RHdzSWJXeVp4UXlDeldr?=
 =?utf-8?B?dG1tZjl5dzVXQTNxS1VuQXp0blBlZ3FsMWJXdFg4SDFMblhBYVAvWlQrVEtX?=
 =?utf-8?B?TmFyRDNQMnV2TGFSN2xacVMvcjV6VGlVMThlMXNmWnhjS2JuS2N5c0JHQU5j?=
 =?utf-8?B?SElUcDlTMW1xbHltblJxSGJjY0tOZWtlUHlzTzRkKzc0L1AvN2QwL1FITXJl?=
 =?utf-8?B?M1lrNU0rUmpFUUx6dUVXbHRKQ0ttbkFqa3FtVDlqRmtMZ0JjcUYzQWcrY3p6?=
 =?utf-8?B?bkRaU3UyN1N6SGkzaUwvU0dwV2haeld4TzBSQ3FJUmNGR2FRTWRlU2NPTi9H?=
 =?utf-8?B?VnF4cVJ4ZGt5QWxpa0RtWUplR1JZcU9MelljT3hrTmR5MDZVSXlLTWwyRmxj?=
 =?utf-8?Q?zC2XIkjxPf8qIHpYQoEHnMFtUUYyGCsvGs8tW/jz+fQy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55F775D94256324F8722BE171C4F79F9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 052d7d57-f4af-4c22-4c58-08dc47c166a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:05:15.6157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pB34nMw7jWLwdYjrUu19ZQAiQXCmn3oiyKyNZhDKUKdXWCtoNqjK/Fp35KBngRX7A5D364q0U7wxlgjULAtcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251

T24gMy8xNy8yNCAxOTo1NSwgTGkgemVtaW5nIHdyb3RlOg0KPiByZXQgaXMgYXNzaWduZWQgZmly
c3QsIHNvIGl0IGRvZXMgbm90IG5lZWQgdG8gaW5pdGlhbGl6ZSB0aGUgYXNzaWdubWVudC4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTGkgemVtaW5nIDx6ZW1pbmdAbmZzY2hpbmEuY29tPg0KPiAtLS0N
Cj4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

