Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C683788D69
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbjHYQsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344079AbjHYQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A0E67;
        Fri, 25 Aug 2023 09:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89097629C1;
        Fri, 25 Aug 2023 16:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72FCC433CB;
        Fri, 25 Aug 2023 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692982088;
        bh=Q79LYCwbEEcZzJqxzYl+4FUzvrTxSOie7i/yZqWDwTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ie6Wt0NkLp4XAfqT8VvcAYFfUBhnLm5nzQ48i4VMlrJGX7NpUq5fOg5we1JlSjzD5
         MyJuy95XrB6ooDD6qqTPgij00M+A/QzdsFyrizv+t1vr6noCySNUecSmMGs0WoVV4Y
         f+RV1G19RrXva7PAAXzYZbsQGi2JnXwPCUS0UEhxToCieRvPGOXdpw3lg0sn8pFTXq
         2b4Ckdb8kyjuWV4G+tizpktEIh7lmD+xzPrB2a4MVcEWP/187gJCbbGjZ61S6ILdR6
         XkGBKEzoolYOoONor6LiupuQvDlX0C6LFZTPIK/9avxW5Uz28FeUNmftMTFWlK9+UF
         04upIMvDHz66A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-500913779f5so1738506e87.2;
        Fri, 25 Aug 2023 09:48:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRnM9npOYCr4w/0l/pyjh6jgLaBMkeNCOPLtV0g2IhplIcoccA
        IA01jxZhHQJ9kXAFRqvMY/0XC+H7axVSWUleQ2M=
X-Google-Smtp-Source: AGHT+IGSW1A8/Tpphe6fWlm78FsnJvvdIjMAO9DAAkWifGczRpLUkAreq1u3GY30U9ATT7TcYLzs5/MPKUSkjKXR1v4=
X-Received: by 2002:a19:e058:0:b0:4ff:b830:4b69 with SMTP id
 g24-20020a19e058000000b004ffb8304b69mr11319015lfj.6.1692982086875; Fri, 25
 Aug 2023 09:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230825164152.165610-1-namhyung@kernel.org> <20230825164152.165610-2-namhyung@kernel.org>
In-Reply-To: <20230825164152.165610-2-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 25 Aug 2023 09:47:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5u8Rd4XVF27eeW7CPhAdSF+wfnxKwWRnYPDsXV=_9_aA@mail.gmail.com>
Message-ID: <CAPhsuW5u8Rd4XVF27eeW7CPhAdSF+wfnxKwWRnYPDsXV=_9_aA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf test: Fix perf stat bpf counters test on Intel
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> As of now, bpf counters (bperf) don't support event groups.  But the
> default perf stat includes topdown metrics if supported (on recent Intel
> machines) which require groups.  That makes perf stat exiting.
>
>   $ sudo perf stat --bpf-counter true
>   bpf managed perf events do not yet support groups.
>
> Actually the test explicitly uses cycles event only, but it missed to
> pass the option when it checks the availability of the command.
>
> Fixes: 2c0cb9f56020d ("perf test: Add a shell test for 'perf stat --bpf-c=
ounters' new option")
> Cc: stable@vger.kernel.org
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Song Liu <song@kernel.org>

Thanks!
Song

> ---
>  tools/perf/tests/shell/stat_bpf_counters.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tes=
ts/shell/stat_bpf_counters.sh
> index 513cd1e58e0e..a87bb2814b4c 100755
> --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> @@ -22,10 +22,10 @@ compare_number()
>  }
>
>  # skip if --bpf-counters is not supported
> -if ! perf stat --bpf-counters true > /dev/null 2>&1; then
> +if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
>         if [ "$1" =3D "-v" ]; then
>                 echo "Skipping: --bpf-counters not supported"
> -               perf --no-pager stat --bpf-counters true || true
> +               perf --no-pager stat -e cycles --bpf-counters true || tru=
e
>         fi
>         exit 2
>  fi
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
