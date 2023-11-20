Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707E7F1DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjKTU2j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 15:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjKTU2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:28:37 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8EBC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:28:34 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso3769229a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512114; x=1701116914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAUXEY25pcgFJPPMr5X8QK/ZolpU8TE7YcrDkatwu6s=;
        b=ddnkell22j4pP+rUYQdOtfYfqL+PoL0JNaEVF9dOLZ9hEITuiD98hNVE56m8AHDxCP
         dP3awVlE6aBuSoG4Bsfz8KMEfFSI5QtzjVmXM7PM+S3lhdZmNdWHjyJyefNhePDfXpQn
         x2L9JUiu7HD1R53rTghW+1BPygsnh7dj3ToJIP5ZJDNU6TkEDsjdZM2ZScwgul6Zl1eg
         o/DLadjNZlmT78Aph1e/KSQQS/9kATZgs4hiiMRuetGO8SFPIdsyGLH5rsnCQZamW+PO
         qRvzyKyg4F6HIApQyfHQcerbVfcQsSox91y++qSx7UFKHd0v4OM46ONIlE63qOquUsXq
         HVfQ==
X-Gm-Message-State: AOJu0YxHduEYJNC3izVUegTLdzMiUUzvRE/HWFWX5NeElsgPbCAoPb+T
        reYQjXuMw4buoosCpCBw8ET9epLxO1vJrDWChsM=
X-Google-Smtp-Source: AGHT+IFjJaIdl7rl7XrC7OqYukh73/zgvAGS1DpoMNPVOIdITESLNeauhhDe8BD3rBYF0zpa1RFk+vt2buB1GdNQsss=
X-Received: by 2002:a17:90b:4b8d:b0:27d:3f0c:f087 with SMTP id
 lr13-20020a17090b4b8d00b0027d3f0cf087mr8832482pjb.25.1700512113834; Mon, 20
 Nov 2023 12:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20231108215322.2845536-1-namhyung@kernel.org>
In-Reply-To: <20231108215322.2845536-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Nov 2023 12:28:22 -0800
Message-ID: <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
Subject: Re: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints only
 if contended
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Ping!

On Wed, Nov 8, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It mistakenly fires lock contention tracepoints always in the writer path.
> It should be conditional on the try lock result.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/locking/percpu-rwsem.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 185bd1c906b0..6083883c4fe0 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
>
>  void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>  {
> +       bool contended = false;
> +
>         might_sleep();
>         rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
> -       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
>
>         /* Notify readers to take the slow path. */
>         rcu_sync_enter(&sem->rss);
> @@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>          * Try set sem->block; this provides writer-writer exclusion.
>          * Having sem->block set makes new readers block.
>          */
> -       if (!__percpu_down_write_trylock(sem))
> +       if (!__percpu_down_write_trylock(sem)) {
> +               trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
>                 percpu_rwsem_wait(sem, /* .reader = */ false);
> +               contended = true;
> +       }
>
>         /* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
>
> @@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>
>         /* Wait for all active readers to complete. */
>         rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
> -       trace_contention_end(sem, 0);
> +       if (contended)
> +               trace_contention_end(sem, 0);
>  }
>  EXPORT_SYMBOL_GPL(percpu_down_write);
>
> --
> 2.42.0.869.gea05f2083d-goog
>
