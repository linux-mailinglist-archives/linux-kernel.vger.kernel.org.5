Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A533B76DC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjHCA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHCA0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:26:31 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD45C11D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:26:30 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44779e3e394so195522137.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691022390; x=1691627190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk6j0GFS7IPls0T71J5TEv/VUGibQ9LYNrY6ZRhc4WQ=;
        b=A3FMTBgSM/+Ry82aQYMpgPvkPsrxEIudSjvLRAWekauteN8dYcaciENk0Oham5nWy+
         xsg+1uyABr3c3yglOICg10HACIY9k/783EuGqXe2gDqUbmOLBe4ITkiMpCmo4Cu5uCY0
         /scnsN6894j9ytnLEzrF/w7h2uyoiPKsbe/x/albIdAKXtTpayBGcFePRywUNDjpc905
         8nbZHZUqds3mtii+jbBCHzaGjdZpvKEn9UI0/SCJlYo6Q+PJwHx5BIHl14YDI89e/yNV
         FjzS23P8g6NrJ2DsGhaKnVgo0HwUWsVpHMrrDU5GGAncT+91/Zxnk5kSsYr8aUB/vsDb
         nqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691022390; x=1691627190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk6j0GFS7IPls0T71J5TEv/VUGibQ9LYNrY6ZRhc4WQ=;
        b=ZW1kH67qugmXRMSpFPo2xM8v8Y8NiG0nHYZn9oDaXoi/cADO153Z3JCaKiaHHf2L5l
         wi8DFIctn8zHZ91SkIh/B2VcSTPEY7/lyQ39wEnWaXmfk5aLoe+u+lI5DsKvsr0wOaRa
         vlma86XrAbp8wDGX2gHehnWC4+wAtD1Q9jmBPR8XZ0vv5tTguAK0Q8e206WUupe3S7wa
         4nOs0kRHmeGtHIEi3S173935FQ0tb7XAipVLtsRdBLslmO5lu/ekpdzug4/Cd1yxMe2d
         mAaCWv8CKnTAsN8siwC1OCGuPjVBiMyb3ZpAYIkpdODgho52ynO4ekrpntDpQyxhPEqn
         e6lA==
X-Gm-Message-State: ABy/qLZAxUdBnsa8j+PEjXUjB3OPswZ99Km5Y6wJdJXtNcXypwShxjgG
        MRpvRtkqPLcZaU2SxXG8ylTxI7GSb3FuCXnzKKQElg==
X-Google-Smtp-Source: APBJJlHQm66TQC7ZMPcAlCbk6UgXh9vKj+jbw4Phlpmpl7p76qi5w0WQynMiK0D3UAqbFJec33RdF5UnBYM/r6Ya17U=
X-Received: by 2002:a05:6102:364d:b0:443:8034:be4a with SMTP id
 s13-20020a056102364d00b004438034be4amr5895518vsu.28.1691022388451; Wed, 02
 Aug 2023 17:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-2-wangkefeng.wang@huawei.com> <20230731234027.GB39768@monkey>
In-Reply-To: <20230731234027.GB39768@monkey>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 2 Aug 2023 17:26:17 -0700
Message-ID: <CAHS8izM=_TWVhu9OcEFBg=MDYrh4BFmzM8a3=tSRPRBmkuAUuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: hugetlb: use flush_hugetlb_tlb_range() in move_hugetlb_page_tables()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 4:40=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 07/31/23 15:48, Kefeng Wang wrote:
> > Archs may need to do special things when flushing hugepage tlb,
> > so use the more applicable flush_hugetlb_tlb_range() instead of
> > flush_tlb_range().
> >
> > Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage =
backed vma")
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Thanks!
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>

Sorry for jumping in late, but given the concerns raised around HGM
and the deviation between hugetlb and the rest of MM, does it make
sense to try to make an incremental effort towards avoiding hugetlb
specialization?

In the context of this patch, I would prefer that the arch upgrade
flush_tlb_range() to handle hugetlb correctly, instead of adding more
hugetlb specific deviations, ala flush_hugetlb_tlb_range. While it's
at it, maybe replace flush_hugetlb_tlb_range() in the code with
flush_tlb_range().

Although, I don't have the expertise to judge if upgrading
flush_tlb_range() to handle hugetlb is easy or feasible at all.

> Although, I missed this in 550a7d60bd5e :(
>
> Looks like only powerpc provides an arch specific flush_hugetlb_tlb_range
> today.
> --
> Mike Kravetz
>
> > ---
> >  mm/hugetlb.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 64a3239b6407..ac876bfba340 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5281,9 +5281,9 @@ int move_hugetlb_page_tables(struct vm_area_struc=
t *vma,
> >       }
> >
> >       if (shared_pmd)
> > -             flush_tlb_range(vma, range.start, range.end);
> > +             flush_hugetlb_tlb_range(vma, range.start, range.end);
> >       else
> > -             flush_tlb_range(vma, old_end - len, old_end);
> > +             flush_hugetlb_tlb_range(vma, old_end - len, old_end);
> >       mmu_notifier_invalidate_range_end(&range);
> >       i_mmap_unlock_write(mapping);
> >       hugetlb_vma_unlock_write(vma);
> > --
> > 2.41.0
> >



--=20
Thanks,
Mina
