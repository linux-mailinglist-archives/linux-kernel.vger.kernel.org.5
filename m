Return-Path: <linux-kernel+bounces-162437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A308B5B30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7243E1F21D96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CB7C080;
	Mon, 29 Apr 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IBDm9geC"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752C7BB07;
	Mon, 29 Apr 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400708; cv=fail; b=sKd6w4n+qILPbW/wHPsG1waz97RxJyK2m/Mf8XuPqUzY0/joTaDbHL9jMOleOJ9bXEQlhy+L/4tN6/9Bjb1s/6BEgacBtC1Pxuy4yejsyspMYGd5vKrfSiJL/Fe/adKJ+uGgYzyvMONlyc8bfNHdFhiVJ4urejy6lyGIfvCXOI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400708; c=relaxed/simple;
	bh=9cwG9g2LBbXKRA90IkO4X8caW1yioWgPbtU7F3BEhos=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nanpGWxBgX3h4cLos9uKWQayYK3yg93jbDvYHC60Zf4MhqfP2cg9Hqb7REl00gAhPtXWFL4fsbXcHVa5L5KNWshKiDrSHFm8mvrLDSHPjR0rPf2VNDbzw69sFxYhVvSEKbiLBTMQ9lT5J4rTTwdg47d7oGJa8R5KykbOPhMJTQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IBDm9geC; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDuPi3q+aiLrRGWZBxee8WH5O6Ns38qj2fkgxUzOL4lCLNuLTNI+ynTI2Aq2ffWgujyv84DqP7A6FThUTIVEt/fxi5x+41yhsYU17DeC9bLKS0dczOxGj9PjqeZWHVkfJxkrWqS/vJy1SNMRBkBa5HzZB8pkWUFIFCdnCP/Iut3hipv6Q3OwF1VIyLdwMR04r+5cs5jXZopmz6WhgPKA52i126cIKHtehuEHcMlSbOoUuLmU0XX7Y8qQyTKK6Rg2nQ+jIbQY5kBqTRKriIr/bBbtRSt+tHydyaZCnEuPitGvycM+4NQAlcp03rGtK5uP+hizgz+QznWR2eCQ71DH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4UwnZCOwc+GyNehe4kP2EcG8Fc8hPy5AViVeYefe+w=;
 b=noyWmTAk6Ir11MmN0V8W2TgiQwcCeNEbWgkKQa0DuTtPAY4jG7zzMci5EkG/+53l7kNXJEQOULF0e9bNyC6DqtJkR1hPSsmKDNnbhju4ME0q9kIT8mAS1Pw7bsJUlfxic9vri4lSAl2hxtZmBZIa3lSUTGx/wm08kI9KU+PIw6lZVFLCfGuA/lapIeqybKNZ2NshJmJxcCatFiuQCKgeAF8u47NX49JeyywPxHBUkYZXn3bNXOWFumEwIwgei5DQ1x5wYHW/GUqt1p1hEa7wc/C8B7vjYvDqGpudnv3pCiBFqN23yxrO9YjI3TM3mPn5GKrQIjmvxHi6zmYGnOSTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4UwnZCOwc+GyNehe4kP2EcG8Fc8hPy5AViVeYefe+w=;
 b=IBDm9geCWQf0CikIf8iVE2Y4iu7TZaNfR6QbYCnsEYojSrzd9JVxnbXVh+RIWwkluA2SJYUHMOFo1goIyLNPQMBo6MDpZyINEMyVk3E1cTwnoEI1pV7xOxwrSwB6O+JZduIEFfuPwsCccsb/1UaUTg9F5OwRTAhug7Ae588+ISw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:25:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 14:25:04 +0000
