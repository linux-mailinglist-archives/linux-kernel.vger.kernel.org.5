Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CC7ADD03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjIYQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjIYPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:44:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D039E7A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:44:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40537481094so65722695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695656641; x=1696261441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtNJTeTn8zCFpnwQ2yAv3q9ZzhPnaUxajrS7IyL2tyk=;
        b=Ik4G+FfMGAAtg20GfmRsmZuKf1Bym6ZZ0UxsmjicHyUE/kiSr5ddRRcnaajnhsy5DY
         F7ES2cd2nrhSni4lP/t+lspVRnbFZdInfHQzptllJfMlyAKZw8PMG33tuIXSIpDL3qUE
         KjunWam9UdjY1IVBdedTiOiwe7niyNIR7xJVjEoA5f2dY+alrMixsxYg+kVLMYp4byWb
         REYYszCC0/EXjQCIaomRNnE9e96Gxi4nMqYCwb26gmXvvuQ5UxE3bMKnmat7MFrrOXyT
         v/P5AnEECajwUSJFlNGR2B7J9BXrlWPCysC0y9sRZfKMNi10grNqvmK/JLWp8IhCafBG
         rR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656641; x=1696261441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtNJTeTn8zCFpnwQ2yAv3q9ZzhPnaUxajrS7IyL2tyk=;
        b=E6nB4IJoILDgme/VkJOZ6HcaptcfEGv0F4m+FspgEwbTBe+9SqoxqgOJGJyeQRNrAZ
         DIgyJEyM0iSq10SdGOszd8z5gAgAJDUM+OVCcYy+anntCRGhYiNG/Yi+9mE/UqRdrYE8
         F2u7pnQXBHGk9kOVXjAXOeoBK47X2T4Kx7M60k2haZQwaZkIPHaYKnX75RF2SZYZHpeK
         wQFyF8niMQIOwFsQT4g0TObG2mjcEwjgaBdNfVspXDQWOCdjGRUOYXypRqISpaoNg8KU
         CX3ye4uhlfrQ1nZVAjvOocZiiqIJ5f5cm6iICof0Nd8Are6Y79rof85rrSh96eDQdn7x
         mbdg==
X-Gm-Message-State: AOJu0YzO/1x+r6s3eDg0puCVeF5ZG53nfFYLnblMrErEeUe2nUz3IkeP
        faBi6ltgjrWMk+UEyy6LJFOrKZkDOmw8FmxSaO3ELA==
X-Google-Smtp-Source: AGHT+IGqnItEdifav9vybTr0GkP0gvqcEVAaGKC0hh68JGilQJUcfm9ace+LAwaLXavBJl7e/rVQ+ZoV44Z88NpDnQg=
X-Received: by 2002:a1c:4c1a:0:b0:401:bdf9:c336 with SMTP id
 z26-20020a1c4c1a000000b00401bdf9c336mr6175474wmf.27.1695656640529; Mon, 25
 Sep 2023 08:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com> <20230923053515.535607-4-irogers@google.com>
In-Reply-To: <20230923053515.535607-4-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Sep 2023 08:43:45 -0700
Message-ID: <CAKwvOdngy8a0n7TapeMPvANvp1uQuJAJk9i3kDNWx+czFL0=cQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/18] run-clang-tools: Add pass through checks and and
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
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Add a -checks argument to allow the checks passed to the clang-tool to
> be set on the command line.
>
> Add a pass through -header-filter option.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 34 ++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools=
/run-clang-tools.py
> index 3266708a8658..5dfe03852cb4 100755
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
> @@ -45,14 +50,29 @@ def init(l, a):
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
> +    pargs =3D ["clang-tidy", "-p", args.path]
> +    if checks:

^ can `checks` ever be falsy here?  I don't think we need this
conditional check?

> +        pargs.append("-checks=3D" + ",".join(checks))
> +    if args.header_filter:
> +        pargs.append("-header-filter=3D" + args.header_filter)
> +    pargs.append(file)
> +    p =3D subprocess.run(pargs,
>                         stdout=3Dsubprocess.PIPE,
>                         stderr=3Dsubprocess.STDOUT,
>                         cwd=3Dentry["directory"])
> --
> 2.42.0.515.g380fc7ccd1-goog
>


--=20
Thanks,
~Nick Desaulniers
