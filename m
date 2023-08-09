Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023D77634A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjHIPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjHIPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:05:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EBEB4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:05:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe3678010eso11437734e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691593554; x=1692198354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNfy891wWQJn9GGaD6lb4vpiDtiobMWaR2UsMEivbwk=;
        b=F0JapzA4Vi9mJy4NRwWsAHDugEqxju565TgTe91RCVzWfxEK4zaUiw+PeaO+Cf+MGb
         2MYvnDPz86UyKxutV25GqOcjXrYiHTASwOdBAOcj1c+kpppwC/zhdHkoEqYJmKybkMbp
         DoUc9NyMYujogrq9if20PNFIPdX5d8q7MR+Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593554; x=1692198354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNfy891wWQJn9GGaD6lb4vpiDtiobMWaR2UsMEivbwk=;
        b=j15VlVGreqYYIdbp1TKjbBaQQLXkHVYOC2yOyFvIe/hYQwOSwBM5zkUcGnjBe/y8rL
         YTI2jOS+Y1axBU8qGLhOOv379gO5RASO9WE4TWl47r49ERwGRfoAGwM4ut16EEzdpA5t
         EvG/Htg90EPU6qQPHQ+hQRsMH7+s61SYBrR79bLT2x/E13gHm7oJ2RJODY72PxWi5Ddi
         dPSQxVjNm3g1JcuBhJQ7YopA0wgWuOpV0Os199p3MHx8RpM2Hwokk55FOlTO9luItmwS
         mEqrAfwy4OM7BS7EejB0i+1BE5XzwWJynYx8/I0vJ6UCIiYWeAULAnk+/SetSlblnmxX
         MW7w==
X-Gm-Message-State: AOJu0YzaUuxZhfg6ALC1oS0UpyT2/JiznhcK/4KQSgyX3bsDpCe0OhhO
        EWbgE9aVoSWsA7OJq5o/1YRtQnkDNcOZVx/khTu3p0TK
X-Google-Smtp-Source: AGHT+IFwH4yv7JBJPPibDp0zpn7kCYtFiZSkk8on5qTlb+1+EfDs5N7ijxYmoZp6iyUjssGRcpUJVg==
X-Received: by 2002:a05:6512:2342:b0:4fd:d18e:be33 with SMTP id p2-20020a056512234200b004fdd18ebe33mr2512154lfu.26.1691593554140;
        Wed, 09 Aug 2023 08:05:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906785400b0099bccb03eadsm8061380ejm.205.2023.08.09.08.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 08:05:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso9555282a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 08:05:53 -0700 (PDT)
X-Received: by 2002:a17:906:5382:b0:993:eef2:5d61 with SMTP id
 g2-20020a170906538200b00993eef25d61mr2523827ejo.27.1691593552995; Wed, 09 Aug
 2023 08:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Aug 2023 08:05:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
Message-ID: <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christina Schimpe <christina.schimpe@intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 07:46, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> mem_rw() of procfs uses access_remote_vm() to get data from the target
> process. It worked fine until recent changes in __access_remote_vm()
> that now checks if there's VMA at target address using raw address.
>
> Untag the address before looking up the VMA.

Interesting that it took this long to notice.

Not surprising considering that LAM isn't actually available, but I'd
have expected the arm people to notice more. Yes, I have (and test) my
arm64 laptop, but I obviously don't do user space debugging on it.
Apparently others don't either.

Or maybe TBI is used a lot less than I thought.

Anyway, obviously applied,

            Linus
