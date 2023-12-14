Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90E98124A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjLNBeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjLNBem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:34:42 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EBCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:34:48 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-464754e1120so2287222137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702517688; x=1703122488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSsCOpQm4rGOZ8dJ8rCuCLQhoSFk4i+8PcfnNmU+diM=;
        b=nncnynOpi35n5fsdRo6yTbOGEaYuPoVuEF+Fm4WOqAtr6N2dVXj5g8+KNY8+7tH0mO
         RgMZZdUYYturCdqegCDtFSAqM4fIL1GmKN1E+xIpBDkfOk6pr91Uq4gzgCiS/nw1hn/U
         rCdXy3s4HVFD2X2uudhyitmmkki8yCFrn4vz/8021Zd3c+MRWIWMHosOOEAfmlYzTfXB
         LEm23PbtZm7IB+Gado88kmMjZPk/URI/BnY9FW5ci0nbUaxEX9CWKB9GfqXKfd4+MvX6
         MkPq8CZQgq9/YB0Qz1ncTiL7W8yvgS603DyYe1xx8dyxHQF+CB/9167Byeqg9kQCdmtG
         6pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517688; x=1703122488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSsCOpQm4rGOZ8dJ8rCuCLQhoSFk4i+8PcfnNmU+diM=;
        b=GGQWfY6SZnSrhzUutOUntEMRpd3uC3L4yUreL3QOw/WBS9MbmUnkH7TwT0vb8RjE4Y
         zW1GHYN3W7/1dW/eWVnPkuI5xkg16MyzjvRI2A+OQYd4p/HIiUJb4/3I0TLko1IrwUl+
         bf+QweXrkr0SgGJhyXyR19TZRNGaI48UB2z/xL6i4ReH/B+4vWp7UMrakvl5FZhx+0Q0
         NkeasPeEGrjL9dtyhLTh1Xv9ll11C/o1QKoJVIAT1Qd8OtIqwIN7+Pv2kwReKLsrELOn
         Rjf67WG2TyF7uTVdknuGZaY02Qe4mjpWu9TWSzkCK4rrvhv7I4jYqHCW3IEnPSpkpXAc
         6qrQ==
X-Gm-Message-State: AOJu0Yyp6gHBAy7xxAQlv3+d+3jEcNeA0+8oCrEpRUVaJAEPj3A0Qo5D
        MLzQK9f5+6YvQqPFYbxWSddY05TxjmA0JhmmWMK9vgLMLmAjaQ==
X-Google-Smtp-Source: AGHT+IF0f58ox2Go0izpph3/lXGL4DIhmtGxUOksIbF/sfhoXjAlpoo4updml0aSDurDx2cMNZkFHMEg0hoBHZDOyM0=
X-Received: by 2002:a05:6102:38c7:b0:464:7eeb:107f with SMTP id
 k7-20020a05610238c700b004647eeb107fmr6796687vst.12.1702517687951; Wed, 13 Dec
 2023 17:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20231206110054.61617-1-v-songbaohua@oppo.com> <20231213130231.ksban2ovad4q4rxj@techsingularity.net>
In-Reply-To: <20231213130231.ksban2ovad4q4rxj@techsingularity.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 14 Dec 2023 09:34:35 +0800
Message-ID: <CAGsJ_4zYq2d757BBeQ=2HhksdChvK_i+Srp_Rxw3tcu4YWEcNQ@mail.gmail.com>
Subject: Re: [PATCH] mm: compaction: avoid fast_isolate_freepages blindly
 choose improper pageblock
To:     Mel Gorman <mgorman@techsingularity.net>, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        david@redhat.com, hannes@cmpxchg.org, huzhanyuan@oppo.com,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com,
        v-songbaohua@oppo.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 9:02=E2=80=AFPM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> On Thu, Dec 07, 2023 at 12:00:54AM +1300, Barry Song wrote:
> > Testing shows fast_isolate_freepages can blindly choose an unsuitable
> > pageblock from time to time particularly while the min mark is used
> > from XXX path:
> >  if (!page) {
> >          cc->fast_search_fail++;
> >          if (scan_start) {
> >                  /*
> >                   * Use the highest PFN found above min. If one was
> >                   * not found, be pessimistic for direct compaction
> >                   * and use the min mark.
> >                   */
> >                  if (highest >=3D min_pfn) {
> >                          page =3D pfn_to_page(highest);
> >                          cc->free_pfn =3D highest;
> >                  } else {
> >                          if (cc->direct_compaction && pfn_valid(min_pfn=
)) { /* XXX */
> >                                  page =3D pageblock_pfn_to_page(min_pfn=
,
> >                                          min(pageblock_end_pfn(min_pfn)=
,
> >                                              zone_end_pfn(cc->zone)),
> >                                          cc->zone);
> >                                  cc->free_pfn =3D min_pfn;
> >                          }
> >                  }
> >          }
> >  }
> >
> > The reason is that no code is doing any check on the min_pfn
> >  min_pfn =3D pageblock_start_pfn(cc->free_pfn - (distance >> 1));
> >
> > In contrast, slow path of isolate_freepages() is always skipping unsuit=
able
> > pageblocks in a decent way.
> >
> > This issue doesn't happen quite often. When running 25 machines with 16=
GiB
> > memory for one night, most of them can hit this unexpected code path.
> > However the frequency isn't like many times per second. It might be one
> > time in a couple of hours. Thus, it is very hard to measure the visible
> > performance impact in my machines though the affection of choosing the
> > unsuitable migration_target should be negative in theory.
> >
> > I feel it's still worth fixing this to at least make the code theoretic=
ally
> > self-explanatory as it is quite odd an unsuitable migration_target can =
be
> > still migration_target.
> >
> > Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Hi Mel,
Thanks!

Hi Andrew,
Given this patch has been in mm-stable,
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
stable&id=3Dd19b1a1797
does it still have a chance to collect Mel's tag=EF=BC=9F

>
> --
> Mel Gorman
> SUSE Labs

Thanks
Barry
