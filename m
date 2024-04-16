Return-Path: <linux-kernel+bounces-146727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DAC8A69F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59912B21672
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84711129E88;
	Tue, 16 Apr 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EyICCcY8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57984E0A;
	Tue, 16 Apr 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268244; cv=fail; b=M5mRqLlYDxSgZPLw+rwx1RzaQ9WYX7zNJVEViJhyt4keAMAkbGIvTUNrNzFZ8mHIc9n9emlHOTe1gemiqzXF92I7O8OBve950A0wexwzL6S1NP/cOYDU1DEnPkWPvxe/ccfE3/iEJ3genQ/QjfqYHQ4c65343HdJY3hzn41exlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268244; c=relaxed/simple;
	bh=RZD7L1R/VB4TEPieqCJqBPWMJBxRbbCCYvjYxHMaOF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pKm081i8D6882gfSyEkcsS6gbGs7/J/u6kb6meRxWkskbmYPTqxHMXFqlfTeXLTOG/xJCX6c7kTVVXj6o4W3lp92roDDrD4hZ4jeDdcuulNMQ6E37rUKsvd+jknSQ3ZQxCDXK4wBG4685DN6yXpDw7BVaFAVYb5u4x+J9CQiRWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EyICCcY8; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQmhCnXrwQCKXetDti/qu/ZzzkLW0kL4amc6Zz9PpFlc3vKdxf+XaAUZx4Jz6kS8IebFDK73ej+KX8bde45Pgo8QFz5V4HC2tZ46txKKPmrgGqiBKJtpgOOfSRBwAEfHlmZOfX44RZFzvOHT867qtbObj7yv0dq3QfwmoAkmrvmwuT+x/T1dTRxf4flqIMOAHatZkUlkA9ucTlbay+j61CQ6A9OtPfXwfA7CRKccnU15ubquXQ3NuO9qciFDDWTKeRFVaEzxHQgxUF9QEYY88QLTaa4fWMDLcDCGvS6ZofqJA/8cVwSBeJyAxDIIuubteWkIwDaHA2MMaKUh7usQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZD7L1R/VB4TEPieqCJqBPWMJBxRbbCCYvjYxHMaOF8=;
 b=DH4bf6owKeM6WABYNU7HxKIpD8HPUaFAqAsNIAZ/2y1ur+UyfUYwxNxQB+49Ytc7U+8Kx91uOdR6mHthjmXa7r2o/FoYjGd54muDdSolP1PvNtziK3gvaiTt8BxX4EfoWlnV6J7X0tyFNORi8yzEOuVZiiy8apVMOr2Zoh3dSzfwWFTp25GQ1ASZvUgQxqf1faDHaeE6HVPowbb+59y5hGQatiRsmdAJ/2kWCuzhfj4L1Te0qGY6Y3jET9otWjwgetdFSfnIVMBYtmquEFC/oPOxyklSKr3SOQxxq6Q6r3bywf5S1+0Zy10LlEtfJ4pGjZDchavgdw3t/UyfUEbvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZD7L1R/VB4TEPieqCJqBPWMJBxRbbCCYvjYxHMaOF8=;
 b=EyICCcY8WKLMVwCdqcpGkfa/nE739ryuoNLrQ3Qt0zb0DHLnpJTLgY5S/ibPV073mWsUeipqIYW1EhQS7IbMgh7HhmU3J7M/msdg79JqWD/cnjihFJgqK+WOJaqy0iQy3VPPN97nmkFBag6XFqi2xF2HfaJAKFE3FCgpLfwOMOrfgO7W5b0uO1D1lRfcFp2455TFg1J/8OD95ikQDGO2ag2x4Cs5YXvd9Z9gpUloIC1XQoR+akk7ZdA77az7oNjpeY4AvP0JO4VBtf/Ivh1o6ui32UnDGEo1WukNxRacMx6X+PT2uy124cLENKjdBp7brJm75I6McARZPUDdsVyGjA==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 11:50:40 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 11:50:39 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [PATCH net-next v2 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Topic: [PATCH net-next v2 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Thread-Index: AQHajy2oOK8Gokf+00ClZj5QTeHiJrFqTvmAgAB7JzA=
Date: Tue, 16 Apr 2024 11:50:39 +0000
Message-ID:
 <DM6PR12MB45161CCCBD7E9E70C223E62FD8082@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240415120717.1251864-1-danieller@nvidia.com>
	<20240415120717.1251864-8-danieller@nvidia.com>
 <20240415212927.2c87ddca@kernel.org>
In-Reply-To: <20240415212927.2c87ddca@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|PH7PR12MB7913:EE_
x-ms-office365-filtering-correlation-id: 5efedf05-3deb-4c8d-5f74-08dc5e0b7015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wwG9yZ5Kmj7jUmxtuGiqj5xGSYXUqPx2gwVIdOKaYNhuMdttBv/2p4bVlApFuFjh9bT86cF4zeHT3yYgJWZlMbMFHxWsQGT/auf6C/b1MuDgM3abrX9f1HUVX3jhsLEFIwgu2Ktlut0tg1jNwpJLgjSWSLtC8OVODQ0V/1e1sSc24i5OaSj2PaC1liMYLllta+wLqgA5dsZIUMds0qEZC8XJfa5lmeBMKOFhi8lN6a3Huvy391RXvFvcqwdyB70CBIW4eVCwjgkZ6s056MrtqtAnvVNsPtNfsqY5z0vMGrSHeTfSA71CWUY3m+wH+0f3lbXfg780VPSeI1P21onRuAAtQAr6BOUst/1LddwNaPVZjk8th6L/TkDmvISkofqdUsd7VnafSWtBz+vVGjxz1vc5Og5wT2w5juXyXGN2zq9PGfgq9L65dZC7gGbHY0IWVGDgtw3oBWwg+HyXOgB97EcJDACrz27WOwUqcFvMG4byyxmauUbLbH0XG+qaiKmGIkDyXV45QdgLEYuqSJ0+F0aHTsOJgY7HXgufetWVqTYaAiKAOq8WshqjuT5CqWOgKornQ/jh049eiLOoz9nu+9wqazpODwVUHtxiGoD2LXRFxU3LMkimU2gg5tgovGK5/dh0tnL1Q+BXHca7MuMycqfnus98ERZH3wX4qA7BWv9JH8YXg4T+UXdaTqTpEqR9ar0reU3X5dLSZ++5TAPiMrOiy+iILLOLqH+4S/VWRJU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eU85cGw0cW9sTE1LOTJsZCt1NUxoaDNDTTNGbzVMcm03NXBGMjJ0OEl5YkVY?=
 =?utf-8?B?QldNbVcwbjF0NjN5WXJIdVgyQUpEaTFpcHBZTFVhN3M5eWQ2aStUTnpvbzZ5?=
 =?utf-8?B?ay9yU3dDTFJabkg0VE43aE5SRlgySUNTNWk3SlR0UTQ3cHZEN2lpb3RnSnlk?=
 =?utf-8?B?Y3RVbVhRVzg4K3Z4MmJYU0R5TnY3T2dkd1QxQk5iZ3ZMTCtDR3RPQ1piTEp3?=
 =?utf-8?B?WHJ0VXdrNnUwUVh3TkZtc0psNjZqMmdPS2FpY0M1SGo3SGFiOGwzNjgvSUxP?=
 =?utf-8?B?ZVhmUnJoNFgya2JWcUVVeDJsZ0dJR1JuY3NMaWJOMGdTU05LRjh2SnZNOEdm?=
 =?utf-8?B?TmlFYmdWUmZJY255RlRtdWIra0M1YlVyaXowSDVqNXY1ekdRVlhlYy9aWXN5?=
 =?utf-8?B?ZnY1QlhpVndXSjlGSEJEK2N5QzI0bUNYM0ZQS1R4TXZjTmZKQWJKM0ltTjUx?=
 =?utf-8?B?WEYvc0lDRUpVcmJzaUgvM2sxdjNXczFLZGZYZGpWcFkyNWl2aE1TcXRJblhP?=
 =?utf-8?B?dHIxQUI2TnFvYWF3em5ZcUZhaHIveWttT3d5MWFoeWtlSDNDL1pyMzNJVEUz?=
 =?utf-8?B?c1R0cTh4dVFtZWVHR3cyU2dNcnkyS05EMU51b0RUZk80WGZZRWRyWlhEbFRa?=
 =?utf-8?B?ZTNTbi96SGE4Q0VmZDBjZVJPL3Zpc1g4TytCMEVYWmxXUG1HaHRVajlNZ3o2?=
 =?utf-8?B?WVRRSC92dTBIRWdBMnY4eVY2eTNoSk5MNFVLR0htU1RSdnRDVTErWUxYcTNa?=
 =?utf-8?B?TVhZN0N0NHhaSGNqcW9LK016MzM0M1liK0JxUG4rMktNdm5RRVlsVjBKRjVq?=
 =?utf-8?B?VzdQUDJNZ0hVTzhRRS9DTjBnR0J2WlFidjNrcmxsK0UwT1U0anQ2bkp6WUUw?=
 =?utf-8?B?R3BHNUlLTkgwS2JEYW1EY3d1ZmtWVTdIbStLLzRnTlpMaFR1QmZoL3RSdEZR?=
 =?utf-8?B?aExsRkx0MlZrVEdMd09PTy9IMkNaQnl0d2tmd2ZObWtqYkgxZ1pEMUtmU2hz?=
 =?utf-8?B?MEk5cUFwcEROZ3ZmeHY4RXRRbjRmOUdwWmVrRWJJU2Z2ZCtsTzhEYUgyR3B5?=
 =?utf-8?B?UkN2TzVZZCt4NmZmY1hzWWl6RlRCZm1SdS9hQmJyRWVLdFoxU1BacWhheE9O?=
 =?utf-8?B?c1FZTE10SnF6c2VKa0c1clBLV2lxWUVTY0w5NGJLc05VRVRha1R0ZERNNUxt?=
 =?utf-8?B?UTFka3RTMkVTWURxRC9wdVVLL2diaFQxcmRJREZsbTZQS0FORG9rZjBZWjFa?=
 =?utf-8?B?eEtSUzdlNUVkTHlqZjRVWWt6YlZuTzNIM2hiMWVTN2xmVzZDemliVVFnZnFD?=
 =?utf-8?B?Y3J3dm5NaCtVRlRpOWlJVXlWR01UNk1uZVVpK09wOVFsQjZYN3UrS3NTa1Z0?=
 =?utf-8?B?c3JrK0FlMTJ3emJXb1o5ZC9rcE5NcTBiQ3hnRDNIb2J0KzJleGtHeFBxZ0RL?=
 =?utf-8?B?aTBNZDVLMmxGS1VuSjFFZ0dSMys3QldBV0p5SnN1ZTFwNU9qQktJTmhNWTVH?=
 =?utf-8?B?Q2lmMFdaWTRzMzdjdGw1L2dqc3hUR3kyQXR4YTdrVnpGbzZWQjBjd2Zjdkhp?=
 =?utf-8?B?RlZ3TTVCWjYvOXN1eGYzYzNHVXpWWGtQMnViWWtITFNFTTU2VU9DODlxY0Nz?=
 =?utf-8?B?YzhCZnlzbXY1WE1pTnM2bngraFlIcXVmbHVLN3h0SWdMd1VQYU84TWlEV0VE?=
 =?utf-8?B?Z0M3SEJSOU5tY1lWengzamh3bXdiek5TSUh5azdmT053b2ZvL2toM2IvanJi?=
 =?utf-8?B?NkE5ZkRiS1ZMSit0VjBQa1BDSHVqczRxd09qNFR6S3FCOEwxNDV2NmR0Z2Z3?=
 =?utf-8?B?NTlRYmNKcE5kU1lqbmIwNFh2K3YzeVQxNEFyRFB6cyt1V2FOdnFsNCtLOVFL?=
 =?utf-8?B?UHZNZlpiTFdoRFNjUVNoR3IzUmcxTldWb0pRR2xQeTM4UXJnQ09Nc0JuUisw?=
 =?utf-8?B?YUJ3RmpCbjhxNC9hcWU3SGM5L1JnOVBvU0Q3dU5GQjcvb0thVDFoZXNRbDBl?=
 =?utf-8?B?MHZaTXlQS1FaNVBadXZDay9CZlRralMybm4wNFc5WHlid25Sai9DRFBzQWNq?=
 =?utf-8?B?R3Uxb29IVHM4WDBiNnpSL0tPSDcvNzlwQkdkMjZhdUxLWjIyRnVZZElGRUxV?=
 =?utf-8?Q?NvlQw44qu0vazQUZ0GjXYg010?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efedf05-3deb-4c8d-5f74-08dc5e0b7015
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 11:50:39.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJLa9k9jCL4hun/uGvswx90xx3QwLA/tiD0erw5K0q43VXxwSk/6XohY7KJ3gJ+37JfihLoAXs1v27KfZFFDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

PiA+ICsJcGFnZV9kYXRhLT5kYXRhID0ga21hbGxvYyhwYWdlX2RhdGEtPmxlbmd0aCwgR0ZQX0tF
Uk5FTCk7DQo+ID4gKwlpZiAoIXBhZ2VfZGF0YS0+ZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVOT01F
TTsNCj4gPiArDQo+ID4gKwltZW1jcHkocGFnZV9kYXRhLT5kYXRhLCBkYXRhLCBwYWdlX2RhdGEt
Pmxlbmd0aCk7DQo+IA0KPiBjb2NjaWNoZWNrIHN1Z2dlc3RzIHRvIHVzZSBrbWVtZHVwKCkgaGVy
ZToNCj4gDQo+IG5ldC9ldGh0b29sL2NtaXNfY2RiLmM6NTA0OjE5LTI2OiBXQVJOSU5HIG9wcG9y
dHVuaXR5IGZvciBrbWVtZHVwDQo+IC0tDQo+IHB3LWJvdDogY3INCg0KV2lsbCBmaXgsIHRoYW5r
cy4NCg==

