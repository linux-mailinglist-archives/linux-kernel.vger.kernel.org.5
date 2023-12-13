Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C16810777
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378147AbjLMBRz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 20:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377653AbjLMBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:17:54 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE4199;
        Tue, 12 Dec 2023 17:18:00 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58dd3528497so3908034eaf.3;
        Tue, 12 Dec 2023 17:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430280; x=1703035080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrBztKR7DBFWjHGGF4oqW3fatxTjNIhtib1nUgBnZG0=;
        b=k3FjPQ64/J4SrhOq0pOTnes1t1AqjbLgEAtli7UpsPiRbRbVCv9ckIMmEdZgpwLG+8
         Xh7ULH1975WhC9TWrbtu3pZ+1uOgb6KokSaX6cZrb4kPRKHE7JGPt0AXKtxmZXaIQIab
         HENmgmORsSF226sKdGCJkWADcg4Rtqe7vaYJHURRU0z3LyIg3CIcS9pvuLZ0ZCF8zeeG
         TZfW/PvI41JpeNqiya+KhXX8WNsruOfyYkHLolaolyl0/QL6U2W7ZF7HTr1uQwPtmxpd
         ElFW4PFZRaC5xvn0y0K42b5b31EGoR2OKa1KEZcle8zaYYbrLdRk1k27Pw/pr0lWFFSu
         /tkw==
X-Gm-Message-State: AOJu0Yy6JxjYs/1/NLMUKTOdiXFo8oUqQg3ix3EMu8/f5AdB/8XNlsPx
        phgtbxJwMLNod6BGoQTzc5Vih0d+u+ex/e1dw/g=
X-Google-Smtp-Source: AGHT+IGLl2RaiPS+JDWzHTX1nc4PK06yrw1EpdlQ9nDdu0JL4PGUSDocs0deDQImGZM0/It/b+1jan8KJcbEsFaEjGA=
X-Received: by 2002:a05:6358:4194:b0:170:ee27:bfa1 with SMTP id
 w20-20020a056358419400b00170ee27bfa1mr2326149rwc.5.1702430280044; Tue, 12 Dec
 2023 17:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20231207081635.8427-1-yangyicong@huawei.com> <20231207081635.8427-2-yangyicong@huawei.com>
In-Reply-To: <20231207081635.8427-2-yangyicong@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 12 Dec 2023 17:17:49 -0800
Message-ID: <CAM9d7cgW9YaS7+2Y0zPszbkSZpu2XgJjW3GP+yig4C-++vJ4-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf header: Fix one memory leakage in perf_event__fprintf_event_update()
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, hejunhao3@huawei.com,
        yangyicong@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 7, 2023 at 12:20 AM Yicong Yang <yangyicong@huawei.com> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> When dump the raw trace by `perf report -D` ASan reports a memory
> leakage in perf_event__fprintf_event_update(). It shows that we
> allocated a temporary cpumap for dumping the CPUs but doesn't
> release it and it's not used elsewhere. Fix this by free the
> cpumap after the dumping.
>
> Fixes: c853f9394b7b ("perf tools: Add perf_event__fprintf_event_update function")
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/header.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e86b9439ffee..7190f39ccd13 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4369,9 +4369,10 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
>                 ret += fprintf(fp, "... ");
>
>                 map = cpu_map__new_data(&ev->cpus.cpus);
> -               if (map)
> +               if (map) {
>                         ret += cpu_map__fprintf(map, fp);
> -               else
> +                       perf_cpu_map__put(map);
> +               } else
>                         ret += fprintf(fp, "failed to get cpus\n");
>                 break;
>         default:
> --
> 2.24.0
>
>
