Return-Path: <linux-kernel+bounces-100020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D9F8790E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FD43B22BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB879935;
	Tue, 12 Mar 2024 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Y11ochgw"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19CB78280
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235390; cv=fail; b=l4O6a6KFxWblcQzyyIe/rv8rONfcxQa/88QMAR4eD6qrhSQj5jeyEEpv4D34h8pEgo5QTdvxNB32B/C+E50aOkaYOYIf/M+xpijDXiMaz7l5YOfkaIJ9QN9gX0eHAdcPmqr7YZ5wl8jvNwq5TpnJ/UJ0Ftf3jVdnkv2tHB9F6t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235390; c=relaxed/simple;
	bh=6az+dXSq1gdd30vRMNPOB7+if/aZApdOAZfzc51eR5s=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+leAb8X3fO5uwMzw28c5riHHgNg7YrYil8g/ZYSi9AnfSh0L4CxfyH6bLiQROvJxn00mKN/hvcrO4l8UxQ7Yp5jXYgYD2Mif+jkRghl5cLseBaN67snX1KMWYoc9CaIM8YBWLmhExH5eecCu2SJtHhZKTjxYv4uddyhgyCufo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Y11ochgw; arc=fail smtp.client-ip=40.107.215.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZlTRGKjOgvxl9+bPc12uq3B49IWKzyWiGMFEX9UStQ8nNWWM3yBrYXjP8agtX7Ibt+1EKu0zun4GqvdlndAuDRU37TZIUkZbTjeB/sfGdRn9sCRapT/PxVxQid/9BGPmSkCQFhahtzyezMciK53fKWegvD0rJZ6AhLy/7j/wLfByudOxoyCojc0P7WF5EbMht/7lvDk88KCrHsePX+feAHu7z3urn9qWw2HCc/uI65RUpYZUSEYjcOysQkjnmxAC8sg81ChkNshFwb5dN06rEMYrIT9eZkY8EBl/gvMERJ0jB1di2Dyq2+x9PQ493P8DRWEf6wmWWzFdbjmZe/QVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku//hpXtqiAlEhfX5QrtkC6pmzaVmI+7TfskHpQsoSg=;
 b=T+NZ6vhPlaNda9aUKat/9YkF4vkBw2ASqaOw0iGaY71U4VqF40eMoiS6DMnBAxIkzcRNgxoacwISTglf2qT8lbzc6irBm6mAILdLmOKEUSRBlUKum0a7+Nkqp5S5OtRtcjTHD1Gfs7xoEoTDAPZbVkXwhdgFgqEB79J2BicnAjFkg7P2MYH/A4ISkm3TLx9F0LTXLHN0NMKTr7PprtsG+q/sewAkJK8jqykH7psJ8eK+Rctj4U5dVjsNAIC233dhvPNUwYyosxQohEjs1TEOkH64NJ0q+/VL+YaIkMpSZQ21WajUAQOU5JkuuNopvtXsfGFQeIw5WM6D6FuqJzERGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku//hpXtqiAlEhfX5QrtkC6pmzaVmI+7TfskHpQsoSg=;
 b=Y11ochgwyDpjma0Fw5WzvfGVQbiQgaNba68MrM4HErtW8fsb6AEym31Dcp2/6cICkIxajSdqiWxkocxaFuFBl8KRq9GkLaPAPY9Uae2ElKSuripCVNhXiDiDh3z8Gw6aH1ZVn1ez2zh+1Dc0H+HSgasq3bYH06/O/Zi1le9DHVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by JH0PR02MB6514.apcprd02.prod.outlook.com (2603:1096:990:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:23:03 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%5]) with mapi id 15.20.7362.031; Tue, 12 Mar 2024
 09:23:02 +0000
Message-ID: <d7c5959c-fd3d-4406-b3eb-a4cbf04121d4@oppo.com>
Date: Tue, 12 Mar 2024 17:22:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] reclaim contended folios asynchronously instead of
 promoting them
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>
References: <20240308031126.750-1-lipeifeng@oppo.com>
 <ZeqajmATLj5gm6Bv@casper.infradead.org>
 <b28879d7-b955-44cc-bd51-0ddc7aa33ed5@oppo.com>
