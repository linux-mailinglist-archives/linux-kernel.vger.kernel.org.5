Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAE80117E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378538AbjLAQlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378536AbjLAQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:41:46 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC5197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:41:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so13554a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701448911; x=1702053711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wJ6qDwmyRvhNqpylX9f8LuOmYLWmceoEf5k8FTfkzPU=;
        b=znacTWRINH7bjtkr56UNC1pMzBG1MLZZtyC3HCMP9cD00i5ttvvAjA8JXDV9KPTBrR
         5qa/JAljXjWikCWHzhvSQ04Sjw5xpx9NNC5ghPD9YxPG9QeQmWFXY0Vh7+USxBu7jQvX
         NS4cp9Vau1PE4dKvSOv1f0Xm+RpBWpJ5V2w3xQVKo3X35Mq5bA7J3KNF1RLZWA0s4lqD
         05niG2hrDQFHeLj1T5bbQAFIWNTxN4xP3dbfe6A6scvIUXE0VsBIX02ntC+OHA46EAbu
         ZBeHwB+QSie0WqcXfuX3BxkbjLSyTpevAILf4mWH/HZnnVbHUy3sk4qW5gCUZYckEAn+
         eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448911; x=1702053711;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ6qDwmyRvhNqpylX9f8LuOmYLWmceoEf5k8FTfkzPU=;
        b=gOkTj/OJn6/flkQ5f8o1OM3+jifry+G93vefWQk2fpPVZNyd99PCK/S2/q2YWFDCxg
         H4w6xlWPRl7lNmprmaQ3S9tDEvvEbz0sYURJc02+OjRUkU1f9Hd4GnL/ClkXVe9RRuTY
         wvPK9tLCuVoFdoMSfepRSBEBnccqBzZ2RmtVZAR9vdJeISQw1Be7ZYCMJLiG/jrUhg1q
         PWMReZT89t0XqnPOdNmJyYTg+zATMQn2i1jD+zlSLQdRCbbyDyRxJHRgX7SysfjkhvkN
         dNMxTGZf7Sehwe8JeYMq5gSO3gCGJ4DIriVDh57PGcZUg0XlF/M4WZEsw0p6uAlXh4OB
         +qWA==
X-Gm-Message-State: AOJu0Yx8Ncc6354C8G54YhUDYCksYrqAc9seolckLu3rNo49uLhN3Xgy
        WUmuqEVC1vnLrb9q/NlysNXukRt0X3MBdUTRA8I3fg==
X-Google-Smtp-Source: AGHT+IEBCEUy8WWjrEzQFzI0bb+4iHE3xDO/M7JSFQnRwhSwXTDZWgI6uFpXx2LfPxgJyDBAytWfBT1XfxCuFPcOOzo=
X-Received: by 2002:a50:aade:0:b0:54a:ee8b:7a8c with SMTP id
 r30-20020a50aade000000b0054aee8b7a8cmr168518edc.0.1701448911052; Fri, 01 Dec
 2023 08:41:51 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 17:41:13 +0100
Message-ID: <CAG48ez3xSoYb+45f1RLtktROJrpiDQ1otNvdR+YLQf7m+Krj5Q@mail.gmail.com>
Subject: io_uring: incorrect assumption about mutex behavior on unlock?
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring <io-uring@vger.kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex_unlock() has a different API contract compared to spin_unlock().
spin_unlock() can be used to release ownership of an object, so that
as soon as the spinlock is unlocked, another task is allowed to free
the object containing the spinlock.
mutex_unlock() does not support this kind of usage: The caller of
mutex_unlock() must ensure that the mutex stays alive until
mutex_unlock() has returned.
(See the thread
<https://lore.kernel.org/all/20231130204817.2031407-1-jannh@google.com/>
which discusses adding documentation about this.)
(POSIX userspace mutexes are different from kernel mutexes, in
userspace this pattern is allowed.)

io_ring_exit_work() has a comment that seems to assume that the
uring_lock (which is a mutex) can be used as if the spinlock-style API
contract applied:

    /*
    * Some may use context even when all refs and requests have been put,
    * and they are free to do so while still holding uring_lock or
    * completion_lock, see io_req_task_submit(). Apart from other work,
    * this lock/unlock section also waits them to finish.
    */
    mutex_lock(&ctx->uring_lock);

I couldn't find any way in which io_req_task_submit() actually still
relies on this. I think io_fallback_req_func() now relies on it,
though I'm not sure whether that's intentional. ctx->fallback_work is
flushed in io_ring_ctx_wait_and_kill(), but I think it can probably be
restarted later on via:

io_ring_exit_work -> io_move_task_work_from_local ->
io_req_normal_work_add -> io_fallback_tw(sync=false) ->
schedule_delayed_work

I think it is probably guaranteed that ctx->refs is non-zero when we
enter io_fallback_req_func, since I think we can't enter
io_fallback_req_func with an empty ctx->fallback_llist, and the
requests queued up on ctx->fallback_llist have to hold refcounted
references to the ctx. But by the time we reach the mutex_unlock(), I
think we're not guaranteed to hold any references on the ctx anymore,
and so the ctx could theoretically be freed in the middle of the
mutex_unlock() call?

I think that to make this code properly correct, it might be necessary
to either add another flush_delayed_work() call after ctx->refs has
dropped to zero and we know that the fallback work can't be restarted
anymore, or create an extra ctx->refs reference that is dropped in
io_fallback_req_func() after the mutex_unlock(). (Though I guess it's
probably unlikely that this goes wrong in practice.)
