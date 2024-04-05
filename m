Return-Path: <linux-kernel+bounces-133346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C7E89A29B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F721C2244E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF783161915;
	Fri,  5 Apr 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7BcjykV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D41DF4D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334984; cv=fail; b=LxA6ESPfPIL+3KGIy4PY7+yAhWdvhLsv2NcY4X4KTi6UthyIagHpAEhD01mEapZNh6HTygKlh+NSodUUWd60sPFjHnYxjpzwFWukC5Tqj1zQqJWuKCGHcSyWPrRVRsoNf5vlytPgEjWfJORP5w6pAHawS09LjYFk7eMUnp7uSz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334984; c=relaxed/simple;
	bh=ycfC3hLxrwYX6kOZvL2fQQHBtrRqpspLtKC87Qm/xCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiTIs262CsO+sgISQj/ZupWL9kyhhO8GItAz0EYrP/CYrLa2buGCMk/+uARrBdAqVLN5FnWMoeA7XfdasYkLG54O6YawrfS9q0ZkliBqz0hrvTeUS5C+BY3Fc7A0SeMZWHm6kzaXXy9oiD4dzt5PzzhliSeKg/hn8QZSNrr9q0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7BcjykV; arc=fail smtp.client-ip=40.107.94.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/5mh0uL2aEpNvSTn2HHKSNWINykbOueqhvXmkDsto+E39npEo3hPo4o/7bAlL3ldDPE8/B3zAmCtiZdoX7vYRhttcuvwPp+Ck1qmrPvxTmYyJ+OzukJcHw0kbRVz4/l5mo52G7klqR6hWYUjtarCSyyoFtBOr9O6uj9Ci2fIPuOMLWlgZ1GlUEFAF4OyrbCvaCH6txo+1X1TfgjpJ588rntgYSYTgJtGIhQnzPb/JLfdq+LOkNdBnEFGGgNnQyKtIzhfmDd+2Z7XNywHsOdJOVtgIYPxaN+AZraUJ3aJg2Gsypbl3WFpjVtKFhXG3/yGe2ZaXwijAgsIbtqn1ZoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OUhhraNq+gGQgm0735mRnj9PXMBlWhWgo5TO7NCnSk=;
 b=iWJ3hlmeoq4QC55Q5N/fIUrT0yKlqRPN+yY0+VJ9CtAa1+detUaQvAUROWCRZ1/bf55XZGg1KuRQS0r/uQpu2G7VmzjaccImv6oO+WhnfL22A7pp6vtqN8G6yG2QMXGjFfNtdUpyWrSWksc4PKFW2X6ga5fhJRaGVRjL1Q+Q1nz5+ZReBj7WXa0M1reLyzTOBMrFET80u2/drhkbhScsUh9xAzuygKhbdABrdCkfp9nq6Ab7epsmyWs4wf9A9hESHH1H5RpFOnLXv83BdR73zwEeQZxnnsJ+fzgHKX3rXGtHY+Jgn1blsx5bHCXqH7WC95SF/w7O5i7taonH2VcELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OUhhraNq+gGQgm0735mRnj9PXMBlWhWgo5TO7NCnSk=;
 b=F7BcjykVjs2uaOtegbdn0XsjK/mkKtbAxPBu7rfdJYPZC363BmFUPPIz80VRTl8gUPq0hUqEyrhry8aIMlbqVmLy1F1G1q+G/XL7UICVw3AGkWcdTmbXQuFS5GSRvQEIQRmIXc0waxkU1IUy0SQOtbs+ffj0f+H1858JeCSEMovphl9AL58Tl6ZoD1m6j96t3AIMKDaTjJVkgd7X56v4yv2MBrP7GoL/Vo++Nhya8eqglAJJ+2yxkRvfPOK78i9cLP3F287RIeHlTnPBdfaKlrtqQH06S1wmaMkVsh9oc3EVFYHcdYmNdEWXFlZ0yaB/3KaU7/wHFF7dlS258MxuQg==
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 16:36:19 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 16:36:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: set pageblock_order to HPAGE_PMD_ORDER in case with
 !CONFIG_HUGETLB_PAGE but THP enabled
