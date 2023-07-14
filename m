Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE91753018
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjGNDlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNDli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:41:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7126B1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:41:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5728df0a7d9so13225067b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689306096; x=1691898096;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oq/iXCZ6KBuSs0qXrz+U2H8YMEBCPe12P27Wd/t5wvc=;
        b=o3Z1SICcLfLUodojhbg3ISOh4AV/GyLrGNzS8WFcFZFq1OnoCboClgPujTMXC1QJVk
         vqxB4X6zsRYAfNbjFHnRCL4o8KlZk6pKagsB4qdc2mJWLnSnsGh0/Wo5cOgoB3yA+ct+
         4+bhTMk2x1DESdgo7Mb2v52449B8GyfgHykmJ4siVab/Isy1Qi+QXtqL+0IDiLFjTP+G
         RESjESxnYIyUua0j0CiARuSjN9Hd5KOhsY1aUV1/lBzQWxnLnxJvugs9RpeacUof642p
         3zmlclskYlGaqSVt0vSnDT75PQXZJ6jWqlXwI5lIexSvsNIO7kSGJpfoqGIn01WmW5G4
         HEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689306096; x=1691898096;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq/iXCZ6KBuSs0qXrz+U2H8YMEBCPe12P27Wd/t5wvc=;
        b=kyZPbRtDJJlEMaAQ9diGvPTlm7UL2dVCpjmtCNTkii0el3gX11V334V8cesGLyi7x+
         dS5f5KEXWCnHMxg2lU446HdRRJkmOe+d7rAC5hPOKFjHdI1RSLAjDUWPburvBTWm227a
         gGZyZzJeYkSUj5hO4aUSBuPIdl+lb/+2IzwX5CbGGK+j5Gs3xtF1WjZ9OHIB44ECp6wb
         n3P/sX4LRY0HT0AAnAILSwkuLdZh4pxAXbVZc6PjipZgnBoYQpGWucrk3wXO2giNnAte
         rXucy2b40/iRUlQQzQO7acYbpGUgzSVCTRb49w5xdmgTaw3dKs82P1rJMNSAzflEwU8I
         wWtQ==
X-Gm-Message-State: ABy/qLa4zclg+CQkX+6yV2CmukfY2qioO5+CHTtQTlo1TUQuEcoABq4O
        n2+OOyH74TdA8yazhPAVyDp4hQ==
X-Google-Smtp-Source: APBJJlGaEUzgokNEht6uVJFioRuyVpfaqJG0CEeNs/swISJ3GMh5mJobkuEsIPpFLI6niKKhFr5VhQ==
X-Received: by 2002:a0d:d44c:0:b0:57a:89b1:2c73 with SMTP id w73-20020a0dd44c000000b0057a89b12c73mr3569828ywd.5.1689306096607;
        Thu, 13 Jul 2023 20:41:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t81-20020a0dea54000000b0056ffca5fb01sm2124142ywe.117.2023.07.13.20.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 20:41:36 -0700 (PDT)
Date:   Thu, 13 Jul 2023 20:41:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
In-Reply-To: <c7d06f91-1552-9afa-a0ae-396bc9c703d5@intel.com>
Message-ID: <7e21e99-8f8a-6f31-601c-a73ad6a0e87f@google.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-3-fengwei.yin@intel.com> <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com> <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com> <6573e671-62e-b7b9-1aae-64336c32bf1@google.com>
 <c7d06f91-1552-9afa-a0ae-396bc9c703d5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-479918679-1689306096=:4447"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-479918679-1689306096=:4447
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 14 Jul 2023, Yin, Fengwei wrote:
> On 7/14/2023 10:21 AM, Hugh Dickins wrote:
> > On Wed, 12 Jul 2023, Yin Fengwei wrote:
> >> On 7/12/23 14:23, Yu Zhao wrote:
> >>> On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>> --- a/
> >>>> +++ b/mm/internal.h
> >>>> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio =
*folio,
> >>>>          *    still be set while VM_SPECIAL bits are added: so ignor=
e it then.
> >>>>          */
> >>>>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D=
 VM_LOCKED) &&
> >>>> -           (compound || !folio_test_large(folio)))
> >>>> +           (compound || !folio_test_large(folio) ||
> >>>> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
> >>>>                 mlock_folio(folio);
> >>>>  }
> >>>
> >>> This can be simplified:
> >>> 1. remove the compound parameter
> >> Yes. There is not difference here for pmd mapping of THPs and pte mapp=
ings of THPs
> >> if the only condition need check is whether the folio is within VMA ra=
nge or not.
> >>
> >> But let me add Huge for confirmation.
> >=20
> > I'm not sure what it is that you need me to confirm: if the folio fits
> > within the vma, then the folio fits within the vma, pmd-mapped or not.
> Sorry. My bad. I should speak it out for what I want your confirmation:
>   Whether we can remove the compound and use whether folio is within
>   VMA instead.
>=20
> I suppose you answer is Yes.

Yes (if it all works out going that way).

>=20
> >=20
> > (And I agree with Yu that it's better to drop the folio_test_large()
> > check too.)
> My argument was folio_test_large() can filter the normal 4K page out so
> it doesn't need to call folio_in_range() which looks to me a little bit
> heavy for normal 4K page. And the deal was move folio_test_large()
> to folio_in_range() like function so simplify the code in caller side.

I realized that, but agree with Yu.

It looked a little over-engineered to me, but I didn't spend long enough
looking to understand why there's folio_within_vma() distinct from
folio_in_range(), when everyone(?) calls folio_in_range() with the same
arguments vma->vm_start, vma->vm_end.

>=20
> >=20
> > This idea, of counting the folio as mlocked according to whether the
> > whole folio fits within the vma, does seem a good idea to me: worth
> > pursuing.  But whether the implementation adds up and works out, I
> > have not checked.  It was always difficult to arrive at a satisfactory
> > compromise in mlocking compound pages: I hope this way does work out.
> This is the purpose of this patch. :). Thanks.
>=20
>=20
> Regards
> Yin, Fengwei
>=20
> >=20
> > Hugh
---1463760895-479918679-1689306096=:4447--
