Return-Path: <linux-kernel+bounces-59899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8684FD1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74683B2B3CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260414174A;
	Fri,  9 Feb 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQLJ7+DB"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40EB7E770;
	Fri,  9 Feb 2024 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507853; cv=fail; b=TDWQg38tDhd3zwgdMcG6dIN7nm6n4HOSXbUIULok7fPq/ZNMDARNkrTviw5c/TcdguqlburL4loYLKYBS13krg2L1HeJEAectdfe0mxiSaaa/sK1+7EinCeQenR7wFWFdqFGVeMfQVZQyidx4X86AKp4OwunGDDycMcxspFwUvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507853; c=relaxed/simple;
	bh=p/6Yt3MjCM4m0ec0qC10i4TDdx33NngdS+P8E2esuak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zu3inXxcshTFo6GIKZuRFw1US2jdnqptGWp/05cFY4/3Ks2NEQl7PGKSKQDEbs8OkfCA/XmUTFU7akD4wBRRf3L1MiKhCXWk2pO8j9zXdIgeNSb6++mAyBsIfaKA68Fv9llogq+vhTuOLpWxFjLyCNWlin0ZAG16cbxiMji4rLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uQLJ7+DB; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrQed4b1/oRBYrwz1auJdHmy85mPX6S2oCvFEQFe3YE7bFd03rF7IMTL0k11bDlU97J1yDvFYNQx0Q/DetgPuo1Ky53MoA7QOiANKExhaED+IvAMsUvdzmIJA1tlefok9w1+wIhv8xtEFtufQKYgdzJpvxVsVp+S9mFnPJ5VofhgO0pi68xj4YAB9SfVs5wyo5CYceuIR5nq8RSnlE7RWLh0fBUAXtLX9It7sEQflgUSyKqJ1Rv0uLIwXcesnp+kcjR8TKQpUWoVhnf+bw+JEh5DynMCxYTjwUqsC8smSCiWzb9JZNAk3KXGgAg5qxE0lIsbS92wVh/QBc0/BXuMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AnGGEGP60RSbcZ8B7B/kawZzUjWtEjk1DyGODXGZlM=;
 b=HlmVhWbG7Y4YCZQAJaKPn6WWzmylZGGccN8rqgA1ua/aYhmYA/E2lo7LUIy7JAUn+kDj2CqZkT4pJ1m8Vtj1awpVTD0suoggB40nuacxNQQlMnj9KohOtgz09oDUKQRTNNYHndNjxFAAe/uFLz5TeR4wFJncDZpNnbR9Of2y5dz6ba8boZ5p7K5n2aPGae1F8q8cb742FG7kMiR+CbkEwwOrf61lvj+sRfuj83eiVmqozS5JG4oUKKQfO1SpMGrG7y79HbFbPCojLtAowbBxU2pphQoh1GrwVl84kC2cfAUPuRZcR/5JnJUhQJCEfKc9yhDVNdGmfQ2utcymVspBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AnGGEGP60RSbcZ8B7B/kawZzUjWtEjk1DyGODXGZlM=;
 b=uQLJ7+DBDE40yV67cBMOYkHutPm6EEtUB12zY2C+3Kq1dP3jmYhZCG6LLSVVtr6on7MuL9jDSMJ/0u5pruSL0R9pkAlxaIP9VL8eml6LhFdESex0hu4jsO7VvZ+FDXhWMOHx2ntC8mri3/uLRT7b5oT/vi/Z5OpO+xqSLrDTQJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Fri, 9 Feb
 2024 19:44:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:44:05 +0000
