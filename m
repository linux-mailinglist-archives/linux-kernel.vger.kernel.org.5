Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894CA7A5678
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjISAIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 20:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISAIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 20:08:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5A97
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 17:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALVUcjxOalaQs4kGTOxxDuDDlAF6oH4RkZXTf1CKJ5uWkzoK64IQ4HssKc6NfPYPNIRMu5xyGprXIjES5L5mdMEgeRrFD6W+gcE0GEEv/SaJ+A8huEiv4rEeESjHunla9J3+p1NemhQJkFmasWqX4CQn3CdKa9aIeyFqSDzv3lwH1WhAmn+VJahYGYi4R75WctTSRd8dVimYxwz4VU8byjQQHzAPxgAJNk/25YO12LFsF/MadYCXovUpaApalS7E+3ZXFMSz7hLMIeoi30dpBmqAPHoYfg83MOasUZ79WocPfirZcK1/seMZhUhEjn+6Es2y3XnlYBNlj/Cd3gRG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z76VT7Bwh25VIejD0KpHvyOUCHRHrXH1Kj2hF2ENGc0=;
 b=AAGoDGsXo4Le/kgVJbtxbzmVDilepEhFr8wWPd+MaIRWIbZThpccWP1G+BeLb+vz+E2ny/dIih0o+mdWWpy+L1Mb0rNG2GRsk8uSLTDIVQ64ymfjGdyZR2XmKO/liBBGcqxfnSLFvaMGXxT48fSN7aaZ9BUqMi+qVlWok1Rgh8Yg5Zz1dzN+eMeboXy4PG/xqiw+FWzb6JCExjRLQ9Ndtay7R+RibartZK2lp2YT7YBZGzjA8z9tyqQE5uzA7FesJzdpMA5ZZghdGLZGsFTuw5mSbEcNKdryLnDpRgQHzMv8w6PNE/hAmQgQtY8i2V6mLy/sVvxwcVdFCmF/VNI8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z76VT7Bwh25VIejD0KpHvyOUCHRHrXH1Kj2hF2ENGc0=;
 b=U+DYFuYZZ+EQQmgN9b3VrNa2qfg3IoufO33lX3+K5fMVUuqujCgZEKGhsOO6M3vD4dcg1qnKMkrJ1btwHeXKrZQ8R84H+eLD4ts8D/83DuLJpbXnchB7fh/4HyZ4U6T58QbmbDpi29da+5b1VPSKrkH6uskpHJ3kUVtGROsw68O9LRpnn6xGd3zPgEldKIrk/AQKxByB5mvQgGCvkoT/gc+o5oHBFM5QRXAs528XHwaUrLGFaXi3Wy2aY0ZotHeB/Rf1bXZO8zqb++bGIPqmshY5YkaxA+6BweKJCbs6p4x2gzQurcNvPGqcbUgg8UjBXE7RnKvhWd9Sq6m0nOJIoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 00:08:31 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::2490:a17e:1d63:7505%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 00:08:31 +0000
References: <20230918201832.265108-1-jannh@google.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: document
 mmu_notifier_invalidate_range_start_nonblock()
