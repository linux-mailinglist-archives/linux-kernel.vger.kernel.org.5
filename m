Return-Path: <linux-kernel+bounces-128347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F683895997
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01EB282482
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8E14B06F;
	Tue,  2 Apr 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7ZgyA+4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488714AD30;
	Tue,  2 Apr 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074905; cv=fail; b=XaN19pUB4u792LSTB7ovaEsmyErPL6oargNlfiwI5CFsCL9KdeXRJAAFZng2n9qdP9yMxCIBpBqc0FlAZp8DTpfi5K/4ZGZVk8BVT5HPd02m7cCIkKHgGe1IhfuVJLsy/99/d2CZk8irnom20yEtPwH32ZRO+skmtV6Pqt7wXAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074905; c=relaxed/simple;
	bh=ZBa96lCtTF8UiChX376SWZUQoK/dgqKGGgUwdgbZwBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yi0gjrxWB0NwTd3N+vT4skgMT35Q9In+1MP+kCOLmasfdajJTh3tmPwD7Fc/X0QgGob8j1RXR78ygIiiBXYGC0KI0KFR/0ccgjDDwgS9Otnmfr/jAxLGVHkH6zlwM5tPNnJ3Rdn4kXTDx/2/mcamvnQNjkonOGImZy2CZg9O0I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7ZgyA+4; arc=fail smtp.client-ip=40.107.237.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlBdTbgSsgOEfwAWjAJ9ew6OorGaAVrMJNwJYFBEcqdU+Va9VKDWlD69R0gIoYaCj1cSc9nnhwfeCdBGeeaKC+XXFJ6Ig8Dwy5VeEI5tYd62hzvN2tofw1qYLWkdvWtinFo0nPRFbTGLGHZUqfCgJFPFZ18hXiqCLGrsUdLcIfPV2dkL+gaPq5HG+fw3JAO1HFSbSUfENAjb/L+6PbTy0ncKm9MIKx8CVKVqi0IrVsF60wnf7SgHDW2HFcXsoT+1OUnbG6kYFt8kZkK7tdYmiNhq9Kab+1swZMi6XqZicspVIv7z3uB3WBofOimvEtqhF6cHEvnpdQL3MCyRKb3S1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an589Z13uf+uTUNEwdzluAopzjT4K7N+LVqAkh0TX/U=;
 b=aNl50wKmIyYEM4Y0HrEyQkgH2oHsTUrVpkr5XxBgisVsgWTh6JjE2VRBxRYEOTerygavDGOXlSMWJnbeKIG2S6loTgIgF4SKmky/EzypIdeQLbS4kRxfC36lAko7UI5LRIa2zvSUZqovbH8Lq67I20usFeOYNpFK80EOwP6oBdqTei+nks6HGiFHkuwmOs4/8Ekby39ate87S34Wvhbrl5GKvwKpvGJGmecpUDmGfe4XSAIdFoyy+H57nEdZw9km66nVOSyVR2l8gPQnm9i5afv0cpkSmOpbah3oYRBWp2Ot8mkp0fxG+e4CD2v15RhOK+KUBC+hGXakcQkuEalIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an589Z13uf+uTUNEwdzluAopzjT4K7N+LVqAkh0TX/U=;
 b=a7ZgyA+4zAz/RnfzoRGQYyYZCxIos/1RjoFDTHO60k5131AmMNB7eAbt4LDz5+iFP+m8jNeFuMcMP6cXinbMATuSQD6RhXkC8RnBjghS/r1lcQTVXNgihKcozYvVIw8nt4wuRlSYdgdSXIQn6PRFWVugGXlQNNvk1qgLyYZLYHk=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:21:40 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:21:40 +0000
Message-ID: <70e42f58-b3a9-4df2-913f-2f7b605b127c@amd.com>
Date: Tue, 2 Apr 2024 11:21:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Translate development-process into Spanish
To: Jonathan Corbet <corbet@lwn.net>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, avadnaik@amd.com
References: <20240305221839.2764380-1-avadhut.naik@amd.com>
 <874jcjwyb0.fsf@meer.lwn.net>
