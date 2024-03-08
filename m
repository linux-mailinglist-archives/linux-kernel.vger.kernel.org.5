Return-Path: <linux-kernel+bounces-96487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4193875CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B4D1C20B56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB842C6A5;
	Fri,  8 Mar 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uP/LArgZ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F92C68C;
	Fri,  8 Mar 2024 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869829; cv=fail; b=rJDdHt+I3NFSsd3x/MONQX7iaTnJb9UjempGfmCCgg/zULB/lHN9p8ego5/fWcdl24y5pmfgZp6QgyhdrRvUSvdTKhJxTiLOmXEKKl0Lxgcq4s/NpBSSWKfnWG2AH+IMcv3/Fqu9PkkHci7Dx0Mcgcjg7xBpz+24CwTYOYoDEYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869829; c=relaxed/simple;
	bh=JWlG8zORL5l99pGjP60Vo0nAKLPvQn4aQo3ahR2LXNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+AmR26T6wrM4foJgVrWspbS6vZFuBFp5Rt76igs+UE9CSMsurL3BgdGckqNIL9viZ6qbcQV++Pcd/LkhC0yr8XXeye0NuIvhHmzbkxSLGuxeLd2jl4VYNS9Y7briDL9vkCCQAuihSOexlQwLw9SHxSqXeIMYvf76wnVHtq4sxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uP/LArgZ; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+tZRE+8h8tBvNrg0ZAE1PX+ZHHfzYiZ8ffMtRuv+iDyalTNFvwSQOHLohpIfc0p3MaGxvnixSfaRFbAisTlk9Dy6+aeYoYDzQFn3Qdt3cgkS1nrCQUGmRZfpBpqvVMHkEY3g5SVgtBkG79Yi1IIHXOlqHH2vtcg4hFiOZYryp5TMNrcLQJ81cuKLCBe0OKXqGR5rKANS04stFfCoX6v/aUj76911NYj3IVztDvvxQWOpUkJNiktR6HAlCScScjT8uztTD0ZpsAP/GMj3QyBpvd3gGa+TeP1AS0vUinrf/UqnI7ZubzXSEfapM8qIzokAgjDakygWdly9UngWfzuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLFB66ptBouXdSaspxMTHd7p4FsvhBBWCodDG07VQNM=;
 b=QJAYWSDE1X0Zx1vynDTFaHN7uUTnKrZpNY7DhiGRDCfSCkz1LDFeiWNciiFtWf6BCORm7XqW2ZoVfh/tNXkC3QhrOjV5WHLK8qKk+lgDZGH+N/eBKXwwaCmaDUDgYRVL0+KGHvCWWuhzQ2xTyxKKFfDyQnWEMuhssR3Sz8DrQebcDcf9X+WTRDFNRPZpDVS69jHWG9qMjeoXwIVWH0nvTW19iEWSisJ0t2wj3yn5k/lfw8ADcAa6RjnixLx2c+b0hyXSVWMbrHeak9q0848e84bMs5tD1UQpPLxRS20RXMZg7GRFQdqUmAx3+yqiUphiqArPaVbTBYuG9eZx5MOuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLFB66ptBouXdSaspxMTHd7p4FsvhBBWCodDG07VQNM=;
 b=uP/LArgZ7H4fK4E6N4Wah0tz7UTIKhhr3aoMNMfmJ3jBWEdc88IBojmyFWlmUbrR3eeJ5P4lwgKHmgxd6oWsgeHCx2z0OtXFcnI+62E0O0psshHm2OkbJUQ7U5G/UFCkFu1bsvDopXnqXWytyevScM56ygMtf0+MAHSkiTRiq5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:50:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 03:50:25 +0000
