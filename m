Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659AE777F41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHJRfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHJRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:35:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F6EA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:35:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so33851cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691688934; x=1692293734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4zR+h8gNj84hzvJdKLVYf0Oy4aj291OIfrsJBN6e1k=;
        b=GUrYcJE/mWeEfk2Hkl8lGPsqBr4CZk8xwjk3wmkQqyJwVAQiTIn8X4m9LQhiD+9QKZ
         czxzsndcjdyigOZnT+HPES6lXU3Kz5l7Cn5ZDeNXV8qOemAWnHLBKDTH4xEOrL/jx732
         XIjAhjOv/EUfkKleDG6LhXnyKlJudM4mOyInWMkjhUjKs3y96jrAc0cXuiAviFdz259L
         mWvW+f31bKP7k/w0QBtGWlDpF4ukxytniEquEUrRIh7Ls6EEq0SX3AWSi9lBbNKOfpgZ
         XkRLTDJ0JlEpPkepz0ja++eDkwufhJ22bTecsAXZAnX3G8m7RhtSwQc2TPaCHdAGAefe
         FeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688934; x=1692293734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4zR+h8gNj84hzvJdKLVYf0Oy4aj291OIfrsJBN6e1k=;
        b=WGp8GcC7wXD/cR4HmoO7CdW3mxycEmVB8VQ0vV2vB4gN3P/TCUKgARXbAzEHmngOol
         o7n2x54LWb78HD+A12gVGpShfIxhBmY9+mhYrMdrtpGXZi5cDBVOmuAO7XebFS2F/Hdz
         Dx8lWOSnVQHB9b5IY1zkjJK0nrJkeOeQGytHQK0ZaDAqh+08b/R61pMjUQ50UkENDS7Y
         ELb7tUEcuCJFhWtMDGvDrfgHsRng8EZQhxo2x9hPRjr9CHpecua7h4sJinCJK1xQfh2n
         ZZ6+iqj9kFK0uAQ3YDp+ypuNteBdPhGMimO9ZQ3UCUAI6kiG59CESMu67R/8YMC3rH2f
         FTXQ==
X-Gm-Message-State: AOJu0YwgbWIVtRoySwsjvZ4EI009ItSMjzw+ehqaD8YqEOySeJqFz6zW
        KY55G/lx/ILU/SaND9MI02mhkWhHpgwcZSp/QB6+Yw==
X-Google-Smtp-Source: AGHT+IHpWISn6evOVeDKHwbHWYl5h1d9OmErMjnDnWre/SuX+jMNxEEbDBIPdkoM1XbRgubSJqxhmX2VWp4TRuQSdUM=
X-Received: by 2002:a05:622a:282:b0:403:dcd4:b9b1 with SMTP id
 z2-20020a05622a028200b00403dcd4b9b1mr18232qtw.18.1691688933985; Thu, 10 Aug
 2023 10:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230810103332.3062143-1-ryan.roberts@arm.com> <20230810103332.3062143-4-ryan.roberts@arm.com>
In-Reply-To: <20230810103332.3062143-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 11:34:57 -0600
Message-ID: <CAOUHufZatMprwzaT+=Lb6jSw60DN_Br=Og+N6krK3OQZiGyAYA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] mm/mmu_gather: Remove encoded_page infrastructure
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Will Deacon <will@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> commit 70fb4fdff582 ("mm: introduce 'encoded' page pointers with
> embedded extra bits") and commit 7cc8f9c7146a ("mm: mmu_gather: prepare
> to gather encoded page pointers with flags") converted mmu_gather for
> dealing with encoded_page, where the bottom 2 bits could encode extra
> flags. Only 1 bit was ever used; to flag whether the page should
> participate in a delayed rmap removal.
>
> Now that the mmu_gather batched rmap removal mechanism has been
> generalized, all pages participate and therefore the flag is unused. So
> let's remove encoded_page to simplify the code. It also gets in the way
> of further optimization which will be done in a follow up patch.

Adding the original author and reviewers... They might want (need) to
take a look at this series.
