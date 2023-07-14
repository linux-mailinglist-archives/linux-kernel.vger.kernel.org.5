Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04231752F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjGNCVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGNCV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:21:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93282726
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:21:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701eaf0d04so12348217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689301286; x=1691893286;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPT21jJ10K5al6d1WRqyD1dKmIh1g9KwXfoxEHj+CKQ=;
        b=Qrk063lVDJXohNNs69c6BnwN4Tp7O34uuBstMu87PDyYA/7es76kn2yYqgEwpFYf6P
         q8Fc5hrJasmDjGjBDY6YBpmn7IqgWFLPI68Yz1ppHdJhK4TlFJJYMRfkJGUEV5tWyXug
         fOVIDNxv2Y3ckJkGx2HfQ/1KtRXLwAldokIjAgMSUxKwKBNnTAaYTK5C5+JG+1F0ooQj
         TIPQR3Lv/LgI+e5+buQkNjRG8ZVlnyxH8ICUZVNdjb4+IHXI38eqi9GFKYZHhuiz9BQk
         CVEuB02N1sHTxLQKlNWTgxkTZ7nHCYEUc2mtRCONfe71LB9rt8H41YG/9Cr6OZs/YbgV
         dn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301286; x=1691893286;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPT21jJ10K5al6d1WRqyD1dKmIh1g9KwXfoxEHj+CKQ=;
        b=TQCSsDobamjEmVVtf3WX00A7q2yCPX3xjczaRsu5rSBhdwFoKnlJ+vwhv8YiqE4q8E
         SfoaDi3eOIcsbSFzECmlpg3h42gg966qbQt3647gTglMHd1VwHYe0kxElmJ11CsSG4UC
         ZmzsPIMlWqjKfBRSSWmsKCxn5ll2Ir/NhiyN87pYGn2rxh9ZKYXr6S5z8xROQ0vvuqvS
         2b4GHlyOyiQL2ODf5UakTzSTiH4/aOnm8sJp48q+Ycxo+R90wtjZyrRdnynfaFsVu5Wi
         KxEoAaKMOmL2DpO5Ks/+0tfOKV0Hjpv3flTgcAxTVcn4dPNiP5O7Nizu+Q0BFNVZuQid
         PzeQ==
X-Gm-Message-State: ABy/qLbPp60OPcU8Dd0FDZW1tJuAF55VZ5oKaT/zKWHnRBH6hH4pI58i
        Gds58oo38LvJI6PW2wDGIJ/Ibw==
X-Google-Smtp-Source: APBJJlHAkOo/DcpF03vqEFA5G8IaQaPqkQIrTI44airjaZ4v8GZWz1EXsKa3qZWCTT3u3uVIWLNUlg==
X-Received: by 2002:a0d:e812:0:b0:57a:504a:e019 with SMTP id r18-20020a0de812000000b0057a504ae019mr3443519ywe.20.1689301284364;
        Thu, 13 Jul 2023 19:21:24 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c23-20020a814e17000000b0057726fce046sm2062661ywb.26.2023.07.13.19.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:21:23 -0700 (PDT)
Date:   Thu, 13 Jul 2023 19:21:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yin Fengwei <fengwei.yin@intel.com>
cc:     Yu Zhao <yuzhao@google.com>, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, david@redhat.com, ryan.roberts@arm.com,
        shy828301@gmail.com
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
In-Reply-To: <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
Message-ID: <6573e671-62e-b7b9-1aae-64336c32bf1@google.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-3-fengwei.yin@intel.com> <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com> <6cc5a915-a28c-983f-9b32-6040f033970b@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-755330418-1689301283=:3952"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-755330418-1689301283=:3952
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Jul 2023, Yin Fengwei wrote:
> On 7/12/23 14:23, Yu Zhao wrote:
> > On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel=
=2Ecom> wrote:
> >> --- a/mm/internal.h
> >> +++ b/mm/internal.h
> >> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *f=
olio,
> >>          *    still be set while VM_SPECIAL bits are added: so ignore =
it then.
> >>          */
> >>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D V=
M_LOCKED) &&
> >> -           (compound || !folio_test_large(folio)))
> >> +           (compound || !folio_test_large(folio) ||
> >> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
> >>                 mlock_folio(folio);
> >>  }
> >=20
> > This can be simplified:
> > 1. remove the compound parameter
> Yes. There is not difference here for pmd mapping of THPs and pte mapping=
s of THPs
> if the only condition need check is whether the folio is within VMA range=
 or not.
>=20
> But let me add Huge for confirmation.

I'm not sure what it is that you need me to confirm: if the folio fits
within the vma, then the folio fits within the vma, pmd-mapped or not.

(And I agree with Yu that it's better to drop the folio_test_large()
check too.)

This idea, of counting the folio as mlocked according to whether the
whole folio fits within the vma, does seem a good idea to me: worth
pursuing.  But whether the implementation adds up and works out, I
have not checked.  It was always difficult to arrive at a satisfactory
compromise in mlocking compound pages: I hope this way does work out.

Hugh
---1463760895-755330418-1689301283=:3952--
