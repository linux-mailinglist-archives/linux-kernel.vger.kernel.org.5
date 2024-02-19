Return-Path: <linux-kernel+bounces-71791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244985AA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A201C2255D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F847F5A;
	Mon, 19 Feb 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i6JjThjg"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881E45952;
	Mon, 19 Feb 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365651; cv=fail; b=Cc1UNN5g6NXSkxUBS8S/ZlYXdzUAgs4/Hq4V5bVnlV21F8UTUoZ27vieW6YjeEpHbI+JyeKrQAiB4Uf+SaCRSMRZp2gbvq/96BkoHd2VbJH5b3nHE2HtTNDfJPCQiAYtPZvpn8mz49dV02PK5z8a2AIIwKo2Hi1EhFytwdjknxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365651; c=relaxed/simple;
	bh=PDCXIH5NpSSMehJ5RjK/8qOrxgY+d2h4XPGSyyvpznQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2XS4TbMzVdZcqK0ZLHfqqPsYkLQ1GmNiUo14fVFXs6BmAkwu0G9+UTAGExF3lKXrTPksoXvL2pafOr9dZNMNNbeh/044Md/vbqFwdW8o9qJdJdH6WvhRikn6FwMfcw13yS9eECntyu3iKaOyR7lafEKSRH99EvQJud8TE1DKj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i6JjThjg; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVXX7Q2ooahWPq67v3Z5t44oyX3v065WZfPBrwWOAHl/6pxXpOn9UVLTGVWzYZIJXSjha2SHWvn/P45RGrzESlKHZf8hsxfCdI5fm/bcqo1OOeshhcgURDzaEyBGrQPtU698BybUamA+whxk0DaGf0xz/toPOcZL3SaTaRKqTw2JsE0Zv/nZfOyBg8mopszn2SIygAQP9Gy/3uea7/r2EaT8Nvup8pLv3gVBIAmU4N4suPnItmLG2EGAGiHvmxbi0nl26bNP9OGzyD+roijC6loROpsPmFJT4JuhHbKShhQsxu1z3aMpY1goNIgHEbx8Fq7Tm+T0TKz7BAKfzIKF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDBLiJRNm5lALpGF/GlYZlDGyah/RohqnyAtKwDyXBo=;
 b=ZXxalvVN+5UiRlPjd6hg6+vB1UErTyKKdWh6ijjCVOtOBJr1cEUef1IFWGABFcM0p9nGgixFw3U7uSDK2T31bLFNDKStZ9iSrTVcSPCvTzTdZmD56lgs9ahJS7Etee1CBkrAUTr8No8m6178Iz5dzdhNt5MC2+GaLDJ+nBYNALQuO359GAS8buYCSVT8tAqZVxzAt/Sn9w1+akHLSAiCrDmsZJZfsr9Pj6l8H1tmwnPrlyILObHDUAXNM67tpdQ1/0xIttt47acyepzsRzQHURXSs1oqTEpiK+nhyuSI2KbsJHA4SAE/AcJe7r9Rp2AB+n237/8nI5mWiUPRJzxWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDBLiJRNm5lALpGF/GlYZlDGyah/RohqnyAtKwDyXBo=;
 b=i6JjThjgIVind+H2BcDhlHeVHQw9kQRP5Yhx7FIAZ93AJjgdQ3yUTsjZOciem7+ABgf6B4eCbBITQJNJ8mZvMY5fWtd3R8hHMQThYbXdCQsuRipaPhbe2FZCbBNoNxCnzIT/6u+kEGLdPJp48HVi1HDL7BvImfEgk3237x8/s0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Mon, 19 Feb
 2024 18:00:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 18:00:46 +0000
