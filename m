Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484867E8977
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjKKGMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Nov 2023 01:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKKGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:12:14 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D173D55;
        Fri, 10 Nov 2023 22:12:11 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6d30d9f4549so1578452a34.0;
        Fri, 10 Nov 2023 22:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699683130; x=1700287930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F18ZfBJDbteJpzF3orYa0y+zwvcNIr/l7qVlsuvq6RY=;
        b=ciiKjWfOv5Br0/3YOAwqbIVtu9Ey/BNj8fhQDhDwD8HarF1V1uEyQVl9iyyfwS3gx4
         J0D1QNK55QdK74fsy7rO0fgUDKehKuCBfGZpfj64KzJglrWEdmIE5qEq/kVxfsgikRRm
         8p/4ET94b/sBTRu6Ef8Mm8nu4Ytk/k2xDp7sVqemPe+eDIoIgZET+SngIMtz5HdPieK+
         CapXcLhmp6YVtDV4bXKq4tW/36atVdNVvKUX43x8G7BtA7ALcl0cWb8PbZvmHS5Qx4ap
         TdzO/puD+ZDsHzQYrW0FU7QAk4rGHmTch5Y2WDMVSGNtrRkDif0adY1QX42KFcrAFbfs
         0O+g==
X-Gm-Message-State: AOJu0Ywd7ChJ8WoK3ZmcTccALk/+k02jZ7pD+j+yxDo1k7H3pfSYZwoy
        38baNBLYf3sw9cboMSKOnac7eDrtKjVgL8YvbMA=
X-Google-Smtp-Source: AGHT+IGm/ncW6tg2O+/GY8fy3Ui1xaM/XhX0zayiBwqhafMsRJUlmlrCiiMLnmQ4fMHM1pr2yytjj7ZAgno+DypQkLY=
X-Received: by 2002:a05:6870:7d08:b0:1f4:a992:a15f with SMTP id
 os8-20020a0568707d0800b001f4a992a15fmr1994226oab.43.1699683130507; Fri, 10
 Nov 2023 22:12:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <6456d4d523841fb97b639433731540b8783529a1.1699487758.git.jpoimboe@kernel.org>
In-Reply-To: <6456d4d523841fb97b639433731540b8783529a1.1699487758.git.jpoimboe@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Nov 2023 22:11:59 -0800
Message-ID: <CAM9d7chW3nL6zTzcPxBL-RQHyKPTuxR=hbrkexDBAPo4hNw=mw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/10] perf: Simplify get_perf_callchain() user logic
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
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

On Wed, Nov 8, 2023 at 4:44 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
> should never be NULL.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  kernel/events/callchain.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index aa5f9d11c28d..2bee8b6fda0e 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -202,20 +202,18 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>
>         if (user) {
>                 if (!user_mode(regs)) {
> -                       if  (current->mm)
> -                               regs = task_pt_regs(current);
> -                       else
> -                               regs = NULL;
> +                       if (!current->mm)
> +                               goto exit_put;
> +                       regs = task_pt_regs(current);
>                 }
>
> -               if (regs) {
> -                       if (add_mark)
> -                               perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> +               if (add_mark)
> +                       perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
>
> -                       perf_callchain_user(&ctx, regs);
> -               }
> +               perf_callchain_user(&ctx, regs);
>         }
>
> +exit_put:
>         put_callchain_entry(rctx);
>
>         return entry;
> --
> 2.41.0
>
