Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11717A33D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 07:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjIQF04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 17 Sep 2023 01:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjIQF0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 01:26:14 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B811A1;
        Sat, 16 Sep 2023 22:26:08 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77acb04309dso120844339f.2;
        Sat, 16 Sep 2023 22:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694928367; x=1695533167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8OMLePdBQiCZVj6JV7z+xTlIDlELNPKMdSpZjXipN8=;
        b=k70YohqaB9R2wq+1hF6/0/+ZtCU7clWB34z55P9JzZ6IxuLLttEcN1uQ/njOoIZ2zQ
         mw1rrZTcUu16tv9qUSXBdyPSapHn0sH/NXDJXlM/0Qf8/3QSRBvIxOAkTHTI1eqP2k9B
         gbBEXrVi706olGKWBR7xTy4tFhK8/gQM3ehsrmL0xZFg8Ur1SBw/WMbBInNpEv6Nhx0j
         MaC/DF8wmfBNlupoXgpmJWtoEUMNJGNxIiLuI6UrbwFkHjVfLQpFoojmDURsIQ+qIirv
         vhN1JJor5gIdGdR3p3EODt++sO59GvUZTk2Yzqpez5HqWhHAfG5iJv+A3AiripwGBdjG
         8aYQ==
X-Gm-Message-State: AOJu0YzTtX74blnVt7GE4hW7teta9UcwyJ9WHuvc+cYmzFf/VQLoc9Ys
        jkH0SoinqvUawXp995GnpfgYwyM58VBSxcdvnfM=
X-Google-Smtp-Source: AGHT+IE2dPUBZ4V875an1HcA/LtfQ+rfbROd2YPDaB6eCG4vmPZ/u1QkZNCgNdjTSWxCDyBeVqOs/xYuUdoA0BMZ/qg=
X-Received: by 2002:a6b:510a:0:b0:794:eddf:daad with SMTP id
 f10-20020a6b510a000000b00794eddfdaadmr6953575iob.15.1694928367552; Sat, 16
 Sep 2023 22:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230913184957.230076-1-irogers@google.com>
In-Reply-To: <20230913184957.230076-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 16 Sep 2023 22:25:55 -0700
Message-ID: <CAM9d7cg7oETR=ecaqrag13abpOmBKOextAEw=kRA_gZqVMGGDg@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Avoid compile error wrt redefining bool
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:50 AM Ian Rogers <irogers@google.com> wrote:
>
> Make part of an existing TODO conditional to avoid the following build
> error:
> ```
> tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:14: error: cannot combine with previous 'char' declaration specifier
>    26 | typedef char bool;
>       |              ^
> include/stdbool.h:20:14: note: expanded from macro 'bool'
>    20 | #define bool _Bool
>       |              ^
> tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:1: error: typedef requires a name [-Werror,-Wmissing-declarations]
>    26 | typedef char bool;
>       | ^~~~~~~~~~~~~~~~~
> 2 errors generated.
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools, thanks!

Namhyung
