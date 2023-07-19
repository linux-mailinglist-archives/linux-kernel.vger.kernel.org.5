Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2037E759D33
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGSSYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:24:14 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A65A1FD8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:24:11 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403f21d3c2dso30361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689791051; x=1692383051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbxDP50CZlJWnajO6VajqSUKLZ5IRlVqyfdIEvg3GPU=;
        b=cCcb6eQT6QeSg08XCK+G6+pNCXlEYQXfJlxkZW06c6q512LcRhBaKXOTDLPQXcMyhn
         wzRnmtEcp0EqhEqA4f4R4c+VJkr8COsUa0pFjRwFQHEvBzEz5XyI6gfWgu9MZ+3KjoR9
         2xO+WUC6c88rDPj3E5lc4Jrwj+0YwQ6mTDEcvan34MhuALxpL+r3Z1iyxBeFo7nyuoPw
         MeZrCJNyRKls2MpWKVsUHq9DDxxbBcAtRxpeLc/Vr9vjJcfgcBFmIxKUDVTi+PLD9iO7
         xwoKimjrilChWMMPSDBUBtiJsu4zHEtP8lBds/ls6u8cxZGOcltjdUMdZW90anUWU7Iq
         izsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791051; x=1692383051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbxDP50CZlJWnajO6VajqSUKLZ5IRlVqyfdIEvg3GPU=;
        b=Np0oIFnWyofGgEXQSiU/R8QRW4HxwxhK/rGLQ54dFCorRdy34SYEDTUtiDPYMvQ5zO
         VG/veCoJpOq7I/s+TGI3+mDGa8XlSXboWa7AtPnFLoMiRsQ8ZKRkrgm6vEwhf0BlFu5L
         Iy+hrepDx0dBs6Xz3QRc1e0gwputkN5lgLMWeGRjh3MLGIIpNXSsvGm8YJpbxJmGDzZ0
         v4j2a4AHHCBv4PjyIC/ebCXmvUx/rO9rAt4PuvHg3cOr08F964HVWFrerni+rgpIaZGI
         30Uk6iMCWdSDsC8so8ybS3IlVf+2rQVQqoBDgphi6dXk7EI1LMnQW0Qm8XA9ubENTYLK
         TApA==
X-Gm-Message-State: ABy/qLaJD4pH0JM85qt0zYkpCSA1NylD4+U7xHI6F7tkNNdLTRiuCnvM
        qny4h6xVJoA5spjes3ZCHtJh2zQgTZlBRwMdTB+bIQ==
X-Google-Smtp-Source: APBJJlGFr+FaLX5OMVBu61IXG3nYjTcxCvhEkVh0rHeOkEHasFwwQLcd87tTeXtQRNkG8Cz3VO8HPknFYMPiZlGyMJg=
X-Received: by 2002:a05:622a:1756:b0:403:eb3c:37af with SMTP id
 l22-20020a05622a175600b00403eb3c37afmr27539qtk.26.1689791050679; Wed, 19 Jul
 2023 11:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230719135450.545227-1-ryan.roberts@arm.com> <20230719135450.545227-3-ryan.roberts@arm.com>
In-Reply-To: <20230719135450.545227-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 19 Jul 2023 12:23:34 -0600
Message-ID: <CAOUHufZrrPBkdEYWnGnbTTHxp8bveSOocPB3J=+nu-VfYFdKZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: Implement folio_remove_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Jul 19, 2023 at 7:55=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Like page_remove_rmap() but batch-removes the rmap for a range of pages
> belonging to a folio. This can provide a small speedup due to less
> manipuation of the various counters. But more crucially, if removing the
> rmap for all pages of a folio in a batch, there is no need to
> (spuriously) add it to the deferred split list, which saves significant
> cost when there is contention for the split queue lock.
>
> All contained pages are accounted using the order-0 folio (or base page)
> scheme.
>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I have asked for this before but let me be very clear this time: we
need to generalize the existing functions rather than add more
specialized functions. Otherwise it'd get even harder to maintain down
the road.

folio_remove_rmap_range() needs to replace page_remove_rmap(). IOW,
page_remove_rmap() is just a wrapper around folio_remove_rmap_range().
