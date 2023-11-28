Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94E57FC413
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjK1TOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjK1TOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:14:06 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEC61707
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:14:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so9185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701198851; x=1701803651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sQJEQO1lAXLUO7lOurIsnWNVY/yZ4K1PFUY114AiIg=;
        b=UTiD8QGp5Xp1eKjwifmVLLr7sxUtHpUEziO2Noc8x1Sa37ahGCzd70cf9mCLlsriYR
         HZD+A+nLCdmaZgOAt1LFCEdH0a3v4V5/yO8F5ej7JhiIyw4AJS+wSsRA1Eyw7RoNmHbS
         kEprG0pVuaaVo2AYOfUQIfypUCGP+UKZoRh2lSKEO06R8raWtHeTgJvRQCCmC9b+p6T3
         5id3cBOWTHJDTewr1W4SgT2jaTr6kna3vAlN3wTGnrJqg2ootaVfB373R/jCYusW81go
         3ib+Dg2t2i5xOP546YGZTw9JSZrLDP9pCGbzhpZDIACDYc9IVXsiZyG/jjKB0ZMFjimt
         nG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198851; x=1701803651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sQJEQO1lAXLUO7lOurIsnWNVY/yZ4K1PFUY114AiIg=;
        b=hfWfVaHY8zPfMdqFAiIo7hAHRC0qryPGqKRQZnpNfZiEoqmYqCbAmHJTommXNXcpTL
         FQsMGViPstQTfZVkgTBWiXIwe4Oobm3ugHt+lJCwFOTIisOJjs2Y54hZXb/fOTjbxcVN
         pkeppK4Rlx7HFswYOlaRamP46X8MMlZUJIvBueEDY0tHTXUMeUV+o34FQ4R17hONEpai
         SGakjy4pbm1rc9bjQoG7p0eWB3YnuqmvwVCvqnnrJosHW2LjzwSkIyDPFN1OkeFsniBm
         RmsKj1wSqyQBSLMOszQKTmlET+10K7pDyk+nI4oyNfPGCSJnwOf49RCZ/EOd/Dyh09Hj
         LUmQ==
X-Gm-Message-State: AOJu0Yz7UNb2l8YKeczefRTPuaAiyJLZnKggo9iIviGclAK9KCA6pl6U
        NWGz5AqDMmowMxy4FcE73/O6VSaKa1FRoin3SMD2mA==
X-Google-Smtp-Source: AGHT+IEuzdV2LP9iggW4NsbrWUCJTF1PKKYjnA9pmxZjCHha1l8TTtDbQbnJcZcnV6cuVeQyFQfWgediT0WIcK14cYo=
X-Received: by 2002:a05:600c:4f44:b0:408:3727:92c5 with SMTP id
 m4-20020a05600c4f4400b00408372792c5mr852331wmq.2.1701198850618; Tue, 28 Nov
 2023 11:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org>
In-Reply-To: <20231128175441.721579-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Nov 2023 11:13:55 -0800
Message-ID: <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> It used to have annotation_options for each command separately (for
> example, perf report, annotate, and top), but we can make it global as
> they never used together (with different settings).  This would save
> some memory for each symbol when annotation is enabled.
>
> This code is available at 'perf/annotate-option-v1' branch in
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung

Thanks for doing this and I think it is progress. I think there is a
common problem with having things be an option rather than say part of
session. Having a global variable seems unfortunate but I'm not sure
if in all locations we have easy access to the session. The rough
structure with annotations as I understand it is:

session has machines
a machine has dsos
a dso has symbols
a symbol has an annotation

Annotation is something of unfortunate abstraction as it covers things
like an IPC per symbol (why hard code to just IPC?) and things like
source files and line numbers.

A recent success story where we got rid of a configuration variable
was by switching to lazy allocation with sorting by name for symbols
within a dso. If we could have a lazy allocation model with
annotations then maybe we can do away with large hammers like global
options.

Thanks,
Ian




> Namhyung Kim (8):
>   perf annotate: Introduce global annotation_options
>   perf report: Convert to the global annotation_options
>   perf top: Convert to the global annotation_options
>   perf annotate: Use global annotation_options
>   perf ui/browser/annotate: Use global annotation_options
>   perf annotate: Ensure init/exit for global options
>   perf annotate: Remove remaining usages of local annotation options
>   perf annotate: Get rid of local annotation options
>
>  tools/perf/builtin-annotate.c     |  43 +++++----
>  tools/perf/builtin-report.c       |  37 ++++----
>  tools/perf/builtin-top.c          |  45 +++++-----
>  tools/perf/ui/browsers/annotate.c |  85 ++++++++----------
>  tools/perf/ui/browsers/hists.c    |  34 +++----
>  tools/perf/ui/browsers/hists.h    |   2 -
>  tools/perf/util/annotate.c        | 142 +++++++++++++++---------------
>  tools/perf/util/annotate.h        |  38 ++++----
>  tools/perf/util/block-info.c      |   6 +-
>  tools/perf/util/block-info.h      |   3 +-
>  tools/perf/util/hist.h            |  25 ++----
>  tools/perf/util/top.h             |   1 -
>  12 files changed, 206 insertions(+), 255 deletions(-)
>
>
> base-commit: 757489991f7c08603395b85037a981c31719c92c
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
