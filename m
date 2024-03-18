Return-Path: <linux-kernel+bounces-106368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21AB87ED30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5849828149C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F6535B0;
	Mon, 18 Mar 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEzlhRln"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6515336B11;
	Mon, 18 Mar 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778589; cv=fail; b=Dt7RTr4Rlvnmb8HKgBFBGlwtFxRY6jDhKCJ5RFLgYgSfCn2AUNl0y3Dfdy+yUWjPJ373bkLZpV7xOpWVUlaJDeyoIOR9oPTAqgFhN3vQvKhy6hyoUDMnaJECJk4W3US5Z8KvqfkBTJP4I1g34+ibC+cRbFXhJ3Y/azfxg2UyhAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778589; c=relaxed/simple;
	bh=kIT6BFjv3xpXLU/umsxieq5WJKEk0Jew1EAy1pJf9z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+JC3iw8Jab9xfL+F5LVlksS1tZ3jkV6A8bPIXMFwuRTE0+3wQXbnIXw60Q7UtsihVsMuQ2wn5X64+cDZYZvgfEa1K2HUj5P7Gdp22fp/NxYORaLBsMchsamY9vUJsvMGwRvnfraQv6gnsFU9XLuIaVSXGVqu8lAWCI36k1FYiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEzlhRln; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggU2T2+dW5s6Jl2d0IwtXFeqUSSDq9wPJqcoLLiT15hXKN2xiZ8jiiLxEUpsXy+lHu3ksu3Q98h5lhTxF5yw02H8dmvHQEHm1o/W0JwTw9hBDE0r5tbzf2o7GAeIVLoxM+fCa7SBp34QFQu+Gq1iwTCkRxaSROGBn7NVC2hnJMpuy3y+Lold4vVbs1EUuKBrWskeqiK2gumAs3/5qCz/lrWJX2FiBF+ppD+v7pwEjUzSSFVDNacKW5e9hCQDL/DV6iKOFyTDR7ftLgsmPz6X9yf6XiEyco4vP/oE3O3cll1xz5CSzJHpmmatYzUiiboYaNrks5jiF6qqHX1fuZFBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHPGI0sgsnO463bBG9OyVNa4jROqiE7xpF6jdd5I06I=;
 b=B/R8nMZx4EeZodp4q5yfseF+Y/QR3DeULAg+6s7JDzOWyZ9N+qliajNvLYo9YPsaNNW4ENz+Vw9ObKurN9x2Cv15Nkgz+Vc7+6KmM/hrKESfuQ4hPJsjkkE/JQ99KPz/ajNi3WM32k65EAcZUnbk7KdTMLe5dSHwZZEqLI2M3IBme6aM6l5DcA0T/ctaoaFa7d7nSAuaWdRWTWP2dTVFN/mwOUG/omgShdd9yJE7E8bcP4+UASzYbvHY3FI5DnfeV60iplShvKQWLwavEEnkZ05QlNETJQpWegVlAf9PxAUUU916M9vJk+hf6FRa7xeYO5iGLsENqym5mWgdKoDljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHPGI0sgsnO463bBG9OyVNa4jROqiE7xpF6jdd5I06I=;
 b=AEzlhRlnrOSA0DyBXbxK8dZeBR/+5KQic4KDWPbGQGdvLRvNFzEQdMh6ik67/S9D0j3E/gmR/M5uh4T5Czaw8kdTGRvCF3DUoH03VzLnqDnnIVCT7IppnMASh4iSaaQ/Pgyks1xa5KKbUzxCEv1oZOFh7UpG6q6VHBRaXyThMBwvH8PjLZ7OF2c5gygzOMrwj6FO1WJ/IbSph3bjRzdiD2eFkTMWdanpr4K7SL5D/VrGp3BgGT+8SKKpwFwOtLM2p8C3g4sQsL1bblVOVBpoMnpEFnngaztyB+5/G/4b4euRoISSiyByh1Mq3vQGzLeg2uhWWVIleLBOCYny2HJxrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 16:16:25 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:16:25 +0000
