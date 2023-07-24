Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5024075FDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGXR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGXR3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:29:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA57E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:29:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so3145e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690219786; x=1690824586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDkF/IWFKRglR3qWWX4AN+kufJEx5Kc41nROK+8O7lI=;
        b=nVf4gto/qjNh2zXk8AwF2ibFw0CyIiiyKMhRiWGNuvC/Pmal0l5ZZbCzwIgS+VmgV7
         1iUjsgJUXjGlaRIp2KofIP7TUbcV7bw+XFPxcvsi2vQEM0Wma7sSeAxXJW8TuWQYIReX
         1Hzw1DLRd6UbBkdNcMa1ACROcFNACXX+/q/8maywVzzRjhXskMtESjKdRskvaohhDITk
         Q8eGpV1Z4jXb2IyUYhI2fc+c/4+OuEOydu7E1OnhqQTHdoNkzkZZh3DerbO6kaa/2ZzT
         ESh6BImKErYwEoEBbRikOWvOU1VmZaDZ0IxbMajHnsYNdsEWL3IuIKEpNNB/cU3iPtGd
         S7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219786; x=1690824586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDkF/IWFKRglR3qWWX4AN+kufJEx5Kc41nROK+8O7lI=;
        b=DeI3ZzKshrE19/NOeETzf6E3Yay1D0zRWoTEJOW81sltvGTFLK9IdeYOss7bP1EMBB
         Hs0Vs4Anucc/t1fOjbsVtG+STR9w06hul+fx+2aTyDezQEr2zuXLZPicm9Zo+g6QvxtH
         NK/UNv77/9Idw4E8gRky8ZURmZki7vgK0OgmKluVhTwMCiSsM7OsGRW/6PoVIzykLd38
         IRKKQrilWoMtqEp65i2qYa3HRsy005V0ka1ib6aKPl9JUg0BkdrKH3nzS2cs4T81eOHC
         mWL3kIsx/DM0baSEmi1SacZxisKkGh2lRs4Vmh9hYkd8ezcnr2rRlYieqDVeyV2w0a9J
         NBRQ==
X-Gm-Message-State: ABy/qLZEIiE6xBADQv9sLNNa8apGjmPJJPschlH8CsMdVJPuwwCh5e8Y
        W97kFoOejqlvNjyp+A5IXtr60+XggeFHtSwaJNRj5pDnh7Hgtd7Iqq8=
X-Google-Smtp-Source: APBJJlEGhQmbz6EIp31/9ksAy4uci6XEiQc+7Mz+B5i1hxx8DRc9mdINflvY12TOOLdhH2gO/ISVrD2htfsauuFv7M8=
X-Received: by 2002:a05:600c:3c93:b0:3fc:75d:8f85 with SMTP id
 bg19-20020a05600c3c9300b003fc075d8f85mr199859wmb.6.1690219786166; Mon, 24 Jul
 2023 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230721225107.942336-1-jannh@google.com> <20230724101136.4c58e8291961e87f6c5c1c79@linux-foundation.org>
In-Reply-To: <20230724101136.4c58e8291961e87f6c5c1c79@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 24 Jul 2023 19:29:09 +0200
Message-ID: <CAG48ez1RPZQ0p7dB3BsVwiTPHqge1Ja7E-XCQp-P7xBHT+AM=w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix memory ordering for mm_lock_seq and vm_lock_seq
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>
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

On Mon, Jul 24, 2023 at 7:11=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> On Sat, 22 Jul 2023 00:51:07 +0200 Jann Horn <jannh@google.com> wrote:
> > BACKPORT WARNING: One of the functions changed by this patch (which I'v=
e
> > written against Linus' tree) is vma_try_start_write(), but this functio=
n
> > no longer exists in mm/mm-everything. I don't know whether the merged
> > version of this patch will be ordered before or after the patch that
> > removes vma_try_start_write(). If you're backporting this patch to a
> > tree with vma_try_start_write(), make sure this patch changes that
> > function.
>
> I staged this patch as a hotfix, ahead of mm-unstable material.
>
> The conflict is with Hugh's "mm: delete mmap_write_trylock() and
> vma_try_start_write()"
> (https://lkml.kernel.org/r/4e6db3d-e8e-73fb-1f2a-8de2dab2a87c@google.com)
>
> I fixed the reject in the obvious way (deleted the function anyway),
> but there's a possibility that the ordering issue you have addressed
> will now be reintroduced by Hugh's series, so please let's review that.

Thanks. I've looked at Hugh's series and what you did (deleting the
function anyway) looks good to me.
