Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD57F04CE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 09:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjKSI3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 03:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 03:29:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE934CE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:29:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583E8C433CD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700382568;
        bh=6v79FyeoIDasUhEqXXVQirvwJzjxpmLQLlOQstZb9KY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFI4xKuEFjWeWK9lvlb/XZ0hFSAwMl/9gZ0HjcEEsusTyTpy9GgoBy7tWUA1iPhpc
         wmxzMC86wgrlWSpdLu5bJV535RSFEZ1b0ZyvsuCRnaIOD9kg3YRBZrzIaz09vkabuy
         xAJeb3pKCs5i+/hNux+EzgQlorZifsbmXPygIWrN46iE1VxbYj+v1lFgdUMkVawMgY
         TeKdbh7giBRJ3HjF8hHDErRmiN0tpmSP5FJY/kb5ckWfU7ynyL/3HyYtoXnCHE5nWa
         o5NUWWHVBa89RRsFzBWpWVL9hpGGjSnxQ2iVuQSvukZ1eLNVfnYx2Q9b8hpJ6cbkDh
         BhUviairKHYIQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd09f51fe0so2340718a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 00:29:28 -0800 (PST)
X-Gm-Message-State: AOJu0YwJWNo+skETpsFBf8/kVftfMej7z/B2xZx/ryz4X90nnJj5OH3k
        Ta4RVwQvuAkGMpFn1l4OLBNFS4QASls5BE/eufTPiw==
X-Google-Smtp-Source: AGHT+IHsPnYEvTIB0NWcX31Z6JVfHuVms48qFy9H3ayAzX5NQ49G2yH1qY+9iMTDEWHuZ9aAjWQPlXthKMkvaW7hJt0=
X-Received: by 2002:a05:6870:cb4a:b0:1ea:809c:3eb with SMTP id
 oz10-20020a056870cb4a00b001ea809c03ebmr5213078oab.44.1700382567531; Sun, 19
 Nov 2023 00:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
 <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
 <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com> <CAKEwX=O0eNmoFRsnRXpkY55UGHBOiGL2aQW6um8Kq5hgGH=c_A@mail.gmail.com>
In-Reply-To: <CAKEwX=O0eNmoFRsnRXpkY55UGHBOiGL2aQW6um8Kq5hgGH=c_A@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 00:29:16 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNFfzkDXCX52Y9whz4TcWJMjM0kk-mKvet0Ge0cEOYmsQ@mail.gmail.com>
Message-ID: <CAF8kJuNFfzkDXCX52Y9whz4TcWJMjM0kk-mKvet0Ge0cEOYmsQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 10:44=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:

> > Why do we need  to release them?
> > Consider this scenario,there is a lot of data cached in memory and zswa=
p,
> > hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data =
will be written
> > directly to swap due to zswap_store failure. Should we free the last on=
e
> > to store the latest one in zswap.
>
> Shameless plug: zswap will much less likely hit the limit (global or
> cgroup) with the shrinker enabled ;) It will proactively reclaim the
> objects way ahead of the limit.

I think that is actually the proper path, by the time it hits the
limit of zpool. That is already too late to shrink zpool to make room.
The shrinker should have guaranteed the amount of pages for write back
purposes to make forward progress.

> It comes with its own can of worms, of course - it's unlikely to work
> for all workloads in its current form, but perhaps worth experimenting
> with/improved upon?

Agree.

Chris
