Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418CA7F2847
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjKUJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjKUJCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:02:13 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A65CA;
        Tue, 21 Nov 2023 01:02:09 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so1931030241.2;
        Tue, 21 Nov 2023 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700557328; x=1701162128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vySVtlxZasL8ujz46d4j31n+R/7yltOZRIzr3n9abgM=;
        b=lIckEBX9cdnwHccw/j1P9Vab8LpjlU3l63/9P2jH4wym4fOEt0sM+CM0/TXRygT/7+
         4l0LZ4vkCAoPmhm+pXTWH6qy7YFMsyUdrIotTbaMUkktRPQXDnjpopv4wQG0n9uKjUdQ
         Z/H9wm6TT4jB1kXUV2oVzds97hboe4eIPgj+ti9J3jiZA6AdBGqMgPHiI8VMHoxL1XBK
         jGoVD5d9jPbS8osx3vI6BGGGCK+pLQIYg7TgZeEz2R7vtZUPUhh8Gudmoo1glLmf1gXE
         zh5coqB67jjVzGGT9U54E48W2q2I9iGbrdYIKpg5d5Lwiyp4Z88L2rH2rnDA8UPE3Db+
         JIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700557328; x=1701162128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vySVtlxZasL8ujz46d4j31n+R/7yltOZRIzr3n9abgM=;
        b=OAHlVWzt39CrM57iKJ+mRagXzsiiUTKvj5i+PXdr6ZH5c91oEAyQzdY6hxl0mM+7ck
         zwyKXR4Fqqavw9d/ziaAnWQYVmz1u6ao2kXQyrz0BC6Hj3m1CKIFKXH/hkgjTY8B3QaU
         DcSxibrvdX7Vz6TVkXDZri5a/kZqtNjPuLOceEGRQ0ND+Jm3mDeNX35fWblw/vYbZ2Zj
         Z2LHebbyMtHKTHlE+4IJxycnZ5ZrQgSMEAZdXV6YD0YXHwrdeNnbkJ0Fd0ghId43BLLq
         3EMYeo+chW6QDFehppO+h9OPSr60glLjgGl6MSBxn0ku9cOx5Qh1KZkPbzrpSVDcEbJi
         MddQ==
X-Gm-Message-State: AOJu0YygDFAlQfQS4kFzOBMWhqOVdaIWkjdVcTp9MgbSXd0aBV3uXJlV
        /N8LTjXs+RTEyy/qk2puX8ETyIb1Y9Rxh/cduEw=
X-Google-Smtp-Source: AGHT+IFc+3mDgcjtqb/7aZD84LfT9fY0MiwdUWtRt4/j8EHWdIVuAoKJFJBTNJIKOAFXIiL4CwjNKbdcw3VxpVy01tM=
X-Received: by 2002:a67:bb10:0:b0:45d:b889:3770 with SMTP id
 m16-20020a67bb10000000b0045db8893770mr7404679vsn.1.1700557328478; Tue, 21 Nov
 2023 01:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20231120091214.150502-1-sxwjean@me.com> <20231120091214.150502-5-sxwjean@me.com>
In-Reply-To: <20231120091214.150502-5-sxwjean@me.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 21 Nov 2023 18:01:57 +0900
Message-ID: <CAB=+i9RUP+Ar3x63sbDTq8+=nkygp2bJ1Py962U7ATyNU6Npvw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/slab: move slab merge from slab_common.c to slub.c
To:     sxwjean@me.com
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 6:13=E2=80=AFPM <sxwjean@me.com> wrote:
>
> From: Xiongwei Song <xiongwei.song@windriver.com>
>
> Since slab allocator has been removed. There is no users about slab
> merge except slub. This commit is almost to revert
> commit 423c929cbbec ("mm/slab_common: commonize slab merge logic").
>
> Also change all prefix of slab merge related functions, variables and
> definitions from "slab/SLAB" to"slub/SLUB".
>
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slab.h        |   3 --
>  mm/slab_common.c |  98 ----------------------------------------------
>  mm/slub.c        | 100 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 99 insertions(+), 102 deletions(-)
[...]
> +/*
> + * Merge control. If this is set then no merging of slab caches will occ=
ur.
> + */
> +static bool slub_nomerge =3D !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT);
> +
> +static int __init setup_slub_nomerge(char *str)
> +{
> +       slub_nomerge =3D true;
> +       return 1;
> +}
> +
> +static int __init setup_slub_merge(char *str)
> +{
> +       slub_nomerge =3D false;
> +       return 1;
> +}
> +
> +__setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
> +__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);

FYI This hunk breaks kernel builds:

In file included from ./include/linux/printk.h:6,
                 from ./include/asm-generic/bug.h:22,
                 from ./arch/x86/include/asm/bug.h:87,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/mmdebug.h:5,
                 from ./include/linux/mm.h:6,
                 from mm/slub.c:13:
mm/slub.c:748:45: error: =E2=80=98setup_slab_nomerge=E2=80=99 undeclared he=
re (not in
a function); did you mean =E2=80=98setup_slub_nomerge=E2=80=99?
  748 | __setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
      |                                             ^~~~~~~~~~~~~~~~~~
./include/linux/init.h:340:32: note: in definition of macro =E2=80=98__setu=
p_param=E2=80=99
  340 |   =3D { __setup_str_##unique_id, fn, early }
      |                                ^~
mm/slub.c:749:41: error: =E2=80=98setup_slab_merge=E2=80=99 undeclared here=
 (not in a
function); did you mean =E2=80=98setup_slub_merge=E2=80=99?
  749 | __setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
      |                                         ^~~~~~~~~~~~~~~~
./include/linux/init.h:340:32: note: in definition of macro =E2=80=98__setu=
p_param=E2=80=99
  340 |   =3D { __setup_str_##unique_id, fn, early }
      |                                ^~
  CC      kernel/time/ntp.o
mm/slub.c:742:19: warning: =E2=80=98setup_slub_merge=E2=80=99 defined but n=
ot used
[-Wunused-function]
  742 | static int __init setup_slub_merge(char *str)
      |                   ^~~~~~~~~~~~~~~~
mm/slub.c:736:19: warning: =E2=80=98setup_slub_nomerge=E2=80=99 defined but=
 not used
[-Wunused-function]
  736 | static int __init setup_slub_nomerge(char *str)
      |                   ^~~~~~~~~~~~~~~~~~
