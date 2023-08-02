Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33CE76D4A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHBREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjHBRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:03:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C60139
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:03:25 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40c72caec5cso15711cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690995796; x=1691600596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HiRldT2G6GzpLSLP4EwtJNax/SO6hwG02IxOftO9E8=;
        b=bmDUn/wWoQiozTuFj9W9r+8AZ6IeqgRCIb9UJ4cNGrMbOsb5BoofRxwtT+/Qfn34w8
         iu/qEtk1in3BNhGBmQUnoky8JHS6QOOLwQzG+PZ5GDOuAGyY1LdCZHWj/l3gy/mIfaGJ
         0WmTeqx90p5r95bd1DK8HBtZm4QKhSckPQ4ki9irFtaEwx6pjIweOyY0HHxB5WVBgz8O
         DXGPrI/EQZyALVebLqtuDmmJAPRqmZ/2eNNKMSIb8nqV3BMrpF8LQiarXAQt3k7E68IM
         1KaPfFxg+RLLCHik5SBt0IHXK756WtwN7TVLZOehoma8yRwIflLSZUM6tyPa7QJ3DTXn
         TAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995796; x=1691600596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HiRldT2G6GzpLSLP4EwtJNax/SO6hwG02IxOftO9E8=;
        b=OaoaA/uZ53713RNZ8ipXaAdtO3iEi9orASonRcj59ir4hlVaTq5ZJs3uupbhj4SkaE
         FprerCiy1l49AkmNDTJI46cyeHJFpxy9G6wzCDI0ZjsFOFJY4RO/2WsQVOMKGvBFaakK
         FZDBIB4Y0u/FevsI2BWBQUc7a38ItNw7pzmFv6DG/w8ndyRe1tBsC60gsOA8jy57+ZQ3
         epMCLMd/hHHcU859voSBmQJu5fzFBEOdQ/oM6R12YL1E5YTGabG4AB28FbInEgf4cVzO
         EnT5R8d1PCBJGgHdszRFuuJYDEv0RElWkicjk2unHVcjGL/7/hRqzTtxRZC/KiqmCSxD
         e88Q==
X-Gm-Message-State: ABy/qLZ+p5yKGPL3IUMI3rUhHHyINfkn0Prb4r4qkwI/4ADv2Ln6HhmD
        OCt1YbhiVEIrFooe1G3tl2nTzFY4Rp4Wx6+5gDLVqA==
X-Google-Smtp-Source: APBJJlEX+7lbURiVGUUTUYsqPDNEbOR6PHjgsu1wg/jUNz9qyIij6vnqnv3W7FCVgj0GhfVtq5JyecxvGXGRxAjlF2Y=
X-Received: by 2002:ac8:58d4:0:b0:3f8:5b2:aef5 with SMTP id
 u20-20020ac858d4000000b003f805b2aef5mr1045439qta.29.1690995796169; Wed, 02
 Aug 2023 10:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230727141837.3386072-1-ryan.roberts@arm.com> <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
In-Reply-To: <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 2 Aug 2023 11:02:40 -0600
Message-ID: <CAOUHufZr8ym0kzoa99=k3Gquc4AdoYXMaj-kv99u5FPv1KkezA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Optimize large folio interaction with deferred split
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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

On Wed, Aug 2, 2023 at 10:42=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Hi Andrew,
>
> After discussion about this in Matthew's THP Cabal, we have decided to ta=
ke a
> different approach with this patch set. Could you therefore remove it fro=
m
> mm-unstable, please? Sorry about the noise.
>
> I'm going to try 2 different approaches:
>  - avoid the split lock contention by using mmu gather (suggested by Kiri=
ll)
>  - expand the zap pte batching to also cover file folios (as requested by=
 Yu).

Also we didn't have the chance to clarify before Ryan dropped out from
the meeting: I don't think this series is a prerequisite for the other
series ("variable-order, large folios for anonymous memory") at all.
They can move along in parallel: one is specific for anon and the
other (this series) is generic for all types of large folios.
