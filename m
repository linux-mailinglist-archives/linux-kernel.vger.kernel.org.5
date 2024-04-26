Return-Path: <linux-kernel+bounces-160030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3738B380A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F1D1F22E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35F1474AC;
	Fri, 26 Apr 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nQpzhMIj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBE146A8E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137126; cv=fail; b=Hlrq5mDPOAsfSewhyt18b4R6QVYiK7mUusVrBYh3e03b0ZIkf6MZcoWLF7u//7Rm4HvyGaEEv1TCD8IcV5oC7VhwZanMuImqOboJar2E8bSQ/ZjZ4j4b/kvPTiDm0CTuVSZkUuwkCqlGYs4VZxTawRdQiz3zOyA2zP1wRaTLkAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137126; c=relaxed/simple;
	bh=EdAC2p+RMI2+C3Uq438HHgRU7ccE44pQsNfuGeKJBls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhZvSDO144QYuVdANc1I+akrufLlgzmI62vpPvgonuLmTBAK9Da/5DcHzVhLHd6KXxNAbSNbloidK/yEue/InlBT8gIkNeZw6RPk/M8RmzN/9nsMrYoIDw7kHOKpKMqlwZGePjFkYuzaNobTxMjk4ZwOFh2Y9kO+yH0LurqxHhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nQpzhMIj; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io5URMS4pXdZWFxzSy8cPcAjVTkdBlRmhSEPCM+0qluXmhQx5fDV2WshaLNP6+HLvm0M0th8WhdnAdhv5f/IPAAzGdyYyZYyWP9L2QAQXXKd0tm2A5T6TSX8zijUwvcfyORtpLEWVV3+vypBUKndqzAEyEWFaB4HO3xO9mzkZAl90GOYZnT0EOj/QuobHDjg5Kug7c53Bxd1dNltQaVoNdAJ5MBpCnBv++3ckkxrqH0du80Vtncz2c/QMDvQumvCeOyNRYDNCNNh5Ty1AL6WozDGQ99Er+uS7Vc1bF+qh5i9rFdqpPqDRhyzf8bRAv0EwD38hLxQHIkAViHZP3RQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcekWCCGPspJazWk11aoPlQYLpDqjITZYAARs7BklVE=;
 b=UETwtq3sizebhLb1xvqSVPESSs6kDNtxiBmSrPYKmmgADNcxNQwFDkLOPhPNg4BKwj2nAdG+wAGf2mtK/lwNJgoZa9B6CoDyE1TGQ8VYG2U9hmh24FCAFJbxCfyn/go8dEPzqcz+22Ygg3XK6BZkvO0vIFXVgoRxO6rrbquSGI93icmW/+5aNUe7ZtQ4oHHS2880ims6nZ3s6VjIPopul9sR1+ugiqsy96yrgAjfPaatQ9atCxpbUEnbjnCTrPCjJ5K4DLlhoV1Qnx07pZRGiAib7+i4R1ySzgDtbdZkEtUDwfCoqqYUIdl4QZ4FCRvLUr15mnEPyVZlSpAVQfkeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcekWCCGPspJazWk11aoPlQYLpDqjITZYAARs7BklVE=;
 b=nQpzhMIj8++Vhp0TcLcCqydqQz5vCKWO1ME6WENjlCbWGk88GTceZhVji/gB9KIcsFPQP2jOGU5T8QmEYYctYTlVEQrcDh+l5zV0n4vaLWIS+ll3wHo4mRclezrK/P0qYKwrySvGn6YvQnKRQOee2gbObE5+WA2F8jXjKOKpvUK26ADs8lf1tCgldFkQaDoA92mm8lR+by0Y8+Y9HnEOCpflAJ59Be5w5sz1Fwzus3boX4kLpYxiRdMeuWnklX+a6XsJKSWyov5CNAjWhOpWQs4Ya6mIwHDBJNYk3WIiLwWbcxFmlFnozl3h2RGYYKFG6+0XgKoQvUW8Wi2jTRVYRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:12:01 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 13:12:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 26 Apr 2024 09:11:58 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <D4AE5BC4-846F-436F-A110-3604C5B66786@nvidia.com>
