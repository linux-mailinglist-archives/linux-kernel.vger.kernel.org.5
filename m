Return-Path: <linux-kernel+bounces-72187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7A085B098
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3401C22120
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDD3F9FA;
	Tue, 20 Feb 2024 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="UcaOvXfG"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448A2F48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708393384; cv=fail; b=PtngNJO2KfDois7OdVpBdLFqR5CQ81VglvEtcqu/kWPJCD4lEr8hDuiWCglYJCXiS/OYZvC7cQB9/wSeCD5w1bL6+vW2z9M5JxBDjrlwsqFK7OFwXbbtgLbG9bNS6jfVGAPgvmJ0otkk3c+at5BzBGrYZtnRPdm8SHjvU5zo3+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708393384; c=relaxed/simple;
	bh=LV/Pdc/iszQR3LgVHy7+nnwK62EWjMRG+7HCUSE7COA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t23fEVu90Us7mwsiKq3sIkFkFWR0DptNbXWflVOXDdXwdSmHeLhzjH8rVe4IhO2vN5ix+rUVvqMwA3OVSZ6bb24tA5EQ5pDVLSw4kqJz7EUu8aa4/7+ZQZ/QNV3hPN160Do7ULpdV4YkWRR7a00DgblFtKjE+WpXSnI12SYzddw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=UcaOvXfG; arc=fail smtp.client-ip=40.107.255.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfNceUZehVszPWthZvCEDbUje6A1QfE4/pEb/wb2Zy42/vd/lZcqeMWTUITHIcC7QlLHFTxkA7RZzZ7QmiDgR3Cb6P5L2cd27IgDMOIUL3wPBeaTmNgGOSXkz1LNOAi/4Xnd6KUf5OvYWIXJb9/Fsi6hw/jx1n0FMakui6CdYWOdXDbbGxOMAnLlQWz+pfC3dyqqCGiagXChfJllo/lu9T0VpKEjEGciv0tvYwD/iqDnEwzCO7UycmdYMCRKpqrKfGjecg3I+f3WbJcjsbr/axVq12zwGgW47LtQA26F3rjnQk1otGcFgvz+JftEwukiSwOEXOjpUH/lKroT3aM6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThDB/ADrVL/M7r/iNqp+OJD6jCzvEKav8Vp/xvlj/HQ=;
 b=HnXgsCAB24DCpP7OBvW9XPFz5JTeweaus6vztX5zBaU4EE8jGLnsckjda3lvFYWc5Wae6CzkYi1HOPdAXP98EdQ+zg9fbxxVIIXQRq195gw42mNuLnAcrZpPVXP/xQiYlIDs6k9arXIK/BJ7jqFxc0r95KKYpLyRSluEkg0tFfl5/x28xr6YVGG92bE7OwKtcrwVYI7H2imJhu87FIIMjdeWEb7WsouMUC+8zq9wywhmcJZt9lv1BYv2bgB7opBlNH81IjG4hRgECvx1fHeG/5yVeXVXXJYS8PabkHim6ej3MtZDX+cbqc3OgjRTBiUYgxKSrHTAxKV3ahhf+SY7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThDB/ADrVL/M7r/iNqp+OJD6jCzvEKav8Vp/xvlj/HQ=;
 b=UcaOvXfGcYm4ZD2J8ViP4J2x9SeTtZgiIWKi7f7MRRLMFm1nAESyuzW4HxZEAtU1JPnyAGIuMkHil8jt8oUaJ6w9DJBc2YQVK5zSBLG8iwYY0ouoGzefwDxTK4/fF9xywI1R6o9trnX+qlyM7FBoDyFQRx2AEBvzPVLAu/wWfg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by SI6PR02MB8312.apcprd02.prod.outlook.com (2603:1096:4:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 01:42:59 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 01:42:58 +0000
Message-ID: <7c648dac-3198-3dba-0a96-34798cfdbd99@oppo.com>
Date: Tue, 20 Feb 2024 09:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] mm/rmap: support folio_referenced to control if
 try_lock in rmap_walk