Date:   Tue, 19 Sep 2023 10:08:06 +1000
In-reply-to: <20230918201832.265108-1-jannh@google.com>
Message-ID: <87bkdz58jq.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0116.ausprd01.prod.outlook.com
 (2603:10c6:10:1::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f27ae1e-2e31-4855-d3d4-08dbb8a48eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6i8/SM7dsZeHH/WMBpd9VV87vWzAEbIrYF21mwKVS1AeVLSqPetnBFQoVJEt73+HIiBa/v/NiC6TFTLh9Nj0n3xsmHP1Kt+sufvAaz/Npa1mA8ivn1zcTDubPujWJMaEEWMI+AtmL9I9vYjxsZV7NDb5+ohdM5bHOVRomu3jg8Lc6WYI9ajxNuAgm4uKoKeORCtHqle/KfJmsF6MCA2J1oiArircKbnl2Gz3Lnc9/R7qr8APt8NV4Z33+yHStzxIGbhufRFDPaXRF14/QoePLvf4eYIO36KDKDpj1s5cxVV65WZkGstSnL5aGuAAYaHRoASqrCmm3DFpPmkFGZYCy28ZaX1EOOGCgESGnSEOxvRFHGKiqayMgUEZ9z3L5sUXa44uQrAG3+5Rb/JYuutGyTd9uFKUN6qelzcGEWK9tu5TpnxFYA1vF3uQNDErN1Tuahf08/Q3sGHttGyXegZlQb2YuNcgQ/JEqEiI2CdvM2QcDOzAm5IDuB0ksGjJq2uDcgi/nf/YNkNSX1+zqZsAE31iGU3hhYg3vu3Aek/W80axRaCM6PzMjWEqzRgsvgEL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(451199024)(8676002)(8936002)(316002)(6916009)(41300700001)(26005)(2906002)(478600001)(66946007)(66556008)(66476007)(54906003)(4326008)(5660300002)(6506007)(6486002)(9686003)(6512007)(83380400001)(6666004)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iyktlHHnm/Yq3C9PCCBYd+2lpBYb7NLV2702yPAlwwgGZKGiNRHcbCO974ZK?=
 =?us-ascii?Q?5tyUiV3WJkdSCsAVQ+6yUujZ+PfBlQSlthajJ4ToFd+pGMCbRuomwCjZ0jKl?=
 =?us-ascii?Q?+ZU0u4hak20+EzLhXaa5ZWMrDWkU3e7Ifia4YxcM7sEGMmOGR6MQ8OxQlBsK?=
 =?us-ascii?Q?qiOIlcOYCqKFondwlMqdc4cxb76hje3XrEbZnpG7hxqRWfcBTUHUICI8MyDz?=
 =?us-ascii?Q?muGYrWx7NiI7tjhrhxJcOh2YBjtLjYmoiJbptqFiRCaow+z4EBlxUBhEZMJg?=
 =?us-ascii?Q?D6Gt0ZXGTN6HGg8nrRXGSt2njGu1EEhCC4AT4RHBkWAlzWwzfUJBFtHc2KQU?=
 =?us-ascii?Q?hVBNZTuXpcmjNrLTA/hELNaAjfLBpQidobzbMVS4phByTiQMYYckj0o7MUli?=
 =?us-ascii?Q?Gg1oAPvW19HK2oyWLlDuwwn+FJ4PrACKrnQFXZ0SM1JsRpTNloupmUG3VYYC?=
 =?us-ascii?Q?tlnU2XcuTwpq+6ZwI7REskP3TGqfj0TyCKIPJrmMa/nbW44VxQE1AVANaS5D?=
 =?us-ascii?Q?wmqujJCEHKCencLm3TRAkrzhC+xUfIUGSsaOnIL429KEqOJC8rj5iU7dEm08?=
 =?us-ascii?Q?0WSgbdxH52+rA17R5VGmWP49AmtVCRECwzDDbYXPh/713UnOG3fkZlvmQIj2?=
 =?us-ascii?Q?uSAbb3HjYQacpMI/nrpuZPKstQO2jXniDwQlyIz9TnsjSaB3J0Or3+jU/cYy?=
 =?us-ascii?Q?dVtiM4odalmyYIskI3GrL0sKmh1fM86vkbHxWUJTcCCY7oQlwvJ0v0oJ9lQy?=
 =?us-ascii?Q?dmPNY9A2hNGlvNVMKT0u3PNBgbMIsjlZnfn5Ji2tvWve61FVoecZAqzDmgmR?=
 =?us-ascii?Q?ayP8O/fis/pZo+UQu7kdTxs+Ydteky91E4LDpbLj8ZrHET4BdURCH3iVXtXv?=
 =?us-ascii?Q?Favxwydc0YTIp0gU9W+ryaQAuMScM9d023DqmTDUR5rcdfBRvjmW27dAS+Jo?=
 =?us-ascii?Q?AivsKmvTZVvBn/p9qQWQ95Qtlb4KfFntDOH+o6ky0D64Cyfg3jcbDYCk+57v?=
 =?us-ascii?Q?E+FUed19kdyQ7zah1Hy1lsIb238mhRp85JUACR7XvguGghddyZT57tgegP6+?=
 =?us-ascii?Q?vchlBQNANdhWxewcmmv448zd2WWmsK/GPLhD6xtCAk/VTTZdfH57InNo+L6Q?=
 =?us-ascii?Q?hKHbPnqrMfv7SHlmgcuc4h9hu276xnr62pq7lgA5mcG6piRpqV5e1xFL0OQe?=
 =?us-ascii?Q?mmeVni/guDtGVbbct+xlAj+JK30CAZOUgmhbZMK7f2ziXTd4iSbkK7rSJXK3?=
 =?us-ascii?Q?cZmLeFMfB1Aph0ex/3QQwQHl6PKenCG2jO6eyNhHaO0JRYQH2cM85ByUV4Qw?=
 =?us-ascii?Q?54c5ZAkZV/pHhGXoSLrtxow378rlwMZ2jYCMWOo6dkGYkbtWfboZ8iOPvxww?=
 =?us-ascii?Q?Q6sq2UYQPEaB/vvFpPM7MU+vZLBEMy1e6O6JYyOH2n5jj805v6RPzUGKid3h?=
 =?us-ascii?Q?cqlO5UV2QNI2G+0J/Dd576+khIXd/wgKRF0dAEJJrIK1w/QLY1OzGWO/lgab?=
 =?us-ascii?Q?dJ+5+dzyydegL2NPZZlFZj+DkUZcdp/XEtR8QyC4UpYLcti8Yil8iHEA2d0o?=
 =?us-ascii?Q?JUSkmP+U9+XhnYvoY0KK8S8zhA6takOXPRtM/rTu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f27ae1e-2e31-4855-d3d4-08dbb8a48eb3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 00:08:31.2770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO+2xzMLMS4Lvo4k6ErkCC2L3NMXs8SlgVNNoKN0lrge6QWMrAVSIUCqjQe3VNPbx9HWP92YvcdR3g4a9XjcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good, thanks.

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Jann Horn <jannh@google.com> writes:

> Document what mmu_notifier_invalidate_range_start_nonblock() is for.
> Also add a __must_check annotation to signal that callers must bail out if
> a notifier vetoes the operation.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/mmu_notifier.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 6e3c857606f1..f349e08a9dfe 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -459,7 +459,14 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  }
>  
> -static inline int
> +/*
> + * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
> + * can return an error if a notifier can't proceed without blocking, in which
> + * case you're not allowed to modify PTEs in the specified range.
> + *
> + * This is mainly intended for OOM handling.
> + */
> +static inline int __must_check
>  mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
>  {
>  	int ret = 0;
>
> base-commit: 6704c78e2963a5682b4ac3c0e609d36f2405cf17

