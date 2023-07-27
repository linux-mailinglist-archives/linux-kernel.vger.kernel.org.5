Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED150765A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjG0RWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjG0RWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:22:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA32D5D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:22:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40550136e54so19271cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690478566; x=1691083366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iBSnQ5X7Bak2sfXDoDjMggzIUJmAFUrUhU8QMi07MQ=;
        b=L2j4ig2q7+TlWH4is4fSMeAnuEDwttbgXN9Ciq1UQsG5WQxpUi5VZ8KMRZOhxaKKF1
         UX6Vpbkhimq+/vnFYPLMkI9xCuPgRbBwUcdr3Q17GF1zv7FSLlNURNye1dYwrkJUvBHu
         YswLU2kI/6W6M7gZnEBKJtyeE5DXwwSQm3EwUraTFmU7W7HUOpKCtwF+5r73I9j0Tri2
         GbcyeDmisTMCT49CD6T+7OFJwHcr1FHC1gxKLf67k72x/9aByS74JUSzQebkveBMPLBL
         jbdWMKLxrLR+oFMJqvrQ/cGlEirp3krzaCsTRjvM/jV1bhOQP9//nj97GW8+S40RLYjJ
         twIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478566; x=1691083366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iBSnQ5X7Bak2sfXDoDjMggzIUJmAFUrUhU8QMi07MQ=;
        b=a0PDUPMGeCD9f6nfV7yqcCBfCmuvG6HUkvadEbR7PxvWh7nLTBZY8T1+u2SlHwiUzo
         PLd+lACgtVHmbIHWt960s0uE5uENuNWF1MOXyf1ik6idIgoJFVJZItpth6OSRGiZCTo8
         7aAdByp2Zpw1H/puY11l9mNbfrBd4NtyOvYPthgRZc3KXHVH+34AES66+nP2t/ivpsLK
         Xxq3D5jMRiRx1La5oUCEbf43swazJ8etDK/MKxGM1ehy9jNtnRi68yI6ZS2nP2R4UgFk
         jBI9f4m6JAWcDmdN5jHZGKRRCyybyO0Wroxk1rSxrDMp7c1XBHD6hLmjpg87oSdR1kJ6
         EO8g==
X-Gm-Message-State: ABy/qLagPMSiV2Tii26PWYRYwMucoe3GYNRxaIXaMypALJzBFQEVrqg+
        gbHDQhm+krM/rYWZ9s7xfOv7GGZBVNBPmZD3pniS+g==
X-Google-Smtp-Source: APBJJlEHmDtLma/pDt7kAcnkGk4KhU1ciC8WIqe3qlzEIEhkAYIwkfdL5qkyAn8APXdFJB15RqW4Gaxd1ayPgEGqnHA=
X-Received: by 2002:a05:622a:247:b0:403:b3ab:393e with SMTP id
 c7-20020a05622a024700b00403b3ab393emr15394qtx.18.1690478566020; Thu, 27 Jul
 2023 10:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141837.3386072-1-ryan.roberts@arm.com> <20230727141837.3386072-4-ryan.roberts@arm.com>
In-Reply-To: <20230727141837.3386072-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 27 Jul 2023 11:22:09 -0600
Message-ID: <CAOUHufYiEwYw0sFGK0kP0FFRfV51=hVJ==e5R_hXZXQo-OEcwQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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

On Thu, Jul 27, 2023 at 8:18=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to the
> deferred split queue in the common case, which reduces split queue lock
> contention.
>
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meaning
> there is no value to adding it to the split queue.
>
> A complicating factor is that for platforms where MMU_GATHER_NO_GATHER
> is enabled (e.g. s390), __tlb_remove_page() drops a reference to the
> page. This means that the folio reference count could drop to zero while
> still in use (i.e. before folio_remove_rmap_range() is called). This
> does not happen on other platforms because the actual page freeing is
> deferred.
>
> Solve this by appropriately getting/putting the folio to guarrantee it
> does not get freed early. Given the need to get/put the folio in the
> batch path, we stick to the non-batched path if the folio is not large.
> While the batched path is functionally correct for a folio with 1 page,
> it is unlikely to be as efficient as the existing non-batched path in
> this case.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

This ad hoc patch looks unacceptable to me: we can't afford to keep
adding special cases.

I vote for completely converting zap_pte_range() to use
folio_remove_rmap_range(), and that includes tlb_flush_rmap_batch()
and other types of large folios, not just anon. Otherwise I'll leave
it to Matthew and David.
