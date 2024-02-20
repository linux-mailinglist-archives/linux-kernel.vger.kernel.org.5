Return-Path: <linux-kernel+bounces-72202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A285B0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D001C21E15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6821E3E485;
	Tue, 20 Feb 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Wp4Ejt6S"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A93A8F7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395108; cv=fail; b=jo+DmauquWn+WkQEu36raF78M0967npbmifpNFXQ0LqQ+1ZjdnYCQ4BsIUT+99m9w1KGKgFtut23KLijppVDIXOCDygFWjciUtcFu96EQwc0PjivWOwkl3TMOFQk6goro0NDztje4N63i+PVCeWbp2nZBk23QwsP3hLlRT+Vlio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395108; c=relaxed/simple;
	bh=io2nWXZETdxKFfAlrC3QUkLtJYladxbLMNDvTXlY0ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HB043nZILrEQjc3HmDtt2Yflv/VMPVx/TD66sEUliwgJH1jqmwMMyrBVH7ra26RSGFisoISeR9v939Kq/VHXfEZvmmMOiJaaezTKTazNtJv3wGw5kDpXiKbko1z7zYY93jzPLsFk2XH7c/4OcpyRvQ6zjEElP8QA5VijKtsiIJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Wp4Ejt6S; arc=fail smtp.client-ip=40.107.215.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IubpY/InSRv8W6oWLfYxPMVNByogxBnZyt20Yx0m3xIW7DwFUmAblicf4nskW9S5p/LM+Hp+ZmLNLjUusMh6+037gkWbHNAPdGvS4ny97qd3T+IPSPX5cHw0LDnbcvkoe0OVlENMWEiM7UfsFjt36EbyRFi98cCl9bdTzaEoyXd9/vSYtTD495eehSLYo5F5klNJPYivWvGBRB2Y/PWU7YykgpIaXiDXBm5JXYKEpmRnXY7/o2QT3VoCzfvNagcsA4KQRUCPoge8DwPeO75HKeXb/JlLWCv/eQP34Oyb1yvE/mikY/lCev9TOIE9ZvDrfoAxDRzSMk0PcX6BtnIxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7HtqW3kstUWjyU5f/jAuNm3BzU0DpXvUT3O0XbGDPk=;
 b=feKw+Cx5p4MFejG0m9OGI2if3H3/02lxeDKDUJU07q/fYdqzCRhouclqjEKIXNGW3H9ITYbYZI8y1LzOeQTpd8mZZ0DBQRCttTtD+03ofN1e1wRGQIwJUboR+eDBuD5FR0VU109JXjVzE9s8MbTevS6D/JQCPRRVs+QDf39uvx4bmsN+hQss3h0Ax8oszcmgXRBFxxQgWyAtKU2dPnqDEZ+k62QS89DZFw2zsh0bijVc3xrdFbLEK1V5wwif4u24UIyDGpm8yuGvQ7WdqJFxw4O+dVxzZ1rTxOT42MVdxg+fnEMW5efyT5qnW/F6DhXG6a4M+z2Ufb8bGi1pOMinHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7HtqW3kstUWjyU5f/jAuNm3BzU0DpXvUT3O0XbGDPk=;
 b=Wp4Ejt6STjZ6nDrNb7AaP/E5k8l8+Y4dWuLnHAUB9iqDeQlOcATZCoRyXTwF2FZSBwTUczwPSOpMpmH0dKSsUP4DL0QwBsO9z1+SxXkAx/q7aZMlsjH1BfuWlFmxNqQT3/bBesBrfgx6Pt8AMmEdxspI1covsf62oDIKTv/AY5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by SEYPR02MB5965.apcprd02.prod.outlook.com (2603:1096:101:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 02:11:39 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 02:11:39 +0000
Message-ID: <f0ad229d-0846-d60b-2508-88c5878e733a@oppo.com>
Date: Tue, 20 Feb 2024 10:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] mm: support kshrinkd
To: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 gregkh@google.com, v-songbaohua@oppo.com, surenb@google.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <20240219141703.3851-3-lipeifeng@oppo.com>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <20240219141703.3851-3-lipeifeng@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|SEYPR02MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdac8e5-3213-4985-1d75-08dc31b94614
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSxiSmP9jfTEg28su7OXdSer5nEQNmQ++SjRcYRXduG1RekRPd805bWPe2G24vosQEzmfZzM4EIkg5ZuGFxaPuA2ENZVaKoqSoD6LeNDpmUgm4dh9s9ANZ90/yFxNA5yyG7Iw2DNMQx46IO1pdVUPD37+6c9eXvUdbJl7lvtdqdmQJCt3SC3lGC3ib5mUh2JCyX6GsCY32HUmzRjnWGa9bpjCaf4HipirmNb5lfikdYjFMn87gphM7Qi+hJNWuize2z9E2IBOuKyqowWBVfAfkrCslTiNH5y6rJyy+RBckSZAGNWuWy8rKienvtElhUgAKd94SrWNaBXhJX4pktR3HoxqpO5/je13UGdQAq/1kiI06c2RB+dD+HdltVs0v7PBR3oQBi5Kur5ZxpVMjP1GcwU6nRW2sHKKLXxi8EZ09qe5jAqdCuig5ZKcgxBjtexYW2AGNy+2Z9yEfgX2i6KNEb9XWkbYiywRC4TsMuUT5qhLFZLpbcvmk3DZqv+XRe0d/9fDBM6FUZFe9JSqr+925j8jzP8RubKk2dfxsQXpJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amVZMW9rb2xJRWppc2JmYUVEY2xEL1JMM2E1UUxOSHFqM0grbmM3bjZ3VUoy?=
 =?utf-8?B?OGVReHJzNHlYcUY2MTRDU2tETUI3djlzbVphMmhRcTIrSEpuSVI4clpaYnI2?=
 =?utf-8?B?aEJnci9yNWhxOFZ1VmxTeThRNGQ3QXd6SzhlL2w3STMrYjY4dXNrT1A0dXBX?=
 =?utf-8?B?TEFBdDNVTmdJMTR0ZFkxYkZ2cHJGbkNiS1Z1OXlUWUM3QTFYOU5mdGZxL3pN?=
 =?utf-8?B?NFNBZDk2TGtIOE80UWxqcmx1SWYxeXJpdEdubEI4ZEZDUk56Wi9jQW13ME5D?=
 =?utf-8?B?alZzdThNZmE4NThnYW45WUFCcjhvZGtxZSs4OGg1M2F2c0lqaEc1MjV5eXlK?=
 =?utf-8?B?MTRFcDU2SkRSTzIwVk0vN0dHN0h5Qi9MQzJFZnhvT2c2dFV1NHh5YjBQOEZV?=
 =?utf-8?B?cWdBZnFwZ3Q5eFZTeGJrb0xKam9zVk5KTGUrNFVhUU1hT1NUL3hPdnI1RmVO?=
 =?utf-8?B?TkR4NDBjNHZmLzRnM0hWRzc1RUtsZGN4SXl0Q0dIYjFuN0VkTDg0WC9uanBI?=
 =?utf-8?B?by9lRGJSbzNzTlVBaXZQRjVCcVpRNUNRK2pZTS93RTE2SjZ1UkUxZkk5eHJj?=
 =?utf-8?B?eENWbXk4bm9wUlBoYzZXRzJ2aVdjSE8wK2FsN0Z2OWtUcDR5cGhSb1d3ZUov?=
 =?utf-8?B?YVRKUjkyMGZJUFZrcWpFSVlvdC9hQ2NNdVRFZEpsejBoVy8wSEhaeUQ5N01H?=
 =?utf-8?B?SGQ5a3diZ3VqYzZwSTdEUjFGd01RU0p5RDkzSWFkMEdNelQwalF5TXhhT3A3?=
 =?utf-8?B?NkhSemlDR0dWbU52cExQWGt1T3NCVzRqT2l6RWI1WFpVZTZZOTE5dDIvVzZG?=
 =?utf-8?B?TE5PckFHSXJ0T2xvRGEwNU4zb0hoSDJPSzZYOFhPM3F6eDVLOVg4VEdpMHlQ?=
 =?utf-8?B?TGtNU1VyTjJDa3JhazBDUlN3RURQWkg2d3lqZE5ib3NtL0Z0N0FTT1Z1Z2xG?=
 =?utf-8?B?bk91VGE0MnpqcFNReHpiaGNQc3FEYitBR2xpN1cvMkxIekgvTllEeTkyZmg3?=
 =?utf-8?B?UkgzOERSdkNRVVhtUjRWa3VsdC9FMWdKNFRzQkNxckoyWlJhaXVTY2RQSlQx?=
 =?utf-8?B?L2tBSHN1aE9CTVdleXJtUmd0Y3RpTnRLLzJIUys1V3Jmb2dONk5TOWxCVSsw?=
 =?utf-8?B?RkpFcXduQjFvV2xPVW1QckxUU3J6QlgwaDlPcjBGdzA5Q3pCdm5OVnFBbjJ3?=
 =?utf-8?B?SzZCeVhoRWxsMk1SOGg3T1N4d29Fbmk3bnRoZzVoZDNhRE5PTGtLWnA5aEtB?=
 =?utf-8?B?MUQ3WElBVFpmSlllWUhYd2c0ckRpVk9XMEtQYWpXV2ZtdTlNR3dXSjdEbEFN?=
 =?utf-8?B?SFFEaFpTTVhVU3E3WEtjR0VzaHYyRmUrQTBwT0orQW1EUXFIMHJBS291cU1X?=
 =?utf-8?B?TmxlT1psVUx5ekZLS2VrdmJKWldnZ1hnMWM0aitBSFRaeERWSTdnaUZTakFa?=
 =?utf-8?B?NHZHRU5KNEY3V3NGc2diSG9BbDRPVlNzZkgwcmwyQ0VFT0F0ZzRobVM5aWEr?=
 =?utf-8?B?T3dXUnBORGdhVWVhbU96dGg0dTcyS3pOWng1R0pvbFoyNXVGdFNpRUhsVldM?=
 =?utf-8?B?THpqZFhHOFNVaDJRQytlNVlRdnc5MldKZTQrMW5LR2orbGFhajBIMmp5UTlX?=
 =?utf-8?B?dk04eE8zZjN3Uk5mLzg1bXh2a3JKUWd3THJZWnhPMzJSR0VUM2JnbUJubkww?=
 =?utf-8?B?RU1DRkdzaEwrNVowOXJISEttVi9ZcTJSbnE4UHlmZmpmcXpZT3Jna2QxZWRy?=
 =?utf-8?B?ZmFFeGR1YnpTMHRjZEthOUZzSE1Ia2phaERJTjhjbUNCMTMrc21sdWZvMWM2?=
 =?utf-8?B?MVJYdzJGTHpqZDhEbkJWbVhUSFphZzA3TCtnZGlhWld2NzhDS002cGROUGhV?=
 =?utf-8?B?cnA3cnJMYlBiQXpMWTFobWROeGIydEozSmk4cHlpQkVwWGlnaXdWMlhURDR6?=
 =?utf-8?B?N0VVcU1EWFF0NFA0OGo4SmxVMWNpUW1ER2Y4RXlkR241b293OENFWWdpbk9Q?=
 =?utf-8?B?SW11SU5welNQcHZ4bVVTRFpRd2doV1Z5ME1tRGQ1dnRkV05KcS9iKzlVMGtS?=
 =?utf-8?B?MmFnSkMrNmN6NWtaZlFnc1d4YjNSV0xETDJxVXJ2dnFVelk3Qm95UTIvSjMy?=
 =?utf-8?B?eXdZbjFBSUdMQjhjTXEwbFdNeWpuQk9wTFRVMFlxZy8wakdoY0dIYXNJYVMz?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdac8e5-3213-4985-1d75-08dc31b94614
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 02:11:39.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKykFyap5BO66JEvGXRr6b0cToft3bQ0SRTb4NdWH8fGh+JKMlW4LDlmsIKylfdsPNwHpvMK422hWPKcfPXaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5965

