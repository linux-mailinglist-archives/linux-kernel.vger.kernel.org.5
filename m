Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CE760935
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGYF1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGYF1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:27:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A981116
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:27:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40540a8a3bbso116091cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690262823; x=1690867623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMPRqJXMInv8v5vhvbPZrO5iSlj8zIJ9ZEICMI2l64c=;
        b=V3Lct4ehGATFO7kphID666/8i+A7zdLdQWo/o/A6KVusVOchXYBzpsLpkZ9IzyG1MQ
         5Bw6Fb1mQSsofM1sqfG7gs+N9FwY7NsMziLys7XqC3xvp1AWjuTqVMiT5xsc9pXNltlt
         R3kxGDZPJQo4Df7ocy+1AbuJ8hRWNM3AAjwQS1Dvc8F/MLsfaNfKnRLKhNk+8kWhGAMM
         iCS8cGYEQP42UF/veaC6/1e0hOU+LheNaliOtvZ544KajbDSKmxAZuTl2r8H2LJfBQP0
         vZCPYkV0U/iBaTJ5Ox67Iwhw4QPPMAC78iYuhQmUBu4uXqVsK/2p8WJRW9w0MPVmX5ed
         BYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690262823; x=1690867623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMPRqJXMInv8v5vhvbPZrO5iSlj8zIJ9ZEICMI2l64c=;
        b=ebzumbnkXLn9CNlAoRaRH4h35PfzV9cVZKQSQ2KHrAGdY9aXArJ8PsUrD+l72D7EIZ
         UkkUUXBoCA8GYWgZ5z7z7MPYyGTatxL5Kg903LjKkP7FNoHJAbASX9y/yBMQ1GJArNKr
         eHPX2NRV15V7L0IlP2iXUtWVMGxYNVdqLygEsKtRWfH2LVlktbBbjewjetItTDM+iABh
         DFB5klPf88//pWvinQZ9TDBFXJ0Ie8QjOXNe5/1IlPiDaLiDMgohBmvuKPBfUmrv2wIq
         qp0tkhtzICRlb2lJaP9nCOPixOdzIB5Y2pV6b1bOB2iHpN33eHoGMtmUPvkBoGUaa4Jk
         fpFQ==
X-Gm-Message-State: ABy/qLYFixNQKLVMF5zMAoLUr+DhL8S+KHi0Xvnq+iNTuJt07vzdqPoS
        iCYAIPPtwqhg0IolJM1FaZxCyRYgiLM1dVWTaqOFbw==
X-Google-Smtp-Source: APBJJlEJYoswpogaatG+DCIJxapPdsmkfOqC++Abk/+PXYWE4vrCV9EDzu46/nXDumqPvPx6iXcOfQJ6cC+nt14nZsc=
X-Received: by 2002:a05:622a:1009:b0:3f8:8c06:c53b with SMTP id
 d9-20020a05622a100900b003f88c06c53bmr101627qte.0.1690262823590; Mon, 24 Jul
 2023 22:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com> <20230721094043.2506691-5-fengwei.yin@intel.com>
In-Reply-To: <20230721094043.2506691-5-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 24 Jul 2023 23:26:27 -0600
Message-ID: <CAOUHufbVZ_jxoKRuqqf3m6aNykEb5Z2M9Pi116dh2_F6CPO_zg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] madvise: avoid trying to split large folio
 always in cold_pageout
To:     Yin Fengwei <fengwei.yin@intel.com>, minchan@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
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

On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Current madvise_cold_or_pageout_pte_range() always tries to split
> large folio.
>
> Avoid trying to split large folio always by:
>   - if large folio is in the request range, don't split it. Leave
>     to page reclaim to decide whether the large folio needs be
>     split.
>   - if large folio crosses boundaries of request range, skip it if
>     it's page cache. Try to split it if it's anonymous large folio.
>     If failed to split it, just skip it.
>
> Invoke folio_referenced() to clear the A bit for large folio. As it
> will acquire pte lock, just do it after release pte lock.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>

I currently don't have the bandwidth to look at this one. Minchan, can
you please take a look? Thanks.