Message-ID: <46065d68-8334-4b76-bc68-c2695e7b98de@amd.com>
Date: Thu, 7 Mar 2024 21:50:21 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
Cc: James Morse <james.morse@arm.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <9b94b97e-4a8c-415e-af7a-d3f832592cf9@intel.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
 <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
 <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ceb7943-1314-480b-7da2-08dc3f22e32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Qbf+TvAMNXCLwvH6669FR8O/cSvBRoB6yTDcbjrpi4qPIseCINHPIJhrHpddpdP/eyCAM0MUjSk7Ajk55SBWKdVPE6mniRNl0umZxuV8ur3s0fxa/n85bL5RgsUAJMUuIp+klqMvLlgjU1FYQ7U3WyPTbFC9fwN4n46mWBSCr1Xh17e9Ov2i/+3n/xB7C3L4Ai/zgcsQl4MICyI4TEUWZSHDaqgSBEPBeixHguXg+pW3ChAeV3xyEW8qjbHa5hiLlQTrofk0je16wlxcgONEfO2qJoqLKwjzu9oLdnJo7wHA51pFDmr1RGve7FwG9q28527eJv01YypfKkmXNZ6xqSARGZZNq15VW6EcNvAJ8scDJEAOIxgZjEgrCzn1E+H57vQOD9X8An5wiRJxA0Giu6uz4CY3nJHdy49sBbJ8PCholtTh7ocnqw/wScjhLxiXy2RtdTgF3M/1IcMN/29ae/e3XHBOVmgz0vE7kcTKhYI5bu3MFgBFs5LNVNMsyuJZLkjmzpWDMRl2bPoN9RmmG+dXjLBpsFEEA6IlHf4ETrD0pyNCi0W8Lrm3tCFfnWpnmemhYQRhd4Y0E+IkOUb5RkpDO0T72XSMDYj3s6QjOQHbt6GA9MTyisqfQ/sWYGVTUWP5fC4BkGSuE7nZUvDktd+tnTTjGUX0taK9LpyZmU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VoZ3NmZnJxNE1KWWNSUThwSFVKaDRSSjNQamFMbmVFdlVacGZNVlhYM3Ey?=
 =?utf-8?B?MGs1ZHRPWE1sMWc3VGdVa3UxQWVZTGl4THYvbG5GbUpuSUQxZS9wVktsQkJ5?=
 =?utf-8?B?RUY4ZWEveVNFQnM5WXFrZVdPMytWKzRRM1BEWHMyY3RjZG83S1lRQjdSaHJI?=
 =?utf-8?B?SVhQOWZFUGtuVnhLeEdxeUxSMFdaU0VBVmpCcE9KTlczMXlpKzIxYklEWm5h?=
 =?utf-8?B?eDcrVEdMMzVnR3dIVWhnNDljQnV4TXU4UU1WVDJLWGkwTHFoS2l3c2hWMlVQ?=
 =?utf-8?B?NnVhNXl3UTJnaGdtbzFXYXN4Ump4Yk5wd3RFWEl4SmZwVStTWmpWZXdFUFBq?=
 =?utf-8?B?L1VzdjlHSTVWL2NNWGVJUStiTDc1aVJaSE1LVnlxR05FMkxxR3E0WWw0Skw2?=
 =?utf-8?B?N0Vkdys5ZGRSUkVqVDFpbWhLNlozTjA0NkhTQWdOUjQ1SVhUR2FhTVU2dmxP?=
 =?utf-8?B?aTNmRG5DajNIazRuQ0tpd2pPZmk3Wnlld2pVZmMrcHowVUtlTGo3MnN6ZXRN?=
 =?utf-8?B?ck9ibUdLckJBc3MvbDFPL2FsQnhkenF1K1kzdDhLdFBVNUozWjVQUXRFYnFW?=
 =?utf-8?B?NWJsRFQ0M2VXUU9QVjdpQlJ3Yy92U0dWVWV1WUZjVmRjOUdnTTFJc0lPSXM1?=
 =?utf-8?B?Q0liOS9kVW8velZhbjlCcWZJZWZaK21wN09EM3BrRFRPSEFuS2RHQkdnU1Mz?=
 =?utf-8?B?eUhmNDl1bFFrbkNDN2hDdFVobW9ITlZacHJRMCt0QmxCb09seUw5dFF4dHhx?=
 =?utf-8?B?NWFkbFhNQ1pSalZRNTVhM0J6T01LYnRCcTRkR0ZJdHBnY1FZN0FMNWVsaGs2?=
 =?utf-8?B?Z3JPYnhOeGV1ODdLVUJ3dkdWTEVsUi85S2ZnY21jVmQvQlZqM1VHUk13MTla?=
 =?utf-8?B?NDJCNC9tdG9BM3JOQlcvWWZjMmV1UjcwUXY4Q2FWSzVtQjJLQllVcTEvN01C?=
 =?utf-8?B?V2pXcUwxMDIyNWFEZ2QzdXNINWRlaTNmNWxtdGZpS2U3YVNxM1FTSWEzRU5S?=
 =?utf-8?B?RmFRSjlyZ0NRTzBTT2tlUlFIUjFEdU9CdlAxUVJsMzJGYWRhZEJZTVR6Tzc4?=
 =?utf-8?B?ejJvME1mOGRQSGY0bTY1ZVRqNFc2UC9sSVBxMXpMb0l3MytPNk10cVFwWWly?=
 =?utf-8?B?TXNxWllYVnVNU2YxdXVPQTNwYUJNQUMvVlVxR2ZqMitxWDBVRzYxb1Q5byt2?=
 =?utf-8?B?YXRpV1ZUaEgzdHp0OWZ3OG5IZXF6di9pWkh3a1hxQkdRSy9LdVkzSUJmcm15?=
 =?utf-8?B?WjFFeExKcWt3a1FWeGNRYTdXSy9UYUVsTlJxUWplQjhGbXUxcUlSN3VGMmRI?=
 =?utf-8?B?bnphQ2dNRTVJRDhpYk5wcW1vT2k5OVRRYUpWUytJdUJrVVZmUjI2WkZiNUhD?=
 =?utf-8?B?VDA1dEJLRWRSblIxM2lPeFRmdFJqd2J6bTd5Snl6V3RoVkQxYlFDUEZvNnpW?=
 =?utf-8?B?OW1RaUFVRHRMMzk0bzVRZis3dUhMRHBhVGJNbnpGaTNIWVZiNCtkcVd4eUhn?=
 =?utf-8?B?cDFJRktzbWxmR2RIMXlNbDBxNlZqcG1rVEpidDNMdWRuMzdVSHl5MjZ5WVVM?=
 =?utf-8?B?ZVRaUytzT0l6bXZBZDZOSGhCT0w0MitCQ1dVMERPcGNCKysvUnhMeTd3c3FX?=
 =?utf-8?B?MXgxMVU3Q3k5bktldWV4Mmo0QWpTb01icTFaYktVSmJ4b003eFkvQnQ0TmxX?=
 =?utf-8?B?elArdGxPamN1b0MzOUZrWlFYOThBRmo1eE51OXc2czlEcFF3OHFhR0EyQzJa?=
 =?utf-8?B?Mko1UXdLZFY1OHJNTXJGU01VaDRUREJlY040M042anlPa3lwc1Bia2FONG9P?=
 =?utf-8?B?R3dtV1E0OFZMWTlmVTJEb3FLSjQzbEluQ1hBRTR4WkNmSHpBOThCMjRtTUtS?=
 =?utf-8?B?bXV3TjJla0NiL29waXJJNjlyR3lKRUlpYzhsTzU0MjVKWlUzNWk2MGxKTkky?=
 =?utf-8?B?YUxWUkNxVGE2ZDdKbGRid3U4aElZMGJoRVRsQkZRRDRZRWFmcW9lLzFXdGgw?=
 =?utf-8?B?RlRFSTYzLzUxZVhQNXZrUzB3TXkzbU1INWtCdlhjMFI4MnI3RnpCRFFKZmxn?=
 =?utf-8?B?elowQVp2bE9YM01wMDdxTTAzOUxDNzJsL3JQKzRucUxnL1NoVEdKaVBQbjQ3?=
 =?utf-8?Q?fZIs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceb7943-1314-480b-7da2-08dc3f22e32c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:50:25.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QWDrb2qScjB7Kb3RIZuvU/gdwgppFq2+nDCQhYQvdE1Ab517FRaNVpuF8plHBsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

