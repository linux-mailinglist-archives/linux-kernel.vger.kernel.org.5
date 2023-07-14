Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB4752F29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjGNCJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjGNCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:09:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10B2D64
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:09:15 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so173841cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689300555; x=1691892555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaoyMod4YhQet4GlKsQo7SoI2O5v7F0iNZz73/v59vU=;
        b=MkLXXmdMYO5MjdINzkKT/vpvpgCKquPcbnWMJh7ZVyVppPkKOUFhF7vkNfx3GDSD2Y
         o3ytngfQLVehiOeiE7z84FEolHR4lnKs8Js+X8hnVPfFu5aocs88eACuhb//HqpkTxPJ
         E1B39L1s2E/FDIUjQQ4Ji4Iy6avLEF5IbWf4jjFvmVpE0h8UWefuQal7EetYynazW5Ln
         J3yhCxh29d3ibhvvX6/qJgJ+5RDB3YLAZBE3O8BhP68Gm4f5uyrGcw8Ht4MmZKXxXAL2
         Hhsg00KWx59mvRtMR7xzbqXOGUR7dQGDCv/YN0ohetR/3UVMH5Gwp+1ZezBH18jb41M4
         pj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689300555; x=1691892555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaoyMod4YhQet4GlKsQo7SoI2O5v7F0iNZz73/v59vU=;
        b=kUSkto+JA0bqxImm7RK/DFtweEjkANKVE6LyVX5qS6X+QuMqQxzbPkIRe23uv/nzsM
         3jHwQNQBNqdSjprhFWKUH8qDb9IGXgnCyBfj5meTXoUmTa5M2Bdxz+/nitrungHxxmLL
         oJk/DFxtxEnMMHM0x8QVOYc/c+qkUZsaBfzfhqgygeTHcHexQSYFi6GX/k++KNUlNGz7
         fNF0KkGvEYwnVpbOkKiuprtisLhyChh2WmEj1dEMJPOjzBkr+lTk+RAwtiFGI8eEeQgY
         +yAn0OS8274znA8FeGTovrSUwD6/DucD+JgWCm+2CySc261Ryu/6kkZ+0Ucl14IWkdwf
         KoJA==
X-Gm-Message-State: ABy/qLYeWT/HARF5AhWSRTlJvEacNr6IoVNF5z1YTHQ6ncuP1jB1cMcd
        2je39nLisEQf9fv7RYrePSk1mRrf++O54gzxSm5xYQ==
X-Google-Smtp-Source: APBJJlEPLV0bF4tbzek2jRVF22PTIoNWTDMx7dndC/6IdnzTfMMK2pzf/pL0r/5uHf0J6qv/hb/b+lg1WYFjI43wJ0I=
X-Received: by 2002:a05:622a:394:b0:3fa:45ab:22a5 with SMTP id
 j20-20020a05622a039400b003fa45ab22a5mr708987qtx.27.1689300554862; Thu, 13 Jul
 2023 19:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150558.200545-1-fengwei.yin@intel.com>
In-Reply-To: <20230713150558.200545-1-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 13 Jul 2023 20:08:38 -0600
Message-ID: <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 13, 2023 at 9:06=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Current madvise_cold_or_pageout_pte_range() has two problems for
> large folio support:
>   - Using folio_mapcount() with large folio prevent large folio from
>     picking up.
>   - If large folio is in the range requested, shouldn't split it
>     in madvise_cold_or_pageout_pte_range().
>
> Fix them by:
>   - Use folio_estimated_sharers() with large folio
>   - If large folio is in the range requested, don't split it. Leave
>     to page reclaim phase.
>
> For large folio cross boundaries of requested range, skip it if it's
> page cache. Try to split it if it's anonymous folio. If splitting
> fails, skip it.

For now, we may not want to change the existing semantic (heuristic).
IOW, we may want to stick to the "only owner" condition:

  - if (folio_mapcount(folio) !=3D 1)
  + if (folio_entire_mapcount(folio) ||
  +     (any_page_within_range_has_mapcount > 1))

+Minchan Kim

Also there is an existing bug here: the later commit 07e8c82b5eff8
("madvise: convert madvise_cold_or_pageout_pte_range() to use folios")
is incorrect for sure; the original commit 9c276cc65a58f ("mm:
introduce MADV_COLD") seems incorrect too.

+Vishal Moola (Oracle)

The "any_page_within_range_has_mapcount" test above seems to be the
only correct to meet condition claimed by the comments, before or
after the folio conversion, assuming here a THP page means the
compound page without PMD mappings (PMD-split). Otherwise the test is
always false (if it's also PMD mapped somewhere else).

  /*
   * Creating a THP page is expensive so split it only if we
   * are sure it's worth. Split it if we are only owner.
   */

> The main reason to call folio_referenced() is to clear the yong of
> conresponding PTEs. So in page reclaim phase, there is good chance
> the folio can be reclaimed.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> This patch is based on mlock large folio support rfc2 as it depends
> on the folio_in_range() added by that patchset
>
> Also folio_op_size() can be unitfied with get_folio_mlock_step().
>
> Testing done:
>   - kselftest: No new regression introduced.
>
>  mm/madvise.c | 133 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 84 insertions(+), 49 deletions(-)

Also the refactor looks fine to me but it'd be better if it's a separate pa=
tch.