Message-ID: <891ec639-e557-4dbe-8afa-3317b9c173ce@amd.com>
Date: Mon, 29 Apr 2024 10:25:02 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, robert.richter@amd.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <20240429125956.GNZi-ZzN1Izxps8ztT@fat_crate.local>
 <d1e329da-6a04-47f7-bdab-ea6c4f584802@amd.com>
 <20240429141244.GGZi-q3NdmI17pai4N@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240429141244.GGZi-q3NdmI17pai4N@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:408:f4::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f94da89-1948-47a7-03e6-08dc68582960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzQ2QXNtUTN4dzZJT1ZiaW9KSTZxN1F3bEtjc2xWeWJsZnRRKzU2dEJ5bmZ4?=
 =?utf-8?B?K3l2L1ZPRUVvV1RXNmNtSHgwNXdTZ0NJTTh1eFc0eDRob1B0Z0JnWmJLOE1C?=
 =?utf-8?B?RmRyNmRCSGc4SU4zOUQyb3lzT0dpMS92Q3B3emNRV0JHS1hwKzlxeTBKelRH?=
 =?utf-8?B?ZkFCOFg2cEY4dDk0MC9aMUpiYUl4NmgrZkd5NHByUDZsZDk2WEtCSzJyV0J1?=
 =?utf-8?B?MjRteXBnQ2NOZyt1ajN4SGs4NGU4bndWM2pxZGhlYS8ydlBxdnVPMXJNQUV3?=
 =?utf-8?B?RmVIaUpqWGNGdlJNbVRlRkdLcjZrQ1h3NVQ5UVhhVFZTSE9xaUUvNzM3OTRk?=
 =?utf-8?B?NEZUR0RhN2o0QWp3Vmg3eVUwcXNCUCtpWFI0V1hBNFgwYjhZUzVvUWZVRCtY?=
 =?utf-8?B?anQrZUhoVmQ0MHVVK3YrNmdsTkRmcVk4MWtLS3p5d0l1V2tzS1JzemhZRXFq?=
 =?utf-8?B?WWhKcWlFY0p1dCszY2VCd05ON1k1Snc5UjVqMlhOUWUwNTJSNkdYQ0I2RjNS?=
 =?utf-8?B?RmliWVJITU9vOHkzMEhPTmhmUTVGRFN0M3Vsb3lSenVldnpqbVl6OWhEc3NM?=
 =?utf-8?B?N2ZaRXEyanN4UDMwMC9IWmtNUW9JSUFUQ2hEVThKQmF5TGpvbW0vY29nTnZl?=
 =?utf-8?B?dzZkOW9PRW5CMW5WcGtva0NvaXZXYUF0d3pVN0k4RUVxTUx4d1Q0dE5ZQjh3?=
 =?utf-8?B?QkxpeWY4b1ZFUWNsN3I5NisvalZFQmJrNHp6K0FRU3dCTlkyK2NxZU16NGtV?=
 =?utf-8?B?WnRyOFhSOXZNcGJCRzNLSmIyblhLUUxGMnpvRDRIRUxsZG1VWEhyWkFKbE1k?=
 =?utf-8?B?UTNvMlExUmdTeUJwbG1YNENQVnpzTUMvYllvVUpKaGU5blphMmg3L085eG9u?=
 =?utf-8?B?MExMcTd5Q1NZY3RKMEsrRHA2VDF5YnFXc2NuQ3k3dHVqK2JMVUxLM1ZMYkx5?=
 =?utf-8?B?bUJjS0hzNHcxS1poZ3VMRmZQMGRHbDZNcXRoOExVUi9RS0RGaHJiN0l3L0FI?=
 =?utf-8?B?SnkyUG9DK1FUMjlvTnN0TmZCc1BDRWJCUGZyYUFwVzVteTNrVFZZbzhTS0FD?=
 =?utf-8?B?QVlpUnJldlFUUDl4WXEvbmVmZ1JGdm1zWW43b0ZFdHE2WDFUV0JXNE5zKytw?=
 =?utf-8?B?eVFoWjlWMTRMVnVLZ1llUm5GMUk5WGVUemV2SFhrTElGcjBVZXgyWG9Eb2h5?=
 =?utf-8?B?VjZqdnJIV0tnMk9Fcld1U3VHNEJCQnFGa01ZUHRrV0JXMFUvY0c1R0JQTVdG?=
 =?utf-8?B?ck4yMnRBRzZuZk5oM083RzhCSENPMFVhWlhKWmJtczZESHI2QXhkNXdraG5Q?=
 =?utf-8?B?QUtlZlZsU25UWGhORTIvUWNiR1RiV2R3Zkp4Qk53L2l3a3pTVFljb1VSeVlh?=
 =?utf-8?B?bFZVSE5lb2p5Wm9mTUdqSHRxN25qV0s3QXQ0c2JoOVh5Y0tGdHNyT3BCeG5a?=
 =?utf-8?B?SC9HUFMwUXVnOFJ0UDB5VlNCV29Gb2hVUmRQVXhHYlFmeUdrK1FUNTRTd2ow?=
 =?utf-8?B?RzA2SXZKOWM2Qk84RU5KL1RTdXhHd1R0cDlnSDZYa3B2T2syNERQaFNFeFdT?=
 =?utf-8?B?eENILzh1c2dOSkhMb2JEUjV2NS9ERDFCVjVkMWd1YVd1VGc5dm9SeWp4LzJ2?=
 =?utf-8?B?anhOeEdhbWZDQWlHTVZnKzZDRGc5RjVhbmQ1TlNwUnJiVlVNWnNkM1dzNmtW?=
 =?utf-8?B?djFSRnAybFFHdk1OVURueFNldERITHlIaXJRdUQ0NEMrRThlNEpmMm5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z25zY1VwV3lXNThsTFZiNmxpZFRSTEs3R0FYcjYyRTJjWThRZkFoYkNiL1hG?=
 =?utf-8?B?cVFmbzRtNFVhT2tPU3FCNVB1VjlMMWNwMjZXeGpvQm5MWnlVR1pGWkNhMS8r?=
 =?utf-8?B?NWRybVcyTVNUSlpvVXlCc3JmN09veUgzY0J0UURiMVA1bldMM0dkRmFUbkJV?=
 =?utf-8?B?YVN1Yzhlc0VXdGx4R2ptQjRVMVd4akUvZUk0R0hMUDlTRVpNN2gxNDZXVllQ?=
 =?utf-8?B?V1ZzV3N4ekgvcHlYKzdWaUg5MFZlcHN0anltRmtWWDlFM0MyU0EwZTBER1VQ?=
 =?utf-8?B?N3FxZ1BvUmozdnhYUCtpWmlnUjhENWo3am9oZlhsR2xjMmYwaWMzRno4eGFH?=
 =?utf-8?B?YnkxYXMvTHM2blI2RmhSQVNsaWI2S1FyRGlJMklDcDJIMS8wUStSbzZnVTZX?=
 =?utf-8?B?TmM3bVRJSjFITzZMVzlRdHcrN3pHcDY1eEFqYStvVWdjUzhWVFBlbC9hRGlx?=
 =?utf-8?B?a0hlSCs0VDliV1BkOXFFRVhNQlo3MXF2ajlBaEEwZmVnWjJTenB1TXpaaHYv?=
 =?utf-8?B?eEdoQ2M1cXMxRllTZkZOa3BLMUs5SXZpMDJLdENTdHEzMWc2VEJaWGJWampi?=
 =?utf-8?B?SlFzbFhYUVpRcXhSOFQ2VWxCdGs1cFZ2SXZaYnphRjlvQmtBS29xV05UcVFS?=
 =?utf-8?B?bTNsQ3ErSExOSVRNNmMvNWpkS3lXRzFrREZVSHdaQTdPeEdCS050M3BwelI2?=
 =?utf-8?B?WlBYSHlxanJicENuMHcrYlQrb1ByRzBhVHI3aHF1d1VRWEw1NVcvTU84Qkxp?=
 =?utf-8?B?R2QyK1VhcmwvR09DS1lvTW42REFKMGE1NDh3S1VqRzNXL2hFYm43TFZaQlg0?=
 =?utf-8?B?TDV1cFN3RG1NNGRpdnVRL1E1aU5jSTdmVWpjUGd6Sk90YVlVRzdHSC9ZYnpK?=
 =?utf-8?B?K1hsUUdzYWVmelNrSDg5dXlqMDB1U1FYZldlUFFRMmVWRVFpOXNiL2VOQllP?=
 =?utf-8?B?WW9FbUNGTCtaSXc2UFZ4SFEraVpKRXUrT21sT1MxSmdJVmdxM3QyQWJCdWN4?=
 =?utf-8?B?dndYL2lOLzJkeGFLMnhwQzlhQ2hVMXh1TGNTeTBsdG5CVXFucE4xOVlQQWw2?=
 =?utf-8?B?TkYzOTU2WUhiMWs3OXBCTVpGdDkxY2RWK0FSUThVdTZwbXZQWEtOczNjZG9k?=
 =?utf-8?B?RTlQNGZ4bXJ2dXNuWXgvQUtWeWlOR0lVaW0zZ2ZDNkhWNE1lek9obnZhbzlP?=
 =?utf-8?B?aDZybjY0S01EVXBLeU56QUdrdkxKczhKR2tZZExZTGlkNUhaNCtwMkpaWjZT?=
 =?utf-8?B?ZTR5R3ZBcHJhYUhuZk0wUlI0bE1UL1V1V2sycEFLdmR1cEdPeEJsVEJhQVRO?=
 =?utf-8?B?TDcyOEVrK01xbWN6TzBYeUZIOFY2QVBtUnN4cFhYcktwUkJHSmp3Y3ZDVUZ3?=
 =?utf-8?B?VkZKVkYySERKSVBpb0ZSOTgvNVh3STVBUndweXo4cDQ4eldtU1h4Zjk1WVp3?=
 =?utf-8?B?OE5aWUVRV3FCbURRR2xRZUN3WDhmdHRPRzQ3NzVwK0ZpaHdCNEdtU3VtNlhJ?=
 =?utf-8?B?TElNQ3JkYUt2T0NBeTZOc0VTcWJWNkkwTzhPSmlESklYTmdXclFKNVgrSTJo?=
 =?utf-8?B?c3F6c2d6anhxc29QeEM2R210SVRFYlc2aG40aytSVFlaMGRqUkppclEyblRY?=
 =?utf-8?B?QkFFT3ZHZEtSYnpqUmtIVSt4SHYwanRVa2xZSVN5QzVnTnZqYmliSGh4WE92?=
 =?utf-8?B?RmRXeDVIamVsQXF0MDRkOGtFajJoRHlkWnVJQXJtWFRXY0VpK0FDNm5QSHJC?=
 =?utf-8?B?S2pRWkpjeDg1Z0ZRY1FCZDVXNDkweVdqYmhWWlM0TWZXYzVNT01DYkFpN1l4?=
 =?utf-8?B?VFVDQ256TGtsa2NQRkFpdWNJdDV4cnNXbEthb0RnMHJRbFVtMDkxZkJYamVE?=
 =?utf-8?B?TTJKTW5jeHVyOEpSMVVCTVpmTVByWEk4anlFWnFwYXJTemNxWDByeURtZmY2?=
 =?utf-8?B?YTdWYmJwZENRaUU2WC9NZnV2Z2xNdmRiUkx1cTJRNUFVR2ZJb2plQzVFVzA2?=
 =?utf-8?B?Z3lmM2pNcWlQRjd0RU1QYmZDNVVuNk04NVcyWlN0WDZwNFd3SDBlRDNjYlBr?=
 =?utf-8?B?Y2VoSmR1LzkvVkpWa0NKKzY5Q29KNGFEUkplRzl6ZVpMVWlScG9MRWFBbDRu?=
 =?utf-8?Q?LvFZOu+uaO2YnoU8xotwH5gNI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f94da89-1948-47a7-03e6-08dc68582960
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:25:04.1070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQwI7Eea2dTjD8UigPXIKjvsr9MDcZTS2ciCAE+WIZdURTi8ejZbLIBFoZsztOKvBmfeF/Z6zmBpqvxw53USKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

