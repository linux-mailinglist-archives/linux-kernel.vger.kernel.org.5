Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8845F7FA8C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjK0SR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0SRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:17:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B945198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:18:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso43664a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109079; x=1701713879; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbO6Rn3HgozfB603dwPHxujztq3d0wQRYz9hizN4I5c=;
        b=QYZdNSY5CQWlwu5md0+10k2T/B1aw1+Kg2M0nJrTeMryt/NTBM9PJPydYLgF6PTqYR
         fUxVbiZ927yCL/pcyjsvME1Jb/3L9+DSMUm/2+T58VW18zDZT789fJP9FOZjrARBXX/1
         IXD4x+wUEjJqouXllXdnm4pDn5CnR+cEIkszbs1uBVfhPk8BCRndNoZz2j5Pk87ywWM+
         z7JCrNYi86kgGg8RY5SQMtybUQIcg64IHOY13S6y75JIieZufeiu8/Ppk49VYw6bpFuA
         ZkD9OmSR3OT4zzSqWbJL5dwr9tikMvJuPaaOstPIOMO9j4qJ+VD7+IzxvvYL3Eqr0iNk
         Il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109079; x=1701713879;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbO6Rn3HgozfB603dwPHxujztq3d0wQRYz9hizN4I5c=;
        b=lJaPMUbSiy9BgDCFb15YsJTZ2HvlckSik1u6L2kO7V8Xrd0jspZ9MCqQAW8s/kJjuG
         f6Y9+2CaHJraGs0zi3PAIF76X7XA/2FEc9sP6nSF7+vxctlRvrMBI1Cn3FXl/ItJG4oG
         kHd6PydIQrR7AATrdWG3dGj7lF67kdsnGZAyXYDWX9JkH8Eal/89+BAjMWgpwRIjwmt4
         FUvtmKjgrQddeO+1z3JLKE635azsuiyh76y6oFyxZ1Wz0EtxxcpqA/3pgmNm599P7z55
         A7O+jt3TNhC9AGvZ+ocXTqKy0/1ODRhGwZ5XPOWaHkOWoxpkJkK7qR2sPmGyDZKbDXSy
         djLQ==
X-Gm-Message-State: AOJu0Yxe8zgQRVHf+dGT/PVFmD+ORvgni/q/M8zFCRkuSyKO5JP73r5A
        vVmGkpaJ1XS6KMfzlz00x+tJAHeDloawIRfUHJUvYQ==
X-Google-Smtp-Source: AGHT+IGcxh9IUDZlSXE311RsVrwWNEKtFxWrzMAlc7/JeAkg9bemUQ7+Rz1b7VOxjjNQLe6zlmzJJ/CQlZzxCrhVyUw=
X-Received: by 2002:a05:6402:88d:b0:54b:221d:ee1c with SMTP id
 e13-20020a056402088d00b0054b221dee1cmr249061edy.5.1701109079467; Mon, 27 Nov
 2023 10:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20231109232732.2973015-1-irogers@google.com>
In-Reply-To: <20231109232732.2973015-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 27 Nov 2023 10:17:48 -0800
Message-ID: <CAP-5=fV50dXzK47WyqT-MEX1TfTrEJdGNhuBLSQ3nLE0+F3_Uw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events: Add skx, clx, icx and spr upi
 bandwidth metric
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 3:28=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add upi_data_receive_bw metric for skylakex, cascadelakex, icelakex
> and sapphirerapids. The metric was added to perfmon metrics in:
> https://github.com/intel/perfmon/pull/119
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 6 ++++++
>  tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json    | 6 ++++++
>  .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json     | 6 ++++++
>  tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json    | 6 ++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json=
 b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 84c132af3dfa..8bc6c0707856 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -1862,6 +1862,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> index e98602c66707..71d78a7841ea 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -1846,6 +1846,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> index 06c6d67cb76b..e31a4aac9f20 100644
> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> @@ -1964,6 +1964,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index 4a8f8eeb7525..ec3aa5ef00a3 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -1806,6 +1806,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
