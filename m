Return-Path: <linux-kernel+bounces-59956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1584FDE5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839AA1F29791
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F788F78;
	Fri,  9 Feb 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZK6bZdWd"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D17610C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511661; cv=fail; b=TUeVdqS18Dcz1us18mP+tE1PULMUE0dFtC7tKqtoL/2SuxeXqWrGzZqqD17zhIm4cfZxfK1q8M9pauFHXjr30EhtKel+X1jzknQsuDwHny/MesOJ/TIHtw+C8h8pBRgh7wcnSZNV1QQ81vcKdJ0aJ+zc9zrpISkwhBWqzNlDPu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511661; c=relaxed/simple;
	bh=cNMpqRWtNcY8HLrNPzWp1qy2QgClWFVPqqLA0d6NNFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tD7Kq2ddljlxLPkRzhTJbpHq1lHLqZ8WjXzxk8QcLMxn0UdtSKoWiUTOCqXFemkmJiA47IMXryIPGy2wzVuL62F2EwNIK/9UZSQEFxbNbqi5gbrJ2ESivk+JeJYX4XtOn5W0H4brZO/Foz6nmEzrCm921I1cyDxlfie0CY2ZrrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZK6bZdWd; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf8xDmerDStZ3nyebrozPYaNr1d9WzwgmQBie7GJU0RbYARddxbH30iDVinIroiR6W1bFORvnIiIdf1E0zYlQM7TdIWz7xD7KPNJnMKOHCFVF7Tr+D0SqLfF4PyhgTnjy7VrCawSBsgZzdJOSG8VvH3y0e+OZMVnCxxwPkZg5+TIX//lt09vNxzRtLmc4PHZsenDSrJbugTKx8oDIznjFVMIiefUjhSaM2vUDnNv34aNQhcCxP8sKr58UkN45Ev+ErtM2W4rVBlJZqDrkLS1e89HGvTZYDQbP69vWOfGn9/bdpqLd1a2p1BUiRUK15qkOBaD1Up59TIHS4m8XTucWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMn0so+mgTBIcpA3kDRBCWBcZpD6yqUsG/hggDFbuhM=;
 b=kc7JlSdG4xfIhKLwgHhVcjE+Y0aeUtgt0am3X8WuZIyECqwCq198mubdUT4ZTWsIk7J7/VCNMMPZPoFn6y4FyAcIa95pweH5CG9AQdoWdMTku8UNmsx89zsdAGyTIxgnML0z0It3srvFqGEru5Ibcz78q6nrQ79e3xrqK1RnzVukZ+6K/IMFw7dYVnjjPHBgTAQPFh9MEMzCMTvaos8AsAEkG2toKA26O4+BmV3nnPrDF+zVLlaswWpsMx6KnlsBIO7WI7m03S6qlEXO4J1d5jPRNjGD5DFS/aZDcIzWdIEEmkwDuWngGLpE93yM7hlR0J8EYzxuTORVuIyuKlqJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMn0so+mgTBIcpA3kDRBCWBcZpD6yqUsG/hggDFbuhM=;
 b=ZK6bZdWdxI0xozij7lzKKH7Irx+ywMhnVS8MOeiujIB1AFXdBBjMVpj8Um2NTBgJG/ThuQoHgd/Uzz/FV7IQGAlP/OsjX1vxYZTFI3+Hz0NwtQupJgdNiaxFQQx81ThF5ROwbt1qkSgk7/wi13t1wpe1JoqhkceHmxw6K+DVK8ViX1/199UCFj8PdnBybE5gQcUBN58wrFWUkhpDGFBZ/AJYqOOMdd/J/mUcxcAqwVnX9kia/hwB6sWAvdcBGaMXO9V35KLHZVn9YaR2l0R4YyEFd9u5CUm6Dn3Y3TPOh6pNP16y+EJilAHusy9z3lfq2kcQOmO+cjIMJkTT/vLh2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.15; Fri, 9 Feb 2024 20:47:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 20:47:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Fri, 09 Feb 2024 15:47:32 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <4E833B0D-668E-4CDD-9E7C-5D01185B3D12@nvidia.com>