On 4/29/2024 10:12 AM, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 09:56:56AM -0400, Yazen Ghannam wrote:
>> Right, I mean we should do things the simpler way unless there's a real issue
>> to address.
> 
> You need to pay attention to past issues before you go, simplify it and
> break it again.
> 

I completely agree. I haven't seen evidence of an issue yet for the DFR case
though. Which is why I thought it'd be safe to do some clean up.

>> I'm not opposed to this, but I don't understand what is at risk.
>>
>> Is it that the function pointer may not be written atomically? So even if we
>> write it again with the same value, a concurrent interrupt on another core may
>> see a partially updated (corrupt) pointer?
> 
> Yes, it won't happen, they say as it is guaranteed by the
> architecture. But I've heard those "promises".
> 
>> intel_init_cmci() does not do this check. So is it more at risk, or is the AMD
>> code just more cautious?
>>
>> Again I'm not against the current code. I just think we should simplify it, if
>> possible.
> 
> So in looking at the INTR_CFG MSR, I think we should do a function which
> does MCA init stuff only on the BSP exactly for things like that.
> 
> There you can set the interrupt handler pointer, the INTR_CFG MSR and so
> on. And we don't have such function and I've needed a function like that
> in the past.
> 
> And just for the general goal of not doing ugly code which should run
> only once but is run per-CPU just because our infrastructure doesn't
> allow it.
> 
> Wanna give that a try?
> 
> Thx.
> 

Yep, "MCA init cleanup" is another thing on my TODO list.

The BSP still completely finishes init before the APs, correct? I recall some
effort to make CPU init more parallel, but I haven't been following it.

Thanks,
Yazen