In-Reply-To: <b28879d7-b955-44cc-bd51-0ddc7aa33ed5@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:3:18::19) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|JH0PR02MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f42d8f-c72d-4240-db86-08dc42760457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oLettO5OhzvFD9KN190dI95hYLc5ueI4cF/69yYGOfpvH/s2r/mH7UoqHZH6JK2dnJel2lqtfiOJQCIjYRFfi7u6lTLkxlJajpVD3r9UaQZWAJxpcDyBhR0V2TU8dS7OI62HtUA8TqNQzbflIu60m3jhFJxQFzjTFnxZyvCsGxpk2t8T9R7mWvWMX/6s/Dw2VZBmPDnxa/yqIshxXHiwJUXeZDkQPwPk182ra2UtFH5PTP2HEN8bJvga8b2TYtl0WxvAvhRA33FWp9nQctpBO6SYRpdAlhSQ2o2p4lG3HQEwUY4rlixzHv0Axxr0SAB7pXOfE8P04K4OgAtgNlI4PjmG0Mt3O93FDKwU8+Qc6MIDVthKpeSi39Zax0jxKXu7FJzQW+jEOZzgRexPZJuxa/jqaO//fGblARQSKstNsBodpOhKUg7Ecf8nWSD0/WVcCecOeeWh4ElupZRwSJsw95PwNDuDDSXjsq0Bn0bV+YHq/w0nF3zuqLnVX64fEYitijRAcyw+AO3sV6tHBoRQLsAQW45xa9rZkUgQP4smisyEyZVpnOrfacHqwbBiZdA04xANODgzVMLoEfHXFGnpt0JnUBqoChMJ3uc4oYHr3cN33QEIXwC6xrF7xFUDVfHiQBACfsEqWOv7CPdJhxoNdLSCydbd/JQODAiao5JBKzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3c5YUNKc0NTcVJQTlBtMzdRektmWjZGWmRvRGpYTGNZYXA4MGcyQjIwb21C?=
 =?utf-8?B?cFlPcWVWUzBTMGR5Q2JNZTVXbit3NVM1VFZQcDBwUlkvZC8xTGZlMGozTS9E?=
 =?utf-8?B?UThXTkR1SGNZdlVnSUFRRFBaZEdSc1liT3R4dE5LaUcvMU5ISDlXZVZkQW9p?=
 =?utf-8?B?ZzFsWVZrVnBFTHRqZVMwUjRxSzJiYnBPbjJhTFdvQWhkbFdDNVh4b2xsb3Yr?=
 =?utf-8?B?NDltZDhXSmNxYmlXdkJuSVNFVVVROEovbHdZd0Y3T3pLTVJVNFo3NzlsUjMx?=
 =?utf-8?B?Lzh6dmJyeTFpK3EwR3ZwZXcraW1nYUN2S295Sy9rLzVmenJpNWNmV082Q2Zv?=
 =?utf-8?B?ZlpvK21tS3RKaENUUUl0U2o5VEdxdElLVzBYS0hhcU9MM2dRM2JJRmdlWHVM?=
 =?utf-8?B?Z1B0UHVOUTdabkxBVVhMQXM5RHlyb0VaWXBDQnVFTmxSVU5md0xMUDJJRFQ2?=
 =?utf-8?B?dlYxbzBCRnFPMlNVR3g2emRjbVJMd2d3cElvcDdCa2J4RnpQTzBEYnp1cnA4?=
 =?utf-8?B?SHhJMXkzZ01raVNzL2lVS09ocHZPUzhvMWtEUzFXVVNRTnlpZHdITTc1LzFF?=
 =?utf-8?B?ZWNGMGU2V2NIb0V6Wm1JNHBwc05GY1dUU09FZFNiazE1Y1hCWWJoYzNKYWlM?=
 =?utf-8?B?eC9xUWZyVjZreXpaSlVTL2pEK3duTERKTml4NEdRRlM2eE5jOUhvR0pVSEI2?=
 =?utf-8?B?TnVodVZNYWMvUWFrZWxmOVhiamF5RkVnVU9FbFNMQXQ3OXJZaGRXcG5SVEhC?=
 =?utf-8?B?Z3ZuanB2bDRsR2pXZTlXNmtWLy9rcEZYV2wvL21Pa1lKMjg1TDlJanA3dE5v?=
 =?utf-8?B?citVUXdzdGdzSnBLUHUvVENkZDVPQkFMVCtjM0RHU25jb1VBUUJScTkvOWlP?=
 =?utf-8?B?b1lLeGxpcnRBdlFQTytEOE5nUGZwS1F6ckc5WDY1U2NmSC8vbWlMZ3ZRVEJx?=
 =?utf-8?B?N0xKUCtaVHA0ckp0MFlZdnFTbE5lKzJObnFRb2Z4eHNrOG00SWdRRlRuRWdt?=
 =?utf-8?B?TXZNQ21Wc0dSU1d4cElObGx5Tms2SEZQUTRyRjAzb2NXbnhzWUlGcWFxdjRD?=
 =?utf-8?B?MXpqcC8zbVoxZHVEUm8reUlnSHM3M3pBc0pMdmlMSmsrSXI1SlJEZFV3TXcw?=
 =?utf-8?B?Z21BczZKR0E2dllpQnlTZENCekdhZ0J5WEphMkNIUHdsV0dJeWZsR0RJdC82?=
 =?utf-8?B?ZG5aNDIwYVJMSFdEV1MrNndUMjRabUUzTDBiWEszZFhEQ1kvYzFmbk5yVkt3?=
 =?utf-8?B?SGViWFcrT0tDQlZrZ0U5YXRqaWo5dTBiVlJYNUlFeWRaT3ZwWnBXM3NUcStK?=
 =?utf-8?B?VWsxKy9PT3BJREg5a2lsUE9seTZMcTRCZUxHbmV6TUlRaEpoVUFnNFJJTlhH?=
 =?utf-8?B?alNGS3l3WGtYUlkrZ214eFQvbTVPMmV6RWVwdVpJbFRkT255QlN2aXd0Q210?=
 =?utf-8?B?d1RjOHVrVDUzWlQ3bjJzUkNheDhHQ1h3eUhrblg1TXArbkxuVi9rb2ZFMjNP?=
 =?utf-8?B?bW1tRUtFU1Brc0pBb1c5QnE3NEdnOHdnSmRnOXNucmpXOVJLbG1CQkVwc291?=
 =?utf-8?B?Y0RQVStVN2NKWHV5a3JFYWlkN3dkK2tGaFBjdEdWYlFYVHowaG5WMUZxNkhu?=
 =?utf-8?B?RzdJUlUzTTJSVHJYb2tKbCt4dkFCRER1OElHY2pncXpWSXBvTXRJT3hSQWJ2?=
 =?utf-8?B?eWd5U09tcFUyY3lKYTZpMlJwRktLYUs2QUl2TzcxUHRJSjE3UjZDelE4Y3Vz?=
 =?utf-8?B?QXFPbWRxNWNremh3VVJvVHc4Zm94RUozcXdRc0dOSTdLYnV0Uy83WllLdFk5?=
 =?utf-8?B?aU84dmpwQXRwZG40QU1uSS9HKzNLc2NWL3E5UDF2cFVqbjlnbk4yNXFOZllN?=
 =?utf-8?B?TFNuQ1FwLzZ1RXg1c0krenpKeWY4ZDdQcWl1Nk9OMzk1Z0dNWk1Ncll1dkpW?=
 =?utf-8?B?TGQyc3BDb0ZZeG9qeTMyTW5TM3lzZFBPOG1VZ2pUT0Ixa3hLRkJLYTZlMGJQ?=
 =?utf-8?B?K05WNlE2R2ZaYlY5Tjc3cjEycWpmR1dVTWRVbjVsZEx0YlBzcW5DMzV2dDJo?=
 =?utf-8?B?WUdvZWdkTndpY25TRzJscDFZZUZrQ25sQjhBeWpXampRNTZFQ2hKeUY4YVRy?=
 =?utf-8?Q?4LGL4w8wix1H2GuX5v4crFHoU?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f42d8f-c72d-4240-db86-08dc42760457
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:23:02.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8zcC/SraEetObr/MWZKnmj6YHISHOV3LE1eZbPSzfxUrpaufk34Ud7AjpO436DIq3vIXCXXb+BrlswVkMliHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6514


