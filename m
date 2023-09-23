Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B917ABEF5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjIWIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIWIu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43070127;
        Sat, 23 Sep 2023 01:50:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690E0C433CC;
        Sat, 23 Sep 2023 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695459017;
        bh=lQHIylow5tabdL32iDpwnh89XUFsl95pp9pT8Mj4Q2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iHF5d8YwsC5+4DVl1uL/suenVETkEj5fOHFZU6+7ohmGE9/paeNQB9n4hVC9n0JdZ
         vW8+BW+mUPJ12lIBwDrsG04Z2N0rG4KXOj7HTMXqHv1ExIdI+PmsR9tl53IYUsup0O
         ax7WobR0XarEuMdt7DcpxuqTLTelyMpR+0FEjavzd8NQv/dmwswHtRHw3sCvrC/C1k
         IXguZ0tjDPken/Q4GF35zfgBaHxjEvrRZ9grXi7A7Zt6Ig2G57wsy/Lg2/gtYgA2XQ
         2ECrOPkHGrI2XKTzzth1V25O74SXYnVlm50XiByP3GA7pySrrOVX8KmdX4YjWLlivR
         IzZvYDIrMQo9w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1db2445b7afso2084142fac.1;
        Sat, 23 Sep 2023 01:50:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7A3IdShLIftXRU3k///9+n+I98Bpqx0Cs+EpMjDvZgELeh4vH
        58aOB2SOUMKYmdFSfv1vaLHbCxJG/S0SonyCId0=
X-Google-Smtp-Source: AGHT+IH+SLYcikY9lh7DkpERTN1+srY8WpqvvwH8ez0iI7KQZ2ItCL1a4hoqGjzo/TI3FMQM/nPXnaxMAKA1gOUOARs=
X-Received: by 2002:a05:6870:858d:b0:1d6:5317:82cd with SMTP id
 f13-20020a056870858d00b001d6531782cdmr2198365oal.34.1695459016715; Sat, 23
 Sep 2023 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com>
In-Reply-To: <20230918210631.3882376-1-jbrennen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 23 Sep 2023 17:49:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
Message-ID: <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Jack Brennen <jbrennen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 6:06=E2=80=AFAM Jack Brennen <jbrennen@google.com> =
wrote:
>
> Modify modpost to use binary search for converting addresses back
> into symbol references.  Previously it used linear search.
>
> This change saves a few seconds of wall time for defconfig builds,
> but can save several minutes on allyesconfigs.

Thanks.
Binary search is a good idea.


> Before:
> $ make LLVM=3D1 -j128 allyesconfig vmlinux -s KCFLAGS=3D"-Wno-error"
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 13:30.31

Instead of the time for the entire build,
can you put the time for the modpost command?

If you allyesconfig case,

 $ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o





> diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
> new file mode 100644
> index 000000000000..aab79262512b
> --- /dev/null
> +++ b/scripts/mod/symsearch.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Helper functions for finding the symbol in an ELF which is "nearest"
> + * to a given address.
> + */
>

Can you use the following block comment style?

/*
 * Helper functions for finding the symbol in an ELF which is "nearest"
 * to a given address.
 */



> +#include "modpost.h"
> +
> +/* Struct used for binary search. */

I think this obvious comment is unneeded.



> +struct syminfo {
> +       unsigned int symbol_index;
> +       unsigned int section_index;
> +       Elf_Addr addr;
> +};
> +
> +/* Container used to hold an entire binary search table.
> + * Entries in table are ascending, sorted first by section_index,
> + * then by addr, and last by symbol_index.  The sorting by
> + * symbol_index is used to duplicate the quirks of the prior
> + * find_nearest_sym() function, where exact matches to an address
> + * return the first symtab entry seen, but near misses return the
> + * last symtab entry seen.

Preserving this quirk makes the code complicated.

I do not mind changing the behavior of the corner case.





> + * The first and last entries of the table are sentinels and their
> + * values only matter in two places:  when we sort the table, and
> + * on lookups, the end sentinel should not have an addr field which
> + * matches its immediate predecessor.  To meet these requirements,
> + * we initialize them to (0,0,0) and (max,max,max), and then after
> + * sorting, we tweak the end sentinel's addr field accordingly.
> + */
> +struct symsearch {
> +       size_t table_size;
> +       struct syminfo table[];
> +};



