Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083E87A6BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjISTke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjISTkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:40:32 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB288F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:40:25 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49351972cbeso2295911e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695152425; x=1695757225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b55LLDU+JPS5dVBBhaMn22hJgg2JySbWjWj3gYvRiO4=;
        b=qjxIjtB7HUB6i0nMjawWvyoKR8l+fz4LWFz42jAuNiKMdevWxMBu+6Av7CvB84T46l
         V1nanrqAqaxf08GaTfp3qHISB3uegeD6drsRVHFQC16pHyUfwpECE0dzG9J304lytcvX
         YE4nrsUmud8clmjjSK9LxUOHBsHjTZ6tmC6+6D2mGw5nRJhhSI9U22BzK0qmduTYtIOf
         +dVnXrQM0rC4E9TPm+m6mT8ID1TmC5o+8txpXJhKdHLpbwctDU2sCKvbhgaBfXsH2aMk
         h/2niCkhZHuokhthPHnPL6GWZ/tlkCdEP5VoBvY2QxFhuEpO6T/tVQ/pSTYhbKgTWVQ/
         lV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695152425; x=1695757225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b55LLDU+JPS5dVBBhaMn22hJgg2JySbWjWj3gYvRiO4=;
        b=HjcSIzVeOSdSmsgSon0U2gbu1rcg6dBTIQARF7/mer640M1Nho8Jx6YKNFXXYzUneP
         7Q991bMXZxRvdzia/4VjlSbO4w2pkw3yqQfQ3JYOZ60U+2sFkH2owOVqXThrQT8FQ2G4
         sao6+3dWp++qHKjIsDdX3evtef9BJM2E+JO7582PaqYW7pqNXgRi0BLaugBSFhnGYliy
         wdNbrSEcsbl0wMjEOBNPXDUDOrZXmmoV6Wh+j4Jf5YDZnsQ6JCdGIGmOTn2t6i/yYJ1O
         lSL2osv9HDseiUwGY7R5ibzaKv+2UVFdP2mqCRaOr2JqmTbB3K2Ik2Kf9WtEA47X1Yv9
         62Eg==
X-Gm-Message-State: AOJu0YyQv6OASeIeDQLA2i3EHowB5G8MzN7dE8VGbgJ1wUlsoSg2YEdU
        VgCXNAJfuX8zkS0kqmYS6fMYxwgwa5oWBK2LeKIU6g==
X-Google-Smtp-Source: AGHT+IFQd8u59vp+CaoBmYTXFraY3VNIeSrY1FkD5+TXqw3O3B9AGau9M0l1j7ihEX/0TTjaXCt8CZHUPVks+syzd0c=
X-Received: by 2002:a1f:e2c3:0:b0:496:a303:a321 with SMTP id
 z186-20020a1fe2c3000000b00496a303a321mr858379vkg.8.1695152424769; Tue, 19 Sep
 2023 12:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com>
In-Reply-To: <20230918210631.3882376-1-jbrennen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Sep 2023 12:40:09 -0700
Message-ID: <CAKwvOd=knPrBkk+QdAs_Wih8bUbsvCjWXWWuTmOUUOGGh7-f2w@mail.gmail.com>
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary search
To:     Jack Brennen <jbrennen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:06=E2=80=AFPM Jack Brennen <jbrennen@google.com> =
wrote:
>
> Modify modpost to use binary search for converting addresses back
> into symbol references.  Previously it used linear search.
>
> This change saves a few seconds of wall time for defconfig builds,
> but can save several minutes on allyesconfigs.
>
> Before:
> $ make LLVM=3D1 -j128 allyesconfig vmlinux -s KCFLAGS=3D"-Wno-error"
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 13:30.31
>
> After:
> $ make LLVM=3D1 -j128 allyesconfig vmlinux -s KCFLAGS=3D"-Wno-error"
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 11:43.43
>
> Signed-off-by: Jack Brennen <jbrennen@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Jack, if this is your first kernel patch, it's a nice one! And
welcome!  Thanks for your work on this.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Some ideas for future improvement.

I noticed we make 2 trips through the symbol table checking
is_sym_searchable twice.  We could probably skip one trip and just
malloc the full size of the symbol table, even if this is technically
larger than absolutely needed.  Guessing that might save us repeated
strlen calls on every symbol in the table.

Also, if qsort shows up in any profile, it's pretty well known why
std::sort beats qsort; there's potential for more speed there, but I
didn't profile so IDK.

