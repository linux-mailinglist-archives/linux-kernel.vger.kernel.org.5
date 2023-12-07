Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415848090E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443782AbjLGS5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443238AbjLGS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:57:28 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246C10EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:57:35 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b70139d54cso25105239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701975454; x=1702580254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukzvr3DAWirfHGKHECMg/pDTE54aIQ3L22Mz/h7Tkos=;
        b=d3PtBDMcZYFqrnw6o4Ioxk10akLVdh2rpGENcPpaWMj6CJ8+wD9c3BW4HMhvFOrYOV
         KtGW8XQTGYQ1SbZMhK4KI1m7uFADVGEKN6LK7gjvUzhQB33eHhs5ZwXz4FqXLEH4qa6f
         0MU8pMCIAfQLEOuUu45sxEsVIG8H/eQcjQydWWxnrSairn5+DxhhQq9Ky4XYjAgCQgOZ
         PJRUjW/X/DVsF6O94W7H4VyTXW4ZtPBtcu8LN+P232h9gj1dOK7e8QkvgpLRO5uik7BU
         yRRL+jR+liWHMelUp33RfFQUtR7F1lnBhh7GZgq0/nlLxOTjZZ8hZlhUPTACH8HVWWGP
         LWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701975454; x=1702580254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ukzvr3DAWirfHGKHECMg/pDTE54aIQ3L22Mz/h7Tkos=;
        b=WyeYoJ26yafxm3kp8LG6x1Apl6CF6uVEupl0KPOj+BKqZPyqVr5eBIe5mr297buVZK
         nOhyUhDUlJa1P8ri+4oEQqZRCfm+euszXSnaFq0YEiDKsYOwKRTQRSsZm82ocF5d3RPL
         XRGOvJpOLAOTTdFOJ6J7FUwfvP6oYo4xUFVILqxSy6L9sVEUCxhdkHfRtQT7prZV+xo2
         QWd4AuwfFgZ2qxux+nCFBXnik8qG24aW3PhCfpCuPkWzS1E/z2fVym0ZVGKnsgG1usWc
         p3cpi6Ag+MSEVWVPOtl2Wn6oeEMbIATDwo7LjGwjNW/lFjl477eccMMBrk+cktFovvdJ
         N4aw==
X-Gm-Message-State: AOJu0Yw8w0GpikrLa7EZ7Meu/OdqplFyYdNMYkpEf5xLxCf7fPHHNGCQ
        p9tq/TxT7KioZ+pOJm+FOrIISky9/BzyyZiTHVh7D3tihuvM/w==
X-Google-Smtp-Source: AGHT+IGkvMz3w4RMQvI7vRS56bBvcVCMLvOx4P2+RUShnNBcq/m9Q7PVxUQPMaACkBYSaEWa8JhUbdWIff7z1Pq5Ozw=
X-Received: by 2002:a6b:6704:0:b0:7b6:fc90:c3d8 with SMTP id
 b4-20020a6b6704000000b007b6fc90c3d8mr1171273ioc.38.1701975454509; Thu, 07 Dec
 2023 10:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
 <ee7631a5-b167-43d9-af19-a5a12dcac03a@bytedance.com> <6bf18314-7749-476e-aece-064ecfb0dffc@bytedance.com>
 <CAKEwX=NX5T1AL6jXuW0oonW_GtPOos+oXdWGAE3hxdWQyavBPA@mail.gmail.com>
In-Reply-To: <CAKEwX=NX5T1AL6jXuW0oonW_GtPOos+oXdWGAE3hxdWQyavBPA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 7 Dec 2023 10:57:23 -0800
Message-ID: <CAKEwX=MLNX7DQtjvDAF78dZdcPqdmhzXZPoaPnVk5esJcsDYCQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 10:15=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Dec 7, 2023 at 7:18=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Updated test data based on today's mm-unstable branch:
> >
> >                         mm-unstable     +patchset
> > 1. !shrinker_enabled:   86s             74s
> > 2.  shrinker_enabled:   63s             61s
> >
> > Shows much less optimization for the shrinker_enabled case, but still
> > much optimization for the !shrinker_enabled case.
> >
> > Thanks!
>
> I'm gonna assume this is build time since it makes the zswap shrinker
> look pretty good :)
> I think this just means some of the gains between this patchset and
> the zswap shrinker overlaps. But on the positive note:
>
> a) Both are complementary, i.e enable both (bottom right corner) gives
> us the best result.
> b) Each individual change improves the runtime. If you disable the
> shrinker, then this patch helps tremendously, so we're onto something.
> c) The !shrinker_enabled is no longer *too* bad - once again, thanks
> for noticing the regression and help me fix it! In fact, every cell
> improves compared to the last run. Woohoo!

Oh and, another thing that might be helpful to observe reduction in
lock contention (and compare approaches if necessary) is this analysis
that Yosry performed for the multiple zpools change:
https://lore.kernel.org/lkml/20230620194644.3142384-1-yosryahmed@google.com=
/

We could look at the various paths that utilize rbtree and see how
long we're spinning at the lock(s) etc.
