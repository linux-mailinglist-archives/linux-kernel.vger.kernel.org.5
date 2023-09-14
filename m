Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6B79F607
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjINA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjINA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:58:55 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD631BCD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:58:50 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38E0wgV3031997;
        Thu, 14 Sep 2023 08:58:42 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Thu, 14 Sep 2023 08:58:39 +0800
Date:   Thu, 14 Sep 2023 08:58:36 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <bjorn@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ycliang@andestech.com>
Subject: Re: [PATCH 1/3] riscv: Improve PTDUMP to show RSW with non-zero value
Message-ID: <ZQJavHfMLDXBaRC-@APC323>
References: <20230913162458.2931065-1-peterlin@andestech.com>
 <CAHVXubhB_FY7Vc7105J_SuS8JbvVSyKTbtaamY1HPngyXRmWXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubhB_FY7Vc7105J_SuS8JbvVSyKTbtaamY1HPngyXRmWXA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38E0wgV3031997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:29:11PM +0200, Alexandre Ghiti wrote:
> Hi Yu,
> 
> On Wed, Sep 13, 2023 at 6:25 PM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > RSW field is allowed to encode 2 bits of information, currently
> > PTDUMP only prints RSW when its value is 1 or 3.
> >
> > To fix this issue and enhance the debug experience with PTDUMP,
> > allow it to print the RSW with any non-zero value, otherwise,
> > it will print a empty string for each row.
> >
> > This patch also removes the val from the struct prot_bits
> > as it is no longer needed.
> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > ---
> >  arch/riscv/include/asm/pgtable-bits.h |  2 +-
> >  arch/riscv/mm/ptdump.c                | 33 ++++++++++++---------------
> >  2 files changed, 15 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index f896708e8331..d5e828b7d7c6 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -16,7 +16,7 @@
> >  #define _PAGE_GLOBAL    (1 << 5)    /* Global */
> >  #define _PAGE_ACCESSED  (1 << 6)    /* Set by hardware on any access */
> >  #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
> > -#define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
> > +#define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
> 
> That makes the PAGE_SPECIAL below use the 2 software reserved bits
> right? You should redefine PAGE_SPECIAL to (1 << 8).

Hi Alexandre,

Sure, will fix.
Thanks for the review.

Regards,
Peter Lin

> >
> >  #define _PAGE_SPECIAL   _PAGE_SOFT
> >  #define _PAGE_TABLE     _PAGE_PRESENT
> > diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
> > index 20a9f991a6d7..62bbea17d475 100644
> > --- a/arch/riscv/mm/ptdump.c
> > +++ b/arch/riscv/mm/ptdump.c
> > @@ -129,7 +129,6 @@ static struct ptd_mm_info efi_ptd_info = {
> >  /* Page Table Entry */
> >  struct prot_bits {
> >         u64 mask;
> > -       u64 val;
> >         const char *set;
> >         const char *clear;
> >  };
> > @@ -137,47 +136,38 @@ struct prot_bits {
> >  static const struct prot_bits pte_bits[] = {
> >         {
> >                 .mask = _PAGE_SOFT,
> > -               .val = _PAGE_SOFT,
> > -               .set = "RSW",
> > -               .clear = "   ",
> > +               .set = "RSW(%d)",
> > +               .clear = "      ",
> >         }, {
> >                 .mask = _PAGE_DIRTY,
> > -               .val = _PAGE_DIRTY,
> >                 .set = "D",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_ACCESSED,
> > -               .val = _PAGE_ACCESSED,
> >                 .set = "A",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_GLOBAL,
> > -               .val = _PAGE_GLOBAL,
> >                 .set = "G",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_USER,
> > -               .val = _PAGE_USER,
> >                 .set = "U",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_EXEC,
> > -               .val = _PAGE_EXEC,
> >                 .set = "X",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_WRITE,
> > -               .val = _PAGE_WRITE,
> >                 .set = "W",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_READ,
> > -               .val = _PAGE_READ,
> >                 .set = "R",
> >                 .clear = ".",
> >         }, {
> >                 .mask = _PAGE_PRESENT,
> > -               .val = _PAGE_PRESENT,
> >                 .set = "V",
> >                 .clear = ".",
> >         }
> > @@ -208,15 +198,20 @@ static void dump_prot(struct pg_state *st)
> >         unsigned int i;
> >
> >         for (i = 0; i < ARRAY_SIZE(pte_bits); i++) {
> > -               const char *s;
> > -
> > -               if ((st->current_prot & pte_bits[i].mask) == pte_bits[i].val)
> > -                       s = pte_bits[i].set;
> > +               char s[7];
> > +               unsigned long val;
> > +
> > +               val = st->current_prot & pte_bits[i].mask;
> > +               if (val) {
> > +                       if (pte_bits[i].mask == _PAGE_SOFT)
> > +                               sprintf(s, pte_bits[i].set, val >> 8);
> > +                       else
> > +                               sprintf(s, "%s", pte_bits[i].set);
> > +               }
> >                 else
> > -                       s = pte_bits[i].clear;
> > +                       sprintf(s, "%s", pte_bits[i].clear);
> >
> > -               if (s)
> > -                       pt_dump_seq_printf(st->seq, " %s", s);
> > +               pt_dump_seq_printf(st->seq, " %s", s);
> >         }
> >  }
> >
> > --
> > 2.34.1
> >