> ---
>  scripts/mod/Makefile    |   4 +-
>  scripts/mod/modpost.c   |  60 +----------
>  scripts/mod/modpost.h   |  25 +++++
>  scripts/mod/symsearch.c | 233 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 265 insertions(+), 57 deletions(-)
>  create mode 100644 scripts/mod/symsearch.c
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index c9e38ad937fd..3c54125eb373 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o +=3D $(CC_FLAGS_LTO)
>  hostprogs-always-y     +=3D modpost mk_elfconfig
>  always-y               +=3D empty.o
>
> -modpost-objs   :=3D modpost.o file2alias.o sumversion.o
> +modpost-objs   :=3D modpost.o file2alias.o sumversion.o symsearch.o
>
>  devicetable-offsets-file :=3D devicetable-offsets.h
>
> @@ -16,7 +16,7 @@ targets +=3D $(devicetable-offsets-file) devicetable-of=
fsets.s
>
>  # dependencies on generated files need to be listed explicitly
>
> -$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconf=
ig.h
> +$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o $(obj)/symsearc=
h.o: $(obj)/elfconfig.h
>  $(obj)/file2alias.o: $(obj)/$(devicetable-offsets-file)
>
>  quiet_cmd_elfconfig =3D MKELF   $@
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index de499dce5265..975f235aca2c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -22,7 +22,6 @@
>  #include <errno.h>
>  #include "modpost.h"
>  #include "../../include/linux/license.h"
> -#include "../../include/linux/module_symbol.h"
>
>  static bool module_enabled;
>  /* Are we using CONFIG_MODVERSIONS? */
> @@ -577,11 +576,14 @@ static int parse_elf(struct elf_info *info, const c=
har *filename)
>                         *p =3D TO_NATIVE(*p);
>         }
>
> +       symsearch_init(info);
> +
>         return 1;
>  }
>
>  static void parse_elf_finish(struct elf_info *info)
>  {
> +       symsearch_finish(info);
>         release_file(info->hdr, info->size);
>  }
>
> @@ -1039,65 +1041,13 @@ static int secref_whitelist(const char *fromsec, =
const char *fromsym,
>         return 1;
>  }
>
> -/*
> - * If there's no name there, ignore it; likewise, ignore it if it's
> - * one of the magic symbols emitted used by current tools.
> - *
> - * Otherwise if find_symbols_between() returns those symbols, they'll
> - * fail the whitelist tests and cause lots of false alarms ... fixable
> - * only by merging __exit and __init sections into __text, bloating
> - * the kernel (which is especially evil on embedded platforms).
> - */
> -static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> -{
> -       const char *name =3D elf->strtab + sym->st_name;
> -
> -       if (!name || !strlen(name))
> -               return 0;
> -       return !is_mapping_symbol(name);
> -}
> -
>  /* Look up the nearest symbol based on the section and the address */
>  static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
>                                  unsigned int secndx, bool allow_negative=
,
>                                  Elf_Addr min_distance)
>  {
> -       Elf_Sym *sym;
> -       Elf_Sym *near =3D NULL;
> -       Elf_Addr sym_addr, distance;
> -       bool is_arm =3D (elf->hdr->e_machine =3D=3D EM_ARM);
> -
> -       for (sym =3D elf->symtab_start; sym < elf->symtab_stop; sym++) {
> -               if (get_secindex(elf, sym) !=3D secndx)
> -                       continue;
> -               if (!is_valid_name(elf, sym))
> -                       continue;
> -
> -               sym_addr =3D sym->st_value;
> -
> -               /*
> -                * For ARM Thumb instruction, the bit 0 of st_value is se=
t
> -                * if the symbol is STT_FUNC type. Mask it to get the add=
ress.
> -                */
> -               if (is_arm && ELF_ST_TYPE(sym->st_info) =3D=3D STT_FUNC)
> -                        sym_addr &=3D ~1;
> -
> -               if (addr >=3D sym_addr)
> -                       distance =3D addr - sym_addr;
> -               else if (allow_negative)
> -                       distance =3D sym_addr - addr;
> -               else
> -                       continue;
> -
> -               if (distance <=3D min_distance) {
> -                       min_distance =3D distance;
> -                       near =3D sym;
> -               }
> -
> -               if (min_distance =3D=3D 0)
> -                       break;
> -       }
> -       return near;
> +       return symsearch_find_nearest(elf, addr, secndx,
> +                                     allow_negative, min_distance);
>  }
>
>  static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 5f94c2c9f2d9..6413f26fcb6b 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -10,6 +10,7 @@
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <elf.h>
> +#include "../../include/linux/module_symbol.h"
>
>  #include "list.h"
>  #include "elfconfig.h"
> @@ -128,6 +129,8 @@ struct elf_info {
>          * take shndx from symtab_shndx_start[N] instead */
>         Elf32_Word   *symtab_shndx_start;
>         Elf32_Word   *symtab_shndx_stop;
> +
> +       struct symsearch *symsearch;
>  };
>
>  /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
> @@ -154,6 +157,28 @@ static inline unsigned int get_secindex(const struct=
 elf_info *info,
>         return index;
>  }
>
> +/*
> + * If there's no name there, ignore it; likewise, ignore it if it's
> + * one of the magic symbols emitted used by current tools.
> + *
> + * Internal symbols created by tools should be ignored by modpost.
> + */
> +static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
> +{
> +       const char *name =3D elf->strtab + sym->st_name;
> +
> +       if (!name || !strlen(name))
> +               return 0;
> +       return !is_mapping_symbol(name);
> +}
> +
> +/* symsearch.c */
> +void symsearch_init(struct elf_info *elf);
> +void symsearch_finish(struct elf_info *elf);
> +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> +                               unsigned int secndx, bool allow_negative,
> +                               Elf_Addr min_distance);
> +
>  /* file2alias.c */
>  void handle_moddevtable(struct module *mod, struct elf_info *info,
>                         Elf_Sym *sym, const char *symname);
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
> +
> +#include "modpost.h"
> +
> +/* Struct used for binary search. */
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
> +
> +static inline bool is_sym_searchable(struct elf_info *elf, Elf_Sym *sym)
> +{
> +       return is_valid_name(elf, sym) !=3D 0;
> +}
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
> +       bool hi_is_usable =3D false;
> +       bool lo_is_usable =3D false;
> +       Elf_Addr hi_distance =3D -1;  // max Elf_Addr
> +       Elf_Addr lo_distance =3D -1;  // max Elf_Addr
> +       Elf_Addr min_distance_lo =3D min_distance;
> +       Elf_Addr min_distance_hi =3D allow_negative ? min_distance : 0;
> +
> +       for (;;) {
> +               size_t mid;
> +
> +               mid =3D lo + (hi - lo) / 2;
> +               if (mid =3D=3D lo)
> +                       break;
> +               if (secndx > table[mid].section_index) {
> +                       lo =3D mid;
> +               } else if (secndx < table[mid].section_index) {
> +                       hi =3D mid;
> +               } else if (addr > table[mid].addr) {
> +                       lo =3D mid;
> +                       lo_distance =3D addr - table[mid].addr;
> +                       lo_is_usable =3D (lo_distance <=3D min_distance_l=
o);
> +               } else {
> +                       hi =3D mid;
> +                       hi_distance =3D table[mid].addr - addr;
> +                       hi_is_usable =3D (hi_distance <=3D min_distance_h=
i);
> +               }
> +       }
> +
> +       if (hi_is_usable && lo_is_usable) {
> +               lo_is_usable =3D (lo_distance <=3D hi_distance);
> +               hi_is_usable =3D (hi_distance <=3D lo_distance);
> +       }
> +
> +       if (!hi_is_usable)
> +               return lo_is_usable ? lo : 0;
> +
> +       if (hi_distance =3D=3D 0)
> +               return hi;
> +
> +       /* Match quirks of existing behavior.  Advance hi to the last
> +        * matching entry in the search table.  We don't need to worry
> +        * about running off the end of the array due to the sentinel.
> +        */
> +       while (table[hi+1].addr =3D=3D table[hi].addr &&
> +              table[hi+1].section_index =3D=3D table[hi].section_index) =
{
> +               hi++;
> +       }
> +
> +       return (lo_is_usable &&
> +               table[lo].symbol_index > table[hi].symbol_index) ? lo : h=
i;
> +}
> +
> +Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
> +                               unsigned int secndx, bool allow_negative,
> +                               Elf_Addr min_distance)
> +{
> +       size_t result =3D symsearch_find_impl(elf, addr, secndx,
> +                                           allow_negative, min_distance)=
;
> +
> +       if (result =3D=3D 0)
> +               return NULL;
> +
> +       return &elf->symtab_start[elf->symsearch->table[result].symbol_in=
dex];
> +}
> --
> 2.42.0.459.ge4e396fd5e-goog
>


--=20
Thanks,
~Nick Desaulniers
