Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B97769059
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGaIiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGaIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:37:26 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434BE57
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:33:48 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-486198c70adso1342486e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690792427; x=1691397227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckP7NF4Z1GYTZiK2dYi1nNlDBTWx4/E1X/qSymornb4=;
        b=guWCLMET61252C+Y3fHlLWURhdE33BrI72qoF3c3XbX3saGrvm5yGS7DN+T13z9opB
         GkF+MFpYqRTjp3KZ3qrZtTCcvFP05XmUYYHuYnSZ2QAYWCRoyWGnb5X+u5hzLx/UhenD
         wahK+HTVUyA/dbOZjpxeK16hBdGCTSjutPtR1N8jAKrgyEQissAUDWm9IEcVNOtbTp7+
         l90XD8MeYwuvXIC9XsnPpDZFGnMIVkzrmu23rHRnLK5cupra2yZN/qYVSL75/MMKrJPb
         6nTKVzO7aB6eG5t6FmMofBadGV62EfIdWQN+rbZxqfNjrtvloHDbzzSeaMWNIl71m41a
         nuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690792427; x=1691397227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckP7NF4Z1GYTZiK2dYi1nNlDBTWx4/E1X/qSymornb4=;
        b=L9ygJMYCEETZqYiHxSDCJIC1ycqY6vWmjowCyI2yqOp3fetF1b2ylh7fwOh3wwonHG
         1KkrDwOK4xli47jOcoDe3hSBTNfgRjukB393p2dh1BG+MC7Jukn3XDSYTlRRhN14NrrV
         j6qDROpRXY+tmYWUx/wrWIXGEqMfScMqexlYzzomkTHaC/Y7JpUkaKzJISvSpAZXNmsD
         IE3Dnyp/ND/k3+nLc3pF1Mb0muPBSzcrj7PXoSxz0+2NSVigtJCRQGtnmjXVxtU+96Ko
         Djxq97oUWiIdO3yaaa5VLAcVJJhyaJyw+ZjhpwmJ+ktngih9cBNk5r3XP199yT/iMNfM
         Jm+w==
X-Gm-Message-State: ABy/qLa+gAMwdhcEBd844JSF+h9/MsxXDEZmkF9wIWt4gRvv8ZKO5mQG
        kHPpyfHO3FYYRjmxujXr/nafpQVhJdAvZTnj30BuWeENWd+knQ==
X-Google-Smtp-Source: APBJJlGr8v2sGSmuvo5riAw+d+bqvLQqaR1dl+ejrmOkv/DR13s0R0YVtDCFriB+aGix82X/xDObYVFtQMiBwhIfmtw=
X-Received: by 2002:a1f:6013:0:b0:486:4c0b:b4cf with SMTP id
 u19-20020a1f6013000000b004864c0bb4cfmr4757886vkb.10.1690792427512; Mon, 31
 Jul 2023 01:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com> <20230731074829.79309-5-wangkefeng.wang@huawei.com>
In-Reply-To: <20230731074829.79309-5-wangkefeng.wang@huawei.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 31 Jul 2023 16:33:36 +0800
Message-ID: <CAGsJ_4xvSyvskcKMptiwm+8eV-sgSWsJYgBEYpwQ2n=cHHNZ7Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: tlb: set huge page size to stride for hugepage
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 4:14=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> It is better to use huge_page_size() for hugepage(HugeTLB) instead of
> PAGE_SIZE for stride, which has been done in flush_pmd/pud_tlb_range(),
> it could reduce the loop in __flush_tlb_range().
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/t=
lbflush.h
> index 412a3b9a3c25..25e35e6f8093 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -360,16 +360,17 @@ static inline void __flush_tlb_range(struct vm_area=
_struct *vma,
>         dsb(ish);
>  }
>
> -static inline void flush_tlb_range(struct vm_area_struct *vma,
> -                                  unsigned long start, unsigned long end=
)
> -{
> -       /*
> -        * We cannot use leaf-only invalidation here, since we may be inv=
alidating
> -        * table entries as part of collapsing hugepages or moving page t=
ables.
> -        * Set the tlb_level to 0 because we can not get enough informati=
on here.
> -        */
> -       __flush_tlb_range(vma, start, end, PAGE_SIZE, false, 0);
> -}
> +/*
> + * We cannot use leaf-only invalidation here, since we may be invalidati=
ng
> + * table entries as part of collapsing hugepages or moving page tables.
> + * Set the tlb_level to 0 because we can not get enough information here=
.
> + */
> +#define flush_tlb_range(vma, start, end)                               \
> +       __flush_tlb_range(vma, start, end,                              \
> +                               ((vma)->vm_flags & VM_HUGETLB)          \
> +                               ? huge_page_size(hstate_vma(vma))       \
> +                               : PAGE_SIZE, false, 0)
> +

seems like a good idea.

I wonder if a better implementation will be MMU_GATHER_PAGE_SIZE,  in this =
case,
we are going to support stride for other large folios as well, such as thp.

>
>  static inline void flush_tlb_kernel_range(unsigned long start, unsigned =
long end)
>  {
> --
> 2.41.0
>

Thanks
Barry
