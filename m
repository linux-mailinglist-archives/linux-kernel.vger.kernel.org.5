Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE687ADA05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjIYOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjIYOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:24:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B8C0;
        Mon, 25 Sep 2023 07:24:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ED8C433C7;
        Mon, 25 Sep 2023 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695651877;
        bh=xoy/PRtJGyTbhpbADl4SNs8tYLCaI3ks/iyqy+0+WbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BPQAoa25D+eDfXxxIHJECqiejVL/kWK0sBraMw0QMOx3LGicl/aw0gQ9Ok+XFfD7Q
         C8tuT3YLfzmYNKL1Hb3KqQMMZLKnwszqNrUs5vh/xO0gj6+//CxcMpe9/4sqyUPNpi
         TP4Q504evYfajlNyyZqfERgGEemINs+32IbrpR9qrFJG6n7WaNW0rLuZetgl7LMlHD
         0HBmYQEVVZyy5wA/trEoJWFkWyAFOagNLlYeRQvklF6i2rqLOs0RIlgKzna77JjKb0
         D85alCi+tOOs06NdIprgUVoGlf0v9QG33zONO4HRzXW282havsH/h7rU/VfONEErUp
         seNGczH19I09g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso225125fac.0;
        Mon, 25 Sep 2023 07:24:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjEvEZQWotLeJCrgTBu+gbpNVnGHElutzLdxVduSJFzZctUrAv
        cjcAjhuCvcpnCahEgO0x9Wn4Jjwkuu5RPX1I/ak=
X-Google-Smtp-Source: AGHT+IH6fd4r3hn1r8JFtfJHlpX3dqpD6ut4fpumAnhPM5D4ZV1DRZoLfhx0jdrga/RpH8ZxGlBsfemxsNY8LGiFtpg=
X-Received: by 2002:a05:6870:a408:b0:1d6:5f77:5127 with SMTP id
 m8-20020a056870a40800b001d65f775127mr6061901oal.5.1695651876433; Mon, 25 Sep
 2023 07:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230918210631.3882376-1-jbrennen@google.com> <CAK7LNASSgCFYequw+0zQpUC-9yLHvJLHZ97Ko1ejUYZVTkM81w@mail.gmail.com>
 <CAF5hLgJOMJ70whVsPhZgsiVGYv10S8mpXvzY1HnreV6X4oZg4A@mail.gmail.com>
In-Reply-To: <CAF5hLgJOMJ70whVsPhZgsiVGYv10S8mpXvzY1HnreV6X4oZg4A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Sep 2023 23:23:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHTjzU4dG8ES6BjtUQv-vq50Lh1ZmBW3kv4K3zkF-SGg@mail.gmail.com>
Message-ID: <CAK7LNATHTjzU4dG8ES6BjtUQv-vq50Lh1ZmBW3kv4K3zkF-SGg@mail.gmail.com>
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

On Sun, Sep 24, 2023 at 2:21=E2=80=AFAM Jack Brennen <jbrennen@google.com> =
wrote:
>
> Mainly just clarifying that we're willing to change the behavior in corne=
r
> cases?


Yes.

I do not see a sensible reason in the previous quirk
(take the first for the exact match, but the last for others).




