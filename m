Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B17B7DECC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjKBGEV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 02:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:04:19 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE58BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:04:13 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28023eadc70so600182a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698905053; x=1699509853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9JmNRCSMX3cxhvTtJqtyhnY7GO8nXDu3IZHQQ4SY6Q=;
        b=RqERb01vxxCQgsKTbHqTt9pK51tYaNUhA+3JTcfAu62bc3ORCDBkYFFf6g0v4k8PW4
         ekriYM9fJ2Ju2MFy0qeLrfl1siK0WDF9CFKDCfgEQblkeX7j2R6mdU03tlrGyeu14saM
         qv328bqoSx5DtMDZ3yzOdYMVCQ7DqM5cC+BfdUNlAZHvcB6xxm+n5wIlPKYavXgFCASh
         KgsuGWQ1XsH2ePh2gkAO84paaXXdnHdJu07yvRgxwPOteUZE8GqZcoumNs6zmGQe1Ve4
         azpUwi+vHV83rgZTyjn1fYc5jaIUXMdvUhpJpKvlopxp/kVVcTYCGsRPzIi72/lDvFrI
         XOAg==
X-Gm-Message-State: AOJu0YyicEvQpJyAN8wjQFs1qpzWyyl6gCefibk5EFec4jATmiUKjtFQ
        9de+EV5mGxfUoDp2CUTef24A16t1Fgp99KgrBQQ=
X-Google-Smtp-Source: AGHT+IGUcw6LUfhJ7ZpBdSkq41ZauqR5pMoQBxn2AXiDoGvdWf73Ev1vtE4shTudKbauiWEdIwK6NQ/20zkP9T8kchQ=
X-Received: by 2002:a17:90b:3601:b0:27d:839:52ae with SMTP id
 ml1-20020a17090b360100b0027d083952aemr15218600pjb.32.1698905052648; Wed, 01
 Nov 2023 23:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZUEddFPTJHVLhH/6@kernel.org>
In-Reply-To: <ZUEddFPTJHVLhH/6@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Nov 2023 23:04:01 -0700
Message-ID: <CAM9d7cjJxS-weBz0xKNm1EzQAT42c9T4w=6Fe=ux9DMCLz3KUA@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf beauty socket/prctl_option: Cope with
 extended regexp complaint by grep
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:30 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Noticed on fedora 38, the extended regexp that so far was ok for both
> grep and sed now gets complaints by grep, that says '/' doesn't need to
> be escaped with '\'.
>
> So stop using '/' in sed, use '%' instead and remove the \ before / in
> the common extended regexp.
>
> Link: https://x.com/SMT_Solvers/status/1710380010098344192?s=20
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/trace/beauty/prctl_option.sh | 4 ++--
>  tools/perf/trace/beauty/socket.sh       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
> index 8059342ca4126c38..9455d9672f140d13 100755
> --- a/tools/perf/trace/beauty/prctl_option.sh
> +++ b/tools/perf/trace/beauty/prctl_option.sh
> @@ -4,9 +4,9 @@
>  [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
>
>  printf "static const char *prctl_options[] = {\n"
> -regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*\/.*)?$'
> +regex='^#define[[:space:]]{1}PR_(\w+)[[:space:]]*([[:xdigit:]]+)([[:space:]]*/.*)?$'
>  grep -E $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
> -       sed -r "s/$regex/\2 \1/g"       | \
> +       sed -E "s%$regex%\2 \1%g"       | \
>         sort -n | xargs printf "\t[%s] = \"%s\",\n"
>  printf "};\n"
>
> diff --git a/tools/perf/trace/beauty/socket.sh b/tools/perf/trace/beauty/socket.sh
> index 8bc7ba62203e4a9d..670c6db298ae0298 100755
> --- a/tools/perf/trace/beauty/socket.sh
> +++ b/tools/perf/trace/beauty/socket.sh
> @@ -18,10 +18,10 @@ grep -E $ipproto_regex ${uapi_header_dir}/in.h | \
>  printf "};\n\n"
>
>  printf "static const char *socket_level[] = {\n"
> -socket_level_regex='^#define[[:space:]]+SOL_(\w+)[[:space:]]+([[:digit:]]+)([[:space:]]+\/.*)?'
> +socket_level_regex='^#define[[:space:]]+SOL_(\w+)[[:space:]]+([[:digit:]]+)([[:space:]]+/.*)?'
>
>  grep -E $socket_level_regex ${beauty_header_dir}/socket.h | \
> -       sed -r "s/$socket_level_regex/\2 \1/g"  | \
> +       sed -E "s%$socket_level_regex%\2 \1%g"  | \
>         sort -n | xargs printf "\t[%s] = \"%s\",\n"
>  printf "};\n\n"
>
> --
> 2.41.0
>
