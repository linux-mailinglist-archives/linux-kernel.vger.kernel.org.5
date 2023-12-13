Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B089C812230
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 23:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjLMW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 17:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjLMW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 17:57:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864AFCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702508274; x=1734044274;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XQaWesZMJUArsxWWGZj09uOnYpj5VTzPV+rq4UAz69w=;
  b=ZNh7JUxd8E/yWjRrpR6t9NUOzDkek0yuVPf8H96nd0tkeaqXjQmvQRBm
   lQ2WDLzr6QKq6YXxu9E9RWt3610h0p9mDs4DK/52rgxX5EX0ZlhEYhZe8
   O6OfU3LiiInp3metpAAbWAwFA+61g66Cmt/kavOPqZgnUNVppDJUypmrc
   sgT6n5I/3eCLOWtshNmPtfOyq/ca6cl1mcZSVbnuS+FAFgf9JasoBEbAv
   qIesk9ITjQFVBChVj/wW8nrFlCd2MFz2wkmDi5JNgW9mPiBZLnGESKKiy
   ptUPTDqcgg6ebF4iBLYRn3YS/fLibLoOlJzNm3bQaEd62sR/Kw9kbS1Ny
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397822516"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="397822516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:57:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774121698"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="774121698"
Received: from wanghuan-mobl1.amr.corp.intel.com (HELO [10.212.178.119]) ([10.212.178.119])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:57:54 -0800
Message-ID: <3c7d9b8878220571cb7e0760c3a463951252b762.camel@linux.intel.com>
Subject: Re: [PATCH] mm: remove redundant lru_add_drain() prior to unmapping
 pages
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jianfeng Wang <jianfeng.w.wang@oracle.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Dec 2023 14:57:53 -0800
In-Reply-To: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
References: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 23:28 -0800, Jianfeng Wang wrote:
> When unmapping VMA pages, pages will be gathered in batch and released by
> tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
> tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
> which calls lru_add_drain() to drain cached pages in folio_batch before
> releasing gathered pages. Thus, it is redundant to call lru_add_drain()
> before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
>=20
> Remove lru_add_drain() prior to gathering and unmapping pages in
> exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.
>=20
> Note that the page unmapping process in oom_killer (e.g., in
> __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
> redundant lru_add_drain(). So, this commit makes the code more consistent=
.
>=20
> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> ---
>  mm/mmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1971bfffcc03..0451285dee4f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2330,7 +2330,9 @@ static void unmap_region(struct mm_struct *mm, stru=
ct ma_state *mas,
>  	struct mmu_gather tlb;
>  	unsigned long mt_start =3D mas->index;
> =20
> +#ifdef CONFIG_MMU_GATHER_NO_GATHER

In your comment you say skip lru_add_drain() when CONFIG_MMU_GATHER_NO_GATH=
ER
is *not* set.  So shouldn't this be

#ifndef CONFIG_MMU_GATHER_NO_GATHER ?

>  	lru_add_drain();
> +#endif
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
>  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
> @@ -3300,7 +3302,9 @@ void exit_mmap(struct mm_struct *mm)
>  		return;
>  	}
> =20
> +#ifdef CONFIG_MMU_GATHER_NO_GATHER

same question as above.

>  	lru_add_drain();
> +#endif
>  	flush_cache_mm(mm);
>  	tlb_gather_mmu_fullmm(&tlb, mm);
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */

