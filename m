Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66893778047
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjHJScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:32:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F62690
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:32:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso1479098a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691692353; x=1692297153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4G1eMy9+CFptENlm/g/netej2ahnFST4juFiDvm5E8=;
        b=DW+wAyxZGH0xk/XkLxnrk0DEBYevqGNqFWhx+MsguaeozNgX2s3xfD6iAFp8X88+Tb
         cM4OIRGSj3xMp375zSnjH/dL+eX21UykuA8Ajr03rsfE+BsGIh7zI3W6wEniFfLgTdUr
         eA2lCm9aCYdJ5UqBwdWYqysPYJ+zqUv9hD3mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692353; x=1692297153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4G1eMy9+CFptENlm/g/netej2ahnFST4juFiDvm5E8=;
        b=BrlWFLnPo4l+VOWjvDQo7ViyaYBANJaelHEbo1kyx7Mojgi7bxk5Pk0pKcEMVIZ7uu
         QXg14waZ6xg2QklxAtFsAReoDoGps2123B7rPyRV74m5QuSPHHNxJqpawd3Wcr+4miOQ
         66+D+KmRD/bS/f/K3WgVOMMdcRZCBAM2CwVejHYPhaK2uDzeC0OEpwBcSXLxRelOcFo4
         /YM1i70Fic2QGp61cxMF4hkLj+ah+8MMVJv5vzKzed5O00nQ6jDtwm/Wt5pYY24+8Rwl
         pmCETVZgt1vOq+Gkte3OOf/cmzTpJ9dA1g2utQ9zSc3FsZxmyta0AfK1C5pBTHRvrVdF
         NSHA==
X-Gm-Message-State: AOJu0Yzgie25LL/V6xu6LPYWFTzW77Dew2C5aYo4Y1ONMVKV3LNgUHTT
        w57cw/kn3fXBsiufkMdDfuNqocWRrZgYQcF8zNB0w8cq
X-Google-Smtp-Source: AGHT+IGxxLmzZYbxpK0Un3S8vYR0/uZlFNTtuU6qfnPvx/4vqkd28eId1SSvD/K0wNx6Q9VfZ17Lkw==
X-Received: by 2002:aa7:c542:0:b0:523:38b1:9bbc with SMTP id s2-20020aa7c542000000b0052338b19bbcmr2355795edr.41.1691692352787;
        Thu, 10 Aug 2023 11:32:32 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7d295000000b0052345dcc4desm1111841edq.38.2023.08.10.11.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:32:32 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99c1d03e124so166607366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:32:32 -0700 (PDT)
X-Received: by 2002:aa7:d408:0:b0:523:f91:fcce with SMTP id
 z8-20020aa7d408000000b005230f91fccemr2755596edq.13.1691692331501; Thu, 10 Aug
 2023 11:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-4-ryan.roberts@arm.com> <CAOUHufZatMprwzaT+=Lb6jSw60DN_Br=Og+N6krK3OQZiGyAYA@mail.gmail.com>
In-Reply-To: <CAOUHufZatMprwzaT+=Lb6jSw60DN_Br=Og+N6krK3OQZiGyAYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 11:31:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPp3DquE4A4FaWjgmS4wx7BT4MEFj5AOQie=tnK1N6yg@mail.gmail.com>
Message-ID: <CAHk-=wiPp3DquE4A4FaWjgmS4wx7BT4MEFj5AOQie=tnK1N6yg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] mm/mmu_gather: Remove encoded_page infrastructure
To:     Yu Zhao <yuzhao@google.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 10:35, Yu Zhao <yuzhao@google.com> wrote:
>
> Adding the original author and reviewers... They might want (need) to
> take a look at this series.

It looks fine to me. The important part is that the rmap removal has
to be done after the TLB flush, but before the page table lock is
released.

That used to be a special thing for anonymous pages and thus needed
that special flag. But if it's done for *all* pages the need to flag
pages goes away.

I see no issues with this, although obviously I might have missed something.

                Linus
