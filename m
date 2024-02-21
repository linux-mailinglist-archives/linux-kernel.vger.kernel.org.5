Return-Path: <linux-kernel+bounces-73912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9685CD89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31861F243D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613F4C7E;
	Wed, 21 Feb 2024 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZoP4TGBv"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540264428;
	Wed, 21 Feb 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708479883; cv=fail; b=CWJaBi7TJcmzfdRE/YgDCcIz9LdwVqwtXCn8T4Z59zPOSRvcJIuD/EiqAEUI4sgTsab/Ob6tNEIPzfhalYH3h9cCNz9Nhr+mQ9YMv9xpUOaXokT0N3alfq1qebqbDFJ5/ElWdTd5fQGMsLUEtjFV32jqQiZXYQGH/xD0GrxdLpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708479883; c=relaxed/simple;
	bh=WHdvgHuKUB8kT08Um2BI/jzr8lTrLl8O6NHB9y+QW9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dWybl4NI3q+ZMG1Pc8ExMzd29oPtnaJ1AKPZ0B+vCJDN5A82CkFJ6QTMKn4FuKjmahnvYoXsPpDNaJBSZfbwJpvropc2FyZsAZDL3Je3iQlhTbwkBC2hVy8+Od+BQSxMRguvk9FNJ5/dszhXEmwMIdftB/Bf7hdIioXdX1tB/gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZoP4TGBv; arc=fail smtp.client-ip=40.107.215.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laybEkJ6nIXIKqnlZ/mnRdE+bjfRoT66Kftsu572gu1cpCjiEHFf+cNIEMS14ab4qu0637N7yA175dSF/kx0VNMtoPjhp5mNLJwnRaxRB+Huzz/ePIhXQsQenLUO912TRP0ySQum6bMHQhdVSIgFnpSdIvksn8xNZJthtftEm26oKc8+Ipdww7H5FuyQ5l8DMWQdXWShXjF4d1UUDJAtvGnyyWTQTLRcljmR20eT9FKYof/y/mqwtJORBzDH9fP97ruZNsfZuhCyYXT78Xuciu4MW/O4QWZC2uD7klwqARBJozy1WKqTMYeJigPJE8aunZwZ56Rel+14Gthat8fswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=F+XN6+DHhRcCKNk8rUBjBwDBW9FFdA7kh0pprlFaQl8M7aXLjVoWv/aGj5+cZNZkXA7gYklHGnyBgjoK6ay+gI99xb50zFyqEOXjQ1stKnbpBMPPM4o0YbmFxg6l6vr93U4bEZkAeFD2gTkh+acExhqL4jT2tYCPrf4x9dN4L3gTQ3vLnYvaXlRJJJh7mnJAIRB/1B01NK6Wz+/ec6fahUUtHBTgzbS958tOCKlzCJGXcLbmHqScFb37kq3SEfUd04Imf9ycBuPYfzfGNsjbwAQXhdaYw0E4eOAPmK+ur/wFZFxUVeEIEG7dHi9imEvYFkL/X/2O4DAtYl5ff27klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=ZoP4TGBvIPI/8vgpYYAKaBU6wT7IKaqY8raNTTaNR2UNsj1xvgMieukPFsAOafS23RZy54+DfbFWHz5oJvyvOAjM0WwtTsxSOH4q2mA8nMkTfGV5yVsMvEQbf0gEsF1GPkt2t9vV9aByiZW2LKEDUc8ARrN2e2TW+uXvW3FLBRuLG+5NWCSSTQKnP1O33QnW3zlqr+5rGocf0zhBk/rS02hK7zCZXAzphQxlaVD/yUrM7mBOd2DW/zvWQQqj54+h2PNK+kRHrIpUivYDra+Ggfwn7INjIBqOt0BJQDMXtiv4fbzFIQ90Osuj9+EaTcfWA2a8Tbe4SXQn2rJqr6cvug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by KL1PR06MB7367.apcprd06.prod.outlook.com (2603:1096:820:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 01:44:36 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::8865:1c6c:513:4a68]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::8865:1c6c:513:4a68%6]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 01:44:36 +0000
