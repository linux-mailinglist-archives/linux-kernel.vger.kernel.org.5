Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2D7ACC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjIXWUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIXWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:20:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695AFA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:20:25 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-351367c1c24so94695ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695594025; x=1696198825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FtajYu0QcSwr5TLL107KfjFB5NdN5A4TVIBLzbOzHAo=;
        b=S4CVZ+wj3ceJTGjp/WFPbJquNHD+z7r6ELGP7cj+R3ZmCuMBKw5PC/O3htH9IFtkLX
         ZYNtvHoWkwtoxVX0BpQplBm7TLCuxWgnl20i3I1AqByfEyUuQSom+IQQP3w5qkiUKVz1
         0arHtV5hRG11SHWTe/8AJ77M156ZhKcc76oU++WXRHL7QpXbqrspizOt998f01f5xHDX
         J5Gs0pb4Umh3T52dzJ/5wEmQKCAp2TUASyIeD4K4ASifzLzcDx+sWmC6uQg4kNqUJMuh
         NbJTc4SuhO0f/tYHSuT70ea8Pbx3sVeXgDOVwI0Hbb9TBgovOpPeIseDCa5N5jGRbAIN
         E+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695594025; x=1696198825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtajYu0QcSwr5TLL107KfjFB5NdN5A4TVIBLzbOzHAo=;
        b=RivUnCCiJOL8J6C7Ps+L6RMfsYIxZ4Y2xHKVPkksPAAiRtbuhFE8gLEq9rUAUGmotK
         lXVMCjUd+r3hXlApXuQu84Gw9GR82GzdssEGNle/tUWpNaotdSgN5EYZ6374lYUmrx0j
         wlex07svv+ariMtjTeI95/gZq+b9yz/o1Z2FsqDF/GUsobXwfO5cbKoD1E2EYCA8naG6
         vmawGWC4PYfwTusCCG9bElcMf5sbMlYYbRiBYh/IvUC1pG0f2aLBJuEUZFI3F/4vWsRQ
         zpBMZbO/R2QtJtrPQ3f8mfsVQt7lMbDeX8hNrr8YwFP+wA9J3uPgM483KhORqy2ILG0U
         4K+g==
X-Gm-Message-State: AOJu0Yz9vsaI6+SijF5WxNOKzvUxKVTpsm0G5SQAsr+csUKayg0ZqhQk
        7pgCR3WmMrQBkbWkBd2l1mbquQ==
X-Google-Smtp-Source: AGHT+IGLf53RDLgRjFbrmrfUiXjsToOCQ7VJ2K6mWLfN3wnfdUtVszHybWV0wDxF6e33hfggAIXp5w==
X-Received: by 2002:a05:6e02:2199:b0:34d:f90f:d42a with SMTP id j25-20020a056e02219900b0034df90fd42amr322242ila.1.1695594024785;
        Sun, 24 Sep 2023 15:20:24 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:205:f843:c1bc:4b42:fda0])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e81000b001bf6ea340a9sm7274343plg.159.2023.09.24.15.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 15:20:24 -0700 (PDT)
Date:   Sun, 24 Sep 2023 15:20:19 -0700
From:   Fangrui Song <maskray@google.com>
To:     Jack Brennen <jbrennen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] modpost: Optimize symbol search from linear to binary
 search
Message-ID: <20230924222019.dipusbpgntepnq2y@google.com>
References: <20230918210631.3882376-1-jbrennen@google.com>
 <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-23, Masahiro Yamada wrote:
