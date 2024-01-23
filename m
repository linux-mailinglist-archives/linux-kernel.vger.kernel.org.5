Return-Path: <linux-kernel+bounces-35567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBA83935C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BAB1F22110
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D7C605CB;
	Tue, 23 Jan 2024 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOpOgjKe"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A2605C0;
	Tue, 23 Jan 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024138; cv=fail; b=BIXMsiGDinXbOTcyNpuqEkvgjt2YpOyLWtaXuOfUs11gpl+s3i8fBvBJBgbYPG3TpCade3A4IFEs22ybGQsS78ev4GfiQB3BZd0FcFq/0/ZqZ6JLQq+8skaZpvKcrieKvw2dsGU0PmIZ8GA1yTRx+3ysQbyeRwEFoa7IXaJHtVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024138; c=relaxed/simple;
	bh=p88129RiMKS5r4JrnWnRvk6aaBSzwufrv3mnUSqWGjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0V/7shMZT5er6v+X1Gv59+NObNGeZsqgP3iwei79O350zE0Q13ciGekZjRgAKg6t0vbaOh5Lgb1EGEvTcwU1Dw3lSZLzKFXcr7TxW8Tu7aYmN36W4tCgTD5TA4bjbiRGI5s7lzDTdv3rl3jI/j3RIme6qpC+TlI9RtJSCFrVmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOpOgjKe; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP879DMwhsvjQd0gYuNP3pMgCK7erzPuNnWKvfFRs6yQSma3C7Qw7snlnD9gFortgbWYtTRsoS8NIezYYWLBneTI325mjczhNAYkoUENev4AWQnKv0kO+xHcgvcIsMpK+AL3/iZWYptAqJzX8wQdEEKYnXUZrRDcnQw4/+ZGK5B0FzHM2o9k1XFHwrbcjyM3/GjI1WT1AnYJq014D9d6huhOmwb4n9zPRMWJjr8A7W5Rz2+IO7aBNS9BtY1f1TtwoxpoY4nZS8fv4AhjIY6yHQVnkcvHqVdAcRKABXOwmWk5CyNfQx6IryLISuhiGhcY+K8+0IuN1N7RIWzOfYSVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeyHFmfcQNL16FEKpfPEcHtuywCNf4iWEYF9Rxm6Gv4=;
 b=l+kkAiDkpjxv5BLAWeWg76FoQXPOLdx10Nf51yu3RoF26sKLi0nX/t/ex7cIr75xC9cxbn2z9ztf8o9gQlvgMljT9sp+GmSFPiwFvLzlo7zR1xw6GgkJctHJOyXPNCNSp8bXTrlfq1BWWq23qbcSOWODx8CgAFvr494mG9LFQyh+NTVpIsMwXkV9ZRPMpG65KcsQe9AHrrB2dA/B06p2/P3gDx9TNuXLEKrNZVidu3fZHo9t+Bujg6kkaPjUGKqm/0KPHoIAzCBu0IFzCGNz3nNIeCdglz4ddQnB7YVgZ61rQLGHzmbJgIf4gIruWIxN12WdtaG6nvd/99uQxtZmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeyHFmfcQNL16FEKpfPEcHtuywCNf4iWEYF9Rxm6Gv4=;
 b=aOpOgjKerkoLXIoepsyPIkXJZjkDs9wAv3MmZgvp8VMKKhL/F6gTtZGMLiV93J5arBRBd911oF5t8VUkpzJu/r8JUKrS2A/h4HYTGalXcU9oGq+K0wPbkw1I5zESrLvofLR+ts0HNnU941vj5OvTmwtkWWHF09r9IDPZ3SfsP4TPUaxmb5QGNBXhrhFR3G9Lk53oNP5/gfu08whBcuHSqH+JtuLRi0aQyrkOH2aLH7+FWxiyUmX+o5qwfeY3K6OFeqY0U7stazzr8Edzg5A0vwDXlV7w5Ltco0F6dSTTWAny1heCDtNQcDgNPWMmbdWQlEagHutx9Mq4bnogACnC5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Tue, 23 Jan 2024 15:35:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 15:35:32 +0000
