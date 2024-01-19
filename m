Return-Path: <linux-kernel+bounces-31546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88291832FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB201F2224F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6DE56B90;
	Fri, 19 Jan 2024 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mj/PVslh"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306D0374E0;
	Fri, 19 Jan 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696559; cv=fail; b=HjIMMcMptN016TcTl+jy/mwq1Q/00kFKVUDqioZi9zyYuoj5LYI02wQNUglf/AU8+c3M41gd11FDn+wzoWw1ZDlYWTbFFaqjhgUci8/YuqAAYzGKDCBvnMVfocA0B2ivJAqfCggXWeJB7D8tMOsAKizIbQdfz9F6rn5b+3hxsWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696559; c=relaxed/simple;
	bh=cnx8ZJJvO1vsattg+ukiBJi3jCsI1SXkn1L38dZnKt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEBUHuQHpG9Yrh73yFdzBtXmHvcwT2bkrdOTnP8Vphk6vaY4jQQqHOJUmflZ7hwrK5ChOX2rqrKp2tYqA9QoW8kdiohZhHot5zl25lIJWJQOpZ7FZfl+sY74f7ozkwUvQEzpZ0bU5eNYUNWH7cZBpjrpJ6M/4ObpfF71G7U5+JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mj/PVslh; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9LqvgYMI+AquF3opnHmiEnG8Km5XL1hrizHgOTX0gSiogqJUX0JAuKjcmol1SnTX0oCKMLOO53ipyB4erzrpGsiubj1Yoxc0Y2kfXEgCAwoBkMyVcMdaL6wStkC4mtr/wYM3FeaymC0s5l3AEgtpxhW9KJx5pxx330GlzeU0jql7A7CxaYnzx5wlkL4a96ZivWrud9mPMRkUAdsMTBJbZZrMtd+nZPp0/vM8gz8wZYU2lRpdYv3XRmbPVdXZjbBcJs22C7M2uai4l4ldW/rj0limnExJo6DMu0SLP1uYjr+AT+BxrSAxZaKcRRA3yHm82JoIOy5u7Y5rdShG5zopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssQ8+5Evt8CBO0Qp9Uuj6eiazZ+MzpiAySpPvKIN17o=;
 b=oWYXs6NT8+QjKUNQsWF5DbzMBLqoIaYXOKohQKtt0S08JxqcfS4Vaoqyj9Y0L20Fl2bKOG/KRo1OVsmCpJYvd/N9R/8A1g7GwPRN+TtSCxYrAWoGh85iG5I26J+D7NkEFw2KCvTiTiLHsQTrJ89VYEYPSeepAFvtgikaWcqhjrNyW6x6qZqcvBjSdTE1yHiMAiA67OU4o9FHI0M0FDHvv/raLwIiouncSrEd1jaqHB+f3dqjbYvv44XEAVYLPj3niQSC5yCJNspv4ZaLIDKZMveWQc8o3q4zzqBsco/gXIo59zUhtuGV67MN5msYPES5B1k9K58kAv0k4hhgJsudbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssQ8+5Evt8CBO0Qp9Uuj6eiazZ+MzpiAySpPvKIN17o=;
 b=mj/PVslhBP5hP0LAxG3OwQcfM6ef+QF9Iidh+ryja8YzgO9mR3vvdRsHKGUnpCC3g5lQbYaaPmLyhWMZGWbKSxYRco4DVBBdX+vKBWX5Os2EqpxqO4u4rX5bqeuolNndzk3p8fQIXz+Vv0z1EsZwTi4tWBxK30dlfTEYBpEux+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 20:35:53 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%6]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 20:35:53 +0000
