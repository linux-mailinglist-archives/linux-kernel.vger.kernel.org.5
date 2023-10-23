Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEC97D3F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjJWSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjJWSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:34:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8918E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sba/6KUMGO49+Y34o7EFNNBnwbyDigMcwGdKPbGeJIIkE74gYmDs6ALh/9PqGzFcL7lTjatowRRorO3f+mnE8GOpNFZeLVWhQ/KvUDhjo8S9/q6MkJmHfVoJuOQC36qI2x8fBY7Q+oXB0xZHqbuD7zpHbVus3MYBJED1ZAn3X+viiWm68uYUmq7qQ6GHldq9V/cAQJSe4rULZpdcDgP7xOB2giNB0y7e4I6yH6EQrEKvBOePMd/YmVa+zimnfqFWWiG6B0LjCcCiGh+VAtOJJ2bgOV8mGC3nBmcpLsTtVNf3Rx88hDpJptHQk8LvRRcvB3RcuS0IGW5Ayh3qKsV1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D2E0WAdjL2R7Q4fhp4KtNfFFSbhKoDmAiPK7PmIsPU=;
 b=M+TQbs2Eq78yNq3t4dDnb+MwdTce4gSECL4Za28YAD3DYrl4PwDURJIpnPwUENh6QKT9UqHIHYmsMvWcKc3v+ir5muJNA3FlVXBvBLHpywc5Sla59xZv1xk81J/UCD/pQ7xbSWggZARMTNH8qapvat6ND6MkboIBaf/vRNiaC/RO9KBFlFzeOMr+jKiX72rZKciWs9WZSuiQ9OFDdODyUoPxoj86NtTnsnvjtRAnt0PK6g+kxnCDoc02P3MbouON96J/aGcSiUMPS5UVzzR1NWA9Tzg0h+gDuame2u9BLr9Z8m496+QfZ5RB0gOg2SbNnsKSZyOz62PclMjWTOK0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D2E0WAdjL2R7Q4fhp4KtNfFFSbhKoDmAiPK7PmIsPU=;
 b=CV+PaQavKDhxJw6nXGpM42gwean3UJTU0+iOV5J1a9WfNodf7lB9/Ve3uPCfh79tpcXO4UyvIrHGOoo1tKlagmB9Zr5Q34UFaH7M9AIbs0ChQe2jPcpGWQpr/g48WkiMqSzVnGKwMbuVpYEFM65z/YCuGSGL4bpPNhZgaClM7VKlvKkCTlOHT+iAWUvi0joC7XLWSy6MOg2cP6xgfnPFAILBYWVHQouUzoP42nL5SUIAgjpsS0znSZQD8HLqOYlLDBmUPC78HKLIDZCWqynS3tqz24QYgNoGsZh8VBGWCirPcYXWi0ojzZaLJJ2Nvn5UMamgWM+6ht84lsDiSouusA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.24; Mon, 23 Oct 2023 18:34:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b90d:78a0:f664:ffd2%3]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 18:34:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        "\"Huang, Ying\"" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
