Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC580F544
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377162AbjLLSK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjLLSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:10:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51353A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:10:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50d11bd3144so242e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404648; x=1703009448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7WErAa1svouJ5RTcfagEeGuPrLYcmmXJIIkL6H2OPU=;
        b=V1WQxxcuz17BnLaK4YJEOjJtw9DQ/Ivzswz5cBSt6e7iOjUvDsuWq/DFOYpyWV8SFd
         TzvTRzGieUzWCPjRIZum9Z8zNaD8MrfLMTOQ+RoiqLCFN2BtJElqcV6qWCwnZSGeNM9B
         l4/NSMAZQtIfzST4//xDq8fR4EKcGcXSrq5LWEUOM/wA9g58nERZKChz0ERK/YpGNY46
         920j9YpQ7GGADgpDC58b0Rzq2EiE/IQk3wkbYkShKafgj5HvuNixWHbT3jU5Ge4C2gga
         1Eyrg6ZpHMRE5lui5wIsXFifXmcB+5HK7Burz0TpmlCQ3Vtgw3jrGAFxCkPEsXbFBZnE
         MHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404648; x=1703009448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7WErAa1svouJ5RTcfagEeGuPrLYcmmXJIIkL6H2OPU=;
        b=YoeElVW9PadJkuudJMuEmhAqvG55aEdylxtsHkTMk2QVAo1PQjW9KBOo+YQXlEwRNG
         XM65F+LorSYo4fMdkbHEXzdu40yOxdbr/UtGV1NC2WyDtDORScRoX6+1ZqGsnrZXvxIw
         hsd7yEydU14STDc44zYFo22SyGNqA17ZYuo1jZOTDMHM1wwZp+MyXXtUqqoEikAbRc1A
         qUuJOkVFWCfQPXZDhuUF9HlYOXbRXbAXhSBOaUMvQWrV2b1afqj01/183sumAb/CdZ78
         OpLiPrfQ6V6FziPB4Z36hwMIB4KqF7xiYxS1lv4udBaQn1NdBlGNJGcbU5XsT8lxi65t
         tRaQ==
X-Gm-Message-State: AOJu0YxEDZnn9bvbhlzkCDa7W/yd2QQmk9EK592xtiTfXUd+AfFWV5Ah
        FD+BRCBgkQajzo+Pmkvr1nFEOIUhe3D7WyJ495e0lQ==
X-Google-Smtp-Source: AGHT+IHzkQIK4cpQrOTv6o/7Dyk15G788Co/V3rqIA3FMQmcUowvHpCwakRVH5BeQ+agq+GfZTS6yVmJFBoT5Ci01fM=
X-Received: by 2002:a19:5e41:0:b0:50a:519d:5a8a with SMTP id
 z1-20020a195e41000000b0050a519d5a8amr278722lfi.5.1702404648263; Tue, 12 Dec
 2023 10:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org>
In-Reply-To: <20231212070547.612536-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 10:10:37 -0800
Message-ID: <CAP-5=fV5sA1ga5UfvHW_=Ep25b-TzsLJ8Atqk3KePKOx-fk9TQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf tools: Random fixes for DWARF unwind
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Pablo Galindo <pablogsal@gmail.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> I've found a couple of issues on the unwind code while I'm playing with
> the JIT-dump code for the CPython.  The code assumes normal DSOs mapped
> from the beginning of the file and aligned to the page size.  But it's
> not true for the JIT-dumped DSOs which are generated for each function.

We have a JIT test in:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/shell/test_java_symbol.sh?h=3Dperf-tools-next

It'd be great if we could do similar for CPython.

Thanks,
Ian



> Depending on the JIT implementation, the code address and accompanied
> ELF info (like ELF file headers and unwind info) can be overlapped to
> adjacent (JIT-dumped) DSOs.  So it should take more care when it
> calculates the mapping address for the DSO.
>
> It seems these changes need to go to the stable trees but they are
> changed a lot since then so I'm not sure.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (3):
>   perf genelf: Set ELF program header addresses properly
>   perf unwind-libdw: Handle JIT-generated DSOs properly
>   perf unwind-libunwind: Fix base address for .eh_frame
>
>  tools/perf/util/genelf.c                 |  6 +++---
>  tools/perf/util/unwind-libdw.c           | 21 +++++++++++++++++----
>  tools/perf/util/unwind-libunwind-local.c |  2 +-
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> --
> 2.43.0.472.g3155946c3a-goog
>
