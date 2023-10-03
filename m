Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E517B5FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjJCEQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjJCEQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:16:23 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4157EA1;
        Mon,  2 Oct 2023 21:16:21 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso329654a91.0;
        Mon, 02 Oct 2023 21:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306581; x=1696911381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roNIt2Fvqox3p9gNk4uqUQWHOaR3aQGBkVYARrazd/o=;
        b=l1ghURz5BBytBe69uzqLREOfW7l/+Nd4Eak14ICKbt/1OSouEdacCGhUdUF+R4V8w9
         vl4eClbd5HiXdcKpeA1+uy9QMAicLgmgO4xOg2Hv7wh/fCpQ03ACHVNNbux9gM33fC3l
         y1OJcc87dJm8wh5m2uRq5aaw4qPW6KjU6UB4f04IPzV8Q5Bg9KL5MXPW+5PULu/Ax2Fr
         AlC/TZtZ7EkZowskGNJAt1oUq70SiVSkfYJ1YNx+EQCmWbou1j+jVROXTGiJUS4I+3JQ
         SH3lrgjV6J4vaBqG2HaYdPGF5gZQJL++WjdDC/pITABIpbagZUOiHpgPhPimbxa1SFsi
         Zpfg==
X-Gm-Message-State: AOJu0Yx1/HQB+8IoL11c7xYF90WQ9fBDO6OCWAIny10Gmww/6icbKMkp
        29HOUnOVQ2n667BE/5jklOQ8mIc53OHhPJGcXi8=
X-Google-Smtp-Source: AGHT+IFZS7x/FhnJZ79uhKVgJHrxjrpHUXDyShy2EH8n3EXXp13HvEl6knpBA+1QtSGReY75u0+/5ztV3phzF+HL8zQ=
X-Received: by 2002:a17:90a:53a5:b0:276:757d:8c89 with SMTP id
 y34-20020a17090a53a500b00276757d8c89mr10859669pjh.44.1696306580571; Mon, 02
 Oct 2023 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131047.15176-1-april@acab.dev>
In-Reply-To: <20231001131047.15176-1-april@acab.dev>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:16:08 -0700
Message-ID: <CAM9d7cgB6GfJSQhWJwmi=FodKwsYdVy_FnRJ+jzt1DpmO-J3cg@mail.gmail.com>
Subject: Re: [PATCH] /bin/dmesg to dmesg Path
To:     April John <april@acab.dev>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
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

Hello,

On Sun, Oct 1, 2023 at 6:10 AM April John <april@acab.dev> wrote:
>
> Dmesg is not in every distro at /bin/dmesg, in NixOS for example, this fails,
> but the path should in most cases contain dmesg.
> This follows the example of replacing /bin/bash with bash Path in the codebase.
>
> ---
> tools/perf/util/evsel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a8a5ff87c..aa602aae6 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3053,7 +3053,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>
> return scnprintf(msg, size,
> "The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
> - "/bin/dmesg | grep -i perf may provide additional information.\n",
> + "dmesg | grep -i perf may provide additional information.\n",
> err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
> }
>
> --
> 2.42.0
>
> Signed-off-by: April John <april@acab.dev>

It is usual to put a tag after the patch, it should be at the end of the
commit message.  With that,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
