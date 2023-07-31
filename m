Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B99769F90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGaRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjGaRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:37:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800521BF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:36:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbb3195013so12495ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690825019; x=1691429819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqwUjf4srHS0GmV2PrhboWOP/pK2frD9PFN9eIO2JAw=;
        b=PW7uXs8te+DjBD/konvGzLWP8g1fMK7bveuEGlOTMiFVF5fJOURsOxjYwDa4V8/7PN
         GfxiTdGyn4gNxwwJEsgm5Sa3Z07XoIws8zOegDuEUNdgEakGsCpulFVJ68YDWRx8hG7J
         pHEIHY9NNGcOKqt3EcY+H5XjDJYzQb9r6s9KF29xhh5Zs48JdBGHLJzvx9IIdfAb6DL2
         uvolYf+4ofy8X/EQBFsrD9bL5wC/3Jo2GpoHAsbLgZmiKj7F/6zz+pRJOqtmGCUykUqb
         cXxdJcVUj2aUL7x0X6KpmqFqe34XSu2p4AB041J8zGtZ22s2J/6FLShweArcanRRNTIu
         x2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690825019; x=1691429819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqwUjf4srHS0GmV2PrhboWOP/pK2frD9PFN9eIO2JAw=;
        b=YAOkjDEDcHpMVL/1/h0A0wPdPeIRuWiLGtUBHn/O7XiWyc7Utlq3NiuiXEr6mB0MKM
         HUEin/7ERJyT14DwG9/z9SZY38P57UUGSBnKVQ+TyEBGpV9oXffj/yiqTDvjWZolp37/
         PQP4gOZwgq3gsaXMrIVop00qPCnp3v9Knn8/fxEL/Fd+o/6/pucRDkr+O/BqWv70AoSp
         zqhrXl+Q8z1iBO+NBbpYHur38L4ALgo3zURiz3F84EhdM93OF7mYgblhSd5rtes+nJjf
         CUU/pPgu6+Xkfgku5lx6DVe2AazXLDRcyjxAFY1/i8Bb39Tunm6K3g7qDRhuiZRXC8HI
         Ugvg==
X-Gm-Message-State: ABy/qLYFv+E2ydVMHaKl4TFpkjp4mpFj8DXAAR0Yyd+plQom8w2agF5x
        r1a1HItvy6DLQcPOEdJODBxqaO4gnC/1MLys1K+2tw==
X-Google-Smtp-Source: APBJJlFkMuLyTHjACrkUI9ojOs57IF7oGguBdj8b71/dF8frxz4uOZLWejmA7Zhtt9x/0OUhO69yCloZOMPgYxPCZgE=
X-Received: by 2002:a17:902:c410:b0:1b8:82c6:9e11 with SMTP id
 k16-20020a170902c41000b001b882c69e11mr381793plk.0.1690825018566; Mon, 31 Jul
 2023 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com> <20230722022251.3446223-7-rananta@google.com>
 <87r0otr579.wl-maz@kernel.org>
In-Reply-To: <87r0otr579.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 31 Jul 2023 10:36:47 -0700
Message-ID: <CAJHc60zqOeWXf3kh5hKL6DL3g4znmHaH-TqC0QDcBrWPsHAEXQ@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] arm64: tlb: Refactor the core flush algorithm of __flush_tlb_range
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:58=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Sat, 22 Jul 2023 03:22:45 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > Currently, the core TLB flush functionality of __flush_tlb_range()
> > hardcodes vae1is (and variants) for the flush operation. In the
> > upcoming patches, the KVM code reuses this core algorithm with
> > ipas2e1is for range based TLB invalidations based on the IPA.
> > Hence, extract the core flush functionality of __flush_tlb_range()
> > into its own macro that accepts an 'op' argument to pass any
> > TLBI operation, such that other callers (KVM) can benefit.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> > ---
> >  arch/arm64/include/asm/tlbflush.h | 109 +++++++++++++++---------------
> >  1 file changed, 56 insertions(+), 53 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm=
/tlbflush.h
> > index 412a3b9a3c25..f7fafba25add 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -278,14 +278,62 @@ static inline void flush_tlb_page(struct vm_area_=
struct *vma,
> >   */
> >  #define MAX_TLBI_OPS PTRS_PER_PTE
> >
> > +/* When the CPU does not support TLB range operations, flush the TLB
> > + * entries one by one at the granularity of 'stride'. If the TLB
> > + * range ops are supported, then:
>
> Comment format (the original was correct).
>
Isn't the format the same as original? Or are you referring to the
fact that it needs to be placed inside the macro definition?
> > + *
> > + * 1. If 'pages' is odd, flush the first page through non-range
> > + *    operations;
> > + *
> > + * 2. For remaining pages: the minimum range granularity is decided
> > + *    by 'scale', so multiple range TLBI operations may be required.
> > + *    Start from scale =3D 0, flush the corresponding number of pages
> > + *    ((num+1)*2^(5*scale+1) starting from 'addr'), then increase it
> > + *    until no pages left.
> > + *
> > + * Note that certain ranges can be represented by either num =3D 31 an=
d
> > + * scale or num =3D 0 and scale + 1. The loop below favours the latter
> > + * since num is limited to 30 by the __TLBI_RANGE_NUM() macro.
> > + */
> > +#define __flush_tlb_range_op(op, start, pages, stride,                =
       \
> > +                             asid, tlb_level, tlbi_user)             \
>
> If you make this a common macro, please document the parameters, and
> what the constraints are. For example, what does tlbi_user mean for an
> IPA invalidation?
>
Sure, I'll document the parameters. That'll be helpful.

- Raghavendra
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