Date:   Mon, 23 Oct 2023 14:34:33 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <61FB8BFF-E3CB-4C99-8A6D-845A69E4E76F@nvidia.com>
In-Reply-To: <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <74e34633-6060-f5e3-aee-7040d43f2e93@google.com>
 <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_80759634-1D42-4C8C-8F34-A08FF7846968_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:208:32a::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: ef89b12e-02ef-4354-8ceb-08dbd3f6b571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HRhIeWFDww8Fh3hV/ySYTtYwyhHknV9lGmngIyEunOfY4j+kimdyY4LULWFeXx2xU+8eV/dYJFSJgPs+gWaMs++al05Cz+C2cc759dJy7gYzeURFfVOVaU8jeWfzYr9+ZRRmBKhb7al0hgZO4TzM8NoOX9ng++z4XkFnlleM5T9C0nb7o89SB/hC7sj9lhpwL4kUK2Tk1P/7dsgVoOwOKOSaNxJVYKfjWz8Zf1maxdcLy84tfhlVE1oemG+fqlG/f6ys0GoUr5kHOwH03hDzNELiwkIyFTE70INDMGVb5zJAgOhXyDpMI9689Li2oHtQtYO4ik5mjoURO3B9RIFIOs7N+N1RwjlhTbfdw0I36eB2R/asJ9TrJhnsQlIA5b5GtWuyTAEJF4Bdwv7sIDIVSJQjf22Iqr+GSqmEeUG/+tisHp5fURBoKtPpBc6rJ69M9LDBRdjWU++QDBuJFmbtIJs5n+IsmVRLQrukIS62knCXdaWtlJCDQ1rQfsTi0iInqoHD9sdM1pyrRnyJ15XVcZoDORR4thUHu/WfNnHmOXoS5SSUTd4xRBvBfPLpVjUCUbx9BkL8Af9IpO0rESszITjEx6OXqcpQJyKclTsOgTBu6Ytt3H7rMW0MLJTziRgXQrnJ5aHyqWLVZyX8AEUUDc/FLvsEVTYO8Lcz4EtGJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(66476007)(36756003)(2616005)(2906002)(30864003)(7416002)(83380400001)(6512007)(86362001)(26005)(6506007)(53546011)(4326008)(38100700002)(235185007)(33656002)(41300700001)(6486002)(5660300002)(478600001)(8676002)(8936002)(6916009)(66946007)(54906003)(966005)(316002)(6666004)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09uLx6jZxmaHyxBErL9fKAjiI2cAzzQjTVRZLGzkTRvGzG2LxJ4TV6Gf9neq?=
 =?us-ascii?Q?OFiwS8rfwzZqm1lMCgXGIjAjpGiRXAcygb2xm9zCPMGWt8HEO5XHRU3l/zRO?=
 =?us-ascii?Q?3yNKXsRAV71Gk/Zf/ruunNgW96GiwBREJw2zXFLoc7nQME1+4lJlsHFeZUFe?=
 =?us-ascii?Q?D8e3t3+3NoBb/umcuLZgjkz427nJmmXvmPTca5DOh5OBhIuqr1jcpvJ4/avh?=
 =?us-ascii?Q?2FbCSZhhH1zBSIEsrzXuQwCbMrTZ2HF45VYr9kFuFiXof5yOun2oJDPx2bjK?=
 =?us-ascii?Q?AXR8nVOkj2TPK279/K9JdReP3Xud+FLmTQyOdTkiu/PmTy5uitcSnJZTokTz?=
 =?us-ascii?Q?+G9MVAJIltmqrkQxE0taZGULV4O4dAvlBIuH1FzvEvDFO/J3WdVXbiEIUJ/7?=
 =?us-ascii?Q?O6Abfnsm7rgLkJYvbrUPR3mjSRBUzud9sLaTBrwiyOhcqfBJQ4w6jkVJHZBY?=
 =?us-ascii?Q?zVCdMhydAACVXKAqy34v/r/xCRcjrXT8h3UfY9aeen9IknKEaANZGA3pzTie?=
 =?us-ascii?Q?VUbq+tP1aeYlG4JNlU5eD4yu8Q6pCd4HONguA8PLBUAOeefbwpnkCoi69Pah?=
 =?us-ascii?Q?M4L++MfVZ8e8Uxw5xGaw/7VZqEquF35kgRUB5wn7exfiRAuGXiQWdEeendlJ?=
 =?us-ascii?Q?O1Vmvjk/VelT2e+Q6iUy4Qa271IIOYRFWrEDBTRKbdvBY+S3IKOOl6yYks0R?=
 =?us-ascii?Q?1W/PAJgYyoQKxDNZrIO418xqyRYKuCKfb8+Cw63gxmSzvftMuM32UBfo+jat?=
 =?us-ascii?Q?bK52r5l027a8Vkblpv2Vb2hhCUOij6s1gFljFCwvjWPjxWnmY6lH0T4uBUw6?=
 =?us-ascii?Q?+qK/T+HzV4UCzXBKAPbOepEbczzgTDhWfzyitjKMEGG4Fjy+2SEo6XuzgWov?=
 =?us-ascii?Q?c7YcT8NLML+WoXryHw66Rkqz8PBDLfdESucRCsG/fSK1ALd0GRlmW+YZRmRq?=
 =?us-ascii?Q?ZmIOlCpM1ZZfKJNDdJHs3Lr3AJkAIy6KnHLAGltn1m0jy4eFxtbFTGI4LYlk?=
 =?us-ascii?Q?ytdEzpdF6KcJWdLT3KMRuIb+48HMHC2qL6csrcrWgMeiZJGYir9eRZDPypBy?=
 =?us-ascii?Q?V9lJufmwRXdnHPdJsz05LQcRh3gIQ8JhIkJb/J96w+oFP6xyIIVVsgREfLxf?=
 =?us-ascii?Q?0loV5ZVYHOgP/QC4v6Mhsm70x4Gm1CBqABSwkf3eAZw6AKma2sRTO73vZwQX?=
 =?us-ascii?Q?mfYaXwiYRdXnHc3ceqbKpON0L9VoEGwXypC30FNlFxlDStmY5j+TbXwR40Nz?=
 =?us-ascii?Q?cJWIeGSP+FSrCa6M5bbCrhMHuWrDRpC4aa9rVB0ix19guoCwxq8HrvaKMMX5?=
 =?us-ascii?Q?qaY60ttrQZ8ba902EhOkcHj3Kf5dPCAXUYrLE/KozBWtufdGWDtll/Oo4vnr?=
 =?us-ascii?Q?TANbiCLgTDNZjcvlelZdSku1lTum5w6Qywm+BvnF7WsUNCGLjDzwRA5iTPC4?=
 =?us-ascii?Q?9AF9Lh7+7BXamYvnItCWubAm7R+26CJfiG1XuSa/c3LiuZE1USXt4RTRBa35?=
 =?us-ascii?Q?DSOMbz4GTlRGUV+edcxd8UrbUAYn/hk/HQR/pr7dCdhMJpuM5Rr+stXnY7fA?=
 =?us-ascii?Q?9vmODa2BC1B8wWulZCE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89b12e-02ef-4354-8ceb-08dbd3f6b571
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:34:36.4318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ki5qUV/WIo9z4WBSknXve++S347e0q7lGFfUQUPf4zzfLR4MLbDLPohueme9C9Fp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_80759634-1D42-4C8C-8F34-A08FF7846968_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Oct 2023, at 16:39, Hugh Dickins wrote:

