Return-Path: <linux-kernel+bounces-71063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE685A02F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437DB1F22A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A124B5B;
	Mon, 19 Feb 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLxbccUO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAA24A19
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336220; cv=fail; b=Hq8G0j/pKscRE9GuBhYie14OhzuopRPyLFOCeYyrdRu13+TAk8uN+q7dyD0XWXtBGTj/xjAmRpUfQg2uGtJh2LwqJpdB0XscyGYXMjxFQuZQZ5hrCpS2PxSCz6fhoCbKVZAEcgdoD5qiIwYBGJKQc4SxellI61IGddgwWdrCuCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336220; c=relaxed/simple;
	bh=iQeiM3xpYp00ELdC1AWh7K49vh067MS8un07PYHxHVM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=mgy4oHJycw434Xq6Ump1Cb95jw1jzQ9/0oBGEb951njr6BKSuhFIRsItIDkWxnV5GHhunmj3l3ppYW44DFiJtvEzZ84lYfnDVW06DjAGueJvKufPafEeFLRzWCNvKIg05bvouSAhcnD3F57rq06A1T9FaIuFCvJwKiZG7J/gRME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLxbccUO; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9iYkO9l/4lwqFkX1nponr5tD4vCooWjwKr35drOkkhooM0BOPDBGx02npzOg3Mkb8vMz3wusFMe5UgjHZVtgaAK9wuyKCp92z/GAHKqMQsGkJ+G9vSDKsT6wt1rUF01zLuAKArrh3RR3pkP/kfAM+qenheKe0P2Epb3ZtkCJM8F3GdizCpyxmQrlma4JxIxWoWXc6OIfWNSdORGOgOksLITh1aAxDfPsEVi9gIbNumZJjwYcXp7oaPghCvDGkfPzh7lNdr2INSf8qxsoEXWmiCbqr5TGr8FYqB5uws7QUWFo+LkZJs0aLXcGBg4IVP7Y1O50Vfn8gi07MsFK4q1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tixQ5R9IZUP+WEX2uv+RFHb/ecS/16t8tSkxwJh1HM=;
 b=TdqZHV/zSXx3+mc9faIE2qb6/VrQWWy5JFz4idA52FfT2tw4WUQSgmYEbgU0vZ0vXQFFLEzxpMbE1B3sJeAVvfeQN+e+fYAWAPHiSW0Nb0a2/d4Vp3RzyYdfIo1ZSGOh/RFO7GGpxJnEl5hlZIBmb9KETxyYgWAxarMn4JKf53PZZJCgHVpyo/JctWy8tm1FukK8WH4Kh15nyEX1Uwd4vI8OoPLgXkFak1L9CPxJ7VjjxHEFgzRFfUvL3w4ODFzL5klvl4KdFdRNyCkodg0niIOfQe4fKCTTB58r/VDmELzr/YcI5iNqdHAvvLjvOshGs/RJFfT9vQT24oTvzZ26Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tixQ5R9IZUP+WEX2uv+RFHb/ecS/16t8tSkxwJh1HM=;
 b=OLxbccUOKiANT3Kq4Xs7GgEhO6mRmZJ6zY/LTxjsFG8PP2JVik8fC0Imd2ttpgEVnGpT/olLLc6Y1UWhzbsgIQcod4u4c/UhIAE0D/nj+yTeL3A8ff9pcbJpjtJ/hNDujTF8wdCy7Ksyc6OWmdK2ghLFNOi1Nv7G6CpEjOhkVNqXX7w0IIvz3KW4Hut+7vSUpf8awkU0Z9KOdowKsFmuSOjMayE9Q9TmC8RvHNHlugWWf3nspMOgJhcUgerFpvkriaKq6KjfulLjV7cVknNUsAIrg2WsZxeUbMMNYSN7SVxBqIfJofNvewj1kkfYfNEtb3B6FfGWP+IDH+f8eNn7fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.19; Mon, 19 Feb 2024 09:50:14 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb%4]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 09:50:13 +0000
References: <20240216211320.222431-1-sidhartha.kumar@oracle.com>
 <20240216211320.222431-4-sidhartha.kumar@oracle.com>
 <Zc_Z1PT20tNlsiFf@casper.infradead.org>
 <71db0ad0-a385-8572-7bea-bb11f76a6345@oracle.com>
 <Zc_taXK-X-NYPQli@casper.infradead.org>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/6] mm/migrate_device: convert
 __migrate_device_pages() to folios