syminfo::symbol_index is unsigned int.
symsearch::table_size is size_t.


symbol_index of the last element is always larger than
elf->symsearch->table_size.

So, the code works only within 32-bit width anyway.












> +
> +static inline bool is_sym_searchable(struct elf_info *elf, Elf_Sym *sym)
> +{
> +       return is_valid_name(elf, sym) !=3D 0;
> +}

If you call is_valid_name() directly, this function was unneeded?






> +
> +static int syminfo_compare(const void *s1, const void *s2)
> +{
> +       const struct syminfo *sym1 =3D s1;
> +       const struct syminfo *sym2 =3D s2;
> +
> +       if (sym1->section_index > sym2->section_index)
> +               return 1;
> +       if (sym1->section_index < sym2->section_index)
> +               return -1;
> +       if (sym1->addr > sym2->addr)
> +               return 1;
> +       if (sym1->addr < sym2->addr)
> +               return -1;
> +       if (sym1->symbol_index > sym2->symbol_index)
> +               return 1;
> +       if (sym1->symbol_index < sym2->symbol_index)
> +               return -1;
> +       return 0;
> +}
> +
> +static size_t symbol_count(struct elf_info *elf)
> +{
> +       size_t result =3D 0;
> +
> +       for (Elf_Sym *sym =3D elf->symtab_start; sym < elf->symtab_stop; =
sym++) {
> +               if (is_sym_searchable(elf, sym))
> +                       result++;
> +       }
> +       return result;
> +}
> +
> +/* Populate the search array that we just allocated.
> + * Be slightly paranoid here.  If the ELF file changes during processing=
,

I could not understand. In which case, the ELF file changes?

modpost loads the entire file to memory first..

In which scenario, the memory content changes?






> + * or if the behavior of is_sym_searchable() changes during processing,
> + * we want to catch it; neither of those is acceptable.
> + */
> +static void symsearch_populate(struct elf_info *elf,
> +                              struct syminfo *table,
> +                              size_t table_size)
> +{
> +       bool is_arm =3D (elf->hdr->e_machine =3D=3D EM_ARM);
> +
> +       /* Start sentinel */
> +       if (table_size-- =3D=3D 0)
> +               fatal("%s: size mismatch\n", __func__);
> +       table->symbol_index =3D 0;
> +       table->section_index =3D 0;
> +       table->addr =3D 0;
> +       table++;
> +
> +       for (Elf_Sym *sym =3D elf->symtab_start; sym < elf->symtab_stop; =
sym++) {
> +               if (is_sym_searchable(elf, sym)) {
> +                       if (table_size-- =3D=3D 0)
> +                               fatal("%s: size mismatch\n", __func__);
> +                       table->symbol_index =3D sym - elf->symtab_start;
> +                       table->section_index =3D get_secindex(elf, sym);
> +                       table->addr =3D sym->st_value;
> +
> +                       /*
> +                        * For ARM Thumb instruction, the bit 0 of st_val=
ue is
> +                        * set if the symbol is STT_FUNC type. Mask it to=
 get
> +                        * the address.
> +                        */
> +                       if (is_arm && ELF_ST_TYPE(sym->st_info) =3D=3D ST=
T_FUNC)
> +                               table->addr &=3D ~1;
> +
> +                       table++;
> +               }
> +       }
> +
> +       /* End sentinel; all values are unsigned so -1 wraps to max */
> +       if (table_size !=3D 1)
> +               fatal("%s: size mismatch\n", __func__);
> +       table->symbol_index =3D -1;
> +       table->section_index =3D -1;
> +       table->addr =3D -1;
> +}
> +
> +void symsearch_init(struct elf_info *elf)
> +{
> +       /* +2 here to allocate space for the start and end sentinels */
> +       size_t table_size =3D symbol_count(elf) + 2;
> +
> +       elf->symsearch =3D NOFAIL(malloc(
> +                                       sizeof(struct symsearch) +
> +                                       sizeof(struct syminfo) * table_si=
ze));
> +       elf->symsearch->table_size =3D table_size;
> +
> +       symsearch_populate(elf, elf->symsearch->table, table_size);
> +       qsort(elf->symsearch->table, table_size,
> +             sizeof(struct syminfo), syminfo_compare);
> +
> +       /* A bit of paranoia; make sure that the end sentinel's address i=
s
> +        * different than its predecessor.  Not doing this could cause
> +        * possible undefined behavior if anybody ever inserts a symbol
> +        * with section_index and addr both at their max values.

I could not understand this comment.

If section_index and addr both at their max values at [table_size - 2],
->table[table_size - 2].addr + 1 wraps to zero.

The table is not sorted any longer?




> +        * Doing this little bit of defensive programming is more efficie=
nt
> +        * than checking for array overruns later.
> +        */
> +       elf->symsearch->table[table_size - 1].addr =3D
> +               elf->symsearch->table[table_size - 2].addr + 1;
> +}
> +
> +void symsearch_finish(struct elf_info *elf)
> +{
> +       free(elf->symsearch);
> +       elf->symsearch =3D NULL;
> +}
> +
> +/* Find the syminfo which is in secndx and "nearest" to addr.
> + * allow_negative: allow returning a symbol whose address is > addr.
> + * min_distance: ignore symbols which are further away than this.
> + *
> + * Returns a nonzero index into the symsearch table for success.
> + * Returns NULL if no legal symbol is found within the requested range.
> + */
> +static size_t symsearch_find_impl(struct elf_info *elf, Elf_Addr addr,
> +                                 unsigned int secndx, bool allow_negativ=
e,
> +                                 Elf_Addr min_distance)
> +{
> +       /* Find the target in the array; it will lie between two elements=
.
> +        * Invariant here: table[lo] < target <=3D table[hi]
> +        * For the purposes of search, exact hits in the search array are
> +        * considered greater than the target.  This means that if we do
> +        * get an exact hit, then once the search terminates, table[hi]
> +        * will be the exact match which has the lowest symbol index.
> +        */
> +       struct syminfo *table =3D elf->symsearch->table;
> +       size_t hi =3D elf->symsearch->table_size - 1;
> +       size_t lo =3D 0;




The binary search code was implemented in a too complex way
to preserve the previous quirks.


I want to use the same comparison function for
qsort() and bsearch() to avoid paranoia.




How about this implementation?



static struct syminfo *symsearch_find_impl(struct elf_info *elf, Elf_Addr a=
ddr,
                                           unsigned int secndx, bool
allow_negative,
                                           Elf_Addr min_distance)
{
        struct syminfo target =3D { .symbol_index =3D -1, .section_index =
=3D
secndx, .addr =3D addr };
        struct syminfo *table =3D elf->symsearch->table;
        unsigned int hi =3D elf->symsearch->table_size - 1;
        unsigned int lo =3D 0;
        struct syminfo *result =3D NULL;
        Elf_Addr distance;

        while (lo < hi) {
                unsigned int mid =3D (lo + hi + 1) / 2;

                if (syminfo_compare(&table[mid], &target) > 0)
                        hi =3D mid - 1;
                else
                        lo =3D mid;
        }

        /*
         * The target resides between lo and (lo + 1).
         * If allow_negative is true, check both of them.
         */

        if (allow_negative && lo + 1 < elf->symsearch->table_size &&
            table[lo + 1].section_index =3D=3D secndx) {
                distance =3D table[lo + 1].addr - addr;
                if (distance <=3D min_distance) {
                        min_distance =3D distance;
                        result =3D &table[lo + 1];
                }
        }

        if (table[lo].section_index =3D=3D secndx) {
                distance =3D addr - table[lo].addr;
                if (distance <=3D min_distance)
                  result =3D &table[lo];
        }

        return result;
}

Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
                                unsigned int secndx, bool allow_negative,
                                Elf_Addr min_distance)
{
        struct syminfo *result;

        result =3D symsearch_find_impl(elf, addr, secndx,
                                     allow_negative, min_distance);
        if (!result)
                return NULL;

        return &elf->symtab_start[result->symbol_index];
}



This does not preserve the previous quirks.

If there are multiple entries with the same address,
it always returns the last element.

I did not expect sentinels.

I did not do thorough tests, but it seems to be working for me.




Also, please call symsearch_find_nearest() directly
and remove symfind_nearest_sym().






--
Best Regards

Masahiro Yamada
