Return-Path: <linux-kernel+bounces-50053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1B8473C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C51A28D896
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF01474A2;
	Fri,  2 Feb 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0nlOBE81"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876F179A5;
	Fri,  2 Feb 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889311; cv=fail; b=bwBDWwb+DCd8qcv3KORYrXkTNoNgvvzYnn2vUOqlJSd+cDuPcJs29ThSKp6LxkGrm6dQTc/6ITqE74pirw7d/GLWevgWzHftT4KAl3kc7dIAP5UAHTPSj4kK6CJlZ7opMzyvzj4mi5Zqt3hoK6La7pbd6LmKGpTqYiY4UFT1oQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889311; c=relaxed/simple;
	bh=z9wNJIt0HavkhNtS7u86wWKoRehxUFQoVpDrOs6THR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LLxX++2RqNhwfrP6z9OgX3D3dnfh6G9KsZDZXXfHar8ykqXIbfiuIAmrQbJBw2ZzLMWLIBTWzy/Ex+Rc/YA89xN3D54u+GKAa3f8n5V63P/Ab1EiPxCFJ7EUlNR/uXiuUjZdFBszqH7aYQWsKF8+o7XA+2oSFW5ysQNiRDE/OY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0nlOBE81; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjpXxDbb6a0BWU8d9z+tqJzjPtKZ4Xezf8iMuX+iSGbNdVzteQIisRycvyM+fA08KVHACnaLkLEspCDF9ek9afnwqtsPbn6Y3yuokHXt0yi5WjaqN9/Sq2gC4rXQXUNN5FvFGbCwmHXTkLh8QBnURBbBHIvfxbfSwh4oUKXqz0qaybuYMP8e6ztQljfSlf82KkhFL4AefNo1dnTgXiw9aigVxF4l4r2iSASi/7P8+tBQ0g2aBAc0HOvDqwpkpvtN/l5+4oZ8lt9IdBIvO6Ml+kn4XQb/iUoZ2InPhHMrc3X3NKaxKCJsZ8hIg3BYF3QF0aJSTNOmIuI9PWJDMgmIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZigCM6X244C0dqouNRYpAL9Vl5cCbYO8LpQF18642tU=;
 b=dNdPaRRvfjvCvHqqKcePButF/zUpav70+irI6cwHv+wbdvUKND+E0Zz30nPjtDIPGMM+ZccFTb1wQwIlGFsp88NAqHk80UdkQfuxwKvhJPbYG23mfJPvr+9aBPL7g3QV0A+c9uzBgGac4PaD80e1evFNZ1JTUUdib6sUSsbQrjsEriotzvlf5WwCmpZres+rpsazYbcgMa8kvws0+18bxZDkGpjQbRe1hpkgj1cfpzO0eXf273CSOJuQOdmfWc43sq0AfL0MxAddlZRDfAodfziJYjpCSbtUIuUoy5eVhIYcIdIPDdOH/JfpgXBnLs0D/hNoCGofskBPQRStJNpgSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZigCM6X244C0dqouNRYpAL9Vl5cCbYO8LpQF18642tU=;
 b=0nlOBE81PXnLnppENGWQroDOrZZBmRmkHrPBgrPj6i3Npfb+xhRAiDApF7v/pa0N38MRspSs5s+N8We3cws7yALJsLIpWJSPhS2xL3bJMoYCiVfRQ0JCq7lidJG7T8CWHgzoJIeopoRkQYdrEnQQAEo2lFkBPMsJ/H0abm1m+D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Fri, 2 Feb
 2024 15:55:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 15:55:06 +0000
Message-ID: <7b57ceea-f6d6-4d4a-9e3c-8cdcca08121b@amd.com>
Date: Fri, 2 Feb 2024 09:55:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate CPPC
 capabilities missing