Date: Fri, 05 Apr 2024 12:36:17 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <5CECC6AA-F7AE-4C01-AB4B-83E95EE52A1D@nvidia.com>
In-Reply-To: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
References: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7BE47CE4-DE40-406A-BE69-7F54E585825E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4207:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kcx2fclOOHGq9XkRsy/cpRH5aiVxDZL0hiiU8pm4VbdeMtxa7JUmqefVlAVnkWkMZE+ujUnLdLfCw1ELNL4ZdYa6ilq5k1P6UZEN0uKBrM2T2XYSqJRwLJNn/WjFVyIq2+eF+O8jI3BE4TUijRzRot2FkxnMlo/gTOC+L6dOF706CxCKxioldzrai45tFqmXAKcIVl+mH/vLt3SR6b1Ky47AEteY0Fyl6xEBSq98bMkGBHYnuNhcCsAP3UnUsWHq/Ijy6539XJpczh3Mk0kfR4TRbufNP4hw6oi+cgvA6AFCAn7a9DfaB/nvyHT5RqCj8P1DyjrZFyJGVY9m8e10MsgiGhpwqYVKS9bANgTVyVgl/IpfCk3pOUN7maMav3A7xtRoEZXPFFQSc912+Sr5qJEx2ZYe/eQXKEizi1cUSnX9684ZEgt4Fovqvzl0gs5GORaZwfJXJtZBxDJRD8Xt39QdjRAqZMMkbYst9FuXR3RqneKp0KP9mqBMDRFnoR9KjvEPZSuv96xn7geTs8ZSClWJ9gIepy6nylruzl45MOSU8dIJ7AhZbYU8Wh5ynHInS5FdD4m3UmbV5lfg62Piy4kWLf+RbtUkgti+FIT/ylKZjT8XUZKh3W6Cbac1kUFOOo+ATRVe8EsOyxVmPEhh65QO7S48wOtgUNfly/ePJYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/GcaMdlt9gGFk4Q/l1V3jCgWO7VE4rda7Z1fvAqVZovms7jEGNelvChtkZG?=
 =?us-ascii?Q?vbmflgXOvClreiOpE9YvpLV32t8+EdZmdOR1/YchR+TjThrSP7JuKdxjfn5S?=
 =?us-ascii?Q?DA4SzX2Akxl3RJbTJSe3eu5f+XGePI8ZjVfFoPQC2a1EJmEn4WsFPJHz/dyF?=
 =?us-ascii?Q?BNIyMZB21Tu0tPDIV4Cedv7WdMEpHQy0V2PEK25p2PgZ7G2HtIaQFSpeaSjQ?=
 =?us-ascii?Q?ASBV9hrgML4P7Fka3+fu3ErxqfMcFoB9USSlSu0wmsjsMbOXa4GiDZPo+IA8?=
 =?us-ascii?Q?QsljpG9lb+5yEyeFdpUClrQXatLp6U1Gvp7nsI+yq4xNRAqeR96GBTsax4QT?=
 =?us-ascii?Q?SQ/iuPO13qoMapCtJoBXIl+yPU/cnYEECg1Kzzl3BuuEGv3MxUppdyd/WCXY?=
 =?us-ascii?Q?dYRAqW9CbIV53MRiCP0C+6pqK9szlpExHCNvf4Vspi9dq7Zyb0lnTi+eMSiC?=
 =?us-ascii?Q?5gnwBZoZ4RxleniiHNPNCZ3o4GKCL/EyF7C/zRBHlEoLp7YO++lhoDqqU1ss?=
 =?us-ascii?Q?n0JnYm+mGvQoTtQ9rvpILQck8BaH1o1rrWzGjReal3jjAl0LC3sIXGOembMD?=
 =?us-ascii?Q?VOK/8SbOnx9UUEB8uRw1P3P1pu+mi4NsjaONb+vRWoNoemtb2sj1koR+6zrd?=
 =?us-ascii?Q?nML5zSKOIwdTkFiWzEgShNY4g04qskluV7qsESGaHR73/Sv4Cd+Ui/+laSV0?=
 =?us-ascii?Q?GdPxi5RqFIPVOWE85bvaHTXwld+wmCRLZ+gQzDr4Vthd2joXg7Vy3E13o1n9?=
 =?us-ascii?Q?OxZ80kXNwzA/k5Wo3HdfFDEY/kwN3jLyZrA1bvBNgJoOffhWg7ZvUuTMungY?=
 =?us-ascii?Q?rCYSCEXlq/IbZKWt0+z1tdZ5n/BTQGfQTzxnrcjJSSQ++BtyvNAJ3YiIC4FP?=
 =?us-ascii?Q?9HZBdmC/ZEI+fg8UH2Wy3mX/ytDZJAAwpKcUfebn5ws3OKzVa0CXbf4+qI54?=
 =?us-ascii?Q?MtI81n+zJvFIekf0iBYP0QlJ8WuxLsdy+hPV9xto6qjUEmixKmvlgdo3nOPY?=
 =?us-ascii?Q?r/tuaEKXlEmK66hlhD+MY9Gg0ZP6/7kL17nOc7u9UibvPMpYUd/s6NGv6lh2?=
 =?us-ascii?Q?Gso4RMZrpfbQKKp/vhQmnyG4Rs1x3C0K5zI/XlhnIXLurP8EN5uatbfJ6FEK?=
 =?us-ascii?Q?ZCkEsvlfrpT/ePKrcK/xDM3nLago2ki/BnALt0e3a2PkSc6vPqevvUOC7Nvw?=
 =?us-ascii?Q?WSUE5T01rNkaLg82oOrG3LkcBFw8ab7/tCKmHKzDutrXcVOIw2nGU1sxqLtD?=
 =?us-ascii?Q?Ua6rczFxZl+ekKp5cc9/8DMV4RmheW8t9H7rFxguydhV6QQN2lKzjDJg3eYy?=
 =?us-ascii?Q?R2h3PPTXhBk6Ekkfp3Gk5rhI3B3lsXNkWougvQZIl1tdQloKtkWgsfLPIW26?=
 =?us-ascii?Q?HWhWNc9zokP9HA2Ye3NbwOsPP3aGeyJO32mItKBSs/7nFX0Jj5afXNYNdrEJ?=
 =?us-ascii?Q?zHupagNKQijBMxct/LxQt2FfFnNrvKg8mh+NOnadzV8r58G0WvypLVW8ReVD?=
 =?us-ascii?Q?KwhdG1HGAW2hPkcFaZZPhjMVjh14l2SOYh+coYaXw0N1qlkp92PPuojOGRCc?=
 =?us-ascii?Q?YCcXIEdsk1+n459zpcGAyjSerhtfCLP7wJ9eeiVp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0244a7-6cfe-475b-e269-08dc558e8564
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 16:36:19.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fQhSp/Hyh57yytTGAcPGPunHIlP/An+THqPH4kJP5eMT3+Z1oJCx4sZwjC55Xdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

