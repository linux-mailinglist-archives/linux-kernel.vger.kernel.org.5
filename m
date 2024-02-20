Return-Path: <linux-kernel+bounces-72198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AFC85B0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF715282322
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531163A1CD;
	Tue, 20 Feb 2024 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="I/HG1+WY"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E62F48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394688; cv=fail; b=jO+pHnzVVAjsurTB8jiG/52EDQG9KRdXVmDGLPlg9feh1H9HIKETbvUNIWclaJXQ35vIPQay4r8kI4CYCwyexxuPJFLuYlZGDJRfmKFpQp136TS3wMCqdTK+w71MUbVv7+gqwUlLsaeQq6DMLlSqcKIcsfCD6X6O+0i93p6UFZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394688; c=relaxed/simple;
	bh=yYPPqHgEcoMuwPXy/M15Qki8WI++ahxQ3fMx6rF66HA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUmjvkTW5AEPIyH3cs0CtVvY1PuRrs1ksjoGbPvfa5lOP0z4gCUzFc5WAUa6rWGxFYHrnVI3mWGMOOgW8Ym3lwOEB1ak2J2GxmBUqaPd+aeGBxN1vgUFdc72zxI8K33swSNpJ1dDXP3yw7VjdItuS2x8tK4SYJZ8tKvoLlXAlto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=I/HG1+WY; arc=fail smtp.client-ip=40.107.215.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTgzNRSFak9/1LCoRbvKs2erilPo/hxHEBzwa61cU97qIKQXB9bmDqFcs74Tmzj6Vn7xSH0myBS98wEy7SuIygj5cEecBh6jCd6XSUi7Yy2tNu60RE+M44QSRQh2uOL+Z1AVeAQl8SfRWdAb22H9JKSzR8vwVnBQbZMQNYhSNYR5OK84fCK4rKXiz5wlXJxzDVf0DdGwieYokySKtYIvbJeTCifqMTioOzSP0qeqJ+G4x6DYV9eQ3dEWOjO8qgBZZAfejGfxHXgl64S0hIOVGkpyNl5V0DVcVYJLkBqW1dTTTMD2jcBUK08dzhoBkZ+e5q1enugZJ7A0E6OLBVtLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWrr7rt0ujltp5y0SNqbALWqPhs6rm6XK3z+/ydVfwc=;
 b=dmeEnm+3FNXm0q7wqjw9Ja7CVg1ymIz1G8RFTRYqFE0TKS/ymyAj8ogH1ktx4Jj6yaIZL1ihBmSQ84GoNcMdM3ISrs55vekKf0FAA4A5WCRRpF378Ss6bptee3nthOmNwZVeN+Eym/pluchbTS2M0XbpAEvRUkMU9krDm2Z6NH2V+Nqr/GKy44eX3tYioiIGVX8pwA0HbHxwzCPnyZ3r9/TSdrmhbd6UMVUcSsL9l048LHjf4YXB0oz1AUYt+zQ5aUdK/yHuJZElJFbDU21bEK6joF3qRt4yLftK9/7tpiGJwUw0FnG2AEhoPJPSM7wy4vQZUQKBsJttfkgnU9r3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWrr7rt0ujltp5y0SNqbALWqPhs6rm6XK3z+/ydVfwc=;
 b=I/HG1+WYUJj8l3n1xCn2RsdLKmjkTeS/GHZn5ZGuVFUeKNbFf+FXjL8PGsVBpYP4NqyYMxY9EQiX7dBbeQSvqXWRHCxJ7Zymk2qt7YZzYBkYaGyA+dtIIKBg1eRvAQswYcB3AsR+oaW6y5eAxyk6qj2xIWM6c8D9i9TVS+JnQE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by SEYPR02MB6607.apcprd02.prod.outlook.com (2603:1096:101:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 02:04:37 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 02:04:35 +0000
Message-ID: <a642d9dc-6d48-016c-7007-c08ce8933d18@oppo.com>
Date: Tue, 20 Feb 2024 10:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Support kshrinkd
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 gregkh@google.com, tkjos@google.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <ZdOG-135dLP0IeU8@casper.infradead.org>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <ZdOG-135dLP0IeU8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To SI2PR02MB5612.apcprd02.prod.outlook.com
 (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|SEYPR02MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b568f54-a937-4809-56ad-08dc31b84960
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T3OqCjmV8ZIx0SXwyi1xnaHOlfr0ZeHX0f6JcWADXICNiPrFjZLNNSk7BecPiC2mxjHZYWVC6I4SrTuod266ZpKrbRTpYs7GglA7S4Ueos181Zs9kJ8g+6E10qYJPZAD+he1F1o3oAQI52Ok5IO8BhAm3yKnFzW/s9zFqS0Vn+YascrO5eW4EcVgd3qGuhlSJx+JZJajVRYnBnNIWHZ1DdSKR4mKfjiEEqErhLtac69vxWs9ZlizUiP86+lPiwiwRTKHWNjf5RKsGXRaPCERbrw/ie8bE9amR7Rd5xFpgZz4/pneVzcoGDJJ/mxXDeVU8Atpm/AwoLIbKF49DjtrRSJ7JTpj6T13vWPk6TmJ0pnXL1pG01sTpuCVAOh0EBSyzb1JVcHxM2xZFwEJGefksfXPJgWdM5kZc5gw3RR5gmCCNE+eM4Ug1i2MS9Wk29KeQrYRFexTICsTw+xNsp2HzwMiq1DQr1ke2hrPuq+QTrCFT1JWBnUDBuhUQXKwnKaPf7XPDIuGg/WkJ4FtXaVedg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmx2VnBxZGh1ekRuZk92V3dUTXFLRUw3V2Rma1pYV1ExQlEyWDFyeDZXc0ZY?=
 =?utf-8?B?dG80bFlENnloM1FLZHVENk9qbTNGNndaRDgxWG9EeEpmTUVoMlhIYWlzWnI0?=
 =?utf-8?B?eFZFNDh0YW9oSE9rV0NTNmJNbldibzlNYVFMS1ZUeVh1d1RQSGxtZGRBTTk5?=
 =?utf-8?B?eUF1QzlHZ3k3UlB6am1LNE84aVRjekxUQWZRcmRCZzBUOS9xTk5tKzJ6K09k?=
 =?utf-8?B?Y3FEV2xmVURqa1ZYbDYyOEN2N0JDN25WNlVPTDcyWmk5T2dNTFBuNTZtcW9s?=
 =?utf-8?B?WGg0aDczNXJGU1BxQkVkazgxQXRkTGZlMFNFRytnc0xBUWVqcnhzTlVZQzVC?=
 =?utf-8?B?NnZEV3ZxMUVHUG5vMzNEU2pSUDVFR1ZqOTdocE55b1JUeU00SXFhbWYwRlJs?=
 =?utf-8?B?UUpmRUNTMURSbFhaenRwRU85cXBzRW5NRTF0ODBvWEErcjVMZ25TdHlCYk5X?=
 =?utf-8?B?R0VaOTJBODVWbnVhR3RzU2xUS21BUHFwVFd5S1M5Q1JwNS9lTVd4R2t5SXlY?=
 =?utf-8?B?dDVWM1A3ZTBYQWxMWXk0MkFqU3RFUmFoRGNPcXZNYnU2eUVCVGpnbFNhU1ZY?=
 =?utf-8?B?bmY4SVZsRzZLeGxua2pUWC96SzJwbWk1anluc0FqREJOcG1zZXR1ZkhFbkFN?=
 =?utf-8?B?MTNHTEtFQ0Q1K1ZxWFVZczNLdnk0bmsreHZnS2dsY28zdVB6SnhlaXBRaUZP?=
 =?utf-8?B?WU5DbVo3RTZvRDFtZmZWMDhjQW1mTm5VdVhNSzdIeWZVYS83ZkFlSWZvaTRH?=
 =?utf-8?B?TXMxbnBpTU4vd3RHdW1XUHp2ODZhRDhKRmtsVEpJcHpLTFRSN1ZpY1QzRkFR?=
 =?utf-8?B?eU56Z2tWaDR4Y3VmaUlGNnlJQk8wZVZRVEJibXdPRFZSNHk2WDdRRDc3bXd5?=
 =?utf-8?B?elJ4dFExMDVOdThqMDdLdmdKbE9BTEMxakUrZUJPQXZHVjI0R2lKWUIvTmtH?=
 =?utf-8?B?ajdKSEZMcnRoV0p6QVlLMk5zNUhFM3p1bUMyUXNUd0FBSUtRTEVzcFBlL0g4?=
 =?utf-8?B?NXZDRjJZbEtaT1gxNHhoMlBDZ2NGYkY2cVF6NHpqbGNuWmdLZUpRclYvS2tp?=
 =?utf-8?B?YjBWMTRtbUVHbGtyWUpNemJDNnRqdkpSdTNnSmp3UXVWSU1QSzU2SFBnQ3Zm?=
 =?utf-8?B?eHhCTFNCb2N3cGpKWWJSRzhrZklDdGZLdTFtbHNQdXdmTm4wVzF3NzFkbE9G?=
 =?utf-8?B?UGhlWFJ0d0tjREFxMXRhWXI2WWptRWh1WFhaV29DSnlad0VoUDEyZC9oSHUx?=
 =?utf-8?B?S1c3dmo1UGRoM3VCMURuQnh5YnpzVktLQUxyLytGa1g0TkZ4WFJQYkxpTGcw?=
 =?utf-8?B?ZS8rZ1hNN0FhQmhUNzZOY0ZreEdkY3gxMFdMWGZJcVgyeldvMmtVRFVoSUV1?=
 =?utf-8?B?N0JSbFBPZ1EwK3NER1FSQ0d4VGlqVFp6T2dsK2lSaDBJTkJrRjArVmZ4bDNC?=
 =?utf-8?B?ZitPZnluSzVsbFFVdDZqZDd6cDhISU9DL3B3ZzlYSVNrUWx0ZWhxK0hPUUtR?=
 =?utf-8?B?NTQyVUIyNklRVlhXMXo3R05VWGhyeFZBbEpNc1pjWUhyNWZLNFlVajNTNHBX?=
 =?utf-8?B?ckR3d1ZpZkRlQUt0cVYzdU9ENUdBci9ySkdYSFNDZ2xTeTUwRFNGRHFuU1Na?=
 =?utf-8?B?eSs1dDJlNG1MOTE1UFpjdXUxM1pGN3NQZENtYUhUU09kSnMxaTNJRE52SmR0?=
 =?utf-8?B?MFg2REtTMTBaVjhWZ294VFRCREg4cm53L1paRUJsS0Q1WGUvTHVFbzVzQzNC?=
 =?utf-8?B?dExqaWxhV0JMRTBKYnpTdWIwNnZ0QjhjcHh5U1dwdXZ6K0Z0U2xmQlNNWnMx?=
 =?utf-8?B?RWVRdUJtU1BRTFd4UVJoR0dPRzE2N0J2UjNGZW00KzNWenRvZVRnQ2tYc20y?=
 =?utf-8?B?dmIrU0xLR3QzVFZPT2F6d3JCQWJDMml2QWp4Q21HVk01Z1AwRFBJQ0dvRzdL?=
 =?utf-8?B?TXg0NEZwL2VkbElNQ0Y0aTV0RGhpbVgvVVNESWVUUUozKyt3WVlrcWNEeXJn?=
 =?utf-8?B?bGkvZEh3TDBDaThTNExic21BSHczcm1vSVRQVk9hYm81UXNvQ2JuYnF6VWsv?=
 =?utf-8?B?TmhlSlBLY2YwWGQwazZTc2dmUHdVTUtzT2Y0MjZ3RlI3azJDblZSRWYxR3A5?=
 =?utf-8?B?VVFvL3FDNEVNRXpkRjBWUDNwcTVoaFpUZ051R1JZY3lYVTdPUWRpdFFpb1RK?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b568f54-a937-4809-56ad-08dc31b84960
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 02:04:35.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+z8INW1JNC+MaHH8gpnrQ4yYEOa/P9gr/Xc+0zsNEPaK7VDdlxV5c376Oq3E2efl0l9wfm5k5jLAwtdIlHktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6607


在 2024/2/20 0:51, Matthew Wilcox 写道:
> On Mon, Feb 19, 2024 at 10:17:01PM +0800, lipeifeng@oppo.com wrote:
>> 'commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")'
>> The above patch would avoid reclaim path to stuck rmap lock.
>> But it would cause some folios in LRU not sorted by aging because
>> the contended-folios in rmap_walk would be putbacked to the head of LRU
>> during shrink_folio_list even if the folios are very cold.
>>
>> The patchset setups new kthread:kshrinkd to reclaim the contended-folio
>> in rmap_walk when shrink_folio_list, to avoid to break the rules of LRU.
> Patch 1/2 didn't make it to my inbox or to lore.
Hi Sir, I had resent to you.
>   But you should talk
> about the real world consequences of this in the cover letter.  What do
> we observe if this problem happens?  How much extra performance will we
> gain by applying this patch?

Hi Sir:

Monkey-test in phone with 16G-ram for 300 hours shows that almost one-third

of the contended-pages can be freed successfully next time, putting back 
those

folios to LRU's head would break the rules of inative-LRU.

- pgsteal_kshrinkd 262577
- pgscan_kshrinkd 795503


"pgsteal_kshrinkd" means that the amount of those contended-folios which 
can be

freed successfully but be putbacked in the head of inactive-LRU, more 
than 1GB(262577 folios).

Mobile-phone with 16-ram, the total amount of inactive are around 4.5G, 
so that the

contended-folios would break the rules of inactive-LRU.

- nr_inactive_anon 1020953
- nr_inactive_file 204801


Actually, The patchset had been merged in Google kernel/common since

android12-5.10 and android13-5.15, and were taken in more than 100 millions

android-phone devices more than 1.5 years.

But for the reason of GKI, the patches were implemented in the form of 
hooks,

the patches merged in google-line as follows:

https://android-review.googlesource.com/c/kernel/common/+/2163904

https://android-review.googlesource.com/c/kernel/common/+/2191343

https://android-review.googlesource.com/c/kernel/common/+/2550490

https://android-review.googlesource.com/c/kernel/common/+/2318311