>On Tue, Sep 19, 2023 at 6:06 AM Jack Brennen <jbrennen@google.com> wrote:
>>
>> Modify modpost to use binary search for converting addresses back
>> into symbol references.  Previously it used linear search.
>>
>> This change saves a few seconds of wall time for defconfig builds,
>> but can save several minutes on allyesconfigs.
>
>Thanks.
>Binary search is a good idea.
>
>
>> Before:
>> $ make LLVM=1 -j128 allyesconfig vmlinux -s KCFLAGS="-Wno-error"
>>         Elapsed (wall clock) time (h:mm:ss or m:ss): 13:30.31
>
>Instead of the time for the entire build,
>can you put the time for the modpost command?
>
>If you allyesconfig case,
>
> $ time scripts/mod/modpost -M -m -a -N -o vmlinux.symvers vmlinux.o
>
>
>
>
>
>> diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
>> new file mode 100644
>> index 000000000000..aab79262512b
>> --- /dev/null
>> +++ b/scripts/mod/symsearch.c
>> @@ -0,0 +1,233 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/* Helper functions for finding the symbol in an ELF which is "nearest"
>> + * to a given address.
>> + */
>>
>
>Can you use the following block comment style?
>
>/*
> * Helper functions for finding the symbol in an ELF which is "nearest"
> * to a given address.
> */
>
>
>
>> +#include "modpost.h"
>> +
>> +/* Struct used for binary search. */
>
>I think this obvious comment is unneeded.
>
>
>
>> +struct syminfo {
>> +       unsigned int symbol_index;
>> +       unsigned int section_index;
>> +       Elf_Addr addr;
>> +};
>> +
>> +/* Container used to hold an entire binary search table.
>> + * Entries in table are ascending, sorted first by section_index,
>> + * then by addr, and last by symbol_index.  The sorting by
>> + * symbol_index is used to duplicate the quirks of the prior
>> + * find_nearest_sym() function, where exact matches to an address
>> + * return the first symtab entry seen, but near misses return the
>> + * last symtab entry seen.
>
>Preserving this quirk makes the code complicated.
>
>I do not mind changing the behavior of the corner case.
>
>
>
>
>
>> + * The first and last entries of the table are sentinels and their
>> + * values only matter in two places:  when we sort the table, and
>> + * on lookups, the end sentinel should not have an addr field which
>> + * matches its immediate predecessor.  To meet these requirements,
>> + * we initialize them to (0,0,0) and (max,max,max), and then after
>> + * sorting, we tweak the end sentinel's addr field accordingly.
>> + */
>> +struct symsearch {
>> +       size_t table_size;
>> +       struct syminfo table[];
>> +};
>
>
>
>syminfo::symbol_index is unsigned int.
>symsearch::table_size is size_t.
>
>
>symbol_index of the last element is always larger than
>elf->symsearch->table_size.
>
>So, the code works only within 32-bit width anyway.
>
>
>
>
>
>
>
>
>
>
>
>
>> +
>> +static inline bool is_sym_searchable(struct elf_info *elf, Elf_Sym *sym)
>> +{
>> +       return is_valid_name(elf, sym) != 0;
>> +}
>
>If you call is_valid_name() directly, this function was unneeded?
>
>
>
>
>
>
>> +
>> +static int syminfo_compare(const void *s1, const void *s2)
>> +{
>> +       const struct syminfo *sym1 = s1;
>> +       const struct syminfo *sym2 = s2;
>> +
>> +       if (sym1->section_index > sym2->section_index)
>> +               return 1;
>> +       if (sym1->section_index < sym2->section_index)
>> +               return -1;
>> +       if (sym1->addr > sym2->addr)
>> +               return 1;
>> +       if (sym1->addr < sym2->addr)
>> +               return -1;
>> +       if (sym1->symbol_index > sym2->symbol_index)
>> +               return 1;
>> +       if (sym1->symbol_index < sym2->symbol_index)
>> +               return -1;
>> +       return 0;
>> +}
>> +
>> +static size_t symbol_count(struct elf_info *elf)
>> +{
>> +       size_t result = 0;
>> +
>> +       for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
>> +               if (is_sym_searchable(elf, sym))
>> +                       result++;
>> +       }
>> +       return result;
>> +}
>> +
>> +/* Populate the search array that we just allocated.
>> + * Be slightly paranoid here.  If the ELF file changes during processing,
>
>I could not understand. In which case, the ELF file changes?
>
>modpost loads the entire file to memory first..
>
>In which scenario, the memory content changes?
>
>
>
>
>
>
>> + * or if the behavior of is_sym_searchable() changes during processing,
>> + * we want to catch it; neither of those is acceptable.
>> + */
>> +static void symsearch_populate(struct elf_info *elf,
>> +                              struct syminfo *table,
>> +                              size_t table_size)
>> +{
>> +       bool is_arm = (elf->hdr->e_machine == EM_ARM);
>> +
>> +       /* Start sentinel */
>> +       if (table_size-- == 0)
>> +               fatal("%s: size mismatch\n", __func__);
>> +       table->symbol_index = 0;
>> +       table->section_index = 0;
>> +       table->addr = 0;
>> +       table++;
>> +
>> +       for (Elf_Sym *sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
>> +               if (is_sym_searchable(elf, sym)) {
>> +                       if (table_size-- == 0)
>> +                               fatal("%s: size mismatch\n", __func__);
>> +                       table->symbol_index = sym - elf->symtab_start;
>> +                       table->section_index = get_secindex(elf, sym);
>> +                       table->addr = sym->st_value;
>> +
>> +                       /*
>> +                        * For ARM Thumb instruction, the bit 0 of st_value is
>> +                        * set if the symbol is STT_FUNC type. Mask it to get
>> +                        * the address.
>> +                        */
>> +                       if (is_arm && ELF_ST_TYPE(sym->st_info) == STT_FUNC)
>> +                               table->addr &= ~1;
>> +
>> +                       table++;
>> +               }
>> +       }
>> +
>> +       /* End sentinel; all values are unsigned so -1 wraps to max */
>> +       if (table_size != 1)
>> +               fatal("%s: size mismatch\n", __func__);
>> +       table->symbol_index = -1;
>> +       table->section_index = -1;
>> +       table->addr = -1;
>> +}
>> +
>> +void symsearch_init(struct elf_info *elf)
>> +{
>> +       /* +2 here to allocate space for the start and end sentinels */
>> +       size_t table_size = symbol_count(elf) + 2;
>> +
>> +       elf->symsearch = NOFAIL(malloc(
>> +                                       sizeof(struct symsearch) +
>> +                                       sizeof(struct syminfo) * table_size));
>> +       elf->symsearch->table_size = table_size;
>> +
>> +       symsearch_populate(elf, elf->symsearch->table, table_size);
>> +       qsort(elf->symsearch->table, table_size,
>> +             sizeof(struct syminfo), syminfo_compare);
>> +
>> +       /* A bit of paranoia; make sure that the end sentinel's address is
>> +        * different than its predecessor.  Not doing this could cause
>> +        * possible undefined behavior if anybody ever inserts a symbol
>> +        * with section_index and addr both at their max values.
>
>I could not understand this comment.
>
>If section_index and addr both at their max values at [table_size - 2],
>->table[table_size - 2].addr + 1 wraps to zero.
>
>The table is not sorted any longer?
>
>
>
>
>> +        * Doing this little bit of defensive programming is more efficient
>> +        * than checking for array overruns later.
>> +        */
>> +       elf->symsearch->table[table_size - 1].addr =
>> +               elf->symsearch->table[table_size - 2].addr + 1;
>> +}
>> +
>> +void symsearch_finish(struct elf_info *elf)
>> +{
>> +       free(elf->symsearch);
>> +       elf->symsearch = NULL;
>> +}
>> +
>> +/* Find the syminfo which is in secndx and "nearest" to addr.
>> + * allow_negative: allow returning a symbol whose address is > addr.
>> + * min_distance: ignore symbols which are further away than this.
>> + *
>> + * Returns a nonzero index into the symsearch table for success.
>> + * Returns NULL if no legal symbol is found within the requested range.
>> + */
>> +static size_t symsearch_find_impl(struct elf_info *elf, Elf_Addr addr,
>> +                                 unsigned int secndx, bool allow_negative,
>> +                                 Elf_Addr min_distance)
>> +{
>> +       /* Find the target in the array; it will lie between two elements.
>> +        * Invariant here: table[lo] < target <= table[hi]
>> +        * For the purposes of search, exact hits in the search array are
>> +        * considered greater than the target.  This means that if we do
>> +        * get an exact hit, then once the search terminates, table[hi]
>> +        * will be the exact match which has the lowest symbol index.
>> +        */
>> +       struct syminfo *table = elf->symsearch->table;
>> +       size_t hi = elf->symsearch->table_size - 1;
>> +       size_t lo = 0;
>
>
>
>
>The binary search code was implemented in a too complex way
>to preserve the previous quirks.
>
>
>I want to use the same comparison function for
>qsort() and bsearch() to avoid paranoia.
>
>
>
>
>How about this implementation?
>
>
>
>static struct syminfo *symsearch_find_impl(struct elf_info *elf, Elf_Addr addr,
>                                           unsigned int secndx, bool
>allow_negative,
>                                           Elf_Addr min_distance)
>{
>        struct syminfo target = { .symbol_index = -1, .section_index =
>secndx, .addr = addr };
>        struct syminfo *table = elf->symsearch->table;
>        unsigned int hi = elf->symsearch->table_size - 1;
>        unsigned int lo = 0;
>        struct syminfo *result = NULL;
>        Elf_Addr distance;
>
>        while (lo < hi) {
>                unsigned int mid = (lo + hi + 1) / 2;
>
>                if (syminfo_compare(&table[mid], &target) > 0)
>                        hi = mid - 1;
>                else
>                        lo = mid;
>        }
>
>        /*
>         * The target resides between lo and (lo + 1).
>         * If allow_negative is true, check both of them.
>         */
>
>        if (allow_negative && lo + 1 < elf->symsearch->table_size &&
>            table[lo + 1].section_index == secndx) {
>                distance = table[lo + 1].addr - addr;
>                if (distance <= min_distance) {
>                        min_distance = distance;
>                        result = &table[lo + 1];
>                }
>        }
>
>        if (table[lo].section_index == secndx) {
>                distance = addr - table[lo].addr;
>                if (distance <= min_distance)
>                  result = &table[lo];
>        }
>
>        return result;
>}

I think this implementation (shrinking [lo,hi] to [lo,mid-1] or
[mid,hi]) is better than the original one (shrinking [lo,hi] to [lo,mid]
or [mid,hi], a bit wasteful).

The original patch uses `if (mid == lo) break;`, which I consider not so
elegant.

However, the `- 1` part in `unsigned int hi = elf->symsearch->table_size - 1;` can be improved.
I'd prefer an implementation similar to typical C++ https://en.cppreference.com/w/cpp/algorithm/upper_bound implementation.

lo = 0;
hi = n;  // or replace hi with count
while (lo < hi) {
   mid = (lo + hi) / 2;  // we don't care about (lo+hi) overflow
   if (less_or_eq(&table[mid], &target))
     lo = mid+1;
   else
     hi = mid;
}

// lo == hi: the index of the first element that is > target
// if elements equal to target are present, they are on the left of lo

>Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
>                                unsigned int secndx, bool allow_negative,
>                                Elf_Addr min_distance)
>{
>        struct syminfo *result;
>
>        result = symsearch_find_impl(elf, addr, secndx,
>                                     allow_negative, min_distance);
>        if (!result)
>                return NULL;
>
>        return &elf->symtab_start[result->symbol_index];
>}
>
>
>
>This does not preserve the previous quirks.
>
>If there are multiple entries with the same address,
>it always returns the last element.
>
>I did not expect sentinels.
>
>I did not do thorough tests, but it seems to be working for me.
>
>
>
>
>Also, please call symsearch_find_nearest() directly
>and remove symfind_nearest_sym().
>
>
>
>
>
>
>--
>Best Regards
>
>Masahiro Yamada
>
