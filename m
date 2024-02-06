Return-Path: <linux-kernel+bounces-55509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596E84BD89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E7B1F28CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2561426B;
	Tue,  6 Feb 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r9t3YaCG"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC014017
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245824; cv=fail; b=jPhloDkVwM8oTwTz+eOmI3TtbcpAgll6P9N0fabOlp9loKPBL+R4MvSy4ZKEm/SCt/ZSViAFQGcjZoyMVdJfI/GZV/X8BjDiwE+VGrzGiVYz1QKSjFf41QLQnLhPWSVivU8t+cIEWMAWDDhuFI+u0me8m6dsrjwwFS41N35A6Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245824; c=relaxed/simple;
	bh=LSfz9daJZDH0+tgvwv5f52dZH9dZnMPkZ1Sz/0IGIB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZDl3+V6p+Y5y7g2WuMgleTT9jYB5fjpHuab3RdO4gFkIku9wQPf5kVIK7MQnc5druObI78XRbINd4SLLKQ35rtk07a3ANRYn2ZYxqB/51b7O8wl8kO3azmTTCmn+dtC/Us3b//Oup4dlR0J/2ehGYaevxWNkrpsXxoGErDXSvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r9t3YaCG; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udg0Brrum8xoLphYrYh/KAFj56jEYOeHg71x1m0xrSyfk7q4oUuJ394nJr9zoViG61Klw/b70cLFKW5Yxb9UybZisgn2B9A76pMiilkLsSagT8dg9Q5c2DR1IsnjMhXJzOtu817VvtT4Ti/ywCbrF7ehhfrvDQkGaHSjkmsPCVDaM6RqM0/J0ThLdHsGoDtfspPgWHyn/uiLs6VWKXMBdS27uybZYRbFnmRHtjXsRqwqPhL+lmo1tATUQVJB1wZlZ3/YkvVaEXlaBu9sk692mF+bCoXm+YQSsOGndQDKLDd1jP+ypXc/X4vX87U5rgy3EhkLjNIBIGjsLWy+aVxZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCcFFrLvD9nHFUNUZr+lenMu3clXMMXCTOJi1TSdaRU=;
 b=AR0/MpslMQfodpCIMrRsY6MjPU5TOpJYK2Llotx+I3uLlVii/phE8SaxEe6kGoGndmMp86raXFOgPooK+ZZU6u//7yY6ioFpPqghlx3xCVZvZgdrwoaG0FvhIIFPAnnH0oiq4BGoGA4t1mrn2/hyaHMsDX3ZPJO35Jn62WasuJevuLFQc5Eo0eu2nwez5zlwDuTicCoybxcvaMC8dSuvaYMxxZTSem7458/IYmSvGLtUYNfztsq3Ce/gKC4fdLnQ7aDmboXdz24YvG9SxuHQFhy35AsyO+6d0UPyLkOYXzhpAzvPR6XVUXJkFZxiJqlXMJFOEU5AydAz6OHQkbNiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCcFFrLvD9nHFUNUZr+lenMu3clXMMXCTOJi1TSdaRU=;
 b=r9t3YaCG4xwMf+coEdPz6SJ5+pfKo/nGFnvDslvMIgUb7hA/vX6GHUFtMDn4zhni6U7nDEPpb6VgDb1j9kjxSOScSyky0N4SikwSss5/FruE49+6PakttKOztvhXtI2/zslQX48Gd+9SbhvtSWrjBlYgxurIpk+xTSmlSH8GKY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 18:57:00 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622%6]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 18:57:00 +0000
