Return-Path: <linux-kernel+bounces-153220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C78ACB07
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8627281370
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF115250C;
	Mon, 22 Apr 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="UYjewxEm"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE1152183
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782350; cv=fail; b=hE4GVqW2W47b+WRZ5Wv52jGRszN4MeIY9fYTKQYRkWDSxmiM4ezaSMhT52SwMJi0d+oKks7MMfrCGMz7dKY3HGVYpsbo/oIyMjS4htKeutd0JMJ51xB8SMhLNsJ9hk3tcvgwLyNS2eCG0cEL41EG2oJqD+NhSvzd9GUFm0GoMm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782350; c=relaxed/simple;
	bh=Ux9rRMTweF8tor4HFQpY0zknrFt7L6Px3KVXLsuza28=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsoHIQRJvyg9ODdA9DVXMeewEYx2nhtJfjvYdGBgrDUCe6ITo2TdWst//ZlyMsx0SE0JTFl698eoCBtVfRBOQugvzGJFlnIdLHsbbuR82iMOyg/1LQwz0fYrfswnrZqmhN4av1jzy53ETJqUkgvj0Dhu6+bVSIbwdJnmJ2IAypk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=UYjewxEm; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecz6NywQ6pn3Itu4XUdJULRGezs/BPV5y0wL2WUA6GxT8Fy6wN6W6dgQ1xjyN5a8PuQ3C1P3bYdrjRNosvwl5YEyXNSxSYVjeFQKbgWFEKvpqBAULCMxadpfnYU5IoRGGJpDf1KQSCtrdVbIQoUC/gf/4tNIfp28y9vkFRthG1oGG42s0zQfAXaF4iuG8IuoehR/JsocnVst9Is5IEo1i9bYdyVzr+kgudeEljeBvpTm5k5BsuujtRkeDn6mehfdVfcalLEWh20xXv9DgcMDFl0iLdyUfvdyEY1JMKc7wYfCNO5UD7Ty+Ofesj9kFJoqw8yfydRGEaW1Iz2WcU1dFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkaMX4TMJOGY0GfX+UlxK4zZPoM+pP0bQ72PCujC74E=;
 b=Dazfwdez+SaYAZMT7zjZ/sOdvn+89HzG7puTSnmT74oXJkrdU108JxRuRHgk3Hw6oL31qt+zwMIWfr8GlnWAN2L777KQieZgaiTQTlNtjx8m3fRN6Dq+5otvXZGK2EG3IAjIkA4L2Nr7t9rt8chxEesUbEDeeKxpCtrN3h8B1EYyU1TCHAWYjF4GwD8YgZGHepTJQe/pQCRtdJ9xqdelWPjhcUWzZTEM0D0pB8BIVq4O+PqZi12353icTyvpEU1oOZ2nVBaZm0QXzI+4ltyHyb8QwFE9dYl020c2O0sEzYGUaq+gTpEphqtYQJxk4flSOfKXM0LZBmKwAZQsMuU32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkaMX4TMJOGY0GfX+UlxK4zZPoM+pP0bQ72PCujC74E=;
 b=UYjewxEm+adKyK5f0uqeVR04gRuSthfDAlOnKeAFUSyhguqV56ohEA4Q8uDlS/qb8w8CH3KMvjhZQkm43SRQzvr63q5AVlnTGZq3869+bITuzzxQlZI3R0ocwPnkS/xshTeXfgHBR04yelhVWLin0dy3QQCnlQou3n0A/ezDJu0=
