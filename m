Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603147E863E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjKJXKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjKJXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:10:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C485A171C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:10:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E018C433C8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699657830;
        bh=qzpNyLMC3A64xmdVeHWaXH90W9sIZeMAIAR6Er2pCF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grA5mJLsH/+fz2emPy8DmfvIbgtgfKjTuffWYqQxScJzEksPEvtEWEoGydAmBQ13W
         No89NQMbMvsJ6CyrV5RHZzth0v54b2wU14S4ng5CxYXq1YxprjFZLl+uiK85M8EIKQ
         IZn3xEXRc9IsvzysuL9LV7e2QHBc1EVR4ZHs4X9vH4S3itjgoMajG0ne/BMkA4TnKd
         HrAgbMn+PxLt0pNaE1uN0O8esy68Kf6hnti3pY/6Q9TlWhmWWj4taKKEtHPRnqeooB
         bgGyW56ghLJgwyeeQMwV66eeXa4PM67D2+lCcvG4EHHHMAkHkBTzv6atvGjnMfB5A4
         UgzoKb/KTdsbw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2b6cb933so1371344a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:10:30 -0800 (PST)
X-Gm-Message-State: AOJu0Yy3gotncXUWqUqFE3org00rqKDIms8vvuIDAT7EiUZe9QSVYQv0
        bmIYycWWz6PNfQ0qKdj0RG72ABYbSMGHaLeeE1s75Q==
X-Google-Smtp-Source: AGHT+IHT0Ga3k2HwehobvQ094KpaDzUHoTF0BQnVAyg9rq61jKUTEPBaI8omUev0xwQiA7zEScehe6jVq87qUxqw8NI=
X-Received: by 2002:a17:90b:4f8a:b0:27f:df1a:caab with SMTP id
 qe10-20020a17090b4f8a00b0027fdf1acaabmr552651pjb.21.1699657808503; Fri, 10
 Nov 2023 15:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20231106231158.380730-1-nphamcs@gmail.com>
In-Reply-To: <20231106231158.380730-1-nphamcs@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 10 Nov 2023 15:09:56 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPXBLpG2d4sje6ntrA+U-AnLzu3sNpJK02YxNcg04YNng@mail.gmail.com>
Message-ID: <CAF8kJuPXBLpG2d4sje6ntrA+U-AnLzu3sNpJK02YxNcg04YNng@mail.gmail.com>
Subject: Re: [PATCH v4] zswap: memcontrol: implement zswap writeback disabling
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org,
        lizefan.x@bytedance.com, Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org,
        roman.gushchin@linux.dev, Shakeel Butt <shakeelb@google.com>,
        muchun.song@linux.dev, Hugh Dickins <hughd@google.com>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm <linux-mm@kvack.org>, kernel-team@meta.com,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        david@ixit.cz
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

Hi Nhat,

Acked-by: Chris Li <chrisl@kernel.org>

On Mon, Nov 6, 2023 at 3:12=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -219,6 +219,12 @@ struct mem_cgroup {

 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
        unsigned long zswap_max;
+
+       /*
+        * Prevent pages from this memcg from being written back from zswap=
 to
+        * swap, and from being swapped out on zswap store failures.
+        */
+       bool zswap_writeback;
 #endif

I notice the bool is between two integers.
mem_cgroup structure has a few bool sprinkle in different locations.
Arrange them together might save a few padding bytes. We can also
consider using bit fields.
It is a very minor point, the condition also exists before your change.

>  #endif /* _LINUX_ZSWAP_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e43b5aba8efc..9cb3ea912cbe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5545,6 +5545,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *p=
arent_css)
>         WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         memcg->zswap_max =3D PAGE_COUNTER_MAX;
> +
> +       if (parent)
> +               WRITE_ONCE(memcg->zswap_writeback, READ_ONCE(parent->zswa=
p_writeback));
> +       else
> +               WRITE_ONCE(memcg->zswap_writeback, true);

You can combine this two WRITE_ONCE to one

bool writeback =3D !parent ||   READ_ONCE(parent->zswap_writeback);
WRITE_ONCE(memcg->zswap_writeback, writeback);

Chris
