Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E84F7B6011
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbjJCErJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbjJCErH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:47:07 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0E9D3;
        Mon,  2 Oct 2023 21:47:04 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-27734d76e1bso316273a91.2;
        Mon, 02 Oct 2023 21:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696308424; x=1696913224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAqDrWh5okAg7A4rwUqEIqw966pHJE6DnlfG9T172Og=;
        b=C3kbFTb2LPG45VemVUALv9/iRhcnt4KufMK50bYhhkB1i6IUqCNuaFrb2H3Sa58q19
         zvtqIhXSxD1CcGr7uk/4QBIxrNUhlKMQ5sxFcpKweyuhUDFjTbY3d/BKAjtHmw5UeL0k
         suX/epbIuRzSsv0x3MZgNoJPb1+Iw4fWpZwJXXizha9SASzuvJlehoUPR9MD0Q1/QS7w
         puaL518lsGJyW2ozwjesaHa/y4EkJqv1mbb0EEuf5I5vHuTke5owYqQbNfpLsM+95yYY
         KsGGQkygm2FBNdFJs8SXdKhygh0N+WD/aLij3swnbZ9I1fvkaHFs8K4X9aL3qS7eoCTP
         aR/Q==
X-Gm-Message-State: AOJu0YxLUYGHtyIpYMZWcjMR+Dh0v38fjYufNXBZjS8hQT+ny5+9Fuva
        u8htxVQU+q62JjHaFZ9J+cNqHk2as4mIaw4Sv3A=
X-Google-Smtp-Source: AGHT+IERzbYaWyQbhR+nShIBM4jHt1nNh96uFF52D5YOmaclsP8HnUboUKfBMQ9IF8frZVoiDMCY/uHbsOB6iavotQY=
X-Received: by 2002:a17:90a:6c41:b0:268:15dd:c5c7 with SMTP id
 x59-20020a17090a6c4100b0026815ddc5c7mr10411882pjj.40.1696308423944; Mon, 02
 Oct 2023 21:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230930060206.2353141-1-irogers@google.com>
In-Reply-To: <20230930060206.2353141-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:46:52 -0700
Message-ID: <CAM9d7chAvXoU90uCNAqr6DxH1-pUYqd82_BAdoZjjs1Uscm8Vw@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: Avoid system wide when not privileged
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Ian,

On Fri, Sep 29, 2023 at 11:02 PM Ian Rogers <irogers@google.com> wrote:
>
> Switch the test program to sleep that makes more sense for system wide
> events. Only enable system wide when root or not paranoid. This avoids
> failures under some testing conditions like ARM cloud.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

While I'm ok with the change, I wonder why it doesn't have the same
code structure as in the stat_all_metrics.sh which checks the actual result.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> index cb35e488809a..f3e305649e2c 100755
> --- a/tools/perf/tests/shell/stat_all_metricgroups.sh
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -4,9 +4,21 @@
>
>  set -e
>
> -for m in $(perf list --raw-dump metricgroups); do
> +function ParanoidAndNotRoot()
> +{
> +  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> +}
> +
> +system_wide_flag="-a"
> +if ParanoidAndNotRoot 0
> +then
> +  system_wide_flag=""
> +fi
> +
> +for m in $(perf list --raw-dump metricgroups)
> +do
>    echo "Testing $m"
> -  perf stat -M "$m" -a true
> +  perf stat -M "$m" $system_wide_flag sleep 0.01
>  done
>
>  exit 0
> --
> 2.42.0.582.g8ccd20d70d-goog
>