Message-ID: <073bad3d-7a4e-43da-b9b4-3123ce1e2da5@amd.com>
Date: Tue, 6 Feb 2024 12:56:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] TDX host: kexec() support
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <c86203a5-0223-4824-888e-76ff9565e178@amd.com>
 <23b05fe0-60c5-4cd4-bfe8-b706c34d23ac@intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <23b05fe0-60c5-4cd4-bfe8-b706c34d23ac@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:8:2b::32) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: b78fc0a5-e46f-46db-bbcc-08dc27456608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UTQLK20bPNJIFflgxi5MgVm1zH7daxcVs6BA7sGh5wDt8oGyx41CBDRTumoLse1NMZ0sWbpQ8+tZhStNjKDjCuVxnpS/ZxAuSCMYUK4GsOhyAES+AfOf2G1Fk5yUGyWR84/lpchDPal9ByFDcG7Gsq9MOXN72+K/7CC491N7SlQCYLQu7CKgIL39v+Oia70GLw9Q0pKRD2R5RcNHKDDCW9paQSy3zCFeGML7wJcaTa7kAL4KD5vw1ZLPkjIqQ60CVkVtB8+brMUsRfJsoOdJIGJVJwd/NQRGo4CKIya4up1sxElqgsoWM125zSFxGaTzl25h8OZvNUVic40rW0IT3c12UP3q7EaRRv5wviKXKjWXGAzkFs9XiCHeAmZPpniXOZXRjFQfuF1L1eXwxj9CKGOQYzQtxuwG8pg6FnCjVfjKbHx84lINSB7pcgANshnLo9z1O70Kc64Xnzew+fUqV6kaILqcJ32ExbXkJI+hObRzom4pY8CW66C8hn4v55PcA+J7aNxBydXnn9rcD9OZtDxMw2pIPW7o549Vv59Sr4ca2wWYiUxRodTlE24yKm/+lWAwOzRBmUHaI/yILCNFs0S7HTFjqKeZwCCiTwsGxrTjaaP3/a6RhPqjUbgEqT5q7GnAseqifzUWVqaJwXXa7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(26005)(86362001)(6506007)(6666004)(8676002)(478600001)(66556008)(4326008)(66946007)(6486002)(2906002)(6512007)(53546011)(7416002)(5660300002)(31696002)(316002)(83380400001)(110136005)(38100700002)(2616005)(31686004)(8936002)(66476007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzROR09xZnRKT01CTXcvOTRRRkE1K2ZxQ1lwODloQnpvVkhHK1B4L3JtWEZD?=
 =?utf-8?B?OU91aFFhcmRYaG5rSncwSFZmOWdiQ0dIWFpPQlVBTTNiKzF1Y0g5emVIQzZo?=
 =?utf-8?B?ZVQzZW1EVVBKUFVsSGRBcXhPZnZUeGxZWUdhUEdXTlFPY1IzVXNlZzVRc3JK?=
 =?utf-8?B?Z3E1Q0ROTzRSdElmM2s0L1pVcVlXcTJadkNsNkhVK29NRjFlakNlZjBodTMz?=
 =?utf-8?B?UndjZk10Y0dMWFVHRlZZeFEwNnNHTDhKUHhQam5BQklLUFRsaEppd3dZd3Bq?=
 =?utf-8?B?NXlOdlZObDFSakJjaVA2VHlEUWd3L0d0SXpDRzVhSlFpcFRId3NYbER3bHpP?=
 =?utf-8?B?SnVIRi83NmpGM01lNytzV25qS083eFQ5b3BGRm9mdndnVzU1RE9vQ0JWOGox?=
 =?utf-8?B?elk3aldFVWdnWUFpeGlEeVZpeksrM0RUQUdDYksydWY3WVVWZW4wYnhGWWhB?=
 =?utf-8?B?SmZybkpIMHI4bGVkUU5MeEI3TXRJbXBLNURSZTJtNW4rSVVqMlJDeFkyZFB6?=
 =?utf-8?B?T3ZsaE9ueGdCU29PeUhDMzl0ZkVpek9HTVhqdlpZcEQ0S2VNR0xWVk9kRHZn?=
 =?utf-8?B?RU9Va25YbkJ3bUtZSnpGYzJoZmNlaWhBN3NkRzlCbFpGZXpYaVJjSzdSOUxL?=
 =?utf-8?B?b1NrcGJ1QTYwMFpndEVLWEpGNlVsNXFJMUh6ZFZ1Q1FVS2ZoQWc5K1EzaExK?=
 =?utf-8?B?L0QzV09FQkpBRHg4T21NbEF3SVUvRGlhWkV2bWVWUjlDOU9NVnBFU0tpZXBJ?=
 =?utf-8?B?aFFoUnl6V3R1Y2NzSFNVNFg1emMwcDVPQ3lmOTlPSzBEWmV4V3dKK1d3QnNG?=
 =?utf-8?B?c0hmM1JEOE1zcnc1TFFXMytjNWpEcWpVc3lEVXBIUG5UaVNmK0pURG5QQi9S?=
 =?utf-8?B?dk5OR2JiVXYrckNOUXZsQ3krbTl3Y1M1czhiNTZnQ3VsamVlTW9WMHVvbmNT?=
 =?utf-8?B?eE5FYXhpN0JBTFUzUFZId2YvMngxSlpwd01oVkhwdytRNEV6ZGdudXh5M3Ev?=
 =?utf-8?B?djhsSWJsMUk0dndGemxvYmdUZXBmbFZEZGhUM3FQZzU0eWkvd1c2czJJY1dM?=
 =?utf-8?B?YyttSUgydTVMblRHMDdFVHBFZHRpSWQyd3RaMjhId3pOZDg1ZkNlalB1Vk8z?=
 =?utf-8?B?NTRtRlA3TjNPTE1hNVBoZExGUDZ6M1BnN1pjK3M5cEdPZ3pwRDFXcmtsVk8z?=
 =?utf-8?B?MHZrOHZqb0FtREtlcGpTMmhCMUMwODkyVlcrSk5ybnU4RDRtN09HZlY5eWJQ?=
 =?utf-8?B?MFd0QXRSQzdTSWdZVDlUcldyVmpib1duNEtnL3dLQnhEYW0wanoxV1FOQUov?=
 =?utf-8?B?clpSUWFpbFhxN0owRUxScnVhNGxPcExKWUUwOVF4cGlPSjN0bnJrNm0zcXor?=
 =?utf-8?B?NCs1MVV0R1pXMUN1ZjFQQ0N2RytjU29BeEVZejhEKzQ0WmMxS3ZTcnMwQXBD?=
 =?utf-8?B?WWtsTGppMzRoVnBNTXVWdkpzM08rd2J2V3ZQSnpLUWRySlBSR2pCMG9FMnZr?=
 =?utf-8?B?M09CR0s3KzkrQzJ5a3Nsdjl3U3QzRU80aHVCSWRybGxZaFZqdmpMUWNPaUNu?=
 =?utf-8?B?SmdOWk5seWgyRUVweFc5MmdqS01kanpwc0RkRHROOGxocmRMbUFTaHgrQmdi?=
 =?utf-8?B?Vko4NDhCOWhvV2U0dXNBcEdlNFNJY29rNjVEc0F6SjgrNk1JKzBXRXV0bzl0?=
 =?utf-8?B?azAvTkgwQUVrVGwyL2h1VWVKRlZxNXl5QWN6ZUttSlRPL1RCWmp5RjZ4alRF?=
 =?utf-8?B?TS83MjlXN2VOMlhnckhlaUhzcWliRHA3UW5hS2tHYTdVZU85eGZtbktjZGlW?=
 =?utf-8?B?SmgzeTQ1WmpRYktRajR2bWs1ZjJGMlYzSjNBUTNsN0VWNXZCb2NJQUhTbEx2?=
 =?utf-8?B?WFFlYVN0eFFrcmdSWTRiQTdvb3JsNHdhQ2lxVmNoOWtvNXp4R1JLd2l5L1Jp?=
 =?utf-8?B?S0J2NGxQemdob2IvSzNqeU5BQmhPZjlUQVV3VEZMVitlckJ0czlBZmxJbUdO?=
 =?utf-8?B?Qko3R21sUUhXZW5mb3E3U1JtUTdXb09FSG5vL1B4QlZwZlJ2a1dMZ0kzZnhP?=
 =?utf-8?B?S0VCN0xwM0pWYlVUaVB3WUFMbWVrMkV5WWxnU3UycTdVTDk5RTY0N2VHazFm?=
 =?utf-8?Q?YthQRN0qhnYgnGpmYCLdhRdrK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78fc0a5-e46f-46db-bbcc-08dc27456608
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:57:00.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlGuIWmapPc9Ro1VLX1XqIVsafQeznzvcF7QXK0e0bN61/POz0gpVJw0wp7dNWOSUxpsiGrS7DOrFApkAdAiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On 2/5/2024 12:50 AM, Huang, Kai wrote:

>
>
> On 2/02/2024 2:28 am, Tom Lendacky wrote:
>> On 1/31/24 05:31, Huang, Kai wrote:
>>> Currently kexec() support and TDX host are muturally exclusive in the
>>> Kconfig.  This series adds the TDX host kexec support so that they can
>>> work together and can be enabled at the same time in the Kconfig.
>>>
>>> This follows Dave's suggestion to add the CC_ATTR_HOST_MEM_INCOHERENT
>>> attribute to unify both Intel and AMD, instead of having Intel/AMD
>>> specific checks around [1].
>>>
>>> Hi Tom,
>>>
>>> I've tested on my TDX testig machine but I don't have AMD machine to
>>> test.  I highly appreciate if you or any AMD guy can help to review
>>> and/or test this series to make sure I didn't break anything.
>>
>> Hi Kai,
>>
>> I'm adding Ashish to the thread to take a look at this as he's been 
>> focusing on kexec related things recently.
>>
>
> Thanks Tom.
>
> Hi Ashish,
>
> I appreciate if you can help to review and test the first patch. Thanks!

Hello Kai,

Yes, i am currently working on SNP guest kexec support on top of 
Kirill's TDX guest kexec patches, i will have a look your patch-set and 
test and review it.

Thanks, Ashish


