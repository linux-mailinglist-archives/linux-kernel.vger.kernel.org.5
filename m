Return-Path: <linux-kernel+bounces-147489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0A8A7523
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F1C283E25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61AB13958E;
	Tue, 16 Apr 2024 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7FM7HC0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92F1386AC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297255; cv=fail; b=guYs5J6aPM0/o13MAgGKbu1ar5NNjOa9T4X1C0i8M2udaSvBWKAM9ugGASomGJWUTztnOeIbCaz3WqHgTOzYaiU0KFv3dogPlcTZ1xueQQBSLe7rVxEvCLQ4MpvziKQdEPWriYdXJIaqe7KztV404vwsuIhRMSOkp7gVrBlgRp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297255; c=relaxed/simple;
	bh=iJHMKsoGMJORBQJEXL4KfKiCds4YrsrtxlF5gMMN2Sc=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=TT5kPyjdN3l/ffbfn/mKLXV8hEJ4ZNFHlcVPKRfKG5Hkw3No5J42k66UP1QIsTEerSK6M8ZPkcEJzMNy85wLOcXAuaU9y7DGOO0mfN3EMvptx1DbJKhmptiYOFsTmOp26n9mu1zfcedvoDRM/kMC8RJyrevtWknu4BP7Ls0XOm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7FM7HC0; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrzzP673n2358gFE/2s0FbrLB5efRdiePDZ4z7OolhgKCGKdZsztHg1qgFXoBa7ybTTdeBxhZC5GqHOQiHlWrFFLik+HUzgm/fUubTuNQkCIjGDcf7Cm4w2KashxERgs0bgLI8ibp2Pml/u2bxkCWG/6xhAbkiI3mddGvdFPUDM569id7oD/9Zw4tC+DhZKNKz7CdvKylM/RRJ0DEIE8rqvtbHLQ3HFO7kza9EeI+O98hoZG3gf/ieFstf9LuuW2eFT/7eSC/GOWUxX2fzzjOpjMc4vvrI5jsvkrozLGKG2wy9Wti4tjsBvd5cE/QsqeMPqJSApHOpaYFtBcbFMgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWSXEorwitRYBK/7qu1wqcqP6sGbFCjXk8kN3Qym2vc=;
 b=WuReYIjAEQzbYurHWmyOYJrOHOtNu8NpbVNztM9snR1f/tzJ3q8qAIsWTxFeInCIJDUOKb4Ru4Jf8eqdHrsnAKJKFMa5MZ0B0FrqfOD/KKdl6LCRByNtYBHX3rkyfOjan6deguhFxV27QjJRMaIQ+aViuHU9c6uc8fmcZn8ZZKI6tH6bRQFhdOYg5MQIKgtuPeh2/5eeLCbngsP9zz605KJ6INqRm0Zr+bQDMT0YI8RIDUKn6jaMyT8XYJoYC/yrPN3sb2Li6OnTeOACSUoEW8JFoR0ouPoSJf5JFuU24ZdgTvUo3GuzBRH+Ga0bSsd6nt+6arYQuFRhoENEC1Yl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWSXEorwitRYBK/7qu1wqcqP6sGbFCjXk8kN3Qym2vc=;
 b=B7FM7HC0PmXDJHxqjvqOa6hpPzyk+Q08MwIB4HnCqA4NuFXS8V8alxLSqi5486VFAsZu+pXfPaPywss+gk9ViQxDQTSmTeIHUyM+xnCp3vy4mq2gT1z4aKjSi8DPIjKeJkSMyy2A53bQ675V4MJFfsCFOvtFkOc4PHpEywZ5LqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:54:10 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 19:54:10 +0000
Message-ID: <3cb02504-4854-8bc6-7962-e590e656856d@amd.com>
Date: Tue, 16 Apr 2024 14:54:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joel Becker <jlbec@evilplan.org>,
 Christoph Hellwig <hch@lst.de>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
 <661e10a01f1d8_4d561294d0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <7fc4e7d4-dfa8-b626-76c7-1f8993304a2d@amd.com>
 <661ec2968fa55_4d56129470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 12/14] fs/configfs: Add a callback to determine
 attribute visibility
