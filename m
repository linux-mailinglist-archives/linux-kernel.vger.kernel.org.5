Return-Path: <linux-kernel+bounces-66071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607085563F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2E1F23DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DB18639;
	Wed, 14 Feb 2024 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLSc2j6y"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB4182DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950554; cv=fail; b=kIZnH65G0MrZ3J7EsEY4SSJhNWFVLeoQbOq8kNA5G6/KnFWUWfNf0bpiK29oA4ec8tp2xD0X/FWrHx6/v4b+D0v3jJOZTWe4ffMYQYV4nAmpTSbaLaYi9ljx0p1m2Z2vlSkh00tMK2z7yJsiQXY60HVL4uA1iS9Sqw2gxP4xODc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950554; c=relaxed/simple;
	bh=KRBISNJHZWc5MjxeEKMs19Eh5LK7UiKuxUlylXMLXfM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=crYxdo9wI610ENv9ZxoTK4ut8ETGgFaueSRBpsZloMtr5ZeqBZt1s/xRx+SIbzytnshlG74amLT436er27irv843RX1xOsLBOBYk63WxKB1bntIhjOB/1WSXpVLNU3KRdqPcuVd70+lOrOXOEWhtCqNLu/GeeQ6voKfZrTpgpNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLSc2j6y; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrH0eyIZl1IBq0a3XFgRlISz2jhG9pwDmkcyfB0cYZTAnFS4WqvSi+oFBx6877sdCWJxXwyn8bBEN2MfrE9ddYySx9POHCjVUZRldCbR5731xz5+UZ93PTvIAA2asXTxqVWo4qenUawjSbuNL49+s5AY0k7tyZq8WDqtyWUaATNcR5qZwB5j78FY5bNb9hm7Cggg8tBx92cVMh5MM425xXEJQZ8QcN4NP9AebygV96OyQDxQTrViybelC5fHp1rCOTefLPWKUA9Th0f42B8SpBuzFT3w6mfdWK5w6ZlNVW9nOVECmT/j6vpWJ2sg6wyN/OB57Y6N1/ieyTDLJG4jLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KYJqgidmqbDkgJIkNggjLiwR2PqTQrgZRmi0591JA0=;
 b=FuMHqW3diWGdFcz65n55DP411nN+EZr14p8yaoIe4pFHUXrrtV7nfzTyuEeOczWJ/7aPvNk+U8Ad4ocVoybC2O9m6Z76txnBk2lWtU3sws4Cn9oo1PRg3nEFIp1XwVPHruKxRx9KhII5llKEzoFZqB3rm7WmRd59JZ38lCjH85qlVmnBi/KKuyGQVJk0oosuwj8NgdKi6frPv8UYYLxBbJ5hKKdyDjscdnucJ91ujQ8/5tlqADSGuoQYUcHrZz6cGieC8nxX5pljY5DwkaSkyI9Ewl1v7wZAvLZpIYtTBYMJFdsHELVh7BZdzgI0KMEZc0YufoYk9YySoE8skgjDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KYJqgidmqbDkgJIkNggjLiwR2PqTQrgZRmi0591JA0=;
 b=RLSc2j6yU6TUrOsjHVSjr+ZZNh38cdFwYqX+sY2OTyCN3dGtnjjhpHgHDOr5icxNjGPxX47i/he8f0Ua7OGlRcWwqFvc4LWZRJQNjlgJAb6O6QyqCQor5+8GOfTUaBhl/nPkMjHhMrGndXKxdqyujhrRloF8njel+X3YB6aoNgRton1rMK/knNrIj/AT6GCPrn9jqFmGgu+8VTBFqQrm/e4UtR0c33G8OcGP7IWkGzHMUpIxvZfXPvEqznCQLmSvI+EboNftB9Rj5cBgaD17eMA2Km/xJFE6ooBgx/S6B0taFWZVvqpkp4vBECzUEEBSNOgjHEHh7Svx92tacDjrSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.21; Wed, 14 Feb
 2024 22:42:29 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb%4]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 22:42:28 +0000
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 1/2] mm/migrate_device: further convert
 migrate_device_unmap() to folios
