Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966847BD347
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbjJIGVS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345176AbjJIGVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:21:17 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5EA4;
        Sun,  8 Oct 2023 23:21:15 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3371180a12.1;
        Sun, 08 Oct 2023 23:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696832475; x=1697437275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqzxkQ2kaFA3LhoAZmBsNaaLHYDoJFZNDM8wtB/redY=;
        b=vOtJOzfmgoDQpbLLBWDLVmcr+uVZVAYeptrHPew9/FJdw6mGM10Q8V+Fv0GYUWdoWh
         SGUXaY9j6wTvMpyxDDuDiLzbdRds2A0dYQ20WAJc5IvM5uT8gl4pFDaGSJ+P6uy3BwIW
         n7aRTj5sJ3o3gw6BSC/bX2LZoeDQkvEWMwOtwlWX/iPKST9kCnhoxju+Vt+kNTyRkSDa
         bqZShR+uStwo/lGEOQOeLb80P7/P0lQqFByM9mRf09VWrBwb76y43Ytrf59cwBk2oaan
         9gWfEtSOJg9E0M9N3ptLQ/LyKRQrkYfIoZkOskdYp9dZNiKSd/DaCltxtOYJB3w+DHQu
         zmyA==
X-Gm-Message-State: AOJu0Yw17SS7LhOIPpI/OTTs6NkagiLhPvJg4AvwO8pgt/VMF47LwkmB
        CKs/9yTifBjQdNkg0dWNHi3DU5F259xScnH7XxE=
X-Google-Smtp-Source: AGHT+IHipStQxQb3cJsEmsKyjG2x73hMhk0WqgsHINOilfTS5PE0o/18YQpFkwA82j4XWhtNLoMGqq0ExLQXvPsOs/w=
X-Received: by 2002:a05:6a21:7881:b0:15e:a653:fed5 with SMTP id
 bf1-20020a056a21788100b0015ea653fed5mr18979636pzc.16.1696832475036; Sun, 08
 Oct 2023 23:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-11-irogers@google.com>
In-Reply-To: <20231005230851.3666908-11-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 23:21:03 -0700
Message-ID: <CAM9d7cj3AuAo-+ncd6nULusvgw1NUhBdSAED9vf_eDQ7Z=cEPQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] perf dlfilter: Be defensive against potential
 NULL dereference
To:     Ian Rogers <irogers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 4:09 PM Ian Rogers <irogers@google.com> wrote:
>
> In the unlikely case of having a symbol without a mapping, avoid a
> NULL dereference that clang-tidy warns about.

I'm not sure if it's possible to have a symbol without a map,
but I'm also fine with being conservative.

Thanks,
Namhyung

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/dlfilter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 1dbf27822ee2..5e54832137a9 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -52,8 +52,10 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
>                 d_al->sym_end = sym->end;
>                 if (al->addr < sym->end)
>                         d_al->symoff = al->addr - sym->start;
> -               else
> +               else if (al->map)
>                         d_al->symoff = al->addr - map__start(al->map) - sym->start;
> +               else
> +                       d_al->symoff = 0;
>                 d_al->sym_binding = sym->binding;
>         } else {
>                 d_al->sym = NULL;
> --
> 2.42.0.609.gbb76f46606-goog
>