Received: from PS2PR06CA0014.apcprd06.prod.outlook.com (2603:1096:300:56::26)
 by OSQPR02MB7980.apcprd02.prod.outlook.com (2603:1096:604:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 10:39:04 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:56:cafe::54) by PS2PR06CA0014.outlook.office365.com
 (2603:1096:300:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 10:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 10:39:04 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 22 Apr
 2024 18:39:03 +0800
Date: Mon, 22 Apr 2024 18:38:57 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: <akpm@linux-foundation.org>, <urezki@gmail.com>, <hch@infradead.org>,
	<lstoakes@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix return value of vb_alloc if size
 is 0.
Message-ID: <20240422103857.qw5mrcnj4rgej2jh@oppo.com>
References: <20240419101643.11534-1-hailong.liu@oppo.com>
 <CAGsJ_4zUhnAAUb77ktJxDvAQpZhGrs00+8iQU3dhwpy=C_CjDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zUhnAAUb77ktJxDvAQpZhGrs00+8iQU3dhwpy=C_CjDA@mail.gmail.com>
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|OSQPR02MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 681227e7-f8db-4e4b-2a07-08dc62b86e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk00UGY4WnRwcnhrdjlWY1Vlc213emFEUkhjck4xM29EWXFvZ2JkZFFsVG9G?=
 =?utf-8?B?OExUZmJDazBpcFRpUDM2aXRiMWFFNVpxYTBFVkM1L0ZqZjhNOFlpYzIyU3pw?=
 =?utf-8?B?S1BTYzZpMVFETks5TitseWsrVHZXVDNLTlFkM0gyalFDcFZxalFjTHZ3emlz?=
 =?utf-8?B?V2NHdVF2a2U2djFDOVNuRjYrbUxKcFM4eDRtUzFaVEFQTWdycXl3VE9WR1B3?=
 =?utf-8?B?Sm9hRGdzd2Yrcno4RkNkUTlIK2xDWVRPTDkwVzY4aTUza21NdFc3Vkg1UXRX?=
 =?utf-8?B?MFR1ZldyYktLc3ZDZ2RKSTd0RVkrbUJJZFNrNVA3bW9uV1d6c2pWRzZNV21R?=
 =?utf-8?B?VElPeGVCY2RWQXZCaFNURFA5QnAzMG4xUWZtc0Z5ejRJQ0ZhZmpMUjR6L3Zl?=
 =?utf-8?B?cjl4ek1ubkI3S3NNMEdtOEVOZkh5Nm00b3VTYnduQy9hWkVoNWQxSFI4UDhM?=
 =?utf-8?B?a3MrdDNkblFKUWxPaW9VS3F5RlMrTnBLc1gzeGdJSXp2enRtZjZ5NE5ibnJM?=
 =?utf-8?B?ODY5RnR3UTJTU0xXUEdnZXVpU3Vwc0ZWR3hWR0dxenFKN2tBTUZKOUtpRlNr?=
 =?utf-8?B?NThZT2Y4YWh2WTRwSzVDQkhzOWVvNG51L0pLWUhFbDFsU3JCTkkyWWlNaUJu?=
 =?utf-8?B?S1FueGtFeDVXT0F0TjloRTlPY2ppRWkyb2VHWUYreitQNEJGdzQwajJncnNI?=
 =?utf-8?B?T0tGaENpbjkranNvdUNGYlJ5c0JqemFpc0ZLSVRrdUlzdWhZQ0MxL3Q3OHZy?=
 =?utf-8?B?M3ozenZCdWs5cUV6Ky8yTC9SMS9EVXd6M3RjMGlPeHBiS0hVM0E3YkdQV3Q0?=
 =?utf-8?B?QlljYzU2MTVvd2hmb3pEL1QyL0tCTnEzcy9CMlc2NjYxUGFVZnZUQlRmODBH?=
 =?utf-8?B?S3RrUkMrUkxyQ0lvcGIxTEVXRUUzcGRkcHlKV2EvbWtSdjZuYVFOaFJwNGha?=
 =?utf-8?B?QVljNk1ZZXZNcTBkT2ZNd0JCdDRzVUkvbGYxbzY3RU1QUmN3MEZpVCtPd2ZB?=
 =?utf-8?B?UzA2alBsK0xaZHJ6ZzI5dFdzM0M0Q3oxOU13bTRmZ2wxT2xLeXdTYmtlbStw?=
 =?utf-8?B?S2x3SVhjTCtJOGlBT2FHSEhVNjRFV2R0WVZRdXdYTUMvK3VKeWpRWW52M2I4?=
 =?utf-8?B?S1hnYjVkMFNrMy9zQlhRZm8wT3FwUlMvNE5yWW9NUFVJT2ZDOTFObFR3OUdy?=
 =?utf-8?B?ekVrTTgwanhuVStkTGo4aGZVMmp6SDBZbjZlT1VNbXNjdnRoNXhlVjEyVGNz?=
 =?utf-8?B?SzA5Rkp5UEloem9VaURDSzFHZWVaSVdRY1FkVzhyWjV6cnNyOXNmWHVFWGI4?=
 =?utf-8?B?ZXNBaEtZNFk0Z0ZZQiszcWhrQWdpaFJwV056MnlLSThJWVVaczl5Z0l4Y3JR?=
 =?utf-8?B?aVFrK2wxQ3V3bEFOaTY0cFhpb3ZaMUZOVGhYdFducyt5Wk5PdlhFT1AzOElz?=
 =?utf-8?B?NGlTNTZ6cmhPdGt2K3hKSDBYUFBxclU3RUZ3OG03RFlrS3Zpck5IcThpekd0?=
 =?utf-8?B?eG4yaHBsclJJZnVYMG5jUGJVZERyaHVBZXVvS2NIUWdvT1U3dnNSVTRLOHRI?=
 =?utf-8?B?RG5EWFFwWWZLTVozQXNCcWZRYkhCK1o2ZEZPVmNpYUFwTzY5VEtLVHk1UDhD?=
 =?utf-8?B?Z2w1Z0VWVUNOMGdrYi9LVTRoNzBFRmpkeUdqYUFDR0hLZUlsRHZ0YVc1eFhF?=
 =?utf-8?B?aEwrUXIyaUdub2lSd284THI5R1c5U24zWDdLREhSOGZOekRTM1Nxa1RIcThM?=
 =?utf-8?B?c3ZzVUloY2tLZnhyQmtPdWNQTm11Um4vb3RYb2NQNGVFZ0JIWkpMR081aDlj?=
 =?utf-8?B?S0x5QjVJOE0vcWdiQnZVUTRxMGptdnpZazd5MU56OGZkSWJRdUpTeHg3ZUZs?=
 =?utf-8?Q?pGoxycfq0aUd8?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 10:39:04.1504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 681227e7-f8db-4e4b-2a07-08dc62b86e4b
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7980

On Mon, 22. Apr 11:46, Barry Song wrote:
> On Fri, Apr 19, 2024 at 6:17 PM <hailong.liu@oppo.com> wrote:
> >
> > From: "Hailong.Liu" <hailong.liu@oppo.com>
> >
> > vm_map_ram check return value of vb_alloc by IS_ERR. if
> > vm_map_ram(page, 0, 0) , vb_alloc(0, GFP_KERNEL) would return NULL
> > which cause kernel panic by vmap_pages_range_noflush。fix this by
> > return ERR_PTR(-EINVAL) if size is 0.
> >
> > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > ---
> > Changes since v1 [1]:
> > - Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL
> >
> > BTW,  Barry suggests me that if count is 0, return directly, in my
> > opinion, change return value is more resonable.
> >
> > [1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com/
> >
> >  mm/vmalloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a3fedb3ee0db..c430a999805b 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
> >                  * get_order(0) returns funny result. Just warn and terminate
> >                  * early.
> >                  */
> > -               return NULL;
> > +               return ERR_PTR(-EINVAL);
>
> might be ZERO_SIZE_PTR.

Hi Barry,
Hi Barry, I use ERR_PTR(-EINVAL) to keep consistency with the return
value of the function alloc_vmap_area.

	if (unlikely(!size || offset_in_page(size) || !is_power_of_2(align)))
		return ERR_PTR(-EINVAL);

IMO, ZERO_SIZE_PTR is used by slab and can not be catched by IS_ERR().

--
Best Regards,
Hailong.

