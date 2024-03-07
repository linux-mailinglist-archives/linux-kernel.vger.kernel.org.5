Return-Path: <linux-kernel+bounces-95998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0938755DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B82B232C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57A131E21;
	Thu,  7 Mar 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OhuCmkxs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3391EB41;
	Thu,  7 Mar 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835160; cv=fail; b=j//uIoiNuBMKYAg6c3Wi02kD55VJeVjwXNHQ1fa5I0qdw+/PGABHXF0Yg21aIsFRlAkxFD6QJ+MNvSiXVU9nmgHgSXvfFsaIM2pfV0uRpx8mkdLuPB3o/bfPmUS6RlbSvxR1a5rRfxHJv1rxIAHaKZOS2Ed3XMcBpf7z26Jiitc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835160; c=relaxed/simple;
	bh=DI+12lSQ0yHvjDfR8NT2WUGPQpkRlEzX9cBd04hNqtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gCn2supoU5pghKT7TZlZ39RWFoNno3enMxzvbN7WON8DAtdaFDRBS2nVqXQZVnIjNfRhYAl4HP6oQZq/1/xq647IvYRGGsc5rivPaVFvvg0rA/4tBWFVyfmK95wChl6y/nmjNAr/u+Mpfy6yOsivLoLjmdjx0ZeHDabetMP2aAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OhuCmkxs; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aac+y1qpLvXckwDFE3F9wd3xPUCmLhTKlzM3WRW4ItJJiKyHNgFGIcIJSsIL3H4M+jn+mCRZeVcIuj7sZOlmoYZg3i5zoO7RSUxkV8DPg4hS4cSu0P/zZiED0OdjmSWu1yzfT3FKFH9l3QNEcEAkylAu4lzzqYi+Dtf06RzyX5lw8sGKJYGe4EDvUfKD8aXEAGKnB50MOA+VaTG2QwVrM2iUoQnV5z/+WdvP/7IStJw8wgAOSQLlv2WshKL/+0bjbSAaK6tQ/iRDHZTKDgu3jRD0awQdbUvNBqXndKCfcfFnBvrjDwAVzV4E3/N2YELckqxOuERrIdryKSeNv4qiBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFgnQjgoufUaTm3fPJGsTSnRLxse/CypBcBcKmOiAWY=;
 b=FnbjkyjD4pj0okuYXiKINxjRfb4M1s30an+DCjfYVa5r83+FZFTFYRvAhWwKFJG8QXlt5kdSkzbjM+3BeZUK5hFDpZP9T/lNPDn9jGity5MY3e/+TlYINoOGjZdVygISXtJF+3z6gWm3jtpXXxBBksZPW4p3Ck0aaIFypjvYCjrN6q7GJGVumIxdC1kjykGIvMoB2mVsIRKRndJXNtXGBrAcxYWVmeQVPaCEwFePoMt+lE3TVRNaCvQTnFL8EmfmcyfRZhDZn4er8H7AU8rHAH9Se0XwUEe/VyWPGzWDFcm6WJwiirfk67LrsrWf22Tz2dUzRO/zBN3J4exow6DD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFgnQjgoufUaTm3fPJGsTSnRLxse/CypBcBcKmOiAWY=;
 b=OhuCmkxsvO06jS3wA31c5ba1EGNzwrbYb6GU6xgSBb67II14zQccNoBLcN+5TNv9Gswpydy8PhH5PA8LgcJSUNIf9S8nQkLDrE6h6ZxAWbhvNYX1wQuTvixfB7Um4llbIOMp8xhd0F/ZHj9fOXfDU6bKWSHVjMetHhS4K8QHuvIt4mlIGpmvqtnh53Qh512jE+Q+gD4P7n3KRFx2eLrQLpcig8WMUOUdJ6KqOh/EQydjFq7afLTNmBjhkPngTyYJeeqJnI4SoSM6MBOjcM37UZ6v+PncO0JIKx08U7EsNWQyACpmnW9JnZ+znOSPgxkBJy3EH/FBEoRLuNX2ONeEkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Thu, 7 Mar
 2024 18:12:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 18:12:35 +0000
