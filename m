Return-Path: <linux-kernel+bounces-157897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220798B1852
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B321B22B35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5E6DDBD;
	Thu, 25 Apr 2024 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+64K9JL"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBD5227;
	Thu, 25 Apr 2024 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007242; cv=fail; b=D1mHZljlYJt0WgJYlWG6RuPfXmX6W10TaWjQiM1tg8lByQPR1iE8i2JHstV2YOUJMlTTkVj2Wn5wB+VYLJDXzmR5YmS9/gsVofvcIj8W1FeSgsUaYAmp0t0F8s3g/ghL9ma5arfzGkdgCgP79xu9rvP9U7gPU5BgcNb/xLbG4+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007242; c=relaxed/simple;
	bh=g45/svmcLo/c7kR5Qn4TrBBgEUOee4VG3Uj8V+rZ9XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kuRAgyy/RDWli8nqeR/KKJIRNv4zxmWWkbxNyoYLZfmKi9rSFmsL9qCRkX6y9+4CYJNBv1gmTN4OOOKyZoYS/thfr+hCHvZV2PC9PVh7bppbZDV/VIALkx31Yvp82oK0Mokkr/z1JFOLcjrXr+8oViB7uyFh3WwLEhqYKRh4Kow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+64K9JL; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcDuaIRDNdmzNPBWPGSZHL47WAXB73jIVeeZUja36Mo3Fx+NDQUQPMqcXoUFbOp9efVhTWmGjMV9FabhTMZLHOkaIUs0K9SpOXaGhb0bu3CMk1lsZIHwXD+mkjZvgoAt+iNS4gXpcaZ/3ysrq+lny5QBQx4UAfXpTZwdmF0KrwZ91PnrUFLuwDsaGfji97F82vFc47TVd7kjqeC0kFqgjpPN7fr/LY+1K/BvBmojpjYnMqMmBQjWqCtgdRpflqcFBotcHXO0pttBFCRhDR+xJx57j97kGZqSswlI+KWzNrVEgJCBq4HxjMMEqHPGCf56pxX/h0QEVDHYEnDwCwMH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM5P5ClxA78VLYFq2gZmZxZ3PPDxrkXTHutVhPFT3HA=;
 b=oGKA4ZixXvF4FjaIpuWlxebuMBUMRiI8+g3yN7ShLcJIB+JBpUcEWjSxinN9qL9KlET8ydfo6swsJ8AvY72nncT90t+6auF4OgRMW3ROTfKk7rgcIbzwgHujrXXEXUEhsysG6xPFhXexQD95hhR9VmwFi+JnvWrSmtOoWO0ky1ebiFX7HFEs4+hKjGms+SgKwGMonvjdXcz5RIJXwLlIG1OuPRDUt7Kprvd/ysL8OSFIxTDmhSTb8jQydFRcs+8IQt+QqMYaAq/ef5qBBHwwYhGm+CscstAAwJQRR6F/hPjhbBhl9aafv4nTvaPB8ce7TSuDigiH2mA4C94UnAmcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM5P5ClxA78VLYFq2gZmZxZ3PPDxrkXTHutVhPFT3HA=;
 b=T+64K9JLXO3lGYB7Wsy0W86C+ZizpLPIn9FUXLCyx2DZknSa2IIo/jVZbgpmbgMiyPcJX7YBEDmCJlwf/F7lON6Tpkr//mbUSX2owx1UoL6Z+UBVFZcE/F+HBqkjkGwCulW08JqAFEhOiMO6kJ4AKUOCDSCH4Fh1iBJ1MfNdlavso9jZ27HE7MBuI6FlmdHnbrKk3E2+6BOa9ZBqdyrCZD9EZ8nVg9xHvIgTZ5xCAzKoXD6fHgQFniEdCuP7ShFENMOQ3AQVa23bXCoZHnNY5TTNYIWldYjoloV+yjFfh+YM8r0ohCa29P+D8fWyGEdPxoa4sGvQDL8Q+d0H08gx6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 01:07:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 01:07:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 hare@suse.de, john.g.garry@oracle.com, p.raghav@samsung.com,
 da.gomez@samsung.com
Subject: Re: [PATCH] mm/huge_memory: move writeback and truncation checks
 early
