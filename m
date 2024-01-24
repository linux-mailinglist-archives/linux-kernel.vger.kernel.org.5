Return-Path: <linux-kernel+bounces-36320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D01839F50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFAB6B2852A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284B5244;
	Wed, 24 Jan 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FtRaZ7e4"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2117.outbound.protection.outlook.com [40.107.215.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E788BA24;
	Wed, 24 Jan 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064141; cv=fail; b=DEdfDGhOcP5llXCdmOY5ljtawn00Q4jfwNAtzmhh0J7ZGf1QUL7DiXevMP7jCqFEoQPDhKlryXIHhGLVCOGH6uXZiIrGSvRktAsvYy+arSVh9xOLtXvKP0Oyv+Rl92+vcqVUVUSv2ZwbS+cv4jWl0Ukyi86WeizO7jh0EGmY6Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064141; c=relaxed/simple;
	bh=WHdvgHuKUB8kT08Um2BI/jzr8lTrLl8O6NHB9y+QW9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUSkeVTRKHqwP7S2ID6QX9vmd5GBTd+ciTeAvA/lIiB+A33zy2gJjdv9PWch0CAwmBl+dkXo02Zkp11J7T3nN8VxUpfUxsCf7JcqeFwHuNXxNVBdNPSXJMdW4Y4+S0dn4BwQ5MXKKQZBi7o3l0mdbVkIb54xd19s/+O5pKyQWHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FtRaZ7e4; arc=fail smtp.client-ip=40.107.215.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLOMS7T0MzPLdvaop/g8g3N65UZY7R9lp6nnsytwHcdF3bW/cWpfa6E0bwSYQJMnF6OfACGY778f68emC4poOCkmWXRPhOCjQX7SOt/5bkJGW6D4a+nasQ9ybLOwgiGGb3U3xLfio4enul7YkW5FntdWXgar6Ff68ag5C2MNGgC1aYVjlcpUBrySTm6cgTj3NNargxst9HNfTXm+SqUGC6r/oEzO9xacIUNrNTIRqRNxuZSBoPU2nqMjco0bxttDzf6ABDH/uhABBtmsGAJysayCWi0QFDyJmI2xReQ544bxyiZ32xqtWIddaTeXdx9SA/s096NKskvaOGyZzgYQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=Zy+tQkSmWcvwcIZPearB7+Jxp9ntaZRFUh9/mycR9jHkfrRDTcbHhECJQmmGiNnmtGugNNuFN9xS7LY2XDO0fTq304fHs/LNZ4KXRt2vUdPJKI8DMfv05BQIqunS9voXE8UqLKi0Lxv+57H9bacmueD7fSxeOMumUJT5BH9uTd21pBcWP6rA+1kXkBpfbEhAQvlH7Tl6CKtdSpbYJy2d1eo4t5osRt0uJK12hTXQon37siG07c4WrPyKk6h/9kamhzpTEA/BiopwdrKAGnw6UntoH+JmWNSuJEDIwnXcotik8z8TQsUxgu/T9xHH4ImOrXFtl4PY2qBp/EuKtAheDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUpaom51hJXjSvVhih0g0QjTelFX9vmGOrUDtVibyCc=;
 b=FtRaZ7e4DjAGu9EMs3f2NBJY9ieKIHeSJ8+jZBJd0xmzFrE7vj0A+nL7S/MxKjS7b2xGhQYOheWD4pLNHtJaDZdzDfeTKV+BhQg23C3F3BofleelO5tW7FOj3bb7x2g1Sy/TORbSWXh9tV3hB0BFBKlR/RVE8XzRoB1tKFNXVEH+AAgNAxsh61Y2ce/UebhYNteGAZQwmWeTd6TGuysZfdrZaJHhuz4WJlT6EdFz4s9HboKFE4CeazxDMtgm09Nv8wEY9DP1pjEB54ecuAEsQgqN8RzcLm8QLrmHcq9/cBfUuwuz5yQAAfFzKXuzduPXe2ywsoGx+265ugrtHTswXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by TY0PR06MB5305.apcprd06.prod.outlook.com (2603:1096:400:210::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 02:42:15 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 02:42:14 +0000
Message-ID: <eb48859c-d56d-4c0d-8800-af82a4b2eea4@vivo.com>
Date: Wed, 24 Jan 2024 10:41:48 +0800
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
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|TY0PR06MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d8f252-79b8-43c0-e720-08dc1c8612d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sI8T/DVYN+EXR8ag9Sr5xZIKOwV6xgrxYXbiDuqf7dyqGE2M5ir1F/U3k+YaTVoE4DerAJMQDiNNC9u5gnlM+TNfRp0U5OvLIFqzi+HEuA8b4oK0NIHG7NOuLSzwamXsl4AkgIVwZdGO/BWF96Oh/rvpVFQT/dfWcPPuWHUdM2wCRmwUcnrMnqtMSveqKFhb1TTH9+FhjilYIMI5TG0yAivNb0CLKpwwcir0yHEuArlJFIMwJYuPyNUlR/rMsUTZqtR/2JnbwZ5gaJ/sQ/fAZWnQl/VAy61s4YDeaEuhYBvxxBKcARjT+J2QvsjoSw65bmcAAwonYTrFhNJuki7O6rtuC8i8BeQJFabBYGRzzvXjm0KLaV0mMcYefFp1DsPfK2BSHt3jgirVs9b5X8URXV50sdoDNZfaGs8JXRhvBjfA19Z3y7oozVo5ri2KwtBY5duhmC+iB56OyHhm7cvX22vryGsUSe9SkFXvxI0I98HELDYh43D2ujTt9RttbrjBnRGatjDe9s8ADgp28i91Uqcg/A4AAJT9NpnIsUiBIGNkftwlx8zA5t3jTBNOHBroGPfRUy97shbEJ5JZagjKy61wOsWNm2DHYkbFfBwmyDzoWX9190U/ScKjjjDUCXoItveRYBek/zSc9Y8IaA1t2szTZ4zWhGS9ix7aRn/En3UlUzOCwqb9NlhjxWPFZB1C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(5660300002)(83380400001)(107886003)(2616005)(26005)(36756003)(38350700005)(86362001)(31696002)(316002)(31686004)(52116002)(6486002)(478600001)(6506007)(6666004)(6512007)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djdZeTdhelBYN04zMzBqcXdEQytma1RIU3NRZ1FIYVFZUndrU1A0b3c0RXlN?=
 =?utf-8?B?ejQ5aGZxNFk5UFJnc2lzWWJUcWgxajFiNXRvdkRjRUpwaGphbm5nUWcvVHdy?=
 =?utf-8?B?S0Z3aG9MdW9WYXYyOWQ1cWREa3ZxZ1JBL0p1TldZbVg0VWIvdDV0ZUltTDRq?=
 =?utf-8?B?SDJES2dXK0cxY2o4RDRhYlYwTUtneXZKTHVWZ1JERWxiNnViZytkN2hWSmdo?=
 =?utf-8?B?REkyVDFScjBDd3BIaEFUbnNpWU0va0xnT3NtaWpoMHlGeU9NamR6Z1BrL2w2?=
 =?utf-8?B?UE1RTS9wS0NEZzN6RGdjSGNsZzVxM2hUUUxJdWZSZW1yVUJrM0J0eUk1dHVX?=
 =?utf-8?B?alh6NVMwV2IyQlhYNUsrVFk0QnRUdGQyNkJXMlNsODZ4ekFOanZTR2o0aFJW?=
 =?utf-8?B?YitFbVlzK1h5WHFiZ1VDU1J1TGZwOXl6ejlCcTUzSERHS3JiaHVQbDh3ZWVa?=
 =?utf-8?B?V2tHUHhuTzJMSTN3d2tEVGNHNHEyeXR3bGlZMXlkL201MytHMDFFeUVYTEdP?=
 =?utf-8?B?ZlZwR2QyUzFIZ0psZWhQL2I2S3pDWVZvSk1qZUQ2QTdIbWt0QkpkbVUwSG8z?=
 =?utf-8?B?TU9EcUN2T09Ja05ZZlVEaHIxR1BXY2l1L0VmSnNUVXRXM002M1owRkFyZWxD?=
 =?utf-8?B?WkEwSGpOUXZweTlWbEtKcng3UTQ4WGh6SnpiakZ6T3VVa09zTEg4UjA0WUwr?=
 =?utf-8?B?Z3BOc1kvN2JRS0lzUTZ5WUJ4dFlkRVJ1Q2JUcjkzSnkvU1VQYTJwcytXYzZV?=
 =?utf-8?B?NXErTEZ3eVdiTzhyMG9LbldUL1h2cVNmVlhvckxuV3lGZHVvdFB0aXBJVmhv?=
 =?utf-8?B?Vkl3TCtNeXJsdmw0M2F1V3IyU3VmOUdjWWZ5TndmOXR6cG40Q0c4aUZiTWNH?=
 =?utf-8?B?N0d0aU1sUlVzdFNKa25nMk5vVDlaVG5FRDdKcWdiZy9HTXRMMjNNaWI1MkdS?=
 =?utf-8?B?ODZOOXBmYlFtek9RRW1WZGRoNGFONmpCaEIyemhGc0ZNMmlqTU9nNG5ocVdk?=
 =?utf-8?B?Z3QyTU5OM1cwaFFSaHgyd21tVk5Jd20wQXpieHh4dVNxcGVXcWphYWhFQVZQ?=
 =?utf-8?B?N2FRUzR3MHJRK0tOR3ZhaFFsM3hxMzZVN21PVWwwN2t6eCs1R3JTeUwzWUFH?=
 =?utf-8?B?WVFzOTZGTjduczNqUmNLeVJYTzU1bHVrWU1tNFdSL01oY2cza0NPY05pTnZy?=
 =?utf-8?B?ZW1UUzVCRW14YTFsK3RTdEYrbDNQeWdsNlJmMzlZTXQvT3hpeEx0clgrNE43?=
 =?utf-8?B?YkdvMGFsRWNQZk1zd1Q0OXZpcWZpM3RhR2NCbURoQ1FRVmg2bFBrNXBtUS92?=
 =?utf-8?B?T1ZKSmRrVVVWTFIwS1JBU05XYmNxODh1eHF2dngva29hNkVFY01TdVlvWEMr?=
 =?utf-8?B?K0JZSDFvUDRMVk5yK1JDOUZpcjJOaDFhdjFlTDNLVk4xM0VlajE5dUd1SVVy?=
 =?utf-8?B?UHpUMGdyTXdZV2NwS2d0QkZ2YWRaRkphejhyTXhEMjJVVGpvT3k0TXBUb05i?=
 =?utf-8?B?dlZiVnQvUzBBVCtSbWRFTmxpVXltREgvTjBCbU9oOVgxK3BLYlQ0WkJHb3Bs?=
 =?utf-8?B?WktabDVFOStLUUdYaTFzOTJlUUxWTklOUDJVRHpuYWpWaXh2MHJiVCtRcTVz?=
 =?utf-8?B?Q2VJMVZidUZNVlo4Qk1yRmJqVjZMRithcEkwU1BUbmhyY092ejBtZVhQUk05?=
 =?utf-8?B?ZFZWaytDOXpPdVA2bEFOT1A5OFFjM1JjeXozelJMSVBKSDdlTzQ5eWlmNjBz?=
 =?utf-8?B?dUVPazR0bWFXdzhmUTFiWHY3U0pMTm1Qb1BYeUs2OFBjS2pXaFY0VzlBdGJa?=
 =?utf-8?B?eE5TTVNvb01XRW9LV0lvelBEaDRvTExWMTFkWldZTnAvSm9Vc3NpVjRvWHZX?=
 =?utf-8?B?dmM0YTlNRlNMVFQxU2VZSVo5TkRzVDlGY1FSUG5hREs4YVM5MUgvV2doQkQz?=
 =?utf-8?B?YVJCM1Q5NFdGTmU3TzViZFQ5NWxyTU85R0djMG5MZDAxTCtZOTZJL1pGL0Zy?=
 =?utf-8?B?UlNhMWxsOWptNkdaQ2ozRTEranRzTDZXVzFid2NJVmVpSWZKSHNWQW9zNnow?=
 =?utf-8?B?VlVaN3JRS0RxZk5Va0Q1bnF2NG5kM0lFcUJTcytmcTY2YlpXVzJvWTZDa2Ez?=
 =?utf-8?Q?rz7If4NRuq6abrA9Qv5HAR4pp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d8f252-79b8-43c0-e720-08dc1c8612d9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:42:14.9193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IO7zHQKBAttp4bJhQu66Mm4OIGnw9vhNyO2F7c2rUu6SVTcktZKO1lQD9Gb8orzJCegWFP8rNmKTpebV1XLTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5305

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

