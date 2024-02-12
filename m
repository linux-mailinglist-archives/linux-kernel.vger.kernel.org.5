Return-Path: <linux-kernel+bounces-62086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227EA851B35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429851C21724
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C803D99E;
	Mon, 12 Feb 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oqjqWgA1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A873EA6C;
	Mon, 12 Feb 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758585; cv=fail; b=k0fCQ+ij/EsZ/rGpir3pMPIzaY91jCCTumUlJazluf3vAwygZDRwkAXl3M+95UeofGD6VC6PwiN2V+G1LeQEdPeUhzP5R1569wxlEKnF/TYdqvd+JmODcd27axSI6lX//avG+jLYBQNZ4g0BqfeLYj3ojImwzyLja1H7d1B0A3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758585; c=relaxed/simple;
	bh=dX2Yia9KczH2Vf1Du6AxHjdqMq7Sla2dYUFgVp8XlZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmtgoBUSqPZx7sJ6mOjlZiZb7bKAlTnj1esahrKAnA1Pp6jJIdnDWnWigvOj9QxkQoAVvsa1qbgUiioaS3hdXMH543IrfRREU4f1BrdSiD4NcVHMq178kjVnQjWYP3HIZuISAaLaeFM2Ofg6ufQHzNhzeYzD2W5sO04uYgqPdQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oqjqWgA1; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3t2hdojIQHJxA1mBzrCBROELwRt1T07ti3cqw7AuE3tqow3P40gLISYJSnwW4GZxQlXGByul0sSb/Vk6QcW+4UiCwZXK9V5CALC4HTYYwFz06XUK3JKkfFhKaiKYm47m9+SZeuuhVf6RZ378FNmca56YkhDReOWyoS1k9B82K9S6ZvJYn6z+99Tgu4m46cf/kY5IP3pn9CGHb63A/K83O9j2UZWAT0vPKTPMrMB4bn2v7fYyliSm9RryB2LoYeDSFbrfbfrMRKCoAOTskoexaYrK9qmb1WRI+UKlQhROuRLdJvUIZlfD3GE10UxzaHuoGKVOiRGIx9IOK/EGxmmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VUgfKMEj6zlEmQpCmUbdPmASehz08B7yzk5SGcT1Qs=;
 b=UyOngaO1vjpzXhJr7lNVy6UjuC/9w1tRlI8tEAdUTMqmuVp1HaLzTFE0G9NHYDuSuWlmwdE/UNxIVAx5SHMujsjj+q7frrm4NfzI6JRPxPUAFPU6hI2hLsbLRW73bEp0eDT0x50shufAePPCUD+5DkAOYMspJopSZua3L6s/qARQUuTAMUUJY44pOdkzLkqN5JhPpT2qnyg7kAyLo5hkfxoBpab1kQpRUReMvULGKBOvNbkC5CXc2F4N1wjdHI5hFWlLxPLxf+Jglu7EgqvKqrL6HTaoDB0L2++1T6Jv+pl8dvgZ5d24Wo9/XMi+0fqT3gQ7w9sky4dY71SInqdzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VUgfKMEj6zlEmQpCmUbdPmASehz08B7yzk5SGcT1Qs=;
 b=oqjqWgA1a4F/SfAtyOio+N834Uu00JEySRvzAr4sLHgboCdh6ILhL0egNPJ1ronajp45zJ1iJv8YN2bQDQqKssS85KaXQCaUO5XZoGEZd8yFDPJLUh28q5YTvDqqe7Xwj3C1R2EoWC5d3GAum16TqqDypVD1X2iKaYS3Nzld4Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Mon, 12 Feb
 2024 17:23:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 17:22:59 +0000
