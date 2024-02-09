Return-Path: <linux-kernel+bounces-59902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75D84FD1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DAD1C2174A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367284A47;
	Fri,  9 Feb 2024 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cDP8XLYW"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0E77EF1B;
	Fri,  9 Feb 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508055; cv=fail; b=R/CX9hiBJYxF7ipUQyNlB/LBUprPjQXpdwe3ZTc7KB9MQKhs2UKKttSNZHnbLCNSv8Rw7oi1KXW0dx+D7X45k9bW0T8VPnICNBHZiIP3pBYgH2kIWsMx9Jdrtnqz4fgzcgE9tJc/bnxsRaBsTvGlLHsHVW/Mna0i8b84zXLWjkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508055; c=relaxed/simple;
	bh=IJnWbbfOPQqWlXSNXBELk23uUUHRP8SEqZEAtHlDeWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GkDReKsFXKZsys6qZd0OY7xbF72GRODvRv4ibqAIhokt85gpDREaKLZc6hHqkzBuXTS3BuCWeYp4jmzOlZl+CP9C2FfOaBBk9ljq3CyUB/boQDnGUQGXv1ZCHNpKslk5J+SM5dcQ1nfE/c7PsURABDZsYydETqopA3C/ms/H4Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cDP8XLYW; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0QDvV/ydZs4QmkcnfPDUkhn7GlYGCLS7eagOmA8rNqFEgmvr49+SYv+RjoL+JbRoZAFLII50pYlrnrq/vq8TKOceHKIcERkpC6gWWpMKWFCeSXo/gVtUH5yKgwTXe/jPdhfx2IYLTpDpKfrWDl5q7QXPN1+gjg+Zvhw36AX3V0DeXMw0JHxQEHBaHZhEfioitlfh9s/h+9nxbmu1j8hhrYZ83XPm8BeF4RzCAUw6XHcZxux4a5Ut+MQnW2tVVjxDPjj4iE5toeh+SUUlydGpGDo8gbe0BYyXhFhdlFKmmJYleYnLwoouyo5xC0Abfx8c+cBj3EcrRE68BpZEAlbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYvJjlxiSlpUeskv6kWpzWLotMVRWts6HKxHJ/7PLNk=;
 b=lu/h7dYIUtwWwvG81vMp2vekjALSYbTYC7yaYCrfws+Ctnxx3kR/EdaE7EWHZKztAVIYn3hjDoCmj+8kDyCtEB2BFi0dnM0Q1qB+b1ddECtJIKXAfvdBTD+6A2jAAg+H3hFu6Jt71A8JJbooPzaw7PA+W/or1cMoAy0a2QmM14x7aGtHCHf3W/LdUDRR6Pu+1b00NL62uywiX5SvnC5vSAvSEituHBYIGMwxj4dC1F3a/Hm/udzH+Q4zWCRh6RJPJBXT/SAUuICopnYxKNxh2Ntz4rgon45ux5rwa2DY51HChCP/0Mawb3YCqJpwnb21YWg5awzzh/hwAthKIttK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYvJjlxiSlpUeskv6kWpzWLotMVRWts6HKxHJ/7PLNk=;
 b=cDP8XLYWj0iNDxV8tZx4luRzRV+AHbJEY4ZgWzbHg1oa2fomVD7w9XN4bngJWmcfaWxa1FvoptwQZn6xXURxuytaU3MKtmBoh1B+69YvEPt37Y7hHaz6LrRnA8p52+ip7cl8YURd1ZZDIjZCNa8E3OxM8aGE2NJYc98zf6kBKW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.13; Fri, 9 Feb
 2024 19:47:31 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 19:47:31 +0000
