Return-Path: <linux-kernel+bounces-55938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA1884C3C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B071F29088
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A81D12E68;
	Wed,  7 Feb 2024 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oRpxvJXn"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642912E47;
	Wed,  7 Feb 2024 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280835; cv=fail; b=AVKyMKfSklrlWc9FrCLVsq2PtJwefA4EVvuMOFNWI+lWsUDHyzDiiBI9oNyDoCnfkmGUBghN+vgBZF1fZ3QEmFiSfs+6+KHUz2yxbBvL3x7KsR0WUIAFLE2GXfoVXkLNcupgkF8ogp+od0+kqlrvUAK/aKjZShp2yE1N5jwL8wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280835; c=relaxed/simple;
	bh=yPyKXBt0CbHbxYY8B1gtJVMU1CDfxU9Bfv87kIEX3g4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sEXV8APUoX+y43wfpN3ae1aeXBm9lZF+pnvsfTIMXuUer6gAIVppLkCDYWlhyqYMAURTMsuJ25OIkTox4ypxGTlv5bK7u9SfogptUd2ZhRuylnS5VPAA+Y62S1LLWTbXl3wP5AykFUs0zEE0oMN4ZEuGTulFMJ0fhikieOSEc4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oRpxvJXn; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsprd0pFF2ytMNbVeYbpuk16uUUz96s72QfscxbXyRy2LEqEu64DNiMcGOOSu4fH4+keW6ivau1wXN0+EqWO1kaKHqAeY4faYpEIVwC0JExY1xnXRM6sF9pXkF6FRNKvUK0+clo0WBOfHQAi4hBYZiFTRvJi0hLwPW/91AfRnajidyq6lT7fIriE6N2Uxw6HmBsb1sIBeBaQVDNd1odVcjRIJLOrXl0MwVfxWBebqN5xX/bS3Oz3+98EJQdwF2OJJ2WXWna0Z5r2BgGoZYqwU8yEuPul6ZNbrXpkOvthiVQvmEIZR9xqQMV04V6oqTvVfeKdnHVkNpIe+RiMgvAkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHC6hNNH8WnfqSnAS4043h8gn8aMYHkBtU67YaUuLWw=;
 b=AfkL6wXYHbgAIJL6F32Hr6yyEUHoWaBkD/8EOcob0HuNvaOQNg9W5bhz3tnycZM37zPqDawpWahv0FD1gb8ZGx8/pkoXwEdqC5xcTl4ErJFcHHJR7pYJ59G/OchU2q1iZ+60BoppXYdpx9GoE8Shdoaoj6MAENOOj20QTzjo7vI+8eJXqzGP9oQeOUIr5IjWkG+I5yHSm3pdIWlGVoKeijnE0H+JiSZJbN1VabVRzmJDR7WpARdt3fhuirnGGegMOF3VPbPu+jwPzHSj0Nd0aQYRfL7QXFLpQ6bDvEf3hrDusxQX1s1uPVYPMYVk4MxX8L07eF4Je4Ky9Q9jdPZ67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHC6hNNH8WnfqSnAS4043h8gn8aMYHkBtU67YaUuLWw=;
 b=oRpxvJXnAvBlmnvLNV8sHjlCa1hLDiLSYZGH0pkPCbP8XBlnEU4mXKP84X6ArjR4ynAQtqu7ZdFCXo4yOJcKqRzVx/wrUFVHc+UaW84HN/5BUVo9Avosr+KaVDJqXxrAZWAaYj+teg5kp8FhZgICXaaNifIz0RLxYyCjqVFtvxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Wed, 7 Feb 2024 04:40:26 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::10f5:3862:261c:274f]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::10f5:3862:261c:274f%5]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 04:40:26 +0000