> Shrink shmem's stack usage by eliminating the pseudo-vma from its folio=

> allocation.  alloc_pages_mpol(gfp, order, pol, ilx, nid) becomes the
> principal actor for passing mempolicy choice down to __alloc_pages(),
> rather than vma_alloc_folio(gfp, order, vma, addr, hugepage).
>
> vma_alloc_folio() and alloc_pages() remain, but as wrappers around
> alloc_pages_mpol().  alloc_pages_bulk_*() untouched, except to provide =
the
> additional args to policy_nodemask(), which subsumes policy_node().
> Cleanup throughout, cutting out some unhelpful "helpers".
>
> It would all be much simpler without MPOL_INTERLEAVE, but that adds a
> dynamic to the constant mpol: complicated by v3.6 commit 09c231cb8bfd
> ("tmpfs: distribute interleave better across nodes"), which added ino b=
ias
> to the interleave, hidden from mm/mempolicy.c until this commit.
>
> Hence "ilx" throughout, the "interleave index".  Originally I thought i=
t
> could be done just with nid, but that's wrong: the nodemask may come fr=
om
> the shared policy layer below a shmem vma, or it may come from the task=

> layer above a shmem vma; and without the final nodemask then nodeid can=
not
> be decided.  And how ilx is applied depends also on page order.
>
> The interleave index is almost always irrelevant unless MPOL_INTERLEAVE=
:
> with one exception in alloc_pages_mpol(), where the NO_INTERLEAVE_INDEX=

> passed down from vma-less alloc_pages() is also used as hint not to use=

> THP-style hugepage allocation - to avoid the overhead of a hugepage arg=