Date: Mon, 18 Mar 2024 13:16:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 11/13] mm/treewide: Replace pXd_huge() with pXd_leaf()
Message-ID: <20240318161623.GB5825@nvidia.com>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-12-peterx@redhat.com>
 <0f929f80-92fd-4824-a7d6-839f1aef4c8a@csgroup.eu>
 <ZfL0qh0re5BpYGba@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfL0qh0re5BpYGba@x1n>
X-ClientProxiedBy: SN7PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:806:125::24) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2ba8d5-2498-470a-5de1-08dc4766c242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5R9VlEMi4F4P2NagsgZhz97fAh/GDS4WvK99aifrcZftVfBgP7iMBcyUS0ERzvatCyS4ZpyHPDXkdD04kwL7nblOyc5ipabejo6JpSODlaoUMeRRQ66VyexP08ZwxXEzJfMyfUb61xeseE88qry9nsoyDq0XwBLMzvppr/wldCPmkj+TeeuqJraR2qQHxM1ErTYvHUPihobdq9GnfAVK6BznG3dbPyzbMnQxerLrB/PaDldtHfavxiN6ZgNa1iFpAQjEb2vw8f7YE64p/EhVmii9uFl6G9fADuf5BYFoHmN1FVk+nPOpcWp4KhaOuzoPN6lanRmEe+2OBn41OJpsYE5TRmqvGx8n+eD6IP6rrQRGvIUkmvMdI5aE7PwXcqs6NyOPW8v5R8Qe85tdVpcTl+LdydHWJpsRBQL+f2H4MGu1uMPoMVFC1vkaEV17cvSFmSyiQiZSASTg5vtCWxI1/K9ihUXXlI8P08OZoTtSTfD4d6EUDqswyXs533Vhm2kTmcR65eYZXN+ADd5b155eAhs/JPZMEM5+ZvokVOAQl2hOUuHHtsdkhCmCPQAEIfpZnzuFwpuaID2NeSaoJs5YDn3WPM025x79eu8ZzF253+DG1KU1AaM2+dH1sJ77QXd9zjyR3yZuMMWoEny4kt5vtTb0FaAFeaWOa5HXn1WBGnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sK+rlVthDEJlrnSJpDOsTBTV1nHVv6ZxTdUDLVqjaLA1HnRnNB006izuCjN?=
 =?us-ascii?Q?sMyQU6ATSVkt9o5z9KzkC6qApIoCM2ZD0X+1QsgZ1cgAkKRBbywjKgHwkDWe?=
 =?us-ascii?Q?2Cd8DL0s6cW8jWxxThZhWZmQqztTPQ9Hof6M7PSed+S1ZYGSJDV1jksfzVu9?=
 =?us-ascii?Q?3BW78pOQ4wtmjh7baLWjcWvu1acO3PG4NrhPsOyjr+wBC3x7Yntdp0S6j53u?=
 =?us-ascii?Q?eMNfm26K09UF/0Py7VlNjZmSfnD9PRgIiYqEe/QTnr66BIsEWNFFkPiwX/4e?=
 =?us-ascii?Q?kmC0mb86agBJISOkCbYbuXAzsFBi/WZJQGXTK/MWn9ks8REQNG0z77nmYipO?=
 =?us-ascii?Q?QcQCUcxa9ZTJUQPLjfZcgCazPOfuKgdVSFrBmqlIMSLMjNq8qsp4ENhfbxYk?=
 =?us-ascii?Q?K1YcaxRib6zOPGu1kQh6CQJKJVVv018pYEVC/ow6JK1pBCJCEo679lpDnjMH?=
 =?us-ascii?Q?25H6WEx59ltWb/2cE5ymrbSSrNJ/RQbThlLoyBE41f7kzCbmTIktVw1JhdIY?=
 =?us-ascii?Q?0dw+a78J8f/GyxOe1i36CVp9cqDfU5clKEKjCQXaOwZ4NKCW7hWY0vDBwIF7?=
 =?us-ascii?Q?9ZsFMyrS4ehhR6X+YR9Da1wr40gVnWOV7t9b8syaeGnHYNOHRyMyFBdJpOPg?=
 =?us-ascii?Q?3AXzVoJiCCNYL7OTL1cX+/h6vw4cPiv+iGQyxy6YNDBx+XenzIfyJELWh0qY?=
 =?us-ascii?Q?LBxO2jA2lIzCziwTWKVQCQopQsSr7X0v73+aMfBvxM8azxSA5EBSYMT1i388?=
 =?us-ascii?Q?kNuBiTyZBem05836ZBi4zfyMxmp5R5yPbyHqKrTcwYXX3jVKq3eCkPiC76KO?=
 =?us-ascii?Q?KQZGSPyPFXYFhj1aE0v+jozwmrI9Hb9w7S53D09GvggkmJpbHAmPd+jn3j0f?=
 =?us-ascii?Q?Yci8B6dDODYgN+/zgBBqLuLWlVYUCXCnJTVZGTbRvo+RiO1V3DQe3eNsmS6R?=
 =?us-ascii?Q?YGykz7bEg7JlgvYaGdEK1XDwQakPcLQQOdXUYn5tK0buZsm545qXEcUn8Sjq?=
 =?us-ascii?Q?6G14KQsZtruvJdTVptA423d23SJkmN+3hpjLocgLZZhSVAWTnmPw1jL/oWxe?=
 =?us-ascii?Q?nscDEPXj+G07UXL61ulPXWXgub5d95+Tq5mUkh1W9HXmJbvZG9Hatk/9V0x9?=
 =?us-ascii?Q?rafn1uTmOZYEgcUUoajZu/+6K8EwWnhyrFgm3iH+l8w7NAUyw2kTOYztHjv/?=
 =?us-ascii?Q?lNXFVROC/lBqsFEDCFfGk9TnK/+McQ6GSov0/inOR9VgQ2dhgXYMA/+66O+P?=
 =?us-ascii?Q?gDfoEVXZu8FFe7kMgDqhy3NvKVYSrIiOWIvdj5M4srhXCA/LyJlCsj9f/hwx?=
 =?us-ascii?Q?9aQAbOpLzL27DxdeRi5nJdgQq6+oaZFofU4MYI0eKBkH+lIwtiTpOViJ4VbG?=
 =?us-ascii?Q?Y46dwKMfIEL/dqrRLa+Wq5q95ha34fw+wBc29AbU7AoXPgFPk16l6ed7bU8n?=
 =?us-ascii?Q?HbirpVdmULI4fLb8k1O5RRwi8iZZW5cwyxHd9h46LRu6FYP8imiwaSnihKvb?=
 =?us-ascii?Q?ibb49k21Wvr8gpnQVHbX8zpnAeI17NzDsdk/GC1X/GrYxQa+wZsu5rnx8Tsw?=
 =?us-ascii?Q?fcASbXQOx7ottXT+zVE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ba8d5-2498-470a-5de1-08dc4766c242
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:16:25.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L4gyrK+ZKTmJPnB51EriTxZnleDFjlf/kcepXfjxBaiyEpQzV7czB9M7BBT2B0P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331

On Thu, Mar 14, 2024 at 08:59:22AM -0400, Peter Xu wrote:

> > > --- a/mm/hmm.c
> > > +++ b/mm/hmm.c
> > > @@ -429,7 +429,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> > >   		return hmm_vma_walk_hole(start, end, -1, walk);
> > >   	}
> > >   
> > > -	if (pud_huge(pud) && pud_devmap(pud)) {
> > > +	if (pud_leaf(pud) && pud_devmap(pud)) {
> > 
> > Didn't previous patch say devmap implies leaf ? Or is it only for GUP ?
> 
> This is an extra safety check that I didn't remove.  Devmap used separate
> bits even though I'm not clear on why.  It should still imply a leaf though.

Yes, something is very wrong if devmap is true on non-leaf..

Jason