Date: Mon, 19 Feb 2024 20:49:07 +1100
In-reply-to: <Zc_taXK-X-NYPQli@casper.infradead.org>
Message-ID: <8734tobx66.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0198.ausprd01.prod.outlook.com
 (2603:10c6:10:16::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8a8a9b-53dd-4dcc-ce3a-08dc31302b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1fyFWcheHumYfIVojtuhGxolXlQpk1uwdk2vbvZovXZXazyVSI2ejlNT2TvTs1vNesfamNYrCyPZUa7GDCXR9jSTVzY7sOTy9uLSjeQEbsyuU7k+8C7EGy+P5H4gQ5pZcNDVKa5TOb6L1CxlHEOnaSJUkSCchuhYvT65BUszMgBKIew6sEMKu6deSWhKfQ2rQmLEg0ey2W8XcNaoljViUoGxkdaUKv1259k+bAtHoVwASM18+6JKiaO0MnOPT9VTR1fwHYIrXdwVKGOlHQAT4IoXyBTa3efVBbFHkS05LizVIHc28pXEYmWzF27fw0npNpXtw5fpcyxYZlvkRHWUZ8z60uZC/QCBl2WwSorBrvVYGijpcv4EFWT+mG3T3CCfRYsIkIL9ZEdUhMKxSCgcGSYrKNHQsbzsRLR4xudo03h5NkTkRyA7zA+mVEixpiUix9gngpR3dy8keAst5aNBrZ70ZpOdJ74rfexxQAfU1cTGL+h9N1GQlML429SIsM+JLB+ApcrNr5vCyXJka8EECvD57ZDXcLKrBK18QYxgzlX6sidGev6QTzzJAZt7wwPH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(26005)(8936002)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(41300700001)(83380400001)(8676002)(86362001)(38100700002)(9686003)(53546011)(478600001)(6666004)(6486002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NDSACoz2xKlKHoGe3zE90od1VwS78IS0gbILsS1ERrZKUQlgAT5EFOkH/WGk?=
 =?us-ascii?Q?CH0zSWoXrLCKlQWAgh4TBe68VBMSpT9CfOQomTb+A9BzKWiDY0XZ/pNdnPd1?=
 =?us-ascii?Q?xTh4YI1tGEK0aeNqgA0HWsEU8FMoQ4UF28sjDK061DtKS9KI8443XntUYl/L?=
 =?us-ascii?Q?FWNSm74WjMFMtZvaN5Ufvl1YXBRY19Ke3gLMnGD+qIpo8urgElGKm5SEc5A7?=
 =?us-ascii?Q?9s1UmqSgVqKbxrjMQ6WeJq9+wsL6apyl0hIDjC9ggaZnMAZ86nINM8WglXdL?=
 =?us-ascii?Q?O28jcXarPepxD79aj15hdpcdTE8kx2tcLu53dWAvkj9lyy+ej5h9kzElaUxl?=
 =?us-ascii?Q?iFAN8QnSOYyma691MamLMguczSAR38ehvYrrb2gUJNmDGdhSBXV/HxKCqLDa?=
 =?us-ascii?Q?xth6jPnc007fnV18OP9Pg8jeLOhK6ONHm5Cd7kJ1Qg+Z0Hom3TPyafL2Wz0B?=
 =?us-ascii?Q?5nB1VmaL7WdyDdwGAAjiwm+eXsFZMy/C0bkbGCjh4ivapkHHNvf82i3WLIW7?=
 =?us-ascii?Q?1sfqUjeAWp8niBXn007Fi8TX+NETfX4mpc2WhXmK0Xwc5LEPG67JJR6m+6Yx?=
 =?us-ascii?Q?OlACYeDU9Q1VAxYPIzGCQUc9scySaGGc9j8v3hyHKRO4Qt4E+ZMjqYDUaAaP?=
 =?us-ascii?Q?aTQ//cYKvTDqA1btNFArPv54J8XO81+qGMO6jgp0nDdxKEYtsB1+hzPBLuBT?=
 =?us-ascii?Q?6wiE5pzi1W4ExHXadTSWsWpT+NqRWHube8jI1dWh20UKNSfmmLhnRuRKKaMD?=
 =?us-ascii?Q?6Aw9i33aXUmC4xVKgkf0Rx+WzYvErEv+Kg5tCQrVcC8xsbE/qn7BhKZiDq/E?=
 =?us-ascii?Q?USB5waIQHzBeM7Y4aCDkxVOAPy3RJJuW1HhChcfZNP9tPaZ3P7LCm2iO4oUL?=
 =?us-ascii?Q?mIqh3YmoaIVFc5oubV600ESrVW6Q9dFdjfgQaaKAxeeB1zLkorOWJQw6M1zd?=
 =?us-ascii?Q?fOL5KVqbmnsKXZJ/WQAeaj9mNoypE6vaETu5gJy0gBYvfEtf9oJ4wUxBmdsC?=
 =?us-ascii?Q?25/saf7Fj4WCaJal+GdnTVKFb2/hj6YhDyyrlN9Y0Y4uUxFizn0qpOPHniiZ?=
 =?us-ascii?Q?oinF4RdELS7AHbVHjqC2Y7z0qRdW163xAmTaUZwlrs7cNts6rE6D5eHZQvMD?=
 =?us-ascii?Q?wFDeqxtD7qTN8T6cZ7e6XwKfsQd51jQRp0wT6L9BXznGsc07JoYbcNjZVfFW?=
 =?us-ascii?Q?itHd8sKUqEGUvHy9auWgJHGNAWa5o6Ay7J15VTQAdwYSXgjHBks17Txze/vL?=
 =?us-ascii?Q?jxIx+XvjGT/hKmcrH/hpIvoJ3kG+U7Z/jIVHxizVlBOGpSLSgkY3FAnDh5sA?=
 =?us-ascii?Q?IeolxdCedlBmqRSVtU41YUtVIlNrx+rIzmCAxIn39l4balJTAOJ8ztDTiLxi?=
 =?us-ascii?Q?1Q1l+HyVROwc+J4TCvE4V1/7S/ZizVL2d/ZQ77L+pWH0Xq+fnjj0yz2olgL3?=
 =?us-ascii?Q?T369WEQ7kQ0dDHdHr7iW0uJ3IS7mthJvhcQmBOb+i6UG+2KAtkvAI7sE1uyV?=
 =?us-ascii?Q?sJpsos/0cWmXeAp5nhzZC4aY+L1hvpGLmL1QQnlEDOMCmNJIhwUZSJajigwb?=
 =?us-ascii?Q?dkk5xJD9vbUdjujCjl2iKbQo+IwIXUWYT4OzMGBU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8a8a9b-53dd-4dcc-ce3a-08dc31302b82
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:50:13.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDs7OaJzsyWVIAK6I2neLksFqao7uBRwKYE9Bqy/0PV09s0wH0USF/0N7Jqc4kqoGobOysnYcKsQqOb4yPSF3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252


Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Feb 16, 2024 at 02:00:31PM -0800, Sidhartha Kumar wrote:
>> On 2/16/24 1:55 PM, Matthew Wilcox wrote:
>> > On Fri, Feb 16, 2024 at 01:13:18PM -0800, Sidhartha Kumar wrote:
>> > > Use migrate_pfn_to_folio() so we can work with folios directly in
>> > > __migrate_device_pages().
>> > 
>> > i don't understand why this would be correct if we have multipage
>> > folios.
>> > 
>> 
>> Alistair mentioned that he is working on order > 0 device page support so I
>> was under the impression that currently device pages are only order 0.

Right, at the moment we only create order 0 device private pages.

> That might well be true, but I'm *very* uncomfortable with doing a folio
> conversion in core MM that won't work with large folios.  We need to
> consider what will happen with large device folios.

Yes. Perhaps it would be better to post these fixes as part of a series
introducing multi-page folio support for deivce private pages after
all. I don't think we can address your other comments here without first
describing how large folios for device private pages would work, and the
best way to describe that is with the patches.

I doubt I will get those posted this week, but will aim to do so in the
next 2-3 weeks.

> (for filesystems, I am less bothered.  Individual filesystems control
> whether they see large folios or not, and for lesser filesystems it may
> never be worth converting them to support large folios)


