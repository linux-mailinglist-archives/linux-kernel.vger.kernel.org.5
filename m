Return-Path: <linux-kernel+bounces-42085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7783FC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24D0B22147
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B8DEEDA;
	Mon, 29 Jan 2024 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HpeXx1yF"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC3EADC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494906; cv=fail; b=BRvpx1XdatFb6zd66ZJ2xs02NGOg5Zu3wv3n2zbqIHpb6DaKMoHWo7xxTJ1YschGF7FlsNA/Qw3WZuF+wAeNXqLayIqZ6kMD//u4UAItk0169mjzb6qBkYTiJP5A3at/Hls7qzlPNF/kfvhvfudcOb1/ZnJtFQPNiIUUX6JkLyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494906; c=relaxed/simple;
	bh=PhpsI4kkmIrwjqleXjptAKrwENujnBfD1d6KJYTyU+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JVPPqYIkhITRFSw1oqNXrcae2WodM6jC61yqWpvuEkc2ws1F9fHmnaAqmcvPIGQCEzxB1RYlnouBvIoG6LoVg6q/m8VjaxfX9LLiAmDsu7TEietCBjp6kR/gE29JA4zs6N2hcgKCzqd51gNBALjvBc9TkzbE/siZSdwHAyWNQ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HpeXx1yF; arc=fail smtp.client-ip=40.107.215.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuzmGVTtYFxElYpB5ngg3Khmoj8oEoUDExzyBbAZ+R0MPS4TxFsQ6OCbKIou1wPtrotk6MQZ9oU3EIct9/rW/N8c5FaDiMQwJi5ljAj7F4FEM2JMEUMNgdJGCOUGzejmy4xQgzS6KpRMnqsZNcAOyzHdRkf6N6PXzTthmqRGmxwTtnzkjDWb3vbjXyjAsMbkOzplrzrpTZtMzD8R8wz+3TmABFS+XGRoMAq03QLJplmiLQmh54rynpthwieWRqxxM+Cr48RWnDyVXgZWyLfzHIX4963ekffAvLsCmmXKjwF9QAXbKpi3J+pJyyUzh6VWl7iwCMI1pUWReWXHxc/t4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zR4YGXUOfKbQJDSmH7CCn+bSppJgxmBPbzsLZt3iSdo=;
 b=EiMyi0VsdAZxlgUiX4bDYeFP9cSociGbtxRviHtHA36TtyYZp/YBz3wgpzvcEdegLJGkgLFnXyN+jp59ANoKCXAdC+DkyB3BzAoRS0D3Ca1EEeDxAj2lC3TwF/+Wn53GZHNHqz1qPuBUq+SYZoln6PPgouYcruXdMIRCW/90mkD/owbx8du/gvjOCT8lO2YcmwpzvL749UTlKtaCWBhJQmYaRuirnzlJrMK4ZWuqAyrfeqf+u/jWnWjnnbOeRElTlH7e0po8ouzAoNVQU4UpP7juyC4aXhWn5x7rpqvjWVninairc+lhGS64w/qXMrKgkhXLjetgHG+oJsLMoKU+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zR4YGXUOfKbQJDSmH7CCn+bSppJgxmBPbzsLZt3iSdo=;
 b=HpeXx1yFnzYQf9vGTqLy3VXfNtwBVTaZQKYPHvn8Lk2w2VH8YwRJ0eRntVHotwRDaLHJP7Dmhb5Zq0rBMcvp6+4KLo5szD9RS2vz2qBOa0kXif8+yedSRXjMDSTJsBiBzYNlg6I3yItw/VtEqx8QZqwcy1XSVr3uRLeVsIc3rH8HcxUgbBedbdB5IoFjMSpEiIaGqs9kFe4fz6RLeIENR9zWyis7dzs3RlARdHOly4Nuzbt+xUBQ48rhm8r7A5HqwwxDAWXSvvPONuBILqINnMdsjKF7PGZcLXGPs6YSlWWrIIVW+1ZWAfk7peX3qN6FTcJHe+YqFdUkKZQ5DKBxKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB7430.apcprd06.prod.outlook.com (2603:1096:820:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:21:38 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:21:38 +0000
Message-ID: <9af163e3-fa45-4fe0-a95d-28096aa9909d@vivo.com>
Date: Mon, 29 Jan 2024 10:21:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:vmscan: shrink skip folios in the exiting task
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240124124308.461-1-justinjiang@vivo.com>
 <ZbEOrim8tjMXB5os@casper.infradead.org>
 <726d018c-01d0-48b3-870b-c63fb06eb0d0@vivo.com>
 <ZbX1uEbrN-lwnnaW@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZbX1uEbrN-lwnnaW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: b06294e6-f7a9-4121-c117-08dc20710645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qNAUrD51J+pguLpgxUItFwBH52FJh9/vLrv0ubTyKJcxt7wgjRlVFeoPJmsFX9Obgj36WCiIw8FcWdFHn6ulG+YEF/jfXX1PE30kSHOUAsgRmtLA84Fk/0rMywnQHpqKcMY9Lj1NNhGGsBENXpAJR5vhvZ6YOwlQ7Uorb0XNiLA1RFHUfPD4gIUhQPWsnwzJ72PpfnTnBmibe5o0i038qQ6Udmyik0kRCkhsyJUniv+5j44PzbvQfYwk4ipotBW4Ad4EQBCQBUNCTcn3jXeDastdu/bTlw+koXnf107EG+hZMdHNsNRv6eaXEv/noeibVzDush0JzmDhK1ZYS8fe2NXzZ5iEFCF5u0cXzsLiOsQhZSIdAbxAdQjCQVOSwIv+jCUQ4otflio6p55N5fj3eZfkyviFTdovpS3NQ9YbBuHpkCVNBQjGob/z2y4DxVyZF3X1/6V5Gju2HLBus+1K0vl8cHvJkfazYFUWYyxl3Oj++KQXLjKt7X5KIFddL3YZsxS11g/mfYFrtkbLkeKDJJH8sSf5OEEqvqCcC1I+fLdUYCOhpCfycL7O/Q9bkHrudUF0HZhaNhK6DwmibTsecQKhBQX9wZaXDgi38N0v0LthXvYmib/txOzxt2nvOVMOV/iHlW5TvZyH39E2gHMr409EGY4yMjA5u5JszGELdA9719NqBq6Pgk1bcpIKM/ng4LqEaWHO5cjNnnKcW2epda0ikMv0WfOw4FwDyGLUcGsdITY/ePKkASfPnq2xs5zR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39850400004)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6512007)(107886003)(26005)(2616005)(38100700002)(5660300002)(4326008)(8676002)(8936002)(2906002)(478600001)(6486002)(6506007)(52116002)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38350700005)(31696002)(86362001)(36756003)(31686004)(43062008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2s4Rk5rRTN6dVVtanFJYTBIUHIyeFFzOGFEOGtOWHg1K1hhQjM5R2lSdmRZ?=
 =?utf-8?B?Ty8yZUZpVlpOZGhSOXliTzF0VE9zU29CWUo2NXQ5czRBVzE3YVVsdi9SSDFY?=
 =?utf-8?B?OVAvMCtuTmNxa3JMWlNtb3pTTVdxdDJoZEIxR0tDQ0JsaFVSNHVzQ0NtdHlr?=
 =?utf-8?B?aGhHZHlGTm9jSGdCaU5nb0RTY21nMFkyUWNmUGxKeFdXTk43Z3BGR1BQYmVw?=
 =?utf-8?B?VmVoWFBiR0cyQ0E2RmNBV3R0RXVEQTZMRkdwbnhZeDdiUVhpY3BwbDdUb3FD?=
 =?utf-8?B?M0R5bWJPUk5rM1VIbEtlajZPTmVQY2lnbno1MlE5RUJYYVRsSUU5TGNLakF3?=
 =?utf-8?B?YWZMTkFERHRNR3BqVGhNSVZmTG5oN0piNit1L1BKTUoyZWVXVEZQWEtnV2Yv?=
 =?utf-8?B?eE9KOUg5SEdFTzNGMTdBWmZyWFhlTEorTmRoREU0enFWbUdGOFpFVkdMdlg3?=
 =?utf-8?B?SzBjUXJNejMyOXZZd0p6WFFjVHUvSFYySnZkcm9YMUtQc1RraVpTT0szWmRH?=
 =?utf-8?B?M3M4ZmtvZGxXU3NwdzdZamhyd3UwTEFnMzJWUW5UdXRNRGViY1JVNGs1L2Nq?=
 =?utf-8?B?eG1YYzROSlpZVDdzdW52Ynp0akZDWlVsYUpjOU9PVmdqSjY4YzNqRmVsWWZ3?=
 =?utf-8?B?RUNaVjdwR25kYldmZlIyRUNRdGt2NGpwcFVyQ1UrajhFYkxBM0RPVlNqWUVh?=
 =?utf-8?B?bVBxL3phQklPS3dEVjNXRXBDbVpHOVZZTWJHYmxpSnJQeXRWZ0JPVlh3VWc5?=
 =?utf-8?B?ZGZHRnZTSTJNL0I1KzF4czUxTGVNckhaNmtXRnBTYzZGRGZwWUJMekZtWGhK?=
 =?utf-8?B?WnhCdmZwalQ3UGNSbTR0eHJqYTBjMEg5dVFyNlFWNGp1WUFSTDZ0Z3I3V1ZN?=
 =?utf-8?B?dWNMdW91Z0V5L01YM3FvSlJUTFNBbTlYMm5oeVl3WkttbzExZ3lLZVFoVDlT?=
 =?utf-8?B?VGNCTjhFSzZLTXVwaDdKbDlWVE94dU5rRWpKVjM2WkZtS2NJYng5dm1DOGh1?=
 =?utf-8?B?QU9PcnVMbUpiYno3ZWcwU21FdFd0aHhJTFJ2RlZJZ3Rub1VhQXNJZ05kcUNL?=
 =?utf-8?B?blpFTFg4N3hIYkdZdSs3Sk5abVJCQmFoQ3dvemllYXp3UEZyYXVzc3VTS1p5?=
 =?utf-8?B?djZ4SCtZbFF3RCtIKytoR3JjVmV6ZUg3bmpmQk9iaHp1MWxvRHdLOEd3RFhR?=
 =?utf-8?B?bWJNZmhheStvMTFXQ09vVEVwdjlxZzB0L2FCa04wNlRvRnBGRlJRSy9VU3dC?=
 =?utf-8?B?MGx4am5lRmdIeHVPMHdFU05rWWpQenhScmZwTE8wUTlvNG9aeVZ5L0NWSEl6?=
 =?utf-8?B?NGEvS3IzbXEvbzc0emFSUHQ3Tk1tSVFtTm51NjhxL0V2R3ZOUzlyY3ZNcEJy?=
 =?utf-8?B?MkR5NWdla293U0x2V2JhSlhzQVMxY3RsU1RFeFA3clpETkxNVVBzNy95Sk44?=
 =?utf-8?B?bWpvS2NKUGVMVXpJWTBnMHdYV3U1THhZcVh4NDFwS2h1cUk0U2NWbVJFVXNW?=
 =?utf-8?B?R2RrYW1qckNnc1FUZ0ZpclVOMzIyNVNtOVBHWk4wZXorQUJQL3BOeEJ0SzEv?=
 =?utf-8?B?bXpjRnk2a0Y3Qmx0TlJnazJjdzNnU2s0b0V4RnpSNU9KSDdJeHJIUXBCUllv?=
 =?utf-8?B?OXN1TDhPVXhhalhyM0hCbDlPMkk4cUFYTTdrb3ZVRDVzcHYvV011NGVQTlI4?=
 =?utf-8?B?MC96WnFIRjJSR0ovd29FRExYMzdtM2p5OFZ0cWZINTNNL0xKVi9HRDdYd1hY?=
 =?utf-8?B?N3pIeUlLT3pnMTE2VDhOUytIRUpFSkZtWjhmTk5EMDdpQzZKOWNjUCthS3R6?=
 =?utf-8?B?MTZLeitBNEJ3aHhta3ZWN0xscWdMT3NHc2MxbnFJV1dOSVl2NkRwNlhiNDh4?=
 =?utf-8?B?eEg0RFk5VnZacHphd0JobXRjTWgyNXlqREdRTmI3QnNyenZPb0dNb01jSWJJ?=
 =?utf-8?B?aTQ2NmtlRzlBNTBSSU4wQVMyK2hPeDVZVk9jSDNBeXFlc0lJZXNSRVhHMStU?=
 =?utf-8?B?cU9CVlRiYUxCWGk3VHZCTmllSVRuR0FiYVg1TEhaYXI0OVdMNHZodlFrWmo3?=
 =?utf-8?B?NGtSWTNJOFMvNmpPenlNUUs2TkxyaUd5bDBsUVpXWWNMd3lKdGEyUDA4and6?=
 =?utf-8?Q?0mWz/vp3mmW86KBWUMtCKDtJ1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06294e6-f7a9-4121-c117-08dc20710645
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:21:38.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdB9FT0OS7BxBxBlaQUdRDvl7Wp5aRw/mZt2QccC0glsvofdGtQnWHVO2DrUwSpOE83qE1+mEvfCw5E71dUUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7430



在 2024/1/28 14:35, Matthew Wilcox 写道:
> On Thu, Jan 25, 2024 at 09:34:53AM +0800, zhiguojiang wrote:
>>>> In the scenarios of the low memory system and mutil backed-applications,
>>>> the time-consuming problem caused by shrinking the exiting task's folios
>>>> will be more severe.
>>> What testing have you done of this patch?  How often does it happen?
>>> Are there particular workloads that benefit from this?  (I'm not sure
>>> what "mutil backed-applications" are?)
>> 1 Yes, this patch has been tested.
>>
>> 2 When the exiting tasks and shrink_inactive_list occur at the same time,
>>     the folios which shrink_inactive_list reclaims may be the exiting tasks's
>> folios
>>     in lruvecs. And when system is low memory, it more likely to occur,
>> because
>>     more backend applidatuions will be killed.
>>     The shrink_inactive_list reclaims the exiting tasks's folios in lruvecs
>> and
>>     transforms the exiting tasks's anon folios into swap memory, which leads
>>     to the increasing load of the current exiting tasks.
> Ah, we're talking about an OOM scenario.  OK, that makes some sense.
> You should have mentioned that in the patch description.
Hi,

1 Ok, I will update a more comprehensive description in next version.

2 I think this issue can occur not only in OOM scenario, but also in
   normal task exit scenario. So:

1) if (unlikely(!atomic_read(&vma->vm_mm->mm_users))) represents
   the scenario where the task exits normally.