Message-ID: <5eb8850b-ada0-4945-b81a-995fd0b8b134@amd.com>
Date: Mon, 12 Feb 2024 11:22:56 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
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
 <20240130222034.37181-7-tony.luck@intel.com>
 <89dc9022-c9a4-42dc-8710-be2d6d9a4e7c@amd.com>
 <ZcZ-cDqGLTtHpB1T@agluck-desk3>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZcZ-cDqGLTtHpB1T@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:806:d2::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fc4ae0-9960-4249-6340-08dc2bef42d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sjO09ECw/VOawCccZpev8PU3j2jDnLyXJEOi1dORfBc1ICEPzDNuTUQE1oVqHYeMsthn6FM+zIZPG0fpkLwk6rw7Y8wWuGqq5gQFkt60FYrgbfeKX4o2S8PYYg1dtagEeJXnAIJeTeYIKqcVQHXRhbrpVy3qEVnG1Wp5pP+CDfEVSGdrEZAh3eFSi2Lfr5aFixKQn8tW9C7HtGsZEQjyhpxeQWHWRvWcBgME1VKx0TCx5DAQ9ab54aMd+dYeCxZd+2QOVEomAyX0lnSnX3AkmepfJAvgaTXcO+e8khzAtzvhU7fZap61s4k5TWHitoczRu3tzx16m3EtnP66w00XyKu9wMxpiHYm7S/Eo1Mgmf6UtRs8EsD23ZPYn5iL/O9+7yYlxZnyhGH4Q3zufzcJkw5m6bJXDngzQzKFXE5AQVpfYmPxzE8qBovH+ct3CBU41ofUCYt2QwTp6gHciU54RKDxN63ZDyBED3CSF9NZxxdOAjM1jQ8ikXiaHiLRczU8Dwmm5RSr/c0AdeMRN5X+xfgMTlspK8vaC2BzeHv1ppI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7416002)(6666004)(66476007)(38100700002)(31696002)(2906002)(86362001)(4744005)(3450700001)(54906003)(6506007)(6486002)(966005)(5660300002)(478600001)(53546011)(4326008)(316002)(66556008)(66946007)(6916009)(26005)(8676002)(2616005)(8936002)(41300700001)(36756003)(6512007)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2RCZk1ieTNiVHErU0xJbStmdkNGZWVIOVpCZmtyY0lXaFRKL0t5Wk9TV1VD?=
 =?utf-8?B?cGJjQ0NRV0FodktZdDJQVHFnYVVUK21YemluUm9hZWgxL1JCVDNyQ1Q4OWtS?=
 =?utf-8?B?NXU2RGJjSXdzdUJlRlNZeDJkVnNkdUlKcnFGY24vTHNYZ0dvZVduTGJpUHhB?=
 =?utf-8?B?bmIrK1duRThFNkpYcjdNUU1rWVdhWWMxRzRJKzZGd3lEMlhpUVl1UGZNWThN?=
 =?utf-8?B?SWVxSEhMZUZ1OG9ldm5ybUE3aWpyZGlrS0JDWHNxWXJaNFpMRGlLNDZKNWFX?=
 =?utf-8?B?ajJLV2c4eDhsRjF5RmFZeGJMU0gvOXh4REhwVDdMTlMrWGxNYVZQQndGUmxF?=
 =?utf-8?B?OFAxeEswMnQzc2FoWEIvbzJPa2JabGtEUjRVamdCS015MXl3Z21yV1E5Z2o2?=
 =?utf-8?B?MzFPU2RHZ0tPa2dvbGxPKzR5ZDdwQy9KU2ZubGpuWGJ4R2V6aXhBd2ZuQVg5?=
 =?utf-8?B?RTJWamhnL3hNdm1Sejk4emNsRG5heU5HK1puNnFEYnc3RFdNM0hiK2h2Ynk1?=
 =?utf-8?B?TStKb0R6MFBDSXY0OXc2QThOeWh1dEEveUZ4MGQvUHQ0cWF3MHN5cXh1U1FC?=
 =?utf-8?B?UU9sSk41MDM4bGJXaUdHRHBRRHdrclFIZGJZSEVmZTJ2Mit2WnMzUEJFdC9N?=
 =?utf-8?B?TTVqT1NhSHYwQjEyakdtTms4aG1LbDZ4dEdEQ01HTXM4QjlBT1hlemNjWlFt?=
 =?utf-8?B?d0FWTWI1Ri9xb1IzMWlPcExZYldySENhWXhDamRTVkYzRFZLdG8yVnN6Y29G?=
 =?utf-8?B?VGtGK0JWblVKVnVjUERtTUtnY3dWYjFDZ1hidFdxWG5SN2V6ZFdRMWNtQUJk?=
 =?utf-8?B?TjhPdUFDS2t6N0RPWGgwYlVOdlJJYnhiemZ1SUFQTjhKTU02YmxkTHlJU3RI?=
 =?utf-8?B?NkVJa0lzWXBQSEtOYUdVb1AzcHNqTGZacjNnT2VTMTMreEJVcFlSR2NRKzVP?=
 =?utf-8?B?ZEJYZXFXUTE1Vm1XZUxGVmNpMEJvNUl6eG85UllwWGhzdFN6RjZNWFVnaW52?=
 =?utf-8?B?dDBVM0JIampkQ1ZWaCthOFVGaVRRS2Z0V1RjUE8vMHVWVUlXUU9nM0V0bUlq?=
 =?utf-8?B?bSs4ZFYvaUZURi9FMnRTalpTd3Zxd2RTbTUwTXByTmRkSEhUaStyb3lCNE8x?=
 =?utf-8?B?eHRjUzRBRllLK1BVbm5neWQzUmpVYy9ONkRPWnRVSkZRbW9WaXBLb2Z0VUJp?=
 =?utf-8?B?VFE0WjJqeDRCcnBlMENGUUFZZEhtaUh2c2lKeFU3SnZQSlR5eVo3bzYwWGw2?=
 =?utf-8?B?UXJLVTNHKzZVRFZSb2YxN1hUdllURXBoTzJTcnpzUkIwM0FnS05EZTJUcUZV?=
 =?utf-8?B?bk5qK1RJaXRpSzlRb3p1c05sT09ibFhlL3QwR01VUkNSWHh5eFBWUVJ5eVc5?=
 =?utf-8?B?dWhyT0doNU5rUHZPaVRBSEdjWWd1WWEyOEVYbmxoTjh2T0dHTlZ2TVduV3lh?=
 =?utf-8?B?T2ZWM0lRaHdLUDJvWUlwTzFnN2FPb0hiaXUvbU1uejNzaFlsUTNzREpOOVlj?=
 =?utf-8?B?L1dXYm4xR2RKVXd6cFdXZE5NejNoTGd5aXplNTRXQlBZQS9qUVJFWFFOcDZL?=
 =?utf-8?B?WVMrQXROYTIzZ0NkRG5PdG5EZFZ4dmpDWVZucmhyRU5RU24xcTFVa0NzbmhS?=
 =?utf-8?B?L0VWUnJBdVpCeFBaTVdsTnpMYUJuZzB6NmhuSVNLWU9QaHZZemJMUmpRNkI5?=
 =?utf-8?B?Zk1HcitKMTN1VUc0aG0reFBxVlZJSnBmanRnY3ZyLzVBY1VLOWZwaDdnQ2Qx?=
 =?utf-8?B?YndxNThuMVQyVHdSODVtRFFzWkQrUS9Kbis3RHYrbVJJRStOUjNKVDU3Z1Ex?=
 =?utf-8?B?Um8zaUsvVXBhdmgvNGZIenhxS0JvUzlZNEdreXpTRGhVSy9TM0JQbGI5TzRP?=
 =?utf-8?B?bzZ3WkV1MHg0dGsyUUdKSC90YXhsaGk0OHNSSDNVbXNGOVdsaVRuTmtYUDJ2?=
 =?utf-8?B?MUF3K2VzdndMNVREeWk1T3M1VmJHaHdyc1JBN1UwTU9EVHR0eVdjM1ZNUDZJ?=
 =?utf-8?B?cDdNRUwzR2Fhbjk3eVNSbzFJSzUrUlNmRVJDNHZhRVUzajR6RlJ3WVJ5Y0VS?=
 =?utf-8?B?UTIyaGc1Skw5VGxtanNpYng1Q2NDVmVxTHFBZ3E2Kzhud3hjMDFEZUl2SERB?=
 =?utf-8?Q?nZY4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fc4ae0-9960-4249-6340-08dc2bef42d4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:22:59.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TeuV3eKIbQ/TbIYMmBJ0+Xi6dODsrptrfTLemPfpTOL9j8x+FxDohfqed0LpKqGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676

Hi Tony,

On 2/9/24 13:35, Tony Luck wrote:
> On Fri, Feb 09, 2024 at 09:29:16AM -0600, Moger, Babu wrote:
>>>  
>>> +extern unsigned int snc_nodes_per_l3_cache;
>>
>> I feel this can be part of rdt_resource instead of global.
> 
> Mixed emotions about that. It would be another field that appears
> in every instance of rdt_resource, but only used by the RDT_RESOURCE_L3_MON
> copy.
> 
That was the comment I got earlier for my patches(search for global).

https://lore.kernel.org/lkml/47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com/
-- 
Thanks
Babu Moger