In-Reply-To: <661ec2968fa55_4d56129470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::18) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 04843fba-54df-4b2b-7a50-08dc5e4efbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QnGz9jeaK2hVYk2kSfAOITWfuMq5oKh2vodOgsra56JbUwXv0POfoWxl865YswaiWsOq7VrJpVuv/CmKxxN+XX0eB0hVtw86TRcCdptUulnuWNKl6Rl8R1/B4iPvmdoWNd86XsEkPLq9xbOGYy9vXZyOOwVEo11CdlPBiSbRf8ndgpR3DpkRZSaNAkiJqxHSkxrHxcuEt+hnt+gYE8F/9lGe6uBwM143hxvJuzMvjBICP9PeW/C2T/bpdPQjSxgEAVKuYXS+TTGutoka5TxgeGVOiBtyOYFvqtbQumlf6RVKWm+Dt+hGFM8ogvnbnz8Y01zAW+rA02I53RYNtknopS6aRWhyjdePo0up1Z3SkmnGTtph/e9zOaSNbH4lk2TOF+sbpMrEItGIkv3V7cn4e4lSO2Lpyo6b8igsiyO8ybadYd6RSJouzSD3OIC6wTOCctX5oPfRtNmTfWqSKjMBfN4qHVtvk/3/XFLmvz3OtzZUQjmDU3se6p2l+KNDD08WJ3i22Wp4tmwXd/v1xm+Sy8BFjWrm6ks1NkqR8UocbyneiKx2ek/vJ23JUR+TE4u7UsXKpemyGTxa+w6NMtrdNaGFQwaRHVeSG9LCWLSBHvx+jRPTQaOqQWYI0frFfzdbGBgr3Jevqxsuk5wlDAr2Fd8lCk0Bys1J/xaFZ7HOYeE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUp5SnpJOHRzZGw3T3NQTUNVZlp4ajRDVUx6STV1R0IwbGE1bXpxMGNHQy84?=
 =?utf-8?B?U1RhUEJFQm1sTGoyYVhLNjF3VEhPU0JVYmEzWCtVL2F2L2tlbS9oek5kY3Zt?=
 =?utf-8?B?V0lkMmpNbko0VjRPTGRUU0RNQWhneENwQ1BoVnpscXkyMWdCemdPUEc3aTg4?=
 =?utf-8?B?Q3RIL0VDS3ZtWFZPTGU1amxpOHRpZy9nY3ErTVREQ1VibHAwR0pZOEFpempR?=
 =?utf-8?B?WTJVbmhlRldkNUhVWWRvNEZFWE1vckNzTCt3RXZZak9SOHhKYWJhRnl0bTJr?=
 =?utf-8?B?aHJFSERiYlViVFQrc2Q0Yy9udjZXK3ZoNkRjSzVxNXhMazF4dUdieFdKOTd4?=
 =?utf-8?B?Wmgxa1p6TUs0cjdRTkJuMnN5alg4VllsK0tTTUVHMlQ1OTFVZGxuU2VuMGcx?=
 =?utf-8?B?N0t4eWJDZ083eWt4YzhhOFpBbnI0bmU4OFA2SDd2TUdCZjAzaFMyNUUrcitE?=
 =?utf-8?B?S3dOZGtxdGx6RlFTdm5HNWdhVmw0WXdyWVlBNXB4eFcwQUMveVRmVUFCekUx?=
 =?utf-8?B?NnRlUHF3MDhtSzFEeGg4TzRva281U0V1eHN6amlrRDNKdjFRQ0FpZDZmckZT?=
 =?utf-8?B?dERhVXZqOTRaNHBpWmdoY0pxYmNuc3B5R2tTZVpmSjVHbEs3TEhHMEROak1t?=
 =?utf-8?B?MVJBenYwUjJWN2dDZGQwSEFvQW15Z1pQVnJrMGs3dTRaZFpkOC9uaDZIYk52?=
 =?utf-8?B?VHB5a1YwRCtabWNpNzgvbkcrVWYzb05BT3JQbzgrRlNUbE1Pd28wVFFMbUdJ?=
 =?utf-8?B?VStIcFl5ZXZBdm5pV3I4YXBHTkd6ZS93VCtqL0pWdjNvVW9yNWgrbm5xdi9N?=
 =?utf-8?B?cVFGSVROOHpzSzZZRndDT2x3dk5nSzdmMXdKTWdqdlRKWFRCTlpVQ1UzRXh1?=
 =?utf-8?B?bFNwcWtyNUpWUHRsNnBZRXRGOUlHOHZ1YXFIbDllUi8xUFlZSEhqODVleGcv?=
 =?utf-8?B?bnB1UzZYMkcvWVhRNlVTMGZQb2RQejJWVVY2UkI2VDNNb3JGMk41RGRYeWJG?=
 =?utf-8?B?VUsyeDJhdldBWkZVcURIdFlVbCtjc1hxanVUSCtnaHJrbk1RMzVzMC9TSTJj?=
 =?utf-8?B?RE5NOENGNHZ1L2ZIc2wrajkzaXRzckdxbGorZVlNcWdULzZ5anNVRXo2SlZ0?=
 =?utf-8?B?MEE2ZVlKeHlZN1hGK2RqU043dkxFd2FoNDZoTVlGMkN5L3Vic2JoRUE4Nnpa?=
 =?utf-8?B?UGx6M0dySGhRYk9WMHVVcVAxb2RCSlFuTnIzdVcxQVNNZjRucE1aRzUxUVEr?=
 =?utf-8?B?Tlp5QzZSbW8wbURNOTVNTXQyMTVhRmtoUTRlRktmdGdxWmRvU2ZOa0ZFNTRw?=
 =?utf-8?B?YWcwSDdXa1NJM05CUTZDMEdVOWJtZ2ttZkpmalZFRTBpM0NaT3h3Qzh4YUJO?=
 =?utf-8?B?bVc0cDZCNzh2MUlGNVJEaVdBQUJtd2VKRnZBMisvNkN1blo2RkI4enhNQmJM?=
 =?utf-8?B?WTBvM3BraGNHM1MvSTM3RUZhNlJFeE55NkRjcmt4SzBmL1hOcnlWS3lRQUlq?=
 =?utf-8?B?Q3VmV3Q0dXZ0ak15d0tjWEo1SDEwT0lSRlZDdDAydmFpWkNjYm9FTkZvbHQ3?=
 =?utf-8?B?cDE2aGxZWTFTZU85dUxFcTM0aksvK1RtSnFNVUZjT3E5MGo4MnRFeTg1bnFJ?=
 =?utf-8?B?ZU44ZHRkeHdBS2E2b2NoVWI3akxCald5bkFFWk9IR0dkZHUxSEJZVlEwcDJZ?=
 =?utf-8?B?b1lhMHI5RWd2WkM3UXpTcFphUlo5VXRSZHAyU2t4QjQwUktGTURSOGpKVVhH?=
 =?utf-8?B?VHBMMkdYR3BxWHNMWTFTVVZsb2o5bHNNeWt1MGRuNjRmcXpXSlF3ZEdLdXpH?=
 =?utf-8?B?OEk5Wld1K1NZOG9pMWlBbVdHMCtoaW53L2JSRXR6RlpIZ2F0WUJaMnhLc0NM?=
 =?utf-8?B?WW9YWHFpWGxUQnNjcEhhSzR2SXJhQ3FFZXprM3F3OVpJczE3SW93Z2EwVE4w?=
 =?utf-8?B?blg2SHV3aVRneXRqeVQvek0xSlVXby9xZWFsbkFzMnc0K0pJSG9qMHRybWlj?=
 =?utf-8?B?bUtXR01RaHRlaSttMTY0K3ZtaU1ycnBqZktReUY1dHNKVkJYTVJFM2R2WUFZ?=
 =?utf-8?B?VVV4SmlCNjdyS2NBMkRGalVkTjM0ZEI3SVFSdFhvRk91VWdzOGRaUytIZXZV?=
 =?utf-8?Q?IJMBQFw5EuZj2qlmi23I+3Sar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04843fba-54df-4b2b-7a50-08dc5e4efbb2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:54:10.4249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvIQy1gYJWAhtds6BfmlamF1GIcVWZF7u0hqYb0APKjEwX0IpYhPPfZb0rLY1RXo7P7LuCThW8tKPmHpR7/FYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