> (though I don't understand why we never just added a GFP bit for THP - =
if
> it actually needs a different allocation strategy from other pages of t=
he
> same order).  vma_alloc_folio() still carries its hugepage arg here, bu=
t
> it is not used, and should be removed when agreed.
>
> get_vma_policy() no longer allows a NULL vma: over time I believe we've=

> eradicated all the places which used to need it e.g.  swapoff and madvi=
se
> used to pass NULL vma to read_swap_cache_async(), but now know the vma.=

>
> Link: https://lkml.kernel.org/r/74e34633-6060-f5e3-aee-7040d43f2e93@goo=
gle.com
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tejun heo <tj@kernel.org>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---
> Rebased to mm.git's current mm-stable, to resolve with removal of
> vma_policy() from include/linux/mempolicy.h, and temporary omission
> of Nhat's ZSWAP mods from mm/swap_state.c: no other changes.
>
> git cherry-pick 800caf44af25^..237d4ce921f0 # applies mm-unstable's 01-=
09
> then apply this "mempolicy: alloc_pages_mpol() for NUMA policy without =
vma"
> git cherry-pick e4fb3362b782^..ec6412928b8e # applies mm-unstable's 11-=
12
>
>  fs/proc/task_mmu.c        |   5 +-
>  include/linux/gfp.h       |  10 +-
>  include/linux/mempolicy.h |  13 +-
>  include/linux/mm.h        |   2 +-
>  ipc/shm.c                 |  21 +--
>  mm/mempolicy.c            | 383 +++++++++++++++++++-------------------=
--------
>  mm/shmem.c                |  92 ++++++-----
>  mm/swap.h                 |   9 +-
>  mm/swap_state.c           |  86 +++++++----
>  9 files changed, 299 insertions(+), 322 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1d99450..66ae1c2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2673,8 +2673,9 @@ static int show_numa_map(struct seq_file *m, void=
 *v)
>  	struct numa_maps *md =3D &numa_priv->md;
>  	struct file *file =3D vma->vm_file;
>  	struct mm_struct *mm =3D vma->vm_mm;
> -	struct mempolicy *pol;
>  	char buffer[64];
> +	struct mempolicy *pol;
> +	pgoff_t ilx;
>  	int nid;
>
>  	if (!mm)
> @@ -2683,7 +2684,7 @@ static int show_numa_map(struct seq_file *m, void=
 *v)
>  	/* Ensure we start with an empty set of numa_maps statistics. */
>  	memset(md, 0, sizeof(*md));
>
> -	pol =3D __get_vma_policy(vma, vma->vm_start);
> +	pol =3D __get_vma_policy(vma, vma->vm_start, &ilx);
>  	if (pol) {
>  		mpol_to_str(buffer, sizeof(buffer), pol);
>  		mpol_cond_put(pol);
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 665f066..f74f8d0 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -8,6 +8,7 @@
>  #include <linux/topology.h>
>
>  struct vm_area_struct;
> +struct mempolicy;
>
>  /* Convert GFP flags to their corresponding migrate type */
>  #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
> @@ -262,7 +263,9 @@ static inline struct page *alloc_pages_node(int nid=
, gfp_t gfp_mask,
>
>  #ifdef CONFIG_NUMA
>  struct page *alloc_pages(gfp_t gfp, unsigned int order);
> -struct folio *folio_alloc(gfp_t gfp, unsigned order);
> +struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
> +		struct mempolicy *mpol, pgoff_t ilx, int nid);
> +struct folio *folio_alloc(gfp_t gfp, unsigned int order);
>  struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_str=
uct *vma,
>  		unsigned long addr, bool hugepage);
>  #else
> @@ -270,6 +273,11 @@ static inline struct page *alloc_pages(gfp_t gfp_m=
ask, unsigned int order)
>  {
>  	return alloc_pages_node(numa_node_id(), gfp_mask, order);
>  }
> +static inline struct page *alloc_pages_mpol(gfp_t gfp, unsigned int or=
der,
> +		struct mempolicy *mpol, pgoff_t ilx, int nid)
> +{
> +	return alloc_pages(gfp, order);
> +}
>  static inline struct folio *folio_alloc(gfp_t gfp, unsigned int order)=