Message-ID: <68ad366a-187e-4b99-a7c2-a7aaf8abbbf3@amd.com>
Date: Mon, 19 Feb 2024 12:00:41 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 "james.morse@arm.com" <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <7c26af23-fa1e-4e01-8088-8fbd9be3d6f3@intel.com>
 <431d6ac4-53cb-2f73-3cda-22616df2f96a@amd.com>
 <4bb63a78-0d0d-47bc-ad65-558af8bc5519@intel.com>
 <51c60991-eb10-40e8-b3ab-676b92b0c662@amd.com>
 <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoChhKJiMAueFtgCTc7ffO++S5DJCySmxqf9ZDmhR9RQapw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0046.namprd12.prod.outlook.com
 (2603:10b6:802:20::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e1328a-4e37-4d1c-0d64-08dc3174b27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DMaZW/gizVRK/NhgWDO+m2xP/ggbw/JMcrpKCNlr7tdvvsGU9lpQpJtWOWplijfEnuSO05fkeyRNJzyEuhAILSBvlG20XrvoEjsEFvHkNFWbZxAoDqaIzRIsG121iWugoObePRn/Cz8CZzk4S7SAo4HUdjDm8vtFeKpCztB5Fsb8OaChEII7R4VMVKc74vKVB6X8SP5Db5O31EfNXEuQmraV34T/8dqjbjTQi8W7imuYrgmQHvDYuP0oa2Z/Ox4NWh/ebXmzeo2vXnIl45t/AIgq7y43LyJnNuCj1vhdVHiqE1BGeLRqoYM+3qG8avxVXzXSmoDbtTYdnP5P6Xyc6saLD+o4IBtIKDtBIWm0A/kuOLwTlG6EtQMPIpoVaDkXznU/taCncaZNDkV+f/jaULuyQVk48S6ZWXeTCqbQ56pykc3RZ/yi3s71MHoPWgmkC9QJ0mvf0py/y3vXIPGwvq76bFElApq/1dVBCZbkHqiwtuem2dN5fOpUH2odYxzm2rgYM1yZsEZ58T+ERHpki9eqKAHTETt+jj7t2eEn/H0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW5HZHN2OSt2R2ppMkRIdjRvOVB2aUE3ZjhrMSt3SWplTVhrVmlxQXpQRTB0?=
 =?utf-8?B?QUZocGtwWTFMSVpVKzZ3YWQwbXFGQjBtYWRaR1kyM0Z3Q2tJVnY2eWZzRUxW?=
 =?utf-8?B?TkNRKzFTYkFwQTd0Mmk5WHlXK2VIcy8yZlVGOTBvVEdqNGtHdDlUbVQxRkk1?=
 =?utf-8?B?WlhnYlJMU0ZXblNGYlJlcCtkTnRpTmZGMUVrWHdMYWlaaTk1ZWVXeThabXhM?=
 =?utf-8?B?elpiQXRpRXZIQlVkVkkxK3hoUXViQzJFR1NkSUkwNTRQcjFuTVJEQnVINDR5?=
 =?utf-8?B?RkVQWEdseGZhWEp6UDkzTHUrcWJkZXVZUHdWK1JFdVpIY3BEZzFTMjliUEQz?=
 =?utf-8?B?N0Zodkk1MDc2THljTEUvQW1MVytrN0YzUzJ4VDJHTWdxWU9IZUNCZG92cXZZ?=
 =?utf-8?B?YnV4NktPa1ZIRkMwR2VKc1ZQWU1wVlhJdUt6bHpCVlJ3Wkt6eitoclpOMnhB?=
 =?utf-8?B?bG1QNnN2bXI0S1UwYjlZOFBaZldJamRHVUlibDB1NVh5a0htSDhtdmxTM3dL?=
 =?utf-8?B?UVRVSFlvUFZXUGZlTG5BK243QWkxenV3OUFxS0FXYVd4elJZbmJueWRnWkNx?=
 =?utf-8?B?OWY1RXIxc0xCMW5oNUk1QVljTGhOVU1sb0xSNlc4MllUVDNMTzkxTFMwVkJG?=
 =?utf-8?B?NWJVejBTdGppdmZYM1U1blZWek1KUXg1dTRUR0pVcjFJQ3BTNWE2UkJRWUxG?=
 =?utf-8?B?RjlBWkMyS3B4WFVhd0lzNHh5QmdMYnpaMVlaajVzTHFIRDJwbDZ5T3UrNXRB?=
 =?utf-8?B?bVlBd1lnWlBpblFMMTFSTHJVYUZlZWptQVA1NVNGMjhrRmtuSkFXWktEODBP?=
 =?utf-8?B?ZG0xYURkMFNSWTBxN2g0OS9IVXNXNnJ5eW00VXQyTVRPVTRKMnl6QWVYbTFU?=
 =?utf-8?B?c1hvWks0YnNpaDAxZG1jbFVLcVlkRlhjRUk3Y1VyZVIyTjVVeUp5WHEzR0hR?=
 =?utf-8?B?bTNackJRYWp2NXhXcDVaZWRWWXJ3QnNlc1ZCZVE2VXlQWDh2YkFVR2Z5elBa?=
 =?utf-8?B?ZmFsampxT2t3NGRXNmN0MnQyYVFNQ24zMENDS0x0dlNOMTl1TExtMk9ZbmVX?=
 =?utf-8?B?VXN3aXNYRmZaQXM4QXlkRWZNSXBqTWtSZzMvcEwvc0c5Mkk0WXFOME9kVFFw?=
 =?utf-8?B?VnduMStreVV1alZqeEwwSndHUGRXQVVhV3hIYU5lOE5uVUFnMlp2OEtDVGk5?=
 =?utf-8?B?bHJzcGlYODRaclY5SXFTTXU0MEQwNHRNdjllMjgwM05HZ20wSWpXaVRxQTVX?=
 =?utf-8?B?blJYbFJxclRXTmtYUHFwVTlyalBVdXNGRUFONHA3a25EMzBVejJRQUNJTUJv?=
 =?utf-8?B?dXA1QU1jVjhXM1RWZWJCbFpCUUh2b3pBU0RjbEd4WXRRVDB5U3ZWYjlvRGVM?=
 =?utf-8?B?SG13VEhyU2hlcm15emJ3ZHdoa3Y5MWJGNCtvVldSNWl3Z1RCWnByYTh6TGFv?=
 =?utf-8?B?cnJ2ai9GOURwUGFNQ21JcDFFNGR1ZWUzd2lpRUJXaE9VOGdEMHY3cTR2WFBw?=
 =?utf-8?B?c2p0OWxBakkzemhsVEM5OC83SmcrSFl4QjdPUzJwa1JhY2IxR1pGbC9MbjYr?=
 =?utf-8?B?WFBFcXhPaFVHckFnQXAxUFZVQ2ZMTzhEN3dBNm0zeHpZN0tha0JXTVdWR0tK?=
 =?utf-8?B?RXIrSlpyNXd5d3c1R3ZBeHR2V2NBYVl6dmJ4dTRoYmc1Z3padkxkd2lpLzYy?=
 =?utf-8?B?cW8rQjFra05GWTA4ZFhDV1pCRHdPWHoyYWhSWlhCdWJCWGFSdjdnUVBGd2VE?=
 =?utf-8?B?OEM1KytWWGNCdDI5eFhzdHgrTFVMeW1Ia0ZZalhYNzFMRGNuWnY2MW03cGc4?=
 =?utf-8?B?S1FSaDdHNk9LZnQ0ZFF2d3M2ZWdhbnZFajNBb3g4eXVoWHErblA5K2t6a0dL?=
 =?utf-8?B?WUZqdVF0UzNwRVRnYzRIZDYrWHdaRGt3TE9rYzVRNkpaWnJsMW9yWXZGS0ky?=
 =?utf-8?B?SEhBcXEyQStVOEVCazdTbm5YeEF6UnRVYXRSWm5YYkJlV3BEeWU1SUtMWHFE?=
 =?utf-8?B?TnNhR2MybXY3Ym1NRjJNZmhjdW5yS3BFL3ZVWHRDOEhFRENlS1lpQVZZT0Ey?=
 =?utf-8?B?TWUvOGlURnAyQ3FJZ0tONFJjRmlwNmpDV2Yvb2JFcS9ScGpCeEJQcHpwUGpa?=
 =?utf-8?Q?tp8U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e1328a-4e37-4d1c-0d64-08dc3174b27c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 18:00:46.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nOCivGBVCJZu2vEHe5s62o3lsyRr7L/p4KQMfa8QwdFxTqjFqAYAq8o+39GsrES
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

Hi Peter,

On 2/16/24 14:18, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Feb 8, 2024 at 9:29 AM Moger, Babu <babu.moger@amd.com> wrote:
>> On 2/5/24 16:38, Reinette Chatre wrote:
>>> This could be improved beyond a binary "enable"/"disable" interface to user space.
>>> For example, the hardware can discover which "mbm counter assign" related feature
>>> (I'm counting the "soft RMID" here as one of the "mbm counter assign" related
>>> features) is supported on the platform and it can be presented to the user like:
>>>
>>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>> [feature_1] feature_2 feature_3
>>
>> How about this?
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>  ABMC:Capable
>>  SOFT-RMID:Capable
>>
>> To enable ABMC
>> # echo ABMC:enable > /sys/fs/resctrl/info/L3_MON/mbm_assign
>>
>> When ABMC is enabled:
>> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>  ABMC:Enable
>>  SOFT-RMID:Capable
> 
> There would be no need to use soft RMIDs on a system that supports
> ABMC, so I can't think of a reason why the underlying implementation
> would matter to our users. The user should only have to request the
> interface where monitors must be assigned manually. The mount would
> succeed if the system has a way to support the interface.

Ok Sure. I will exclude Soft-rmid for this interface.

For now, lets keep this only for ABMC.
# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
ABMC:Capable

Or

# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
ABMC:Enable

> 
> 
>>> You have made it clear on several occasions that you do not intend to support
>>> domain level assignment. That may be ok but the interface you create should
>>> not prevent future support of domain level assignment.
>>>
>>> If my point is not clear, could you please share how this interface is able to
>>> support domain level assignment in the future?
>>>
>>> I am starting to think that we need a file similar to the schemata file
>>> for group and domain level monitor configurations.
>>
>> Something like this?
>>
>> By default
>> #cat /sys/fs/resctrl/monitor_state
>> default:0=total=assign,local=assign;1=total=assign,local=assign
>>
>> With ABMC,
>> #cat /sys/fs/resctrl/monitor_state
>> ABMC:0=total=unassign,local=unassign;1=total=unassign,local=unassign
> 
> The benefit from all the string parsing in this interface is only
> halving the number of monitor_state sysfs writes we'd need compared to
> creating a separate file for mbm_local and mbm_total. Given that our
> use case is to assign the 32 assignable counters to read the bandwidth
> of ~256 monitoring groups, this isn't a substantial gain to help us. I
> think you should just focus on providing the necessary control
> granularity without trying to consolidate writes in this interface. I

Ok. Looks like we need to provide the interface to assign the RMIDs to
individual domains in this interface. I wasn't planning that now. But, it
can be done without much changes.

Something like this(corrected typos: replaced '=' with '-').

#cat /sys/fs/resctrl/monitor_state
ABMC:0=total-unassign,local-unassign;1=total-unassign,local-unassign

To assign:

#echo "ABMC:0=total-assign,local-assign" > /sys/fs/resctrl/monitor_state


> will propose an additional interface below to optimize our use case.
> 
> Whether mbm_total and mbm_local are combined in the group directories
> or not, I don't see why you wouldn't just repeat the same file
> interface in the domain directories for a user needing finer-grained
> controls.

I don't see the need for the same file inside each domain directory in the
group level when the above command can assign the RMIDs per domain.

> 
> 
>>>> Peter, James,
>>>>
>>>> Please comment on what you want achieve in "assignment" based on the features you are working on.
> 
> I prototyped and tested the following additional interface for the
> large-scale, batch use case that we're primarily concerned about:
> 
> info/L3_MON/mbm_{local,total}_bytes_assigned
> 
> Writing a whitespace-delimited list of mongroup directory paths does
> the following:
> 1. unassign all monitors for the given counter
> 2. assigns a monitor to each mongroup referenced in the write
> 3. batches per-domain register updates resulting from the assignments
> into a single IPI for each domain
> 
> This interface allows us to do less sysfs writes and IPIs on systems
> with more assignable monitoring resources, rather than doing more.
> 
> The reference to a mongroup when reading/writing the above node is the
> resctrl-root-relative path to the monitoring group. There is probably
> a more concise way to refer to the groups, but my prototype used
> kernfs_walk_and_get() to locate each rdtgroup struct.
> 
> I would also like to add that in the software-ABMC prototype I made,
> because it's based on assignment of a small number of RMIDs,
> assignment results in all counters being assigned at once. On
> implementations where per-counter assignments aren't possible,
> assignment through such a resource would be allowed to assign more
> resources than explicitly requested.
> 
> This would allow an implementation only capable of global assignment
> to assign resources to all groups when a non-empty string is written
> to the proposed file nodes, and all resources to be unassigned when an
> empty string is written. Reading back from the file nodes would tell
> the user how much was actually assigned.

Yes. This interface can be extended to ABMC as a global assignment option.
If you have your patches ready I can add your patches on top of my ABMC
feature.
Or if you want to add the support later then I will go ahead with current
base ABMC support.
Let me know.
-- 
Thanks
Babu Moger