Content-Language: en-US
To: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
 "Petkov, Borislav" <Borislav.Petkov@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du, Xiaojian"
 <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1706863981.git.perry.yuan@amd.com>
 <8a55135d10cfc906616d3cd4530f9aac487c5034.1706863981.git.perry.yuan@amd.com>
 <097c6d94-2add-4c59-9ab3-8e8dbc7605c7@amd.com>
 <CYYPR12MB865553ECA464FD9BFA57D1BB9C422@CYYPR12MB8655.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CYYPR12MB865553ECA464FD9BFA57D1BB9C422@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0017.prod.exchangelabs.com (2603:10b6:5:296::22)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BN9PR12MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ab8c71-8f24-44d4-f938-08dc24075328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wb6egDxeGtfg/HgkchmPR2o6qxlnA8Fnb+iZP8paZBAgE893XpOSq/N5yMSubii8UsJnokQO/JVR3cZy7kWIlHc4dnUK3ZAv9jpOAHhInFlhr7ySXj0xv97fBBGAHXMZs1wiLpRuES9FYJgjPOV/opIkiM6hX5QoTqynKau7Hc5YQFkkFhKwWI2WHkO2S4zZBWF2m0VZE+vQLHSyX8T6liHcOr8apk9L7rbUcaeiu8BIYQo5Aid43kbKDQ9sejcXYB0XozfhETFbsokYhQYthQgAXxsviCvU1d5cGvAhJJem/zUNlPadcwTXokOvnZf+srgqleXqywwOHY7K0WbBrUZsRJz8bX3uKXl/b1Jk9A6U8uDlo01pdGKrYHBNj2B64jiz2KGcnbF/0XZkuLbIc3pkgMPwGMlmiLuBrfMOdTUbQ9CAWaMGb3H3juyQsDb4arDfDhz4lV8L81hvIqezr2pmbCAuq8yV4VCDzQ3eMs5fK/6OpQb9+RRmoN80LG2jubx28yPSw3TZFDfzthj3jOdSBnjR3leSuICcwfPP51XgeeXQBA220owh7Xu96323bPEsvQMd0BGFeTqH2TZsb/OS23crVHc+6pniE4AEEdnBb+Px0xUPEYt0iymjbTjjbCM6bhEX0NpGX6V2ZgliI57A9Pp7Vo8c3ppi1zFeDpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(921011)(31686004)(2906002)(478600001)(5660300002)(44832011)(83380400001)(36756003)(316002)(66476007)(54906003)(66946007)(8936002)(8676002)(6636002)(6512007)(6506007)(31696002)(6486002)(86362001)(66556008)(4326008)(53546011)(6666004)(2616005)(110136005)(38100700002)(41300700001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmtjN2o0cVg2a3U5L1VBeDZVb3ZjVWR5bS9ocmQzRTZnZitRQlgwR0EzZ0Ri?=
 =?utf-8?B?bUVjbTFDdWp4cGdmZnVJekdTaGJOWmxPRnZNTnhlMHdFeWVJSXNFdndpVUta?=
 =?utf-8?B?RXF4amZHM3VmMnF4YStNUkdLcE9oZ3hDWTNyYlFiZ2R4aGJCQlRrdWtKQ2ZF?=
 =?utf-8?B?KzZ3OGJsWjVLOWxsRnk0WDRHcmQrSXFtZVUyOStRMzF1ZHFYSnhVeWIxMmRx?=
 =?utf-8?B?VTEvQTV4QmduZnV6Q016QzJrTjY4UG5tT2NSNmpmbzRMekhCL0hlSHF3RENB?=
 =?utf-8?B?cTNQYUdMSk1tMFNwUjBOWUFoeTBRbnBVMGRXMGZtelQzQy9lSlVZUXh1T2RK?=
 =?utf-8?B?WnhGNi8zZVVzYzdrUG52dU05SEQ2Vmp3eTFES1RhalNoVmZ3VUVSZ0E4ZlFW?=
 =?utf-8?B?M1Q4NFRTNU43QXFBd20yYWh5aTNIdHBheDF4VE5CUXBubmt2a1FlRTBMNytm?=
 =?utf-8?B?cG9INXRwbU5WRmhsT0NpYW04ZkxMdjRCcmdaWnJnSlphQU5lK0NPSjB0cThP?=
 =?utf-8?B?RWs2UzhLTmpOa254Y0hMYnA4QlhtM0Q3QmM4U09oQStQQlZ0WThZQ0pSQjVi?=
 =?utf-8?B?Tk9pd05kSmhLL0hJMmZzWXVBMDNOQTNXL2ZsRVl2ME96UldrVWlnY1RWOVEv?=
 =?utf-8?B?UlR6TE1naEtZaGJmVXZOV3ByZm0zZldNYkY0Q21Gbjg2NjAxVmRiRE04cmdl?=
 =?utf-8?B?UzRxam0vYUZ2TTdWenlQMndPVm1Fb2tNeDM4NGdTODhQeVhPYk45T3NhV3p6?=
 =?utf-8?B?U29mck9ZYUkrcmY0a2lkaWN4dVBoaTQ4Y3FnSUtoM0xFT2hlNGVQNkI4cDRx?=
 =?utf-8?B?Zyt3OTVNS0xrRHRHYllDQXkyTmdBa1hYY2VwTU8yaW0vZzlCaHZnQkZmb1lr?=
 =?utf-8?B?VXo1N1FRQkJxc1k5WC95K0dxTFVlcGgzdzZEZFVJL1A0dE1aRHQvT0J1WTVa?=
 =?utf-8?B?cE55TDlzempIU1FhakVhZEJGOEJISG5ZRmh3eXpZckxadlVZSHNVQmNzSGhr?=
 =?utf-8?B?dS9rOU1UK3lCNkxGUWdSbFcyWkVpZEIxbWxHVmgrR1htNUVlQ3MvelF6TTlP?=
 =?utf-8?B?RDMrY0liWDNqcGNyRG5GS3o2eHFQWi8yeG5FUUR0dWJqOWRvSHFlTW1ucHRj?=
 =?utf-8?B?cmVFUm9VWnpFTnl5UUV4eWZ2RFk3clZWSitRN1JWVkJvU3M5dHQrOEJreHlL?=
 =?utf-8?B?ZG02QmFvOTMyQkxkOTg1MUZtWFRVTk42Yys4aG90dVhHdGlTMUpKUUdVTk1J?=
 =?utf-8?B?TkFsQXVmM0k4QWNmNDUzZHhNOG1GOG56MWVFcDA5RDgrU0hOWjhOb2VoWUs5?=
 =?utf-8?B?L2xPKys0b0dpVkVsVGtsUXhIbEpNcjdIT1Vtd2hlLzZjVm02cGU3dFpyblp4?=
 =?utf-8?B?T3VERnpoR0pkY1JhV1hNNXMwSzY2TTFPc21lMWdzQmhkbDk3QW1Pa0xGVDBG?=
 =?utf-8?B?THBDemhaNXpMRkdhd0NYV0x4RFhOdW9PWGNOK0d2YlJpdmFzNHJwK3o1RDg5?=
 =?utf-8?B?a21tQ1VqUi8vV0xnUkkrZ3ZJbE1vK3RWWEdPT05hOHFPOVVBcTNZUUptTDRj?=
 =?utf-8?B?M0hZQWFQODF4Zk1uN2ZqeEdnR29GdE9YRkhQR0ZXUGR5QlFMZ3Q1Vmt2RitS?=
 =?utf-8?B?T215ZThyZnUyWFNSQi94clkyN2NoZDhMM2xVbGg0bVBiUE1PekpIVFV4aVRM?=
 =?utf-8?B?QjFnRTVoaWNIaWhMMUI0aEVhNGJmQm8ySHF5VGJydnJlTCtwaEZDWlNoSzVC?=
 =?utf-8?B?VUVsRDZmZStTTmlNbWFEeS9jUlJqcTZCQThhY09RVFRTZm9obGpMOURIcU52?=
 =?utf-8?B?L3VsaEFHUU9WdWdYVVRBYlBqQ25SSE94SWRMUE5ZdURpbjdwUHpTZnVqVjRC?=
 =?utf-8?B?YXNiN3BvZ3B0VGhxTkdidFRVdmxRajlEQVZHS0FhUXQrbUlUOGVoYkQ5a3gw?=
 =?utf-8?B?TUlKUjBGRmVqUEdBNkdGMVoxeVZIcTIyaTZYenlTZE9JbFlqS2MwMnFOcDV5?=
 =?utf-8?B?L0Qrc0lmb3dCR2QzNmJNMkEybVN6bGhTbEh5MklaL0hWenV3c3diVHZuMlcr?=
 =?utf-8?B?K2RaVWdaUVRSNXVnNzYzVWx2R0JFZlBFNjFRZDRybUdkTStUZzA1YU1XaFZN?=
 =?utf-8?Q?l5anoEOAMgc6Uvv8iq+MlXNJe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ab8c71-8f24-44d4-f938-08dc24075328
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:55:06.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE1gqq+ToRjoYRRCTQRWQ1N1DtUxSAVYBjIMYFNN3Txu6hkhZlkhyUymZD6naRwjLQr5QZZJ3jEjKnfVuOyhmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050

On 2/2/2024 09:35, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
>   Hi Mario,
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Friday, February 2, 2024 11:17 PM
>> To: Yuan, Perry <Perry.Yuan@amd.com>; rafael.j.wysocki@intel.com;
>> viresh.kumar@linaro.org; Huang, Ray <Ray.Huang@amd.com>; Shenoy,
>> Gautham Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
>> <Borislav.Petkov@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
>> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
>> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 6/6] cpufreq:amd-pstate: add quirk for the pstate
>> CPPC capabilities missing
>>
>> On 2/2/2024 02:55, Perry Yuan wrote:
>>> Add quirk table to get CPPC capabilities issue fixed by providing
>>> correct perf or frequency values while driver loading.
>>>
>>> If CPPC capabilities are not defined in the ACPI tables or wrongly
>>> defined by platform firmware, it needs to use quick to get those
>>> issues fixed with correct workaround values to make pstate driver can
>>> be loaded even though there are CPPC capabilities errors.
>>>
>>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>>> ---
>>>    drivers/cpufreq/amd-pstate.c | 49
>> ++++++++++++++++++++++++++++++++++--
>>>    include/linux/amd-pstate.h   |  6 +++++
>>>    2 files changed, 53 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate.c
>>> b/drivers/cpufreq/amd-pstate.c index 77effc3caf6c..4d426516abb9 100644
>>> --- a/drivers/cpufreq/amd-pstate.c
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
>>>    static int cppc_state = AMD_PSTATE_UNDEFINED;
>>>    static bool cppc_enabled;
>>>    static bool amd_pstate_prefcore = true;
>>> +static struct quirk_entry *quirks;
>>>
>>>    /*
>>>     * AMD Energy Preference Performance (EPP) @@ -111,6 +112,33 @@
>>> static unsigned int epp_values[] = {
>>>
>>>    typedef int (*cppc_mode_transition_fn)(int);
>>>
>>> +static struct quirk_entry quirk_amd_7k62 = {
>>> +   .nominal_freq = 2600,
>>> +   .lowest_freq = 550,
>>> +};
>>> +
>>> +static int __init dmi_matched(const struct dmi_system_id *dmi) {
>>> +   quirks = dmi->driver_data;
>>> +   pr_info("hardware type %s found\n", dmi->ident);
>>> +
>>> +   return 1;
>>> +}
>>> +
>>> +static const struct dmi_system_id amd_pstate_quirks_table[] __initconst
>> = {
>>> +   {
>>> +           .callback = dmi_matched,
>>> +           .ident = "AMD EPYC 7K62",
>>> +           .matches = {
>>> +                   DMI_MATCH(DMI_PRODUCT_VERSION, "C1"),
>>> +                   DMI_MATCH(DMI_PRODUCT_SERIAL,
>> "FX19911000028")
>>
>> I saw your response to v1, but really this is too narrow for upstream.
>> It's literally applying to a SINGLE system.
>>
>> I feel the rest of the patch is fine, but we shouldn't be adding single system
>> quirks.
> 
> How about change to match the BIOS version ?
> Actually, the issue should be impacting all the systems which have the same broken BIOS.
> 

Yeah it does sound like a BIOS defect; so this is a reasonable 
alternative.  Just make sure that you only apply it to the necessary 
systems with this change.

> Perry.
> 
> 
>>
>>> +           },
>>> +           .driver_data = &quirk_amd_7k62,
>>> +   },
>>> +   {}
>>> +};
>>> +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
>>> +
>>>    static inline int get_mode_idx_from_str(const char *str, size_t size)
>>>    {
>>>      int i;
>>> @@ -600,13 +628,19 @@ static void amd_pstate_adjust_perf(unsigned int
>> cpu,
>>>    static int amd_get_min_freq(struct amd_cpudata *cpudata)
>>>    {
>>>      struct cppc_perf_caps cppc_perf;
>>> +   u32 lowest_freq;
>>>
>>>      int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>      if (ret)
>>>              return ret;
>>>
>>> +   if (quirks && quirks->lowest_freq)
>>> +           lowest_freq = quirks->lowest_freq;
>>> +   else
>>> +           lowest_freq = cppc_perf.lowest_freq;
>>> +
>>>      /* Switch to khz */
>>> -   return cppc_perf.lowest_freq * 1000;
>>> +   return lowest_freq * 1000;
>>>    }
>>>
>>>    static int amd_get_max_freq(struct amd_cpudata *cpudata) @@ -635,12
>>> +669,18 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
>>>    static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
>>>    {
>>>      struct cppc_perf_caps cppc_perf;
>>> +   u32 nominal_freq;
>>>
>>>      int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>>>      if (ret)
>>>              return ret;
>>>
>>> -   return cppc_perf.nominal_freq;
>>> +   if (quirks && quirks->nominal_freq)
>>> +           nominal_freq = quirks->nominal_freq;
>>> +   else
>>> +           nominal_freq = cppc_perf.nominal_freq;
>>> +
>>> +   return nominal_freq;
>>>    }
>>>
>>>    static int amd_get_lowest_nonlinear_freq(struct amd_cpudata
>>> *cpudata) @@ -1672,6 +1712,11 @@ static int __init amd_pstate_init(void)
>>>      if (cpufreq_get_current_driver())
>>>              return -EEXIST;
>>>
>>> +   quirks = NULL;
>>> +
>>> +   /* check if this machine need CPPC quirks */
>>> +   dmi_check_system(amd_pstate_quirks_table);
>>> +
>>>      switch (cppc_state) {
>>>      case AMD_PSTATE_UNDEFINED:
>>>              /* Disable on the following configs by default:
>>> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
>>> index d21838835abd..7b2cbb892fd9 100644
>>> --- a/include/linux/amd-pstate.h
>>> +++ b/include/linux/amd-pstate.h
>>> @@ -124,4 +124,10 @@ static const char * const
>> amd_pstate_mode_string[] = {
>>>      [AMD_PSTATE_GUIDED]      = "guided",
>>>      NULL,
>>>    };
>>> +
>>> +struct quirk_entry {
>>> +   u32 nominal_freq;
>>> +   u32 lowest_freq;
>>> +};
>>> +
>>>    #endif /* _LINUX_AMD_PSTATE_H */
> 


