Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9106E813935
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjLNR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjLNR5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:57:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40E124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702576662; x=1734112662;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fNGLTdSt0U0vp5H92ugUMf6iM40RklxGBua+2WTEdjY=;
  b=HRX19mAavjxzXNIH96YKntOEZWhKC3dIoQho2vPqdy7ZDAOf4cdTEIJK
   C6HqeyVsM+HKH4ANwCt8XA9W0dIEmzO5pAMEYuRv3Oy025Um10w/AhjCK
   FGrCDxf+QAQdeujDLADAD/GTafT/YUOs7cfvJ7cKF+L5KviMT63e+3J6o
   G4pkB3tZT3U8is3B16pgfgWruMqOmqCjC+lbB9clINgEZJJ+2EzX8GGRJ
   R/YQt0CqtUwqpaEt32CCrdLIML9IIwe9piyNMga6m+p50gQTA/k7nMoz0
   J9L7IduC5nhU+StuKg8GkyHjUKCR1/KFIBTax6hyt2z7xhe1AqYQelMsf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8516312"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="8516312"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="17723053"
Received: from priyammi-mobl.amr.corp.intel.com (HELO [10.209.30.248]) ([10.209.30.248])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 09:57:40 -0800
Message-ID: <962b75502b6456a8b698a4ca89d6deedec118ef6.camel@linux.intel.com>
Subject: Re: [PATCH] mm: remove redundant lru_add_drain() prior to unmapping
 pages
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jianfeng Wang <jianfeng.w.wang@oracle.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Dec 2023 09:57:39 -0800
In-Reply-To: <d9284139-e32e-493c-86ea-77130b503a77@oracle.com>
References: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
         <3c7d9b8878220571cb7e0760c3a463951252b762.camel@linux.intel.com>
         <d9284139-e32e-493c-86ea-77130b503a77@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-13 at 17:03 -0800, Jianfeng Wang wrote:
> On 12/13/23 2:57 PM, Tim Chen wrote:
> > On Tue, 2023-12-12 at 23:28 -0800, Jianfeng Wang wrote:
> > > When unmapping VMA pages, pages will be gathered in batch and release=
d by
> > > tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The funct=
ion
> > > tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache=
(),
> > > which calls lru_add_drain() to drain cached pages in folio_batch befo=
re
> > > releasing gathered pages. Thus, it is redundant to call lru_add_drain=
()
> > > before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.
> > >=20
> > > Remove lru_add_drain() prior to gathering and unmapping pages in
> > > exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not =
set.
> > >=20
> > > Note that the page unmapping process in oom_killer (e.g., in
> > > __oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
> > > redundant lru_add_drain(). So, this commit makes the code more consis=
tent.
> > >=20
> > > Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> > > ---
> > >  mm/mmap.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 1971bfffcc03..0451285dee4f 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2330,7 +2330,9 @@ static void unmap_region(struct mm_struct *mm, =
struct ma_state *mas,
> > >  	struct mmu_gather tlb;
> > >  	unsigned long mt_start =3D mas->index;
> > > =20
> > > +#ifdef CONFIG_MMU_GATHER_NO_GATHER
> >=20
> > In your comment you say skip lru_add_drain() when CONFIG_MMU_GATHER_NO_=
GATHER
> > is *not* set.  So shouldn't this be
> >=20
> > #ifndef CONFIG_MMU_GATHER_NO_GATHER ?
> >=20
> Hi Tim,
>=20
> The mmu_gather feature is used to gather pages produced by unmap_vmas() a=
nd
> release them in batch in tlb_finish_mmu(). The feature is *on* if
> CONFIG_MMU_GATHER_NO_GATHER is *not* set. Note that: tlb_finish_mmu() wil=
l call
> free_pages_and_swap_cache()/lru_add_drain() only when the feature is on.

Thanks for the explanation.

Looking at the code, lru_add_drain() is executed for #ifndef CONFIG_MMU_GAT=
HER_NO_GATHER
in tlb_finish_mmu(). So the logic of your patch is fine.
=C2=A0
The #ifndef CONFIG_MMU_GATHER_NO_GATHER means
mmu_gather feature is on.  The double negative throws me off on in my first=
 read
of your commit log.

Suggest that you add a comment in code to make it easier for
future code maintenence:

/* defer lru_add_drain() to tlb_finish_mmu() for ifndef CONFIG_MMU_GATHER_N=
O_GATHER */

Is your change of skipping the extra lru_add_drain() motivated by some perf=
ormance reason
in a workload? Wonder whether it is worth adding an extra ifdef in the code=
.

Tim

>=20
> Yes, this commit aims to skip lru_add_drain() when CONFIG_MMU_GATHER_NO_G=
ATHER
> is *not* set (i.e. when the mmu_gather feature is on) because it is redun=
dant.=20
>=20
> If CONFIG_MMU_GATHER_NO_GATHER is set, pages will be released in unmap_vm=
as().
> tlb_finish_mmu() will not call lru_add_drain(). So, it is still necessary=
 to
> keep the lru_add_drain() call to clear cached pages before unmap_vmas(), =
as
> folio_batchs hold a reference count for pages in them.
>=20
> The same applies to the other case.
>=20
> Thanks,
> - Jianfeng
>=20
> > >  	lru_add_drain();
> > > +#endif
> > >  	tlb_gather_mmu(&tlb, mm);
> > >  	update_hiwater_rss(mm);
> > >  	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
> > > @@ -3300,7 +3302,9 @@ void exit_mmap(struct mm_struct *mm)
> > >  		return;
> > >  	}
> > > =20
> > > +#ifdef CONFIG_MMU_GATHER_NO_GATHER
> >=20
> > same question as above.
> >=20
> > >  	lru_add_drain();
> > > +#endif
> > >  	flush_cache_mm(mm);
> > >  	tlb_gather_mmu_fullmm(&tlb, mm);
> > >  	/* update_hiwater_rss(mm) here? but nobody should be looking */
> >=20