Date: Thu, 15 Feb 2024 09:38:42 +1100
In-reply-to: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
Message-ID: <877cj67jn3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0049.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::14) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d968920-4a73-47c4-56f7-08dc2dae3938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jAa1vNgSqn57jsZKfy3hLA8n+t9cVuXCKEz+Fh/60vsrmZTtg9L381xjYlkuqIRpj/aSpk/Cre3OESEMisI69VDwJ15Go/qmV4AF0I8RAgeL21gD3otWCX4OjC0GyQ54lb+06ILf0sUPdsQQPFM4iBYYQC98LhY/N7IkSrPa+0mBWfe+iW8VuDAkkP0qVBRHIb7fbEAcCGHQBad+A2aYpH3tAWhpZaih1Wn62YgthaaPNPwzthopRYSK6S5NhWX5zJz2iL1aXMK8YlHuTFgMHFpp1bJZlin+eH2BGx9SaRujcy/YtUCHevKaq/rd1UzqYhKkR7YbUOc8/JGXiub897b3T917NrIIDfUxdP9ijL4F+Gw/aJFF7XglFdbAyT3/t9EZE2k7DEvkxZ4bFDnO3KbhPsJSpWNet7bOsGx7b8i3cS6lX8hIUa+n/ujG7kiUSbD53rPdhPzKyXHYY1LrPTTCQRg1Yrs9uXlIa0Ay2RXTrDQ+XCdkuwBI0mZHJeKVNqwpmVbGA/tEO2DFER2iLtC2G2aRIWpG098O1OyNoeT2FAegzSCZ0fJBmckdgBHG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(6486002)(6506007)(2906002)(86362001)(478600001)(38100700002)(8676002)(6916009)(66946007)(6666004)(316002)(83380400001)(4326008)(66476007)(66556008)(9686003)(8936002)(5660300002)(26005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SM2kL7Ew7r1wFDBGwINJH+mWtE+oeGuDMF1nCtfXXBjMLJxOB7xQ1dYYIIpD?=
 =?us-ascii?Q?LINYfNOQ8G7YoEkc6UT8kilLL0yh9VKFYlpa9iV0oNqK2XITqvEa+aUysJTW?=
 =?us-ascii?Q?bc5NwjrZAjJeJalBBJFHwmt0ZAHL/PlYGOISydsNBnsOwfFPvQXkCgPZJcrb?=
 =?us-ascii?Q?f+IAFq1D5VpAU6HfWiOF938ZmqjJIMcMyjpTGaCKozUAktUHjNPNv0kfFNwt?=
 =?us-ascii?Q?cNS0aymB4WlpkyD3woSlCIRo1HbAX0ouLgeuxP+6o+znZvLrrq4LJZK2i8o6?=
 =?us-ascii?Q?czUdVF0ASoPhOn7/s14UJsiJIEUOuFjl8gQyqfy5wSmHiYMaMtljJboZ4pYa?=
 =?us-ascii?Q?mFkauSC7TWhzk2USOjSXuT4CuL7gg0LdKktzTT5lvrSqEYpgReQmXT05/pfO?=
 =?us-ascii?Q?Qv93vzbJrhvU74AqGwx260/D0FNrs8WAc1/H7vYZZt44MX9J1jEcjXfEJXlk?=
 =?us-ascii?Q?3D2I59Ojr7hwxPrWs3VeEv7c+SD5cHd2NLfCoLybv3lVfMXNiZOBJqF4K1K9?=
 =?us-ascii?Q?XEmKq4DuoyL78oQYD+cDc1T0CmeHGAVqmNM6l6ZnVHag9w/E6/aNnApvu4uk?=
 =?us-ascii?Q?ewhOMdoRI4nP9I2fr6iz7ipEOg/c/yZVrGqyKyrsi5ziPh3Q2wcHAU+cc5Cv?=
 =?us-ascii?Q?hXL/UQ921WUJFM/SrAbkF+ArTdL+9UsFbYf3CANT0I6JJQStCW9Zo3TYSCeA?=
 =?us-ascii?Q?+EzxGoNuZWL5G/4DPMx1bkkPgjNMIW4JNp8RA33C9MuZgH7DgUrpM1Sg92G3?=
 =?us-ascii?Q?ddL8IfzfVYpuE7S0O74/UQY729On85eKAMjlA9ASoeO88jymZ1Dt4MZqlfxM?=
 =?us-ascii?Q?fYgGCN67v53lNOxaGD+sZYcegB/PZl+MHVR92sgEdjNuX0WFxtx93vlhoOih?=
 =?us-ascii?Q?qsWXnWE4XgdDgtBYk9F0c8xXK1m2Mfhx4F15zEx8gGzk28hz92XQFcBm5eS+?=
 =?us-ascii?Q?aXK6ky4gQ03wWwfgDpIqVs8ilcwQAX1miJR+PN1MUA7Z0axS6ZEDniW4Hg6h?=
 =?us-ascii?Q?lBd6oS+X4aHWhSDdaBWa8RwauGnd3c4PBYW+L1ZrhB2Hb2wE2mM4g+AQAb5j?=
 =?us-ascii?Q?w8I5ZfKAGQNEcQA/U0CAgNZIJCnoNjLVIbyPY84Eiaxf57kfVmUiu3os5sId?=
 =?us-ascii?Q?XG++WiiMPoFZeWhb47hMwx88yhniUzXyeREziU6CSpxwKbZaQPfL0RTitXW9?=
 =?us-ascii?Q?QNP2Q9vY929kRQsOLNGMMLc+ZJhRd7a9SGx+W/2mXcu0GN+/MqD7h9Ya1x6n?=
 =?us-ascii?Q?p/ybpsyAbi17g3ZN2gpLjljpZK2aSLh20E4Eh2RrtMOdWD52C8GHW4I0Sb+2?=
 =?us-ascii?Q?ZY4CtZc0kJFoFSWC6aH8JxopMX7TeBc2WFqIyJRGqxhHuLpqWZZL967aXvS0?=
 =?us-ascii?Q?MFbxZEe0RhauyqIMx1coY02qsbRZ0O2g/fOWWviXeitomyHmt2ILWXuv4ynJ?=
 =?us-ascii?Q?3J+ScJ2cvGAJ2DJQPOhVN841hsTu6KXYxTdAdvmh8UJHE3tB93hT6vKxdy5D?=
 =?us-ascii?Q?B0fIoArqX/48et0tgWQ7eVX3wkaDv+BmBdO4hv6dFoWq55UkEwX4KVmmlnZw?=
 =?us-ascii?Q?1F2zU8w5L/6g06mTyewSdaNYeH89AocWNaPSsP6P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d968920-4a73-47c4-56f7-08dc2dae3938
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:42:28.8691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D97doudhHD6lPw9bMXMg2BmDGmQcb8L0gH7UeRPwdH1lXYaxOZUFv2Nwrjg3tP4F2CJLKzrAo003PVvQzdjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442


Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:

> migrate_device_unmap() already has a folio, we can use the folio
> versions of is_zone_device_page() and putback_lru_page.
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/migrate_device.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index b6c27c76e1a0b..9152a329b0a68 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -377,33 +377,33 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
>  			continue;
>  		}
>  
> +		folio = page_folio(page);

Instead of open coding the migrate pfn to folio conversion I think we
should define a migrate_pfn_to_folio() and get rid of the intermediate
local variable. This would also allow a minor clean up to the final for
loop in migrate_device_unmap().

>  		/* ZONE_DEVICE pages are not on LRU */
> -		if (!is_zone_device_page(page)) {
> -			if (!PageLRU(page) && allow_drain) {
> +		if (!folio_is_zone_device(folio)) {
> +			if (!folio_test_lru(folio) && allow_drain) {
>  				/* Drain CPU's lru cache */
>  				lru_add_drain_all();
>  				allow_drain = false;
>  			}
>  
> -			if (!isolate_lru_page(page)) {
> +			if (!folio_isolate_lru(folio)) {
>  				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>  				restore++;
>  				continue;
>  			}
>  
>  			/* Drop the reference we took in collect */
> -			put_page(page);
> +			folio_put(folio);
>  		}
>  
> -		folio = page_folio(page);
>  		if (folio_mapped(folio))
>  			try_to_migrate(folio, 0);
>  
> -		if (page_mapped(page) ||
> +		if (folio_mapped(folio) ||
>  		    !migrate_vma_check_page(page, fault_page)) {
> -			if (!is_zone_device_page(page)) {
> -				get_page(page);
> -				putback_lru_page(page);
> +			if (!folio_is_zone_device(folio)) {
> +				folio_get(folio);
> +				folio_putback_lru(folio);
>  			}
>  
>  			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;


