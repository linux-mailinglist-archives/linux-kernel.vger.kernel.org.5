Return-Path: <linux-kernel+bounces-44670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E828425EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790DFB2E0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE46BB22;
	Tue, 30 Jan 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcJVWtk3"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6C6A00C;
	Tue, 30 Jan 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619765; cv=fail; b=STUMJ3S4vXRuT/+o4a+oXYDYJ7Ik6otVHBBg1AnK4Q+vD7UMav5JvzEiozghg/lhiGLInIoU85DktZTjf38niByjKTffFe8Mcn7In3VifatMpCsHiv+POyJsZlhnVURC0QhsHXZW1O6G9+tXNHNuzGsP3udCTbiiU+8rFpoGmvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619765; c=relaxed/simple;
	bh=iBQKEsXfIFXBL35aYm2GG1tAXbCNijZRtr2FcFlR5ZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nv0muXp/JRMyh58FUn0RYxDtK2j+wVxdoycYxqWywa2zl5yYEZGiG9b+nmYLb1DdwKr5mWXHhuovA9vAyDpgXc46UGSPb7PO+3ddWkzKNqz6ycQj9wDQAcU6q22FO6ubp5GkHdvMQyklKaoVvJRRxd0Qh6YNK6Jazky3RSfFWUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcJVWtk3; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FL3uJTZCep4gwd/fMui32s+aw7CFKhNHyETk/jztLz8O2j4XGiPol/G0aBv9KwSe8oeejTBXA07SlUbsTSS9pjs0tb027pJkrr2dS8wyiSzBUMJKcEw6Z/jz2YHZCjuX+qhWvoj0ZbnRp9ZHxJixKopLYEQY7r6cbjlG1LFTjXDqolyNkaeKcjsuTNhBi0E+ZUF8nQxLCXpgQPHZ3PARlJN4sjRZdd1Scu5GPa0RT3+iJ7jrVTMo47PnXZkx4ZOUXOpybEY1q/ae2wE1P+an2OitwK+v1SEHDJ0aaXbav3B8D0ECS4rYJF/05IzjipfdHqe/l4RNZ28s5RnGfnwmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UiWv4/yTDAnSf86Vy/2bRpLldHYbw3sP2eDvRxdZxo=;
 b=gFCWnvp3XWUYrSx3LcYm29gkwCBCx/trBQH9zs74WPhfeU40KDNdOIfMUy1i2X3uRVgvF1j80SfER/ez7/B2+xWyMXdLbbNXcdlvvHi8hoiGwexFEHm7E/duDwLsEjcU4pjEmzPlyRu1yD7/MqW0eWsx4cRbUFrn96G6ohwzqEb2X1MAzPPdQ5VQN44cyGF0i7bnipP8SRFL8uuioXhaZ8RsA1fftFYmj8QHyeHk1mc2joErLFhZOzgW2FleWYam+qKbMjGwsgThuAm1cMRnURIJw5ZHwlrX/hkbyHg3eHiOZ0mx1ISBnEIXh4urlmebeCDCiXFD9xh2mM6OL201CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UiWv4/yTDAnSf86Vy/2bRpLldHYbw3sP2eDvRxdZxo=;
 b=jcJVWtk3vbs9b/IrDVFEfh12LTdY9DKVHdnQtoETJqONq1slhM/cGiBw5OHdn5svRwlXScVL+Q+IPoO+fhBI0B4eLemwu+b1DAc+7Sfa/eyWE4VObSbAicGWpLbl52t+IlH77988DBSRd2jbZLTVVgKKucvMvS4iVO2YjRn75yKjwddVopCbHCgxqOf+2yrqEPOa/qsXNm+Tck/sEpQmRFH9ijqu2v4ipiiwqTCA1RKJcbt8/sNiJXmom63jiZ/phHtFE1ihBc/yOf4MHmanwR9hX5MtQ/Uoey5gw7zmW9XU28oSruz5RoioJu4QIcY8DkC9bjz5eHSY8zZZAbxFww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Tue, 30 Jan 2024 13:02:40 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 13:02:40 +0000
