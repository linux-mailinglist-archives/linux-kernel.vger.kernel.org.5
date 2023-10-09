Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47D7BD2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjJIFvr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 01:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:51:46 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658129E;
        Sun,  8 Oct 2023 22:51:45 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-27736c2a731so3178992a91.3;
        Sun, 08 Oct 2023 22:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696830705; x=1697435505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6To/XFZla//NDfF2btRt6lbatBC8d81aAvKQzzrLLY=;
        b=YUWPfM2iB9Hba3uH1AsuT9HFGzU9zX/wIF1IuF27dkITTF549Jv+4gZSSQzemWbze0
         lgniInAOpM8wxfm5Z1+hMtBooF80ALYwu4bL4F+LbupP0knpsDDMeOkezVG+Q3Tg2fGa
         YIT1iCE8ZToS5MBmQZwEHwrl7wwhhITQbQgxmPR/S+YmcJADF0AYLGoBAWTpiwg22W/n
         5quQOwptj3e28xbBJSKBkaGorJV2BeVj1WVmnzI6jBPtHbFG3Q/FWrhhu4i2pDUUQP6/
         M9SYXD/6Ri/phmsZwRRI7A3sIzIcoimAvRjjApsQgmNDvGRA9tLA7xL9PbRZqVu8AEWx
         06wg==
X-Gm-Message-State: AOJu0Yz+fCdFylaW4rQYsSw4rXRsYxiu+LOQfTg/c0CCyMc7s176g1Uq
        WnfrURS1zdmCL3zvbRwrcincT3DbUDQ1w29jlZY=
X-Google-Smtp-Source: AGHT+IFe+yFp/6ZZtgoksaQEaoA0GtB4qRd6BdyhzEmVCwEhguqPFr5Jdk1nmY7VZfEA4x2t+lec7Svvd6Cx87wSVKk=
X-Received: by 2002:a17:90a:c293:b0:268:18e:9dfa with SMTP id
 f19-20020a17090ac29300b00268018e9dfamr14452873pjt.5.1696830704800; Sun, 08
 Oct 2023 22:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-6-irogers@google.com>
In-Reply-To: <20231005230851.3666908-6-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 22:51:33 -0700
Message-ID: <CAM9d7chmVRrFgEZMYk3EWG+1wjXqLC3suu-xrX64hmfBSAFi0A@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory
 after free
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
> Found by clang-tidy:
> ```
> bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
>                 bench_uprobe_bpf__destroy(skel);
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>

I'm ok with the change but I think it won't call
bench_uprobe__teardown_bpf_skel() if the setup function
returns a negative value.  Maybe we also need to set the
err in the default case of `switch (bench)` statement.

Thanks,
Namhyung


> ---
>  tools/perf/bench/uprobe.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
> index 914c0817fe8a..5c71fdc419dd 100644
> --- a/tools/perf/bench/uprobe.c
> +++ b/tools/perf/bench/uprobe.c
> @@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
>         return err;
>  cleanup:
>         bench_uprobe_bpf__destroy(skel);
> +       skel = NULL;
>         return err;
>  }
>
> --
> 2.42.0.609.gbb76f46606-goog
>