>  {
>  	return __folio_alloc_node(gfp, order, numa_node_id());
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index acdb12f..2801d5b 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -126,7 +126,9 @@ struct mempolicy *mpol_shared_policy_lookup(struct =
shared_policy *sp,
>
>  struct mempolicy *get_task_policy(struct task_struct *p);
>  struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
> -		unsigned long addr);
> +		unsigned long addr, pgoff_t *ilx);
> +struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> +		unsigned long addr, int order, pgoff_t *ilx);
>  bool vma_policy_mof(struct vm_area_struct *vma);
>
>  extern void numa_default_policy(void);
> @@ -140,8 +142,6 @@ extern int huge_node(struct vm_area_struct *vma,
>  extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
>  extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
>  				const nodemask_t *mask);
> -extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy=
);
> -
>  extern unsigned int mempolicy_slab_node(void);
>
>  extern enum zone_type policy_zone;
> @@ -213,6 +213,13 @@ static inline void mpol_free_shared_policy(struct =
shared_policy *sp)
>  	return NULL;
>  }
>
> +static inline struct mempolicy *get_vma_policy(struct vm_area_struct *=
vma,
> +				unsigned long addr, int order, pgoff_t *ilx)
> +{
> +	*ilx =3D 0;
> +	return NULL;
> +}
> +
>  static inline int
>  vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)=

