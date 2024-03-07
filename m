Return-Path: <linux-kernel+bounces-96164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C26418757F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D1281DC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CD138481;
	Thu,  7 Mar 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uaD2qlTq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6312FF8C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842187; cv=fail; b=Gf4sbxePNtkNnyO6U7tNAMP3BrJzPyfVX2hFuw2jjIBIdmr4CRLoVgoQlFIJRif+N+HVNzXoB+618ph6lvkpcuTQH2BSXP/gkGAWH7dZmE0URjpQ/9WVjiFVYwZF0YvBKEQnZWr9P2jcYBRl60KB9HftDOwIfJT0qagqHqeIzeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842187; c=relaxed/simple;
	bh=XXMA0QDfoswjyY/8KmlEqzQJsNTFEGCf5ZHidDcD1mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1dtjUP1SaRzKjwhoYMG84JMePUVMcaDqs1ZDYzQ4bIWrD7EUnVWqeQ6RDUpyKMbHNsY2WQ1BNTRCH3GIWA9cSXj/IjBkADEjNbM3pSzrzNA1LSEdtKcN6IozYnyYZods5q9tfa+6CgKIsiPvVCIIMRRqvOlAHIo2TriIJT221s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uaD2qlTq; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGPTw7qamDCmmNQnq2W60i58bYX8oqlTdruwNa9A5CrASmz+OCqxB9FZLhuSO64D7xB5todhATwY0COpoVn4zpZ22zHqdnJ4zk0J1kLsWtIYI7yIyH195WYQYTs4ejvrqhf6uaIDdm29KI6rhkW9kjhBG6AFXRbPyRnZryHyzGxdh7vrCQKDURbhc/sdLPVelTQ728MfuXq+KB8OgnY59SlgA4kPncEE8NcTSLQIe22/yvMMQqyhMTdvN3anpRuF5c9NzzZ+y0AqRStgatNWrq+euEi0cOy2etVykQ7Fgi3LXpC8huWZ1DIcWoP5b+TSfsAUraTKSWC0PdJi5phcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8bCw6/Sb50j1gmzedUuJ0+pFS/WgQ/PEtbNDGdoj3U=;
 b=ocwfUCWOZWQrVEdSCHSSyUiu0rIcboDKJ1ku9+jOv0d+yz6hVEC5I+pgqvabv8FvR4V4vsyjWr2630E32VeB6JNe2Zf1EKm+2ZnjZJnyL8IuVn5BnV9+oscGpc3myxiBrUCpdPMuAa/buu0Alotxc1ziLRzze0MpNmBPVhrHLZN7e0H4zcWT2k1/Y5Tv3tbWaEtAINy/t7C68dAVrS7YrTo9b5e0puQurmpARWqJX2Uptz/MAaKeoqoMpdRVj9i2IhRLzU5UvaTEkITnAaZf6yBWVcPGniy1tUEeTqtwmkowHoCHdrBfDcGJ4CPrzNRtxAYGeplnx3hy2UAeIK+apw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8bCw6/Sb50j1gmzedUuJ0+pFS/WgQ/PEtbNDGdoj3U=;
 b=uaD2qlTqiUx5vllKK8ZwBlM3mzaqxHwHU0wcXEucQ/aI2suiSii1kzNWOCTRoNRJO1tx6BudLNVTj6hFa0dT8JCrsn0xKONjTw2k+zbpNQVOsSxCcHMR5RaywJVpd2drWalAcKotJIseZGmhQiWzcT9uGOiDXCgRdayxCvC09ZnMMaEL9JQ5rDnV6QCwpIcfzsnIPl+lTsERuRPvDg99Flf3G6tW63jtrAe0Bc1q8hIkT61Yg6hpy+1PUsy6p49rY5TpS/1XduyaCi67e3UHVxXC7eG0TYPkaAmsbbDFOZYksA21DXNzf2cO0BTo2yNzGx8FhkYLV4zCE0CzM9XilQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB8904.namprd12.prod.outlook.com (2603:10b6:610:167::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Thu, 7 Mar 2024 20:09:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 20:09:42 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Dan Carpenter <dan.carpenter@linaro.org>,
 "\"Pankaj Raghav (Samsung)\"" <kernel@pankajraghav.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/huge_memory: check new folio order when split a
 folio
Date: Thu, 07 Mar 2024 15:09:40 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <90B3461F-3A95-46F9-92F5-EA222A65D739@nvidia.com>
In-Reply-To: <20240307120224.0e627784a13cff1121048ae4@linux-foundation.org>
References: <20240307181854.138928-1-zi.yan@sent.com>
 <20240307120224.0e627784a13cff1121048ae4@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_2A49FE18-2452-44CF-9610-9E13B2CC0FC6_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:208:335::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 760da89b-3ee9-4529-c1c0-08dc3ee286a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q5MaIGnE2oBbiZ122ucpVHSVr2NXGviFF3Ia6Wk/NOdDjx9wFzWqv0tMNs5vjkW+ukFio7kICHMQ5jRpvBJwQeNmk2dMVZBCK7HAFX1Z0iJnedG4qzVIO5/zCOYr9+6XnT3kcjwHZhlFkUhtOzjhnIoiMHnJahjQ3itruvUytZ3ygCGg7w3+7DjyLI3hDsRUOPAecI35KLV2m5WoLhQniuNijwI+nMhN8D/YIgFcKQhDSEF6Bmfn+UIjm6MAtaBiXX5JWyMG3r8tww7pxOKmNsGTLZe2JqVrI7NwJuUH5ESJL7znrdr8eawfCqQqxyJkUG7F7dJSIBwxfVTPBRwKnYlMfxtdDJaGdscOJeTKI+rTXYD62Ndl2YIds5a5nSPmEwYPaTEjp6fEJGbeP1uHIUHHRCiKQ//P8+NtkIhpLpUBV4raTkCfqZuw1AYre32UxuiMN84VwXVxwRdi5h6vqkfTK/JdTeBYGTmZk3pAk92zgLi5yN8GZZj9sS/vrxJfG32ZRihTMSSUQmXiVB5Ju/DuW4TgVdVAagFNcmQnsT1ZiqKthXPDd8/3PBL5DbMOKAQcMAOLEs6B8Vw4+WrUNGeKodwNXUajr/sGaHmD2epSTp9H1ERUcj51dITiq6o5H7ChbO2NsrbTmSvSoLKMQpmGPLTMHaAXxHoIg4O1sjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJYCZb8jQyLU/tlH/vcPSYukJum0OwNVPAlUHVMd4w8ibIk/DO4nvUm8PXyu?=
 =?us-ascii?Q?fEdTDmS76DHys4o8qtO1nzaMmV/PL7ZlZ8URtgy10H3nu0o7YxmWzcYvY3QF?=
 =?us-ascii?Q?SCHaAFnJ45QSWVlZHzXg7a3J0JuKAUJnVNrtfzaZPqTwavdcl3/NujMe10xf?=
 =?us-ascii?Q?++kfrOZLSIxmCnbNgqx7k6R2J2p8rr2qsBHyB8Yc2l7uulKutNDgL02ffkBG?=
 =?us-ascii?Q?HwLuz02kaKaUq3+J9cvtv4pVZUsljzMzAmPXcsDK3gg3Gw6mGb8BqDOhda9i?=
 =?us-ascii?Q?gHmRPAb4vfuPhkPrCGSvWe6bntRVWdHYMtmW6UFCfSIltGRn6aUs4K+ovO6a?=
 =?us-ascii?Q?wasi2ujrfnlk36jpNB5kxGWQ7N2C202SXjkW4hnjGQBn+mEtoA908oYfvJBs?=
 =?us-ascii?Q?r7/yyWlxh5R3hwyoFcUwJpM3O+FV9g2yc1FXW5oc4N9kpfioy/H1kAHsRIQ6?=
 =?us-ascii?Q?P7UDW9isAL0RgBGXLTh8TzOb9wSCJ6QT7sRjp2hw4tmHXxvt5ceTuw9rPTkg?=
 =?us-ascii?Q?A0A0jmagAVd78zKEw5DjsiJEVco6Q36gQzo/Pxi18l5N6QctmzIMNOpMm4hb?=
 =?us-ascii?Q?RujjijLDHWMGLpUmpozj3afhmJH1RdQ4s2zBqA4sgbmy5ZvNFJoafCAWBC1a?=
 =?us-ascii?Q?QqSZ+nHaVvP4IPKNU+XKkHlpC0cKlpd1t7El7SyMM68/U4E1OjrCbWEyFlXS?=
 =?us-ascii?Q?5wTf1v5JXhiDMbG5Jg0qp8icQ0H8fHUUXN2cxGQyo0A0Bd1xYt5AoA4V/g2l?=
 =?us-ascii?Q?zMyi7Ywr5dC3fjc1cZqg7X3vMzp/0Qiw149yA1c8UbbpdhYEBuwAdSHemHLk?=
 =?us-ascii?Q?APMMdmY2n2vei2zyqCK66WgvAzD/GlDLLltphyRj7+4KThBJ5xp1Zn/GvZzW?=
 =?us-ascii?Q?zTQpaJOWwEi273wXa0GBkjX3ipHz9CLz65+q6YJTAFqN7Sp8L4KRT1NzOBl1?=
 =?us-ascii?Q?c5hMvvfd9JTfbUUHa/6J0sAxhuoAjVIJx0avyIJyMAHcMW4EMKog6pfyTmEn?=
 =?us-ascii?Q?VSJm0WoXduUYZI33B/yFboWsHmow/6rYC5fXNOlJ1p1adIQtjpfyS1vWiDPQ?=
 =?us-ascii?Q?LU4ibjvjWZpvscxrFOB+CxLu0HmzTZKq2FM98N1wEScFd5xxRP9PrRnwi22e?=
 =?us-ascii?Q?fKV/NbgHL9W/4joNYI/iCn5Jcn840R4hmEV/98z65miwKoGiUN+dp4VPFJ52?=
 =?us-ascii?Q?SOxwiHVH0su1ez8vswYzt2OzKRIWOBgHCXc0mTlX1EWhm/Yh3Po0McjALHoR?=
 =?us-ascii?Q?xxAEUohXFEiu34WKecBg8MDhSrHz5MRRfm7gLaqPijt0MUM0xSr6Sxo41OMY?=
 =?us-ascii?Q?FupFrfhyX7r2zP9V6JDSTR7n2QVxdql+sy2GYMt3z5/wMbB/muJ97tcySyUs?=
 =?us-ascii?Q?FKQ8D0dn+uXiJe10A9sJ7l6bW9KLOc5OMhJtIj1cPwbhsXzfmAUuipr1JPOa?=
 =?us-ascii?Q?WuIcXbxx08KbznjmxtVAJVapCuSG/w/GZSViEduiVHm54sSbd/E9NehfXys8?=
 =?us-ascii?Q?0nvnw935eiMfPuiPC5YQAKiVrtRyfPOyft4D0gmUlKBuWdbxHNZ/p6z2bm6f?=
 =?us-ascii?Q?PCcGIunpec4yQhUyPYY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760da89b-3ee9-4529-c1c0-08dc3ee286a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 20:09:42.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb1aEdzzWWpr0+GXeAJoToVkE4c6ATNawTPOpzEgtA/ZqHwYw9RobHwPoQFg1cDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8904

--=_MailMate_2A49FE18-2452-44CF-9610-9E13B2CC0FC6_=
Content-Type: text/plain

On 7 Mar 2024, at 15:02, Andrew Morton wrote:

> On Thu,  7 Mar 2024 13:18:53 -0500 Zi Yan <zi.yan@sent.com> wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> A folio can only be split into lower orders. Check new_order to make sure
>> it is smaller than input folio order.
>
> It isn't clear what's being fixed here.  Presumably something is
> passing in such folios, but what and where and why and what are the
> effects?
>
> Might it be that these folios are being caused by the debugfs
> interface?  Or something else?

Since there is no new_order checks in debugfs before, any
new_order can be passed via debugfs into
split_huge_page_to_list_to_order().

I did not explicitly mention it here as the debugfs is added in
the commit after the Fixes one.

>
> So I'll add it, but I do think more information and context would
> improve the patch, please.  Suitable Reported-by:, Closes: and Link:
> tags, perhaps.


--
Best Regards,
Yan, Zi

--=_MailMate_2A49FE18-2452-44CF-9610-9E13B2CC0FC6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXqHwQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4rEP/iTi+57j+NZ6c3icFzIHW9gCDjPDozkdMN9A
hbFAhClLyGpvR8Trehkrlc7tygT0OEvRyAIU+qhvWeW1fcGkloobuUhD50jUarA6
U11MTQd7smQ3CKn02WhowXq3EfpXSkZ/n6o3TgmJCAKTGnE8p+DMd8RXa7R9s9Kr
lauMo2vIz8ejbkrt+VNQJxfO7LqT+y+1Nt6dekNUC5ZKQ0BpKHBuZglrBQoEVXRe
znqCy4CyVb3Sb3Pc8d4SHKnm/wy7JJqSVCLT6emf8R06kPSOzQEo9AyxQL9aRTSk
UBsttd7BUzgxXv2N1j4LBz5y7l2W9I0JAZz2xXgNHskI0Sw/EQ3q/NhAZBnAjo/7
oy2fbRNYVuCH3fLxsaJuBLPDkApvmgZCh+tyh7ht5nLc+n1Ay0ZSm24HU8hOAEWo
i1B9ZEAAKbf7/UXMBxleEmwR51DgCnpK0QW6ns+JuBjUX4o15H09BjJuBDrNBZWq
TyR5M4M60DCgMD54snWkYVaxK8conHh6srMX55gXcxtO5UiiWaAGp2cSouRC+DGO
C5p8FDA+sT2oqULHDkiiOBvxw4Q5mQF2Dl4RuG8kyAYk/BThIsAEdJjHu8ye7byC
PJCU8dAqlKm/SRMx19WZFOQIrPeBOuJi07QvDO5phOLm6NxAusExCxhwZ29a2anV
dno7m7Xj
=z91I
-----END PGP SIGNATURE-----

--=_MailMate_2A49FE18-2452-44CF-9610-9E13B2CC0FC6_=--