--=_MailMate_7BE47CE4-DE40-406A-BE69-7F54E585825E_=
Content-Type: text/plain

On 5 Apr 2024, at 8:24, Baolin Wang wrote:

> As Vlastimil suggested in previous discussion[1], it doesn't make sense to set
> pageblock_order as MAX_PAGE_ORDER when hugetlbfs is not enabled and THP is enabled.
> Instead, it should be set to HPAGE_PMD_ORDER.
>
> [1] https://lore.kernel.org/all/76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz/
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/pageblock-flags.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_7BE47CE4-DE40-406A-BE69-7F54E585825E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYQKIEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjRMP/Rl/7EsCNGNLzfsD99qWtjv5eU3ss6CKddKR
AAnDvZbrBf+/dLwKALp+0NYk1oR2nFaHpDpaVAnWEpXfN6BkVKLKXy4f8hs0yCEQ
NkG7pNolMtFgbql2G1fLTXy6dz7dFj1oq+YSlIZM8lV1mFCUntKiF33zRNApw08B
Rla8V6BOo7blMMloANEKiPugnzqPRC/4PsG7ZXLVW2VKoZNKbF1uG/TbzLASyzLg
Ic8d3dBh1f0XYXJMHvDbm073wKydM4+xWUvkS2rh0ykR4ZbfQd5BaokUCRhtfKlT
U9KH27nknN/EGArq/t3eP/TTYAAUzX4uyjMgDxeFZeufk++WOedmTL9eoSI0y7Lc
wnbtO04u9GGcalF9uOazndJuuTzVl09TEZXDeQsm2x7oVDLMueF8nvz5nfc82JdM
zu66tTPOlF5ljwQJcKOEMcEKQuixoNW+OgtnWlgR4haiukuiIttroYABkjqGUw4B
brNSRkfSqNGdobEB63q1iIasZcVPeUp6ps9Yz41cUqvFKoeDNaEPo6BHkUM/V0FH
//I8dBCvu6nCFc4owCfk0mLR79Uf428PgIEn9PoTb3V3fTsww1+AZORcRwmWex8e
Wkh646kxgtIWq6ZHqNRPrUnzoF0oc1dre8ZfCnhyteWSqAmMTq406bo/aIgPQ1JX
M4okRhQu
=BicG
-----END PGP SIGNATURE-----

--=_MailMate_7BE47CE4-DE40-406A-BE69-7F54E585825E_=--