Hi Reinette/Peter,


On 3/7/24 16:53, Reinette Chatre wrote:
> Hi Peter,
> 
> On 3/7/2024 2:33 PM, Peter Newman wrote:
>> Hi Reinette,
>>
>> On Thu, Mar 7, 2024 at 12:41 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 3/7/2024 10:57 AM, Peter Newman wrote:
>>>> Hi Babu,
>>>>
>>>> On Mon, Mar 4, 2024 at 2:24 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>> Based on our discussion, I am listing few examples here. Let me know if
>>>>> I missed something.
>>>>>
>>>>>    mount  -t resctrl resctrl /sys/fs/resctrl/
>>>>>
>>>>> 1. Assign both local and total counters to default group on domain 0 and 1.
>>>>>     $echo "//00=lt;01=lt" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>
>>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>     //00=lt;01=lt
>>>>>
>>>>> 2. Assign a total event to mon group inside the default group for both
>>>>> domain 0 and 1.
>>>>>
>>>>>     $mkdir /sys/fs/resctrl/mon_groups/mon_a
>>>>>     $echo "/mon_a/00+t;01+t" >
>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>
>>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>     //00=lt;01=lt
>>>>>     /mon_a/00=t;01=t
>>>>>
>>>>> 3. Assign a local event to non-default control mon group both domain 0
>>>>> and 1.
>>>>>     $mkdir /sys/fs/resctrl/ctrl_a
>>>>>     $echo "/ctrl_a/00=l;01=l"  >
>>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>
>>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>     //00=lt;01=lt
>>>>>     /mon_a/00=t;01=t
>>>>>     /ctrl_a/00=l;01=l
>>>>>
>>>>> 4. Assign a both counters to mon group inside another control
>>>>> group(non-default).
>>>>>     $mkdir /sys/fs/resctrl/ctrl_a/mon_ab/
>>>>>     $echo "ctrl_a/mon_ab/00=lt;01=lt" >
>>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_contro
>>>>>
>>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>     //00=lt;01=lt
>>>>>     /mon_a/00=t;01=t
>>>>>     /ctrl_a/00=l;01=l
>>>>>     ctrl_a/mon_ab/00=lt;01=lt
>>>>>
>>>>> 5. Unassign a counter to mon group inside another control
>>>>> group(non-default).
>>>>>     $echo "ctrl_a/mon_ab/00-l;01-l" >
>>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>>>
>>>>>    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>    //00=lt;01=lt
>>>>>    /mon_a/00=t;01=t
>>>>>    /ctrl_a/00=l;01=l
>>>>>    ctrl_a/mon_ab/00=t;01=t
>>>>>
>>>>> 6. Unassign all the counters on a specific group.
>>>>>     $echo "ctrl_a/mon_ab/00=_" >
>>>>> /sys/fs/resctrl/nfo/L3_MON/mbm_assign_control
>>>>>
>>>>>     $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>     //00=lt;01=lt
>>>>>     /mon_a/00=t;01=t
>>>>>     /ctrl_a/00=l;01=l
>>>>>     ctrl_a/mon_ab/00=_;01=_
>>>>
>>>> The use case I'm interested in is iterating 32 counters over 256
>>>> groups[1]. If it's not possible to reassign 32 counters in a single
>>>> write system call, with just one IPI per domain per batch reassignment
>>>> operation, then I don't see any advantage over the original proposal
>>>> with the assignment control file in every group directory. We already
>>>> had fine-grained control placing assign/unassign nodes throughout the
>>>> directory hierarchy, with the scope implicit in the directory
>>>> location.
>>>
>>> The intent of this interface is to support modification of several
>>> groups with a single write. These examples only show impact to a single
>>> group at a time, but multiple groups can be modified by separating
>>> configurations with a "\n". I believe Babu was planning to add some
>>> of these examples in his next iteration since it is not obvious yet.
>>>
>>>>
>>>> The interface I proposed in [1] aims to reduce the per-domain IPIs by
>>>> a factor of the number of counters, rather than sending off 2 rounds
>>>> of IPIs to each domain for each monitoring group.
>>>
>>> I understood the proposed interface appeared to focus on one use case
>>> while the goal is to find an interface to support all requirements.
>>> With this proposed interface it it possible to make large scale changes
>>> with a single sysfs write.
>>
>> Ok I see you requested[1] one such example earlier.
>>
>> From what I've read, is this what you had in mind of reassigning 32
>> counters from the first 16 groups to the next?
>>
>> I had found that it's hard to get a single write() syscall out of a
>> string containing newlines, so I'm using one explicit call:
> 
> Apologies but this is not clear to me, could you please elaborate?
> 
> If you are referring to testing via shell you can try ANSI-C Quoting like:
> 	echo -n $'c1/m1/00=_\nc2/m2/00=_\n'
> 
>>
>> write([mbm_assign_control fd],
>> "/c1/m1/00=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
>> "/c1/m2/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
>> "/c1/m3/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
>> [...]
>> "/c1/m14/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
>> "/c1/m15/00=_;01=_;02=_;03=_;04=_;05=_;06=_;07=_;08=_;09=_;10=_;11=_;12=_;13=_;14=_;15=_\n"
>> "/c1/m16/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
>> "/c1/m17/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
>> "/c1/m18/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
>> [...]
>> "/c1/m30/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n"
>> "/c1/m31/00=lt;01=lt;02=lt;03=lt;04=lt;05=lt;06=lt;07=lt;08=lt;09=lt;10=lt;11=lt;12=lt;13=lt;14=lt;15=lt\n",
>> size);
> 
> (so far no "/" needed as prefix)
> 
> We could also consider some syntax to mean "all domains". For example,
> if no domain given then it can mean "all domains"?

Yea. Sound good to me. Will let you know if there are any troubles when I
start working on it.

I am also thinking about replacing the newline requirement for multiple
groups. Domains separate by "," and groups separate by ";".

Something like this..

"/c1/m1/00=_,01=_;/c1/m2/00=_,01=_;/c1/m3/00=lt,01=lt"

Thoughts?

> So, your example could possibly also be accomplished with a
> 
> 	c1/m1/=_\nc1/m2/=_\nc1/m3/=_\n [...] c1/m16/=lt\nc1/m17/=lt\nc1/m18/=_\n [...]
> 
> Any thoughts?
> 
> Reinette

-- 
Thanks
Babu Moger