Date: Wed, 24 Apr 2024 21:07:16 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <0273A5B5-0BAB-4A11-A760-5337927B0264@nvidia.com>
In-Reply-To: <20240424225736.1501030-1-mcgrof@kernel.org>
References: <20240424225736.1501030-1-mcgrof@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_EFD33508-11D7-4F57-BBB2-72B845D772E5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: d051aed6-6331-4ed0-f002-08dc64c40d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seTuHI9prtTQEXJGhgxSpjKBiNR161F8UGtGDx3MO76x+DQ6oxiiD5jPPFcX?=
 =?us-ascii?Q?5awaMs+iVsNBhRBrVtqqNkLLiZjv0o3NFk8wosVVYBtoeE9MOHmcDoS0de9r?=
 =?us-ascii?Q?xJlcygq2PnzxGv23xoi3iw+RZSaEJOEFyPjKSvabjGzTI2qBjBXWOhsqtVTR?=
 =?us-ascii?Q?Ui9gpJcQQ0iHddP+co0Z0OjE+7DIs6gPT5xI/eobti4ciXjixOPYOg4YRfeN?=
 =?us-ascii?Q?f//pqGDHBv45xtMheIWH0lYuDTgTOKA82hNGhD/Z+UwBU6F6dqAioxya0epT?=
 =?us-ascii?Q?WmYwDCDRdfOWV8vaqprXfKt/oF7ayxH3Kca8QSaCEKvZFuqB8Tw/oGJrf1+U?=
 =?us-ascii?Q?o8vQ4x4yCLkfjzTljgOXLAFiC+r5C1mHGp2/inihzoYkcQV4eAlvglKJ/fo0?=
 =?us-ascii?Q?DwqF5yh3ZhQA/aCeQL9H9fsk9NRL4hgpSJqv9tFqOXNStBrttlEM0U6jZDO4?=
 =?us-ascii?Q?wbfor4gvolQRtE7wINXLo+rGu3rkEJIPl3jPzOHdAYUv7Tj8v3RMF1ULxW34?=
 =?us-ascii?Q?jOdDr83/6DRC3NbrsRNbT0ADPVoveUbQOsQfKRXVNKkZfdktZb79PJpaI69g?=
 =?us-ascii?Q?ykQFA0NiZZPL7BNVb5DPCsiFUs62DAgYFfdM1PJQaS74p0eX5tVataxqbolc?=
 =?us-ascii?Q?5fsxGuWOmsGf4dPjSIHCBxlq2eg4GoNSeJkdyNY6zkUUuNopte4tKRLWGKYy?=
 =?us-ascii?Q?nvfZ5tsvnRkPrORAEkbs/MEkg4Qa6afdKtTreldRR/mFSYzb5dRQc3HA1fnb?=
 =?us-ascii?Q?WZJgxdzQXwHwUr7Ipu7O5tZ079AirvdlqKLUEp83w8m2aT0tmX76HGelWlrD?=
 =?us-ascii?Q?1tHY8pxkC/gNtdFO0ED14Xx4TZx8BmF8ZZQ+PweWg2eawRAqoFQlfPgYrKrQ?=
 =?us-ascii?Q?nMoRR4Hia1FYdP5WxqI8kOGYolCb57+tiv6KZldpzqbjZl1wbHDGChYycDig?=
 =?us-ascii?Q?fPn2ikqt60POWUpdxb7K82XFzTG5nbNT2LR0hBOlpWkobalcD+cUI2uqqr30?=
 =?us-ascii?Q?/Kc293hDXsd1/Y3wU1L0edrWlCrzSi2VbvmnnO/XcftCILrPlrprNYyKmMp1?=
 =?us-ascii?Q?fJl52PFzmZRcoV+WRRQ0ImoZOXmNqSlyxraBwFqKaqlr/1/BpI9JMDMVvwop?=
 =?us-ascii?Q?Stj2d68h3BixXkJwNzIK3hOJYIIFAhpfyi5mFQjj8mS4spblvAWQRYw76AQn?=
 =?us-ascii?Q?XaCl8NFppadB2pHgcHnwi9imciFhgVQYZ/qnUZjM78HSldJ9Sv+MheJtuHwK?=
 =?us-ascii?Q?x5Fh3iXwQgwkUqEJYeYaiIddPizZRNtS5CKKsEW2MA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qq2RUNpTjUF9zluJsdWZQzGjR9MQL8V4KaKkbNam6bbxVz2mXvboUAqCGq0x?=
 =?us-ascii?Q?CDNBnfYmURIgh6DWT9j7mx0WOOZCfDEMqEfthSOnwdXvLqNM2zP0p3fBEEPv?=
 =?us-ascii?Q?j0rosbgn4EgCiK3dnU6mM+YbOoYrL9wA9fiTjhwCyzgyzdJ+xQVcL90FFCqo?=
 =?us-ascii?Q?GDoC/UDyVN7lZ1IdNscf/g9fpBL6LPTkbWkhk5Oh/f9jWACv5YABnEiC/gso?=
 =?us-ascii?Q?7g43rr2JWyaic4c0lISPfTbmzWGlH+VP/K1r0KclnqNoTZQA6DiJ4GWm+Kgv?=
 =?us-ascii?Q?Hd3GolUAJ95wo1TvrnG/cnAW25LQEXSj2jULCsjY229zP7M2Oj9zQg622LRt?=
 =?us-ascii?Q?LnnYmCCimF3oBbOc2FB8LrcjsE7DMzIYQKtO6cPsED55zgjBJKzLhoed5HEm?=
 =?us-ascii?Q?f5Ztn+HXkbuLn02kZUwJgTlGnOTnMds/8F32n8VXsEVB2Joppw3dN81vpLzs?=
 =?us-ascii?Q?ZoVStso2ufUQDss5hFMEbwciw2vf9MzvmzyGc22DZmxBO4fK9V7C85hgBVpu?=
 =?us-ascii?Q?+Q/CTFzUt+wLbpkX8lRfzXJ626Z3oeSU5NiY57l86yetCViYpmzKJFyCH4wr?=
 =?us-ascii?Q?ARKrRkxaKajuAMHjVKYtdaDLAeUVpeqZHNOkzuQc/gtLR+ivSw21Xh1B2IGw?=
 =?us-ascii?Q?e6jFPUj4rtyssaNWW60aezZhwsa/AP55SoHN1AocqBFx5MkJ73YTvBBcAIxN?=
 =?us-ascii?Q?vcMuhjsMcIegFQxxZL5o673eu8U0f0AM+y/+A/Q8R3QuXx1kLEi+5KGtUOKS?=
 =?us-ascii?Q?vWnqbGRxpAk9yZUzM1v8JR4hdulBAPhg6Ah9I5Z0ar7tXVRBzqmPS8EbVeEs?=
 =?us-ascii?Q?AQkYR05tJ5i1hhI4gZGyH0TjzGAFSU53n+mH1fDMTJOJHrNygy25WANbOmaj?=
 =?us-ascii?Q?ciQKTlFK1Z+kc1bIoX1chARyOvol9/tH5zpoPVG+MxGKFKq1Hx69XtmfuaVn?=
 =?us-ascii?Q?DwY53gG82Muur5Z95HhX5rFS5FbD9NQnhcG3ELWddJjEp/1RU0Ro3v6Pec8x?=
 =?us-ascii?Q?ijt7mNsP5Ae0MMr15ZosSRp6JNpK1xuHkIk7qTjuFvebXKU//+vUCSIxcP/1?=
 =?us-ascii?Q?OvwBh+LMqAY/pPIpP/NDE6UALpcqO3X2wbdygBt+CiMKR6hF6Mq8hCC7Ip5z?=
 =?us-ascii?Q?MMtORqk2my9S29sH1gVzCttHmHlg+m8k9C7UKv8Ue1nhnDpcpUwX9PyCCwFt?=
 =?us-ascii?Q?K+2FSjZo1WJ2KaerHx5Pah/a73Oy75wrC5hZxlu3m1Tyu8CUfmaTqyS2jFuB?=
 =?us-ascii?Q?9qkpsJEgi91v1HSJjeeQy/4hRM8lCcMozeYexv76ddMnH5QRkof1l8mA8hwW?=
 =?us-ascii?Q?E/qegtEF1Qr3+NZQgK6zcNTlII6yd94PMm1ajehdcBhcxaFrn2GqMwi8aX2z?=
 =?us-ascii?Q?h8cyT1JqWt3IOVos+Hmc4cM5ast8UhSVOOx8nDh9PQiV8T/LSN5SsYcw9bLl?=
 =?us-ascii?Q?1pdOvwju23gzWuTYWVeLhTyE6C+MTgwyxdRevAAOCD21HyGe/7OWFACNHKhA?=
 =?us-ascii?Q?ElSTOOLyDGqne/pXqFAt62ivbKIPvqFyUwX2FWdu8ARiWkWsR3Br/XnZOrU8?=
 =?us-ascii?Q?JrnmhD2BWPfzoBMkdmeMSD+nvLJA1qxMjfgQnWYZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d051aed6-6331-4ed0-f002-08dc64c40d6b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:07:18.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N7YK+gKqThakAV/BeD62c2/zTsCXOx0+Y3oGG9NtEFP/vgQtwPCMWNfHsCTrdiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