> The existing behavior has one set of quirks about which symtab entry
> is returned, and your proposed behavior has another different set of quir=
ks.
>
> It's probably OK to break builds which have an undocumented assumption
> about the order of symtab entries; personally, I'd rather not risk that m=
yself,
> but if somebody with more experience is willing to back that decision, I'=
m
> OK with it.
>
> Also, there's an alternative approach that uses bsearch from the standard
> library and a common comparison function between qsort and bsearch. I
> considered this alternative earlier; maybe you would prefer it because it
> eliminates having to reimplement a binary search algorithm.
> I chose not to do it this way because of trying to duplicate the quirks.
> If no duplication of the quirks is needed, this becomes easier.
>
> The idea for that is to build a sorted array of syminfo that look like th=
is:
>
> (section_index, addr_lo, addr_hi, sym_lo, sym_hi)
>
> What this represents is the situation where for any lookup in the
> range from (section_index, addr_lo) to (section_index, addr_hi)
> inclusive, the nearest symbol will be either sym_lo or sym_hi.
> There are four different meanings for (sym_lo, sym_hi):
>
> (sym_lo =3D 0)
> This is a placeholder for a duplicated address, and it cannot
> compare equal to anything. After we sort the array, we set all
> of the duplicated addresses except for the last one to sym_lo =3D 0.
>
> (sym_lo =3D MAX_SYM)
> This is used to designate an address being looked up. When this
> is seen, it compares equal to any other syminfo that has an
> overlapping range.
>
> (sym_lo !=3D 0, sym_hi =3D 0)
> This represents the last range in a section. There's no following
> address that could match. Should also have addr_hi =3D MAX.
>
> (sym_lo !=3D 0, sym_hi !=3D 0)
> This represents a range in a section that's not the last range.
> sym_hi may be usable to satisfy the lookup, but only if it's
> closer than sym_lo and if allow_negative is true. Note that
> the address of sym_hi will be addr_hi+1, so we don't need any
> additional code to fetch that address.
>
> Here's a sample comparison function:
> int syminfo_compare(const void *a, const void *b) {
>   const struct syminfo *sym1 =3D a;
>   const struct syminfo *sym2 =3D b;
>
>   if (sym1->section_index > sym2->section_index)
>     return 1;
>   if (sym1->section_index < sym2->section_index)
>     return -1;
>   if ((sym1->sym_lo =3D=3D MAX_SYM && sym2->sym_lo !=3D 0) ||
>       (sym2->sym_lo =3D=3D MAX_SYM && sym1->sym_lo !=3D 0)) {
>     /* Overlap is equality - test for it */
>     if (sym1->addr_hi >=3D sym2->addr_lo &&
>         sym2->addr_hi >=3D sym1->addr_lo) {
>       return 0;
>     }
>     /* No overlap, fall through */
>   }
>   if (sym1->addr_lo > sym2->addr_lo)
>     return 1;
>   if (sym1->addr_lo < sym2->addr_lo)
>     return -1;
>   /* Note that if we are comparing a lookup (MAX_SYM) with
>      a placeholder (0), the lookup always compares greater.
>      This causes us to search to the "right" of the placeholder
>      for a match, which is what we want. */
>   if (sym1->sym_lo > sym2->sym_lo)
>     return 1;
>   if (sym1->sym_lo < sym2->sym_lo)
>     return -1;
>   return 0;
> }
>
> So this greatly simplifies the back-end searching. It's a bsearch()
> which gives you either a miss, or one or two alternatives for the result.
> On the front end, you have an extra step after sorting which massages the
> search array into the right configuration.  There's actually not much cod=
e
> needed to do that.
>
> Is that of interest?  The leveraging of bsearch() in that way?


I am curious about how to use bsearch() if the whole implementation
is short, but I could not understand that logic fully.




> A few other responses below...
>
> On Sat, Sep 23, 2023 at 4:50=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> > > +/* Populate the search array that we just allocated.
> > > + * Be slightly paranoid here.  If the ELF file changes during proces=
sing,
> >
> > I could not understand. In which case, the ELF file changes?
> >
> > modpost loads the entire file to memory first..
> >
> > In which scenario, the memory content changes?
> >
>
> modpost doesn't load the entire file, it uses mmap to map it into the
> address space.The easiest way to imagine this being an issue is that some
> buggy parallelization happens and something is modifying vmlinux.o while
> modpost is processing it.  Of course it's probably acceptable to say,
> "Don't do that!"
>
> There are two alternatives here: actually read in the entire file, which
> is certainly suboptimal, or just live with the fact that mmap makes no
> guarantees about whether changes in the file are reflected in the memory =
map.

You are right. I missed the fact that grab_file() used mmap.

I am OK with the careful check.

Yet another possible alternative is, as Nick suggested, cut the first loop.
Use realloc() to grow the array as needed, but this is also suboptimal
if memory copy occurs.




> > > +       /* A bit of paranoia; make sure that the end sentinel's addre=
ss is
> > > +        * different than its predecessor.  Not doing this could caus=
e
> > > +        * possible undefined behavior if anybody ever inserts a symb=
ol
> > > +        * with section_index and addr both at their max values.
> >
> > I could not understand this comment.
> >
> > If section_index and addr both at their max values at [table_size - 2],
> > ->table[table_size - 2].addr + 1 wraps to zero.
> >
> > The table is not sorted any longer?
> >
>
> That's correct, the table would not be sorted any longer. But by design,
> we never do a relational comparison against the end sentinel. But if
> we rework the search, either by your suggestion or by using bsearch(),
> this sentinel goes away.

Understood.
With mid =3D lo + (hi - lo) / 2,
the last sentinel is never set as mid.



--
Best Regards
Masahiro Yamada