Message-ID: <fac8d079-100e-4b8d-9a35-db8219b28b51@vivo.com>
Date: Wed, 21 Feb 2024 09:44:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v6 0/2] Make memory reclamation measurable
To: akpm@linux-foundation.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, opensource.kernel@vivo.com
References: <20240105013607.2868-1-cuibixuan@vivo.com>
From: Bixuan Cui <cuibixuan@vivo.com>
In-Reply-To: <20240105013607.2868-1-cuibixuan@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::6) To TYZPR06MB4045.apcprd06.prod.outlook.com
 (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|KL1PR06MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe4873f-5096-48a4-5835-08dc327ea8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4GhZf2cJipiB6mnJEFcpDXJDRw+UgEB5wwpoIQ7KWjvPgSkJpGkwvXlrAC2N/j9zzGy7FsWdlan69IS9+f3EizTiToMB0+LPNuBKchUNLQtS852AZfK+qnOOYxhuHvSKbiNX7e2UYh90GqMwYkm2p/npShEX7ivnvI0uDZSkT6uARII4x5q+d/A6pHkd8yv0DhaUbyI7Ffi06bFDeXjfTsTtAWITy6bCF1Qs6V8JE/BrED/bPRnRUB64wwkPu22jlJww0tFiXujwYfnmXYH2Yt6Rz4X/6tctOMH+4E3uWyKIy5QBJoKxGzFrfwa9yKQaBIMU7m2i7amViIP6xjQHx3cdo/P9ausUn0HkZqeLL8f6vGyvIIHKmArqvmsXo/MAAwj8m62WGWnHkdlZYa+yK4yzsgbXBOTNnI54Wx96bHKhZchlgrxETmxiaDMj2lXXm/49JJg6zZEGd4T5ItUpl54oLfhRYjzLCoTEawrkdiORg8xwr3FxlQQRWP8YiTR8nMMhZH6x47yjoWlphMrcwCPk42vfr/EWcebO0oP4G8SwrS+SmalC6EmT87T6HSOzdJfUOdU1AVdhNHWq6cgGEK/57a3o0mytKWq3N7oSS6jy6vClHFXp9o1QQTFlgG+G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFYSDIrNzFRV0dNUTdsMzlhNk5TaEgxNXNkU2EwcWpQanhUTEhUS2Zlc1JC?=
 =?utf-8?B?N2ZxRUt1ZmxUWC9CV0FOeFd0VEF1eStpQTFSMzNYYmgwbDRpNy9EbTVOMEtV?=
 =?utf-8?B?QTN5OVhWRDBRNUs5YkdReXp2MjdRbG9vTXJoRUh5RUVjeU9oYzJ0YWl1eXVt?=
 =?utf-8?B?N3pzRGVqaWJaNFZINWczZHlxY09nYXp4SjkrQm81Ym0vQVFzdW8xT29ZRUlj?=
 =?utf-8?B?cCtBNEkveGsvZVZTb2d5VUgzdUN3bkRRWFlJMFZxUVdRSEdpTlh4WXhQU3pp?=
 =?utf-8?B?WEp0RldmVU80MHpJaTNEcXhBQlBMUUZRS1UxSlBid1Jldm8xY3FENDZjZnVh?=
 =?utf-8?B?NExPaTNWK3JMbk1McTFFdUZ6aXc4TlJUbnJyUkJWU1lTSWZxR0JtUGRjREZo?=
 =?utf-8?B?ekk1NTlBS1FsOUxWRzNISjdGN0RvU0syaWRhT3JaWHlUV1dTdnJrakk3SGFF?=
 =?utf-8?B?QzJBVHdEWVlpNkREQW0rVWI5UE53UC9oejQ0WVFYNzY1bDF5TENoTG1UMHpK?=
 =?utf-8?B?dnFlWi90MmdNc08vNDRPbGR1OWVqOCs0ZTluNW55aTVqR2hEU2lLdFErdS9N?=
 =?utf-8?B?bVdpOTBLOWEvOE5LVUY1bnF6ZFNMaEZOQzZ5YnpaYmtrSU83MkZKb1RWZ09F?=
 =?utf-8?B?Tk5RKzRJMmMvVkx3N3lBSkZvWjJUeEsrZnNhckxERkpvZSt3L2JKWDlOYko0?=
 =?utf-8?B?clFBTzlhZG0vU3Boakw2dGdwaTBGcUdPWTFBd00xZktneG1UR2RCUDZHNnM0?=
 =?utf-8?B?c2RHbDZBSTYvS3I2b1dSNDJxVXl5aWNzSkFudVhCVjJqWm5nTDlGVzJmazFr?=
 =?utf-8?B?ZFNaZ3NFZ0Yyc3JtQ2J0aFhHOEROYTRtVGFCT3pSaHZIWTlwaHVublJMVVRP?=
 =?utf-8?B?cVJnOW5OdEF4Y3duRU1RU0Fjbm1sTThidW1uNVhrN2VrTlRyV21DUWxzWjlm?=
 =?utf-8?B?TnJsOEdSVFRvOE5wWTVtMmtSVHZaZ0lDbURSQ3FQYlZJMThQc0g2b01LSmtD?=
 =?utf-8?B?S1U1YXdRMHVRV1QvcXZ5cXNoZC9ML21BTkdkN2gwVExRWC92d0VoMGh3YUJx?=
 =?utf-8?B?UVY4QkRaRS8xbHVTaTdkbVhIcm5Ra1JnRysvb3dnRG5GWnNJZlZkcVhLREZU?=
 =?utf-8?B?MVZSeVk1ejhUVGhlQWpKYnd1MHNQVC9rUjNWY3U0QWpMakpkeTNFcGp6QzNU?=
 =?utf-8?B?VUpBbi9OY0Q3MjFXelFEbzVCaUxjeTh4TXVSNUFIUE0zaWs5Znl0b0EwaHdT?=
 =?utf-8?B?aUgwU2Z2bUJSQnZHbnpuUG5IWXFucTFKVCtXMUVjdzRzTHJrMGE3SlRod2NK?=
 =?utf-8?B?ZDJNaDNrNUJZbitkYnJJa1dBOFMwMitVVWxrWFdsTDJiaTRpaU9EZUZnMnFq?=
 =?utf-8?B?VGIyRlhyYmhrUWFvQjNqUmhrdG1Rb1I4SnkyZlNPRXNwMzFOaDVxVHBkeDZa?=
 =?utf-8?B?WEpuUXV4UXpjb2J4dWc0cWFtR2hHRWRieVdXeW1tZ2lLYVhnc2J2UEpDVXhv?=
 =?utf-8?B?YVVSVEd3d1RweEV5S0pIR0VKdWdUdDZqRS9mS2xQR3pWV2hTUVZEZXJIRytZ?=
 =?utf-8?B?Y0NUUytYb0hEZnFsNEYxWDk0cXR0ZXVWSHE1STRUU0o3dVZ5eTg3WGFkSldG?=
 =?utf-8?B?ZEw0ZUZZZkdjYnNvbENOdmF5U3ROMHc3OGJkL3o1ME9IRlNyNjc4RjB4d1Jl?=
 =?utf-8?B?REJaRU9XZ0w5bjZRRExXSk5NRWxWSzFuNlNQQTNRSzdRbXBHUkVEZURXVXdl?=
 =?utf-8?B?MjVldUlRMGhKdldxWnA3bmFJbkFLS0huZWdRQVUyS0pjVUNpOC9xcXJkRi96?=
 =?utf-8?B?d20yVEYrWUlHRmRvMUx0QVZLSXlYalN1Zy95MThaTXFpNTBhaXZPT091UmN2?=
 =?utf-8?B?WENxODJ4Ujl4OFQzWDhjbHkvMFBNTzdMWGxwazJ6NE5oWnM5cmhVM2h0Y2Z4?=
 =?utf-8?B?M2Z3ZkxDQTRaczQyWkljLzRoVEl6T2NwQ2pKTngrWE9vcjJKbVhNS3BKbVpX?=
 =?utf-8?B?OTZRbUQvWG13YUtLbWdGSkVWRStCZ0VCUEtCTXNmQ3pKcC9HUmdvQXJqSzNo?=
 =?utf-8?B?VkxPQWpzYlJqQmhzb0tTTDVWYmlYcEpuUGFuaTlsN3ovSzZCT3Z1WG9ZK0g2?=
 =?utf-8?Q?yfeSVALUfK6YgedtKCNDyCmGL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe4873f-5096-48a4-5835-08dc327ea8f8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 01:44:36.2897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US9GSrLuBTMA2nP/M3lBvPDfZWY79EU/gXi2X7IXU4JQKlVYe70bC0tVdAx3ftmVa09uJQFb/O305Qbvqu4egw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7367

ping~

在 2024/1/5 9:36, Bixuan Cui 写道:
> When the system memory is low, kswapd reclaims the memory. The key steps
> of memory reclamation include
> 1.shrink_lruvec
>    * shrink_active_list, moves folios from the active LRU to the inactive LRU
>    * shrink_inactive_list, shrink lru from inactive LRU list
> 2.shrink_slab
>    * shrinker->count_objects(), calculates the freeable memory
>    * shrinker->scan_objects(), reclaims the slab memory
> 
> The existing tracers in the vmscan are as follows:
> 
> --do_try_to_free_pages
> --shrink_zones
> --trace_mm_vmscan_node_reclaim_begin (tracer)
> --shrink_node
> --shrink_node_memcgs
>    --trace_mm_vmscan_memcg_shrink_begin (tracer)
>    --shrink_lruvec
>      --shrink_list
>        --shrink_active_list
> 	  --trace_mm_vmscan_lru_shrink_active (tracer)
>        --shrink_inactive_list
> 	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
>      --shrink_active_list
>    --shrink_slab
>      --do_shrink_slab
>      --shrinker->count_objects()
>      --trace_mm_shrink_slab_start (tracer)
>      --shrinker->scan_objects()
>      --trace_mm_shrink_slab_end (tracer)
>    --trace_mm_vmscan_memcg_shrink_end (tracer)
> --trace_mm_vmscan_node_reclaim_end (tracer)
> 
> If we get the duration and quantity of shrink lru and slab,
> then we can measure the memory recycling, as follows
> 
> Measuring memory reclamation with bpf:
>    LRU FILE:
> 	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
> 	7   kswapd0	 	26		51		32
> 	7   kswapd0		52		47		13
>    SLAB:
> 	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim(page)
> 	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
> 	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
> 	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0
> 
> For this, add the new tracer to shrink_active_list/shrink_inactive_list
> and shrinker->count_objects().
> 
> Changes:
> v6: * Add Reviewed-by from Steven Rostedt.
> v5: * Use 'DECLARE_EVENT_CLASS(mm_vmscan_lru_shrink_start_template' to
> replace 'RACE_EVENT(mm_vmscan_lru_shrink_inactive/active_start'
>      * Add the explanation for adding new shrink lru events into 'mm: vmscan: add new event to trace shrink lru'
> v4: Add Reviewed-by and Changlog to every patch.
> v3: Swap the positions of 'nid' and 'freeable' to prevent the hole in the trace event.
> v2: Modify trace_mm_vmscan_lru_shrink_inactive() in evict_folios() at the same time to fix build error.
> 
> cuibixuan (2):
>    mm: shrinker: add new event to trace shrink count
>    mm: vmscan: add new event to trace shrink lru
> 
>   include/trace/events/vmscan.h | 80 ++++++++++++++++++++++++++++++++++-
>   mm/shrinker.c                 |  4 ++
>   mm/vmscan.c                   | 11 +++--
>   3 files changed, 90 insertions(+), 5 deletions(-)
> 