Message-ID: <a1edfd18-793f-435d-b4f7-8394224f4d8b@nvidia.com>
Date: Tue, 30 Jan 2024 13:02:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/346] 6.7.3-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240129170016.356158639@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 719b5409-e963-42f0-c5e4-08dc2193bdae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4w6UlKmEzZbOUFPZRg+cOufN86HIWDOzzJ/fOZPwhRSRJhb7R5dTgQvYieO+A6OpUMmR0OUFzTN6VNx2H58M5736RHjctVnHgnLEf7AgNQPoJoWdPX3IgKjMVaRK4dQJQkv0eM1aiaBym17sQ1XueUE5Jq50ImTy1vx39TRba3aHEmb3ixzDKMqexutkgsHeHXkGyqo6NlcCzZrqm3bwIGPc1JeaICcV8D3qFMrJ8wH9EfhNV5apduyhGqERgwd7q7OkrUA13oOk4RMqP7iBoGfl5Dt9w3hgz/+gC89nHn3S/TUHWVDYwx9mR6cY+A8NZ4CpKnXDGSK64zdrRBuoQKulGDS1tQwX0y6dTcdzFxhSwPFhxRWMVREoF5ONhjOkcTuFGqbVbru+VS4w5am1kEXGsa1cIgolvTOEdwyQBIZUoyUxMhmkMDXSC6WH3q9/uLj/ZRKfCR5xpgUVF7KIWjcvdc05d/Tma11CFAeCCfR8cbKXIeq3Hrod3Z+U3XHLvA287jBGtVu13IGIl1JJ9hhzrpkH1A/tukzosHeVMmdz/Fo5p9J3e+W1q2pgV7LhY2cYSNYzj0Ggp0cX79rhTUSeR3tK853W5pT2ybdbGzKT3vu9cItCEsPU0U5/I7DWvVdAUCKsSn6SlxnsAvSAVry2HUY2blI5DzuZaaRdUeAXlV1uvbAL6F74ufJmPUX+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(55236004)(26005)(6506007)(6666004)(53546011)(6512007)(478600001)(38100700002)(41300700001)(7416002)(4326008)(5660300002)(8676002)(66946007)(2906002)(2616005)(66556008)(316002)(966005)(66476007)(6486002)(31696002)(36756003)(86362001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpXaEdZM2x6RVVYQ0RXYzhSdXdqdkcza1BZMHcyVjFtelRVeFdqeng5YmVK?=
 =?utf-8?B?eDdWeVN0Z2NtQloxb3ZSeGJuUWhhSEg3M21OWTEzZlZrNitQczk1UFVQN1Jk?=
 =?utf-8?B?NWpUb09iVWFCdUlIY3VPZ3FNcTRFQkhIT3RLbVZ4TDVUeFlwbWhEb2ErdlRW?=
 =?utf-8?B?T3gxb2d3NStxRzdRL2d4cDluNlUwcFNhajBqUjY3OVVTRC9FY29ETjhGUnRJ?=
 =?utf-8?B?eDhZWkNWdnM3TGdCVWpZWCtQZjhtMkp2aXkrakcwZW12UVE2RVNEWFMrYWM3?=
 =?utf-8?B?a1RFQ3hyb3VQYU9LRlBUZDJhV1RSTE5LTWVTZEthR1l0ZVNEVXJreGJQcW5X?=
 =?utf-8?B?aUpQQlFSVjBDaitLMjIvVk5ScVJVN3lwTHdhay91bmhyR0Z6K21STlo0K1ZM?=
 =?utf-8?B?eC9vMWN3cUsxMFVadDdSSW1sb2dyTEI3RzA5OTFoVy80WHFmNVVmd2dxTmRp?=
 =?utf-8?B?MjJQVWcxSFVtNEJrRGZmYWR5d2VrSVdsSCsyMHFMWER3ZGhtdnNobDQvK1F2?=
 =?utf-8?B?d3V1ZmtYb1ZoVlQ3YlRYQ2RLM21vamRJSFhyT2grOGRaM0s1T2QxSitBdEh6?=
 =?utf-8?B?NHFNakFzSDF6aGVlYzlQWHBYb2xmUHFwY2x4em1hbEo2cS8zcFZ3YWdneFpV?=
 =?utf-8?B?a0RJd21ZZFhEQjMvaUZpRDZKWHlsVEtFaFpqeVpjbDVpaE13K1FiY09pTHkz?=
 =?utf-8?B?c2FQZi80Ryt2d0xYbHJSVEhUV1JnMTY1dWM3ZWxlNkdld1RicGZ0WWRaTzh5?=
 =?utf-8?B?NU9FcjdUV3JxODJoQTA1clhZRWI2bGtVTlUzWXkwK3EyRGhlVzg0UlZOWVdB?=
 =?utf-8?B?RzlpTjlCRnMvZWZCdjBxZm94TXpXbXoyb3d6aFo5K3RlTFJQZC8xK2orME5E?=
 =?utf-8?B?bXpPZElHZFhkekFjWHlVZExnTi9yK2dnd3FXMG4yMFN3RC9nZW9nazQ4LzZk?=
 =?utf-8?B?bHBIYkxiMis1WFhtM2dwQ3hEVGVPVjFIa2xKN1gzTldLOWlZYUhYSU1CTUNy?=
 =?utf-8?B?dWhxcnZEN25UMFNUMzc5SFE5WkZIdzBIQ1FXMHc5WjRKK0djeVRmTG16WTVE?=
 =?utf-8?B?eGxabFozZU9Id0ZFOEx5YjRNRi8rakxudVgyQ2xLQUVBSkc1cHJsa2VJNDVo?=
 =?utf-8?B?TUhCSVVHTWg3U0txZjNDUFU1UU9wNDcwN3F6RW5FQjN4Q3o5bDY5KzlUVkVO?=
 =?utf-8?B?SmE0L3VrcFdoZkVHUTZpbkkzTWtualVzS2tNVGNVQ0c4bllqTXV3YzZrMG84?=
 =?utf-8?B?WlFPUmpJaGhtM1hIWjA3YURsY09oUWl0WnVWdXMrU2NyMHFlMDNRV3ZrdEJR?=
 =?utf-8?B?cGJlQ3dnQXYyRldZWm5ydU9kbnRXb01iYk0xdldTYkc1QmN2VFMrVUFmTXpW?=
 =?utf-8?B?cldaSW9QUWtEazYvR2F0aVpmNnpCNVU1WHhkSEN5SHZIZlFrdmpHeEMyME9a?=
 =?utf-8?B?em9NTnQyMTZlZnhjUmNseEFXdDFXWkdLMksrUVBST3o2ZjFFVzBUWjBNVUt5?=
 =?utf-8?B?cFNMVHNoNVdVKzBuVURCY3VRT3RUUDM2Vk42RG9mUHV6R0drUW9vWlZmUnEv?=
 =?utf-8?B?OTJWcGtJeVNIRlpMM21QUkErUGNtUlRwbFFwbjVFakdyOUt5S284NE9NSXY2?=
 =?utf-8?B?NXBHZzZmREhaQ0tXbFRJaGxyd2RhTGxzYUJDZW42bWFlVU5XMXMzWHdPNTdH?=
 =?utf-8?B?TW9oWXhTWithbDVWK21TbFZFczl4RHIvNlBxTjkyNFFFRjBucE5RT215M1cy?=
 =?utf-8?B?WTJYRGtCeGpQT0gxSnhMMEd2MHhZdms5TGllZ2YvYUZxNjc2NWZvUFc2RjJw?=
 =?utf-8?B?VklFZ3RRZDZwSjI4WU1hcHpqaVlRV0MyMmFZQ1Q4TWN5ZVlHc25JeVozM3p5?=
 =?utf-8?B?L2x6Y3daTmZpUVByUDVEOWxXUVArU1FpOFNIZU1mdUtUUEZ6NHV0SHZUbTBE?=
 =?utf-8?B?NVFnRlZoNjRoR2hBd1FWY3BVR2M4cnRsSTl3WTBzVnhYZGQ5OW5xc1FScVFp?=
 =?utf-8?B?YnpIdzkrbWpjYStaUHhrQm5pMEYrRHZSMGFHWFdxa0IrRUlzcjBiUFN2S0FH?=
 =?utf-8?B?NUJ1dVNNVFZ0aHpQclJCckVDTG5MbmFYdm5kVHhIK0tPbElBMWZwcThjZitv?=
 =?utf-8?B?Z1lPWWxPVkRVWjQ2ajVlMFBvZUMvRDlURkNyVDRMNWtrc1NmeGp0UVpjRVRQ?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719b5409-e963-42f0-c5e4-08dc2193bdae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 13:02:40.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 155nDPuWHMEu4mVpqcM96gSPfyozNDv9C2hQY/vIUQuXsGY6krCZAd73GZDPTU6S0YxkCt+zJ0+2vnqqQtPhxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339


On 29/01/2024 17:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.3 release.
> There are 346 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.7:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.7.3-rc1-g7c05c677b6ca
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