Message-ID: <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
Date: Wed, 7 Feb 2024 10:10:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
To: john.johansen@canonical.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com,
 paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com,
 mjguzik@gmail.com
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
Content-Language: en-US
In-Reply-To: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::11) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3dddd4-f3a4-4dfc-0fcd-08dc2796e78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sn+9mIBWEFFNgWX1a+StRthsATZ/J96oCOQxhpB0qaMcM4v67MuCFPlFhTh4WpgYP//rixJkMXRF1t5/Ttg8goj8+q16l3Q+a+4nI4k5uFzh87cH2r+HADyZyAK8L7kPCPWVip6tYNP+SOsijgEuKwCSY+IULhd2zdo20Q8FqUULiTaTga5EvQGN3DgjZnvKk/zEHmITPEjVOt14oXCiiMJjoqXc/dLgWr45Q7wGNFV6odtTrqoG5jjd5j8vCQGKJUFu12W4aCoLAI9sQEvagdENQtz9zmuJqOZ0GtQ5zlUTqWyh55KRG15HrmW3Ar9akpyND7noIydjHe4209LVkzY6o//rSSWJCDvBSx4f2oVNfF7U0Vac6VPfJ3BncGwnIU1QaGGDWhASVaxFYqpbM0CGfu05D0qjVwGezj4tqYPQRVupmbcVlw3k3ndlK3/ChaAKLrg+mXuAno4ihovB/UTLolWfi7zLPXlUXHHQ1OLxMhIS70crKMR+JjKoqCZyRCqgC3aPd+uzv9V3Wue7FlTOlQTaKv99PDb5g74rxISpmLml+aUOHIZkNrHiELhY35epJrizBEjq7/Qu/fBmVPNCRlZGS8KI4rijSEsV4ieV5TmwDZh9FlbJ7WsO7nMOPKiOgBTyKhb3TRERdoPE9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(36756003)(53546011)(6666004)(6512007)(2616005)(86362001)(41300700001)(31696002)(38100700002)(26005)(83380400001)(6486002)(478600001)(66946007)(31686004)(8676002)(30864003)(8936002)(4326008)(66476007)(2906002)(5660300002)(7416002)(54906003)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JiRks3T1BaREZBQVQxc2UzYXVyNE8wMHozS3lVbnZMZ0J1Vk5NN0VhWU1G?=
 =?utf-8?B?b0g0UW5DampWc1dHdSt0cXdvTzBqSUFXQUFtRCs5dU4vNXpZOEZSM0FIVUhy?=
 =?utf-8?B?UlpuR0QrcWhwRGl6UTN6NWJIY09MSEJTM3oxQVYrTGFDb2JjMCtDdzd1L0Vv?=
 =?utf-8?B?RFhwemk5ZiswTHZoRUZNcXV2S1h5bjVGZ0RTNUZwWWMwQUUyWlRUVHBwT1p1?=
 =?utf-8?B?WVZ6cU1jT0NWVHNFTUxFYTd0cUxBeXQ1NW5KbzVjSjIydHlrcXdvV1lUcTY4?=
 =?utf-8?B?R2ROdVphVmhjSjBJU2xSN3NGVzJHVFovMHN0WkQ2d3U4N1B2OUJocjFwZTd6?=
 =?utf-8?B?OEhDYmU5aEE1YzVQbFp5dnVGUGpQbHhYbkJwOXRCUVVZRTdQT1hrV0hhQXZ2?=
 =?utf-8?B?MmJvOWtnNTJJQjIvTGVmczViYTcxSW9sbXFuZm9pN0JmclN6aHlzNDhwb3Fw?=
 =?utf-8?B?VU5tQUJFNjZEMkZsYUp3d0VaMElUUXNaMWlVbENSanVIemVxZmhUZndUcUhz?=
 =?utf-8?B?bWVGQjZnanNEZVY4bkYrcy9yQTkyM2JZejJaRnJaMDVId1V2QXRUZXF5T3lm?=
 =?utf-8?B?Vnl2elhLZCtxOWoveXhkOVM4ZG5PcEdra3VZZUNaeS9sR3dEZXMyT2k2S1ZK?=
 =?utf-8?B?VDlIa01MNU40SExDeFhCdGQ3TEd0SjZsUlpEdWFTTlNOUnU2bDhJb2Z6bmFm?=
 =?utf-8?B?NXdkbUN4Q09LTkdQT1lOUEt2TzY2TTdIUGxjdGpKcmJNajRmcmpmSjBVS3VH?=
 =?utf-8?B?K25SZjRRcTNqdkliS0JiaS9tMW40cjVYMDNJRG1ZMUJrU051YWxZbkkyWEVF?=
 =?utf-8?B?SkhENng5ZWFyWTV2TEFHNzJaTi95UTNVUm9kVFNpazJiVmNGNW1hNTBkTHQy?=
 =?utf-8?B?Tmw3amxNRlhYTXUyVjhKekh6eXZiTmppeWVSQXpYV0YxalovZndOOUIvU01H?=
 =?utf-8?B?Y1FNVkx5N3plRTFKNE1CVUwxKzdXYk8yMUNkb29EM0ZCcTU3RC9NQ0s1Y0ZP?=
 =?utf-8?B?a0d1REF1SmRkMjJHaERDUkJZOUw2NVB0ZUhDVVVNTGlzbkhjbHZEcXRndUcr?=
 =?utf-8?B?Q3FTa0pQT3NUTGJSOVBIbmFSbDJNNzd2a2x6Zk9NVUw5UzFQM1BJdXVaM212?=
 =?utf-8?B?djUvbWV0a1g3cHpndWxVWTFwUG4rM3FhYzhDblZ3WWs5V21hR1NocE1ZdXNX?=
 =?utf-8?B?d2hkdElOVnBKQ1IraFlhQmF5TXJ0ejhSZkFrRXNVQ2RxL2NzZDdnaUZra1g4?=
 =?utf-8?B?aFdYMGlRMG9UYXo4bmx3MUcrYkkzaFJtSkl4alphRWUwNTF5cGZybEVCNFlw?=
 =?utf-8?B?WW8vaWJrY2kvRnBWZjEzNWR5Tm11a3c5MmVOR2QzNkFrSDZkdWNXLytkcDRq?=
 =?utf-8?B?RmtiYnk2djNRL05JMEc5MGRmdXZ1ODhDSlFBclFDS01TejZ6RWUxcmR1UEJU?=
 =?utf-8?B?UzYyd3BIOHVwY08xUXQwVTFqSUQ4eUdWNm9EQXd1MTJxbzZETTh3RlhFZlBW?=
 =?utf-8?B?K29nakxoUDA4Vkh3L05qaEhJSGNYZkh1NWxCdmkxSjIrbm9oYWZrTGVmRkxU?=
 =?utf-8?B?S1pYeVh0WVJOV1Z4ZjFINTZFRXpMNHJ4OHNkRTcwbE43QUY2VGJWTFRzWnBv?=
 =?utf-8?B?aU10QUNsTkU0eGNMWGhhUWVWMldvcWtaWGxCTFA0ZHdhK0I1UFFJeUdCTEdS?=
 =?utf-8?B?dUQzalFQQzNOSFFGaDFJRk9Rb2Z4WXpodHoreTdLL2dmb0dTRmZwTHU4aTYw?=
 =?utf-8?B?TUFhWS9hTEJtZGUyS3Q5NnJoWTQ3dS9PdnQyMFE4cU9ydVBGU0hPN3gzZUkz?=
 =?utf-8?B?em9sKzRhV3NsSEFWR3pTUm9Oc3ozcVpNT3QyMUhPUTVtZnFBNDBnWGRCK0lI?=
 =?utf-8?B?NitxVVJ2NHdlcWN1MTl2MHZJUzhqcmhLaFF4Mmp4TnYrZEtZZ000bHQ1RFUv?=
 =?utf-8?B?UzVTS0JGWm9LOUF6ZnpmVTZnVTlGQVozQ0pwM3o2VVh0ZW9LSVluUk1uMUg0?=
 =?utf-8?B?SmlFTW1Ub3pDZG54QWxMQ0dMMUgxNUxmUUJuWXhMbUovLzdLY1NoS2tYQTla?=
 =?utf-8?B?U0ZhYUthK2xKNmlKN0htNDl1TEM0c3NGVm1ZUW8vOCtQT1haczlhYUhaZStu?=
 =?utf-8?Q?qjnMmSiWxkLslrBeRMFOnsn1a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3dddd4-f3a4-4dfc-0fcd-08dc2796e78e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:40:26.5379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNrj39q3ltlUJAxQXXnKXuYXnZPhxR7PnnQA6kaVgZUau9Jbi1ivpFFtwy71h1nkji5fH+ALJwLFynPQDfytYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