Message-ID: <8d2d0dac-b188-4826-a43a-bb5fc0528f0d@amd.com>
Date: Fri, 9 Feb 2024 13:47:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
 <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
 <SJ1PR11MB6083F74E1C45F06860A29A38FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083F74E1C45F06860A29A38FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0114.namprd07.prod.outlook.com
 (2603:10b6:4:ae::43) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CO6PR12MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: f5383abc-fcf8-420a-a586-08dc29a7f42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o3h3XUQoHcq0sImoIWPMJ8Cq413ChKiaFONMzS9d/0NKAj3WHkD6GeP6zVd5YI4ph2aVLMHAj1O7KQPFNpKTZVe+o2ZUrZYtKS3Yt/pMRiVFYf8nzgRqrFMCI8Yzfto5DjCmliweV/MNvzOuO2NR//8croJmdB0WdhZCrsMN5o1PK9rKJI33voUeGOuZR0TxXPThjYNGT/DcGrlynKwTW9f7iZt9kqWzo+lOuQqM+wb73yL6raQKnPEBiL8aQR6UuH+fO4W/jbxqDGb9PKk/V3O0FWpqjpZ4pyHTT1G8z/SZUNPjI7N+1oLyKs015sge7z1MV+awdKuB4bs607V85yOHZNP6o0S6qAoHoHdCHvie4e89ZRyXlOO1QfX7WQnI+yiXQJCAbhDyv9/CeNdW4+toyDr3Eqttn0sLW4WFH1FShsa34MvYCao/41GltrG3jEm3O9ozCCeMgF35Z7SK9Kv79B5AGZEjsQNMz7TQrZOXCCm9kMReJHtaBRkktLhjL2aqwpgPnp2dwPqStpXGcM+yRqB09VULo4/2hU3yFdbLdBmRjmc8wP6UYmYl11N4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230273577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(4326008)(31686004)(41300700001)(5660300002)(8676002)(2906002)(8936002)(54906003)(110136005)(66476007)(66946007)(40140700001)(36756003)(316002)(6486002)(478600001)(6512007)(2616005)(31696002)(83380400001)(53546011)(38100700002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NklLSUk3UkVrQ1IwVXFFZzNTenluZmxBaDlTeHFLQTZZeXNOckt2OW9RS3BZ?=
 =?utf-8?B?V2Z1dndpM1ZpM2xJZURXcFZHamhMOXdWTTJxQzAyRXZtSUJwRmhPS0dVUm45?=
 =?utf-8?B?Qk9lY01tSm9DM3ZSZ0RvWWUyanhIOWQ2cHcxTlhsQVFjZWZ5SzhseVlZWXV0?=
 =?utf-8?B?K3pSTzZST2NkcWErbWFQcklMOHQvR0x6azNTYTJFaDZZaUFJdWFoV3RZdjZn?=
 =?utf-8?B?SmNlWHd0ZWlCV1VWcy85YXRZYzJScWVlOFBSM0h1RDh3ZSs5aVNHQmdkVnB4?=
 =?utf-8?B?NXNNbTFmZW5JdVdUTmhPSlQyTmdMR2FaUWJQT1U5SUdBa081d3NmQUpUekcv?=
 =?utf-8?B?YlRUaUhranhtSnhwSFJDVUtRUUl5VExjbGs4QXZueDhlT1NWVDhGRXlvbm1O?=
 =?utf-8?B?NFpYTVRSVnpUVER5cng4Mm5FeEQvWjJZcDBtbVFyR3o0RE1nU0ZQTWxsWEtr?=
 =?utf-8?B?b2JKYklxMVRiNjQwbEdNN0JrNCs5Mms2MjhsTTJZeXA5WjJsOHRMRUJXNkFj?=
 =?utf-8?B?R0pYNVJWcVFDUFFnd3RuUk12WUlpcWN2WXBHVmp1RWkyUUNDcnBpdzFoQ3hv?=
 =?utf-8?B?UXVsNHFKc3JKc3EyZkxQYnFRRFVjemQ2ejV5aWZNTHhMMWpOdi9zRXpJRVlR?=
 =?utf-8?B?MTljN3djakVnaUx6emlZajdCVFRuRndna3ZOSDh6U1k3WGloWnRYK2p1eXJE?=
 =?utf-8?B?UmRoNzlSb09LNzZOa2prSWp4WHhYYld5ZmU1aW5KbHd2Y3Exc0dycHFJUEpW?=
 =?utf-8?B?dHFPcmJJNUpJcHFleE95TEtmSGl0VERDdFRJcDRJU0xGaG5Tb3o1UGpDOTFQ?=
 =?utf-8?B?VTFyV2ZZOW83WldRWkV2QTdkZk92WktVUUZlWE1uMzFqUHk4TExrdUZCMWRW?=
 =?utf-8?B?OTFPcDQya04raEJLckQvUHlmdWhuSnJMWG0xbU02MEt1MkptRjFRYlRtK3R0?=
 =?utf-8?B?ZGpBYWhZZ2RZaVpJVGNPbVRJTjFFVHRTSnhLNCsvUXZQL0xTQzVBUmhadlgw?=
 =?utf-8?B?UVhKZ0NReUV3Q3NUQjNPRFZBWEVtQWpEZkl4RkNsdkQ3WUpnVktha2hRZWpQ?=
 =?utf-8?B?SGFFeEtJK3VnK0tZU245cnhuNFplQ1NIWmhla0Y2bmdLam1NYzIxWU9ERTlN?=
 =?utf-8?B?ZzVuc08xNU1TbkFyMDJwUTZEOGF6UFk1NFYvaHZsa1RkMHd6MEVZWU5xaEhB?=
 =?utf-8?B?OTR1VG9PaEpkWFpwYklYd2QxendPdVh0WmI1bXFYcVhzczNGRzhmWmRUWjcr?=
 =?utf-8?B?UVc1aVdOa3RjN2lVOVZVTHVJQXlSSlgxYnlOcDF3Z2syK3oxOGdsci9RMkhB?=
 =?utf-8?B?SXhHWk5yODlmUlRlR3R4eG1wSS80WFlEWCtnMG5Yb250UmROZVdsRHZuRUw4?=
 =?utf-8?B?UU1FNmNOQmUzQUR3ZXBUY2NNYkYrZHRCbXBmUlNWZGFvZzNrZHU1aHdPSHhN?=
 =?utf-8?B?OTBpTVNXNVFyNEdCdnBGbkxVNDNSZ1VWakprZWxzdWViWERoNVdHeTBTZjBj?=
 =?utf-8?B?bDJqcy9NaVZzWVpNeVd4Q0VuM3llVDhMK2lLdzlVMzJCMTJFcEFCdHRjWndq?=
 =?utf-8?B?UEFVcUREYVZLaUxmWGpTT0xKZGZ2TEI5Nk5BZ3lzQStJUnUzaGZxb2dpSFdz?=
 =?utf-8?B?STBlTVZ5WGJBeFZCOWhqdFR1MytWY1I0M3VHWHlqemg3M280YzJLdlI3c2dV?=
 =?utf-8?B?UUVjc01ZR0pJRk1uUFcxRTRrTnN3Snhub2FVYXJqTDNvNnZkVW02ejhUNlcw?=
 =?utf-8?B?Rlgyc2pmWTI0K0RSQy9iM1pCOHJiL2lrOVIxL0xuT2pPKzFvZTVYbzl6TUpw?=
 =?utf-8?B?eTBTS2JlU3lTbFFrWXdpUE1zV21IRTI5Ym5LR0VpdnJMNVhNak96T25UL3FT?=
 =?utf-8?B?UjRCeGxoOGxTQlZwdFI5S001OVlBdS9BQmNNc25iZm5TcVJBZkdHRmkzSjJr?=
 =?utf-8?B?U2JqWjh3WDY3czF4Y2lYM1VUOUtUYTIxMlZnTTFJTGRoNVd4UFFPUUpoSGRp?=
 =?utf-8?B?UkNZWU9sSHYvRTU4WDdxVkVTNXNHZ0NoWlBBcDdaTStjL3MvL3AveEg4Ty9I?=
 =?utf-8?B?VFNZcUJhQ21iMTV0U0VPbmg2ODZVOUgycktJQWI2TVArU1Mxa3lVcXZ4d3JP?=
 =?utf-8?Q?Xxb0zMgYbsLDvjniGJv+4cotI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5383abc-fcf8-420a-a586-08dc29a7f42e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:47:31.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgJdr54uMFwxlV53KO75xVwgas+orr+2CD4Hk7D4OrFfkDScz/qWSnoGz1wcpAA6mh6bo7zPJ7TJF1FqD4+mUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457