Message-ID: <0a442338-79bf-4051-a0d4-2b546b8ed42c@amd.com>
Date: Fri, 9 Feb 2024 13:44:02 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 3/8] x86/resctrl: Prepare for non-cache-scoped
 resources
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>,
 Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <20240130222034.37181-4-tony.luck@intel.com>
 <b3e77817-e070-48a7-a92b-630603c81556@amd.com>
 <ZcZ1hxQTjyCoQr5F@agluck-desk3>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZcZ1hxQTjyCoQr5F@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ac5a80-f81a-4c65-1539-08dc29a7796a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QxjDVpaShzO84Ab4Oo4koeSfkqRdLA6wtY2X0T1AqaqWUOuB49A6UWlDgJFFesdg7bJm4yEwwV+NJBoQD1htYNemkqiXbMeTUrCIOe6+7f0ysv7emH/UH2H7IL7tlz8OoF/7R8RPMLXS4GAuZsJFPISIlV84W+Mg8UePw3zmeUaTvb4p9s7qZo6IykcY2RYwGhCIuZdI2ZDn9yFUcUiiHroy+PJPT6z00a+mFJi+AYaSFNkNwMQenkxcA6FTWO61dI3izBzo5Ymwbmp7SJpw7iJ43k0ia1GLcQVLNHGwLbuzB55yxuypwRYLOUJOCdosRqp5ObM6w9VTAjM33pRW6BfWd+FjOKWYnXCbh9u13o2s6O/q4W6ldpWTU0yW5cpLKe3QCW9NpyaBGk7YSclkxob2b34SJ/2lWdlOQt6RAiZOjUcJcV9hPTUAqJwYREM+ba/1qXESt0MAnSaRcfKn50e1BoMWJMZIrCu7VV0WSCr3atpocQZYViWGtlruVY8KhDPDXU+OADSmNIWewJ4BsF96Sv8+KrBBIa+r1+q1nKBBPYyyyIm8qH/mxfWrHcmN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31696002)(86362001)(6486002)(478600001)(26005)(66476007)(66556008)(66946007)(316002)(6916009)(54906003)(2616005)(6666004)(6512007)(53546011)(38100700002)(6506007)(36756003)(41300700001)(31686004)(5660300002)(4744005)(7416002)(2906002)(4326008)(8676002)(8936002)(3450700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjAzcjRoTmg1UmR3OHhpYnhtQVptdXMwTWFrcDRMM1l0Z3BsMkdZbTJmYlY3?=
 =?utf-8?B?dEl6MmNnVTNlekViaWdJMHlKTjE3bE5FRlNNUnprc3l4aVFkVUI2MzAxb0NF?=
 =?utf-8?B?Z3NLNkIzem92SE8wZ0s3RXB0eUZZajRUcjB2WkJ0RW1keFpjanBISHlJUlNZ?=
 =?utf-8?B?R2owKzFKK3ByYlQvM3RMdytFLzdzTHhUaG9HcThrenUxN2w4ZS9FVVNYRXVH?=
 =?utf-8?B?d1h2cnFEZjQzMXZZY0JaWWNqT2IzVGFNaWZ6NHB4ZStQSC91elBwT1JweWpv?=
 =?utf-8?B?eTJqSXRPbHJYY2pjbUhoUEFxc3I1cVo3bzh4TTd5OVNpeU9aSkZ5eGhlVWxO?=
 =?utf-8?B?Q255MlB0b3hlMThhek1YRURpVzA5UTFnbUlJc0VVZVcwZm1ITVljZzN1TDg3?=
 =?utf-8?B?cy9WaWZhbVl3V3dOWFU2eS9hNkdtRXF3M3YvNzczMzFwcyt2aERhQVlxSG5K?=
 =?utf-8?B?ckxOWTR2SWdWcDU4ZTZpaTBKRFVZR0FMaHVNdSt1YkFjSms1T3RkZ1hSdEN6?=
 =?utf-8?B?WDhMaG1jZG1lTUpPL1Z0TzMwYXhrT0t2bnl5M0RkNlpCMldlaFo5WHpEVElC?=
 =?utf-8?B?VWpaTzJ4Q0NLTERQdWNSbC9DekxSVmNTamQwTFZYQUZsOHQ1c0QrbDAxYjdW?=
 =?utf-8?B?MUtFeDRqbmlnOTlTK1NzMVlmKzdWYnd6T2J0RXdxQWNwcHFkOEo5MXk0OHJQ?=
 =?utf-8?B?VkZmMVJDZ3JQZVlTd0E2d1hwaGJ2bENLRXQ0YTJFanFXeXgyUk1mVUNKYWZC?=
 =?utf-8?B?bDFpdHdjMGJCQklGSjhUZkJXUkZZa2FSOHNnVHloMW9aL0hhWU1RWmRyclh1?=
 =?utf-8?B?SzBTYkFiVFZubWZ2bWQ0R1d4U3dadUlYY3BYRHVFU2FyREd5OWd1TkgweThz?=
 =?utf-8?B?SFR1a2lxSHN2dDJVa3FYa2grUTFCL0lsVkJpY3Zqa0k2UXlKcUVHRkFxN1B1?=
 =?utf-8?B?NXdaQk1GeUZ6NFFlN3BsU210MjZ5bU5LWTBDclhIdWFhY1Jzb3djSS8yamJC?=
 =?utf-8?B?WndzVlFoUllsY2sxSUc4alc4Y1NSY0xOV3ZqNjFjL00yWDFKWjJadFZxVUY2?=
 =?utf-8?B?QmU5MlBIQWN2YW1RVmpyaWdBZDMxN3lrY0JEanpBQkw5N0dGVEQzTnAyc3Er?=
 =?utf-8?B?MndrM2Y5WlVrMVR5TWxEMkJONVdWU2tUUll0RFV4UjhzMEgwNFpLeXhQQ0ZH?=
 =?utf-8?B?WktXem02ODk4ZVROMjQ2VkV0VnZjWVlJbkN0SHRBdlhTb3U1aXFYQjNCSFpE?=
 =?utf-8?B?Ym5QejRmOU1ZeVJtQXdRYThWZUxWMEh0MktXSmFRa0lYRlFQRXM2dEFXN2ps?=
 =?utf-8?B?SWYwb040SHI3M2MvSEFnYnNYK015UjRHV2tZNjYrOVdjQUJYOVhGd0JLaklu?=
 =?utf-8?B?VFJDKzdGVGF2NDkram0wZWFhQVlEMVpncW1OVnl0U2JLbUpNYjhQYVhoeC9Q?=
 =?utf-8?B?NUlMdkJZSC9pcFlja1d4REdLTXA2c3RMT2dxcVpSVlpWRmI3eVpFK0kxdFU3?=
 =?utf-8?B?QlZEUyswY3VoSkNUaTNBTUsyTzVkdHhoNVoweDJnTnYvbXZPU3dRMWJzSnVQ?=
 =?utf-8?B?bTNxcGNOaTRSL2Q2U21ycVRhSUY4YnhNbXBvbFc0ZjRFZVZieklJL3hUMVhu?=
 =?utf-8?B?UnVxSzJtWjlUVFVCUmRFYWZUVEJKNTQxUVdDSFlNSTZ0K05GeDh2SDVscjlv?=
 =?utf-8?B?ak1wSHZkUFNpYVE3TTJxSWwvZHNxcitNK0M5blJKdHgxVEhQVGRrdHVOWCsy?=
 =?utf-8?B?dnNYKy91RU9IbzVNeTR5ODJnZm9GY3J6aW5jN1pmell0RFV2QllIZkhkOWVJ?=
 =?utf-8?B?bnNVVUs3NmV0WmxrbWwxZW5SMXdxMHNlUktTWm1VdS9xMTZVbGxlOTFYOVky?=
 =?utf-8?B?TVhnd1RPV05BaDh2S0I3TUl1TVNOazRyR1k3U0huYmpsYVdNMXljMWRnMUNp?=
 =?utf-8?B?ZU5tc0RIQjhvcjFrQlJvNWVWOGFCczFrTWF1RlFYU21ocnhJSFFPM0dkWE9R?=
 =?utf-8?B?R0FGTGNWQ0NwdWN6Tlp1dVJvclpLVzVza2wzb2JMSkV3QklrL3VVQ0xCZHJ6?=
 =?utf-8?B?eit4K2psZHowdUxrdER3VW9EK2dkc1FJVXB6d0ZWNFpLdWQ5U1VDWE5DY2RZ?=
 =?utf-8?Q?o5qjvN5oDZTnPiTh1lFyp7TDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ac5a80-f81a-4c65-1539-08dc29a7796a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:44:05.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGAClGiftz/gMdTjcWF8J11mzISrGlZtJQ0wZNFPNWzzwhGinWvFzGMLCfTrjRau
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067



On 2/9/24 12:57, Tony Luck wrote:
> On Fri, Feb 09, 2024 at 09:28:35AM -0600, Moger, Babu wrote:
>> Hi Tony,
>>
>> On 1/30/24 16:20, Tony Luck wrote:
>>> Not all resources are scoped in line with some level of hardware cache.
>>
>> same level?
> 
> No. "same" isn't what I meant here. If I shuffle this around:
> 
> 	Not all resources are scoped to match the scope of a hardware
> 	cache level.
> 
> Is that more clear?

Sure. Looks good.

-- 
Thanks
Babu Moger

