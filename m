Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8875984D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGSO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjGSO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:26:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDC10F5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:26:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so7247704276.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689776779; x=1692368779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VK55DG3Fs7PTghAKQd0jM8nvqZIPZ4glcR3HhFBT7c=;
        b=7jfU311slUUW0UFqd1xP+4htLveZmM27w7SWA5P0Ofot830W2PGNGcLy4HrhdEoxQm
         az+ILN50Jzlo4maRmOZlUhdjCrGtxh073DOAMOQlyZCSdcDvxCsrVoHtWECGQCV6CMYP
         dtkRMmL1WsTSmqNv2tW3j4A1S23poCaDbO2S1YBY1oW1aMQtTEPf6UsRY+WbA+OtKrIC
         Ua7LPGLJzdckrb/5yRJ7bC/gRfLRRWFwi+VUOyu29ro5uT5rEQHlXpAaCoqRhr+mHIqE
         pK8dmPZI3dsvbXSSHF64DsP7G2TTHotWz5S+oM6rCmanQUB6ET0h94ELWpdpUDirIPGy
         yX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776779; x=1692368779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VK55DG3Fs7PTghAKQd0jM8nvqZIPZ4glcR3HhFBT7c=;
        b=UVZpgABYpkklUc6x/21HUJhBzQa4vnwhNz0Q0xjyTz5hu2xpSFh11bWWQHXjXwyLpE
         S8N3/7NKBnFD0JNMq93dosrPvk+rVEEoQkYj5LB7ZJKsWTvUqdkCqdcCf5RooH5pbaWI
         TFTHJTXlL6HIK7NkUztx+mvu6xv2Eab7cm5kcqoxSSHgYWJaJiZywwBUQ3KS9yrHjKuO
         Gkrtvg451vd7LFcPq3umPWKD4yw8NWkKw4yQS+ismp6KXXcLhqnv9GwHZLi7gB5fum+A
         1KsOf/jzl5ZzQqwesK4+ngfiVEPHGB9ET9QXGcZh2juCP7ze0RMB6DgPUlkVBMbYSRQp
         hh2Q==
X-Gm-Message-State: ABy/qLaipCoeh1N4Q+UOxxk2dFGUwnhZdW2A66kxjW+eAaS6Ks+6HBtO
        Nx5aLzioao0K/CyfTJ4q/YvCfGUaV5b8IVCrG8qooA==
X-Google-Smtp-Source: APBJJlFkic+Ri/Zc9kWO4O0LpFmkfS6fsW6kTdiRwmfAxsS9VkTkZur4wtoBXB7B9HvqhJ1+BGi7/g==
X-Received: by 2002:a25:5342:0:b0:c85:d8b7:1b96 with SMTP id h63-20020a255342000000b00c85d8b71b96mr2356398ybb.52.1689776778840;
        Wed, 19 Jul 2023 07:26:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 133-20020a250b8b000000b00cecd504e708sm651446ybl.35.2023.07.19.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:26:18 -0700 (PDT)
Date:   Wed, 19 Jul 2023 07:26:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Yin Fengwei <fengwei.yin@intel.com>
cc:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
In-Reply-To: <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
Message-ID: <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com> <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com> <16844254-7248-f557-b1eb-b8b102c877a2@intel.com> <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com> <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com> <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com> <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
 <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com> <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com> <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com> <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 19 Jul 2023, Yin Fengwei wrote:
> >>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
> >>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
> >>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
> >>>>>>>> cpu 2 is isolating the folio for any purpose:
> >>>>>>>>
> >>>>>>>> cpu1                        cpu2
> >>>>>>>>                             isolate folio
> >>>>>>>> folio_test_clear_lru() // 0
> >>>>>>>>                             putback folio // add to unevictable list
> >>>>>>>> folio_test_clear_mlocked()
> >>>>>                                folio_set_lru()
> Let's wait the response from Huge and Yu. :).

I haven't been able to give it enough thought, but I suspect you are right:
that the current __munlock_folio() is deficient when folio_test_clear_lru()
fails.

(Though it has not been reported as a problem in practice: perhaps because
so few places try to isolate from the unevictable "list".)

I forget what my order of development was, but it's likely that I first
wrote the version for our own internal kernel - which used our original
lruvec locking, which did not depend on getting PG_lru first (having got
lru_lock, it checked memcg, then tried again if that had changed).

I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
but it turned out to work okay - elsewhere; but it looks as if I missed
its implication when adapting __munlock_page() for upstream.

If I were trying to fix this __munlock_folio() race myself (sorry, I'm
not), I would first look at that aspect: instead of folio_test_clear_lru()
behaving always like a trylock, could "folio_wait_clear_lru()" or whatever
spin waiting for PG_lru here?

Hugh
