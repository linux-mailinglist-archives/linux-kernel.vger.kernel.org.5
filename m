Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9E7BC11C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjJFVW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJFVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:22:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0DC2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:22:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4527d7f7305so1172919137.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627375; x=1697232175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGVNTkTuEhOSEasSh+f06Vtoy0x55i2wMcWJNOvGy7A=;
        b=n+vSk99Wvz8Oz3Kyk9WWynpVMiPaVTPCVsqkZMCw5u8CJK+6xmawQaOuADpFN+l8Sj
         IIv5da45u/CM93dMRQcyjfgJb6WAUArzGxHy5Ibw6dBH493lLbWHh89Gxriv7696X29H
         lHqnY0xHLMySMusxJDGkpoMFnFrJ7PGPNI6UqUhgf0ypADHxwqEaa3Df6jAJOOXSZe6d
         y3t/pnxjUT/9zhbaPiN4UzFsyL72YXnVV8jDk0ln1cjpkyuR8DG78mMz2PlZ3l37a+JY
         Sx+hzPG6SHzbV/dcJLN3E6dNe0RePyhhkrJB2Q1KiPPZ4XgA5ZWP1uKY6FusDeMfmGbp
         mYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627375; x=1697232175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGVNTkTuEhOSEasSh+f06Vtoy0x55i2wMcWJNOvGy7A=;
        b=NS22FQT7vEscqXsGgE+/SHEwYjV7DVHdG4dACqz9SIBfFHWtDxahVOGECIzvBxcWWo
         JQcA1oftvxLfUH3bOlloNRNKsydiC1BQOy8o2heZkMoMdrA6QhsROjfefUT8GIzkpp2k
         EczNSWs9l5LTaXebNVzAErEKCxz7KrkUAcmDaipAA9NpnkIfiuulS7KqnRXhT7bC4eDR
         QPdUl7ytujuRjz8cIj/MCokbjJRr8suCgJ5XRZeOxsnCdxe5KbBgg7yj24F7F2tWF0PE
         QcnRuTziGNGbaccNsCsOUvpUrO2thsupdjN+KWPhtOL0+A5mIFCcpM/htythVsFymwV3
         kN+w==
X-Gm-Message-State: AOJu0YzSI3MDFsWdEIb+9P6txVV5jUCtQt1nVMsNykfxZc6uOIIsaJ+d
        0K1ejTwvsIu2MTDkPbdoqzKZfVv4/blUxcEaaPjWYw==
X-Google-Smtp-Source: AGHT+IHnX81YT51zxIXl1qmhGCbeGEzay4hR/OGqRxoTUMH7ud/FezhnE2gFVlk4Zt9S1a9t+vYObTEVG+pZ/4S4UyE=
X-Received: by 2002:a67:fe58:0:b0:44d:4c28:55ca with SMTP id
 m24-20020a67fe58000000b0044d4c2855camr9318168vsr.16.1696627374720; Fri, 06
 Oct 2023 14:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-4-irogers@google.com>
In-Reply-To: <20231005230851.3666908-4-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Oct 2023 14:22:42 -0700
Message-ID: <CAKwvOd=7r9v72UadbTqk1EK=kMEH3-JybkmarToCs1_ohRC1sw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
To:     Ian Rogers <irogers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add a -checks argument to allow the checks passed to the clang-tool to
> be set on the command line.
>
> Add a pass through -header-filter option.
>
> Don't run analysis on non-C or CPP files.

Three distinct changes; I wouldn't have minded that as three distinct patch=
es.

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 32 ++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools=
/run-clang-tools.py
> index 3266708a8658..f31ffd09e1ea 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -33,6 +33,11 @@ def parse_arguments():
>      path_help =3D "Path to the compilation database to parse"
>      parser.add_argument("path", type=3Dstr, help=3Dpath_help)
>
> +    checks_help =3D "Checks to pass to the analysis"
> +    parser.add_argument("-checks", type=3Dstr, default=3DNone, help=3Dch=
ecks_help)
> +    header_filter_help =3D "Pass the -header-filter value to the tool"
> +    parser.add_argument("-header-filter", type=3Dstr, default=3DNone, he=
lp=3Dheader_filter_help)
> +
>      return parser.parse_args()
>
>
> @@ -45,14 +50,27 @@ def init(l, a):
>
>  def run_analysis(entry):
>      # Disable all checks, then re-enable the ones we want
> -    checks =3D []
> -    checks.append("-checks=3D-*")
> -    if args.type =3D=3D "clang-tidy":
> -        checks.append("linuxkernel-*")
> +    global args
> +    checks =3D None
> +    if args.checks:
> +        checks =3D args.checks.split(',')
>      else:
> -        checks.append("clang-analyzer-*")
> -        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOr=
UnsafeBufferHandling")
> -    p =3D subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks=
), entry["file"]],
> +        checks =3D ["-*"]
> +        if args.type =3D=3D "clang-tidy":
> +            checks.append("linuxkernel-*")
> +        else:
> +            checks.append("clang-analyzer-*")
> +            checks.append("-clang-analyzer-security.insecureAPI.Deprecat=
edOrUnsafeBufferHandling")
> +    file =3D entry["file"]
> +    if not file.endswith(".c") and not file.endswith(".cpp"):
> +        with lock:
> +            print(f"Skipping non-C file: '{file}'", file=3Dsys.stderr)
> +        return

^ perhaps worth returning earlier if this guard fails? i.e.

rather than do a bunch of work, then do a guard that may return early
that doesn't depend on the earlier work, instead guard first then do
all work.

I don't mind that as a follow up rather than a whole v3 for the series.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +    pargs =3D ["clang-tidy", "-p", args.path, "-checks=3D" + ",".join(ch=
ecks)]
> +    if args.header_filter:
> +        pargs.append("-header-filter=3D" + args.header_filter)
> +    pargs.append(file)
> +    p =3D subprocess.run(pargs,
>                         stdout=3Dsubprocess.PIPE,
>                         stderr=3Dsubprocess.STDOUT,
>                         cwd=3Dentry["directory"])
> --
> 2.42.0.609.gbb76f46606-goog
>


--=20
Thanks,
~Nick Desaulniers