Message-ID: <90bb280e-402a-a3e9-2db4-c08f3762fdb1@amd.com>
Date: Fri, 19 Jan 2024 14:35:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 James Morse <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <ea03f9db-91f1-4f59-b94c-cc351f0bcc29@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ea03f9db-91f1-4f59-b94c-cc351f0bcc29@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::33) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: e988b93c-6804-4535-2224-08dc192e3b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9LteMWMB11IaDgW+qJ44kYa+a/TYb6WUdjJWu3Ll+SPLqCGPJq53jNaIOU6wteNoB68k2HaaQiuQ7B0J9Dob+0orx9WNfPSrBPQ4GDIhdZ3OfzgtZZjxy7+TYMikylX6a1d272pD9FgUbbVnFB0dswYEZ0ZBNK3zX2qV74+RPpKc6fvWCBZp0eLLSgq4KvfjtSoqc3FH7/nY8sfgxCryftemyo81MRJ+L1RwDH2EwzBItyFFxPlCboNUEdCfeO3aqi1tPlXbaViEcKYLETGan03Cj5mLUf1wuuPC46WZ3RvpfSv6c+1XCNcuRPOto5RplzP7RSZQrE0dTYln6uLfBuSE74KYDps1VRjrTPF7x8jTK+uvFeVGJvZRYaD5m9Ggal3r6HGca6il+YMweuJQzLyE1Le99glKlgh8NSwHw0UfcxoLPMtYYXqcq3XmaFjWgftLPvKkYSHtWSTu4RVDHWPjTyfHvxTtVypM19KtUcyy+xQTij0wNsmU+zL7/p8bSV/lJMY+Dx+ijr9NEPMllhPL0cB7UXDIEJkI/FywRtsQ/M78Ps48P8Vz6s9TO2AegJnQ9+soW1llJp8aAI0RHQzb5ia6qfK2O0TK+OoxMwa41mwWV6azASm2fhtPT1Y+xSiX4+8hEtueAFYeNwn0sw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(558084003)(5660300002)(7406005)(26005)(7416002)(4326008)(8676002)(8936002)(2906002)(31686004)(53546011)(6666004)(6506007)(6512007)(66476007)(478600001)(2616005)(6486002)(36756003)(66556008)(66946007)(316002)(110136005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0lIMUlRVlhzRkhoTTZlWUtra0VTTXZKVU5mTmdWY09RSk9zdm9LRUp1NEow?=
 =?utf-8?B?TTJWNUJNbUF6NmdXMzRNc24xVzJ4akd1OTRqL2lDNGQ5VkNheVhYdlAxZjBn?=
 =?utf-8?B?TG8zSHhDeGY4MGNscDZFU2tud0ZwTUZScWRRU2dXM3BVRHBsb3VTSm43bUFo?=
 =?utf-8?B?V004RTMvbnludTIxa01lTStRdy9Wdk5BWlZpK01EWnBLT3EycnZoMjZBN1Ji?=
 =?utf-8?B?M21GQ1NuQUpGSG9PRzBSbk5nSW9pNGhUUzFEVGlLVXpSM2tHMENLVFJYRWlE?=
 =?utf-8?B?RlhhTklvYUZyREdKOVNkeWUvS3NxTW5IZ3Y2MWdZK1hFZzhyb0VRMVhGaStX?=
 =?utf-8?B?ZkQ2ZGI5TXBraVYzVDIxSzlMQ3V4Q2ZFaXIvMGZrNmo5NTJkSnZwa3R6OEdt?=
 =?utf-8?B?WnBhdXZlQm1hK0JQd1lwbEV2TFdPcVI2WUZ1cmI2NnVVTm5jUEo4VERYNE1n?=
 =?utf-8?B?YTVOYnVLV0RnTUhGRmpNcFZuUFJwZ1NVcGhZYit0ZGJrZ3c0NFRFajdxM2w3?=
 =?utf-8?B?aVM3cmtRcnY0OTJzSHViNjRRR0tzSVVEdVcvNTBiMU9mOFVidkJYeXBzNlY2?=
 =?utf-8?B?TElyaVo0OFJFbHVWaDE2eXNDSDdkY21VRzZjTGI4enpoVHgxM2ZrYlJBYjdH?=
 =?utf-8?B?ekFidkxIanVDOXhZNkd4T09VcHB5a3IyU2k2Rnh4WjhFWS9yclVGUzRsTVA3?=
 =?utf-8?B?ZS8wNk9WRmhtT3JvbHhHbXArdkVYYTE5UXJQd1hFTXpBb0JpRytMbEsxb3gv?=
 =?utf-8?B?QTNyczk5dEhFRjZHaWswc0xodThteEp2K0paZSt3VkdIWS9uSHlzeWVaM2Nq?=
 =?utf-8?B?ZXl1YUpvK3B3TmRqRUhsN2F4eFhNenBpSHY1N3ZadURCQ3k0SzJIV1BqeGFD?=
 =?utf-8?B?VkxtQlVrOXlZVUJtd2k3T1ZvTHVmb0NLWERXMm5LQnBrZWw5QWFhVE1haGtz?=
 =?utf-8?B?dkxiWlJzaXl6azRxMXRxYkxJZnFRdTg3MDFjTFBiYXd5dytLWDBEYjdxYWVP?=
 =?utf-8?B?SDRybmZ5WXpxdGYxa2JXdUdWN0VyTVBOUmlwTXBSZFdKaE8rZUFySC82MEM3?=
 =?utf-8?B?SFhrdGYrVFE2RDhuYUFYTVArVTk5c0g4dTlXSWdLNEdSWlZqaXNUVmFxZ0Rj?=
 =?utf-8?B?aitZaXJQay9XdGh6a1J6dDUwc2NTZ09OY3k1Rmo0OUw4eXAwOFFHY1M5WVFr?=
 =?utf-8?B?ZDhLUm9DbUtuT3ZUUStNVTJCTzg1S3FQMmRERWhFUXZnTmVIbUtwZFM4V3M5?=
 =?utf-8?B?ZDBjSHRweG5DNVo3dTVqWjl1QjIrbmRsTDNzRXhOQURiT2ZJUldXNXQ1QUQ3?=
 =?utf-8?B?K3JuWGQ5RE1pYzdMc24xQy9wVkF0VVZNR28rblQzOEZlTkZ2UVlzSVdPZHZI?=
 =?utf-8?B?NDBtVE55UWJTVHF5SlQ3RU0vODRCL0FSSXZZYkM2ZUdBQUhyTDR2ZmIwUDBt?=
 =?utf-8?B?dEtBNSsxSVlMZFZEOXRFZUoxN29UbHpLQmpCQkZaU2EzYWlVa09hc05VZUpx?=
 =?utf-8?B?V2Fodi9qSEZqeGs3eC9tODJXSVZFSExxbFlsMFBGVVlIWngxbU92cDJITDR3?=
 =?utf-8?B?UzBrd3ZGRjJHelkycG0xVDR4NUZCWjc5NHpQSEtzdGpZMWtESFY5OEdZVEFs?=
 =?utf-8?B?UTE5Zlh1Z2puaHREYzQxKzY0ckRvU0VDUmJBc25DWUpnTW1lOXJ1TlRYa1BP?=
 =?utf-8?B?UHlnMThBNkg1Q1BmQ01qUUlHRlZQUjZuc2U4SnRuamVNbk5TNGd6aDBNeENo?=
 =?utf-8?B?Qnk3YXBTTU43amI3alk5dGg3dmlZNnZnQkppVG9BeTZGU3NKa1pGNUZzOG9R?=
 =?utf-8?B?NTJpOUdQMEYxak5yYXUwQzVxcUE1ZTc1alFsTThYaFdRdGFMT3R0TmJaZENt?=
 =?utf-8?B?VmpoN1B0UWZFdUpZKy81OHVrUENySFoxRUt2eEthcjYxRDFYVnZ2cTNzbzZ0?=
 =?utf-8?B?OHFHN09EUHd0cDd3dFVxaUZEZDU1SllQQU5ydU1YZnUvb1Y0c3prNXR2OEpj?=
 =?utf-8?B?RXphZWJaVVZsSVN6UlhSRGdRTnJjWGxIaVA2WlhUamo0YlJXZTM0NVQ2YnZj?=
 =?utf-8?B?SmdObnBvdVdPRk5RRVNvM3dPZ3ZaUTBXSWpNM3oxd3JUejRXUmxqalVGeGQw?=
 =?utf-8?Q?hyJTWdx8H/o1+uOsWECPeCi5f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e988b93c-6804-4535-2224-08dc192e3b36
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:35:53.4473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHKTzeeull+90TngioJhzXwPPxcZ42d1WcB9eyLS8k9iKNLV5FBMHVhVA955rYyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394


On 1/19/2024 12:32 PM, Reinette Chatre wrote:
> +James
>
> On 1/19/2024 10:22 AM, Babu Moger wrote:
>>   
>>     f. This series is still work in progress. I am yet to hear from ARM developers.
> Please at least include James in your submissions to make Arm aware of this work.

Thank you

Babu Moger


