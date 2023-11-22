Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69167F5209
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjKVVFl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 16:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:05:39 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6998
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:05:35 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso221098b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687135; x=1701291935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV2f2BqWkrSB7nwLoOeLKdwbe6EE3dlzzcRDVp/tu6I=;
        b=Nys+EPQMqKJ3+07RaRyo8eRo4Qop7GGhSNA0xLwGI4Cb9wikASRnchB+4okkyJKIDV
         tWUwnxU4Yp2+nMbhMUSucQrF0vzKmJIjMzuXaHNJaQ6HM1B5QgB9VVw1ZWZTWKDFaqFt
         BY3Ver3wamkeBckNJvVfug99EW0P2/3OQmzOAE+ovgpzLqDt2lD84cDrssRIpicUxFiT
         9aNATcyqoV1/5pRcLqL0DxZthklJXECqdqQGQNBzwY/GkNNKOUrTi0rERjEXIVLEVi9W
         10RAIgfcmg0rdAa4C7CaQQ24lIzOZ4O+x4lk9PUUn5mPNWSXdCUnmAFCc18pJv5oyCPJ
         eHFQ==
X-Gm-Message-State: AOJu0Yxj9Pz7RCIygsTJF2Ph8a5DIkpwTEq8/7N25lIXJb8xwhUqnj0z
        pXMN5KFrJxPLDdVqJ77ZeVFs8yd9NmLs1aw4P7c=
X-Google-Smtp-Source: AGHT+IFsxXjlsTR8neJh0lpYk/pH87F6rcV1lKTPQHhEm7yfh63RSV6tst+ZEg8BWr8kKbkicJTz0FmFGJhEvtW8ZrU=
X-Received: by 2002:a05:6a21:191:b0:18b:3d8f:1495 with SMTP id
 le17-20020a056a21019100b0018b3d8f1495mr3994511pzb.33.1700687135149; Wed, 22
 Nov 2023 13:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
In-Reply-To: <20231122022154.12772-1-CruzZhao@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 13:05:24 -0800
Message-ID: <CAM9d7chVZRKUSmXmZS4OyokKfLKp4h8K8RLWehYRpAs5Z4jsbg@mail.gmail.com>
Subject: Re: [PATCH] perf: ignore exited thread when synthesize thread map
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 21, 2023 at 6:22 PM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>
> When synthesize thread map, some threads in thread map may have
> already exited, so that __event__synthesize_thread() returns -1
> and the synthesis breaks. However, It will not have any effect
> if we just ignore the exited thread. So just ignore it and continue.

Looks ok.  But I guess you want to do the same for the leader
thread below as well.

Thanks,
Namhyung

>
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---
>  tools/perf/util/synthetic-events.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index a0579c7d7b9e..43ad2298a933 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -866,14 +866,16 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
>
>         err = 0;
>         for (thread = 0; thread < threads->nr; ++thread) {
> +               /*
> +                * We may race with exiting thread, so don't stop just because
> +                * one thread couldn't be synthesized.
> +                */
>                 if (__event__synthesize_thread(comm_event, mmap_event,
>                                                fork_event, namespaces_event,
>                                                perf_thread_map__pid(threads, thread), 0,
>                                                process, tool, machine,
> -                                              needs_mmap, mmap_data)) {
> -                       err = -1;
> -                       break;
> -               }
> +                                              needs_mmap, mmap_data))
> +                       continue;
>
>                 /*
>                  * comm.pid is set to thread group id by
> --
> 2.39.3
>