--=_MailMate_EFD33508-11D7-4F57-BBB2-72B845D772E5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Apr 2024, at 18:57, Luis Chamberlain wrote:

> We should check as early as possible if we should bail due to writeback=

> or truncation. This will allow us to add further sanity checks earlier
> as well.
>
> This introduces no functional changes.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/huge_memory.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> While working on min order support for LBS this came up as an improveme=
nt
> as we can check for the min order early earlier, so this sets the stage=

> up for that.
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 86a8c7b3b8dc..32c701821e0d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3055,8 +3055,17 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
>  	if (new_order >=3D folio_order(folio))
>  		return -EINVAL;
>
> -	/* Cannot split anonymous THP to order-1 */
> -	if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> +	if (folio_test_writeback(folio))
> +		return -EBUSY;
> +
> +	if (!folio_test_anon(folio)) {
> +		/* Truncated ? */
> +		if (!folio->mapping) {
> +			ret =3D -EBUSY;
> +			goto out;
> +		}
> +	} else if (new_order =3D=3D 1) {
> +		/* Cannot split anonymous THP to order-1 */
>  		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>  		return -EINVAL;
>  	}
> @@ -3079,16 +3088,12 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
>  		}
>  	}
>
> -
>  	is_hzp =3D is_huge_zero_page(&folio->page);
>  	if (is_hzp) {
>  		pr_warn_ratelimited("Called split_huge_page for huge zero page\n");
>  		return -EBUSY;
>  	}
>
> -	if (folio_test_writeback(folio))
> -		return -EBUSY;
> -
>  	if (folio_test_anon(folio)) {
>  		/*
>  		 * The caller does not necessarily hold an mmap_lock that would
> @@ -3111,12 +3116,6 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
>
>  		mapping =3D folio->mapping;
>
> -		/* Truncated ? */
> -		if (!mapping) {
> -			ret =3D -EBUSY;
> -			goto out;
> -		}
> -
>  		/*
>  		 * Do not split if mapping has minimum folio order
>  		 * requirement.
> -- =

> 2.43.0
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_EFD33508-11D7-4F57-BBB2-72B845D772E5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYprMQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU3UUP/0lNC4zViOjzsR4/JRXCw7+NflMLLzetGzJ6
hGLAY2bmIi49AGPsmB7h8BgPifP5SFLW5AH5W3RMGW9LTh+3I7sDc+uSNnBtO5Gs
e/1CvxYv/go+Eo8yvC63NvKpVY1Rk4Wqj/ZAJAl3uq7Wm/qFyuAw1/XWFc+Cquid
prqnKv+q7M4aqlXd6SidR8iuHvVX9iePZsjT/OsgEJlzFXGXOWLFBcPS84+eQvk6
gTbp+uYzXxU0w1GsFaH6/kcFeK3hTihDTpcQTbySYGynvVE5IzjFxovLOhweBgkO
bziUF6oNjeS4K4kvpU03wSsIUR3cnYbPyrITswKo5TzCaXuzu3Qg7/EDoUKKQu6I
7VzZelcgyGziVMFeAkJNrY5KPAxpfo5xtokcwfqOUa0bJbaoPv06CzmjHEEc2jHR
rEow9LbKjsWG62Lw4tasc7N1xnDodmqAm9CFgPrm3s8J6jr7Uw6hYLVUXOY65Xw0
nP78kk/3WULZ1Ou/6Sfr4WLRmFinzWw2IOR5zm6pFjsfeVMWM8v73wxdXIky+wr1
7hAh7B7MhUHzY4ZyFiEx0z7zs4UX1M2p57b7Vcd3/KRbMMyDxXoimf4atIpv92vM
yU3E4uHiKGJ9dRZ07kITfghbNPdkU5tFNygYiz3THmQvoPwKTxbUbrfUDN6D92QO
7HcKAMN6
=zpZR
-----END PGP SIGNATURE-----

--=_MailMate_EFD33508-11D7-4F57-BBB2-72B845D772E5_=--