add experts from Linux and Google.


在 2024/2/19 22:17, lipeifeng@oppo.com 写道:
> From: lipeifeng <lipeifeng@oppo.com>
>
> 'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
> The above patch would avoid reclaim path to stuck rmap lock.
> But it would cause some folios in LRU not sorted by aging because
> the contended-folio in rmap_walk would be putback to the head of LRU
> when shrink_folio_list even if the folio is very cold.
>
> Monkey-test in phone for 300 hours shows that almost one-third of the
> contended-pages can be freed successfully next time, putting back those
> folios to LRU's head would break the rules of LRU.
> - pgsteal_kshrinkd 262577
> - pgscan_kshrinkd 795503
>
> For the above reason, the patch setups new kthread:kshrinkd to reclaim
> the contended-folio in rmap_walk when shrink_folio_list, to avoid to
> break the rules of LRU.
>
> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> ---
>   include/linux/mmzone.h        |   6 ++
>   include/linux/swap.h          |   3 +
>   include/linux/vm_event_item.h |   2 +
>   mm/memory_hotplug.c           |   2 +
>   mm/vmscan.c                   | 189 +++++++++++++++++++++++++++++++++++++++++-
>   mm/vmstat.c                   |   2 +
>   6 files changed, 201 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a497f18..83d7202 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1329,6 +1329,12 @@ typedef struct pglist_data {
>   
>   	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
>   
> +	struct list_head kshrinkd_folios; /* rmap_walk contended folios list*/
> +	spinlock_t kf_lock; /* Protect kshrinkd_folios list*/
> +
> +	struct task_struct *kshrinkd; /* reclaim kshrinkd_folios*/
> +	wait_queue_head_t kshrinkd_wait;
> +
>   #ifdef CONFIG_COMPACTION
>   	int kcompactd_max_order;
>   	enum zone_type kcompactd_highest_zoneidx;
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00dd..155fcb6 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -435,6 +435,9 @@ void check_move_unevictable_folios(struct folio_batch *fbatch);
>   extern void __meminit kswapd_run(int nid);
>   extern void __meminit kswapd_stop(int nid);
>   
> +extern void kshrinkd_run(int nid);
> +extern void kshrinkd_stop(int nid);
> +
>   #ifdef CONFIG_SWAP
>   
>   int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 747943b..ee95ab1 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -38,9 +38,11 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   		PGLAZYFREED,
>   		PGREFILL,
>   		PGREUSE,
> +		PGSTEAL_KSHRINKD,
>   		PGSTEAL_KSWAPD,
>   		PGSTEAL_DIRECT,
>   		PGSTEAL_KHUGEPAGED,
> +		PGSCAN_KSHRINKD,
>   		PGSCAN_KSWAPD,
>   		PGSCAN_DIRECT,
>   		PGSCAN_KHUGEPAGED,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2189099..1b6c4c6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1209,6 +1209,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>   
>   	kswapd_run(nid);
>   	kcompactd_run(nid);
> +	kshrinkd_run(nid);
>   
>   	writeback_set_ratelimit();
>   
> @@ -2092,6 +2093,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>   	}
>   
>   	if (arg.status_change_nid >= 0) {
> +		kshrinkd_stop(node);
>   		kcompactd_stop(node);
>   		kswapd_stop(node);
>   	}
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0296d48..63e4fd4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -139,6 +139,9 @@ struct scan_control {
>   	/* if try_lock in rmap_walk */
>   	unsigned int rw_try_lock:1;
>   
> +	/* need kshrinkd to reclaim if rwc trylock contended*/
> +	unsigned int need_kshrinkd:1;
> +
>   	/* Allocation order */
>   	s8 order;
>   
> @@ -190,6 +193,17 @@ struct scan_control {
>    */
>   int vm_swappiness = 60;
>   
> +/*
> + * Wakeup kshrinkd those folios which lock-contended in ramp_walk
> + * during shrink_folio_list, instead of putting back to the head
> + * of LRU, to avoid to break the rules of LRU.
> + */
> +static void wakeup_kshrinkd(struct pglist_data *pgdat)
> +{
> +	if (likely(pgdat->kshrinkd))
> +		wake_up_interruptible(&pgdat->kshrinkd_wait);
> +}
> +
>   #ifdef CONFIG_MEMCG
>   
>   /* Returns true for reclaim through cgroup limits or cgroup interfaces. */
> @@ -821,6 +835,7 @@ enum folio_references {
>   	FOLIOREF_RECLAIM_CLEAN,
>   	FOLIOREF_KEEP,
>   	FOLIOREF_ACTIVATE,
> +	FOLIOREF_LOCK_CONTENDED,
>   };
>   
>   static enum folio_references folio_check_references(struct folio *folio,
> @@ -841,8 +856,12 @@ static enum folio_references folio_check_references(struct folio *folio,
>   		return FOLIOREF_ACTIVATE;
>   
>   	/* rmap lock contention: rotate */
> -	if (referenced_ptes == -1)
> -		return FOLIOREF_KEEP;
> +	if (referenced_ptes == -1) {
> +		if (sc->need_kshrinkd && folio_pgdat(folio)->kshrinkd)
> +			return FOLIOREF_LOCK_CONTENDED;
> +		else
> +			return FOLIOREF_KEEP;
> +	}
>   
>   	if (referenced_ptes) {
>   		/*
> @@ -1012,6 +1031,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   	LIST_HEAD(ret_folios);
>   	LIST_HEAD(free_folios);
>   	LIST_HEAD(demote_folios);
> +	LIST_HEAD(contended_folios);
>   	unsigned int nr_reclaimed = 0;
>   	unsigned int pgactivate = 0;
>   	bool do_demote_pass;
> @@ -1028,6 +1048,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		enum folio_references references = FOLIOREF_RECLAIM;
>   		bool dirty, writeback;
>   		unsigned int nr_pages;
> +		bool lock_contended = false;
>   
>   		cond_resched();
>   
> @@ -1169,6 +1190,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   		case FOLIOREF_KEEP:
>   			stat->nr_ref_keep += nr_pages;
>   			goto keep_locked;
> +		case FOLIOREF_LOCK_CONTENDED:
> +			lock_contended = true;
> +			goto keep_locked;
>   		case FOLIOREF_RECLAIM:
>   		case FOLIOREF_RECLAIM_CLEAN:
>   			; /* try to reclaim the folio below */
> @@ -1449,7 +1473,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   keep_locked:
>   		folio_unlock(folio);
>   keep:
> -		list_add(&folio->lru, &ret_folios);
> +		if (unlikely(lock_contended))
> +			list_add(&folio->lru, &contended_folios);
> +		else
> +			list_add(&folio->lru, &ret_folios);
>   		VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
>   				folio_test_unevictable(folio), folio);
>   	}
> @@ -1491,6 +1518,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   	free_unref_page_list(&free_folios);
>   
>   	list_splice(&ret_folios, folio_list);
> +
> +	if (!list_empty(&contended_folios)) {
> +		spin_lock_irq(&pgdat->kf_lock);
> +		list_splice(&contended_folios, &pgdat->kshrinkd_folios);
> +		spin_unlock_irq(&pgdat->kf_lock);
> +		wakeup_kshrinkd(pgdat);
> +	}
> +
>   	count_vm_events(PGACTIVATE, pgactivate);
>   
>   	if (plug)
> @@ -1505,6 +1540,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   		.gfp_mask = GFP_KERNEL,
>   		.may_unmap = 1,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   	struct reclaim_stat stat;
>   	unsigned int nr_reclaimed;
> @@ -2101,6 +2137,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>   		.may_swap = 1,
>   		.no_demotion = 1,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   
>   	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
> @@ -5448,6 +5485,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
>   		.reclaim_idx = MAX_NR_ZONES - 1,
>   		.gfp_mask = GFP_KERNEL,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   
>   	buf = kvmalloc(len + 1, GFP_KERNEL);
> @@ -6421,6 +6459,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>   		.may_unmap = 1,
>   		.may_swap = 1,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 1,
>   	};
>   
>   	/*
> @@ -6467,6 +6506,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>   		.reclaim_idx = MAX_NR_ZONES - 1,
>   		.may_swap = !noswap,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   
>   	WARN_ON_ONCE(!current->reclaim_state);
> @@ -6512,6 +6552,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>   		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>   		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   	/*
>   	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> @@ -6774,6 +6815,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>   		.order = order,
>   		.may_unmap = 1,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 1,
>   	};
>   
>   	set_task_reclaim_state(current, &sc.reclaim_state);
> @@ -7234,6 +7276,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>   		.may_swap = 1,
>   		.hibernation_mode = 1,
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 0,
>   	};
>   	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
>   	unsigned long nr_reclaimed;
> @@ -7304,6 +7347,145 @@ static int __init kswapd_init(void)
>   
>   module_init(kswapd_init)
>   
> +static int kshrinkd_should_run(pg_data_t *pgdat)
> +{
> +	int should_run;
> +
> +	spin_lock_irq(&pgdat->kf_lock);
> +	should_run = !list_empty(&pgdat->kshrinkd_folios);
> +	spin_unlock_irq(&pgdat->kf_lock);
> +
> +	return should_run;
> +}
> +
> +static unsigned long kshrinkd_reclaim_folios(struct list_head *folio_list,
> +				struct pglist_data *pgdat)
> +{
> +	struct reclaim_stat dummy_stat;
> +	unsigned int nr_reclaimed = 0;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +		.may_writepage = 1,
> +		.may_unmap = 1,
> +		.may_swap = 1,
> +		.no_demotion = 1,
> +		.rw_try_lock = 0,
> +		.need_kshrinkd = 0,
> +	};
> +
> +	if (list_empty(folio_list))
> +		return nr_reclaimed;
> +
> +	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
> +
> +	return nr_reclaimed;
> +}
> +
> +/*
> + * The background kshrink daemon, started as a kernel thread
> + * from the init process.
> + *
> + * Kshrinkd is to reclaim the contended-folio in rmap_walk when
> + * shrink_folio_list instead of putting back into the head of LRU
> + * directly, to avoid to break the rules of LRU.
> + */
> +
> +static int kshrinkd(void *p)
> +{
> +	pg_data_t *pgdat;
> +	LIST_HEAD(tmp_contended_folios);
> +
> +	pgdat = (pg_data_t *)p;
> +
> +	current->flags |= PF_MEMALLOC | PF_KSWAPD;
> +	set_freezable();
> +
> +	while (!kthread_should_stop()) {
> +		unsigned long nr_reclaimed = 0;
> +		unsigned long nr_putback = 0;
> +
> +		wait_event_freezable(pgdat->kshrinkd_wait,
> +				kshrinkd_should_run(pgdat));
> +
> +		/* splice rmap_walk contended folios to tmp-list */
> +		spin_lock_irq(&pgdat->kf_lock);
> +		list_splice(&pgdat->kshrinkd_folios, &tmp_contended_folios);
> +		INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
> +		spin_unlock_irq(&pgdat->kf_lock);
> +
> +		/* reclaim rmap_walk contended folios */
> +		nr_reclaimed = kshrinkd_reclaim_folios(&tmp_contended_folios, pgdat);
> +		__count_vm_events(PGSTEAL_KSHRINKD, nr_reclaimed);
> +
> +		/* putback the folios which failed to reclaim to lru */
> +		while (!list_empty(&tmp_contended_folios)) {
> +			struct folio *folio = lru_to_folio(&tmp_contended_folios);
> +
> +			nr_putback += folio_nr_pages(folio);
> +			list_del(&folio->lru);
> +			folio_putback_lru(folio);
> +		}
> +
> +		__count_vm_events(PGSCAN_KSHRINKD, nr_reclaimed + nr_putback);
> +	}
> +
> +	current->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
> +
> +	return 0;
> +}
> +
> +/*
> + * This kshrinkd start function will be called by init and node-hot-add.
> + */
> +void kshrinkd_run(int nid)
> +{
> +	pg_data_t *pgdat = NODE_DATA(nid);
> +
> +	if (pgdat->kshrinkd)
> +		return;
> +
> +	pgdat->kshrinkd = kthread_run(kshrinkd, pgdat, "kshrinkd%d", nid);
> +	if (IS_ERR(pgdat->kshrinkd)) {
> +		/* failure to start kshrinkd */
> +		WARN_ON_ONCE(system_state < SYSTEM_RUNNING);
> +		pr_err("Failed to start kshrinkd on node %d\n", nid);
> +		pgdat->kshrinkd = NULL;
> +	}
> +}
> +
> +/*
> + * Called by memory hotplug when all memory in a node is offlined.  Caller must
> + * be holding mem_hotplug_begin/done().
> + */
> +void kshrinkd_stop(int nid)
> +{
> +	struct task_struct *kshrinkd = NODE_DATA(nid)->kshrinkd;
> +
> +	if (kshrinkd) {
> +		kthread_stop(kshrinkd);
> +		NODE_DATA(nid)->kshrinkd = NULL;
> +	}
> +}
> +
> +static int __init kshrinkd_init(void)
> +{
> +	int nid;
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		pg_data_t *pgdat = NODE_DATA(nid);
> +
> +		spin_lock_init(&pgdat->kf_lock);
> +		init_waitqueue_head(&pgdat->kshrinkd_wait);
> +		INIT_LIST_HEAD(&pgdat->kshrinkd_folios);
> +
> +		kshrinkd_run(nid);
> +	}
> +
> +	return 0;
> +}
> +
> +module_init(kshrinkd_init)
> +
>   #ifdef CONFIG_NUMA
>   /*
>    * Node reclaim mode
> @@ -7393,6 +7575,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>   		.may_swap = 1,
>   		.reclaim_idx = gfp_zone(gfp_mask),
>   		.rw_try_lock = 1,
> +		.need_kshrinkd = 1,
>   	};
>   	unsigned long pflags;
>   
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935..76d8a3b 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1279,9 +1279,11 @@ const char * const vmstat_text[] = {
>   
>   	"pgrefill",
>   	"pgreuse",
> +	"pgsteal_kshrinkd",
>   	"pgsteal_kswapd",
>   	"pgsteal_direct",
>   	"pgsteal_khugepaged",
> +	"pgscan_kshrinkd",
>   	"pgscan_kswapd",
>   	"pgscan_direct",
>   	"pgscan_khugepaged",

