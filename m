Return-Path: <linux-kernel+bounces-35634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF39839464
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E56228B69E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B56351D;
	Tue, 23 Jan 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKutlFt+"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094215F54F;
	Tue, 23 Jan 2024 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026324; cv=fail; b=QXnLrNRJQmpxm9C0G4BKwRn2sNXoeTggtmzcr//o81BRTzBE2z99SrBnxnPDX4v6lXZSuibFuRTJ9avhCy2QSV/Q1ZERMMYg9aiVm7stSO2cRZAy3lvu+0sd6RQRNBfJVnGhu+Ifu125szs+/zvzMK5n/z5JtB8SqSKIrY0rOls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026324; c=relaxed/simple;
	bh=98TG6EL4PSF1lDNe/N5gqf2mmmpUiWoi+yXDWUIoYu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pkobFSPnz1gNfeyPrt2OxdKkhXqqJzYq7Lye3dWXjDUG9lVEjVCRdi7/OYe9QnUArpYpiEZZVYuv1SkcuMa8rvjP0dXTzTqp15X5uIQ0UbIbKfoI1OAJdm0GuqNXXbLT2fSdE3BRhf6vobCBuJmVK45065LCr7VZDddEcs/j2S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKutlFt+; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPpa/m99in0aTEolD6PLdOLozQQM1Xpbj8hp2xheDh7jGOg7nRU0jdPP6nRuRIE6vTPGRaf8E+t5fbYWGes1LFYWHKeVhqMTOasblw4Xu7BIxR15xZ82Dj2ZBuWYJ8KJOF0bRsStns0QjLkp2UkZrkGlhomLUUWXpCsVBrn1529oIXu5RYoXn02P59/mko9UUXrsGkkWkE9FuH4nqixF8Plev5ZzRI4N7WlGVwEkMcOP/n44sO7TpcBgEABIlf7TQJBFG+HVV+mRj5u0b5x7iireD7mW8WfnXGpmWcHGUxUgJfvkIoZvC+DqAUdVaQluL3fD1ge8F4ZzVrXP8gM6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVsfoyzalIcWjSDHkHvMay1tj34CP4p/CrKQyiLTv9k=;
 b=aY7BQVyDay4Sbv1LxMzVS9vWhi0Hpk3qb0nN2F9/TTv5r4Fp8bbCu2J/sx0utbOhpvPSvw9uI9MzOGPFQ8kOp86uLNuEMT5xFu0Sw52cpUsQ5zxszbVMP/WB2acAvpbCC+tFh7dIopIBRecsEBLXsNZQqTC3FA9j6yCtItwoTq5A6dMvn+tOR3xIsQ5j9NVOmbAEJWqXsDv8OWnn3Bfhj3ttncdjB4Q1ttaz0lSAwevlBQLel/uru7XtmSbCsxXPALINrpoBF+1Tm9WPRhy5rgKAcJj/J0QDfwapAYNob9yjjqJLpB5nH+bxD1F1mDiaM9KRlaNXJnjkBoWD1C4eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVsfoyzalIcWjSDHkHvMay1tj34CP4p/CrKQyiLTv9k=;
 b=nKutlFt+V8Ddu75hn3FtORg4mRY1bSmp/WqathHtiONKBv/N0OOcjZY0VQU115/1JIfgE05QjMO8B4RzlYu0T49AIaPbnsbWsjJq9oE4lebKVnxPumpT1TAv/O2hOTk1hE2eapzboTi4ozGDmfrYf4uhFzVMDdzjFwIinpanuyrRLPGmAwPoNCu+69xhvp3wipHrj+F0fSv0mJdh99UqGAl3h/RFYubgKCQm8sLzcuNCvescB08wmPg6dn+GJs7Tvdxc5Mb0UA2fNWzb/433DXZvcX2DreqlIE5m5Bzc/QQTQHxHa/NdN8pTdF6+3FV+Sbip7/WrbuyPvwBw5/cfig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 16:11:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 16:11:58 +0000
Message-ID: <1d770359-38b4-4fc5-a15e-6b5bce079b9a@nvidia.com>
Date: Tue, 23 Jan 2024 16:11:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/641] 6.7.2-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, linux-tegra@vger.kernel.org,
 stable@vger.kernel.org