To: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 willy@infradead.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 surenb@google.com, gregkh@google.com, v-songbaohua@oppo.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <20240219141703.3851-2-lipeifeng@oppo.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <20240219141703.3851-2-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0351.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::20) To SI2PR02MB5612.apcprd02.prod.outlook.com
 (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|SI6PR02MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: acb35d46-b306-49b4-c8e9-08dc31b5443b
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBvHf6q27C6wj53oMGVyLOHVwN54sKbFGX2FzLt7ecvw8oyNqemj6BBCq195SWsfnV7oBXa4aMfXx/RNWHqTKErFSFVpLvHnz8fQQoQsRUPy1RD64Pru37qtu/a6d6YSs0H8GTIDw8Szhi0fekp2Obs9hxkejlG20OJiT/WJDTRHQIoFGSeaQhqHeQH1ZF/tWOeFB64EeNU3TjZTqeK3RyhZLCEfLRX/PF7nf6hgdL/7IwGsoV4mMW5kyG5GxCXBw/0Plrg/tt+EKRaoyzWBl5LAcbcKDnxjFYHCi0kghLaZNPQ8fE6AAC1U/a3nP7M6RZR++trzDG7zs159K5C0x3rIlbSx6I31KXhI5uXIlgU24VR8gJOufcwWo+voqLIn5RcMtZvBuYKY4g3hG9M+9Y5pveY4tO9G1lG7cOe7+I+t5VE7cY/nE5XhWLkHuvnryduno7J/j+q7BbQYEeIN/kkGMalfvhsfUhs95heXkB6WHUBWPaLuHQqiVUCDkViyPVsGW2E0F4So5CsfhoMRiyYML7H8Hqd6mwpbkkmWWr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXcrVkU0UDd2SXlZTHNibmZJaEtOc2VDcWdDcW04UVhSOTNGNXp3cEUzMHdX?=
 =?utf-8?B?QmlzS2FJUXF2Vk11MkxGQlZPMUQzMDI2bDRraHl2WTYvR1A5QzdrZzdWVWpY?=
 =?utf-8?B?RXdVT1VFZjZZWW1yYjhOSElyYlFldGd4SUhvSlprNTI1MGhRdmx6d0VWL281?=
 =?utf-8?B?c3RhMTFiRFdFVGpYSmpHcTNCM2lWaFlJUGduK29wZlc2TTZsMWVrV1BiSDZo?=
 =?utf-8?B?RTB0b0J0MDEvR2xEem1keGN3d2g0UFlNUXQ1azJJbURSTDR4RXRGcklUVnF5?=
 =?utf-8?B?bjhYWFpjaTVvL2toYlFHMzhUY0NTYllRSXpTaGZ3UWRDdTQ0RzVLR0FxcWJ6?=
 =?utf-8?B?aUNVRW44bXYrNG9iZThOVlIrV2p1TFllSDAzZkY1SGhOTFNxWTFUY3B4bVZE?=
 =?utf-8?B?WGhraHNROEttVmhqMkMvQk1xdzZrcGZIeUltTzRST2hzR0tBQlY2UEhYZ3R2?=
 =?utf-8?B?dlZzbklRODNtdnpvTy80NzFhU3N6UDlxR1JlRFVjVm55VFFIeVNsUitFSklv?=
 =?utf-8?B?bzdNcDJyTE5jbW1PbTF6c3JaelFpZ0x0Z2J6UkpQMHlkeVJxVjJtMG5QMjdT?=
 =?utf-8?B?eU1MeTh1QVNBazh0SVdJZmdacnkxeG9DZG1IRnhJaklCSDZyZ0I2NitFQTds?=
 =?utf-8?B?dmlOYm80eGVqR3hjWnYwT0pRWjh0MGRDM0wzVyt0V0ozSU02QldMUkFWbzQw?=
 =?utf-8?B?L0Y4OWowZ2R0T2JsNEhUWjBBb1dHMWxXM3A5TlRXSTdPMzYzMjlhajlFWk90?=
 =?utf-8?B?UzN4WkFLOFNoYWFaamNaajZSZHdEOTdrNGFnT2E5dzRpTUV5OExHbUdmU2ZH?=
 =?utf-8?B?NzNlNlI1YnkyOFdLVCtlWks1TVBUbkJsN1QxSDVGTE8zTjduM01sMW1SZnBz?=
 =?utf-8?B?bVd2eFlUVzdVR1djYlREa0wxY0JmMHdBdlhUUHNrM1d0dUwxZy9hbU1NT0ZH?=
 =?utf-8?B?VnZ6T20ybGRVZ2pHVWV4SS84UFFLWWRHK21lV1lwQUpTem9tTUpQMUp4NmZ1?=
 =?utf-8?B?aHFyekxTKzNoREEyeC9LUWV2bFJPc2p2VUtBa3d0RDcyMVBzaGtoK0w4akNt?=
 =?utf-8?B?K1ZxL01xZzMydHExQm9ubVV0NGR1OGdZTm5JdWY2Z0paRGo2TTVQQlZmMXIv?=
 =?utf-8?B?LzNzdHZLenpBWmFHS0ZBN0pnc1VHdXFjdWRWaStENzBDUmNwazQzbENyQkFZ?=
 =?utf-8?B?TUdsNGJUTS9sQkcyTFkvSUV2Sm9sZGxrVEt3TkNOUTBrWXVSaEV1Vmtxc3lH?=
 =?utf-8?B?UXd6cU05enZQbmpseFFqOXArdUxaQUk2Z242UjNMMzRyVkpHL3JIcHNuVmhO?=
 =?utf-8?B?d0w5SWRTVStLcGM4TjNpVGN2a0M5cGgrcGx6TFVuSm9PTkVySHlWangvbTZQ?=
 =?utf-8?B?dzFhQmJRRkZCRGgvaFVUbUs1SU9yRlBTY3laOE0wS2JHSnJaYktEUzdwbmtE?=
 =?utf-8?B?NTh0OUEzbGF2YkQyMHVBMElJbUx6bFFERmw5WWQyL09yOFB6N1MwSmVZNVMr?=
 =?utf-8?B?NStjVmJhSHVJNUtxRXNIenFhNndFLytBTzZVOTBmNDJ5dndwRDQ2bmNOSk1M?=
 =?utf-8?B?cnR3R0lUczE3Y3BVV2xUcXRSOFVSMU0rTXpxZDR6NzdPNG5FU2JFSVljUldy?=
 =?utf-8?B?U0ErQ2ttVjlSZ2pZRGdxa0pzVGdPblF4c240bGpXWTl1WXBNbmlYOWplaG00?=
 =?utf-8?B?K0V4NXJrNzFyRnJKcDVSZk4zbi9HMnhXSzNObDBCV0k1cFZtTXA5TTNEbk5m?=
 =?utf-8?B?UXI5Vm4vUWNVOWFsVGNhVFZmeVBEakZOem1hQmpneExVY3djTXE2MWdHUU1j?=
 =?utf-8?B?cTVQNzJtVE84OTc1Z2ozRnNmRWgwaWVzdVRxYTQxQXBNbE9BdWdyT1FZd1Ev?=
 =?utf-8?B?elA5VXpWRlNUQTNUL1F0OENFOTc5eitHV0p0K0srbm56SlB2V25wREJrYjJY?=
 =?utf-8?B?ekxXZFhuQWxxNFhMa3VQSnVSekltUlJaZjVrTjVvWGN4akw1TUJPUnlPZVdR?=
 =?utf-8?B?Tmc3b1lnT1dkcW5aKys3UWV2QklzKytjUGc3V3pkYU5tUzF4UXRWcm9WcXpu?=
 =?utf-8?B?NTlkNnBlSUtnYnJNMnJBcW1LdFRDYWZHUVVXV05XS0NCM0RJbVBrU096RUpy?=
 =?utf-8?Q?2+6VSdywx5mGlM+ZE8GKG5Q1P?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb35d46-b306-49b4-c8e9-08dc31b5443b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 01:42:58.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pnkp6+684244x6AjcUdjaCL/rFdK5Zgrx81/18d8orqeUY862noop/YZYsKTrSfA2v4hmnwOzLUo3ArL2NDjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR02MB8312

add more experts from Linux and Google.


在 2024/2/19 22:17, lipeifeng@oppo.com 写道:
> From: lipeifeng <lipeifeng@oppo.com>
>
> The patch to support folio_referenced to control the bevavior
> of walk_rmap, which for some thread to hold the lock in rmap_walk
> instead of try_lock when using folio_referenced.
>
> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> ---
>   include/linux/rmap.h |  5 +++--
>   mm/rmap.c            |  5 +++--
>   mm/vmscan.c          | 16 ++++++++++++++--
>   3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b7944a8..846b261 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -623,7 +623,8 @@ static inline int folio_try_share_anon_rmap_pmd(struct folio *folio,
>    * Called from mm/vmscan.c to handle paging out
>    */
>   int folio_referenced(struct folio *, int is_locked,
> -			struct mem_cgroup *memcg, unsigned long *vm_flags);
> +			struct mem_cgroup *memcg, unsigned long *vm_flags,
> +			unsigned int rw_try_lock);
>   
>   void try_to_migrate(struct folio *folio, enum ttu_flags flags);
>   void try_to_unmap(struct folio *, enum ttu_flags flags);
> @@ -739,7 +740,7 @@ struct anon_vma *folio_lock_anon_vma_read(struct folio *folio,
>   
>   static inline int folio_referenced(struct folio *folio, int is_locked,
>   				  struct mem_cgroup *memcg,
> -				  unsigned long *vm_flags)
> +				  unsigned long *vm_flags, unsigned int rw_try_lock)
>   {
>   	*vm_flags = 0;
>   	return 0;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f5d43ed..15d1fba 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -952,6 +952,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
>    * @is_locked: Caller holds lock on the folio.
>    * @memcg: target memory cgroup
>    * @vm_flags: A combination of all the vma->vm_flags which referenced the folio.
> + * @rw_try_lock: if try_lock in rmap_walk
>    *
>    * Quick test_and_clear_referenced for all mappings of a folio,
>    *
> @@ -959,7 +960,7 @@ static bool invalid_folio_referenced_vma(struct vm_area_struct *vma, void *arg)
>    * the function bailed out due to rmap lock contention.
>    */
>   int folio_referenced(struct folio *folio, int is_locked,
> -		     struct mem_cgroup *memcg, unsigned long *vm_flags)
> +		     struct mem_cgroup *memcg, unsigned long *vm_flags, unsigned int rw_try_lock)
>   {
>   	int we_locked = 0;
>   	struct folio_referenced_arg pra = {
> @@ -970,7 +971,7 @@ int folio_referenced(struct folio *folio, int is_locked,
>   		.rmap_one = folio_referenced_one,
>   		.arg = (void *)&pra,
>   		.anon_lock = folio_lock_anon_vma_read,
> -		.try_lock = true,
> +		.try_lock = rw_try_lock ? true : false,
>   		.invalid_vma = invalid_folio_referenced_vma,
>   	};
>   
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854..0296d48 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -136,6 +136,9 @@ struct scan_control {
>   	/* Always discard instead of demoting to lower tier memory */
>   	unsigned int no_demotion:1;
>   
> +	/* if try_lock in rmap_walk */
> +	unsigned int rw_try_lock:1;
> +
>   	/* Allocation order */
>   	s8 order;
>   
> @@ -827,7 +830,7 @@ static enum folio_references folio_check_references(struct folio *folio,
>   	unsigned long vm_flags;
>   
>   	referenced_ptes = folio_referenced(folio, 1, sc->target_mem_cgroup,
> -					   &vm_flags);
> +					   &vm_flags, sc->rw_try_lock);
>   	referenced_folio = folio_test_clear_referenced(folio);
>   
>   	/*
> @@ -1501,6 +1504,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   	struct scan_control sc = {
>   		.gfp_mask = GFP_KERNEL,
>   		.may_unmap = 1,
> +		.rw_try_lock = 1,
>   	};
>   	struct reclaim_stat stat;
>   	unsigned int nr_reclaimed;
> @@ -2038,7 +2042,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>   
>   		/* Referenced or rmap lock contention: rotate */
>   		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
> -				     &vm_flags) != 0) {
> +				     &vm_flags, sc->rw_try_lock) != 0) {
>   			/*
>   			 * Identify referenced, file-backed active folios and
>   			 * give them one more trip around the active list. So
> @@ -2096,6 +2100,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>   		.may_unmap = 1,
>   		.may_swap = 1,
>   		.no_demotion = 1,
> +		.rw_try_lock = 1,
>   	};
>   
>   	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
> @@ -5442,6 +5447,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>   		.may_swap = true,
>   		.reclaim_idx = MAX_NR_ZONES - 1,
>   		.gfp_mask = GFP_KERNEL,
> +		.rw_try_lock = 1,
>   	};
>   
>   	buf = kvmalloc(len + 1, GFP_KERNEL);
> @@ -6414,6 +6420,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>   		.may_writepage = !laptop_mode,
>   		.may_unmap = 1,
>   		.may_swap = 1,
> +		.rw_try_lock = 1,
>   	};
>   
>   	/*
> @@ -6459,6 +6466,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>   		.may_unmap = 1,
>   		.reclaim_idx = MAX_NR_ZONES - 1,
>   		.may_swap = !noswap,
> +		.rw_try_lock = 1,
>   	};
>   
>   	WARN_ON_ONCE(!current->reclaim_state);
> @@ -6503,6 +6511,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   		.may_unmap = 1,
>   		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>   		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +		.rw_try_lock = 1,
>   	};
>   	/*
>   	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> @@ -6764,6 +6773,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>   		.gfp_mask = GFP_KERNEL,
>   		.order = order,
>   		.may_unmap = 1,
> +		.rw_try_lock = 1,
>   	};
>   
>   	set_task_reclaim_state(current, &sc.reclaim_state);
> @@ -7223,6 +7233,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>   		.may_unmap = 1,
>   		.may_swap = 1,
>   		.hibernation_mode = 1,
> +		.rw_try_lock = 1,
>   	};
>   	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>   	unsigned long nr_reclaimed;
> @@ -7381,6 +7392,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>   		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>   		.may_swap = 1,
>   		.reclaim_idx = gfp_zone(gfp_mask),
> +		.rw_try_lock = 1,
>   	};
>   	unsigned long pflags;
>   

