Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62B7D2367
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjJVOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:53:15 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D37F3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:53:12 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7b08ac3ce7fso882464241.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697986391; x=1698591191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP0KrBI8AS67NUkuMfLFP9LwudamMNHt7euRseduZfc=;
        b=hcmvInGLS2gGkqua40B4LC3hpCtIMwDa7BuafzeOmOoRhHMNLxQuQD/nth0AFPeYfV
         XY4loya3s3m2mqqWHTaCzfaldQhAwGqJml0BMgQMLc4Nw5dw+Ml/Dz6IYJhadESQP3CO
         iPhMdy3JC2isBUqYx3wiRDAz6afXjOCdxa07sBzFfbQC70pZNjzQnTvAGIjmtoKrPvZc
         ZoXW36L9dHo3hBuCLR7uK9kyolHgk5cyo3Oa1sfkN9bv+fKHK3AxBWkGoAPwYCpBaNh2
         MrpeV6RiTW6hvYtAhO+bzmpw+kYHB6kS8FEcHcURv5rpviCJ6EWcYRhot/81CDZGjcqj
         QQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697986391; x=1698591191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP0KrBI8AS67NUkuMfLFP9LwudamMNHt7euRseduZfc=;
        b=MJRkHHhD9AhIyceMLXRSPbndmIHf5b6ateXj8crb/0tIJO8+AMNCpjSkojAOAbpmAq
         H5JzjyGmobnkrXhcacYRGLY+5GoWqx9QuBRF7DDvKtSRXoRLh+AkWa+5uPSkIpDSlbc3
         c7OvkztWlCgtCDtp5pAJ3l001raBV0zEKJUr6zriZQ3P12rALu+CjTx2vVqgC3pQtYhC
         kTsYeZgToGJCIczk6fF57YEy0MExLvNxZVjkgGMPk3bEJcBriEOS3/jHrrx7Rk4vD2zE
         AZt4OqqpD/XwFtw9HhZVtyEU8FtVQ4SDR65D5B5jqAwhEoch87E/IImxc3muSwUHQqzF
         uyAw==
X-Gm-Message-State: AOJu0Yy6xniYNPnmEySoq7WKhqBUA9brGP2lDlFui83CULUYxUNr58EV
        vLFRIciX11tgszNUVkAOUlAujCJmOagIt22Tbw0=
X-Google-Smtp-Source: AGHT+IHOdyqLINe1vV+OFZAMW6OHpJs+LFmbhSB8DW7WpiKMpoF9cVEkM3hQauEPGZokHVJyMDqXKBmtqlwhcxlu/KQ=
X-Received: by 2002:a05:6102:51:b0:450:c666:fe14 with SMTP id
 k17-20020a056102005100b00450c666fe14mr5588731vsp.30.1697986391057; Sun, 22
 Oct 2023 07:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
In-Reply-To: <20231021144317.3400916-1-chengming.zhou@linux.dev>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sun, 22 Oct 2023 23:52:59 +0900
Message-ID: <CAB=+i9Rm3y+y1HrYLuEHP-q8qXnvwgM62XJ_rqHnN=Eb3HFTPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/6] slub: Delay freezing of CPU partial slabs
To:     chengming.zhou@linux.dev
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 11:43=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> Changes in RFC v2:
>  - Reuse PG_workingset bit to keep track of whether slub is on the
>    per-node partial list, as suggested by Matthew Wilcox.
>  - Fix OOM problem on kernel without CONFIG_SLUB_CPU_PARTIAL, which
>    is caused by leak of partial slabs when get_partial_node().
>  - Add a patch to simplify acquire_slab().
>  - Reorder patches a little.
>  - v1: https://lore.kernel.org/all/20231017154439.3036608-1-chengming.zho=
u@linux.dev/

I've picked [1] and tested this patch series and it passed a simple MM
& slab test
in 30 different SLUB configurations [2].

Also there's code coverage information [3] if you're interested :P

For the series,
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Will review when I have free time ;)
Thanks!

[1] https://git.kerneltesting.org/slab-experimental/log/
[2] https://jenkins.kerneltesting.org/job/slab-experimental/
[3] https://coverage.kerneltesting.org/slab-experimental-6283c415/mm/index.=
html

> Chengming Zhou (6):
>   slub: Keep track of whether slub is on the per-node partial list
>   slub: Prepare __slab_free() for unfrozen partial slab out of node
>     partial list
>   slub: Don't freeze slabs for cpu partial
>   slub: Simplify acquire_slab()
>   slub: Introduce get_cpu_partial()
>   slub: Optimize deactivate_slab()
>
>  include/linux/page-flags.h |   2 +
>  mm/slab.h                  |  19 +++
>  mm/slub.c                  | 245 +++++++++++++++++++------------------
>  3 files changed, 150 insertions(+), 116 deletions(-)
>
> --
> 2.20.1
>