References: <20240122235818.091081209@linuxfoundation.org>
 <e42056cf-3570-4126-844b-76de3bc3d729@drhqmail203.nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <e42056cf-3570-4126-844b-76de3bc3d729@drhqmail203.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 6884dcfa-f0c6-4827-56eb-08dc1c2e06ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BZmRcoJpo5GIPeXv3F2CP+v/7dcbxVppypKABOvA9TZInmjXN5sV3RrJ3DMpYxbTF2z3Oah/AP/j5sTXNW0+umFi2lSj753ZUyRH7UgOgUDSg8TvnAilIGqwwLwQtvQM+mC3/MI+CilNoDVlmP1OZEq/72DGUhS0qzyY/iwDDk6bDRjOtdW78WzPRFoeTjc4oHvl97lLwe48FdfzK6Q5aRu0L53l/1So8RhkTlmyH5eKpDJ/HNDn5C4RylmatBZxgmQhuHa4OhYSvtbXiKNn1gbBfJqaSzpfWN6ebTsiwIRQLSF/z3RvgTWlBwZBhxkT1OkuGcXqJ8BLzfiQGTY7YiTuwUqdM0nO6uXj9RBhU/WG934ic/D68rjgkbyFpewcxgpuo2B4jnP7IeCfKoh+9tt6PrOfB8L1BpdksaA0wi67zYJ12+FwZUq14ZJEo22JhzlsMa0i/wndSaNeMS8kRjIBlxy7YFLGy3LEj567H3CDe82XSPf6uRE30GvHDG5fSDR2JJAJjmvidwbiJSIs5s4nVlpAQme1+DLSlFDb7wfy1TlQCjZ/m0tIWTOw0JPCDQFFXAopEOBqclis46bmYyjTllkEXAp+OCvyTU+4LhVrdrf1xclNnVLbgSndjGD8QZJ4feFcyyZqQ2Sapm0h6D1ickY7mvW/Wzi+KlrxeFr02X/M5RnsGxf6GbeYDxn4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(55236004)(8676002)(6506007)(41300700001)(53546011)(6666004)(36756003)(6512007)(2616005)(66476007)(5660300002)(316002)(66556008)(6916009)(66946007)(8936002)(4326008)(7416002)(478600001)(38100700002)(966005)(31696002)(2906002)(6486002)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JicDU5bXpPU25nM05DL04rMTdNTmZjRWkreXhLbDQrSHVkV2pYb3pPUHFm?=
 =?utf-8?B?UkJSeUxIM0xJT1RsTTFhTHhrMkxTTVFiQ2JVeFlBUE4yYXduM3VJdmtNV0ZE?=
 =?utf-8?B?emtEK21MSVQ2c3ZNWlpCL2VXamYrWG5rYzYwOThTbUk1YlVCSFdRamdBbkxz?=
 =?utf-8?B?T3kxaUZiaHpaTE0ralkxdnMrWTdvZmR5aUcydTRWcWhVZlJjeHZsakVIclJ6?=
 =?utf-8?B?VmwrU2p3cG9Rczh3UzVKMFFKSVhJeHk3VU9CTlFydGtkV2V6amZMMjNDZ0Jn?=
 =?utf-8?B?a0EzT0UxNlJyc08zS1B4QURzc29xZzJRTm53VzREdHR3RHVzNzhFc0kvTEJU?=
 =?utf-8?B?WDhDMEFxMFNOckIrejB4Zzh1cjMzRXlVOHVnQXM1ajlncUIzQjdvUlhYdHNp?=
 =?utf-8?B?SVg1M1BtVVY1N2g3b0w2cjYwNUtQSndENWJ3WStpell5NlQxWElBY3lYYS9E?=
 =?utf-8?B?ZzdFNTk5UUxIZW5weFZoOHdmUVdXdTNQK01Cd3RSaHhPdWRUWnY3WGdqZ1E3?=
 =?utf-8?B?SEw4ajFXK1A0My91UzlxTTBBL01PanRWNXFjaVd1ZGRrSFV3Yk1mbjN3S016?=
 =?utf-8?B?Q1FtZDVsdkh4TXMzVnFUQkx0TE42eDBnTGtvaGlYZFdKVUNCTjUzS1FhenlC?=
 =?utf-8?B?Q1dsY2FkcFFtM3NqOW55S2V1ZUgybjVvenZMNHJVN1piOEREc1pmQkc0VExM?=
 =?utf-8?B?V3dHUEh5ZTNlOEhNRVl6YWFKVG02V2srM0dBRjdDWlNBNU1WOWk0R3l1cTdx?=
 =?utf-8?B?S0VvcWI4Mi8rV0hmOTdZU01FUTFvWDUwbGQzcG5NQm84OXIwaU5admYwS1Ex?=
 =?utf-8?B?d2xnRXlkYzZSb2dNa3RwNlF3TkxyWUc2d1N3THNJci8vU1FwaC9ET2lCTnZV?=
 =?utf-8?B?b2krb3FJZ0V3RWVoai9BbzF6Nmt1dCttSlZnYWRFeXJoZmV0Z1dCTFRWUkNr?=
 =?utf-8?B?RWtsM05YSERyYjJ6WGx2a1N0NTJOZjRZRTA1WXE4em5tb01aejhqdElHTHhE?=
 =?utf-8?B?QlMrRlFqYTF2SUI3aDZlbVNaZXBrN2JzUUg4NUVBRGVWQ1NUZGpxZEhBLzhE?=
 =?utf-8?B?TzFaYmpoVjhnaDVYaWYyK08xOGJGRU1BU1ZQT0NQeUx2a0V0b0Y2WHR3aXZo?=
 =?utf-8?B?TC9lZlcwSm5udFpBeUk0TWs2TjRRT05QakhDTFRvT1h4VEwxSGdpc0dwT3BD?=
 =?utf-8?B?dTkrT1hCTEYxU3g1K0w5aDhIZDhaTmk3SUlEenNsVzBTZ2xhZzFiempLTDlS?=
 =?utf-8?B?dTl6RCtVQjVlTG1IMytGcDV4SVJzOVZNUlM1cmF5bitBT0N4OHdLWklESnNu?=
 =?utf-8?B?aGVscVdleWhpcEcvaVJ2QXk1R3puU1FSMGdzRzFZTzVzWUlYTG5uWUdQbzBi?=
 =?utf-8?B?ZWlTVjEyTFh5dFcyZDFzZUVWdzlMU014ZFF0cHE0RDRsNnNybW5PZVRwNkhR?=
 =?utf-8?B?VE5tc2VrNDlFdUptSUVMSVJROXpxdTF0c2QyWFJ5cXEyT1BLS0dhVHZMZVRO?=
 =?utf-8?B?RUVHUGp6WVp5cUxuOG9CTU0ybnJwczZNaldRRGIrTEVaNnNtZ1J0Y0Nqdk5G?=
 =?utf-8?B?U1YxRFhlK1psemFMNDlYUGtPajE1c0RwTVdObXp5QklaTS9rV2twQ0lHU08r?=
 =?utf-8?B?ZVpvM1BMRXF5SVZHUnpQRHJYa1ZPQUh3UnNTRUtSQjFyYnI5V1pMYkc2d3dT?=
 =?utf-8?B?SGRLaVNiWGhCT3k4SHBMdzg1RG5iM29wMmEydTdNTEZBMUkzT3M1eG03emxN?=
 =?utf-8?B?WndzcWVndWpOSk14TzR5ZzA5L0Y1bVptaUtBalRpOHR2K29vaTh6OExTbDRr?=
 =?utf-8?B?Vkw3eG5URDl4Z1MvekZmb3ZaRUlZOC9Qcm1ZU0xTd3pLcW1DKzJqVTU2S2lD?=
 =?utf-8?B?MG84Q0ZXajM3ZjBydjV2T3ZuWkppbmlNVElQL3VFWEVNRzFLYkt1cWFmTlFX?=
 =?utf-8?B?bHpsUEU2aUR4dUNaY3dtcDZORndlQkZraGp5QVVQZklwdjAzWXJTa2M0SlQ1?=
 =?utf-8?B?a0NYQ1RVZXVWMnpJSkVCSDR1N2NPbFpaZE1VSjFkNndtajliS0xUTE5RYmNS?=
 =?utf-8?B?RU5Mdjh3SWZuRWpPV0VLWlpRZ3FETlROMkM1Rk9YRysxSDdDTkxQLy85SmRt?=
 =?utf-8?B?S0dkdFIraFJwM09aVXI1OHlWMHdHeVNoM00vT0Vjc244Q3hHSHNIYkFGUitT?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6884dcfa-f0c6-4827-56eb-08dc1c2e06ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:11:58.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8NO2x3tqePBgBLk3i/1OFe2mRDUaRCydc+sqkRY3K219kRx+q0QWYN4CjieZrgZ+8BY19O9fFhoxc4UIHjFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482


On 23/01/2024 16:10, Jon Hunter wrote:
> On Mon, 22 Jan 2024 15:48:24 -0800, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.7.2 release.
>> There are 641 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Failures detected for Tegra ...
> 
> Test results for stable-v6.7:
>      10 builds:	10 pass, 0 fail
>      28 boots:	26 pass, 2 fail
>      96 tests:	95 pass, 1 fail
> 
> Linux version:	6.7.2-rc1-g8538581d9e8e
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                  tegra20-ventana, tegra210-p2371-2180,
>                  tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Boot failures:	tegra210-p2371-2180

This is a new regression for linux-6.7.y. See linux-5.15.y report.

> Test failures:	tegra186-p2771-0000: pm-system-suspend.sh

This one is a known issue for mainline v6.7.

Jon

-- 
nvpublic