On 4/16/24 13:25, Dan Williams wrote:
> Tom Lendacky wrote:
>> On 4/16/24 00:46, Dan Williams wrote:
>>> Tom Lendacky wrote:
>>>> In order to support dynamic decisions as to whether an attribute should be
>>>> created, add a callback that returns a bool to indicate whether the
>>>> attribute should be display. If no callback is registered, the attribute
> [..]
>>>> Cc: Joel Becker <jlbec@evilplan.org>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>>> ---
>>>>    fs/configfs/file.c       |   7 +++
>>>>    include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
>>>>    2 files changed, 84 insertions(+), 34 deletions(-)
>>>>
> [..]
>>>> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
>>>> index 2606711adb18..c836d7bc7c9e 100644
>>>> --- a/include/linux/configfs.h
>>>> +++ b/include/linux/configfs.h
>>>> @@ -116,35 +116,57 @@ struct configfs_attribute {
>>>>    	const char		*ca_name;
>>>>    	struct module 		*ca_owner;
>>>>    	umode_t			ca_mode;
>>>> +	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
>>>>    	ssize_t (*show)(struct config_item *, char *);
>>>>    	ssize_t (*store)(struct config_item *, const char *, size_t);
>>>>    };
>>>>    
>>>> -#define CONFIGFS_ATTR(_pfx, _name)			\
>>>> +#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
>>>>    static struct configfs_attribute _pfx##attr_##_name = {	\
>>>>    	.ca_name	= __stringify(_name),		\
>>>>    	.ca_mode	= S_IRUGO | S_IWUSR,		\
>>>>    	.ca_owner	= THIS_MODULE,			\
>>>> +	.is_visible	= _vis,				\
>>>>    	.show		= _pfx##_name##_show,		\
>>>>    	.store		= _pfx##_name##_store,		\
>>>
>>> Shouldn't this operation live in configfs_group_operations? That would
>>> mirror the sysfs organization, and likely saves some memory.
>>
>> I suppose it can, but then you lose the grouping of attributes within
>> the same directory, right? A configfs group will result in moving the
>> entries into a subdirectory, right? If we go with the group level, then
>> we will be moving the existing TSM extra attributes and the new TSM SVSM
>> attributes into new, separate sub-directories.
> 
> I am not following the concern about "losing the grouping"? Here is what
> I was thinking with having the visibility routines in group operations.
> This is just the broard strokes, it compiles, but still needs the finer
> detail work to make tdx-guest skip all the attributes that do not apply
> to it.  Might need to be broken up a bit more, but hopefully conveys the
> idea. Does this address your grouping concern?