在 2024/3/8 14:41, 李培锋 写道:
>
>
> 在 2024/3/8 12:56, Matthew Wilcox 写道:
>> On Fri, Mar 08, 2024 at 11:11:24AM +0800,lipeifeng@oppo.com  wrote:
>>> Commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")
>>> prevents the reclaim path from becoming stuck on the rmap lock. However,
>>> it reinserts those folios at the head of the LRU during shrink_folio_list,
>>> even if those folios are very cold.
>> This seems like a lot of new code.  Did you consider something simpler
>> like this?
>>
>> Also, this is Minchan's patch you're complaining about.  Add him to the
>> cc.
>>
>> +++ b/mm/vmscan.c
>> @@ -817,6 +817,7 @@ enum folio_references {
>>          FOLIOREF_RECLAIM,
>>          FOLIOREF_RECLAIM_CLEAN,
>>          FOLIOREF_KEEP,
>> +       FOLIOREF_RESCAN,
>>          FOLIOREF_ACTIVATE,
>>   };
>>
>> @@ -837,9 +838,9 @@ static enum folio_references folio_check_references(struct folio *folio,
>>          if (vm_flags & VM_LOCKED)
>>                  return FOLIOREF_ACTIVATE;
>>
>> -       /* rmap lock contention: rotate */
>> +       /* rmap lock contention: keep at the tail */
>>          if (referenced_ptes == -1)
>> -               return FOLIOREF_KEEP;
>> +               return FOLIOREF_RESCAN;
>>
>>          if (referenced_ptes) {
>>                  /*
>> @@ -1164,6 +1165,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                  case FOLIOREF_ACTIVATE:
>>                          goto activate_locked;
>>                  case FOLIOREF_KEEP:
>> +               case FOLIOREF_RESCAN:
>>                          stat->nr_ref_keep += nr_pages;
>>                          goto keep_locked;
>>                  case FOLIOREF_RECLAIM:
>> @@ -1446,7 +1448,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   keep_locked:
>>                  folio_unlock(folio);
>>   keep:
>> -               list_add(&folio->lru, &ret_folios);
>> +               if (references == FOLIOREF_RESCAN)
>> +                       list_add(&folio->lru, &rescan_folios);
>> +               else
>> +                       list_add(&folio->lru, &ret_folios);
>>                  VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
>>                                  folio_test_unevictable(folio), folio);
>>          }
>
> Actually, we have tested the implementation method you mentioned:
>
> Putting back the contended-folios in the tail of LRU during 
> shrink_folio_list
>
> and rescan it in next shrink_folio_list.
>
> In some cases, we found the another serious problems that more and more
>
> contended-folios were piled up at the tail of the LRU, which caused to 
> the
>
> serious lowmem-situation, because none of folios isolated could be 
> reclaimed
>
> since lock-contended during shrink_folio_list.
>
Let me provide more detail.

In fact, we have tested the implementation you mentioned:

if folio is found to be in rmap lock-contention during 
shrink_folio_list, it would be put back to the end of LRU and rescanned 
in the next shrink_fofolio_list.

During the testing, we found a serious problem:

In some shrink_folio_list,all isolated pages could not be reclaimed due 
to rmap lock-contention, resulting in a serious memory reclam 
inefficiency and insufficient memfree.

The specific reasons are as follows:

In the case of insufficient memory, if folios are put back to the tail 
of LRU due to rmap lock-contention during shirnk_folio_list, they will 
be isolated in shrink_inactive_list soon and attempted to be reclaimed 
by the next shrink_folio_list.But these folios are still likely to fail 
to reclaim due to rmap lock-contention in the short term and put back to 
the tail of LRU again.

As the testing progressed, more and more folios with high probability of 
rmap lock-contention were put back to the tail of the LRU during 
shrink_inactive_list, ultimately resulting in no folios isolated could 
be successfully reclaimed in shrink_folio_list.

The shrink_inactive_list procedure does the following:

shrink_inactive_list()

-> isolate_lru_folios():

isolate the 32 folios from the tail of LRU(some of which may have been 
put back in LRU last shrink_folio_list since rmap lock-contention)

-> shrink_folio_list():

reclaime folios and putback rmap lock-contended folios to the tail of LRU

For example, assuming all folios which were put back in LRU due to rmap 
lock-contention in last shrink_folio_list, can not be reclaimed 
successfully because of rmap lock-contention in some case:

1st shrink_inactive_list():

-> isolate_lru_folios()：isolate 32 folios

-> shrink_folio_list()：reclaim 24 folios, putback 8 rmap lock-contended 
folios

2nd shrink_inactive_list():

-> isolate_lru_folios()：isolate 32 folios, include 8 rmap lock-contended 
folios

-> shrink_folio_list()：reclaim 16 folios, putback 16 rmap lock-contended 
folios

3rd shrink_inactive_list():

-> isolate_lru_folios()：isolate 32 folios, include 16 rmap 
lock-contended folios

-> shrink_folio_list()：reclaim 8 folios, putback 24 rmap lock-contended 
folios

4th shrink_inactive_list():

-> isolate_lru_folios()：isolate 32 folios, include 24 rmap 
lock-contended folios

-> shrink_folio_list()：reclaim 0 folios, putback 32 rmap lock-contended 
folios

5th shrink_inactive_list():

-> isolate_lru_folios()：isolate 32 folios, include 32 rmap 
lock-contended folios

-> shrink_folio_list()：reclaim 0 folios, putback 32 rmap lock-contended 
folios


