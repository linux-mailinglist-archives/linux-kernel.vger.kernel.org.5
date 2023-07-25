Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D780762230
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGYTZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGYTZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:25:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251F1FF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:25:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9939fbb7191so43936066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690313140; x=1690917940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gccFtzx/Ez7hMBziN2qyyxk5R7pKLnaq2lGrOQwbiIg=;
        b=k0n6UJsh+lZ+hTFQLHMj4us4wXltqc2G5v/vYmRmdyhuGwj/r3CqrJQDQxYE7M80HV
         wCdCAHYMJw9hGgaxndA5Yw5povenCAxQCF3buKcM3DMGQeQ/QkKeRqwsSoWAxirUzBFu
         UkmK/vSMxzsFGgwBVpCUK57IAtboaemAE7ebrGWETSgDp9xmV0NDxqEsx/W/U8ADDfcD
         5HNiz8T5RsSwulHQJVJMRYhWuv5n78tVzHmeurEiseDIKMSTADQIF9p6LCbuFCjM3uuJ
         O3Lp/YaO+gnCWAMU/TpQ63dzghPVFrKFG0NlQ7eRmy7GbIg85NO/vUpytbZsiSXE3FIh
         M8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690313140; x=1690917940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gccFtzx/Ez7hMBziN2qyyxk5R7pKLnaq2lGrOQwbiIg=;
        b=KWZS6FGpUq8pZ0HFw0XwFruT/9kyAUpuu6trqiq/y0rNKslTigUbEh5UComEilaF/t
         sNQP8Od9Wxc1od98PNrafDFsaSvUv4bzOLcCdJhFowvDuM+kMElJuDs0xaCYKSOgHdxR
         rWy6P3zwS2GOrnq/PPgewVO+6ukhEHBPB8UvJSKRqjviGTGnXtMdkU4z88a+eEGB6AnJ
         uXMQDQB9oNV5R5jY0DAi2XUbfgHfR1UT0rAri6fQADFMshXWzLvKZEpZlLLsrC5FTaqF
         PIf6AA9e0qOBREh4ksgoZQS9tesFBofDTLFDMtogPI7KSvDYxJUpHqw8ERYwHNaKgQ8F
         Ucrg==
X-Gm-Message-State: ABy/qLYSJTQLnYmokYaQAoobcySBtwQMU32heO+0df9MG99NlnsOmAgT
        ns/4EVtwBJMphIoxAd23ebwmfGSadJbxTpFxgnsGfQ==
X-Google-Smtp-Source: APBJJlE6Jp+9TcsoE2xrGcMb1FH46ep2aSbVKNupu8UWDV9Qk1Z8PkQDoSfBqm9P+BjxfgtQ/hDihq7yHn7I8gjHqik=
X-Received: by 2002:a17:907:1624:b0:978:2b56:d76e with SMTP id
 hb36-20020a170907162400b009782b56d76emr3811521ejc.12.1690313139847; Tue, 25
 Jul 2023 12:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230719174613.3062124-1-yosryahmed@google.com>
 <20230725140435.GB1146582@cmpxchg.org> <20230725104310.ac652a03ab92357a162b1f92@linux-foundation.org>
In-Reply-To: <20230725104310.ac652a03ab92357a162b1f92@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Jul 2023 12:25:03 -0700
Message-ID: <CAJD7tkb47j48TkpH=zwdJZqo5QBehVmyeMMekd6JSbNbR7XLMw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:43=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 25 Jul 2023 10:04:35 -0400 Johannes Weiner <hannes@cmpxchg.org> w=
rote:
>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > But I want to be clear: this isn't a regression fix. It's a new
> > performance optimization for the deprecated cgroup1 code. And it comes
> > at the cost of higher memory footprint for both cgroup1 AND cgroup2.
>
> Thanks.
>
> Yosry, could you please send along a suitably modified changelog?

I will send a v2 once we agree on the history story and whether or not
this fixes a regression.

Thanks!