Date: Thu, 7 Mar 2024 14:12:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
	sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH RFC 01/13] mm/hmm: Process pud swap entry without
 pud_huge()
Message-ID: <20240307181233.GD9179@nvidia.com>
References: <20240306104147.193052-1-peterx@redhat.com>
 <20240306104147.193052-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306104147.193052-2-peterx@redhat.com>
X-ClientProxiedBy: DM6PR02CA0148.namprd02.prod.outlook.com
 (2603:10b6:5:332::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2f4bce-b473-43d4-2f43-08dc3ed229f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8OzWZAzD4wGu+ZhmbjHFJwjh1PRO+ZKe5qTWCKBfMMQDOcdeNK/wLT/2Vw16rbMH6irKY02OLa4X4k1bQNudoCNFtIZTgvGpL+nOpQ+kbKbT0u/cI4gRBc73PAvLtbKhh4KYYG1ugSFh95+m3va1XMOaaWruFeKxXcfgqZEqf5osyVzWg5ya28X0qltLWjGxqiB4y+oSEGjnlb7aLKvvlhqf8F949yJ/zYuA/IxwUvzgMcNh74t8ZxmNWVwws8mwzhILTkZ7h3qsbV9+eZWEQgZTV9MVqePwJlO7oj4sKRvpaN56VBojXyhLoP+L1T0PjK/y/QaoenX0v15u8D5//gLx7POJdB8brFZfTs4VQl5JE1g7wJhLgwxESP10WeiO0op3K0WH2vZLEwOpcwjh8Z2vICEU9mUOSnqBj3j24+8j8kRjrEf5AGar9DmAGOk09Tzp2iPuGI+Y45b7ULocHkrBPF1oBIsft1bK0p0J9UzsNRp97ql5RJGWE7nRbnQcUt9TdftuV55Gk7XPpC0Z3JC3LiC9y6OiKp00zj4J95nFimVxrTX8QcgbH7U+gK8O0GBwyq6g3H4j3ci5MThEguRMlCkUxjuxYXzsxgNnpZmDtFY2V0AVmdlAoaa1KK1puisuxTLM7Dto7gXTqRawoCSkPvvVYHHTQr/m2Zmkg58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OEY1ADnp/GTumax52qAHWjssr78dG0sPMLOJb0IVsUOzBJ51mTitlPt/TYs?=
 =?us-ascii?Q?FJQyNHXa1opF3y2nVesF99wZ8uMg9Wt7zVppqybulrA75GhdS8YRCdNGHADo?=
 =?us-ascii?Q?Ywo14X/wqyie7PO3fEZd7ObDTC4FWcMfNNO3wAiT+u6q+OipBItTEyBj8Jqe?=
 =?us-ascii?Q?WcqM4qqVyeH/fkBl5IXckBf60/UTMZQqsgnclFEkVaKEG3yF+e1YhHDybpvm?=
 =?us-ascii?Q?mkpJGU7I/0mHLErqGxK7rh207g/ioa3lPahuXoib8T/vemrUJf9yHC+x9nCs?=
 =?us-ascii?Q?zRpMV24DULArA6AU4ncta/upB0zePc4bFAvHVeCSW1YMwu5A3CgKdazKIFFI?=
 =?us-ascii?Q?A8Ksny05Ekc8+usam41GV9JO8tUc4NcgL+w6Uii/MEVH0fK0DkwU9LRBLiLj?=
 =?us-ascii?Q?7AUBom5OljELnanzpbZ2sGcbRMASV5eIbBa8/iLxHLEYXWb409uGD9BdVl24?=
 =?us-ascii?Q?6e2ZCT5zfm5LmB/nOZXFzuu7qvMh80wmLlf38ZAdzyCY784R0xfW4tsskcNw?=
 =?us-ascii?Q?MFbjU+KFDy3Ro74X04m/wyqldlK6TEZOyKfE8XVVZ483MBBzy5QJlJO77A7M?=
 =?us-ascii?Q?qwgelKdkU6K/p5PhE5FaWQ0WzBmI65urriv1pKoKzOAPVAEWXMGK/iTh/xDY?=
 =?us-ascii?Q?kF+IrHgXRX7lw7qwpayvHPxieZK2MzaPN24eQLNQO3qK/vWj7yCXfiWzPrMd?=
 =?us-ascii?Q?2YNtCLoTjcRCj4lXUOYUa0vHMM3k3o1wr4OqBhgwKtxaVxRX8OkeKyxGAgni?=
 =?us-ascii?Q?8dZsqOtQj2YpOxEvMHCxBHKqWuS6lM9CFJxZTofqmTpwD7OQg+qHsi/TenLg?=
 =?us-ascii?Q?J0PECrWReCwR1EbK0IIUfTZYWc5qtdUhNoyrbDbiGd8YILaLGF3DwIvb32GT?=
 =?us-ascii?Q?QL5oVdFqcCP6XpfY1RpClDyLAJIDiLyRopQWekCbAIQeeY14/aLqAgqi4GUX?=
 =?us-ascii?Q?bPfphfER6WmeQOzKHDpvQVR9hmqaIYDGLPnflx5xzeD5nqbSXWJXKUvufQWz?=
 =?us-ascii?Q?4RsFUR6aM3fzsXbRUlVtqfMPkypoY7UBtcupeu3X0kMQQBraEYdWx2Qx7cjx?=
 =?us-ascii?Q?EkvCf2yt8xuQcKTp5IfoItpR8WyIR/2ynMJHTKM1RqJQnJaLIGiXt4yWCgoi?=
 =?us-ascii?Q?8d2nbkNL1MIB9ZjMHP+BAQKTYh7SA53jk2+1FqypTRNBWUArnZJkw0iSUM5z?=
 =?us-ascii?Q?qTlMVmeO07hYQVLC1XOIF3Tq0Y39iS3tSmT0y8uNec3WKRtyu2VctjM1jRMt?=
 =?us-ascii?Q?cya9X4HZWooew6sWvNz68FJ5Eh2ZIp8iDBtEC7oV67OcnT9Qr2Waur7cfWgz?=
 =?us-ascii?Q?GricnLfgWRJs8IqYQCV5Zhho1WuwIcuW7JiL7AZvCAAMtlcpW7jIrCydMsln?=
 =?us-ascii?Q?nL44IjV9Ghzq7lEUk2BOhToedj6VQVANLbyUeskDs4iIK6xB0s9mGGEcza0W?=
 =?us-ascii?Q?kHkaXYBAP9UijX+UMXQlpA1rhYYVriV3+LMg33nmFJvWW9onFJK8xKVl9nQM?=
 =?us-ascii?Q?UJRdqPUEv5vKY8hkPVV7K1FkhzuySmA/DUhF2QURrWM+TY9rJsUZVqqdWrfT?=
 =?us-ascii?Q?n4rOPfWiddaK/lxiJs8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2f4bce-b473-43d4-2f43-08dc3ed229f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:12:34.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDaSfweMRgzwTW+LbEJp6EBIZZimtA7yY3v7rYWNY78sx8dJIVSVVCqGW8nFiOJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

On Wed, Mar 06, 2024 at 06:41:35PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Swap pud entries do not always return true for pud_huge() for all archs.
> x86 and sparc (so far) allow it, but all the rest do not accept a swap
> entry to be reported as pud_huge().  So it's not safe to check swap entries
> within pud_huge().  Check swap entries before pud_huge(), so it should be
> always safe.
> 
> This is the only place in the kernel that (IMHO, wrongly) relies on
> pud_huge() to return true on pud swap entries.  The plan is to cleanup
> pXd_huge() to only report non-swap mappings for all archs.
> 
> Cc: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hmm.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -424,7 +424,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>  	walk->action = ACTION_CONTINUE;
>  
>  	pud = READ_ONCE(*pudp);
> -	if (pud_none(pud)) {
> +	if (pud_none(pud) || !pud_present(pud)) {

Isn't this a tautology? pud_none always implies !present() ?

Jason