In-Reply-To: <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
References: <20240425211136.486184-1-zi.yan@sent.com>
 <ec4f9194-9ae3-43b3-8559-0b1f186c1d9d@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_379C6F1E-AE18-40EE-95E4-EE2BAB6D3FB1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 58aba2cb-058f-40c7-2f99-08dc65f27575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5vmS+YzTwVDlSVwY0t3kWvyc7WpZUKRxo04Wo1Tyqt0J0im8xUCq1GblxcPl?=
 =?us-ascii?Q?cuRJoVwL4kEA6E6sdl4dgJeSf1rI+ktfcl/j7hD9GKGpWO3g9O+heAnZGaAc?=
 =?us-ascii?Q?9shdGUFtw0DcaWr4AdfFQdScut7UJu39GzPeBQIqYeCnFGIcfcreY49RdLUF?=
 =?us-ascii?Q?SjRrJnj8mUMfR0GyxSnoWpSXRWuw2lEyQqSfHEEKNhuCwC3Dfzl0n7AYx11l?=
 =?us-ascii?Q?JKsVPwyyX1nlWMJFVHr11k8sjPDh37yprQvBEtnQPAUzlezcAfH2TZcUKYgb?=
 =?us-ascii?Q?V1OXgSBmMGDEbOi3mMm8n7FqEpejl8XKJeBP6nkOrxIks9nyk4JzEYpniJo8?=
 =?us-ascii?Q?3HjR/Zxp5PUTyuOc0q7yGFAlHplWrCho4CZxmVNveOmJPFk7xFVQA19sZCY5?=
 =?us-ascii?Q?5TXJEgs5myKIPGnmSXQ8g1IXS8444qUYy5OJy14X9xxUmP/HQwtV266a7huS?=
 =?us-ascii?Q?LCsS6WfsRPdSNkwE469ktYKjgnpcTn1zthNqGVC4YuDNSO2AaXwfodwqQHjZ?=
 =?us-ascii?Q?TsZEYWBUuwOckDe/uoHuwwFYLM5LHPo0B1dqxDtnUaU4ZCThkFAsRkKnnZlt?=
 =?us-ascii?Q?arMmlZDMu1acIw5ODeASvMjY21dTAdT9tJnLo8NPldeZ3q+D2XRNVBY8v7Do?=
 =?us-ascii?Q?fYUNfof7EPqthwhC1nREGKegxNf3/6EqqiYbVmcQEsMEspo9Aon+O+Ud9R0C?=
 =?us-ascii?Q?FSnS2ppL6WCfi1ZwtCQ0xV9nFUE1kGBODa0dRYIakF9c/2SBOgTALfXFpp9B?=
 =?us-ascii?Q?yLqt1u5Umajf9OoKW9EJHdbCYtaAafgmr46k5oKu7GEya1uMZ+kDyjb+mIhA?=
 =?us-ascii?Q?hwLCskYky6NLD27lRxbhIUCPOGur3834NOGq7Ga2uh3BpYdm37JMu8Vf0LK3?=
 =?us-ascii?Q?4IaTO/cnATyNP9HHrWz96ya9V7n3DhxBrdEAbZH+2f5FfphVqkQ7FYZ0ofhk?=
 =?us-ascii?Q?7NG/s9QZybeGFPeRGn/rFE64xaEZ1UIGoP8rr5M17piUI0dq1q0e7adEUBUK?=
 =?us-ascii?Q?YWXwqXp1rzCGWQlYb0x9V+QJZZGA4A429eOOxD6Hk5iPXxPsdWjMWeuQE8vc?=
 =?us-ascii?Q?LqFfPOoGXPFtpMyl3QNW4xA5rRfFpgpVQPZC8f6UnRDEA7pk+jhFYtJbbytK?=
 =?us-ascii?Q?fwO0zZuMBFEvbD3dW7Y83H/yr9n8R7o7N3K3zeAmyIJrqvvTU+br5Ocyu0W/?=
 =?us-ascii?Q?br11VIzV3dtCNH1B6fn/bq/SnJNEqW9p8wrqgcxoOG5Vi/tDzqq+/7eBZZEB?=
 =?us-ascii?Q?N+dZcvWCjB3BAfn6b81s8JRcA64TE7NrzOs8Nxba9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4jWcqOz3Vny19C20v7S1rE8uyrpC5t7yNGBn4D35U1bQC0w8NB0klCEbuufu?=
 =?us-ascii?Q?O57TrBxNz6EW/wz6H3zPGX6wNpsFFITmDqNMntpiQH5nK/nA5K0SEhdfwjDW?=
 =?us-ascii?Q?GWZ+XJEvLaWH370m3VfPonaCCexMANygE/yYg5iFPi6LEEUPj3ZsjID+XC4m?=
 =?us-ascii?Q?Qq96q79z0xRPNvYxkUNCFnhjFZ5IbDS/rYtqdMN3UPPHXFP3Ru+Rwg7fCsrM?=
 =?us-ascii?Q?XAe4JnfNyQxplMb7bnA7poDOjsnhjabs3ZusONIRp/gQOFWB4Elua2mLOQx2?=
 =?us-ascii?Q?SunU/QuacWL8MydNcp0/nA8CHoF2IgqiUpIOXx+pCLW6j43WTSr+sZZ0qVeH?=
 =?us-ascii?Q?Kf6gAl9d6JrBqxlTkh5ipwuI585bSK0OSOSwvwyz2jPVrz7gcoe/QBtLTX7O?=
 =?us-ascii?Q?AMB1zqMJGNsDSatl+cy5KwlwJrvjQTioGe+DNWczox4LQZJx4Qmr3ebcmqcJ?=
 =?us-ascii?Q?yoZ9Y0oGDqOvf430bwxc5L4LZaXSB1+GpxBgLX1uQMNmo6+97BITEZ3eLKHN?=
 =?us-ascii?Q?lrwFK6LHQr4rXI38k/E/e0dLHMi6ck9GhfiOtz9wnblweskoVQpiXUPQqm/o?=
 =?us-ascii?Q?+y9OPitzFiBNVGgMWV3jxpDgMhiyTfrY7NXtzVpnTm5ZYe8fuT6K+v/PZfwV?=
 =?us-ascii?Q?vCFzHF1Dkh/bnigbTrQ+csO7kg3ztR2dwK1xLeXHxdHujQGd0vuKcQJX6ijU?=
 =?us-ascii?Q?iJTt/lGfZUITnu+erlLi1ck9hJHitp4oqJq2C1cVPqAYua/5JKvEc3sWI6cQ?=
 =?us-ascii?Q?zc/BsU+VmpEEWOotOdXUgHHWyBqSIHI0MwYeDTsfu9SYJTBkH9IyJiVqoIMD?=
 =?us-ascii?Q?tgj32uiVsYPow5YxzVrQeZw58Xctm0MgoFI3eJKoMI2ujjn306o+pVxrs6LU?=
 =?us-ascii?Q?vrsV7X70Ut9zXg8YC4pLutoDQ2h4Izyq+ZFACZVVuxlcNJEu/lqvFCHzSIxu?=
 =?us-ascii?Q?56qO9zhmf8LoZOaRbAOrw/hkwjGDM4pHOmS1VYOSmUCw1weoiSNeK3uHEnUW?=
 =?us-ascii?Q?9yVavE5GhrpMwvgTTSSe/3FdVUvtcc/XuOVg8bg/nFxVU0uhdbzLUnPA9+9y?=
 =?us-ascii?Q?AEcN6J65dknFpaLWlXzFpBuOo52ZsQmwXoBjwb5iVNNvqwo6XaZ7DlQ184E2?=
 =?us-ascii?Q?Sah9VD3qo5TUKINqU21ZnRzv9SfYaEUPdVC5sJlhDAh6hYYJwZ/FdRyvbvUq?=
 =?us-ascii?Q?Nqp46UJQO4kTSZb5Ov/gyO3XtkCPo6NwYefHyl2X4tKq920Qi+Hvb74sg3+t?=
 =?us-ascii?Q?BThzXGsjwkTrD5qF2XRwfwz3AIxYE64Mt0pd8QGGJqitB3fgzFpcldMyuF4A?=
 =?us-ascii?Q?fRC3CosxSVQmaZIKKaqL/05mlkkBJQkHHSzNaa//IvkcYYUPXashcpTBinwc?=
 =?us-ascii?Q?CBQjGjByTxP/jtJAIPXFAOAQywdgfXN/ZmFI9IP+PaA6rWe2qiLp5dKF3Eox?=
 =?us-ascii?Q?9trJEA5KxxwVgXVdkV/0WTx6u5YfOpBQ5QGVsUTM692YjwvnOymPqoRWIjat?=
 =?us-ascii?Q?1G4x8TOO7Vzmbf6g3PP5uTBTfnQcz9XdqHfSHTWxcrxvoD9ZFJbNolYBTSwu?=
 =?us-ascii?Q?BGm3ZdVbibtSIIUGywE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58aba2cb-058f-40c7-2f99-08dc65f27575
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:12:00.8145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSq9PMcL7G74TS/fn1NkW4SKhszCbT074HAb65wEQo2cbLBGnhCHx/khgrSb8fwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6932

