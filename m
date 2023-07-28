Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943067670EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjG1PrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjG1PrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:47:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D32681
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:47:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40550136e54so348411cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690559230; x=1691164030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5kOzcNksCR4x2pHItXcAlkQd0Sq49clDfLGooTZWTQ=;
        b=FGXxPL1ytN3CB6f6k2GL8CUzTgC/qgshBaaNPmbKooV3WMiXzgpi0hkilO8oCK1nhd
         ZQf1RWXL+HwIWRomC8cytIT6Xp4UODREmAWLDxy1Y0PcCFoGmk09V6HWeZfra1lltxXT
         mu4hlkIvgoHq5j/sAo4vvngu63goXbxEYMmZy2vkbfMYIk3a7OE53xpPRO9THerSRrYE
         dRQGR8/t7lTkt+dsuoaJChqXtAZ6CEX2dKZuYJQIts7olNcc3XG3q3al/GZjrnCrrG2N
         wPFK9BPkNRVH6pPyjEq81s07JCVsfrjVZpq+B71sPugkT8zoFlYomt7WGiFUVlJzktVd
         /lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559230; x=1691164030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5kOzcNksCR4x2pHItXcAlkQd0Sq49clDfLGooTZWTQ=;
        b=jQQmzZPw6EL3S4XPz+egXmI2u8/IqaLCpFoT3ctr55yxRCfuw/VmTDOuKotD32fc60
         /0a8POKrVNUwi4HjckHN3RwBr+0OTHXG/ZCiddRWjLQzWdA/GV+6ddML6fFbnG+DBlXO
         I28SMfyHVc7xmOzL6e120Y0Zm1WW4gwmQlFWkApV+ketNpuUsQfryyS3ww1SheHBxEmp
         RiOZfAC7c42jI6gRypOtHbDK7NDybmSRZvdr/E/3BpdObtJY+KZlhmFiXXspOHLuXjdX
         1SQ6QQ2kgXeu49XVLigJUzTcLga7JNVezuWw1ntTymzJ3AYbapu3KOwDBrPhHpp6qqiE
         24uQ==
X-Gm-Message-State: ABy/qLY+LVGy39lbxH2Ik9GOsIB55v3d+wp1fNrpmB1idvd3advtyB0/
        /2kRCcrq/iCzIDBJ1ynXAIHhELJNQNYj/cYiXQHi1Q==
X-Google-Smtp-Source: APBJJlEvfgnC/azHL/CZCqlcM439djFU3LDgROiAsgo3y2VeCSzSpfZB9+O5UMLQ1w3mvtFJNlKo5TcAN8tB8JLGKAw=
X-Received: by 2002:a05:622a:1486:b0:3f0:af20:1a37 with SMTP id
 t6-20020a05622a148600b003f0af201a37mr267553qtx.15.1690559230067; Fri, 28 Jul
 2023 08:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230728151812.454806-2-georgmueller@gmx.net>
In-Reply-To: <20230728151812.454806-2-georgmueller@gmx.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 08:46:58 -0700
Message-ID: <CAP-5=fVxqwDwOUc2RuzHDtWtnrzz2hY6GCwBR4NPS2er5C_BeQ@mail.gmail.com>
Subject: Re: [PATCH] perf probe: skip test_uprobe_from_different_cu if there
 is no gcc
To:     =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:19=E2=80=AFAM Georg M=C3=BCller <georgmueller@gmx=
.net> wrote:
>
> Without gcc, the test will fail.
>
> On cleanup, ignore probe removal errors. Otherwise, in case of an error
> adding the probe, the temporary directory is not removed.
>
> Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced by s=
witch to die_get_decl_file()")
> Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
> Link: https://lore.kernel.org/r/CAP-5=3DfUP6UuLgRty3t2=3DfQsQi3k4hDMz415v=
Wdp1x88QMvZ8ug@mail.gmail.com/

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/to=
ols/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 00d2e0e2e0c2..319f36ebb9a4 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -4,6 +4,12 @@
>
>  set -e
>
> +# skip if there's no gcc
> +if ! [ -x "$(command -v gcc)" ]; then
> +        echo "failed: no gcc compiler"
> +        exit 2
> +fi
> +
>  temp_dir=3D$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
>
>  cleanup()
> @@ -11,7 +17,7 @@ cleanup()
>         trap - EXIT TERM INT
>         if [[ "${temp_dir}" =3D~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]];=
 then
>                 echo "--- Cleaning up ---"
> -               perf probe -x ${temp_dir}/testfile -d foo
> +               perf probe -x ${temp_dir}/testfile -d foo || true
>                 rm -f "${temp_dir}/"*
>                 rmdir "${temp_dir}"
>         fi
> --
> 2.41.0
>