Message-ID: <29eb6dc6-8fdf-48b6-8f60-1162da175b7c@nvidia.com>
Date: Tue, 23 Jan 2024 15:35:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/374] 5.15.148-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240122235744.598274724@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f73e486-cc81-4d53-a6ea-08dc1c28ef1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1adEfJEw527HNm9+FCPwGbAiXEFu0sBA3eHINXjnYtMOJ6AyqWfKsI+43Jli6N3XsB3NUGQH5sexjO7NJ4awU+98XWk9sGScQ8tp9zzCY7RQQnlDqB53E49WEDiG10jr4LfgHCcFzPBghgUmvjA+eP8J7FEZXIPsUCNnyWwHQN85nJVbmZCNX7Md+Apng5roJSnonoCBJsGpjtL+UGWNSuwCqBadAkp9amHufIYgsP2TKGSTpD/CXkPyLfseWAa4oCi9bFJNhaPmSEkaIwq4LhRTGG2wXRCRDVYRDFH68AbN7owZE88OH27dDDZuOMpwclDyeiTBqiV6E5q4x9kN6HVesJt4JVl7Uiks6YCotynya29RCYTOzja189o5QAMzcp7UVGA4enN7Z7Etg7GC3a/dG3WeIUmkvDwVXYePCqUU6kZ+HpRFbTYBxt055+b5N9kWODNameU0P5y4xGHX1ChEFEPdVdUkgXBZGfSqYAAprYwAH/jC6gcfU3/iTzL/4DdyMyfJOe42Egzgd1zAJkJxsNLYgzUEJmz5SIQw/QswbXIiv7vSTxz9xjPXaZTAV+EITQCkQyf9CwM3gZNDb1EByh4rkotN/e1p30QdXICMFuxS6/VOiB8XSuWosQ2Jv2Nu8TlVWE0sP9HywWaNYAXup8nNclc91fybrO8kXUXKve7qf/1c6V7ZwGC3oyBp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(4326008)(8676002)(8936002)(7416002)(6506007)(316002)(478600001)(53546011)(6486002)(2616005)(45080400002)(31696002)(2906002)(41300700001)(86362001)(26005)(36756003)(6512007)(6666004)(55236004)(31686004)(66946007)(966005)(83380400001)(5660300002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTZNZlFHcHdtOWhadkp4WmZ4NnRUMHNsWHN5UHc3U1VaTE5ZbW8rYUhzeTl6?=
 =?utf-8?B?cEh0NmUrZEQrV0VPUkRSMEkxUzBuMGlMcjZtdy9tYnVRLzBobE1ibWRkMTFm?=
 =?utf-8?B?bzNRU1hqQjJScGU0V09UMnJnM0FEVXc5Y1hNbWVEM1E4MU1RaVI0ZXlIZ2xC?=
 =?utf-8?B?SVNWN1JrS3NCQ2xoQ3FzK0w1Sy9tOUpSU0RZRERueDlHUVlhMnl0Zys5eG5M?=
 =?utf-8?B?VzI5VEFOQXpZNjJyU3ZQOVorK0xCZ2ErMCtlaXRialo0cGhndDJwTitPVnQ2?=
 =?utf-8?B?Y1R0ZE5uWklrUWx6b2JCbENTQXlBWDZWWTNOMHM4M2xUZXRraFVEQWs1VUta?=
 =?utf-8?B?S2M3MlBsMHFHRUhDVmNxVFdFWDlCZ0prYWlXdjBaTUZkdHk3UERWaDgrVVZK?=
 =?utf-8?B?OEdoYURkZjVDMVNQZTlXUExtczNhR3pTRVg2b3FPRFFEK2o1Zmxyc3dqN2cy?=
 =?utf-8?B?RXhNYUpxV25Oay9ja1RFRFVmV1ZrOU9HOFdHQkE3Y3NiTEFJU3JtL29IM3o4?=
 =?utf-8?B?SzZqbm1ITW82RHRxSVArN2lTZW4zM2R1ejdtdCswRUl6N2xua0RkM1laRlAr?=
 =?utf-8?B?QnRERzVLK0hVa0lRaitYM2w3L0dPUlpVOENLWGN1R2lxSTVpUG9JU3lIYXY1?=
 =?utf-8?B?RFczbGt1MUg1T01IWFUrNFFqWmZ1MjdoRG9WMnJmUmpLb1JEcWNXNFdFMyty?=
 =?utf-8?B?aEdVckZYMlNsMTNmTER4eldOeDFJZ1pWVlhoeTZnNGh6cmRWZXJFSVZ2Y250?=
 =?utf-8?B?SGxwTmFSc3VUNzZZd3AxTDIrWVZqMkFvRFllR3llclFrR1RpNHhQbDZmNWZi?=
 =?utf-8?B?dnR2M1lraCtBRHZ4aXZVRWErcmtnSXZoNE9DV2YzOXRlVHRtblpsVG1pMWdJ?=
 =?utf-8?B?QnVvS3RmRlFPcUhNUEJCcklkVDk0OFlCZU4zY0pVc25wcWUvdEJCMmZzMkNn?=
 =?utf-8?B?UHV4bFI1M05TZEpaeFFYQzBWS0ZibEJrMFloQlBZQVFTdklDcVVBZTR0SWdJ?=
 =?utf-8?B?WWFEOXBCcTRVVEJBYnM0azJCNjcvMFNlRndUaisyK3lNL2ZvdTRhQXlybTJX?=
 =?utf-8?B?RWkrN3VxR3EzcWQwa2VVcnpLNjhSOVN4eWkrWm9CRWRNOUU4aXhtZTJCZmsr?=
 =?utf-8?B?OG90UTJPV0R5eWt0MnN0MTdDK3BpVy90ZWF5NUVKSTFicU9PM2ordDJSQ0NG?=
 =?utf-8?B?anp2Snl1bSs3UUYxNVIwT0VpNlVxMnlpRlU0L3BEYjZuakMzbVlmMG0yTHVm?=
 =?utf-8?B?bDZJMFRUVjFiMkZjOU5qQzk5cVpTU1hYQTdnY3dzcGlSUW1OTnZkNVlZRXhn?=
 =?utf-8?B?b0pZNTNWdzNUelViUk1aamt5N2JNcG4vTEUwV0ZxUVFQZHhycnZzVTZiOERB?=
 =?utf-8?B?MkJSQ2xLQmI2SkxCdHh5dGxqazlsbzlHNjJXRDhnMCtkOEJGdWlDRTdITUZC?=
 =?utf-8?B?d1J4V2tkRE83VzFwTTdpT3dQNlhUVEJVbHFqNEZXU1Fhd25aSU9iYXdDZnhH?=
 =?utf-8?B?bzF0YXdxWkpJRWRQcC9YdWZ4R1FmZHJxODJCM0w5SE1zeEdIeUtQc3dCQkJK?=
 =?utf-8?B?NnUzc0JRTFduVFlUVUVrWFFLYkNLR3dDZitmUGRIU2xsL3lzRzBZV3g0dTc5?=
 =?utf-8?B?cENHK2VzdzJOeG5EQyt3S0ZLNjVWUUo3dUYzd1BIdDFteEFGczR5YzRINFNG?=
 =?utf-8?B?Zi9jSG9KdkxkcHkwRzlVSG9HZ242N0wzdEpieE9NVXJHYTZVbnlDN0RSUFhw?=
 =?utf-8?B?WGQ3dGg3N1BzSFFnamZ1S3pYWXlkQ3RqQmJkclQySVlBNThzUDArc1FkdHdp?=
 =?utf-8?B?WUxzamo5MlhEVXlmSjdUTGpGYmVpcWw4SUlTWDhxTG5GSjlTTTV2ZjN2UnZI?=
 =?utf-8?B?UVM1cEhJaW00dEhnS1NndFJOU0JRdkY1ekNIanJRRDhiQlhYNFZiUnlOcitj?=
 =?utf-8?B?aVVoZlBxQUkwVnZ4c1p0QnJHMVR1M3lDZGhRMnplNUZINlBuNFpqUnRqWVVX?=
 =?utf-8?B?Y0UvbWNnS081VUl0aHZoVDB4a0VOUzRIeFp3M09LTGk2TXBoRnJ1YXgra1ZU?=
 =?utf-8?B?cWR3Rm03UFYwM0dwemZyTXlFckdIOWRZR1kxdEl6Q3o3MWF6U01DQ2VoQ2lL?=
 =?utf-8?B?WWVybFFVaXFzMlpSUlNXSm10WW4vbjFpcEVYODJwdk9YVDlKTnVEcmN6bysr?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f73e486-cc81-4d53-a6ea-08dc1c28ef1f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:35:32.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwYENTMJHXPOd3poOttg0Lt5C1HlelaE2t1R0VkEykmTSoAJDjV/cNVgg9vZd2E2xn8XRUAW7B8hMEezZdae9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769

Hi Greg,

On 22/01/2024 23:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

..
  
> Douglas Anderson <dianders@chromium.org>
>      r8152: Choose our USB config with choose_configuration() rather than probe()


The above commit is causing a boot regression on the Tegra210 Jetson TX1
board and reverting this commit fixes it. This also happens with
linux-6.1.y, linux-6.6.y and linux-6.7.y. I am not seeing this on the
mainline.


Test results for stable-v5.15:
     10 builds:	10 pass, 0 fail
     28 boots:	26 pass, 2 fail
     74 tests:	74 pass, 0 fail

Linux version:	5.15.148-rc1-g59db9667b9d1
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Boot failures:	tegra210-p2371-2180


Looking at the console I am seeing the following panic ...

[    5.262192] r8152-cfgselector 2-1: reset SuperSpeed USB device number 2 using tegra-xusb
[    5.367566] r8152 2-1:1.0: load rtl8153a-3 v2 02/07/20 successfully
[    5.415902] r8152 2-1:1.0 eth0: v1.12.13
[    5.423122] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    5.431970] Mem abort info:
[    5.434799]   ESR = 0x0000000086000004
[    5.438596]   EC = 0x21: IABT (current EL), IL = 32 bits
[    5.443963]   SET = 0, FnV = 0
[    5.447078]   EA = 0, S1PTW = 0
[    5.450254]   FSC = 0x04: level 0 translation fault
[    5.455160] [0000000000000000] user address but active_mm is swapper
[    5.461551] Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
[    5.467830] Modules linked in:
[    5.470892] CPU: 2 PID: 120 Comm: kworker/2:3 Not tainted 5.15.147-00306-gfca62e959560 #8
[    5.479075] Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
[    5.484995] Workqueue: usb_hub_wq hub_event
[    5.489196] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.496163] pc : 0x0
[    5.498354] lr : usb_probe_device+0x34/0xb8
[    5.502548] sp : ffff80000aad3990
[    5.505863] x29: ffff80000aad3990 x28: ffff0000825810a8 x27: ffff80000a464958
[    5.513015] x26: ffff80000a3190f8 x25: ffff80000a34df50 x24: 0000000000000000
[    5.520163] x23: 0000000000000001 x22: 000000000000001d x21: ffff000082581000
[    5.527309] x20: ffff80000a34d1d0 x19: ffff80000a34d210 x18: 0000000000000000
[    5.534456] x17: 313a312d322f312d x16: 322f326273752f62 x15: 0000000000000001
[    5.541602] x14: 0000000000000002 x13: 00000000000777aa x12: 0000000000000001
[    5.548746] x11: 0000000000000028 x10: 0000000000000001 x9 : 0000000000000228
[    5.555892] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 000000000ef0212c
[    5.563038] x5 : 00ffffffffffffff x4 : ffff80000a34ef88 x3 : 0000000000000000
[    5.570184] x2 : ffffffffffffff00 x1 : 0000000000000000 x0 : ffff000082581000
[    5.577329] Call trace:
[    5.579777]  0x0
[    5.581619]  really_probe+0xb4/0x2e0
[    5.585208]  __driver_probe_device+0x7c/0x120
[    5.589570]  driver_probe_device+0x40/0x130
[    5.593757]  __device_attach_driver+0x94/0xe0
[    5.598120]  bus_for_each_drv+0x70/0xc8
[    5.601963]  __device_attach+0xfc/0x188
[    5.605803]  device_initial_probe+0x10/0x18
[    5.609993]  bus_probe_device+0x94/0xa0
[    5.613833]  device_add+0x4ac/0x838
[    5.617326]  usb_new_device+0x1e4/0x580
[    5.621167]  hub_event+0x918/0x1350
[    5.624658]  process_one_work+0x1f4/0x4c0
[    5.628675]  worker_thread+0x48/0x470
[    5.632342]  kthread+0x120/0x158
[    5.635579]  ret_from_fork+0x10/0x20
[    5.639166] Code: bad PC value
[    5.642224] ---[ end trace f266fb655cdbc485 ]---


Jon

-- 
nvpublic