In-Reply-To: <28c47a9f-5ee4-425e-bd8d-bd251634534c@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-3-zi.yan@sent.com>
 <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
 <5F394663-0AFE-4C12-827C-3A0723863395@nvidia.com>
 <193E0D43-0084-48AA-91F5-8316A130ADC3@nvidia.com>
 <28c47a9f-5ee4-425e-bd8d-bd251634534c@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_40B1309B-C45A-48CC-9A08-24B5DC789F4F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 234c2559-0775-48db-c717-08dc29b0582b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	exfvCfMZITFS7H/gVg5Q0IauC2YqgKUeykzdP+q4InmwSkOVvPXBGwZKYipT4guTfIAKx3CE54bNzwDaW0qYIkiI5UpJ8DHu+E2IUAFoAo7L220i1rCcaRipDfIjOORpRXIjoBILeWuQAbu2ctx6oaQ+0qyTZHopWl/3ipVt2hyBertNia4L7GaAPV1MR6YM32+5jbN+z1U5NcW16Uejsae9OqfADg/7iaCVlsvF5TbSscZTGQa2eA1vhCg+t5af4CT3IBwh8CFEAVoXtdbn5ei/8vC8O4LCzcj4WMijlau/ifuWu29L8P8m/fdaHHjKXZhKFeJCkB6W9fop7JyA5M3Bzwl3NCGLqt0MXMej/6wA/5U+3mtGW7dLhEmqUk0ygMIa9a5IgW6dB9ANh7/bvF2jEXxAwJiGNPttbAHvXV77HZiXcixssYzIIFsfy0KZr8vLnkXtGVxvIy6lpD5qhPZyh3zgz16ENb71r9Z3w2lxvgLyvnhToxupQND1ONEVQ7xgdVcxn/LSVyhx/u0QX6voKZ0JXW/YXds/JQv/I/LtK4uOCpSb6gRTgmB1mZPq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33656002)(41300700001)(478600001)(53546011)(6512007)(36756003)(66556008)(86362001)(6486002)(8936002)(26005)(8676002)(54906003)(66476007)(6916009)(7416002)(6506007)(6666004)(66946007)(235185007)(5660300002)(316002)(83380400001)(38100700002)(2616005)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MDjsKQLxAfidOaLqvmHkyznHAOkjfLfPXzJt4S93xGEqBZ2LEDYuZkiwUA5/?=
 =?us-ascii?Q?rWQkkx/NE1pX82rSO/NBYCzpsD+uVLPKOtW3Fi9SVUrBuBg9pDNr03caC6wH?=
 =?us-ascii?Q?K8A0Px82BY/4Izh+dpLLiblaH0KBeeuDjfrxpYF9CGA572cWjs3ndtZZSW3V?=
 =?us-ascii?Q?Yj10yuhQSK2lpC5lzNjpiPJlnCgoC+eG4AcsqQN9kSH1vpj6fb7e8XUF/XFA?=
 =?us-ascii?Q?WJxdIDhXRWdIxlP/zgmcCXN5d75k3RSw1P1GRvV5qXVt70SZ/cftFbyk7anS?=
 =?us-ascii?Q?SKG8zWjpG5CGkfyHrZzWzZXThWfhnH7ZDdoxxsC26YZp8cKID/BFW1/Vg/yy?=
 =?us-ascii?Q?J3hSqqVLAkqKY6u5Kn1wAUd9AwczDn5nLrg/Xhs6aPbLsISYjsCsjCA/UGCA?=
 =?us-ascii?Q?9QXIpmQLze+K3vu/gHUIAnQ81ZUTu/sBX8Q1/JlDwUALUPxyVaHrxIzWLWuv?=
 =?us-ascii?Q?tgo9Ay4Ywa/wR9FOHp1v+qI+RP/EIoPTPqRZBzSyin5WWxzM2YJrKjjc4cA5?=
 =?us-ascii?Q?dn6pASdFYtj3EXdkxxcPU6db06wjufCm/p5wZXpcJHJNIkDcT5bSBBhWO0ep?=
 =?us-ascii?Q?sKNUUkBd0W2aIbIO1QqQsOqPsv/UUJ1C8kZl1Qon0j1XjASWQ7HDAjtYUGq+?=
 =?us-ascii?Q?UOdjQot7K98Z7ieXSMfq2Z0q1yHtYdBZ9o2UWeatQSBfxZAxYEZ2fTEz2Aho?=
 =?us-ascii?Q?SCm4LGyVjOhfq4ssrS0V3xX9xYvU2PJ/oFsC1dHQwzwv4+zrdUxzYaLKKARH?=
 =?us-ascii?Q?rbg9sygxR6I6Hxh1XOyD4sHANtiVER7HHyVjyrRX+9gNWfa//+pvYdHg1cVD?=
 =?us-ascii?Q?yWGJwG4PRTkwzaXaWkuvxDJ6StgXJ1WfWKbQ1GzDGAXbsKxzHq6NzaMOvsPy?=
 =?us-ascii?Q?yPfPKd5BY2vitvA0XzLszGUj1udG3Ky5SHrBvQJ5k0iUXQaUNMDoJBZGgd9l?=
 =?us-ascii?Q?rHKAakQJy9+iDlxGX3TGBP7rjkPl9oeOeJ/u52jZeARF+pfC6NTDVYnhrgUp?=
 =?us-ascii?Q?YYgWfDx7R30nnD/AM1iHDayQ/U3telLac5VoasF5+gt3TLYdgPm+NnJOr48C?=
 =?us-ascii?Q?ayo2kFeqCzlYnbQavN1FjVMN5oI2ei9sXMMBoeiAWlLgJA/5EXB4q/6Ougni?=
 =?us-ascii?Q?vzrL5+egBna3A9NvWN0RF8xPSW5hO9+sy4cPs18nO3hJ9im3YWxjXMVV7v3N?=
 =?us-ascii?Q?WsIVpXQQ34eNy6ypKdmGas53xKVwH7zEzo854LmJI+S33RlEssBfY5iTAbYT?=
 =?us-ascii?Q?CiY1lBH+SuYxfZJajY6tFFNtu2DXYvceL6ST2eFkTlTrElb2U2FUZNAw1eyE?=
 =?us-ascii?Q?qQJDN2YcLRF7UmxjAeDbRAsjW64ryW7aRtPMioaYfAle/OI15/iw/r6N7fXU?=
 =?us-ascii?Q?HqMUN8jHsTU/Za0+i0fAw05HbJl1rmzB5EGl+qHguf2SpqC405GxJz76bSKE?=
 =?us-ascii?Q?8zN1q2iiolNhy5w4QoY72Ih0IN+cce6XnBOlfje6CW8nAOPWhSGCarmRs1Gv?=
 =?us-ascii?Q?Lo3Ss5RYjaosDkRszs2APR0Pq6+qZsdF9C2/J8eRhuqH3TP4LwWMMgxHcxbY?=
 =?us-ascii?Q?pj4EV0miiMCOJLXcplZ01KGNsqLVui+KMPEwP+8Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c2559-0775-48db-c717-08dc29b0582b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:47:35.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2q6sOgK3VueXEobAt5Ze7VfDGjPWghDkrAzwL/XXoy87BAznL2QQIMcfUGgabX7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