Content-Language: en-US
From: "Bilbao, Carlos" <carlos.bilbao@amd.com>
In-Reply-To: <874jcjwyb0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::9) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB7803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wwmwCHncR8jheWYpetPat03+1ZTVciyGDJkRx1CQmO0fCGS+LnNONNWLenSKsAQ4EAj/FcCS1rYoTLinN4LlvZItQQvvXKJvgwxAehW5lzrFbgJgXcDo1gvvg3k5YLhyvmX4iBpO5LhAmveI8SCL9pLqguJJVGGwxKWpOgdG3ClPAbF1IuQE+A1pf7+OFOObC3t11GzEOqOSV+AdiVv3HCAiI0nP/Bd+tjBcmlDqgpnkvCD4XUblhx7eoSzRmF6HbqaG4U3hhCW5WBB6sfjrHkdD29EBUgfI4lab5EMi73n8XQBQyboMMLMXi37nWAt0sd3kbuYgMAHpDr5neW/eNTOwdL33TnHCD+hU94gd4n5kA5TE5JujVeOqjMOvVo39vzLPgxeAaqqbCtfFhHK+HFrwkt2FlKlZJ86gndNGi/AJrXEB8+rWNhkJQzPCangAOnZpL4ZD8958PuhoZTJdNyKHsqzScSKDL7G3adnkruk9ZIlJC2/+8822m6tnICPDDeN3CDmLoyv1CATHOwZ8U0Tyx94XC7oQudTsFq23bqVZ0i78sT4m6yhypiFBA9WRwgh1wjrc9f84ftyD7/1WVxLHal5zx1VeLCcGBfBOtvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1NJZnF2QjRuUDJTSlRRY1hsTWNGenJYVmJDT2VDQjZQWFZHcVY5TmxyZUxW?=
 =?utf-8?B?WmlFQnF3NlVzN2RqVXAwZWZQMzAwd0VCOUFnWDR4NG5lbnJzTEJqMlRzTGxp?=
 =?utf-8?B?Ly9Sc2lqNG9mNVJIVTNQakRydU1DeXVPbFoyQ2FhWjQ4aWp2UUxxNmhyZjZk?=
 =?utf-8?B?aDhnWG8wdjE5TWF0RDJXSHFldVpjb01CdW85NzBtMnRnSW11Yjd5L3JCY3li?=
 =?utf-8?B?TmhyUmdxUkpsRWNLL2JkTzZaZzg3SDRRdUZKdTdyODh5Q0ZxMkF5T3c0emdX?=
 =?utf-8?B?U0xONEsxak9xTElYRmZwNUx4V0l4V24wZm1BdDV2N2pjNmNEV3NmTzFWVkM3?=
 =?utf-8?B?VEoyekdiYm5wZmZJNWlTQWZKSVoraVd0d3BSb2pJMmMrNU8rL0U5SFh0UU9K?=
 =?utf-8?B?K2Jaejd4RER6MUxteEpvUEY0S2tIQlh3bjhvQzZXNk1qL2g3SG5yWjFKdHRi?=
 =?utf-8?B?SHhudmNpL3ZmVFlWd0xudTNKT2ZTUTA0Mmpib2tCeDY5ams4ZnVIdGdDdmov?=
 =?utf-8?B?SlZseWd3Z0tleTJrdlNoTkw1WFRocHNFc05HTzR6ZUdqcmhTbURUVktQdlVn?=
 =?utf-8?B?VGhzSEhnanF5VHJQQjhkMmtqK0tydXVYQS9IMHk3d0tMSUl3WExqNE9XYXRp?=
 =?utf-8?B?Y2NIRSt1NjFEUjJKZUlCMll3RDhBUFhZSzBZSEFGU2Nsb2RwazU5dzRhSTF0?=
 =?utf-8?B?bGxtakJtRHRWZUVSelZ3Y1duRG9Nb080MjBJZ1FWd1ZvVFMvODEyeWIrUFFD?=
 =?utf-8?B?MHlKVC9KdVpvRjhKNnNlZEZ0VmQrZEVOWG43WVFMZDhYMGg0SUJDRTAwQU81?=
 =?utf-8?B?TGc5b3RQTGMrekl2ZFl3SmhUSndKczQzZ0pVSnhwdzNxUGFVcnA4anp2dEM3?=
 =?utf-8?B?c0VpbklGdlpudWttMHRCUmZuUE5Gbzhvb3hBMnhYM0pYNjVhRzB4MTFtbDVI?=
 =?utf-8?B?TldYSnJPWG5DS2ppR3dObnJObjVBNDdHK3BJYTUzRWg1d2Z5b2htNWxFNVE5?=
 =?utf-8?B?LzZ3RE5WbHB1OFpENzNzMDhBaDNBdDRTeEl6aStYQXQ0TmRxRmVBcWdvZGNn?=
 =?utf-8?B?WjF0YVZKWE5GQ3ZuUEdJbWg4SUpoWXZHRVhZZWdMTGw0SlhTbTVVV0ZxbzNB?=
 =?utf-8?B?eXJqNmpsckNlWEV3UEpIS0Vwd0VXYkVKU1Frc1psaEdQQUd6SjhQTnMvQXdE?=
 =?utf-8?B?YWpvangvcXh0Wnd0UGVyUXdQTzY5b0loY0ZYbUgyZWlrWnQ3RWZqNlFnSEpM?=
 =?utf-8?B?L3ZBcUl2SUMvVDRtemVVRzRGL3dxSEZIaDBCVkJ3Q1V1bG1RQ3R0ZmNEVkxx?=
 =?utf-8?B?TUxuS1FUcWdTc2NHYTE3cWU1NlNpWnpMcDE4NWhBc1gvNUhGMm9GUXNtaEFm?=
 =?utf-8?B?UEdvS3E1QVd5dXVudFJYS0RMTFlsRVpvQTZ2RDd4aUVwQjJ1S2k3QWRxajNC?=
 =?utf-8?B?VWhjbFNLYVlwZy9LTk9pRElDeWZ0OXR2b3ZUWGNCVzNFYzZDNkIybklNcW80?=
 =?utf-8?B?dEowcENOaWc5dTBkeThnd0RuWGowdkg0TnhrWXFKK0t2a0lxeUQxQU9EckFL?=
 =?utf-8?B?YUQ5V1N1OE9WQU9vUS9PTGZmZkFtWWROVmtjbzR5TExvRFJMKzJJb3I4bDRV?=
 =?utf-8?B?QzhFL0NQa2RUQlVKNWtBTGVoOG9lamV3U3lJdFdOYkFsRlNtT1RTWGlwN1JX?=
 =?utf-8?B?QWxydXMzUGZvdEhDcWtFc29JWE5Eb1Mvb2RJV1B0bjdXbS92dENxb3BORzM0?=
 =?utf-8?B?ME1ydUluMDBOQnBoVkJld1kyMGtSNXRtWm1VRU56VTNkZUZjZVJBMlArb2o0?=
 =?utf-8?B?TkJDWEFaVWE5MmU4VHA3TnYyQlBrVlhyVUx0TmVvMWd3MFNxRm9jdExsb2t5?=
 =?utf-8?B?VS9NOXZrdGpySEVlVFVwT1NIbElkcmx1NTR2U1dHTVJYUVcyOE4vZW9HeUxl?=
 =?utf-8?B?QmZQelB2Tmd4cmRCdzNPZG43Q2ZaT0ZzS1ViQzVSU3Bja1dHSmxQTHZtZFhm?=
 =?utf-8?B?bks0TnI0VU9DODJ2aWVVb2Y4Zm5yalVkS0lSRGFsSkp4NmNIK3NLSytlNEgw?=
 =?utf-8?B?LzJnQWJ4S2VMY3M3bkpsMk9UcDl0bGd6ZUwycHY2NGtmcFd1Vm5qbndhdkl2?=
 =?utf-8?Q?tkwezctpnWQAF81EhJbxuwfAo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a3ab3f-2728-4821-7c95-08dc5330f9fc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:21:39.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x07mhjrHy0sveW96vvYS07t1hH/r9z70684ffamBbsJDSfTC6HvBZfOdi8CiqF4ovsBB+neW2y2x2v0ePGaKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