Hi,

On 2/8/2024 12:39, Luck, Tony wrote:
>> Will change it to (2 * sizeof(struct mce)) though. Feels more
>> accurate. Thanks for the suggestion!
> 
> Thanks.
> 
>> Do you have any additional concerns/comments on this patchset?
> 
> Overall this is an excellent addition. Reserved space to log errors does need to scale
> up with the CPU count.
> 
> I think part 1 (unconditional increase based on CPU count) is a "must have" enhancement.
> With the change to CPU_GEN_MEMSZ #define:
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> 
> 
> I'm less enthusiastic about part 2 adding a command line option to override the code in
> part 1 with a bigger (or smaller?) amount. Can you describe some situation where a user
> would need to use this?
> 
I added the command-line option to ensure that we have covered all bases and are not enforcing
this memory footprint on all users.

A system with 512 logical CPUs, by the current proposed logic, will have 32 pages allocated
for the pool ((512*256)/4096)). Some users may feel that this is not needed on their systems
and they can do with just, maybe, 16 pages. The command line option gives them the flexibility
to do so without having to change kernel code, rebuild and deploy.

Conversely, some users wanting to err on the side of caution, might feel that the above 32 pages
are not enough for the pool and may want to allocate more, maybe, 48 pages. The command line
option again, provides them with the flexibility to do so.

Sounds reasonable?

-- 
Thanks,
Avadhut Naik

> -Tony



