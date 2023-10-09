Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0487BD307
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbjJIGHD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345128AbjJIGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:07:01 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B799A4;
        Sun,  8 Oct 2023 23:06:56 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2776d882214so2544461a91.2;
        Sun, 08 Oct 2023 23:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696831616; x=1697436416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjxneKkkqrx1oncikRu0Qi4dyA9GT6GAt8sDRuISidk=;
        b=sZQNFkEdjLTTEp9W1dchhd63Zh91jASKpzLC+9b246YiOcTyi1G/s9uRcYL/9ZbqQY
         frdOEL1Eu3zbdcyxQUZSY7dJOzCTe1NN0nW4D1Isf9bZPTDLVTYgUeCp1HMlZU5Pb44u
         xHgR8rhcAUyPWFm1SBdeI4zaT8Q4yvjz0vJfbxl+AcfjZgDb0hf3DNuejw0UbTSIPbEj
         YrpJ9N68Jkl7T2TaojrSNnnHyv6aVCrzPn4s7qRk+Ub/fCzsZD1B/RQ3QorfjV4JJ3Jh
         e4PHkXFDq2wI6TgNDD7uccuyoiu9Jg+9ViTcM2N2iuttlMgwLarHbBpD0zil0QDxx/cZ
         O4MQ==
X-Gm-Message-State: AOJu0YzhnIuVUh2mChn3EeefkASJTqVcL6Z0fThZ65x3Qu2R7zSIzskj
        7tTy4wuHALvdajB3TWjjPBAJBSRaRpQ0vhIeiLI=
X-Google-Smtp-Source: AGHT+IE96wBnK3o5FMWQPBk64nrh21K6OSIjXi5hLdFj4vStoyOVhL4n/9OMc/iQ5OPMJOHsXm4Drcmm78xp6fydi4g=
X-Received: by 2002:a17:90b:33c6:b0:279:19b7:9be7 with SMTP id
 lk6-20020a17090b33c600b0027919b79be7mr12103542pjb.5.1696831615986; Sun, 08
 Oct 2023 23:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-7-irogers@google.com>
In-Reply-To: <20231005230851.3666908-7-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 23:06:44 -0700
Message-ID: <CAM9d7cjB_Sm4xnXexDqq_Q4jmOrwhxBjQbAhr-UTmb_4CPLONw@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] perf buildid-cache: Fix use of uninitialized value
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
> The buildid filename is first determined and then from this the
> buildid read. If getting the filename fails then the buildid will be
> used for a later memcmp uninitialized. Detected by clang-tidy.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-buildid-cache.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index cd381693658b..e2a40f1d9225 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>         char filename[PATH_MAX];
>         struct build_id bid;
>
> -       if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
> -           filename__read_build_id(filename, &bid) == -1) {
> +       if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
> +               return true;

This won't print anything and ignore the file which changes
the existing behavior.  But if it fails to read the build-id, I
don't think there is not much we can do with it.  IIUC the
original intention of -M/--missing option is to list files that
have a build-id but it's not in the build-id cache.  So maybe
it's ok to silently ignore it.

Thanks,
Namhyung


> +
> +       if (filename__read_build_id(filename, &bid) == -1) {
>                 if (errno == ENOENT)
>                         return false;
>
> --
> 2.42.0.609.gbb76f46606-goog
>