Gentle ping.
 
John,

Could you please confirm that:

a. The AppArmor refcount usage described in the RFC is correct?
b. Approach taken to fix the scalability issue is valid/correct?


Thanks
Neeraj

On 1/10/2024 4:41 PM, Neeraj Upadhyay wrote:
> Problem Statement
> =================
> 
> Nginx performance testing with Apparmor enabled (with nginx
> running in unconfined profile), on kernel versions 6.1 and 6.5
> show significant drop in throughput scalability, when Nginx
> workers are scaled to higher number of CPUs across various
> L3 cache domains.
> 
> Below is one sample data on the throughput scalability loss,
> based on results on AMD Zen4 system with 96 CPUs with SMT
> core count 2; so, overall, 192 CPUs:
> 
> Config      Cache Domains     apparmor=off        apparmor=on
>                              scaling eff (%)      scaling eff (%)
> 8C16T          1                  100%             100%
> 16C32T         2                   95%              94%
> 24C48T         3                   94%              93%
> 48C96T         6                   92%              88%
> 96C192T        12                  85%              68%
> 
> If we look at above data, there is a significant drop in
> scaling efficiency, when we move to 96 CPUs/192 SMT threads.
> 
> Perf tool shows most of the contention coming from below
> 6.56%     nginx  [kernel.vmlinux]      [k] apparmor_current_getsecid_subj 
> 6.22%     nginx  [kernel.vmlinux]      [k] apparmor_file_open
> 
> The majority of the CPU cycles is found to be due to memory contention
> in atomic_fetch_add and atomic_fetch_sub operations from kref_get() and
> kref_put() operations on label.
> 
> Commit 2516fde1fa00 ("apparmor: Optimize retrieving current task secid"),
> from 6.7 alleviates the issue to an extent, but not completely:
> 
> Config      Cache Domains     apparmor=on        apparmor=on (patched)
>                              scaling eff (%)      scaling eff (%)
> 8C16T          1                  100%             100%
> 16C32T         2                   97%              93%
> 24C48T         3                   94%              92%
> 48C96T         6                   88%              88%
> 96C192T        12                  65%              79%
> 
> This adverse impact gets more pronounced when we move to >192 CPUs.
> The memory contention and impact increases with high frequency label
> update operations and labels are marked stale more frequently.
> 
> 
> Label Refcount Management
> =========================
> 
> Apparmor uses label objects (struct aa_label) to manage refcounts for
> below set of objects:
> 
> - Applicable profiles
> - Namespaces (unconfined profile)
> - Other non-profile references
> 
> These label references are acquired on various apparmor lsm hooks,
> on operations such as file open, task kill operations, socket bind,
> and other file, socket, misc operations which use current task's cred,
> when the label for the current cred, has been marked stale. This is
> done to check these operations against the set of allowed operations
> for the task performing them.
> 
> Use Percpu refcount for ref management?
> =======================================
> 
> The ref put operations (percpu_ref_put()) in percpu refcount,
> in active mode, do not check whether ref count has dropped to
> 0. The users of the percpu_ref need to explicitly invoke
> a percpu_ref_kill() operation, to drop the initial reference,
> at shutdown paths. After the percpu_ref_kill() operation, ref
> switches to atomic mode and any new percpu_ref_put() operation
> checks for the drop to 0 case and invokes the release operation
> on that label.
> 
> Labels are marked stale is situations like profile removal,
> profile updates. For a namespace, the unconfined label reference
> is dropped when the namespace is destroyed. These points
> are potential shutdown points for labels. However, killing
> the percpu ref from these points has few issues:
> 
> - The label could still be referenced by tasks, which are
>   still holding the reference to the now stale label.
>   Killing the label ref while these operations are in progress
>   will make all subsequent ref-put operations on the stale label
>   to be atomic, which would still result in memory contention.
>   Also, any new reference to the stale label, which is acquired
>   with the elevated refcount will have atomic op contention.
> 
> - The label is marked stale using a non-atomic write operation.
>   It is possible that new operations do not observe this flag
>   and still reference it for quite some time.
> 
> - Explicitly tracking the shutdown points might not be maintainable
>   at a per label granularity, as there can be various paths where
>   label reference could get dropped, such as, before the label has
>   gone live - object initialization error paths. Also, tracking
>   the shutdown points for labels which reference other labels -
>   subprofiles, merged labels requires careful analysis, and adds
>   heavy burden on ensuring the memory contention is not introduced
>   by these ref kill points.
> 
> 
> Proposed Solution
> =================
> 
> One potential solution to the refcount scalability problem is to
> convert the label refcount to a percpu refcount, and manage
> the initial reference from kworker context. The kworker
> keeps an extra reference to the label and periodically scans
> labels and release them if their refcount drops to 0.
> 
> Below is the sequence of operations, which shows the refcount
> management with this approach:
> 
> 1. During label initialization, the percpu ref is initialized in
>    atomic mode. This is done to ensure that, for cases where the
>    label hasn't gone live (->ns isn't assigned), mostly during
>    initialization error paths.
> 
> 2. Labels are switched to percpu mode at various points -
>    when a label is added to labelset tree, when a unconfined profile
>    has been assigned a namespace.
> 
> 3. As part of the initial prototype, only the in tree labels
>    are managed by the kworker. These labels are added to a lockless
>    list. The unconfined labels invoke a percpu_ref_kill() operation
>    when the namespace is destroyed.
> 
> 4. The kworker does a periodic scan of all the labels in the
>    llist. It does below sequence of operations:
> 
>    a. Enqueue a dummy node to mark the start of scan. This dummy
>       node is used as start point of scan and ensures that we
>       there is no additional synchronization required with new
>       label node additions to the llist. Any new labels will
>       be processed in next run of the kworker.
> 
>                       SCAN START PTR
>                           |
>                           v
>       +----------+     +------+    +------+    +------+
>       |          |     |      |    |      |    |      |
>       |   head   ------> dummy|--->|label |--->| label|--->NULL
>       |          |     | node |    |      |    |      |
>       +----------+     +------+    +------+    +------+
> 
> 
>       New label addition:
> 
>                             SCAN START PTR
>                                  |
>                                  v
>       +----------+  +------+  +------+    +------+    +------+
>       |          |  |      |  |      |    |      |    |      |
>       |   head   |--> label|--> dummy|--->|label |--->| label|--->NULL
>       |          |  |      |  | node |    |      |    |      |
>       +----------+  +------+  +------+    +------+    +------+
> 
>     b. Traverse through the llist, starting from dummy->next.
>        If the node is a dummy node, mark it free.
>        If the node is a label node, do,
> 
>        i) Switch the label ref to atomic mode. The ref switch wait
>           for the existing percpu_ref_get() and percpu_ref_put()
>           operations to complete, by waiting for a RCU grace period.
> 
>           Once the switch is complete, from this point onwards, any
>           percpu_ref_get(), percpu_ref_put() operations use
>           atomic operations.
> 
>       ii) Drop the initial reference, which was taken while adding
>           the label node to the llist.
> 
>      iii) Use a percpu_ref_tryget() increment operation on the
>           ref, to see if we dropped the last ref count. if we
>           dropped the last count, we remove the node from the llist.
> 
>           All of these operations are done inside a RCU critical
>           section, to avoid race with the release operations,
>           which can potentially trigger, as soon as we drop
>           the initial ref count.
> 
>       iv) If we didn't drop the last ref, switch back the counter
>           to percpu mode.
> 
> Using this approach, to move the atomic refcount manipulation out of the
> contended paths, there is a significant scalability improvement seen on
> nginx test, and scalability efficiency is close to apparmor-off case.
> 
> Config      Cache Domains     apparmor=on (percpuref)
>                                scaling eff (%)
> 8C16T          1                  100%
> 16C32T         2                   96%
> 24C48T         3                   94%
> 48C96T         6                   93%
> 96C192T        12                  90%
> 
> Limitations
> ===========
> 
> 1. Switching to percpu refcount increases memory size overhead, as
>    percpu memory is allocated for all labels.
> 
> 2. Deferring labels reclaim could potentially result in memory
>    pressure, when there are high frequency of label update operations.
> 
> 3. Percpu refcount uses call_rcu_hurry() to complete switch operations.
>    These can impact energy efficiency, due to back to back hurry
>    callbacks. Using deferrable workqueue partly mitigates this.
>    However, deferring kworker can delay reclaims.
> 
> 4. Back to back label switches can delay other percpu users, as
>    there is a single global switch spinlock used by percpu refcount
>    lib.
> 
> 5. Long running kworker can delay other use cases like system suspend.
>    This is mitigated using freezable workqueue and litming node
>    scans to a max count.
> 
> 6. There is a window where label operates is atomic mode, when its
>    counter is being checked for zero. This can potentially result
>    in high memory contention, during this window which spans RCU
>    grace period (plus callback execution). For example, when
>    scanning label corresponding to unconfined profile, all
>    applications which use unconfined profile would be using
>    atomic ref increment and decrement operations.
> 
>    There are a few apparoaches which were tried to mitigate this issue:
> 
>    a. At a lower time interval, check if scanned label's counter
>       has changed since the start of label scan. If there is a change
>       in count, terminate the switch to atomic mode. Below shows the
>       apparoch using rcuwait.
> 
>       static void aa_label_switch_atomic_confirm(struct percpu_ref *label_ref)
>       {
>          WRITE_ONCE(aa_atomic_switch_complete, true);
>          rcuwait_wake_up(&aa_reclaim_rcuwait);
>       }
> 
>       rcuwait_init(&aa_reclaim_rcuwait);
>       percpu_ref_switch_to_atomic(&label->count, aa_label_switch_atomic_confirm);
> 
>       atomic_count = percpu_ref_count_read(&label->count);
>       do {
>         rcuwait_wait_event_timeout(&aa_reclaim_rcuwait,
>                            (switch_complete = READ_ONCE(aa_atomic_switch_complete)),
>                            TASK_IDLE,
>                            msecs_to_jiffies(5));
>         if (percpu_ref_count_read(&label->count) != atomic_count)
>                 break;
>        } while (!READ_ONCE(switch_complete));
> 
>        However, this approach does not work, as percpu refcount lib does not
>        allow termination of an ongoing switch operation. Also, the counter
>        can return to the original value with set of get() and put() operations
>        before we check the current value.
> 
>    b. Approaches to notify the reclaim kworker from ref get and put operations
>       can potentially disturb cache line state between the various CPU
>       contexts, which are referncing the label, and can potentially impact
>       scalability again.
> 
>    c. Swith the label to an immortal percpu ref, while the scan operates
>       on the current counter. 
> 
>       Below is the sequence of operations to do this:
> 
>       1. Ensure that both immortal ref and label ref are in percpu mode.
>          Reinit the immortal ref in percpu mode.
> 
>          Swap percpu and atomic counters of label refcount and immortal ref
> 	                          percpu-ref
>       	                  +-------------------+                
>       +-------+           |  percpu-ctr-addr1 |                
>       | label | --------->|-------------------|    +----------------+ 
>       +-------+           |   data            |--->| Atomic counter1| 
>                           +-------------------+    +----------------+ 
>       +-------+           +-------------------+                
>       |ImmLbl |---------->|  percpu-ctr-addr2 |    +----------------+
>       +-------+           |-------------------|--->| Atomic counter2|
>                           |    data           |    +----------------+
>                           +-------------------+                
> 
>           label ->percpu-ctr-addr  = percpu-ctr-addr2
>           ImmLbl ->percpu-ctr-addr = percpu-ctr-addr1
>           label ->data->count      = Atomic counter2
>           ImmLbl ->data->count     = Atomic counter1
>   
>   
>       2. Check the counters collected in immortal label, by switch it
>          to atomic mode.
> 
>       3. If the count is 0, do,
>          a. Switch immortal counter to percpu again, giving it an
>             initial count of 1.
>          b. Swap the label and immortal counters again. The immortal
>             ref now has the counter values from new percpu ref get
>             and get operations on the label ref, from the point
>             when we did the initial swap operation.
>          c. Transfer the percpu counts in immortal ref to atomic
>             counter of label percpu refcount.
>          d. Kill immortal ref, for reinit on next iteration.
>          e. Switch label percpu ref to atomic mode.
>          f. If the counter is 1, drop the initial ref.
> 
>        4. If the count is not 0, re-swap the counters.
>           a. Switch immortal counter to percpu again, giving it an
>              initial count of 1.
>           b. Swap the label and immortal counters again. The immortal
>              ref now has the counter values from new percpu ref get
>              and get operations on the label ref, from the point
>              when we did the initial swap operation.
>           c. Transfer the percpu counts in immortal ref to atomic
>              counter of label percpu refcount.
>           d. Kill immortal ref, for reinit on next iteration.
> 
> 
>           Using this approach, we ensure that, label ref users do not switch
>           to atomic mode, while there are active references on the label.
>           However, this approach requires multiple percpu ref mode switches
>           and adds high overhead and complexity to the scanning code.
> 
> Extended/Future Work
> ====================
> 
> 1. Look for ways to fix the limitations, as described in the "Limitations"
>    section.
> 
> 2. Generalize the approach to percpu rcuref, which is used for contexts
>    where release path uses RCU grace period for release operations. Patch
>    7 creates an initial prototype for this.
> 
> 3. Explore hazard pointers for scalable refcounting of labels.
> 
> Highly appreciate any feedback/suggestions on the design approach.
> 
> The patches of this patchset introduce following changes:
> 
> 1.      Documentation of Apparmor Refcount management.
> 
> 2.      Switch labels to percpu refcount in atomic mode.
> 
>         Use percpu refcount for apparmor labels. Initial patch to init
>         the percpu ref in atomic mode, to evaluate the potential
>         impact of percpuref on top of kref based implementation.
> 
> 3.      Switch unconfined namespaces refcount to percpu mode.
> 
>         Switch unconfined ns labels to percpu mode, and kill the
>         initial refcount from namespace destroy path.
> 
> 4.      Add infrastructure to reclaim percpu labels.
> 
>         Add a label reclaim infrastructure for labels which are
>         in percpu mode, for managing their inital refcount.
> 
> 5.      Switch intree labels to percpu mode.
> 
>         Use label reclaim infrastruture to manage intree labels.
> 
> 6.      Initial prototype for optimizing ref switch.
> 
>         Prototype for reducing the time window when a label
>         scan switches the label ref to atomic mode.
> 
> 7.      percpu-rcuref: Add basic infrastructure.
> 
>         Prototype for Percpu refcounts for objects, which protect
>         their object reclaims using RCU grace period.
> 
> 8.      Switch labels to percpu rcurefcount in unmanaged mode.
> 
>         Use percpu rcuref for labels. Start with unmanaged/atomic
>         mode.
> 
> 9.      Switch unconfined and in tree labels to managed ref mode.
> 
>         Use percpu mode with manager worker for unconfined and intree
>         labels.
> 
> 
> ------------------------------------------------------------------------
> 
>  b/Documentation/admin-guide/LSM/ApparmorRefcount.rst |  351 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  b/Documentation/admin-guide/LSM/index.rst            |    1
>  b/Documentation/admin-guide/kernel-parameters.txt    |    8 +
>  b/include/linux/percpu-rcurefcount.h                 |  115 ++++++++++++++++
>  b/include/linux/percpu-refcount.h                    |    2
>  b/lib/Makefile                                       |    2
>  b/lib/percpu-rcurefcount.c                           |  336 +++++++++++++++++++++++++++++++++++++++++++++++
>  b/lib/percpu-refcount.c                              |   93 +++++++++++++
>  b/security/apparmor/include/label.h                  |   16 +-
>  b/security/apparmor/include/policy.h                 |    8 -
>  b/security/apparmor/include/policy_ns.h              |   24 +++
>  b/security/apparmor/label.c                          |   11 +
>  b/security/apparmor/lsm.c                            |  145 ++++++++++++++++++++
>  b/security/apparmor/policy_ns.c                      |    6
>  include/linux/percpu-refcount.h                      |    2
>  lib/percpu-refcount.c                                |   93 -------------
>  security/apparmor/include/label.h                    |   17 +-
>  security/apparmor/include/policy.h                   |   56 +++----
>  security/apparmor/include/policy_ns.h                |   24 ---
>  security/apparmor/label.c                            |   11 -
>  security/apparmor/lsm.c                              |  325 ++++++++++++----------------------------------
>  security/apparmor/policy_ns.c                        |    8 -
>  22 files changed, 1237 insertions(+), 417 deletions(-)
> 
> base-commit: ab27740f7665