On 4/2/2024 10:59 AM, Jonathan Corbet wrote:
> Avadhut Naik <avadhut.naik@amd.com> writes:
> 
>> This patch set translates development-process and two of its associated
>> files into Spanish.
>>
>> The first patch updates the Spanish version of process/submitting-patches
>> with the changes recently introduced into its original English version.
>>
>> The second patch translates the process/development-process into
>> Spanish.
>>
>> The third patch translates the process/1.Intro file into Spanish
>>
>> The fourth patch translates process/2.Process file into Spanish.
>>
>> NOTE:
>> In order to avoid broken links in process/1.Intro, empty files have been
>> created for the documents, associated with development-process, that have
>> not been translated yet. Similar approach was taken for Italian
>> translations some time back.
>>
>> Link: https://lore.kernel.org/lkml/20181108232417.14982-1-federico.vaga@vaga.pv.it/
>>
>> Translations for these documents will be submitted within the coming
>> months.
>>
>> Avadhut Naik (4):
>>   docs/sp_SP: Update process/submitting-patches
>>   docs/sp_SP: Add translation of process/development-process.rst
>>   docs/sp_SP: Add translation of process/1.Intro.rst
>>   docs/sp_SP: Add translation of process/2.Process.rst
>>
>>  .../translations/sp_SP/process/1.Intro.rst    | 302 ++++++++++
>>  .../translations/sp_SP/process/2.Process.rst  | 542 ++++++++++++++++++
>>  .../sp_SP/process/3.Early-stage.rst           |  11 +
>>  .../translations/sp_SP/process/4.Coding.rst   |  11 +
>>  .../translations/sp_SP/process/5.Posting.rst  |  11 +
>>  .../sp_SP/process/6.Followthrough.rst         |  11 +
>>  .../sp_SP/process/7.AdvancedTopics.rst        |  11 +
>>  .../sp_SP/process/8.Conclusion.rst            |  11 +
>>  .../sp_SP/process/development-process.rst     |  27 +
>>  .../translations/sp_SP/process/index.rst      |   1 +
>>  .../sp_SP/process/submitting-patches.rst      |  28 +
>>  11 files changed, 966 insertions(+)
> 
> Applied, thanks.

Thank you, Jon!

> 
> jon

Best regards,
Carlos

