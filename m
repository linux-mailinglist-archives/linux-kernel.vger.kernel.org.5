Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBC7BBD9C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJFRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjJFRWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:22:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79FCF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 10:22:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-668d9c1f70fso12613616d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696612927; x=1697217727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EknEuy8+VO/WBZWGFtfzssW3dtzNayZawyALF7dqvnA=;
        b=SlyUjpb4Z98wEz8TOIrAkLCzruhoe2QiH6UhEDbrld3+oLP+LtK3GOcImTm2dZJNbt
         M7r9n0ohVXL76p6FVcIw4mgURNAhwdOF9/S4mcJhiOCQ8uYKEHyHLtvkJC3NxWPPHdG8
         DsIeER1sUVGPd40Q3WL9xarulC0HmOWrlnLOmE1JR/n3DiZI3fOAXhjQhMCVJUyU8KFd
         2ULPvUKc/In4u0ETchVLf0qdDnzsuuFY7kiNLRBVMBjv1cARQLe73bY1449SQJdp8F4K
         D46j5WOaHNQbNlzDPk7EKX9/2MftpO0ONqYHcGd6u4wpDKj8vzAsMILJyujv18mRG5AR
         itTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696612927; x=1697217727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EknEuy8+VO/WBZWGFtfzssW3dtzNayZawyALF7dqvnA=;
        b=jg0MTgMv/PgzKHIE5lHyaJLAFp9hlKOllaBCqmmjKnVodyuwsGDVBZnwjoFxflXACk
         mMVmSo8QbJqpPVnP/wbsd16JZ3BbW0mDeV9nmEbKP+ifCusA2TsIvLy3VRrAEN94vtVI
         P76IFuQtmpyg9y9lOMw+OoqEU5bcsqhymvUfwmlx8z5fkcpsJ2CESDerEhV9oGYDaRvI
         ZKz1rnKv3otBnl61Uh74Uy0XA9Hs5GQA1n02aw3SymtMFt+nsNCQlt2WPn9SIfoAnBcu
         7TP3EtQxFyRI1dYMHKuPwJuBENbXgOjsRhZHGJaiNBL/tOvuwtTjelTaF4r221yQHVpT
         ekrQ==
X-Gm-Message-State: AOJu0Yytk6osszNYNQIUANKgahGuwx6ojgdqZBbqxKmH2SIR9CBVQ96c
        BP8rGZS8mZrG+/wMhj1iQltsbF8oEHnv/HIyE9Ws6Q==
X-Google-Smtp-Source: AGHT+IHgHuSZWW0zfjtiu53Q/dfXf6JAdjtdD5ymPm4GEksstftSEGfNyqhSiXc3DrR0aWOMGHN5RryhqLR06mwr6h0=
X-Received: by 2002:a05:6214:180e:b0:65b:ed3:9a02 with SMTP id
 o14-20020a056214180e00b0065b0ed39a02mr8264327qvw.17.1696612926911; Fri, 06
 Oct 2023 10:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <e78360a883edac7bc3c6a351c99a6019beacf264.1694625260.git.andreyknvl@google.com>
 <CAG_fn=UAF2aYD1mFbakNhcYk5yZR6tFeP8R-Yyq0p_7hy9owXA@mail.gmail.com>
In-Reply-To: <CAG_fn=UAF2aYD1mFbakNhcYk5yZR6tFeP8R-Yyq0p_7hy9owXA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 6 Oct 2023 19:21:25 +0200
Message-ID: <CAG_fn=XyqgfZO=bduYPTGpM9NovQPZOzZf8cidt7=m6H092sSg@mail.gmail.com>
Subject: Re: [PATCH v2 06/19] lib/stackdepot: fix and clean-up atomic annotations
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 6:14=E2=80=AFPM Alexander Potapenko <glider@google.c=
om> wrote:
>
> On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Simplify comments accompanying the use of atomic accesses in the
> > stack depot code.
> >
> > Also drop smp_load_acquire from next_pool_required in depot_init_pool,
> > as both depot_init_pool and the all smp_store_release's to this variabl=
e
> > are executed under the stack depot lock.

Maybe add this to the comment before "if (!next_pool_required)" ?
