Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05BC753FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjGNQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjGNQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:54:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1DB1FC8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:54:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4036bd4fff1so6821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689353696; x=1691945696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z22Lji21DHhPyVayNZqqGmw+ssfxQ2kpwK4smkoUB/w=;
        b=tKe/iovdH0qDwlwiziwLGPu9QaKUll2SxPp/gfkfKdoiHzE3qARf+GfzNRxPV1SBVO
         b6ytSna0wEXaX3W2WsFPGMqlsKDEn8IjZxONJh8J/S61S1BvMAf4+fJbeFiaY8Jvlrti
         nZ7vlQYIhHKZDKSrsfPNgVXWDZUoZQ/aiq3bjhlgl4CglxEm0JX90PgRnuoueJ+4sGUX
         ziQ12PjguouQQc41xUgDygyCqZGufhI5IgFAREwOGMxlqEBBs2PXk7U4+/NnyYSr6aef
         UWZAVqFNkd4Y+sBKSFqz6sXv7sejZlNdPONpaJ8XhqLld60yN45sf8uDZkFWoJDlw3BM
         1vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353696; x=1691945696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z22Lji21DHhPyVayNZqqGmw+ssfxQ2kpwK4smkoUB/w=;
        b=fX7yyRAGauxCnuNZnXVVZWRzWxXSg0abynBYeRFqzbDDoFVDhqCyIMAI55vTX5YChP
         jEhyOONCfWJ2YvIxUKDghTpSpYqe7Vx0gPi5U9KWpnW+Y9+E0FNuBz69x9g/lJaT+be0
         vk7iin3aqOPcC+8EDkyuTTrNps4OyKSPCa15qKPkFBuD55NHM+mrHeu3c0c2yA6IK1oq
         +eqHZ7UlQUTEBYX+5rzCOvqepDTcAJwAgBVnccdtT+3f08oxOdREdl7yHkk8x9cNOTUs
         DpOHtWjweuVDx9KPfU88VdFDVCBm4Y2wAW1fjSHlMBTQ1rrtSJ7J+/VOUrpP7RD4By4i
         BwiQ==
X-Gm-Message-State: ABy/qLYCLrb9mL2hD0MZzqGT2mMxE7lhLFZ1HXoc1D/VMeAtWFQw9o+O
        9espvbQ2YiAqiTFdkGSQQ/tPQrAcYVOAFe2HDAg0Pg==
X-Google-Smtp-Source: APBJJlHncBuVEFEC55jlI7+mb7yJ4rrbwLngLi3+ds0/PMkK1w/AgZCCU6EOzolM/GD5bcXjFGoGEx2B+Si3CMfWcus=
X-Received: by 2002:a05:622a:1994:b0:3ef:5f97:258f with SMTP id
 u20-20020a05622a199400b003ef5f97258fmr916843qtc.16.1689353696004; Fri, 14 Jul
 2023 09:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com> <20230714161733.4144503-2-ryan.roberts@arm.com>
In-Reply-To: <20230714161733.4144503-2-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 10:54:20 -0600
Message-ID: <CAOUHufZ7HJZW8Srwatyudf=FbwTGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> arch_wants_pte_order() can be overridden by the arch to return the
> preferred folio order for pte-mapped memory. This is useful as some
> architectures (e.g. arm64) can coalesce TLB entries when the physical
> memory is suitably contiguous.
>
> The first user for this hint will be FLEXIBLE_THP, which aims to
> allocate large folios for anonymous memory to reduce page faults and
> other per-page operation costs.
>
> Here we add the default implementation of the function, used when the
> architecture does not define it, which returns -1, implying that the HW
> has no preference. In this case, mm will choose it's own default order.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>

Thanks: -1 actually is better than 0 (what I suggested) for the obvious rea=
son.
