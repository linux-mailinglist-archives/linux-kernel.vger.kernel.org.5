Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E167CE29C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjJRQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJRQW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:22:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43019F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:22:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-419b53acc11so296651cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697646145; x=1698250945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ESBoSu0Q2kOoNHH1TTBfnX4/YG198ciywvQbN8v9rE=;
        b=qAkKjpQYe9q7oGFfKOnW7ZwiMksJrbGIpxRFd6Anm6Vb23Y6QBXxgGhdlkhfRNZRMO
         qDgJ3XYNbPJqav4D/Q+XDYO5hSCzU5SNv4MYpLtyHEjdsCQhMFVguzQ66ikmIiK/d12O
         vvyJXFqqJXxfElT7vW5s8b1gcORAaTmZe8caGIYq/oI4d84ds5w8Wfj1/WqC8iRaECUj
         qZPgUv8MBkS83XmS+oChcmjyTdF0pNkR20hOYqxUu6giqPePxyvyIP3Ic/vqngEjOEuS
         pGcVDaxEIGmqLmwQPc+z7eMLtGEXheIoSDz7/fCTvb1H/eUYh+BeedpyniaHVNJd1tQU
         sajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646145; x=1698250945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ESBoSu0Q2kOoNHH1TTBfnX4/YG198ciywvQbN8v9rE=;
        b=Q+/s/hQiPD8TSlVIhHy/4JzHnM07wOzVpn7vpikWyFGvodEJB9NcDk1oDU2cFSK1F0
         KiW2r/a+4AqjTErOvrGCYs4zNuCjV/UsuEB7ddk7xQiKvwV+oln/fnDe7WNGikQtr2fP
         GYSm4+ByeUmU4Z0DmFyh2Ukaoyb5G9DQQolG0d1uW9ynjexVtR4vWNBaR+GqYdf2BVzM
         kSOA9B4BHtv4k4kN3EmtJttcCQETZQsZ+yV7RpeDdrZIVl61FxGgH65RYe2gTgE516NR
         2oA8PM9D2qxbH7EveXg5ZE3x6DDR/bLF0LZy7M/ESHMU4rQOlHq33UcmJTC+bsPbMfV7
         OTcg==
X-Gm-Message-State: AOJu0YwzRpfyrXWuTjJ2gnzXQ8rIVhp6RUw3tdYtrIn2d48MB2U0I5QF
        26O0VUj6XgSR9v67zS/ZhNz97RRNe3H+CRdf1noAIrZbrli9rJTh6mu18w==
X-Google-Smtp-Source: AGHT+IF6mJk4QPRLAjJWI/o6MMUeKJaaas0JnbYE4DP1GoPpKt3v9snrBQH4kk0quh0gH9SuLieuXsPbaCYJn2+Gj98=
X-Received: by 2002:a05:622a:7711:b0:41c:375b:81a3 with SMTP id
 ki17-20020a05622a771100b0041c375b81a3mr321200qtb.18.1697646144607; Wed, 18
 Oct 2023 09:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231018082104.3918770-1-link@vivo.com> <20231018082104.3918770-3-link@vivo.com>
In-Reply-To: <20231018082104.3918770-3-link@vivo.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 18 Oct 2023 10:21:47 -0600
Message-ID: <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: multi-gen lru: fix stat count
To:     Huan Yang <link@vivo.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 2:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
> For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
> gather folios which isolate to reclaim, and invoke shirnk_folio_list.
>
> But, when complete shrink, it not gather shrink reclaim stat into sc,
> we can't get info like nr_dirty\congested in reclaim, and then
> control writeback, dirty number and mark as LRUVEC_CONGESTED, or
> just bpf trace shrink and get correct sc stat.
>
> This patch fix this by simple copy code from shrink_inactive_list when
> end of shrink list.

MGLRU doesn't try to write back dirt file pages in the reclaim path --
it filters them out in sort_folio() and leaves them to the page
writeback. (The page writeback is a dedicated component for this
purpose). So there is nothing to fix.
