Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215837740DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHHRLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjHHRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:11:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D236768B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:04:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5866e5f6e40so83717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691510670; x=1692115470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTo5ojti02a55E58VI3g974kVDsDFjEN9JowZT+qd/k=;
        b=VCF7cGTRTBdD6bBrYDQakjTWFLuAi6Q+6otovhoj2gGQxOmhhxBlGC8ObWF+z9BuQN
         O4FhbzFoV6diJ1MTsL3V4Hx0rjSK/fWc0vZWCbdftsa4EEmV2clS4Fj0B1HmRkGMQU8i
         xH4zodw2BSDJBGY+c+F9cEw0AU9NkkCjm2tzU6ytR0yGxW2Yia2oUa4Sc3sIG0A9TJSu
         JH9ZVB7Pmz2BqcWUBUUW3IbLiGm15mdsLV1G5lpmBxllvzc+FCFDWW6J9UTbR/C4F3My
         NmX3+zlQrR25n3VjKUrx4xMZXCNvCXJzgQ44EdTYcXhzIPBVHPz6+2FT3FTvDwkuAQgS
         Na2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510670; x=1692115470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTo5ojti02a55E58VI3g974kVDsDFjEN9JowZT+qd/k=;
        b=DTc0oZ4T+3yFj+NVAeoP0NFt1Q7qOtrjNC9jtkYDzuBqWYupnIkpwFXG8avrZwEsI3
         2W10OQE3Hdo2hCm8nr8hz4dCNdU5aSy/dm3J94ff4NlmzZ5LWS/DuhOlMi3Ob65X5mkq
         VpTHUOePoIQH/doI/Dt94jUIScO1NdUyMR2ZTFIMZXRY+i+FWTzHH+2+qg6e7rlcvtyP
         yX8UKlEU0vIJymBAyUrdxQR00KamtVtxD/QnaH2O60ua7/EmCLeEmMqQ8iIE/YouOnR5
         slQhyIAl1mFlK7/4w2HybiZleYnY8BGu8891IzWM7m0pjMIYU04ivmh6YQJvnDIl9HaX
         qMZw==
X-Gm-Message-State: AOJu0YwvNUGWQuURo+i90hpbXOwM7j0ZWJAUZKdgvGJnxAZ3Vdj2cfmz
        HSLHVAaYc7xWbsmKJS/jjIN1fX67mMM=
X-Google-Smtp-Source: AGHT+IEdPz8huAHqBMaXUgoEqld6bpjYXBbq0y8UIRXJ9G7iWwnU0w/pw1lOLCb7FPvPaLYPGA06MiJ6a7U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2792:b0:267:f9ed:93b9 with SMTP id
 pw18-20020a17090b279200b00267f9ed93b9mr101702pjb.3.1691504768630; Tue, 08 Aug
 2023 07:26:08 -0700 (PDT)
Date:   Tue, 8 Aug 2023 07:26:07 -0700
In-Reply-To: <ZNI14eN4bFV5eO4W@nvidia.com>
Mime-Version: 1.0
References: <20230808071329.19995-1-yan.y.zhao@intel.com> <20230808071702.20269-1-yan.y.zhao@intel.com>
 <ZNI14eN4bFV5eO4W@nvidia.com>
Message-ID: <ZNJQf1/jzEeyKaIi@google.com>
Subject: Re: [RFC PATCH 3/3] KVM: x86/mmu: skip zap maybe-dma-pinned pages for
 NUMA migration
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yan Zhao <yan.y.zhao@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, mike.kravetz@oracle.com, apopple@nvidia.com,
        rppt@kernel.org, akpm@linux-foundation.org, kevin.tian@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 03:17:02PM +0800, Yan Zhao wrote:
> > @@ -859,6 +860,21 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
> >  		    !is_last_spte(iter.old_spte, iter.level))
> >  			continue;
> >  
> > +		if (skip_pinned) {
> > +			kvm_pfn_t pfn = spte_to_pfn(iter.old_spte);
> > +			struct page *page = kvm_pfn_to_refcounted_page(pfn);
> > +			struct folio *folio;
> > +
> > +			if (!page)
> > +				continue;
> > +
> > +			folio = page_folio(page);
> > +
> > +			if (folio_test_anon(folio) && PageAnonExclusive(&folio->page) &&
> > +			    folio_maybe_dma_pinned(folio))
> > +				continue;
> > +		}
> > +
> 
> I don't get it..
> 
> The last patch made it so that the NUMA balancing code doesn't change
> page_maybe_dma_pinned() pages to PROT_NONE
> 
> So why doesn't KVM just check if the current and new SPTE are the same
> and refrain from invalidating if nothing changed?

Because KVM doesn't have visibility into the current and new PTEs when the zapping
occurs.  The contract for invalidate_range_start() requires that KVM drop all
references before returning, and so the zapping occurs before change_pte_range()
or change_huge_pmd() have done antyhing.

> Duplicating the checks here seems very frail to me.

Yes, this is approach gets a hard NAK from me.  IIUC, folio_maybe_dma_pinned()
can yield different results purely based on refcounts, i.e. KVM could skip pages
that the primary MMU does not, and thus violate the mmu_notifier contract.  And
in general, I am steadfastedly against adding any kind of heuristic to KVM's
zapping logic.

This really needs to be fixed in the primary MMU and not require any direct
involvement from secondary MMUs, e.g. the mmu_notifier invalidation itself needs
to be skipped.