--=_MailMate_379C6F1E-AE18-40EE-95E4-EE2BAB6D3FB1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Apr 2024, at 4:19, David Hildenbrand wrote:

> On 25.04.24 23:11, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. But it is possible tha=
t
>> the folio is fully unmapped and adding it to deferred split list is
>> unnecessary.
>>
>> For PMD-mapped THPs, that was not really an issue, because removing th=
e
>> last PMD mapping in the absence of PTE mappings would not have added t=
he
>> folio to the deferred split queue.
>>
>> However, for PTE-mapped THPs, which are now more prominent due to mTHP=
,
>> they are always added to the deferred split queue. One side effect
>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be=

>> unintentionally increased, making it look like there are many partiall=
y
>> mapped folios -- although the whole folio is fully unmapped stepwise.
>>
>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-map=
ped
>> folio is unmapped in one go and can avoid being added to deferred spli=
t
>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still=
 be
>> noise when we cannot batch-unmap a complete PTE-mapped folio in one go=

>> -- or where this type of batching is not implemented yet, e.g., migrat=
ion.
>>
>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
>> to tell if the whole folio is unmapped. If the folio is already on
>> deferred split list, it will be skipped, too.
>>
>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still=

>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().=

>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/rmap.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index a7913a454028..220ad8a83589 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
>>   		 * page of the folio is unmapped and at least one page
>>   		 * is still mapped.
>>   		 */
>> -		if (folio_test_large(folio) && folio_test_anon(folio))
>> -			if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>> -				deferred_split_folio(folio);
>> +		if (folio_test_large(folio) && folio_test_anon(folio) &&
>> +		    list_empty(&folio->_deferred_list) &&
>> +		    ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mapped)) ||
>> +		     (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
>> +			deferred_split_folio(folio);
>>   	}
>>    	/*
>>
>> base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> But maybe we can really improve the code:
>
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2608c40dffade..e310b6c4221d7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>  {
>         atomic_t *mapped =3D &folio->_nr_pages_mapped;
>         int last, nr =3D 0, nr_pmdmapped =3D 0;
> +       bool partially_mapped =3D false;
>         enum node_stat_item idx;
>          __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>                                         nr++;
>                         }
>                 } while (page++, --nr_pages > 0);
> +
> +               partially_mapped =3D nr && atomic_read(mapped);
>                 break;
>         case RMAP_LEVEL_PMD:
>                 atomic_dec(&folio->_large_mapcount);
> @@ -1532,6 +1535,7 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>                                 nr =3D 0;
>                         }
>                 }
> +               partially_mapped =3D nr < nr_pmdmapped;
>                 break;
>         }
>  @@ -1553,9 +1557,9 @@ static __always_inline void __folio_remove_rmap(=
struct folio *folio,
>                  * page of the folio is unmapped and at least one page
>                  * is still mapped.
>                  */
> -               if (folio_test_large(folio) && folio_test_anon(folio))
> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> -                               deferred_split_folio(folio);
> +               if (folio_test_large(folio) && folio_test_anon(folio) &=
&
> +                   list_empty(&folio->_deferred_list) && partially_map=
ped)
> +                       deferred_split_folio(folio);
>         }
>          /*
>
> The compiler should be smart enough to optimize it all -- most likely ;=
)

Sure. Let me send a new one using your changes with folio_test_large(foli=
o) dropped
like you said. Yours is easier to understand. Thank you for helping.

--
Best Regards,
Yan, Zi

--=_MailMate_379C6F1E-AE18-40EE-95E4-EE2BAB6D3FB1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrqB4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUhP4P/R2yU8MrioWFVQqWK8DqfsZvQ9l6cNE0ML3r
1y19zJFT2UgIfjc9kNGYdxzkk8mV5l6MAW53T9MYeuvkY+cdJn1/6cPXBk6WQ3xx
1MKZyJBRyn+Z/8fT7F/vMCJowx6F/ODvK7n+8qiqlK941kT1jmR+18XrhHwAKmQ+
mE589CTJFPfL7DtMzPl/VD7kTgFh1PFXz0ybZKlbkZTzPwkZSe+vnphZTNFB/LdM
+TW71sjdc94ChKIEGC3jIN+qiUgh/JMnES8EaymlCSOfr5fVPrKhb+qj8iBvfneO
AVJ9fHsqFIDgPZt/UP9YLYV0IUYb5+8pecC6qGs/G8pKS/ZL8EnefxMsMqKV7XaD
Nrha688yrdarvk+OXMGw5UXjzbG/y17cgpDQPE+e/RUG2UwrY1sgErivAvYC0Vxs
ycWRZjPq3vdagMp73ZAdfAtrGHsMdCGumqdA+qkBHLh80X7/8/oj+kEuJFO9/P0E
ohWxKxqjaFV3kAkfwQaNXsC4U1/5wmWZRlY3V8OmKtXu42gMqH9lSOMQOrHef7J6
oyD237jVLomB1pBXt07NpwIvnAxQsTdUHpmK7x3GZaLzNIEqgEQ9eaRHUXiQVYoe
IkWbWmXX0/BFjkQSS8xIIuDmqvJgO61kuqxTMOfYxvVHVrpUTEOWnGCaIRddfrW3
+m1PeLze
=+kvD
-----END PGP SIGNATURE-----

--=_MailMate_379C6F1E-AE18-40EE-95E4-EE2BAB6D3FB1_=--

