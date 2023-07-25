Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FDC760999
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGYFnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGYFnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:43:37 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D51FCE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:43:13 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so194481cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690263792; x=1690868592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIDMt+ukB3iu96NN76V4i5aDHpFjPIK+TbAxUylXFbc=;
        b=QVWmh30O5Tn5kmdIXi6k8D31VIjeVN906YLSjLLx5O2bPNaMTN+6zn/VxtFxdbslOo
         BD02+q1ZpeCzY54p4D5C34hbNBNS8RC+OLFxOfrEBzWAo1R4QzuliySjeNiBcGxNrqQR
         //zd2eKnCExJHH35DZesh/RxR+LCYO+8KVGEHfYu11V/nhf2+BlydSAJSDfqkDQ3gnww
         mPt/3ApbceJb98bsS5A22Z/aIE6fyE+S+dHCEF5pHgfAOREeHYkRk66JqRiDpQxIZj6q
         Cq/TEBs3QNI/Vs4EMZat48i2LI8r4gGpocKPmKdQq5knf7vdK81zwmkzxGxH/JBLPq5C
         VowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690263792; x=1690868592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIDMt+ukB3iu96NN76V4i5aDHpFjPIK+TbAxUylXFbc=;
        b=bZUvnO6sgGjgZEBchLd5ukFbH/wwRUjH2pbblE0W20MJKy556USz67S5Avoim574tO
         pZKrF9dQp30eQIaPyF2L4upeBq/syE0AcSXvuFsrhUP736sa2Vl88/s3nEJvLEowAYvn
         I7XIc6TpNqpfgGP1pUzot+2snfrDYxtLMRBI7wuZSUI4GR1QDg18Ki5ZScVYV99VuXBy
         1CRqIgtx9qQY+lN+4IQk2u1QY0X95hyKlijFZYICYn0k9Q34SZ4iQ8Bazu+diGdbiyf/
         +8gaazVxRd3OkLni+J4Q11UfKxj3RL5juVjckTLQ/cZOAoeBLGhD+1ysHhBBJRwCUqiN
         gepA==
X-Gm-Message-State: ABy/qLaB3J6lAWSiwdN6izgKQDmQ58Y5zS7yXNErP13kyycfKTUye2zi
        q4qImI8rE5tNU4o+c0NrPSJLY9uyUXNeRl5uhGpZHQ==
X-Google-Smtp-Source: APBJJlHKdDVd54Lf9xjbg3FDc+aM4J4ZaWYYP3CYibYSXCA+p7hZQLopCR5e78Q47BMCmPHnqHhL6mA7VLoBNoo8xvg=
X-Received: by 2002:a05:622a:16:b0:3ef:5f97:258f with SMTP id
 x22-20020a05622a001600b003ef5f97258fmr93934qtw.16.1690263791937; Mon, 24 Jul
 2023 22:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com> <20230721094043.2506691-4-fengwei.yin@intel.com>
In-Reply-To: <20230721094043.2506691-4-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 24 Jul 2023 23:42:35 -0600
Message-ID: <CAOUHufZQr2Z+N2mVaMcnOZ8ukm_CkN51h6OdoAXTxytkVyAWSw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] mm: add functions folio_in_range() and folio_within_vma()
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> It will be used to check whether the folio is mapped to specific
> VMA and whether the mapping address of folio is in the range.
>
> Also a helper function folio_within_vma() to check whether folio
> is in the range of vma based on folio_in_range().
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/internal.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 483add0bfb28..c7dd15d8de3e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -585,6 +585,38 @@ extern long faultin_vma_page_range(struct vm_area_st=
ruct *vma,
>                                    bool write, int *locked);
>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>                                unsigned long bytes);
> +
> +static inline bool
> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
> +               unsigned long start, unsigned long end)
> +{
> +       pgoff_t pgoff, addr;
> +       unsigned long vma_pglen =3D (vma->vm_end - vma->vm_start) >> PAGE=
_SHIFT;
> +
> +       VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
> +       if (start < vma->vm_start)
> +               start =3D vma->vm_start;
> +
> +       if (end > vma->vm_end)
> +               end =3D vma->vm_end;
> +
> +       pgoff =3D folio_pgoff(folio);
> +
> +       /* if folio start address is not in vma range */
> +       if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
> +               return false;
> +
> +       addr =3D vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +
> +       return ((addr >=3D start) && (addr + folio_size(folio) <=3D end))=
;

Not sure how much we care but better to avoid (addr + folio_size()),
since it might wrap to 0 on 32-bit systems.

Reusing some helpers from mm/internal.h, e.g., vma_pgoff_address(),
would be great, if it's possible (I'm not sure if it's).
