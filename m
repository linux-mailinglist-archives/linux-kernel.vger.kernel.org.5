Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0307A2C05
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbjIPAbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjIPAbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:31:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B0CED
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:29:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso3173403a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694824197; x=1695428997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=OVpuhFSt7kKe8EAp1ix12Y6+KCVXgodkw07mHnAJeqfgImBLOgWSIJRNX9Gt6PC9UM
         8yXCba9L76NIeC4tiEAglKkaS1e/wObs9EjuLLtYiRAe2UAVRzBVs7Vj2KUyLzTdG7bc
         62Qif+hrHmGxkrKcpwdYKrYVxPIjaPK69TOMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824197; x=1695428997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=SROi/mhLPJfN+ga6P/ZWwBAL/yGzZ5n5P22/Lro2npVFZ9psV1TuZ6Z/BdDeGLHklP
         jfv4fPkRnezRcBgfEqyc0KyzZixurRApHPk91XYMfQ6BV9QaCPUQDZwrC+ZGwIwkUyfz
         liQ4no7xZ747AnpsUGnOnhT+N7+mal8pgak6/ttaF1lGs6ZSYENguPqGhPKYT4LwQhhB
         /aQ7PwRzyWATeYzgrWDlQefQIi3PuTTlTyRh+scTkrKSrxXBu3ubJRL38yWHS/7f/yXS
         ZLaMx7t5yQ1Y5ukykA1Kknl2apwakjkoLBugPtVbzFng0q7ousRIW/65OU1kISiwPEB8
         QnnQ==
X-Gm-Message-State: AOJu0YwTc/UCqxKHDpV5knMAnCKUj78M5bIhLGs6VJ2O1w38DB9wJDy1
        CwHtTwUR0gMI5x97FHZJUCQShIBeXtXE+7ZJTNe+NdKx
X-Google-Smtp-Source: AGHT+IFh0nh63BTwu/MTERQMlTx2bHXs44guxY0gEA76k9Wfopf4LlPitAKyc1i0u/H9Yu9iTQ/meA==
X-Received: by 2002:ac2:4db3:0:b0:502:9bd7:ec79 with SMTP id h19-20020ac24db3000000b005029bd7ec79mr2629473lfe.29.1694823371091;
        Fri, 15 Sep 2023 17:16:11 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25e91000000b004fb7848bacbsm800625lfq.46.2023.09.15.17.16.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500913779f5so4362748e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3113:b0:500:bc14:3e06 with SMTP id
 n19-20020a056512311300b00500bc143e06mr2583654lfb.44.1694823369876; Fri, 15
 Sep 2023 17:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
 <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
In-Reply-To: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
[...]
>         if (unlikely(error))
>                 folio_set_error(folio);
>         else if (uptodate)
>                 folio_mark_uptodate(folio);
>         if (finished)
>                 folio_unlock(folio);
>   }

Note that this then becomes

        if (unlikely(error))
                folio_set_error(folio);
        if (finished)
                folio_unlock(folio, uptodate && !error);
  }

but that change would happen later, in patch 6/17.

             Linus