>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 86e040e..b4d67a8 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -619,7 +619,7 @@ struct vm_operations_struct {
>  	 * policy.
>  	 */
>  	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
> -					unsigned long addr);
> +					unsigned long addr, pgoff_t *ilx);
>  #endif
>  	/*
>  	 * Called by vm_normal_page() for special PTEs to find the
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 576a543..222aaf0 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -562,30 +562,25 @@ static unsigned long shm_pagesize(struct vm_area_=
struct *vma)
>  }
>
>  #ifdef CONFIG_NUMA
> -static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy=
 *new)
> +static int shm_set_policy(struct vm_area_struct *vma, struct mempolicy=
 *mpol)
>  {
> -	struct file *file =3D vma->vm_file;
> -	struct shm_file_data *sfd =3D shm_file_data(file);
> +	struct shm_file_data *sfd =3D shm_file_data(vma->vm_file);
>  	int err =3D 0;
>
>  	if (sfd->vm_ops->set_policy)
> -		err =3D sfd->vm_ops->set_policy(vma, new);
> +		err =3D sfd->vm_ops->set_policy(vma, mpol);
>  	return err;
>  }
>
>  static struct mempolicy *shm_get_policy(struct vm_area_struct *vma,
> -					unsigned long addr)
> +					unsigned long addr, pgoff_t *ilx)
>  {
> -	struct file *file =3D vma->vm_file;
> -	struct shm_file_data *sfd =3D shm_file_data(file);
> -	struct mempolicy *pol =3D NULL;
> +	struct shm_file_data *sfd =3D shm_file_data(vma->vm_file);
> +	struct mempolicy *mpol =3D vma->vm_policy;
>
>  	if (sfd->vm_ops->get_policy)
> -		pol =3D sfd->vm_ops->get_policy(vma, addr);
> -	else if (vma->vm_policy)
> -		pol =3D vma->vm_policy;
> -
> -	return pol;
> +		mpol =3D sfd->vm_ops->get_policy(vma, addr, ilx);
> +	return mpol;
>  }
>  #endif
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 596d580..8df0503 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -114,6 +114,8 @@
>  #define MPOL_MF_INVERT       (MPOL_MF_INTERNAL << 1)	/* Invert check f=
or nodemask */
>  #define MPOL_MF_WRLOCK       (MPOL_MF_INTERNAL << 2)	/* Write-lock wal=
ked vmas */
>
> +#define NO_INTERLEAVE_INDEX (-1UL)
> +
>  static struct kmem_cache *policy_cache;
>  static struct kmem_cache *sn_cache;
>
> @@ -898,6 +900,7 @@ static long do_get_mempolicy(int *policy, nodemask_=
t *nmask,
>  	}
>
>  	if (flags & MPOL_F_ADDR) {
> +		pgoff_t ilx;		/* ignored here */
>  		/*
>  		 * Do NOT fall back to task policy if the
>  		 * vma/shared policy at addr is NULL.  We
> @@ -909,10 +912,7 @@ static long do_get_mempolicy(int *policy, nodemask=
_t *nmask,
>  			mmap_read_unlock(mm);
>  			return -EFAULT;
>  		}
> -		if (vma->vm_ops && vma->vm_ops->get_policy)
> -			pol =3D vma->vm_ops->get_policy(vma, addr);
> -		else
> -			pol =3D vma->vm_policy;
> +		pol =3D __get_vma_policy(vma, addr, &ilx);
>  	} else if (addr)
>  		return -EINVAL;
>
> @@ -1170,6 +1170,15 @@ static struct folio *new_folio(struct folio *src=
, unsigned long start)
>  			break;
>  	}
>
> +	/*
> +	 * __get_vma_policy() now expects a genuine non-NULL vma. Return NULL=

> +	 * when the page can no longer be located in a vma: that is not ideal=

> +	 * (migrate_pages() will give up early, presuming ENOMEM), but good
> +	 * enough to avoid a crash by syzkaller or concurrent holepunch.
> +	 */
> +	if (!vma)
> +		return NULL;
> +

How often would this happen? I just want to point out that ENOMEM can cau=
se
src THPs or large folios to be split by migrate_pages().

>  	if (folio_test_hugetlb(src)) {
>  		return alloc_hugetlb_folio_vma(folio_hstate(src),
>  				vma, address);
> @@ -1178,9 +1187,6 @@ static struct folio *new_folio(struct folio *src,=
 unsigned long start)
>  	if (folio_test_large(src))
>  		gfp =3D GFP_TRANSHUGE;
>
> -	/*
> -	 * if !vma, vma_alloc_folio() will use task or system default policy
> -	 */
>  	return vma_alloc_folio(gfp, folio_order(src), vma, address,
>  			folio_test_large(src));
>  }


--
Best Regards,
Yan, Zi

--=_MailMate_80759634-1D42-4C8C-8F34-A08FF7846968_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmU2vLkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUYV8P/3/x0TCOro0Y21Sggw9M+0ex/ZmtpbETOG8y
FfXzLiZZAzMxR5mmI64AtcqwH5ms02F3BeG9eTfg9ahUlkYiLDMvblK71e1+FNUe
ASrhLn/m/vkPgcYyH6q1I6j0Q9fvjkQrMs27stx2GShkBU8IMGylADIq2rmK346E
0vZFGG9hgJaazBjXnGL0E12FF7AadV9OmeVXh8jPhP20m6Eb7BXPZUn8lh1ruwZI
tfby9WGnIcvwbzM7uk18TOev4euWTc0JHtGGYlgyjEdfbCdLHGsaiaYODM8EiRgp
jDjFX5SViAIkZSH9cFNiv8ugYSQatuDDTFmFeBOZ9fFSo6coosp2JJWluDmoJhmt
ybEpV8qp/WyqYsRzDlrJQT1FgYNL1X2xYxFqQo9eJZXD00mRk1q/LG3LPKr/yRLU
r55T1wnpatOilsfGU4ROuntRPZ2V3B/nVKpXdFDM1ECGwha2LK7xJVIBjFqA7DFL
bBMpo9nb/w65cT1ef0EAx7OYDzAiSPPD5GM/tJnNENCXjuzgXcg8BmpeaALYX3v8
ivLXsHXqrn3b+gW8b6/H1K/lszsRfBylxfqigK01bsGKvec78QxrXmOkJdwIP3bQ
qO1fBebRTrjo+EauVGcJJ+t4tr2We8RkrrK7efBD51bSj0YmtodBVVZS89qvf7rd
QM1jR3ah
=yu0e
-----END PGP SIGNATURE-----

--=_MailMate_80759634-1D42-4C8C-8F34-A08FF7846968_=--
