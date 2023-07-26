Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3B762AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGZFyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGZFyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:54:04 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415B170D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:54:03 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40550136e54so238831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690350842; x=1690955642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jC3sNXdTqmH+eXOZrdrV9yhRQ5WjXD1etqf4l0CXD8=;
        b=kNdc+TjfV0H/TBWzGhIgAI93ibQ6iIfvmm3jyasTUe4JrmcpVKMNJUb92GH1Je1RHG
         JtWPMEbH0nI6kj1QHNethWv0RMC15Qo2rqaQpdFq8zTVXjCH/Km0JAfZgPt2mPXiAm88
         LMnF/RDqrOZcA/XvEcXUWEqwJOzKnrSM16dMoBMsknlptCkYhOAER5cMgfaYoEh4AuqX
         ob0DMqdnmJ9qTExQ30MAHFHVKimn1NsSO84avLhNa4SzB9FG2bjTxnqhbO5dc6Pnaz3I
         8n9XaFP/B3pERaAQJm8Csq45Vdyfz/5aJtpKpBXgVRyAE3RT0DOhmS1FsPZ5/7akkm/c
         R1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690350842; x=1690955642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jC3sNXdTqmH+eXOZrdrV9yhRQ5WjXD1etqf4l0CXD8=;
        b=jSyo28RX5zYebI4pQnQjT4b7Wq2H5PDHEwVSTfTs8Cwe6aiiiFOTnS4FonDqcI3D+m
         wEpwFGkLZnLkGBqc87zKQKxgIWO0IrHu+vWU0W7I/MexuzlPQN8PE8T78lo4HNnPRgVx
         IopuFxqWeR28a9aEoF99MCcdy/MgubwfxEAjBmUw6embglsL+x05A4EHCIRcr48CeiFo
         1SsFce1rHlMVpGjPPQpmxqBKHdii0nRf+o40B5CHiVBHxzmxyQ6cA/CyFg0MuwD1Vdbe
         wzos2/rGSN5MDLBRc0Hmox47xIIpoQNLkwiiRSsSoXltfGUwGbmrTgNE9BFyT8wo1HIz
         FaoA==
X-Gm-Message-State: ABy/qLaH91AQEupxuH0/OpT3zEztg+OkOfF2bOgjy7IO59zlgOZGOZgP
        Qc94Nk8wKYpzHFKdW0KUsin44rtknBBtQw1bElpxSQ==
X-Google-Smtp-Source: APBJJlHZ+/qIFGCOIW2GxP98uJ1C/0nh99PCGNYz0dkn1fWzZTe8CIpbq/96sCEfO9aknQ72JuQ//pPUEx3R/kB+ldc=
X-Received: by 2002:a05:622a:14c6:b0:3f8:5b2:aef0 with SMTP id
 u6-20020a05622a14c600b003f805b2aef0mr440236qtx.24.1690350842297; Tue, 25 Jul
 2023 22:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230720112955.643283-1-ryan.roberts@arm.com> <20230720112955.643283-3-ryan.roberts@arm.com>
In-Reply-To: <20230720112955.643283-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 25 Jul 2023 23:53:26 -0600
Message-ID: <CAOUHufamqn0b8tN1DppfPi7FRnENzYwcSOVcAKNxkj=CYa+OwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: Implement folio_remove_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 20, 2023 at 5:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
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
> page_remove_rmap() is refactored so that it forwards to
> folio_remove_rmap_range() for !compound cases, and both functions now
> share a common epilogue function. The intention here is to avoid
> duplication of code.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/rmap.h |   2 +
>  mm/rmap.c            | 125 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 97 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index b87d01660412..f578975c12c0 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_area=
_struct *,
>                 bool compound);
>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>                 bool compound);
> +void folio_remove_rmap_range(struct folio *folio, struct page *page,
> +               int nr, struct vm_area_struct *vma);

I prefer folio_remove_rmap_range(page, nr, vma). Passing both the
folio and the starting page seems redundant to me.

Matthew, is there a convention (function names, parameters, etc.) for
operations on a range of pages within a folio?

And regarding the refactor, what I have in mind is that
folio_remove_rmap_range() is the core API and page_remove_rmap() is
just a wrapper around it, i.e., folio_remove_rmap_range(page, 1, vma).

Let me post a diff later and see if it makes sense to you.
