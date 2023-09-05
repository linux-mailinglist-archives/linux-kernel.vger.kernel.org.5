Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEEA792D80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjIESlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 14:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbjIESlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:41:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAFDE5B;
        Tue,  5 Sep 2023 11:40:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bc9811558cso2236156a34.0;
        Tue, 05 Sep 2023 11:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693938882; x=1694543682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXok6MvUwSPR830G0ELqOcFD+HtTDfgZAE/uWxwBED4=;
        b=lWBLMwn2qBUPDe8twhfoPpDVI6XsLYlENLADubyul/vIKdnTIcgkT8Qxg62DfiJIfm
         YjUXFI96SgTtgPzOSBFPdzkVA8v882BxiL6oyd41PkN6j3WzPis5zwwu4ei6cOEHGSu1
         GVOF5QIqXk6jmUhHwhhyHwkbJepESQqSiNk5/5Sk4FB7ndTpRaX0MmbgxiVoJN7Lgy26
         h8ngWKRE1wN+RKp5C3lebjGRx4uRtdsO9SeVUUCW5Hlvpwpmj+LoXnGBMammS2iiBCEW
         beEvjAduvuM+qV4eUcWgcvraviYZ4UlsPlQDQDqjJpuhzh+FywQwOUIm7lyRGVXEMsYz
         P+9w==
X-Gm-Message-State: AOJu0YyompzwyM5TqTFcnfK+4yYFel+8kcO7kTqWN+/sYL2kMpiKfwGh
        MVUnn/2UjqwSilkb5YNwBvnRhzP4LdC/9t3i3aoMazhu
X-Google-Smtp-Source: AGHT+IGbVCij9/I9mr87Kh63ZGXPNUA0q8HrltonAeXU+UjF6zDy+QK44X0q41QZ2g8Byk5t7BnAcrYqNzO5a2bZY7U=
X-Received: by 2002:a5d:934c:0:b0:795:13ea:477a with SMTP id
 i12-20020a5d934c000000b0079513ea477amr14119993ioo.8.1693938192658; Tue, 05
 Sep 2023 11:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230905181554.3202873-1-irogers@google.com>
In-Reply-To: <20230905181554.3202873-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 5 Sep 2023 11:23:01 -0700
Message-ID: <CAM9d7cjgBLTusUgq7xTZLkLookouTZotfrjmUX4nsRO7MCbSvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf completion: Restrict completion of events to events
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 11:16 AM Ian Rogers <irogers@google.com> wrote:
>
> perf list will list libpfm4 events and metrics which aren't valid
> options to the '-e' option. Restrict the events gathered so that
> invalid ones aren't shown.
>
> Before:
> $ perf stat -e <tab><tab>
> Display all 633 possibilities? (y or n)
>
> After:
> $ perf stat -e <tab><tab>
> Display all 375 possibilities? (y or n)
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/perf-completion.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> index 978249d7868c..40cfc30ad7ad 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -164,7 +164,7 @@ __perf_main ()
>                 $prev_skip_opts == @(record|stat|top) ]]; then
>
>                 local cur1=${COMP_WORDS[COMP_CWORD]}
> -               local raw_evts=$($cmd list --raw-dump)
> +               local raw_evts=$($cmd list --raw-dump hw sw cache tracepoint pmu sdt)
>                 local arr s tmp result cpu_evts
>
>                 # aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
> --
> 2.42.0.283.g2d96d420d3-goog
>
