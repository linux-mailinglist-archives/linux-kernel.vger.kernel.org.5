Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B78752A58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjGMSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGMSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:33:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734162D46
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:33:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98df3dea907so145005366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689273195; x=1691865195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eTbts8cHZSzakMKK2Zdyg4qGmgVnQqsmrB4hVj4oIo=;
        b=MfvQrnz3HQM5uz3bUzlEICp3/ZryjhT3ML1rJzkGnCys+HNir8SHdMag1/s/C5Xa53
         2eQ0aNkn7mmeFhB12PYRwc6FjzzoC2QIuUXZ9Mb10qoenWygdzZZtTvdjmeCrDzurzbG
         I9iBCPSNZhXadon5dPLLPeuXPC6d+ISaE6qrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689273195; x=1691865195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eTbts8cHZSzakMKK2Zdyg4qGmgVnQqsmrB4hVj4oIo=;
        b=IPpl1Vmw7ieY6YPfA4xOOnm2crcc0tdUcHtRgA6CtZbkQazc17Qxt4qYoSxQdbfV7A
         oTYYU75Fs/BnQcWyxxbJcHrBvBBk6srWwy+nZqbYvjVrZNz6h1YDxgl+u0FVRMl/gT89
         36bFN6jqH+rJTImAnRK3NJcV5wtEA+YWtIZJHCNq0CcuBM+NUyxkUUOX4t0o9NwNCIJr
         APDNOCNyeMeVeYCiR9JkwDqGHIyBqyUdVxV5O0X11aKdZtL1gocquuyDxufnYiwWWGde
         dcczLXRLp7rxWZFwmHDJXrpNThE5Q/rmKFeoqcfgXJUJLIhpF4C9gh3SdPrn8Wazj9YO
         CSDA==
X-Gm-Message-State: ABy/qLbT5dAzY9eXEH4ZWLs45e059bZ/+hArt1CNv7MYs7FLSxzKmbDW
        iFVrb+3OxMpWbIwzma7Wz6z+Do2j64lmG7dIBXEzbS/B
X-Google-Smtp-Source: APBJJlEOtxso6b+8NV4QvCz7q50dCO0hRCMwvGKZ4VzyKsJXBAnrVSiRKo6Q1+HO1uW+LZ+CKgc72A==
X-Received: by 2002:a17:906:7a58:b0:988:6bd2:b0b3 with SMTP id i24-20020a1709067a5800b009886bd2b0b3mr2254876ejo.60.1689273194911;
        Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906080600b00993470682e5sm4316521ejd.32.2023.07.13.11.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-991c786369cso146127866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
X-Received: by 2002:aa7:d511:0:b0:51d:91d2:335b with SMTP id
 y17-20020aa7d511000000b0051d91d2335bmr2839984edq.1.1689273173806; Thu, 13 Jul
 2023 11:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711011412.100319-1-tj@kernel.org> <20230711011412.100319-28-tj@kernel.org>
 <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
In-Reply-To: <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jul 2023 11:32:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
Message-ID: <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
Subject: Re: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 06:46, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> I'm not sure if we already have an equivalent of
> smp_store_release_u64/smp_load_acquire_u64(). Otherwise, it may be worth
> to add them to a more generic place.

Yeah, a 64-bit atomic load/store is not necessarily even possible on
32-bit architectures.

And when it *is* possible, it might be very very expensive indeed (eg
on 32-bit x86, the way to do a 64-bit load would be with "cmpxchg8b",
which is ridiculously slow)

              Linus