Yes and no. Basically the is_visible()/is_bin_visible() callback will 
have to check every index value for a "group" against the passed in 
value. I was trying to group the values together using an enum in order 
to make it a bit easier and more readable in the callback. Adding 
another attribute to the group requires updates in multiple places. But 
thats just how I was looking at it. I can also see where you might want 
to selectively hide/show entries and this method works well for that.

I'll follow this approach (add you as Co-developed-by: or Suggested-by:, 
whichever you prefer) and submit a v4.

Thanks,
Tom

> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 87f241825bc3..39b8455f0ba5 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -968,7 +968,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>   	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>   
> -	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
> +	ret = tsm_register(&sev_tsm_ops, snp_dev);
>   	if (ret)
>   		goto e_free_cert_data;
>   
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..654d20ea524a 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -301,7 +301,7 @@ static int __init tdx_guest_init(void)
>   		goto free_misc;
>   	}
>   
> -	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
> +	ret = tsm_register(&tdx_tsm_ops, NULL);
>   	if (ret)
>   		goto free_quote;
>   
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index d1c2db83a8ca..b31be0e61728 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -14,7 +14,6 @@
>   
>   static struct tsm_provider {
>   	const struct tsm_ops *ops;
> -	const struct config_item_type *type;
>   	void *data;
>   } provider;
>   static DECLARE_RWSEM(tsm_rwsem);
> @@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
>   }
>   CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
>   
> -#define TSM_DEFAULT_ATTRS() \
> -	&tsm_report_attr_generation, \
> -	&tsm_report_attr_provider
> -
>   static struct configfs_attribute *tsm_report_attrs[] = {
> -	TSM_DEFAULT_ATTRS(),
> -	NULL,
> -};
> -
> -static struct configfs_attribute *tsm_report_extra_attrs[] = {
> -	TSM_DEFAULT_ATTRS(),
> -	&tsm_report_attr_privlevel,
> -	&tsm_report_attr_privlevel_floor,
> +	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
> +	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
> +	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
> +	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
>   	NULL,
>   };
>   
> -#define TSM_DEFAULT_BIN_ATTRS() \
> -	&tsm_report_attr_inblob, \
> -	&tsm_report_attr_outblob
> -
>   static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
> -	TSM_DEFAULT_BIN_ATTRS(),
> -	NULL,
> -};
> -
> -static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
> -	TSM_DEFAULT_BIN_ATTRS(),
> -	&tsm_report_attr_auxblob,
> +	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
> +	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
> +	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
>   	NULL,
>   };
>   
> @@ -297,21 +280,12 @@ static struct configfs_item_operations tsm_report_item_ops = {
>   	.release = tsm_report_item_release,
>   };
>   
> -const struct config_item_type tsm_report_default_type = {
> +static const struct config_item_type tsm_report_type = {
>   	.ct_owner = THIS_MODULE,
>   	.ct_bin_attrs = tsm_report_bin_attrs,
>   	.ct_attrs = tsm_report_attrs,
>   	.ct_item_ops = &tsm_report_item_ops,
>   };
> -EXPORT_SYMBOL_GPL(tsm_report_default_type);
> -
> -const struct config_item_type tsm_report_extra_type = {
> -	.ct_owner = THIS_MODULE,
> -	.ct_bin_attrs = tsm_report_bin_extra_attrs,
> -	.ct_attrs = tsm_report_extra_attrs,
> -	.ct_item_ops = &tsm_report_item_ops,
> -};
> -EXPORT_SYMBOL_GPL(tsm_report_extra_type);
>   
>   static struct config_item *tsm_report_make_item(struct config_group *group,
>   						const char *name)
> @@ -326,12 +300,38 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
>   	if (!state)
>   		return ERR_PTR(-ENOMEM);
>   
> -	config_item_init_type_name(&state->cfg, name, provider.type);
> +	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
>   	return &state->cfg;
>   }
>   
> +static bool tsm_report_attr_visible(struct configfs_attribute *attr, int n)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return false;
> +
> +	if (!provider.ops->is_visible)
> +		return true;
> +
> +	return provider.ops->is_visible(n);
> +}
> +
> +static bool tsm_report_bin_attr_visible(struct configfs_bin_attribute *attr,
> +					int n)
> +{
> +	if (!provider.ops)
> +		return false;
> +
> +	if (!provider.ops->is_bin_visible)
> +		return true;
> +
> +	return provider.ops->is_bin_visible(n);
> +}
> +
>   static struct configfs_group_operations tsm_report_group_ops = {
>   	.make_item = tsm_report_make_item,
> +	.is_visible = tsm_report_attr_visible,
> +	.is_bin_visible = tsm_report_bin_attr_visible,
>   };
>   
>   static const struct config_item_type tsm_reports_type = {
> @@ -353,16 +353,10 @@ static struct configfs_subsystem tsm_configfs = {
>   	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>   };
>   
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -		 const struct config_item_type *type)
> +int tsm_register(const struct tsm_ops *ops, void *priv)
>   {
>   	const struct tsm_ops *conflict;
>   
> -	if (!type)
> -		type = &tsm_report_default_type;
> -	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
> -		return -EINVAL;
> -
>   	guard(rwsem_write)(&tsm_rwsem);
>   	conflict = provider.ops;
>   	if (conflict) {
> @@ -372,7 +366,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>   
>   	provider.ops = ops;
>   	provider.data = priv;
> -	provider.type = type;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
> @@ -384,7 +377,6 @@ int tsm_unregister(const struct tsm_ops *ops)
>   		return -EBUSY;
>   	provider.ops = NULL;
>   	provider.data = NULL;
> -	provider.type = NULL;
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 18677cd4e62f..213e88f4cec2 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
>   static int populate_attrs(struct config_item *item)
>   {
>   	const struct config_item_type *t = item->ci_type;
> +	struct configfs_group_operations *ops = t->ct_group_ops;
>   	struct configfs_attribute *attr;
>   	struct configfs_bin_attribute *bin_attr;
>   	int error = 0;
> @@ -589,12 +590,17 @@ static int populate_attrs(struct config_item *item)
>   		return -EINVAL;
>   	if (t->ct_attrs) {
>   		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
> +			if (ops && ops->is_visible && !ops->is_visible(attr, i))
> +				continue;
>   			if ((error = configfs_create_file(item, attr)))
>   				break;
>   		}
>   	}
>   	if (t->ct_bin_attrs) {
>   		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
> +			if (ops && ops->is_bin_visible &&
> +			    !ops->is_bin_visible(bin_attr, i))
> +				continue;
>   			error = configfs_create_bin_file(item, bin_attr);
>   			if (error)
>   				break;
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 0ad32150611e..356d23b6b9cf 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -444,7 +444,8 @@ const struct file_operations configfs_bin_file_operations = {
>    *	@attr:	atrribute descriptor.
>    */
>   
> -int configfs_create_file(struct config_item * item, const struct configfs_attribute * attr)
> +int configfs_create_file(struct config_item *item,
> +			 const struct configfs_attribute *attr)
>   {
>   	struct dentry *dir = item->ci_dentry;
>   	struct configfs_dirent *parent_sd = dir->d_fsdata;
> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> index 2606711adb18..31553f12db7c 100644
> --- a/include/linux/configfs.h
> +++ b/include/linux/configfs.h
> @@ -216,6 +216,8 @@ struct configfs_group_operations {
>   	struct config_group *(*make_group)(struct config_group *group, const char *name);
>   	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
>   	void (*drop_item)(struct config_group *group, struct config_item *item);
> +	bool (*is_visible)(struct configfs_attribute *attr, int n);
> +	bool (*is_bin_visible)(struct configfs_bin_attribute *attr, int n);
>   };
>   
>   struct configfs_subsystem {
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index de8324a2223c..a45b12943223 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -42,6 +42,19 @@ struct tsm_report {
>   	u8 *auxblob;
>   };
>   
> +enum tsm_attr_index {
> +	TSM_REPORT_GENERATION,
> +	TSM_REPORT_PROVIDER,
> +	TSM_REPORT_PRIVLEVEL,
> +	TSM_REPORT_PRIVLEVEL_FLOOR,
> +};
> +
> +enum tsm_bin_attr_index {
> +	TSM_REPORT_INBLOB,
> +	TSM_REPORT_OUTBLOB,
> +	TSM_REPORT_AUXBLOB,
> +};
> +
>   /**
>    * struct tsm_ops - attributes and operations for tsm instances
>    * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
> @@ -55,15 +68,11 @@ struct tsm_report {
>   struct tsm_ops {
>   	const char *name;
>   	const unsigned int privlevel_floor;
> +	bool (*is_visible)(enum tsm_attr_index index);
> +	bool (*is_bin_visible)(enum tsm_bin_attr_index index);
>   	int (*report_new)(struct tsm_report *report, void *data);
>   };
>   
> -extern const struct config_item_type tsm_report_default_type;
> -
> -/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
> -extern const struct config_item_type tsm_report_extra_type;
> -
> -int tsm_register(const struct tsm_ops *ops, void *priv,
> -		 const struct config_item_type *type);
> +int tsm_register(const struct tsm_ops *ops, void *priv);
>   int tsm_unregister(const struct tsm_ops *ops);
>   #endif /* __TSM_H */