--=_MailMate_40B1309B-C45A-48CC-9A08-24B5DC789F4F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2024, at 15:46, Vlastimil Babka wrote:

> On 2/9/24 20:40, Zi Yan wrote:
>> On 9 Feb 2024, at 14:36, Zi Yan wrote:
>>
>>> On 9 Feb 2024, at 11:37, Vlastimil Babka wrote:
>>>
>>>> On 2/2/24 17:15, Zi Yan wrote:
>>>>
>>>> ...
>>>>
>>>>>  /*
>>>>> @@ -1835,9 +1857,17 @@ static struct folio *compaction_alloc(struct=
 folio *src, unsigned long data)
>>>>>  static void compaction_free(struct folio *dst, unsigned long data)=

>>>>>  {
>>>>>  	struct compact_control *cc =3D (struct compact_control *)data;
>>>>> +	int order =3D folio_order(dst);
>>>>> +	struct page *page =3D &dst->page;
>>>>> +
>>>>> +	folio_set_count(dst, 0);
>>>>
>>>> We can't change refcount to 0 like this, after it was already set to=
 1 and
>>>> somebody else might have done get_page_unless_zero(). You need to ei=
ther
>>>> put_page_testzero() and if it's false, consider the page lost, or le=
ave it
>>>> refcounted and adjust the code to handle both refcounted and non-ref=
counted
>>>> pages on the lists (the first option is simpler and shouldn't be too=
 bad).
>>> Got it. Will fix it with the first option. Thanks.
>>
>> Do you think we should have a WARN or WARN_ONCE if we lose a page here=
?
>
> No, no WARN, it all happens legitimately. It's only our compaction losi=
ng
> the page - whoever would do the get_page_unless_zero() to inspect that =
page
> would then have to put_page() which will free it back to page allocator=
=2E

Got it. Thanks for the explanation.

--
Best Regards,
Yan, Zi

--=_MailMate_40B1309B-C45A-48CC-9A08-24B5DC789F4F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGj2QPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU55YP/3bCxavjUh0cBZ5rgFbgSEQNJi7vabDHlKeS
XPuEfd4NDZiGU3313jG5aZAeB03y2p4Cv+K+xr0fv0vI8Ut+E4QXzApmLE/85T5i
B5L0qAMbRWjYx5CVwpyWkoMs6k87Iz4KEXwp9wFbvpiEvpQl+nb6md1PdSBZEcp1
f4ukNapBscfditJounJttNJDtlpxgFX/JOael2ajib0I7fU+7mIeAoZtp3iUQyCp
PaCFWrj65wuBq/dcykyJD6zZmHUe1EsFj41EGj1rje2sy60ad/4XIjv3De9ilObY
Szuq3AfnpJYj5pTtIAm1csbhOosT3J/N54vtiDWG4zsmlM+0LvFwSrytbC271MdZ
UvjNu41GAzn1jGt0rNUaAUYIZVnH3ejtkbFIaZr8kWXbkX5pYTBB9lujl7Hiags+
hBP6xICbzE2dpX0eHWcgJbzAc2mR9aTQ8vPU6xlI7fqaOffC7DY42kHuRIh1lku4
a93Ynh15yTdDMxfeNecL2k2i34n0hIc/i9P1mk4T7O+8y0p1qSavkSxx/v3+ax/S
M5PAdlIkRnbEHFlCqT7uQiwMjp3/lE7PPD9QiPa8qCkJs21s5uxpF51HWp5mtZjF
qB+SD5rhledDnYsecdhWMXvAZnma2mV6fHe7V3dQSkncMbhlXaQ01i2YBpuD7V8/
ZmQHL2yX
=OxvX
-----END PGP SIGNATURE-----

--=_MailMate_40B1309B-C45A-48CC-9A08-24B5DC789F4F_=--