2) if(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) represents the
    OOM Reaper scenario.

3 MMF_OOM_SKIP can only represent OOM scenario and cannot represent
   normal task exit scenario, as when MMF_OOM_SKIP is set in normal
   task exit scenario, the memory folios of the task have already been
   released. And the shrink_inactive_list should recognize these lru folios
   in exiting task before this exiting task releases its memory folios.

     tlb_gather_mmu_fullmm(&tlb, mm);
     /* update_hiwater_rss(mm) here? but nobody should be looking */
     /* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
     unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
     mmap_read_unlock(mm);

     /*
      * Set MMF_OOM_SKIP to hide this task from the oom killer/reaper
      * because the memory has been already freed.
      */
     set_bit(MMF_OOM_SKIP, &mm->flags);
>> 3 This patch can alleviate the load of the tasks exiting process. This patch
>>     can make that the exiting tasks release its anon folios faster instead of
>>     releasing its swap memory from its anon folios swap-in in
>> shrink_inactive_list.
>>
>> 4 "mutil backed-applications" means that there are a large number of
>>      the backend applications in the system.
>>
>> Thanks
>>> And I do mean specifically of this patch, because to my eyes it
>>> shouldn't even compile.
>> Has been tested.
> That's odd.  I thought GCC used to complain about
>
> 	long x = 0x100000000;
>
> but it does the right thing.  Except on 32-bit where it'll say
> "warning: integer constant out of range".
>
> In any case, the number you chose is not going to work on 32-bit systems
> or on ARM or x86.  It conflicts with protection keys on x86 and MTE on
> ARM.
You're right, I overlooked the situation with the 32-bit system.
> We can do it without any new magic numbers.  I'm not sure this is a
> great approach, but this should work:
>
> +++ b/mm/rmap.c
> @@ -840,6 +840,12 @@ static bool folio_referenced_one(struct folio *folio,
>          int referenced = 0;
>          unsigned long start = address, ptes = 0;
>
> +       /* Skip this folio if it's mapped by an exiting task */
> +       if (test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) {
> +               pra->referenced = -1;
> +               return false;
> +       }
> +
>          while (page_vma_mapped_walk(&pvmw)) {
>                  address = pvmw.address;
>
I agree with your point of view. I think this is currently the best 
solution,
   but I think it also needs to be added with:
if (unlikely(!atomic_read(&vma->vm_mm->mm_users)))

Please help review it again.

Best Regards.



